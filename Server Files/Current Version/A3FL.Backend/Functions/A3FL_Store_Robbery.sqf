/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Store_Robbery_RobStore",
{
	private _store = param [0,objNull];
	private _isStation = param [1,false];
	private _faction = "fisd";
	private _weapon = currentWeapon player;
	private _success = true;
	private _timeElapsed = 0;
	private _robbedTime = missionNamespace getVariable ["StoreCooldown",serverTime-300];
	private _duration = switch(_weapon) do {
		case "arifle_AKM_F": {70};
		case "A3PL_M16": {80};
		case "A3FL_M4": {80};
		case "A3FL_Mossberg_590K": {90};
		case "SMG_05_F": {100};
		case "SMG_02_F": {100};
		case "SMG_01_F": {100};
		default {140};
	};

	if(_robbedTime > (serverTime-300)) exitWith {["Another store robbery has taken place recently, you cannot rob this store!","red"] call A3PL_Player_Notification;};
	if (_weapon isEqualTo "") exitwith {["You are not brandishing a firearm","red"] call A3PL_Player_Notification;};
	if (_weapon IN ["A3FL_GolfDriver","A3FL_BaseballBat","Rangefinder","hgun_Pistol_Signal_F","A3PL_FireAxe","A3PL_Shovel","A3PL_Pickaxe","A3PL_Golf_Club","A3PL_Jaws","A3PL_High_Pressure","A3PL_Medium_Pressure","A3PL_Low_Pressure","A3PL_Taser","A3PL_FireExtinguisher","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","A3PL_Predator"]) exitwith {["You cannot rob a store with this weapon!","red"] call A3PL_Player_Notification;};

	if(_store IN [npc_fuel_11,npc_fuel_12,Robbable_Shop_5]) then {
		_faction="uscg";
	} else {
		_faction="fisd";
	};

	_cops = [_faction] call A3PL_Lib_FactionPlayers;
	if((count(_cops)) < 3) exitWith {[format ["There needs to be a minimum of %1 %2 online to rob this store!",3,_faction],"red"] call A3PL_Player_Notification;};

	["If you try to turn this store, stay near the cash!", "green"] call A3PL_Player_Notification;
	playSound3D ["A3PL_Common\effects\burglaralarm.ogg", _store, false, getPosASL _store, 1, 1, 200];
	[_store] remoteExec ["A3PL_Store_Robbery_Alert", _cops];

	if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
	["Robbing the store...",_duration] spawn A3PL_Lib_LoadAction;
	waitUntil{Player_ActionDoing};
	while {Player_ActionDoing} do {
		if ((player distance2D _store) > 10) exitWith {["You went away from the shop, the robbery failed!", "red"] call A3PL_Player_Notification; _success = false;};
		if (!(vehicle player isEqualTo player)) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
		if ((currentWeapon player) isEqualTo "") exitWith {_success = false;Player_ActionInterrupted=true;};
		_timeElapsed = _timeElapsed + 0.5;
		if (_timeElapsed isEqualTo 28) then {playSound3D ["A3PL_Common\effects\burglaralarm.ogg", _store, false, getPosASL _store, 1, 1, 200];};
	};
	if(Player_ActionInterrupted || !_success) exitWith {["The store robbery was cancelled!", "red"] call A3PL_Player_Notification;};

	["Successful robbery!", "green"] call A3PL_Player_Notification;
	[_isStation,_store] call A3PL_Store_Robbery_Reward;
	[getPlayerUID player,"storeRobberrySuccess",[]] remoteExec ["Server_Log_New",2];
	missionNamespace setVariable ["StoreCooldown",serverTime,true];
}] call Server_Setup_Compile;

["A3PL_Store_Robbery_Reward",
{
	private _isStation = param [0,false];
	private _station = param [1,objNull];
	private _cops = count(["fisd"] call A3PL_Lib_FactionPlayers);
	if(_isStation) then {
		if(_cops < 5) then
		{
			_reward = 5000 + (round (random 6000)) * A3PL_Event_CrimePayout;
			[format ["You earned $%1",str(_reward)], "green"] call A3PL_Player_Notification;
			player setVariable ["player_cash",((player getVariable ["player_cash",0]) + _reward),true];
			[player, 30] call A3PL_Level_AddXP;
		};
		if(_cops >= 5) then
		{
			_reward = 10000 + (round (random 5000)) * A3PL_Event_CrimePayout;
			[format ["You earned $%1",str(_reward)], "green"] call A3PL_Player_Notification;
			player setVariable ["player_cash",((player getVariable ["player_cash",0]) + _reward),true];
			[player, 45] call A3PL_Level_AddXP;
		};
	} else {
		if(_cops < 5) then
		{
			_reward = 5000 + (round (random 6000)) * A3PL_Event_CrimePayout;
			[format ["You earned $%1",str(_reward)], "green"] call A3PL_Player_Notification;
			player setVariable ["player_cash",((player getVariable ["player_cash",0]) + _reward),true];
			[player, 30] call A3PL_Level_AddXP;
		};
		if(_cops >= 5) then
		{
			_reward = 10000 + (round (random 5000)) * A3PL_Event_CrimePayout;
			[format ["You earned $%1",str(_reward)], "green"] call A3PL_Player_Notification;
			player setVariable ["player_cash",((player getVariable ["player_cash",0]) + _reward),true];
			[player, 45] call A3PL_Level_AddXP;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Store_Robbery_Alert",
{
	private _store = param [0,objNull];
	private _storePos = getPos _store;
	private _namePos = [_storePos] call A3PL_Housing_PosAddress;
	[format ["A store alarm at %1 has been triggered",_namePos],"blue"] call A3PL_Player_Notification;
	[_store] spawn A3PL_Store_Robbery_Marker;
}] call Server_Setup_Compile;

["A3PL_Store_Robbery_Marker",
{
	private _store = param [0,objNull];
	private _marker = createMarkerLocal [format["store_robbery_%1",floor (random 5000)],_store];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerColorLocal "ColorWhite";
	_marker setMarkerTypeLocal "mil_warning";
	_marker setMarkerTextLocal format ["Alarm Triggered!"];
	sleep 180;
	deleteMarkerLocal _marker;
}] call Server_Setup_Compile;