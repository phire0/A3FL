/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['A3PL_USCG_Drag',
{
	private ['_civ',"_dragged"];
	_civ = _this select 0;
	_dragged = _civ getVariable ["dragged",false];
	if (_dragged) exitWith {_civ setVariable ["dragged",Nil,true];};
	_alreadyDrag = player getVariable["dragging", false];
	if(_alreadyDrag) exitWith {["You are already dragging someone", "red"] call A3PL_Player_Notification;};
	player setVariable["dragging", true];
	["You are dragging someone", "green"] call A3PL_Player_Notification;
	[player] remoteExec ["A3PL_USCG_DragReceive",_civ];
}] call Server_Setup_Compile;

['A3PL_USCG_DragReceive',
{
	private ["_dragState","_cop"];
	_cop = param [0,objNull];
	[localize"STR_NewUSCG_1", "red"] call A3PL_Player_Notification;
	player setVariable ["dragged",true,true];
	[_cop] spawn
	{
		private ["_var","_cop"];
		_cop = param [0,objNull];
		if (isNull _cop) exitwith {};
		while {(player getVariable ["dragged",false]) && (vehicle _cop isKindOf "Civilian_F") && (surfaceIsWater position player)} do
		{
			uiSleep 2;
			if (isNull _cop) exitwith {};
			if (((player distance _cop) > 3) && (vehicle _cop isKindOf "Civilian_F")) then {
				player setPosASL (getposASL _cop);
			};
		};
		_cop setVariable["dragging", false];
		[localize"STR_NewUSCG_2", "red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;