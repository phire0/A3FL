/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define WAREHOUSELIST ["Land_John_Hangar","Land_A3FL_Warehouse"]

["Server_Warehouses_SaveItems",
{
	private _player = param [0,objNull];
	private _uid = param [1,""];
	private _delete = param [2,true];
	private _warehouse = _player getVariable ["warehouse",objNull];
	private _items = nearestObjects [_warehouse,[],30];
	private _allMembers = _warehouse getVariable["owner",[]];
	private _isOwner = false;
	if((_allMembers select 0) isEqualTo _uid) then {_isOwner = true;};
	if(!_isOwner) exitWith {};

	_warehouse setVariable ["furn_loaded",false,false];
	private _itemsToSave = [];
	{
		if (!isNil {_x getVariable "class"}) then {
			if (((_x getVariable "owner") isEqualTo _uid) && (count(_itemsToSave) < 25)) then {
				_itemsToSave pushback _x;
			};
		};
	} foreach _items;

	private _pItems = [];
	{
		_pItems pushback [(typeOf _x),(_x getVariable "class"),(_warehouse worldToModel (getposATL _x)),getDir _x];
		if (_delete) then {deleteVehicle _x;};
	} foreach _itemsToSave;

	private _query = format ["UPDATE warehouses SET pitems='%1' WHERE location ='%2'",_pItems,(getpos _warehouse)];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;


["Server_Warehouses_LoadItems",
{
	private ["_warehouse","_player","_uid","_pitems"];
	_player = param [0,objNull];
	_warehouse = param [1,objNull];
	_uid = param [2,""];

	if (_warehouse getVariable ["furn_loaded",false]) exitwith {};
	_warehouse setVariable ["furn_loaded",true,false];

	_pitems = [format ["SELECT pitems FROM warehouses WHERE location = '%1'",(getpos _warehouse)], 2] call Server_Database_Async;
	_pitems = call compile (_pitems select 0);

	[_warehouse,_pitems] remoteExec ["A3PL_Warehouses_Loaditems", (owner _player)];
},true] call Server_Setup_Compile;

["Server_Warehouses_LoadItemsSimulation",
{
	private _object = param [0,[]];
	_object enableSimulationGlobal false;
},true] call Server_Setup_Compile;

//Compile block warning
["Server_Warehouses_LoadBox",
{
	private ["_warehouse","_player","_pos","_items","_box","_weapons","_magazines","_items","_vitems","_cargoItems","_actualitems"];
	_player = param [0,objNull];
	_warehouse = param [1,objNull];
	_pos = getposATL _player;
	if (!isNil {_warehouse getVariable "box_spawned"}) exitwith {};
	_warehouse setVariable ["box_spawned",true,false];

	if (isDedicated) then { _items = [format ["SELECT items,vitems FROM warehouses WHERE location = '%1'",(getpos _warehouse)], 2, true] call Server_Database_Async;} else {_items = [[],[],[]];};
	_box = createVehicle ["Box_GEN_Equip_F",_pos, [], 0, "CAN_COLLIDE"];
	clearItemCargoGlobal _box;
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

	private _sCapacity = [_warehouse,4] call A3PL_Warehouses_GetData;
	_box setVariable ["capacity",_sCapacity,true];
},true] call Server_Setup_Compile;

["Server_Warehouses_SaveBox",
{
	private ["_box","_house","_pos","_query","_items"];
	_warehouse = param [0,objNull];
	_box = param [1,objNull];
	_pos = getpos _warehouse;

	//save contents of box into db
	_items = [weaponCargo _box,magazineCargo _box,itemCargo _box,backpackCargo _box];
	_query = format ["UPDATE warehouses SET items='%1',vitems='%3' WHERE location ='%2'",_items,_pos,(_box getVariable ["storage",[]])];
	[_query,1] spawn Server_Database_Async;

	//delete box
	deleteVehicle _box;

	//set var that makes the box loadable again
	_warehouse setVariable ["box_spawned",nil,false];
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

//This function will change/buy the ownership of a house
["Server_Warehouses_Assign",
{
	private ["_object","_player","_uid","_keyID","_pos","_insert","_var","_signs","_takeMoney","_price"];
	_object = param [0,objNull];
	_player = param [1,objNull];
	_takeMoney = param [2,true];
	_price = param [3,0];
	_uid = getPlayerUID _player;

	//set owner var on object
	_object setVariable ["owner",[_uid],true];

	//take money
	if (_takeMoney) then
	{
		_player setVariable ["player_bank",((_player getVariable ["player_bank",0]) - _price),true];
	};

	//Generate a new key, it will take care of assigning it to the house aswell
	//It will also take care of saving the player keys into the DB
	_keyID = [_player,_object,"",true,"warehouse"] call Server_Housing_CreateKey;
	//Insert into houses list, but only if it doesn't exist already
	if (!(_object IN Server_WarehouseList)) then
	{
		Server_WarehouseList pushback _object;
	};

	//Input the new owner, or replace if exist
	//The unique key is the location in this case (BEWARE OF THIS!!!)
	//Also be carefull, _expireTime is in SQL style, not arma (array) style
	_pos = getpos _object;
	_uid = [[_uid]] call Server_Database_Array;
	_insert = format ["INSERT INTO warehouses (uids,classname,location,doorid,pitems) VALUES ('%1','%2','%3','%4','[]') ON DUPLICATE KEY UPDATE doorID='%3'",_uid,typeOf _object,_pos,_keyID];
	[_insert,1] spawn Server_Database_Async;

	_player setVariable ["warehouse",_object,true];

	//sign
	_signs = nearestObjects [_object, ["Land_A3PL_BusinessSign"], 20];
	if (count _signs > 0) then
	{
		(_signs select 0) setObjectTextureGlobal [0,"\A3PL_Objects\Street\business_sign\business_rented_co.paa"];
	};

},true] call Server_Setup_Compile;

["Server_Warehouses_AddMember",
{
	_owner = param [0,objNull];
	_new = param [1,objNull];
	_warehouse = param [2,objNull];


	_actuals = _warehouse getVariable "owner";
	if((_actuals find (getPlayerUID _new)) != -1) exitWith {};

	_actuals pushback(getPlayerUID _new);
	_warehouse setVariable["owner", _actuals,true];

	_actuals = [_actuals] call Server_Database_Array;
	_query = format ["UPDATE warehouses SET uids='%1' WHERE location ='%2'",_actuals,(getpos _warehouse)];
	[_query,1] spawn Server_Database_Async;

	_new setVariable ["warehouse",_warehouse,true];
	_keysid = (_warehouse getVariable ["doorID",[]] select 1);
	_oldKeys = _new getVariable ["keys",[]];
	_oldKeys pushBack _keysid;
	_new setVariable ["keys",_oldKeys,true];

	["You now have keys to this warehouse!","green"] remoteExec ["A3PL_Player_Notification",owner _new];
	[_warehouse] remoteExec ["A3PL_Warehouses_SetMarker",_new];
},true] call Server_Setup_Compile;

["Server_Warehouses_RemoveMember",
{
	private _old = param [0,objNull];
	private _warehouse = param [1,objNull];
	private _uid = getPlayerUID _old;
	private _allMembers = _warehouse getVariable "owner";
	if((_allMembers find _uid) != -1) then {
		_allMembers deleteAt (_allMembers find (getPlayerUID _old));
		_warehouse setVariable["owner", _allMembers,true];

		private _allMembers = [_allMembers] call Server_Database_Array;
		private _query = format ["UPDATE warehouse SET uids='%1' WHERE location ='%2'", _allMembers, (getpos _warehouse)];
		[_query,1] spawn Server_Database_Async;


		_keys = _old getVariable ["keys",[]];
		_keys deleteAt (_keys find (_warehouse getVariable "doorid" select 1));
		_old setVariable ["keys",_keys,true];
		_old setVariable ["warehouse",nil,true];
		["You no longer have keys to this warehouse!","yellow"] remoteExec ["A3PL_Player_Notification",owner _old];
	};
},true] call Server_Setup_Compile;
