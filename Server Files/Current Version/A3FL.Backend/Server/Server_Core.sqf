['Server_Core_Variables', {
	A3PL_RetrievedInventory = true;
	Server_Storage_ListVehicles = [];

	Server_AptList = nearestObjects [[3552.460,6664.702,0], ["Land_A3PL_Motel"], 5000];
	{
		_x setVariable ["Server_AptAssigned",[],false];
	} foreach Server_AptList;

	//Variable that stores a list of owned/sold houses
	Server_HouseList = [];

	//Variable that stores all fishing buoys
	Server_FishingBuoys = [];

	//greenhouses
	Server_JobFarming_GreenHouses = [];

	//List of all jailed players
	Server_Jailed_Players = [];

	A3PL_Uber_Drivers = [];
	A3PL_Uber_Riders = [];

	A3PL_HitchingVehicles = ["A3PL_Car_Base","A3PL_Truck_Base"];

	//Fire Scripts
	Server_TerrainFires = [];
	Server_FireLooping = true;

	//markerlist
	Server_JobRoadWorker_Marked = [];
	publicVariable "Server_JobRoadWorker_Marked";
}, true] call Server_Setup_Compile;

//saves a variable into the persistent variables table
//COMPILE BLOCK WARNING!!!!
["Server_Core_SavePersistentVar",
{
	if (!isDedicated) exitwith {};
	private _var = param [0,""];
	private _toArray = param [1,true];
	private _query = "";
	if (_toArray) then {
		_query = format ["UPDATE persistent_vars SET value='%2' WHERE var = '%1'",_var,[(call compile _var)] call Server_Database_Array];
	} else {
		_query = format ["UPDATE persistent_vars SET value='%2' WHERE var = '%1'",_var,(call compile _var)];
	};
	[_query,1] spawn Server_Database_Async;
},true,true] call Server_Setup_Compile;

//Change a blacklisted variable for player from server
["Server_Core_ChangeVar", {
	private ["_obj", "_variable", "_value"];

	_obj = param [0,objNull];
	_variable = param [1,"ERROR"];
	_value = param [2,"ERROR"];

	//end if no player was sent
	if (isNull _obj) exitWith {};

	//end if no variable was sent
	if ((str _variable) == "ERROR") exitWith {};

	//end if no value was sent
	if ((str _value) == "ERROR") exitWith {};

	//change variable
	_obj setVariable [_variable, _value, true];
}, true] call Server_Setup_Compile;

["Server_Core_GetDefVehicles",{Server_Core_DefVehicles = allMissionObjects "All";},true] call Server_Setup_Compile;

