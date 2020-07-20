/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#include "Server_Macro.hpp"
#define HOUSESLIST ["Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_Mansion01","Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_BostonHouse","Land_A3PL_Shed3","Land_A3PL_Shed4","Land_A3PL_Shed2","Land_John_House_Grey","Land_John_House_Blue","Land_John_House_Red","Land_John_House_Green","Land_A3FL_Mansion","Land_A3FL_Office_Building","Land_A3FL_House1_Cream","Land_A3FL_House1_Green","Land_A3FL_House1_Blue","Land_A3FL_House1_Brown","Land_A3FL_House1_Yellow","Land_A3FL_House2_Cream","Land_A3FL_House2_Green","Land_A3FL_House2_Blue","Land_A3FL_House2_Brown","Land_A3FL_House2_Yellow","Land_A3FL_House3_Cream","Land_A3FL_House3_Green","Land_A3FL_House3_Blue","Land_A3FL_House3_Brown","Land_A3FL_House3_Yellow","Land_A3FL_House4_Cream","Land_A3FL_House4_Green","Land_A3FL_House4_Blue","Land_A3FL_House4_Brown","Land_A3FL_House4_Yellow","Land_A3FL_Anton_Modern_Bungalow"]

diag_log "RUNNING SERVER INIT";

SewuTL926P8Gnm9YUKYnDNhPtReUZ7 = true;
publicVariable "SewuTL926P8Gnm9YUKYnDNhPtReUZ7";

[] spawn
{
	waitUntil {sleep 0.2; !isNil "A3PL_FilesSetup"};
	diag_log "A3PL_FilesSetup received";
	if (!hasInterface) then
	{
		sleep 4;
	};
	diag_log "Waiting for Server_Setup_Init";
	waitUntil {sleep 0.2; !isNil "Server_Setup_Init"};

	[] spawn Server_Setup_Init;
};

Server_Setup_Compile = {
	private _name = param [0,""];
	private _code = param [1,{}];
	private _forServer = param [2,false];
	private _compile = formatText ["%1 = %2;", _name, _code];
	if (isServer) then {
		call compile str(_compile);
	} else {
		call compileFinal str _compile;
	};
	if(_forServer isEqualTo false) then {
		publicVariable _name;
	};
};

//ALL THE COMPILE BLOCKS
['A3PL_ATM_Transfer', {
	private ['_amount', '_sendTo', '_sendToCompile', '_format','_companyTransfer'];

	_amount = round(parseNumber(ctrlText 5372));
	_companyTransfer = false;
	if([localize "STR_A3PLS_ATMTRANSFER_COMPANY", lbText [5472, (lbCurSel 5472)]] call BIS_fnc_inString) then {_companyTransfer = true;} else {_companyTransfer = false;};

	if (((lbCurSel 5472) == -1) || (_amount <= 0)) exitWith {
		[localize "STR_A3PLS_ATMTRANSFER_AMOUNTINVALID", "red"] call A3PL_Player_Notification;
	};

	if (!([_amount] call A3PL_Player_HasBank)) exitWith {
		[localize "STR_A3PLS_ATMTRANSFER_ENOUGNMONEYTRANSFER", "red"] call A3PL_Player_Notification;
	};

	//todo transfer notification
	[player, 'Player_Bank', ((player getVariable 'Player_Bank') - _amount)] remoteExec ['Server_Core_ChangeVar', 2];

	if(_companyTransfer) then {
		_cid = parseNumber(lbData [5472, (lbCurSel 5472)]);
		[_cid, _amount, format[localize "STR_A3PLS_ATMTRANSFER_TRANSFERFROM",name player]] remoteExec ["Server_Company_SetBank",2];
		_format = format[localize "STR_A3PLS_ATMTRANSFER_COMPANYTRANSFER", [_amount] call A3PL_Lib_FormatNumber];
	} else {
		_sendTo = lbData [5472, (lbCurSel 5472)];
		_sendToCompile = call compile _sendTo;
		if(isNull _sendToCompile) exitWith {_format = "Error: Unable to transfer";};
		_format = format[localize "STR_A3PLS_ATMTRANSFER_CIVILIANTRANSFER", [_amount] call A3PL_Lib_FormatNumber, (name _sendToCompile)];
		[format[localize "STR_A3PLS_ATMTRANSFER_RECEIVETRANSFER",_amount], "green"] remoteExec ["A3PL_Player_Notification",_sendToCompile];
		[_sendToCompile, 'Player_Bank', ((_sendToCompile getVariable 'Player_Bank') + _amount)] remoteExec ['Server_Core_ChangeVar', 2];
	};
	[_format, "green"] call A3PL_Player_Notification;
	[0] call A3PL_Lib_CloseDialog;
},false,true] call Server_Setup_Compile;

