/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Fire_PauseCheck", {
	[Server_FireLooping] remoteExec ["A3PL_Admin_PauseCheckReturn"];
},true] call Server_Setup_Compile;

["Server_Fire_PauseFire", {
	if (Server_FireLooping) then {
		Server_FireLooping = false;
	} else {
		Server_FireLooping = true;
	};
},true] call Server_Setup_Compile;

["Server_Fire_Destroy",
{
	private _fireobject = param [0,objNull];
	{deleteVehicle _x;} foreach (nearestObjects [_fireobject, Config_Placeables, 4]);
	{ _x hideObjectGlobal true; } foreach nearestTerrainObjects [_fireobject,["TREE", "SMALL TREE", "BUSH","FOREST"],4];
	{
		_x setDamage 1;
		_x setVariable["burnt",true,true];
	} foreach (nearestObjects [_fireobject, ["Land_Fence1_DED_Fence_01_F","Land_Fence2_DED_Fence_02_F","Land_A3FL_Fence_Wood4_1m","Land_A3FL_Fence_Wood4_4m","Land_A3FL_Fence_Wood2_1m","Land_A3FL_Fence_Wood2_4m","Land_A3FL_Fence_Wood_Doorway2_4m","Land_A3FL_Fence_Wood_Doorway4_2m"],2]);
},true] call Server_Setup_Compile;

["Server_Fire_StartFire",
{
	private _position = param [0,[]];
	private _dir = param [1,windDir];
	if (count _position < 3) exitwith {};
	private _onWater = !(_position isFlatEmpty [-1, -1, -1, -1, 2, false] isEqualTo []);
	if(_onWater || ((_position select 3) < 0)) exitWith {};

	private _fireobject = createVehicle ["A3PL_FireObject",_position, [], 0, "CAN_COLLIDE"];
	_fireobject addEventhandler ["HandleDamage",{[param [0,objNull],param [4,""],param [6,objNull]] spawn Server_Fire_HandleDamage;}];
	_fireObject setDir _dir;
	[_fireObject] call Server_Fire_AddFireParticles;
	Server_TerrainFires pushBack [_fireObject];
	[_fireobject] call Server_Fire_Destroy;
},true] call Server_Setup_Compile;

["Server_Fire_AddFireParticles",
{
	private _fireObject = param [0,[]];
	if (isNull _fireObject) exitwith {};
	private _r1 = random 10; if (_r1 <= 0.7) then {_r1 = true} else {_r1 = false};
	private _r2 = random 10; if (_r2 <= 0.4) then {_r2 = true} else {_r2 = false};
	private _r3 = random 10; if (_r3 <= 0.3) then {_r3 = true} else {_r3 = false};

	private _source1 = createVehicle ["#particleSource",getposATL _fireObject, [], 0, "CAN_COLLIDE"];
	_source1 setparticleclass "MediumDestructionFire";
	_source1 attachTo [_fireObject,[0,0,0]];

	if (_r1) exitwith {
		_source2 = createVehicle ["#particleSource",getposATL _fireObject, [], 0, "CAN_COLLIDE"];
		_source2 setparticleclass "MediumDestructionSmoke";
		_source2 attachTo [_fireObject,[0,0,0]];
	};
	if (_r2) exitwith {
		private _source2 = createVehicle ["#particleSource",getposATL _fireObject, [], 0, "CAN_COLLIDE"];
		_source2 setparticleclass "BigDestructionSmoke";
		_source2 attachTo [_fireObject,[0,0,0]];
	};
	if (_r3) exitwith {
		private _source2 = createVehicle ["#particleSource",getposATL _fireObject, [], 0, "CAN_COLLIDE"];
		_source2 setparticleclass "HouseDestrSmokeLongSmall";
		_source2 attachTo [_fireObject,[0,0,0]];
	};
},true] call Server_Setup_Compile;

["Server_Fire_Killed",
{
	private _fireObject = param [0,objNull];	
	private _f = false;
	{
		deleteVehicle _x;
	} foreach (attachedObjects _fireObject);

	{
		_loopIndex = _forEachIndex;
		_fireArray = _x;
		{
			if (_fireObject == _x) exitwith {
				if (count _fireArray < 2) then {
					Server_TerrainFires deleteAt _loopIndex;
				} else {
					Server_TerrainFires set [_loopIndex,_fireArray-[_x]];
				};
			};
		} foreach _x;
	} foreach Server_TerrainFires;
	deleteVehicle _fireObject;
},true] call Server_Setup_Compile;

