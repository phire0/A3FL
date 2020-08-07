/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

// Load the physical A3 inventory + pos and add them remotely, once finished send message to client!
["Server_Gear_New", {
	private _unit = _this select 0;
	private _newEntry = _this select 1;

	//Assign default gear
	_unit addUniform "U_C_Poloshirt_salmon";
	_unit addItem "A3PL_Cellphone";
	_unit linkItem "ItemGPS";
	//Tell players his gear is loaded, because there is nothing to load
	(owner _unit) publicVariableClient "A3PL_RetrievedInventory";

	//Lets make a new entry for this UID
	if (_newEntry) then
	{
		_query = format ["INSERT INTO players (uid) VALUES ('%1')",(getPlayerUID _unit)];
		[_query,1] call Server_Database_Async;
	};

	//Lets tell the player he needs to enter a new name
	[] remoteExec ["A3PL_Player_NewPlayer",_unit];

	//set keys to nothing so we can assign a house
	_unit setVariable ["keys",[],true];

	[_unit] call Server_Housing_AssignApt;
	[_unit] call Server_Housing_SetPosApt;
},true] call Server_Setup_Compile;

["Server_Gear_NewReceive", {
	private ["_unit","_uid","_name","_query","_return","_sex","_dob"];
	_unit = _this select 0;
	_uid = getPlayerUID _unit;
	_name = _this select 1;
	_sex = _this select 3;
	_dob = _this select 4;

	//check name
	_query = format ["SELECT name FROM players WHERE name='%1'", _name];
	_return = [_query, 2] call Server_Database_Async;
	if (count _return > 0) exitwith
	{
		[] remoteExec ["A3PL_Player_NewPlayer",_unit];
	};

	//Set name, default faction and no keys
	_unit setVariable ["name",_name,true];
	_unit setVariable ["gender",_sex,true];
	_unit setVariable ["job","unemployed",true];
	_unit setVariable ["faction","citizen",true];
	_unit setVariable ["Player_Cash",200,true];
	_unit setVariable ["Player_Bank",500,true];
	_unit setVariable ["Player_Level",0,true];
	_unit setVariable ["Player_XP",0,true];
	_unit setVariable ["Player_Inventory",[],true];
	_unit setVariable ["Cuffed",false,true];

	[_unit,"burger_full_cooked",10] call Server_Inventory_Add;
	[_unit,"coke",10] call Server_Inventory_Add;
	[_unit,"repairwrench",3] call Server_Inventory_Add;
	[_unit,"med_bandage",3] call Server_Inventory_Add;
	[_unit,"med_icepack",2] call Server_Inventory_Add;

	[_unit,_uid,false] call Server_Gear_Save;
	_query = format ["UPDATE players SET name='%1',pasportdate=NOW(), gender='%3', dob='%4' WHERE uid ='%2'", _name,_uid,_sex,_dob];
	[_query,1] spawn Server_Database_Async;

	//give them a rusted CVPI
	_query = format ["INSERT INTO objects (id,type,class,uid,plystorage) VALUES ('%1','vehicle','A3PL_CVPI_Rusty','%2','1')",([7] call Server_Housing_GenerateID),_uid];
	[_query,1] spawn Server_Database_Async;
	[_unit] call Server_iPhoneX_GrantNumber;
},true] call Server_Setup_Compile;

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

			//give the key to the player if he doesn't have it
			_doorID = (_warehouseObj getVariable "doorid") select 1;
			if (!(_doorID IN _keys)) then {
				_allKeys = _unit getVariable["keys",[]];
				_allKeys pushBack _doorID;
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

// Save the physical A3 inventory including clothing
["Server_Gear_Save", {
	private ["_unit", "_uid", "_delete", "_weapons", "_items", "_magazines", "_query", "_loadout", "_pos","_job","_virtinv","_cash","_bank","_ship","_adminWatch"];
	_unit = _this select 0;
	_uid = _this select 1;
	_delete = _this select 2;

	//get loadout
	_loadout = getUnitLoadout _unit;

	//Get position
	_pos = getpos _unit;

	//Delete unit if we want to
	if (_delete) then { deleteVehicle _unit; };

	//get job
	_job = _unit getVariable ["job","unemployed"];

	//virtual inventory
	_virtinv = _unit getVariable ["player_inventory",[]];

	// import export ship
	_ship = [(_unit getVariable ["player_importing",[]]),(_unit getVariable ["player_exporting",[]])];


	//Med stats
	_medStat = _unit getVariable ["A3PL_Wounds",[]];
	_blood = _unit getVariable ["A3PL_MedicalVars",[5000,"120/80",37]];
	_medStat = [_medStat,_blood];

	//cash and bank, lets not check for Nil vars, see if this needs editing later
	_cash = _unit getVariable "Player_Cash";
	_bank = _unit getVariable "Player_Bank";
	_level = _unit getVariable ["Player_Level",0];
	_xp = _unit getVariable ["Player_XP",0];
	if ((isNil "_cash") OR (isNil "_bank")) exitwith
	{
		diag_log format ["Error in Server_Gear_Save: _cash or _bank is nil for %1",name _unit];
	};

	_adminWatch = _unit getVariable ["adminWatch",0];

	_query = format ["UPDATE players SET loadout='%2',position='%3',job='%4',virtualinv='%5',cash='%6',bank='%7',level='%8',xp='%9',medstats='%10',ship='%11',adminWatch='%12' WHERE uid ='%1'",
		_uid,
		([_loadout] call Server_Database_Array), //these need to be formatted for db save, only if array consists of strings
		_pos,
		_job,
		([_virtinv] call Server_Database_Array),
		_cash,
		_bank,
		_level,
		_xp,
		_medStat,
		([_ship] call Server_Database_Array),
		_adminWatch
	];

	[_query,1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;

// Only run when the user has loaded its stats otherwise it will overwrite with empty stats most likely (duh..)
["Server_Gear_HandleDisconnect",
{
	addMissionEventHandler ["HandleDisconnect",
	{
		private ["_unit","_uid","_var"];
		_unit = _this select 0;
		_uid = _this select 2;
		if (isNull _unit) exitwith {};
		_var = _unit getVariable "name";
		if (isNil "_var") exitwith {};
		_jobVeh = _unit getVariable ["jobVehicle",nil];

		[] remoteExecCall ["A3PL_Lib_VerifyHunger",_unit];
		[] remoteExecCall ["A3PL_Lib_VerifyThirst",_unit];

		[_unit,_uid] call Server_Housing_SaveKeys;

		//save furniture
		if (!isNil {_unit getVariable ["house",nil]}) then {[_unit,_uid] call Server_Housing_SaveItems;};
		if (!isNil {_unit getVariable ["warehouse",nil]}) then {[_unit,_uid] call Server_Warehouses_SaveItems;};
		if (!isNil {_jobVeh}) then {deleteVehicle _jobVeh;};

		//get rid of the assigned apt, if exist
		_var = _unit getVariable "apt";
		if (!isNil "_var") then
		{
			[_unit] call Server_Housing_UnAssignApt;
		};

		/* Clean Up Any Buoys owned by the player */
		_deleteAt = [];
		{
			if((_x getVariable ["owner",""]) isEqualTo _uid) then {
				ropeDestroy (_x getVariable ["rope",objNull]);
				deleteVehicle (_x getVariable ["net",objNull]);
				deleteVehicle _x;
				_deleteAt pushBack _forEachIndex;
			};
		} forEach Server_FishingBuoys;

		{
		  Server_FishingBuoys deleteAt _x;
		} forEach _deleteAt;

		[_unit,_uid,true] spawn Server_Gear_Save;
	}];
}, true] call Server_Setup_Compile;

["Server_Gear_SaveLoop",
{
	private _timeSave = 1200;
	["itemAdd", ["A3PL_SaveLoop",
	{
		[] spawn {
			{
				_unit = _x;
				_uid = getPlayerUID _unit;
				[_unit, _uid, false] spawn Server_Gear_Save;
				sleep 10;
			} foreach allPlayers;
		};
	}, _timeSave]] call BIS_fnc_loop;
}, true] call Server_Setup_Compile;


["Server_Gear_WipeRusty",{
	diag_log "running";
	_query = format ["SELECT uid FROM players;"];
	_return = [_query, 2,true] call Server_Database_Async;
	diag_log _return;
	{
		_query = format ["INSERT INTO objects (id,type,class,uid,plystorage) VALUES ('%1','vehicle','A3PL_CVPI_Rusty','%2','1')",([7] call Server_Housing_GenerateID),(_x select 0)];
		[_query,1] spawn Server_Database_Async;
	} forEach _return;

},true] call Server_Setup_Compile;