//Compile BLOCK warning
["A3PL_Debug_Execute", {

	private ["_display","_debugText","_chosenExecType","_remoteExecType","_compileRdy"];
	_bannedText = ["profileNamespace","saveProfileNamespace","fuckedS","files"];
	_display = findDisplay 155;
	_debugText = ctrlText 1400;
	_chosenExecType = lbText [2100,lbCurSel 2100];
	_remoteExecType = clientOwner;
	_forbidden = false;

	switch (_chosenExecType) do {
		case "Server": {_remoteExecType = 2};
		case "Global": {_remoteExecType = 0};
		case "All Clients": {_remoteExecType = -2};
		case "Local": {_remoteExecType = clientOwner};
		default {_remoteExecType = clientOwner};
	};

	{
		if((_debugText find _x) != -1) exitWith {_forbidden = true;};
	} forEach _bannedText;

	if(_forbidden) exitWith {};

	[_debugText] remoteExec ["A3PL_Debug_ExecuteCompiled",_remoteExecType];
	[player,"DebugExecuted",[format ["Debug: %1 Type: %2",_debugText]]] remoteExec ["Server_AdminLoginsert", 2];
},false,true] call Server_Setup_Compile;

["A3PL_Debug_ExecuteCompiled", {

	private ["_debugText"];
	_debugText = param [0,"Nothing"];
	if (_debugText == "Nothing") exitWith {};
	call compile _debugText;
},false,true] call Server_Setup_Compile;

["A3PL_Loading_Request", {
	[] spawn {
		private ["_waiting","_display","_control", '_format',"_pos"];
		disableSerialization;

		_display = findDisplay 15;

		_control = (_display displayCtrl 10359);
		_format = localize "STR_A3PLS_LOADINGREQUEST_SERVERFUNCTIONSRECEIVED";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.3;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>30%</t>";
		_control ctrlSetStructuredText (parseText _format);

		// Do not start doing any of this until we are in the game
		waitUntil {uiSleep 0.5; player == player};
		_pos = getpos player;
		uiSleep 1;

		//Send request to server to load player gear
		[player] remoteExec ["Server_Gear_Load", 2];

		_control = (_display displayCtrl 10359);
		_format = localize "STR_A3PLS_LOADINGREQUEST_RECEIVINGPLAYERGEAR";
		_control ctrlSetStructuredText (parseText _format);

		_waiting = 0;
		while {isNil "A3PL_RetrievedInventory"} do
		{
			uiSleep 1;
			_waiting = _waiting + 2;
			if (_waiting > 10) then
			{
				// send request again after 10sec of no reply
				[player] remoteExec ["Server_Gear_Load", 2];
				_waiting = 0;
			};
		};

		player setVariable ["Zipped",false,true];
		player setVariable ["picking",false,true];
		player setVariable ["working",false,true];
		player setVariable ["DoubleTapped",false,true];

		// use this sleep instead of this while in editor
		if (isServer) then {
			// uiSleep 2;
		} else
		{
			//If position is changed by the server we have loaded the gear
			while {_pos isEqualTo (getpos player)} do
			{
				uiSleep 0.4;
				_format = localize "STR_A3PLS_LOADINGREQUEST_RECEIVINGPLAYERGEAR1";
				_control ctrlSetStructuredText (parseText _format);
				uiSleep 0.4;
				_format = localize "STR_A3PLS_LOADINGREQUEST_RECEIVINGPLAYERGEAR2";
				_control ctrlSetStructuredText (parseText _format);
				uiSleep 0.4;
				_format = localize "STR_A3PLS_LOADINGREQUEST_RECEIVINGPLAYERGEAR3";
				_control ctrlSetStructuredText (parseText _format);
			};
		};

		//okay, we are out of the loop, lets set the markers for houses
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.4;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>40%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = localize "STR_A3PLS_LOADINGREQUEST_ASSIGNHOUSEAPPARTMENT";
		_control ctrlSetStructuredText (parseText _format);


		// Stats retrieved succesfully
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.5;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>50%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = localize "STR_A3PLS_LOADINGREQUEST_PLAYERGEARLOADED";
		_control ctrlSetStructuredText (parseText _format);

		// uiSleep 1;

		_format = localize "STR_A3PLS_LOADINGREQUEST_INITIALIZINGCURRENTVEHICLES";
		_control ctrlSetStructuredText (parseText _format);

		//Comment next line to disable all client vehicle inits from config (might help in debugging lag etc)
		A3PL_Vehicle_HandleInitU = toArray (format ["%1",A3PL_Vehicle_HandleInitU]);
		A3PL_Vehicle_HandleInitU deleteAt 0;
		A3PL_Vehicle_HandleInitU deleteAt ((count A3PL_Vehicle_HandleInitU) - 1);
		A3PL_Vehicle_HandleInitU = toString A3PL_Vehicle_HandleInitU;
		A3PL_HandleVehicleInit = compileFinal A3PL_Vehicle_HandleInitU;

		// uiSleep 2;

		// Vehicles loaded
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.9;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>70%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = localize "STR_A3PLS_LOADINGREQUEST_VEHICLESINITIALIZEDSUCCESFULLY";
		_control ctrlSetStructuredText (parseText _format);

		// uiSleep 2;

		call A3PL_Medical_Init;
		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>80%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = localize "STR_A3PLS_LOADINGREQUEST_MEDICALSYSTEMINITIALIZED";
		_control ctrlSetStructuredText (parseText _format);

		// uiSleep 1;

		//Once done loading everything lets closeDialog
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 1;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>100%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = localize "STR_A3PLS_LOADINGREQUEST_PLAYERINITIALIZEDSUCCESFULLY";
		_control ctrlSetStructuredText (parseText _format);

		// uiSleep 1;

		_display displayRemoveEventHandler ["KeyDown", noEscape];

		[0] call A3PL_Lib_CloseDialog;

		player setVariable ["tf_voiceVolume", 1, true];
		cutText["","BLACK IN"];

		//load the admins
		call A3PL_Admin_Check;

		player enableSimulation true;
		player setvariable ["FinishedLoading",true,true];
		showChat false;
	};
},false,true] call Server_Setup_Compile;