["Server_Fire_HandleDamage",
{
	private _fireObject = param [0,objNull];
	private _projectile = param [1,""];
	private _instig = param [2,objNull];
	private _dmg = 0;
	if (_projectile IN ["A3PL_Extinguisher_Water_Ball","A3PL_High_Pressure_Water_Ball","A3PL_Medium_Pressure_Water_Ball","A3PL_Low_Pressure_Water_Ball","A3PL_High_Pressure_Foam_Ball","A3PL_Medium_Pressure_Foam_Ball","A3PL_Low_Pressure_Foam_Ball"]) then
	{
		switch(_projectile) do {
			case("A3PL_Extinguisher_Water_Ball"): {_dmg = 0.1;};
			case("A3PL_High_Pressure_Water_Ball"): {_dmg = 0.3;};
			case("A3PL_Medium_Pressure_Water_Ball"): {_dmg = 0.15;};
			case("A3PL_Low_Pressure_Water_Ball"): {_dmg = 0.1;};
			case("A3PL_High_Pressure_Foam_Ball"): {_dmg = 0.4;};
			case("A3PL_Medium_Pressure_Foam_Ball"): {_dmg = 0.25;};
			case("A3PL_Low_Pressure_Foam_Ball"): {_dmg = 0.2;};
		};
		_newDmg = (_fireObject getVariable ["dmg",0]) + _dmg;
		if (_newDmg >= 1) then
		{
			[_instig, 3] remoteExec ["A3PL_Level_AddXP",_instig];
			[_fireObject] call Server_Fire_Killed;
		} else {
			_fireObject setVariable ["dmg",_newDmg,false];
		};
	};
	_dmg = 0;
	_dmg;
},true] call Server_Setup_Compile;

["Server_Fire_RemoveFires",
{
	{
		{
			{
				deleteVehicle _x;
			} foreach attachedObjects _x;
			deleteVehicle _x;
		} foreach _x;
	} foreach (missionNameSpace getVariable ["Server_TerrainFires",[]]);
	Server_TerrainFires = [];
},true] call Server_Setup_Compile;

["Server_Fire_FireLoop",
{
	if(Server_TerrainFires isEqualTo []) exitWith {};
	{
		if (!Server_FireLooping) exitWith {};
		private _loopIndex = _forEachIndex;
		private _fireArray = _x;
		private _spreadArray = [];

		if ((count _fireArray) > 0) then {_spreadArray pushback (_fireArray select (count _fireArray - 1));};
		if ((count _fireArray) > 1) then {_spreadArray pushback (_fireArray select (count _fireArray - 2));};
		if ((count _fireArray) > 2) then {_spreadArray pushback (_fireArray select (count _fireArray - 3));};
		{
			private _latestFire = _x;
			private _newDir = windDir + random(90);
			private _dist = 2 + (random 3);
			private _position = [_latestFire, _dist, _newDir] call BIS_fnc_relPos;
			private _correctSurface = (surfaceType _position) IN ["#cype_grass","#cype_forest","#cype_plowedfield","#GdtDirt"];
			if (_correctSurface && (!isOnRoad _position)) then
			{
				private _fireobject = createVehicle ["A3PL_Fireobject",_position, [], 0, "CAN_COLLIDE"];
				_fireobject addEventhandler ["HandleDamage",{[param [0,objNull],param [4,""],param [6,objNull]] call Server_Fire_HandleDamage;}];
				_fireObject setDir _newDir;
				[_fireObject] call Server_Fire_AddFireParticles;

				_fireArray pushback _fireObject;
				Server_TerrainFires set [_loopIndex,_fireArray];
				[_fireobject] call Server_Fire_Destroy;
			};
		} foreach _spreadArray;
	} foreach Server_TerrainFires;
},true] call Server_Setup_Compile;

