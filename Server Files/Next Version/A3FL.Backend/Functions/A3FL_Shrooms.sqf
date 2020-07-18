/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Shrooms_Pick",
{
	private ["_chance","_success","_shroom"];
	_shroom = param [0,objNull];

	if(_shroom getVariable["inUse",false]) exitWith {[localize"STR_NewRessources_AlrPicking","red"] call A3PL_Player_Notification;};
	_shroom setVariable["inUse",true,true];

	_playerLevel = player getVariable["Player_Level",0];
	if (_playerLevel < 7) exitWith {[localize"STR_Inter_Notifications_Level7Required","red"] call A3PL_Player_Notification;};

	if (!Player_ActionCompleted) exitwith {[localize"STR_NewRessources_Action","red"] call A3PL_Player_Notification;};
	Player_ActionCompleted = false;
	["Gathering..",5] spawn A3PL_Lib_LoadAction;
	_success = true;
	waitUntil{Player_ActionDoing};
	_animTime = diag_tickTime;
	while {Player_ActionDoing} do {
		if(_animTime >= diag_tickTime-5) then {
			player playMoveNow 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
			_animTime = diag_tickTime;
		};
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if ((vehicle player) != player) exitWith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
	};
	if(Player_ActionInterrupted || !_success) exitWith {_shroom setVariable["inUse",false,true];};

	["shrooms",1] call A3PL_Inventory_Add;
	[format[localize"STR_NewRessources_ShromGathered",1],"green"] call A3PL_Player_Notification;
	[player,3] call A3PL_Level_AddXP;
	deleteVehicle _shroom;
}] call Server_Setup_Compile;