["Server_Setup_Init",
{
	ASAGNDJSN = true;
	publicVariable "ASAGNDJSN";

	waitUntil {(isNil 'A3PL_FilesSetup') isEqualTo false};

	//setup database
	call Server_Setup_SetupDatabase;
	waitUntil {(isNil 'A3PL_DatabaseSetup') isEqualTo false};
	Server_Setup_SetupDatabase = Nil;

	//setup server variables
	call Server_Core_Variables;

	//Setup 'HandleDisconnect' missionEventHandler (located in Server_Gear)
	call Server_Gear_HandleDisconnect;

	//Call the initial server storage
	call Server_Storage_Init;

	//Temporary Hotfix
	//all this crap runs into post-init
	[] spawn {
		waitUntil {!isNil "npc_bank"};
		call Server_Addresses_Setup;
		call Server_Housing_Initialize;
		call Server_Warehouses_Initialize;

		call Server_Criminal_BlackMarketPos;
		call Server_JobFarming_DrugDealerPos;
		[] spawn Server_JobWildcat_RandomizeOil;
		[] spawn Server_JobWildcat_RandomizeRes;
		call Server_Core_GetDefVehicles;				//create the defaulte vehicles array (for use in cleanup script)
		call Server_JobPicking_Init;					//get the marker locations for picking locations
		[] spawn Server_Lumber_TreeRespawn;				//spawn trees for lumberyacking

		//load stock values
		// [] spawn Server_ShopStock_Load;
		[] spawn Server_Locker_Load;
	};

	call Server_IE_Init;
	call Server_Setup_ResetPlayerDB;
	[] spawn Server_TrafficLights_Start;

	/*iPhoneX*/
	A3PL_iPhoneX_ListNumber = [];
	A3PL_iPhoneX_switchboard = [];
	call Server_iPhoneX_GetPhoneNumber;

	/*Get All FuelStations*/
	private _FuelPositions = [
		[11293.7,9040.11,0],	//Weapons Factory
		[10228.2,8490.94,0],	//Northdale
		[6173.09,7419.18,0],	//Elk City
		[4165.8,6170.87,0],		//Beach Valley
		[3435.99,7519.7,0],		//Stoney Creek
		[2851.2,5555.24,0],		//Silverton Bella
		[2413.74,5496.1,0],		//Silverton Impound
		[2123,11725,0],		//Lubbock
		[3219,12274,0] // Salt Point
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

	["itemAdd", ["Server_PoliceLoop", { call Server_Police_JailLoop; }, 60]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_Fishing", {call Server_fisherman_loop;}, 45]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_BlackMarket", {call Server_Criminal_BlackMarketPos;}, 1200]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_BlackMarketNear", {call Server_Criminal_BlackMarketNear;}, 60]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_DealerPos", {call Server_JobFarming_DrugDealerPos;}, 1200]] call BIS_fnc_loop;
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

	["itemAdd", ["Server_Loop_TurtlesMove", {[] spawn Server_Criminal_TurtlesMove;}, 3600]] call BIS_fnc_loop;

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

	call Server_Company_LoadAll;
	call Server_Police_SeizureLoad;
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

	A3PL_Event_DblHarvest = 1;
	publicVariable "A3PL_Event_DblHarvest";

	A3PL_Event_Paycheck = 1;
	publicVariable "A3PL_Event_Paycheck";

	A3PL_Event_CrimePayout = 1;
	publicVariable "A3PL_Event_CrimePayout";

	Server_AllBusStops = nearestObjects [[6420.21,7001.08,0], ["Land_A3PL_BusStop"], 5000, false];
},true,true] call Server_Setup_Compile;