["Server_Fire_VehicleExplode",
{
	private _veh = param [0,objNull];
	private _var = _veh getVariable ["owner",[]];

	diag_log format["Server_Fire_VehicleExplode: %1 / %2",_veh, _var];

	[_veh] call A3PL_Vehicle_SoundSourceClear;
	_sirenObj = _veh getVariable ["sirenObj",objNull];
	if (!isNull _sirenObj) then {deleteVehicle _sirenObj;};

	if((count _var) > 0) then {
		private _id = _var select 1;
		private _uid = _var select 0;
		private _player = [_uid] call A3PL_Lib_UIDToObject;
		[_veh,false] remoteExec ["A3PL_Vehicle_AddKey",_player];
		[_uid,"VehicleExplode",[typeOf _veh, _id]] remoteExec ["Server_Log_New",2];

		private _isInsured = _veh getVariable ["insurance",false];
		if((typeOf _veh) IN ["A3PL_MiniExcavator","A3PL_Car_Trailer","A3PL_Lowloader","A3PL_Small_Boat_Trailer","A3PL_Drill_Trailer","A3PL_Tanker_Trailer","A3PL_Box_Trailer"]) then {_isInsured = true;};
		if(_isInsured) then {
			[_veh] call Server_Storage_VehicleVirtual;
			private _query = format ["UPDATE objects SET plystorage = '1' WHERE id = '%1'",_id];
			[_query,1] spawn Server_Database_Async;
		} else {
			private _query = format ["UPDATE objects SET istorage = '[]', vstorage = '[]', impounded='1', plystorage = '1' WHERE id = '%1'",_id];
			[_query,1] spawn Server_Database_Async;
		};
	};

	private _fifr = ["fifr"] call A3PL_Lib_FactionPlayers;
	if ((count(_fifr)) >= 5) then {
		private _marker = createMarker [format ["vehiclefire_%1",random 4000], position (_veh)];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "A3PL_Markers_FIFD";
		_marker setMarkerText "FIRE";
		_marker setMarkerColor "ColorWhite";
		[localize"STR_SERVER_FIRE_VEHICLEFIREREPORT","red","fifr",3] call A3PL_Lib_JobMessage;
		["A3PL_Common\effects\firecall.ogg",150,2,10] spawn A3PL_FD_FireStationAlarm;
		[getposATL (_veh)] spawn Server_Fire_StartFire;
		sleep 230;
		deleteMarker _marker;
	};
}] call Server_Setup_Compile;

['Server_FD_Database',
{
	private _player = _this select 0;
	private _name = _this select 1;
	private _call = _this select 2;
	switch (_call) do {
		case "lookpatient":
		{
			private _query = format ["SELECT (SELECT gender FROM players WHERE name = '%1') AS gender, (SELECT dob FROM players WHERE name = '%1') AS DOB, (SELECT pasportdate FROM players WHERE name = '%1') AS pasportDate FROM players WHERE uid = (SELECT uid FROM players WHERE name='%1')", _name];
			private _return = [_query, 2] call Server_Database_Async;
			[_name,_call,_return] remoteExec ["A3PL_FD_DatabaseEnterReceive",(owner _player)];
		};
		case "lookhistory":
		{
			private _query = format ["SELECT * FROM firedatabase WHERE Patient = '%1'", _name];
			private _return = [_query, 2,true] call Server_Database_Async;
			[_name,_call,_return] remoteExec ["A3PL_FD_DatabaseEnterReceive",(owner _player)];
		};
		case "addhistory":
		{
			private _pname = _name select 0;
			private _place = _name select 1;
			private _info = _name select 2;
			private _issuedBy = _name select 3;
			private _info = [_info] call Server_Database_EsapeString;
			private _query = format ["INSERT INTO firedatabase (Patient, Place, Informations, IssuedBy, Time) VALUES ('%1', '%2', '%3', '%4', NOW())",_pname,_place,_info,_issuedBy];
			private _return = [_query, 2,true] call Server_Database_Async;
			[_name,_call,format[localize "STR_SERVER_FIRE_FIREDATABASEFOLDERMODIFIED",_pname]] remoteExec ["A3PL_FD_DatabaseEnterReceive",(owner _player)];
		};
		default {};
	};
},true] call Server_Setup_Compile;

['Server_FD_SwitchClinic',
{
	if (A3PL_FD_Clinic) then {
		A3PL_FD_Clinic = false;
	} else {
		A3PL_FD_Clinic = true;
	};
	publicVariable "A3PL_FD_Clinic";
},true] call Server_Setup_Compile;