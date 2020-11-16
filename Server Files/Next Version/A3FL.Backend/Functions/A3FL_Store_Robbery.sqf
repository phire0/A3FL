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
	private _storeType = "Gas Station";
	private _faction = if(_store IN [npc_fuel_11,npc_fuel_12,Robbable_Shop_5,npc_tacohell_4,npc_mcfisher_4]) then {"uscg"} else {"fisd"};
	private _leos = [_faction] call A3PL_Lib_FactionPlayers;
	private _weapon = currentWeapon player;
	private _timeElapsed = 0;
	private _robbedTime = missionNamespace getVariable ["GasCooldown",serverTime-300];
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

	if (_store IN [npc_fuel_1,npc_fuel_3,npc_fuel_4,npc_fuel_6,npc_fuel_8,npc_fuel_9,npc_fuel_10,npc_fuel_11,npc_fuel_12]) then {
		_storeType = "Gas Station"; _robbedTime = missionNamespace getVariable ["GasCooldown",serverTime-300];};
	if (_store IN [npc_mcfisher,npc_mcfisher_1,npc_mcfisher_2,npc_mcfisher_3,npc_mcfisher_4]) then {
		_storeType = "McFishers"; _robbedTime = missionNamespace getVariable ["McFishersCooldown",serverTime-300];};
	if (_store IN [npc_tacohell_1,npc_tacohell_2,npc_tacohell_3,npc_tacohell_4]) then {
		_storeType = "Taco Hell"; _robbedTime = missionNamespace getVariable ["TacoHellCooldown",serverTime-300];};
	if (_store IN [Robbable_Shop_1,Robbable_Shop_2,Robbable_Shop_3,Robbable_Shop_4,Robbable_Shop_5,Robbable_Shop_6]) then {
		_storeType = "Robbable Store"; _robbedTime = missionNamespace getVariable ["StoreCooldown",serverTime-300];};

	if(_robbedTime > (serverTime-300)) exitWith {["Another store robbery has taken place recently, try again later!","red"] call A3PL_Player_Notification;};

	if (_weapon isEqualTo "") exitwith {["You are not brandishing a firearm","red"] call A3PL_Player_Notification;};

	if (_weapon IN ["A3FL_PepperSpray","A3FL_GolfDriver","A3FL_BaseballBat","Rangefinder","hgun_Pistol_Signal_F","A3PL_FireAxe","A3PL_Shovel","A3PL_Pickaxe","A3PL_Golf_Club","A3PL_Jaws","A3PL_High_Pressure","A3PL_Medium_Pressure","A3PL_Low_Pressure","A3PL_Taser","A3PL_FireExtinguisher","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","A3PL_Predator"]) exitwith {["This weapon cannot be used to rob a store!","red"] call A3PL_Player_Notification;};

	if((count(_leos)) < 2) exitWith {[format ["There needs to be a minimum of 2 %1 online to rob this store!",_faction],"red"] call A3PL_Player_Notification;};

	["Attempting to rob the store... Keep your gun on the cashier!", "green"] call A3PL_Player_Notification;
	playSound3D ["A3PL_Common\effects\burglaralarm.ogg", _store, false, getPosASL _store, 1, 1, 200];
	[_store,_faction] call A3PL_Store_Robbery_Alert;

	if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
	["Robbing the store...",_duration] spawn A3PL_Lib_LoadAction;
	waitUntil{Player_ActionDoing};
	while {Player_ActionDoing} do {
		if ((player distance2D _store) > 10) exitWith {["You went away from the shop, the robbery failed!", "red"] call A3PL_Player_Notification; Player_ActionInterrupted = true;};
		if (!(vehicle player isEqualTo player)) exitwith {Player_ActionInterrupted = true;};
		if (player getVariable ["Incapacitated",false]) exitwith {Player_ActionInterrupted = true;};
		if ((currentWeapon player) isEqualTo "") exitWith {Player_ActionInterrupted=true;};
		_timeElapsed = _timeElapsed + 0.5;
		if (_timeElapsed isEqualTo 28) then {playSound3D ["A3PL_Common\effects\burglaralarm.ogg", _store, false, getPosASL _store, 1, 1, 200];};
	};
	if(Player_ActionInterrupted) exitWith {["The store robbery was cancelled!", "red"] call A3PL_Player_Notification;};

	["Successful robbery!", "green"] call A3PL_Player_Notification;
	[_storeType,_faction] call A3PL_Store_Robbery_Reward;

	if (_storeType isEqualTo "Gas Station") then {
		[getPlayerUID player,"gasStationRobberrySuccess",[]] remoteExec ["Server_Log_New",2];
		missionNamespace setVariable ["GasCooldown",serverTime,true];
	};
	if (_storeType isEqualTo "McFishers") then {
		[getPlayerUID player,"mcFishersRobberrySuccess",[]] remoteExec ["Server_Log_New",2];
		missionNamespace setVariable ["McFishersCooldown",serverTime,true];
	};
	if (_storeType isEqualTo "Taco Hell") then {
		[getPlayerUID player,"tacoHellRobberrySuccess",[]] remoteExec ["Server_Log_New",2];
		missionNamespace setVariable ["TacoHellCooldown",serverTime,true];
	};
	if (_storeType isEqualTo "Robbable Store") then {
		[getPlayerUID player,"storeRobberrySuccess",[]] remoteExec ["Server_Log_New",2];
		missionNamespace setVariable ["StoreCooldown",serverTime,true];
	};	
}] call Server_Setup_Compile;

["A3PL_Store_Robbery_Reward",
{
	private _storeType = param [0,"Gas Station"];
	private _faction = param [1,"fisd"];
	private _leos = count([_faction] call A3PL_Lib_FactionPlayers);
	
	private _baseCashReward = if(_leos < 5) then {7500} else {15000};
	private _cashRewardFinal = 0;
	private _xpGain = if(_leos < 5) then {30} else {45};

	if (_storeType isEqualTo "Gas Station") then {
		_cashRewardFinal = _baseCashReward + (round (random 10000)) * A3PL_Event_CrimePayout;
	};
	if (_storeType isEqualTo "McFishers") then {
		_cashRewardFinal = _baseCashReward + (round (random 5000)) * A3PL_Event_CrimePayout;
	};
	if (_storeType isEqualTo "Taco Hell") then {
		_cashRewardFinal = _baseCashReward + (round (random 7000)) * A3PL_Event_CrimePayout;
	};
	if (_storeType isEqualTo "Robbable Store") then {
		_cashRewardFinal = _baseCashReward + (round (random 15000)) * A3PL_Event_CrimePayout;
	};

	[format ["You earned $%1",str(_cashRewardFinal)],"green"] call A3PL_Player_Notification;
	player setVariable ["player_cash",((player getVariable ["player_cash",0]) + _cashRewardFinal),true];
	[player, _xpGain] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_Store_Robbery_Alert",
{
	private _store = param [0,objNull];
	private _faction = param [1,"fisd"];
	private _leos = [_faction] call A3PL_Lib_FactionPlayers;
	private _namePos = [getPos _store] call A3PL_Housing_PosAddress;
	[format ["A store alarm at %1 has been triggered!",_namePos],"blue",_faction,1] call A3PL_Lib_JobMessage;
	[_store,"Alarm Triggered!","ColorWhite","A3PL_Markers_FISD"] remoteExec ["A3PL_Lib_CreateMarker",_leos];
}] call Server_Setup_Compile;