['Server_Database_ToArray', {
	private["_array"];
	_array = [_this,0,"",[""]] call BIS_fnc_param;
	if(_array == "") exitWith {[]};
	_array = toArray(_array);

	for "_i" from 0 to (count _array)-1 do
	{
		_sel = _array select _i;
		if(_sel == 96) then
		{
			_array set[_i,39];
		};
	};

	_array = toString(_array);
	_array = call compile format["%1", _array];
	_array;
},true,true] call Server_Setup_Compile;

['Server_Database_Setup', {
    private ['_database', '_protocol', '_protocolOptions', '_return', '_result', '_randomNumber', '_extDBCustomID'];

    _database = [_this,0,"",[""]] call BIS_fnc_param;
    _protocol = [_this,1,"",[""]] call BIS_fnc_param;
    _protocolOptions = [_this,2,"",[""]] call BIS_fnc_param;
    _return = false;

    if ( isNil {uiNamespace getVariable "extDBCustomID"} ) then {
            // extDB Version
            _result = "extDB3" callExtension "9:VERSION";

            diag_log format ["extDB3: Version: %1", _result];

            if(_result == "") exitWith {diag_log "extDB3: Failed to Load"; false};
            //if ((parseNumber _result) < 20) exitWith {diag_log "Error: extDB version 20 or Higher Required";};

            // extDB Connect to Database
            _result = call compile ("extDB3" callExtension format["9:ADD_DATABASE:%1", _database]);

            if (_result select 0 isEqualTo 0) exitWith {
                    diag_log format ["extDB3: Error Database: %1", _result];
                    false
            };

            diag_log "extDB3: Connected to Database";

            // Generate Randomized Protocol Name
            _randomNumber = round(random(999999));
            _extDBCustomID = str(_randomNumber);

            extDBCustomID = compileFinal _extDBCustomID;

            // extDB Load Protocol
            _result = call compile ("extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%1:%2:%3:%4", _database, _protocol, _extDBCustomID, _protocolOptions]);

            if ((_result select 0) isEqualTo 0) exitWith {
                    diag_log format ["extDB3: Error Database Setup: %1", _result];
                    false
            };

            diag_log format ["extDB3: Initalized %1 Protocol", _protocol];

            // Save Randomized ID
            uiNamespace setVariable ["extDBCustomID", _extDBCustomID];

            _return = true;
    }
    else {
            extDBCustomID = compileFinal str(uiNamespace getVariable "extDBCustomID");

            diag_log "extDB3: Already Setup";

            _return = true;
    };
    _return
}, true, true] call Server_Setup_Compile;

['Server_Database_Async', {
	params [["_queryStmt","",[""]],["_mode",1,[0]],["_multiarr",false,[false]]];
	private _key = "extDB3" callExtension format["%1:%2:%3", _mode, (call extDBCustomID), _queryStmt];

	if(EQUAL(_mode,1)) exitWith {true};

	_key = call compile format["%1",_key];
	_key = SEL(_key,1);
	_queryResult = "";
	_loop = true;
	while{_loop} do {
		_queryResult = EXTDB format["4:%1", _key];
		if (EQUAL(_queryResult,"[5]")) then {
			_queryResult = "";
			while{true} do {
				_pipe = EXTDB format["5:%1", _key];
				if(_pipe == "") exitWith {_loop = false};
				_queryResult = _queryResult + _pipe;
			};
		} else {
			if (EQUAL(_queryResult,"[3]")) then {
			} else {
				_loop = false;
			};
		};
	};
	_queryResult = call compile _queryResult;
	if(EQUAL(SEL(_queryResult,0),0)) exitWith {diag_log format ["extDB3: Protocol Error: %1", _queryResult]; []};
	_return = SEL(_queryResult,1);
	if(!_multiarr && count _return > 0) then {
		_return = SEL(_return,0);
	};
	_return;
}, true, true] call Server_Setup_Compile;

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