//cleanup items
["Server_Core_Clean",
{
	private ["_toDelete","_items","_allMO","_ignore"];
	_toDelete = [];
	_allMO = allMissionObjects "All";
	_ignore = ["A3PL_MobileCrane","A3PL_Anchor","A3PL_FSS_Siren","A3PL_FSS_Phaser","A3PL_FSS_Priority","A3PL_FSS_Rumbler","A3PL_EQ2B_Wail","A3PL_Whelen_Warble","A3PL_AirHorn_1","A3PL_FSUO_Siren","A3PL_Whelen_Priority3","A3PL_FIPA20A_Priority","A3PL_Electric_Horn","A3PL_Whelen_Siren","A3PL_Whelen_Priority""A3PL_Whelen_Priority2""A3PL_Electric_Airhorn","A3PL_Lifebuoy","A3PL_rescueBasket","A3PL_Ladder","A3PL_OilBarrel","A3PL_MiniExcavator_Bucket","A3PL_MiniExcavator_Jackhammer","A3PL_MiniExcavator_Claw","A3PL_TapeSign","A3PL_PlasticBarrier_01","A3PL_PlasticBarrier_02","A3PL_Road_Bollard","A3PL_RoadBarrier","A3PL_AAA_Box","A3PL_Corn","A3PL_Marijuana","A3PL_Wheat","A3PL_Lettuce","A3PL_Coco_Plant","A3PL_Sugarcane_Plant","A3PL_DeliveryBox","A3PL_Net","A3PL_Stinger","A3PL_Camping_Light","Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F","Land_WoodenTable_small_F","Land_cargo_house_slum_F","Rope","A3PL_Yacht_Pirate","A3PL_Pumpjack","A3PL_OilBarrel","A3PL_Drillhole","A3PL_Ladder","A3PL_FireObject","A3PL_FD_HoseEnd1_Float","A3PL_FD_HoseEnd2_Float","A3PL_FD_HoseEnd2","A3PL_FD_HoseEnd1","A3PL_FD_EmptyPhysx","A3PL_FD_yAdapter","A3PL_FD_HydrantWrench_F","Box_GEN_Equip_F","A3PL_Container_Hook","A3PL_Container_Ship","A3PL_RoadCone_x10","A3PL_RoadCone","Land_A3PL_Tree3","Rabbit_F","A3PL_Grainsack_Malt","A3PL_Grainsack_Yeast","A3PL_Grainsack_CornMeal","A3PL_Distillery","A3PL_Distillery_Hose","A3PL_Jug","A3PL_Jug_Green","Land_A3PL_EstateSign","Land_A3PL_FireHydrant","A3PL_Cannabis","Land_PortableLight_double_F","Land_Device_slingloadable_F","PortableHelipadLight_01_yellow_F","Land_Pipes_large_F","Land_Tribune_F","Land_RampConcrete_F","Land_Crash_barrier_F","Land_GH_Stairs_F","RoadCone_L_F","RoadBarrier_F","RoadBarrier_small_F","Land_Razorwire_F","Land_Can_Dented_F","O_Heli_Light_02_unarmed_F","SoundSource_4","SoundSource_3","SoundSource_2","SoundSource_1","A3PL_EMS_Stretcher","A3PL_PlasticBarrel"];

	{
		if (((_x getVariable ["clean",0]) > 0) && ((Server_Core_DefVehicles find _x) == -1)) then
		{
			//check if this is an item that has pickup set to false in Config_Items
			private ["_class"];
			_skip = false;
			_class = _x getVariable ["class",nil];
			if (!isNil "_class") then
			{
				if (!([_class,"canPickup"] call A3PL_Config_GetItem)) then {_skip = true;};
			};
			if (!_skip) then {_toDelete pushback _x;};
		} else {
			_x setVariable ["clean",1,false];
		};
	} foreach _allMO;
	{
		if (isNil {_x getVariable ["owner",nil]}) then {
			if ((!isNull (attachedTo _x)) OR (!isNil {_x getVariable ["bItem",nil]}) OR ((typeOf _x) IN _ignore)) then {
				_x setVariable ["clean",nil,false];
			} else {
				deleteVehicle _x;
			};
		};
	} foreach _toDelete;
},true] call Server_Setup_Compile;

//repairs all terrain objects
["Server_Core_RepairTerrain",
{
	{
		if ((getDammage _x) isEqualTo 1) then {_x setDammage 0;};
	} foreach nearestTerrainObjects [[6690.16,7330.15,0], [], 10000];
},true] call Server_Setup_Compile;

["Server_Core_Restart",
{
	[format [localize"STR_SERVER_CORE_RESTART10MN"],"yellow"] remoteExec ["A3PL_Player_Notification", -2];
	[format [localize"STR_SERVER_CORE_RESTART10MN"],"yellow"] remoteExec ["A3PL_Player_Notification", -2];
	[format [localize"STR_SERVER_CORE_RESTART10MN"],"yellow"] remoteExec ["A3PL_Player_Notification", -2];
	["A3PL_Common\effects\airalarm.ogg",2500,0,10] spawn A3PL_FD_FireStationAlarm;

	0 setRain 1;
	0 setFog [0.3, 0.3, 8];
	setWind [10, 10, true];
	0 setGusts 1;
	0 setOvercast 1;
	0 setLightnings 1;
	forceWeatherChange;
	[4] remoteExec ["BIS_fnc_earthquake",-2];

	for "_i" from 0 to 2 do {
		sleep 140;
		[4] remoteExec ["BIS_fnc_earthquake",-2];
		[format [localize"STR_SERVER_CORE_RESTARTNOW"],"yellow"] remoteExec ["A3PL_Player_Notification", -2];
		[format [localize"STR_SERVER_CORE_RESTARTNOW"],"yellow"] remoteExec ["A3PL_Player_Notification", -2];
		[format [localize"STR_SERVER_CORE_RESTARTNOW"],"yellow"] remoteExec ["A3PL_Player_Notification", -2];
		["A3PL_Common\effects\airalarm.ogg",2500,0,10] spawn A3PL_FD_FireStationAlarm;
	};
	sleep 120;

},true] call Server_Setup_Compile;

