["A3PL_JobShipCaptain_RentVehicle",
{
	private["_spawnLoc","_location"];
	_price = 1300;
	_location = param [0,player_objintersect];
	_pCash = player getVariable["Player_Cash",0];
	_job = player getVariable["job","unemployed"];

	if(_job != "Ship Captain") exitWith {["You need to be a ship captain to rent an LCM!", "red"] call A3PL_Player_Notification;};

	if(_price > _pCash) exitWith {["You don't have enough cash to rent an LCM!", "red"] call A3PL_Player_Notification;};
	player setVariable["Player_Cash",_pCash-_price,true];
	["Your vehicle has been spawned!", "green"] call A3PL_Player_Notification;

	switch(_location) do {
		case npc_roadworker: {_spawnLoc = [2353.047,5479.137,0.766];}; // Silverton
		case npc_roadworker_1: {_spawnLoc = [5970.537,7397.768,0.766];}; // Elk City // not working
		case npc_roadworker_2: {_spawnLoc = [6934.766,7112.43,0.794];}; // Boulder City
		case npc_roadworker_3: {_spawnLoc = [10236.220,8455.28,0.388];}; // Northdale
		default {_spawnLoc = [2353.047,5479.137,0.766];};
	};

	["A3FL_LCM",_spawnLoc,"LCMRENT",4000] spawn A3PL_Lib_JobVehicle_Assign;
	[player, 5] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;