//COMPILE BLOCK WARNING
["Server_Gear_Load", {
	private ["_unit", "_uid", "_return", "_query", "_pos", "_loadout","_name","_houseVar","_warehouseObj","_warehouseVar","_ownsHouse","_houseObj","_facStorage","_licenses","_perks","_ship","_allKeys"];
	_unit = _this select 0;
	_uid = getPlayerUID _unit;

	// Perform a query with all the information
	_query = format ["SELECT
		id, name, dob, gender, pasportdate,
		cash, bank, paycheck,
		faction, job,
		loadout, virtualinv, f_storage, licenses, userkey,
		level, xp,
		medstats,
		position,
		ship,
		perks,
		jail,
		adminLevel, adminPerms, adminWatch
		FROM players WHERE uid='%1'"
	, _uid];
	_return = [_query, 2] call Server_Database_Async;

	if (count _return == 0) exitwith
	{
		[_unit,true] call Server_Gear_New;
	};

	_name = _return select 1;
	if (_name == "") exitwith
	{
		[_unit,false] call Server_Gear_New;
	};

	//Set position to last known pos, can be [0,0,0] if server has restarted
	_pos = call compile (_return select 18);
	_unit setpos _pos;

	//Set the units db_id
	_unit setVariable ["db_id",_return select 0,true];

	// Set name on the player
	_unit setVariable ["name",_name,true];

	//DOB
	_unit setVariable ["dob",_return select 2,true];

	//Set gender on the player
	_unit setVariable ["gender",_return select 3,true];

	//Join Date
	_unit setVariable ["date",_return select 4,true];

	//Set money
	_unit setVariable ["Player_Cash",_return select 5,true];
	_unit setVariable ["Player_Bank",_return select 6,true];

	//Set faction
	_unit setVariable ["faction",_return select 8,true];
	//Set the job
	_unit setVariable ["job",_return select 9,true];

	//Load player inv and add them
	_loadout = [(_return select 10)] call Server_Database_ToArray;
	_unit setUnitLoadout _loadout;
	_virtinv = [(_return select 11)] call Server_Database_ToArray;
	_facStorage = [(_return select 12)] call Server_Database_ToArray;
	_unit setVariable ["player_inventory",_virtinv,true];
	_unit setVariable ["player_fstorage",_facStorage,true];

	//Set Licenses
	_licenses = [(_return select 13)] call Server_Database_ToArray;
	_unit setVariable ["licenses",_licenses,true];

	//Set medical vars
	_medStat = [(_return select 17)] call Server_Database_ToArray;
	_unit setVariable ["A3PL_Wounds",_medStat select 0,true];
	_unit setVariable ["A3PL_MedicalVars",_medStat select 1,true];

	//Set perks - PA$$ION
	_perks = [(_return select 20)] call Server_Database_ToArray;
	_unit setVariable ["perks",_perks,true];

	//Set level system vars
	_unit setVariable ["Player_Level",_return select 15,true];
	_unit setVariable ["Player_XP",_return select 16,true];

	//Give keys to player
	_keys = [(_return select 14)] call Server_Database_ToArray;
	_unit setVariable ["keys",_keys,true];

	//Set import-export
	_ship = [(_return select 19)] call Server_Database_ToArray;
	_unit setVariable ["player_importing",(_ship select 0),true];
	_unit setVariable ["player_exporting",(_ship select 1),true];

	//Set Admin Variables
	_unit setVariable ["dbVar_AdminLevel",_return select 22,true];
	_unit setVariable ["dbVar_AdminPerms",[(_return select 23)] call Server_Database_ToArray,true];
	_unit setVariable ["adminWatch",_return select 24,true];

	//Set paycheck
	_paycheck = _return select 7;
	[_paycheck] remoteExec ["A3PL_Player_SetPaycheck",_unit];

	//Fixed Vars
	_unit setVariable ["twitterprofile",
		'["\A3PL_Common\icons\citizen.paa","#ed7202","#B5B5B5",[["\A3PL_Common\icons\citizen.paa","Citizen"]],[["#ed7202","Citizen"]],[["#B5B5B5","Default"]]]',
		true
	];
	_unit setVariable ["Cuffed",false,true];

	//Gang system init
	[_unit] spawn Server_Gang_Load;

	//Scan if player owns a house, if not we will assign him an appartment
	//Make sure to re-init, just in case
	call Server_Housing_Initialize;
	call Server_Warehouses_Initialize;

	_ownsHouse = false;
	{
		_houseVar = _x getVariable ["owner",[]];
		if (_uid IN (_houseVar)) exitwith
		{
			_ownsHouse = true;
			_houseObj = _x;

			//give the key to the player if he doesn't have it
			_doorID = (_houseObj getVariable "doorid") select 1;
			if (!(_doorID IN _keys)) then {
				_allKeys = _unit getVariable["keys",[]];
				_allKeys pushBack _doorID;
				_unit setVariable ["keys",_allKeys,true];
			};
		};
	} foreach Server_HouseList;

	_ownsWarehouse = false;
	{
		_warehouseVar = _x getVariable ["owner",[]];
		if (_uid IN (_warehouseVar)) exitwith
		{
			_ownsWarehouse = true;
			_warehouseObj = _x;
			diag_log "owns a warehouse";

			//give the key to the player if he doesn't have it
			_doorID = (_warehouseObj getVariable "doorid") select 1;
			diag_log format ["key ID %1",_doorID];
			if (!(_doorID IN _keys)) then {
				_allKeys = _unit getVariable["keys",[]];
				_allKeys pushBack _doorID;
				diag_log format ["allKeys %1",_allKeys];
				_unit setVariable ["keys",_allKeys,true];
			};
		};
	} foreach Server_WarehouseList;

	if (!_ownsHouse) then
	{
		[_unit] call Server_Housing_AssignApt;
	} else
	{
		//setpos to house position
		if ([[0,0,0],_pos] call BIS_fnc_areEqual) then
		{
			//for some houses we need to set the player position a bit higher
			switch (typeOf _houseObj) do
			{
				case ("Land_Mansion01"): { _unit setpos [(getpos _houseObj select 0),(getpos _houseObj select 1),1]; };
				case default { _unit setpos (getpos _houseObj); };
			};
		};
		//set house var
		_unit setVariable ["house",_houseObj,true];

		//load items
		_firstOwner = (_houseObj getVariable ["owner",[]]) select 0;
		if(_firstOwner isEqualTo _uid) then {
			[_unit,_houseObj,_uid] call Server_Housing_LoadItems;
		};
	};
	if(_ownsWarehouse) then {
	_unit setVariable ["warehouse",_warehouseObj,true];
	_firstOwnerWarehouse = (_warehouseObj getVariable ["owner",[]]) select 0;
	if(_firstOwnerWarehouse isEqualTo _uid) then {
			diag_log "calling loadItems";
			[_unit,_warehouseObj,_uid] call Server_Warehouses_LoadItems;
		};
	};

	if ((!([[0,0,0],_pos] call BIS_fnc_areEqual)) && (!(_ownsHouse))) then //if our position is not [0,0,0] and we have an apartment
	{
		private ["_near"];
		_near = nearestObjects [_pos, ["Land_A3PL_Motel"], 14];
		if (count _near > 0) then
		{
			//still set the player to the apartment position since he spawned (close) back into an apartment
			[_unit] call Server_Housing_SetPosApt;
		};
	};

	//change 0,0,0 with whatever we set on server start later
	if (([[0,0,0],_pos] call BIS_fnc_areEqual) && (!(_ownsHouse))) then
	{
		[_unit] call Server_Housing_SetPosApt;
	};

	_jailTime = (_return select 21);
	if(_jailTime > 0) then
	{
		_unit setPos [4795.31,6313.62,0];
		[_jailTime, _unit] call Server_Police_JailPlayer;
	};

	(owner _unit) publicVariableClient "A3PL_RetrievedInventory";

	//Enterprise number for jobs
	if((_return select 9) IN ["fifr","uscg","fisd"]) then {
		[(_return select 9)] remoteExec["A3PL_iPhoneX_SetJobNumber",_unit];
	};

	//Load Bills
	[_unit] remoteExec ["Server_Company_LoadBills",2];

	//Load Gang System
	[_unit] call Server_Gang_Load;

	//Load Vehicles
	_vehKeys = missionNamespace getVariable [format ["%1_KEYS",_uid],[]];
	[_vehKeys] remoteExec["A3PL_Vehicle_SetAllKeys",_unit];

	//Markers
	[] remoteExec ["A3PL_Player_SetMarkers",_unit];

	_query = format ["SELECT phone_number FROM iphone_phone_numbers WHERE player_id='%1'", getPlayerUID _unit];
	_result = [_query,2] call Server_Database_Async;
	if(count(_result) isEqualTo 0) then {
		[_unit] call Server_iPhoneX_GrantNumber;
	};
}, true,true] call Server_Setup_Compile;