// 11am EST = 3pm UTC
["Server_Core_RestartLoop",{
	_utcTime = "extDB3" callExtension "9:UTC_TIME";
	_justTime = (parseSimpleArray _utcTime) select 1;
	_hourMin = [(_justTime select 3),(_justTime select 4)];

	_restartTimes = [[15,00],[03,00];
	{
		if(_hourMin isEqualTo _x) then {
			[] spawn Server_Core_RestartTimer;
			diag_log format ["Announced Restart At: %1",_hourMin];
		};
	} forEach _restartTimes;

},true] call Server_Setup_Compile;


["Server_Core_Weather",
{
	private["_weatherArray","_nextWeather","_chance"];
	_chance = random(100);
	_nextweather = "";
	switch(true) do {
		case (_chance >= 5): {_nextWeather = "sunny";};
		case (_chance >= 20): {_nextWeather = "thunder";};
		case (_chance >= 50): {_nextWeather = "windy";};
		case (_chance >= 70): {_nextWeather = "rainny";};
		case (_chance >= 90): {_nextWeather = "foggy";};
	};
	switch(_nextWeather) do {
		case('sunny'): {
			60 setFog 0;
			60 setOvercast 0;
			60 setLightnings 0;
			60 setRain 0;
			60 setWaves 0;
			60 setGusts 0;
			setWind [0, 0, true];
		};
		case('rainny'): {
			60 setFog 0;
			60 setOvercast 0.5;
			60 setLightnings 0;
			60 setRain 0.9;
			60 setWaves 0.3;
			60 setGusts 0.3;
			setWind [2, -3, true];
		};
		case('thunder'): {
			60 setFog 0;
			60 setOvercast 1;
			60 setLightnings 1;
			60 setRain 1;
			60 setWaves 0.6;
			60 setGusts 0.5;
			setWind [5, -10, true];
		};
		case('foggy'): {
			60 setFog 0.3;
			60 setOvercast 0.8;
			60 setLightnings 0;
			60 setRain 0;
			60 setWaves 0.2;
			60 setGusts 0;
			setWind [0, 0, true];
		};
		case('windy'): {
			60 setFog 0;
			60 setOvercast 0;
			60 setLightnings 0;
			60 setRain 0;
			60 setWaves 1;
			60 setGusts 1;
			setWind [8, 15, true];
		};
	};
},true] call Server_Setup_Compile;

["Server_Core_DblXP",
{
	if ((A3PL_Event_DblXP) == 1) then {
		[localize"STR_Various_DoubleXPON", "yellow"] remoteExec ["A3PL_Player_Notification",-2];
		A3PL_Event_DblXP = 2;
	} else {
		[localize"STR_Various_DoubleXPOFF", "yellow"] remoteExec ["A3PL_Player_Notification",-2];
		A3PL_Event_DblXP = 1;
	};
	publicVariable "A3PL_Event_DblXP";
},true] call Server_Setup_Compile;

/*["Server_Core_WhitelistServer",
{
 	private _unit = param [0,objNull];
 	private _uid = getPlayerUID _unit;
 	private _query = format ["SELECT COUNT(*) FROM whitelist WHERE uid = '%1'",_uid];
 	private _count = ([_query, 2] call Server_Database_Async) select 0;
 	if(_count isEqualTo 0) then {"removed" serverCommand format["#kick '%1'", _uid];};
},true] call Server_Setup_Compile;*/

["Server_Core_Locality",
{
	private _obj = _this select 0;
	private _player = _this select 1;
	if (!((owner _obj) == (owner _player))) then {_obj setOwner (owner _player);};
},true] call Server_Setup_Compile;

["Server_Core_Save",
{
	[] spawn Server_ShopStock_Save;
	sleep 10;
	[] spawn Server_Locker_Save;
	sleep 10;
	[] spawn Server_Police_SeizureSave;
	sleep 10;
	[] spawn Server_Fuel_Save;
},true] call Server_Setup_Compile;

["Server_Core_RestartTimer",
{
	["The server will restart in 1 hour","yellow"] remoteExec ["A3PL_Player_Notification", -2];
	sleep 900;
	["The server will restart in 45 minutes","yellow"] remoteExec ["A3PL_Player_Notification", -2];
	sleep 900;
	["The server will restart in 30 minutes","yellow"] remoteExec ["A3PL_Player_Notification", -2];
	sleep 600;
	["The server will restart in 20 minutes","yellow"] remoteExec ["A3PL_Player_Notification", -2];
	sleep 600;
	[] call Server_Core_Restart;
},true] call Server_Setup_Compile;
