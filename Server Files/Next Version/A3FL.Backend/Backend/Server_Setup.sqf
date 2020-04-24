["Server_Setup_SetupDatabase",
{
	["Database", "SQL", "TEXT2"] call Server_Database_Setup;
	"extDB3" callExtension "9:LOCK";
	A3PL_DatabaseSetup = true;
},true] call Server_Setup_Compile;

["Server_Setup_ResetPlayerDB",
{
	private _query = "UPDATE players SET position = '[0,0,0]',job = 'unemployed'";
	private _query2 = "UPDATE objects SET impounded = '2' WHERE impounded = '3'";
	private _query3 = "UPDATE objects SET stolen = '0' WHERE stolen = '1'";
	private _query4 = "UPDATE objects SET numpchange = '0' WHERE numpchange = '1'";
	private _query5 = "DELETE FROM iphone_messages WHERE to_num = '911'";
	[_query, 1] call Server_Database_Async;
	[_query2, 1] call Server_Database_Async;
	[_query3, 1] call Server_Database_Async;
	[_query4, 1] call Server_Database_Async;
	[_query5, 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

//COMPILE BLOCK WARNING, COPY OF THIS IN fn_preinit.sqf
["Server_Setup_Init",
{
	ASAGNDJSN = true;
	publicVariable "ASAGNDJSN";

	waitUntil {(isNil 'A3PL_FilesSetup') isEqualTo false};

	//setup database
	[] call Server_Setup_SetupDatabase;
	waitUntil {(isNil 'A3PL_DatabaseSetup') isEqualTo false};
	Server_Setup_SetupDatabase = Nil;

	//setup server variables
	[] call Server_Core_Variables;

	//Setup 'HandleDisconnect' missionEventHandler (located in Server_Gear)
	[] call Server_Gear_HandleDisconnect;

	//Call the initial server storage
	[] call Server_Storage_Init;

	//Temporary Hotfix
	//all this crap runs into post-init
	[] spawn {
		waitUntil {!isNil "npc_bank"};
		[] call Server_Addresses_Setup;
		[] call Server_Housing_Initialize;

		[] call Server_Criminal_BlackMarketPos;
		[] call Server_JobFarming_DrugDealerPos;
		[] spawn Server_JobWildcat_RandomizeOil;
		[] spawn Server_JobWildcat_RandomizeRes;
		[] call Server_Core_GetDefVehicles;				//create the defaulte vehicles array (for use in cleanup script)
		[] call Server_JobPicking_Init;					//get the marker locations for picking locations
		[] spawn Server_Lumber_TreeRespawn;				//spawn trees for lumberyacking

		//load stock values
		[] spawn Server_ShopStock_Load;
		[] spawn Server_Locker_Load;
	};

	[] call Server_IE_Init;
	[] call Server_Setup_ResetPlayerDB;
	[] spawn Server_TrafficLights_Start;

	/*iPhoneX*/
	A3PL_iPhoneX_ListNumber = [];
	A3PL_iPhoneX_switchboard = [];
	[] call Server_iPhoneX_GetPhoneNumber;

	/*Get All FuelStations*/
	private _FuelPositions = [
		[11293.7,9040.11,0],	//Weapons Factory
		[10228.2,8490.94,0],	//Northdale
		[6173.09,7419.18,0],	//Elk City
		[4165.8,6170.87,0],		//Beach Valley
		[3435.99,7519.7,0],		//Stoney Creek
		[2851.2,5555.24,0],		//Silverton Bella
		[2413.74,5496.1,0],		//Silverton Impound
		[9842.12,7973.37,0]		//Deadwood
	];
	FuelStations = [];
	{
		_tank = nearestObject [_x,"Land_A3PL_Gas_Station"];
		FuelStations pushBack _tank;
	} foreach _FuelPositions;
	publicVariable "FuelStations";
	[] spawn Server_Fuel_Load;

	//Spawn Crane Right Import Export
	private _craneright = createVehicle ["A3PL_MobileCrane", [3693.044,7625.027,39.260], [], 0, "CAN_COLLIDE"];
	_craneright setDir 52.482;
	_craneright setFuel 0;

	//Spawn Crane Left Import Export
	private _craneleft = createVehicle ["A3PL_MobileCrane", [3659.797,7681.037,37.850], [], 0, "CAN_COLLIDE"];
	_craneleft setDir 232.025;
	_craneleft setFuel 0;

	["itemAdd", ["Server_PoliceLoop", { [] call Server_Police_JailLoop; }, 60]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_Fishing", {[] call Server_fisherman_loop;}, 45]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_BlackMarket", {[] call Server_Criminal_BlackMarketPos;}, 1200]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_BlackMarketNear", {[] call Server_Criminal_BlackMarketNear;}, 60]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_DealerPos", {[] call Server_JobFarming_DrugDealerPos;}, 1200]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_RepairTerrain", {[] spawn Server_Core_RepairTerrain;}, 600]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_BusinessLoop", {[] spawn Server_Business_Loop;}, 60]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_OilRandomization", {[] spawn Server_JobWildcat_RandomizeOil;}, 3600]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_ResRandomization", {[] spawn Server_JobWildcat_RandomizeRes;}, 3600]] call BIS_fnc_loop;

	//cleanup
	["itemAdd", ["Server_Loop_Cleanup", {[] spawn Server_Core_Clean;}, 900]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_Weather", {[] spawn Server_Core_Weather;}, 1200]] call BIS_fnc_loop;

	//Fire
	["itemAdd", ["Server_Fire_FireLoop", {[] spawn Server_Fire_FireLoop;}, 15]] call BIS_fnc_loop;

	//bus stops
	["itemAdd", ["Server_Lib_AnimBusStop", {[] spawn A3PL_Lib_AnimBusStop;}, 120]] call BIS_fnc_loop;

	//Picking loop
	["itemAdd", ["Server_Loop_Picking", {[] spawn Server_JobPicking_Loop;}, 15]] call BIS_fnc_loop;

	// Mushroom picking loop
	["itemAdd", ["Server_Loop_ShroomPicking", {[] spawn Server_Shrooms_Loop;}, 60]] call BIS_fnc_loop;

	// Mushroom area moving - every 2 hours
	["itemAdd", ["Server_Loop_ShroomMove", {[] spawn Server_Shrooms_MoveMarker;}, 7200]] call BIS_fnc_loop;

	//tree respawn for lumberyack
	["itemAdd", ["Server_Loop_TreeRespawn", {[] spawn Server_Lumber_TreeRespawn;}, 1800]] call BIS_fnc_loop;

	//loop for import_export
	["itemAdd", ["Server_Loop_IE", {[] spawn Server_IE_ShipImport;}, 2100]] call BIS_fnc_loop;

	//loop for animals
	["itemAdd", ["Server_Loop_Hunting",{[] spawn Server_Hunting_HandleLoop;}, 90]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_Save",{[] spawn Server_Core_Save;}, 1800]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_RestartAnnoucement",{[] spawn Server_Core_RestartLoop;}, 60]] call BIS_fnc_loop;

	//lastly load all the persistent vars from database
	private _pVars = ["SELECT * FROM persistent_vars", 2, true] call Server_Database_Async;
	{
		private _compile = formatText ['%1 = %2;',(_x select 0),([(_x select 1)] call Server_Database_ToArray)];
		call compile str(_compile);
		if ((_x select 2) == 1) then {
			publicVariable (_x select 0);
		};
	} foreach _pVars;

	[] call Server_Company_LoadAll;
	[] call Server_Police_SeizureLoad;
	[] spawn Server_Gear_SaveLoop;

	//check addons
	Server_ModVersion = getNumber (configFile >> "CfgPatches" >> "A3PL_Common" >> "requiredVersion");
	publicVariable "Server_ModVersion";

	//Tell clients that server is setup
	A3PL_ServerLoaded = true;
	publicVariable "A3PL_ServerLoaded";

	A3PL_FD_Clinic = true;
	publicVariable "A3PL_FD_Clinic";

	A3PL_Event_DblXP = 1;
	publicVariable "A3PL_Event_DblXP";

	Server_AllBusStops = nearestObjects [[6420.21,7001.08,0], ["Land_A3PL_BusStop"], 5000, false];
},true,true] call Server_Setup_Compile;