["Server_Housing_Initialize",
{
	private ["_houses","_query","_return","_uids","_pos","_doorID","_near","_signs"];
	_houses = ["SELECT uids, location, doorid FROM houses", 2, true] call Server_Database_Async;
	{
		private ["_pos","_uids","_doorid"];
		_uids = [(_x select 0)] call Server_Database_ToArray;
		_pos = call compile (_x select 1);
		_doorid = _x select 2;

		_near = nearestObjects [_pos, HOUSESLIST, 10,true];
		if (count _near == 0) exitwith
		{
			_query = format ["CALL RemovedHouse('%1');",_pos];
			[_query,1] spawn Server_Database_Async;
		};
		_near = _near select 0;
		if (!([_pos,(getpos _near)] call BIS_fnc_areEqual)) then
		{
			_query = format ["UPDATE houses SET location='%1', classname = '%3' WHERE location ='%2'",(getpos _near),_pos, (typeOf _near)];
			[_query,1] spawn Server_Database_Async;
		};

		_signs = nearestObjects [_pos, ["Land_A3PL_EstateSign"], 25,true];
		if (count _signs > 0) then
		{
		    (_signs select 0) setObjectTextureGlobal [0,"\A3PL_Objects\Street\estate_sign\house_rented_co.paa"];
		    (_signs select 0) setVariable["roommates",_uids,true];
		};

		_near setVariable ["doorID",[_uids,_doorid],true];
		_near setVariable ["owner",_uids, true];
		Server_HouseList pushback _near;
	} foreach _houses;
},true,true] call Server_Setup_Compile;

