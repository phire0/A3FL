// Northern Island
// Elk City
// Stoney Creek

["A3PL_JobShipCaptain_RentVehicle",
{
	private["_spawnLoc","_location"];
	_price = 1300;
	_location = param [0,player_objintersect];
	_pCash = player getVariable["Player_Cash",0];
	_job = player getVariable["job","unemployed"];

	if(_job != "Captain") exitWith {["You need to be a ship captain to rent an LCM!", "red"] call A3PL_Player_Notification;};

	if(_price > _pCash) exitWith {["You don't have enough cash to rent an LCM!", "red"] call A3PL_Player_Notification;};
	player setVariable["Player_Cash",_pCash-_price,true];
	["Your vehicle has been spawned!", "green"] call A3PL_Player_Notification;

	switch(_location) do {
		case npc_ship_captain: {_spawnLoc = [2807.168,11818,5];};
		case npc_ship_captain_1: {_spawnLoc = [3582.857,7678.292,5];};
		case npc_ship_captain_2: {_spawnLoc = [5784.5,7285.25,5];};
		default {_spawnLoc = [2353.047,5479.137,0.766];};
	};

	["A3FL_LCM",_spawnLoc,"Captain",4000] spawn A3PL_Lib_JobVehicle_Assign;
	[player, 5] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;
