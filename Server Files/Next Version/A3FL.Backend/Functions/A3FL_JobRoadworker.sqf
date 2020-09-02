/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_JobRoadworker_RepairTerrain",
{
	private ["_tObjects","_obj","_timeLeft"];

	if (!(vehicle player == player)) exitwith {["You can't be in a vehicle when repairing objects", "red"] call A3PL_Player_Notification;};
	_tObjects = nearestTerrainObjects [player, [], 5];
	if (count _tObjects < 1) exitwith {["There doesn't seem to be a terrain object nearby", "red"] call A3PL_Player_Notification;};
	_obj = _tObjects select 0;
	if (getDammage _obj < 1) exitwith {["This object doesn't seem to be damaged", "red"] call A3PL_Player_Notification;};
	_obj setDammage 0;

	_timeLeft = missionNameSpace getVariable ["A3PL_JobRoadworker_Timer",(diag_ticktime-2)];
	if (_timeLeft > diag_ticktime) exitwith {[format ["You need to wait %1 more seconds before you will be paid for repairing terrain objects again.",round(_timeLeft-diag_ticktime)],"red"] call A3PL_Player_Notification;};
	missionNameSpace setVariable ["A3PL_JobRoadworker_Timer",(diag_ticktime + (60 + random 3))];

	["You succesfully repaired a terrain object and earned $10", "green"] call A3PL_Player_Notification;
	[player, 1] call A3PL_Level_AddXP;
	[player, 'Player_Cash', ((player getVariable 'Player_Cash')  + 10)] remoteExec ["Server_Core_ChangeVar",2];
}] call Server_Setup_Compile;

["A3PL_JobRoadWorker_Loop",
{
	player setVariable ["TerrainRepaired",nil,false];
}] call Server_Setup_Compile;

["A3PL_JobRoadWorker_ToggleMark",
{
	private ["_veh"];
	_veh = param [0,objNull];

	if (isNull _veh) then
	{
		_veh = player_objintersect;
		if (!(_veh isKindOf "LandVehicle")) then {_veh = cursorobject};
		if (isNull _veh) exitwith {["Couldn't find a vehicle to impound, are you looking at it?", "red"] call A3PL_Player_Notification;};
	};

	if (_veh getVariable ["impound",false]) then
	{
		[_veh] remoteExec ["Server_JobRoadWorker_UnMark", 2];
		["You unmarked this vehicle for impounding", "red"] call A3PL_Player_Notification;
	} else {
		[_veh] remoteExec ["Server_JobRoadWorker_Mark", 2];
		["You marked this vehicle for impounding, message was send to all available roadworks", "green"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_JobRoadWorker_MarkResponse",
{
	private ["_veh"];
	_veh = param [0,objNull];
	_license = (_veh getvariable ["owner",["0","ERROR"]]) select 1;
	[format ["A new vehicle is available for impounding, it has been marked on the map (License: %1)",_license], "green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_JobRoadWorker_MarkerLoop",
{
	private _isRoadside = (player getVariable ["job","unemployed"]) isEqualTo "Roadside";
	private _isAdmin = player getVariable ["pVar_RedNameOn",false];
	private _vehicles = [];

	{deleteMarkerLocal _x;} foreach A3PL_Jobroadworker_MarkerList;
	if(!_isRoadside && !_isAdmin) exitWith {};

	A3PL_Jobroadworker_MarkerList = [];

	{
		if(!isNull _x) then {_vehicles pushback _x;};
	} foreach Server_JobRoadWorker_Marked;

	{
		_lp = (_x getvariable ["owner",["0","ERROR"]]) select 1;
		_marker = createMarkerLocal [format ["impound_%1",random 4000], _x];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_warning";
		_marker setMarkerTextLocal format ["Impound Vehicle (LP: %1)",_lp];
		_marker setMarkerColorLocal "ColorRed";
		A3PL_Jobroadworker_MarkerList pushback _marker;
	} foreach _vehicles;
}] call Server_Setup_Compile;

["A3PL_JobRoadWorker_Impound",
{
	private ["_car","_cars"];

	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	if ((player getVariable ["job","unemployed"]) != "Roadside") exitwith {["You dont seem to be working here as a Roadside Service Worker", "red"] call A3PL_Player_Notification;};

	_cars = nearestObjects [player, ["Car"], 10];
	_car = objNull;
	{
		if (_x getVariable ["impound",false]) exitwith {_car = _x;};
	} foreach _cars;

	if (isNull _car) exitwith {["It doesn't seem like there is a car nearby that is marked for impounding", "red"] call A3PL_Player_Notification;};
	if ((_car getVariable ["Towed",true])) exitwith {["Unload car before impounding", "red"] call A3PL_Player_Notification;};
	[_car,player] remoteExec ["Server_JobRoadWorker_Impound",2];
}] call Server_Setup_Compile;

["A3PL_JobRoadWorker_RentVehicle",
{
	private["_spawnLoc","_location"];
	_price = 1300;
	_location = param [0,player_objintersect];
	_pCash = player getVariable["Player_Cash",0];
	_job = player getVariable["job","unemployed"];

	//You need to be a roadworker to rent a tow truck
	if(_job != "Roadside") exitWith {[localize"STR_NewRoadWorker_0", "red"] call A3PL_Player_Notification;};

	if(_price > _pCash) exitWith {[localize"STR_NewRoadWorker_1", "red"] call A3PL_Player_Notification;};
	player setVariable["Player_Cash",_pCash-_price,true];
	[localize"STR_NewRoadWorker_2", "green"] call A3PL_Player_Notification;

	switch(_location) do {
		case npc_roadworker: {_spawnLoc = [2353.047,5479.137,0.766];}; // Silverton
		case npc_roadworker_1: {_spawnLoc = [6033.625,7353,0.422];}; // Elk City // not working
		case npc_roadworker_2: {_spawnLoc = [6934.766,7112.43,0.794];}; // Boulder City
		case npc_roadworker_3: {_spawnLoc = [10236.220,8455.28,0.388];}; // Northdale
		case npc_roadworker_4: {_spawnLoc = [2163.75,12108.875,0.65];}; //Lubbock
		default {_spawnLoc = [2353.047,5479.137,0.766];};
	};

	["A3PL_P362_TowTruck",_spawnLoc,"ROADSIDE",1800] spawn A3PL_Lib_JobVehicle_Assign;
	[player, 5] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;