["Server_Housing_LoadItems",
{
	private _player = param [0,objNull];
	private _house = param [1,objNull];
	private _uid = param [2,""];
	if (_house getVariable ["furn_loaded",false]) exitwith {};
	_house setVariable ["furn_loaded",true,false];
	private _pitems = [format ["SELECT pitems FROM houses WHERE location = '%1'",(getpos _house)], 2] call Server_Database_Async;
	_pitems = call compile (_pitems select 0);
	[_house,_pitems] remoteExec ["A3PL_Housing_Loaditems", (owner _player)];
},true] call Server_Setup_Compile;

["Server_Housing_LoadBox",
{
	private ["_house","_player","_pos","_items","_box","_weapons","_magazines","_items","_vitems","_cargoItems","_actualitems"];
	_player = param [0,objNull];
	_house = param [1,objNull];
	_pos = getposATL _player;
	if (!isNil {_house getVariable "box_spawned"}) exitwith {};
	//set variable that disables the box to be spawned again
	_house setVariable ["box_spawned",true,false];

	if (isDedicated) then { _items = [format ["SELECT items,vitems FROM houses WHERE location = '%1'",(getpos _house)], 2, true] call Server_Database_Async;} else {_items = [[],[],[]];};
	_box = createVehicle ["Box_GEN_Equip_F",_pos, [], 0, "CAN_COLLIDE"]; //replace with custom ammo box later
	clearItemCargoGlobal _box; //temp until custom ammo box
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearBackpackCargoGlobal _box;

	//According to how stuff is saved into db
	_cargoItems = call compile ((_items select 0) select 0);
	_vitems = call compile ((_items select 0) select 1);
	_weapons = _cargoItems select 0;
	_magazines = _cargoItems select 1;
	_actualitems = _cargoItems select 2;
	_backpacks = _cargoItems select 3;

	{_box addWeaponCargoGlobal [_x,1]} foreach _weapons;
	{_box addMagazineCargoGlobal [_x,1]} foreach _magazines;
	{_box addItemCargoGlobal [_x,1]} foreach _actualitems;
	{_box addBackpackCargoGlobal [_x,1]} foreach _backpacks;
	_box setVariable ["storage",_vitems,true];
},true] call Server_Setup_Compile;


