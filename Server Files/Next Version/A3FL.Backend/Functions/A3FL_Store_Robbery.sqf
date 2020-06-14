/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Store_Robbery_RobStore",
{
	private ["_store","_cooldown","_success","_cops","_timeElapsed","_isStation","_status"];
	_store = param [0,objNull];
	_isStation = param [1,false];
	_cooldown = _store getVariable ["cooldown",[objNull,false]];
	_fail = false;
	_cops = [];
	_faction = "FISD";

	if (isNull(_cooldown select 0)) then {
		_cooldown = [objNull,false];
	};
	_status = missionNamespace getVariable ["StoreCooldown",0];

	if (_status isEqualTo 1) exitwith {["Another store robbery has taken place recently, you cannot rob this store!","red"] call A3PL_Player_Notification;};
	if (_cooldown select 1) exitwith {["This store has already been robbed recently","red"] call A3PL_Player_Notification;};
	if ((currentWeapon player) isEqualTo "") exitwith {["You are not brandishing a firearm","red"] call A3PL_Player_Notification;};
	if ((currentWeapon player) IN ["hgun_Pistol_Signal_F","A3PL_FireAxe","A3PL_Shovel","A3PL_Pickaxe","A3PL_Golf_Club","A3PL_Jaws","A3PL_High_Pressure","A3PL_Medium_Pressure","A3PL_Low_Pressure","A3PL_Taser","A3PL_FireExtinguisher","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","A3PL_Predator"]) exitwith {["You cannot rob a store with this weapon!","red"] call A3PL_Player_Notification;};

	if(_store IN [Robbable_Shop_1,Robbable_Shop_2,Robbable_Shop_3,Robbable_Shop_4]) then {
		_cops = ["fisd"] call A3PL_Lib_FactionPlayers;
		if ((count(_cops)) < 3) exitwith {_fail=true;_faction="FISD";};
	} else {
		_cops = ["uscg"] call A3PL_Lib_FactionPlayers;
		if ((count(_cops)) < 3) exitwith {_fail=true;_faction="USCG";};
	};

	if(_fail) exitWith {[format ["There needs to be a minimum of %1 %2 online to rob this store!",3,_faction],"red"] call A3PL_Player_Notification;};

	["If you try to turn this store, stay near the cash!", "green"] call A3PL_Player_Notification;

	_store setVariable ["cooldown",[player,true],true];
	missionNamespace setVariable ["StoreCooldown",1,true];

	playSound3D ["A3PL_Common\effects\burglaralarm.ogg", _store, false, getPosASL _store, 1, 1, 200];
	[_store] remoteExec ["A3PL_Store_Robbery_Alert", _cops];

	if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
	["Robbing the store...",50,false] spawn A3PL_Lib_LoadAction;
	_success = true;
	_timeElapsed = 0;
	waitUntil{Player_ActionDoing};
	while {Player_ActionDoing} do {
		if ((player distance2D _store) > 5) exitWith {["You went away from the shop, the robbery failed!", "red"] call A3PL_Player_Notification; _success = false;};
		if (!(vehicle player == player)) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
		_timeElapsed = _timeElapsed + 0.5;
		if (_timeElapsed == 28) then {playSound3D ["A3PL_Common\effects\burglaralarm.ogg", _store, false, getPosASL _store, 1, 1, 200];};
	};
	if(Player_ActionInterrupted || !_success) exitWith {
		Player_ActionInterrupted = true;
		_store setVariable ["cooldown",[objNull,false],true];
		["The store robbery was cancelled!", "red"] call A3PL_Player_Notification;
	};

	["Successful robbery!", "green"] call A3PL_Player_Notification;
	[_isStation,_store] call A3PL_Store_Robbery_Reward;

	uiSleep 1800;
	missionNamespace setVariable ["StoreCooldown",0,true];
	_store setVariable ["cooldown",nil,true];
}] call Server_Setup_Compile;

["A3PL_Store_Robbery_Reward",
{
	private ["_cops","_reward","_isStation","_station"];

	_isStation = param [0,false];
	_station = param [1,objNull];
	_cops = count(["fisd"] call A3PL_Lib_FactionPlayers);
	if(_isStation) then {
		if(_cops < 5) then
		{
			_reward = 5000 + (round (random 6000));
			[format ["You earned $%1",str(_reward)], "green"] call A3PL_Player_Notification;
			player setVariable ["player_cash",((player getVariable ["player_cash",0]) + _reward),true];
			[player, 30] call A3PL_Level_AddXP;
		};
		if(_cops >= 5) then
		{
			_reward = 10000 + (round (random 5000));
			[format ["You earned $%1",str(_reward)], "green"] call A3PL_Player_Notification;
			player setVariable ["player_cash",((player getVariable ["player_cash",0]) + _reward),true];
			[player, 45] call A3PL_Level_AddXP;
		};
	}
	else
	{
		if(_cops < 5) then
		{
			_reward = 5000 + (round (random 6000));
			[format ["You earned $%1",str(_reward)], "green"] call A3PL_Player_Notification;
			player setVariable ["player_cash",((player getVariable ["player_cash",0]) + _reward),true];
			[player, 30] call A3PL_Level_AddXP;
		};
		if(_cops >= 5) then
		{
			_reward = 10000 + (round (random 5000));
			[format ["You earned $%1",str(_reward)], "green"] call A3PL_Player_Notification;
			player setVariable ["player_cash",((player getVariable ["player_cash",0]) + _reward),true];
			[player, 45] call A3PL_Level_AddXP;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Store_Robbery_Alert",
{
	private ["_store","_storePos","_namePos"];
	_store = param [0,objNull];
	_storePos = getPos _store;
	_namePos = [_storePos] call A3PL_Housing_PosAddress;
	[format ["A store alarm at %1 has been triggered",_namePos],"blue"] call A3PL_Player_Notification;
	[_store] spawn A3PL_Store_Robbery_Marker;
}] call Server_Setup_Compile;

["A3PL_Store_Robbery_Marker",
{
	private ["_store"];
	_store = param [0,objNull];

	//create marker
	_marker = createMarkerLocal [format["store_robbery_%1",floor (random 5000)],_store];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerColorLocal "ColorWhite";
	_marker setMarkerTypeLocal "mil_warning";
	_marker setMarkerTextLocal format ["Alarm Triggered!"];

	//wait 180 seconds and delete marker
	uiSleep 180;
	deleteMarkerLocal _marker;
}] call Server_Setup_Compile;
