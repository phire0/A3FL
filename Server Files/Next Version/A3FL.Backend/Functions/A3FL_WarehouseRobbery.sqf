/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_WarehouseRobbery_Rob",
{
	_warehouse = param [0,objNull];
	_robbedTime = missionNamespace getVariable ["WarehouseCooldown",serverTime-300];
	_notify = 30;
	_timeTaken = 45;
	_fail = false;
	_faction = "FISD";

	if ((player getVariable ["warehouse",objNull]) isEqualTo cursorObject) exitWith{["You cannot rob your own warehouse!","red"] call A3PL_Player_Notification;};
	if(_robbedTime > (serverTime-300)) exitWith {["Another warehouse robbery has taken place recently, you cannot rob this warehouse!","red"] call A3PL_Player_Notification;};
	_nearCity = text ((nearestLocations [player, ["NameCityCapital","NameCity","NameVillage"], 5000]) select 0);
	if(_nearCity IN ["Lubbock","Salt Point"]) then {
		if ((count(["uscg"] call A3PL_Lib_FactionPlayers)) < 3) exitwith {_fail=true;_faction="USCG";};
	} else {
		if ((count(["fisd"] call A3PL_Lib_FactionPlayers)) < 3) exitwith {_fail=true;_faction="FISD";};
	};
	if(_fail) exitWith {[format ["There needs to be a minimum of %1 %2 online to rob this warehouse!",3,_faction],"red"] call A3PL_Player_Notification;};

	player playmove "Acts_carFixingWheel";
	["You are attempting to lockpick this warehouse", "yellow"] call A3PL_Player_Notification;
	player setVariable ["picking",true,true];
	_cops = [_faction] call A3PL_Lib_FactionPlayers;

	if(count(_cops) < 5) then {
		_notify = 10;
		_timeTaken = 60;
	};

	_notifyChance = random 100;
	if(_notifyChance >= _notify) then {[_warehouse,_faction] spawn A3PL_WarehouseRobbery_NotifySD;};

	_alarmChance = random 100;
	if(_alarmChance >= 30) then {[_warehouse] spawn A3PL_WarehouseRobbery_Alarm;};

	[getPlayerUID player,"warehouseRobbery",[getPos _house]] remoteExec ["Server_Log_New",2];
	[_house, _timeTaken] spawn
	{
		private ["_warehouse"];
		_house = param [0,objNull];
		_timeTaken = param [1,1];
		if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
		["Lockpicking warehouse...",_timeTaken] spawn A3PL_Lib_LoadAction;
		_success = true;
		waitUntil{Player_ActionDoing};
		while {Player_ActionDoing} do {
		if(player getVariable "cuffed") exitWith {};
			if (!(vehicle player == player)) exitwith {_success = false;};
			if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
			if (!(player_itemClass == "v_lockpick")) exitwith {_success = false;};
			if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {_success = false;};
			if (animationState player != "Acts_carFixingWheel") then {player playmove "Acts_carFixingWheel";}
		};
		player switchMove "";
		if(Player_ActionInterrupted || !_success) exitWith {
			[localize"STR_CRIMINAL_PICKENDED", "red"] call A3PL_Player_Notification;
			if (vehicle player == player) then {player switchMove "";};
		};

		[player_item] call A3PL_Inventory_Clear;
		[player,"v_lockpick",-1] remoteExec ["Server_Inventory_Add",2];

		_breakChance = random 100;
		if(_breakChance >= 90) exitWith {[_warehouse,"the lockpick broke"] call A3PL_WarehouseRobbery_Fail;};

		_chance = random 100;
		if(_chance >= 35) then {
			[_warehouse] call A3PL_WarehouseRobbery_Succeed;
		} else {
			[_warehouse] call A3PL_WarehouseRobbery_Fail;
		};
	};
}] call Server_Setup_Compile;

["A3PL_WarehouseRobbery_Fail",
{
  _warehouse = param [0,objNull];
  _reason = param [1,objNull];
  [format["You have failed to lockpick this door %1!",_reason], "red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_WarehouseRobbery_Succeed",
{
	private["_physicalItems","_virtualItems"];
	_physicalItems = [];
	_virtualItems = [];

	_warehouse = param [0,objNull];
	_warehouse setVariable ["unlocked",true,true];
	_warehouse setVariable ["robbed",true,true];

	["You have successfully lockpicked this door!", "green"] call A3PL_Player_Notification;
	[player,20] call A3PL_Level_AddXP;

	_basicItems = [["dildo",1],["steel",90],["aluminum",90],["titanium",30],["sand",5]];
	_valuableItems = [["zipties",3],["jug_moonshine",6],["steel",180],["aluminum",180],["titanium",60]];
	_rareItems = [["weed_100g",3],["v_lockpick",4],["cocaine_hydrochloride",3],["steel",360],["aluminum",360],["titanium",90]];

	_valuableChance = random 100;
	if(_valuableChance >= 75) then {_virtualItems pushBack selectRandom _valuableItems;};

	_rareChance = random 100;
	if(_rareChance >= 50) then {_virtualItems pushBack selectRandom _rareItems;};

	_virtualItems pushback selectRandom _basicItems;
	_weaponHolder = createVehicle ["Land_MetalCase_01_large_F", [(getpos _warehouse select 0),(getpos _warehouse select 1),1], [], 0, "CAN_COLLIDE"];

	_weaponHolder setVariable["storage",_virtualItems,true];
	{_weaponHolder addItemCargoGlobal _x;} forEach _physicalItems;
}] call Server_Setup_Compile;

["A3PL_WarehouseRobbery_NotifySD",
{
	private["_warehouse","_cops","_namePos"];
	_warehouse = param [0,objNull];
	_faction = param [1,"fisd"];
	_cops = [_faction] call A3PL_Lib_FactionPlayers;

	_namePos = [getPos _warehouse] call A3PL_Housing_PosAddress;
	[format["911: Robbery in progress at %1!",_namePos],"blue",_faction,1] call A3PL_Lib_JobMessage;
	[_warehouse,"Warehouse Alarm","ColorRed"] remoteExec ["A3PL_Lib_CreateMarker",_cops];

	missionNamespace setVariable ["WarehouseCooldown",serverTime,true];
}] call Server_Setup_Compile;

["A3PL_WarehouseRobbery_Alarm", {
	private["_warehouse","_y"];
	_warehouse = param [0,objNull];
	_y = 50;
	while {_y > 0} do {
		playSound3D ["A3\Sounds_F\sfx\alarmCar.wss", _warehouse, true, _warehouse, 3, 1, 400];
		uiSleep 2;
		_y = _y - 1;
	};
}] call Server_Setup_Compile;

["A3PL_WarehouseRobbery_Secure",
{
	private["_warehouse","_box"];
	_warehouse = param [0,objNull];
	_box = nearestObjects[_warehouse,["Land_MetalCase_01_large_F"],20];
	{deleteVehicle _x;} forEach _box;

	_warehouse setVariable ["unlocked",Nil,true];
	[_warehouse,"Door_1",false] call A3PL_Lib_ToggleAnimation;
	["You secured this warehouse","green"] call A3PL_Player_Notification;
	[player,20] call A3PL_Level_AddXP;
	_warehouse setVariable ["robbed",false,true];
}] call Server_Setup_Compile;
