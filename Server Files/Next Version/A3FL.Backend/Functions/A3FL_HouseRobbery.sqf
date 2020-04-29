/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_HouseRobbery_Rob",
{
	_house = param [0,objNull];
	_status = missionNamespace getVariable ["HouseCooldown",0];
	_notify = 30;
	_timeTaken = 45;

	if ((player getVariable ["house",objNull]) == cursorObject) exitWith{["You cannot rob your own house!","red"] call A3PL_Player_Notification;};
	if (_status == 1) exitwith {["Another house robbery has taken place recently, you cannot rob this house!","red"] call A3PL_Player_Notification;};

	_cops = ["fisd"] call A3PL_Lib_FactionPlayers;
	if ((count _cops) < 3) exitwith {["There must be at least 3 FISD on duty to rob a house!","red"] call A3PL_Player_Notification;};

	player playmove "Acts_carFixingWheel";
	["You are attempting to lockpick this house", "yellow"] call A3PL_Player_Notification;
	player setVariable ["picking",true,true];

	if(count(_cops) < 5) then {
		_notify = 10;
		_timeTaken = 60;
	};

	_notifyChance = random 100;
	if(_notifyChance >= _notify) then {[_house] spawn A3PL_HouseRobbery_NotifySD;};

	_alarmChance = random 100;
	if(_alarmChance >= 30) then {[_house] spawn A3PL_HouseRobbery_Alarm;};

	[getPlayerUID player,"houseRobbery",[getPos _house]] remoteExec ["Server_Log_New",2];
	[_house, _timeTaken] spawn
	{
		private ["_house"];
		_house = param [0,objNull];
		_timeTaken = param [1,1];
		if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
		["Lockpicking house...",_timeTaken] spawn A3PL_Lib_LoadAction;
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
		if(!_success) exitWith {
			Player_ActionInterrupted = true;
			[localize"STR_CRIMINAL_PICKENDED", "red"] call A3PL_Player_Notification;
			if (vehicle player == player) then {player switchMove "";};
		};

		[player_item] call A3PL_Inventory_Clear;
		[player,"v_lockpick",-1] remoteExec ["Server_Inventory_Add",2];

		_breakChance = random 100;
		if(_breakChance >= 90) exitWith {[_house,"the lockpick broke"] call A3PL_HouseRobbery_Fail;};

		_chance = random 100;
		if(_chance >= 35) then {
			[_house] call A3PL_HouseRobbery_Succeed;
		} else {
			[_house] call A3PL_HouseRobbery_Fail;
		};
	};
}] call Server_Setup_Compile;

["A3PL_HouseRobbery_Fail",
{
  _house = param [0,objNull];
  _reason = param [1,objNull];
  [format["You have failed to lockpick this door %1!",_reason], "red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_HouseRobbery_Succeed",
{
	private["_physicalItems","_virtualItems"];
	_physicalItems = [];
	_virtualItems = [];

	_house = param [0,objNull];
	_house setVariable ["unlocked",true,true];
	_house setVariable ["robbed",true,true];

	["You have successfully lockpicked this door!", "green"] call A3PL_Player_Notification;
	[player,20] call A3PL_Level_AddXP;

	_weaponRewards = [["A3PL_P226",1],["A3PL_Red_Glock",1],["hgun_P07_F",1],["hgun_Pistol_01_F",1]];
	_magRewards = [["10Rnd_9x21_Mag",2],["A3PL_Red_Glock_Mag",2],["A3PL_P226_Mag",2]];
	_houseHoldItems = [["coke",5],["apple",5],["beer",5],["jerrycan",2],["repairwrench",3],["bread",5]];
	_valuables = [["diamond",2],["diamond_emerald",3],["shark_10lb_tag",1],["shark_4lb_tag",2],["dildo",1]];
	_illegalItems = [["seed_marijuana",5],["v_lockpick",2],["cocaine",2],["zipties",2],["jug_moonshine",2],["weed_50g",2],["weed_100g",2],["turtle",2],["shrooms",4]];

	_gunChance = random 100;
	if(_gunChance >= 75) then {_physicalItems pushBack selectRandom _weaponRewards;};

	_magChance = random 100;
	if(_gunChance >= 65) then {_physicalItems pushBack selectRandom _magRewards;};

	_valuableChance = random 100;
	if(_valuableChance >= 50) then {_virtualItems pushBack selectRandom _valuables;};

	_illegalChance = random 100;
	if(_illegalChance >= 50) then {_virtualItems pushBack selectRandom _illegalItems;};

	_virtualItems pushback selectRandom _houseHoldItems;
	_weaponHolder = createVehicle ["Land_MetalCase_01_large_F", [(getpos _house select 0),(getpos _house select 1),1], [], 0, "CAN_COLLIDE"];

	_weaponHolder setVariable["storage",_virtualItems,true];
	{_weaponHolder addItemCargoGlobal _x;} forEach _physicalItems;
}] call Server_Setup_Compile;

["A3PL_HouseRobbery_NotifySD",
{
	private["_house","_cops","_namePos"];
	_house = param [0,objNull];
	_cops = ["fisd"] call A3PL_Lib_FactionPlayers;

	_namePos = [getPos _house] call A3PL_Housing_PosAddress;
	[format["911: Robbery in progress at %1!",_namePos],"blue","fisd",1] call A3PL_Lib_JobMessage;
	[_house,"House Alarm","ColorRed"] remoteExec ["A3PL_Lib_CreateMarker",_cops];

	missionNamespace setVariable ["HouseCooldown",1,true];
	uiSleep 900;
	missionNamespace setVariable ["HouseCooldown",0,true];
}] call Server_Setup_Compile;

["A3PL_HouseRobbery_Alarm", {
	private["_house","_y"];
	_house = param [0,objNull];
	_y = 50;
	while {_y > 0} do {
		playSound3D ["A3\Sounds_F\sfx\alarmCar.wss", _house, true, _house, 3, 1, 400];
		uiSleep 2;
		_y = _y - 1;
	};
}] call Server_Setup_Compile;

["A3PL_HouseRobbery_Secure",
{
	private["_house","_box"];
	_house = param [0,objNull];
	_box = nearestObjects[_house,["Land_MetalCase_01_large_F"],20];
	{deleteVehicle _x;} forEach _box;

	_house setVariable ["unlocked",Nil,true];
	[_house,"Door_1",false] call A3PL_Lib_ToggleAnimation;
	["You secured this house","green"] call A3PL_Player_Notification;
	[player,20] call A3PL_Level_AddXP;
	_house setVariable ["robbed",false,true];
}] call Server_Setup_Compile;