//Initialize houses, assign all doorIDs, on server start
//COMPILE BLOCK WARNING
["Server_Warehouses_Initialize",
{
	private ["_warehouses","_query","_return","_uid","_pos","_doorID","_near","_signs"];
	//also make sure to update _obj location if it's changed (just incase we move anything slightly with terrain builder), delete it if it cannot be found nearby
	_warehouses = ["SELECT uids,location,doorid FROM warehouses", 2, true] call Server_Database_Async;
	{
		private ["_pos","_uids","_doorid"];
		_uids = [(_x select 0)] call Server_Database_ToArray;
		_pos = call compile (_x select 1);
		_doorid = _x select 2;

		_near = nearestObjects [_pos, ["Land_John_Hangar","Land_A3FL_Warehouse"], 10,true];
		if (count _near == 0) exitwith
		{
			/*_query = format ["CALL RemovedHouse('%1');",_pos];
			[_query,1] spawn Server_Database_Async;*/
		};
		_near = _near select 0;
		if (!([_pos,(getpos _near)] call BIS_fnc_areEqual)) then
		{
			//Update position in DB
			_query = format ["UPDATE warehouses SET location='%1', classname = '%3' WHERE location ='%2'",(getpos _near),_pos, (typeOf _near)];
			[_query,1] spawn Server_Database_Async;
		};

		//look for nearest for sale sign and set the texture to sold
		_signs = nearestObjects [_pos, ["Land_A3PL_BusinessSign"], 25,true];
		if (count _signs > 0) then
		{
			(_signs select 0) setObjectTextureGlobal [0,"\A3PL_Objects\Street\business_sign\business_rented_co.paa"];
		};

		//Set Variables
		_near setVariable ["doorID",[_uids,_doorid],true];
		_near setVariable ["owner",_uids,true];
		Server_WarehouseList pushback _near;
	} foreach _warehouses;
	publicVariable "Server_WarehouseList";
},true,true] call Server_Setup_Compile;

//Compile block warning
["Server_Warehouses_LoadBox",
{
	private ["_warehouse","_player","_pos","_items","_box","_weapons","_magazines","_items","_vitems","_cargoItems","_actualitems"];
	_player = param [0,objNull];
	_warehouse = param [1,objNull];
	_pos = getposATL _player;
	if (!isNil {_warehouse getVariable "box_spawned"}) exitwith {};
	//set variable that disables the box to be spawned again
	_warehouse setVariable ["box_spawned",true,false];

	if (isDedicated) then { _items = [format ["SELECT items,vitems FROM warehouses WHERE location = '%1'",(getpos _warehouse)], 2, true] call Server_Database_Async;} else {_items = [[],[],[]];};
	_box = createVehicle ["Box_GEN_Equip_F",_pos, [], 0, "CAN_COLLIDE"]; //replace with custom ammo box later
	clearItemCargoGlobal _box; //temp until custom ammo box
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearBackpackCargoGlobal _box;

	//According to how stuff is saved into db
	_cargoItems = call compile ((_items select 0) select 0);
	_vitems = call compile ((_items select 0) select 1);
	_weapons = _cargoItems select 0;
	_magazines = _cargoItems select 1;
	_actualitems = _cargoItems select 2;
	_backpacks = _cargoItems select 3;

	//add items [["srifle_EBR_F"],[],[]]
	{_box addWeaponCargoGlobal [_x,1]} foreach _weapons;
	{_box addMagazineCargoGlobal [_x,1]} foreach _magazines;
	{_box addItemCargoGlobal [_x,1]} foreach _actualitems;
	{_box addBackpackCargoGlobal [_x,1]} foreach _backpacks;
	_box setVariable ["storage",_vitems,true];
},true] call Server_Setup_Compile;

["Server_Warehouses_LoadItems",
{
	private ["_warehouse","_player","_uid","_pitems"];
	_player = param [0,objNull];
	_warehouse = param [1,objNull];
	_uid = param [2,""];

	diag_log "In LoadItems";

	//set furn loaded to true
	if (_warehouse getVariable ["furn_loaded",false]) exitwith {};
	_warehouse setVariable ["furn_loaded",true,false];

	_pitems = [format ["SELECT pitems FROM warehouses WHERE location = '%1'",(getpos _warehouse)], 2] call Server_Database_Async;
	_pitems = call compile (_pitems select 0);

		diag_log format ["_pitems %1",_pitems];

	[_warehouse,_pitems] remoteExec ["A3PL_Warehouse_Loaditems", (owner _player)];
},true] call Server_Setup_Compile;

["A3PL_CCTV_SetCamera",
{
	private ["_camNum","_mapCam","_camera"];
	_camNum = param [0,1];
	_mapCam = A3PL_CCTV_ALL select (param [1,0]); //the actual camera object placed on the map
	_camera = call compile format ["A3PL_CCTV_CAMOBJ_%1",_camNum];

	_camera attachto [_mapCam,(_mapCam selectionPosition "cam_pos")];
	_camera CamSetTarget (_mapCam modelToWorld (_mapCam selectionPosition "cam_dir"));
	_camera camCommit 0;
},false,true] call Server_Setup_Compile;
