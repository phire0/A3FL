// Northern Island
// Elk City
// Stoney Creek

["A3PL_JobShipCaptain_RentVehicle",
{
	private _location = param [0,player_objintersect];
	private _class = param[1,"A3FL_LCM"];
	private _price = param[2,1300];
	private _pCash = player getVariable["Player_Cash",0];
	private _job = player getVariable["job","unemployed"];

	hint str(_price);
	if(_job != "Captain") exitWith {["You need to be a ship captain to rent a boat!", "red"] call A3PL_Player_Notification;};
	if(_price > _pCash) exitWith {["You don't have enough cash to rent this boat!", "red"] call A3PL_Player_Notification;};
	player setVariable["Player_Cash",_pCash-_price,true];
	["Your vehicle has been spawned!", "green"] call A3PL_Player_Notification;

	_spawnLoc = switch(_location) do {
		case npc_ship_captain: {[2807.168,11818,5]};
		case npc_ship_captain_1: {[3582.857,7678.292,5]};
		case npc_ship_captain_2: {[5784.5,7285.25,5]};
		default {[2353.047,5479.137,0.766]};
	};

	[_class,_spawnLoc,"Captain"] spawn A3PL_Lib_JobVehicle_Assign;
	[player, 5] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;