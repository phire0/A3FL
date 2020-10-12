/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//deals with removing items from player_inventory after crafting complete
//it will
//1. Remove cash/inventory items permanently from player vars
//2. Set another variable to add factory storage item to player
//3. Save the factory storage to database
//WARNING: In-case of a server crash, items MAY be returned to player due to there not being a cash/inventory save here
["Server_Factory_Finalise",
{
	private ["_player","_type","_id","_items","_amount","_required","_newArr","_storage","_i"];
	_player = param [0,objNull];
	_type = param [1,""];
	_id = param [2,""];
	_required = param [3, []];
	_add = param [4, 1];
	_items = [_type,"items",_player] call A3PL_Config_GetPlayerFStorage;
	_storage = _player getVariable ["player_fstorage",[]];
	_amount = ([_id,_type,"output"] call A3PL_Config_GetFactory)*_add;

	//delete the items from storage
	{
		private ["_id","_amount","_isFactory"];
		_id = _x select 0;
		_isFactory = _id splitString "_";
		_amount = _x select 1;
		_items = [_items, _id, -(_amount), true] call BIS_fnc_addToPairs; //remove item from his storage
	} foreach _required;

	{
		if ((_x select 1) < 1) then {
			_items deleteAt _forEachIndex 	//verify, delete less than 0
		};
	} forEach _items;

	{
		if (_x select 0 == _type) exitwith {_i = _forEachIndex};
	} foreach _storage;

	if (isNil "_i") exitwith {}; //cannot find the factory?

	_newArr = _storage select _i;
	_newArr set [1,_items];

	if (count _items == 0) then {
		_storage deleteAt _i; //we can remove the complete array from player_fstorage
	} else {
		_storage set [_i,_newArr];
	};
	//end of deleting from storage
	_player setvariable ["player_fStorage",_storage,true];

	//if this an item we want to add the item itself and not the recipe
	if (([_id,_type,"type"] call A3PL_Config_GetFactory) == "item") then
	{
		private ["_isFactory"];
		_isFactory = _id splitString "_";
		if ((_isFactory select 0) == "f") then {_isFactory = true;} else {_isFactory = false;};
		if (_isFactory) then {_id = [_id,_type,"class"] call A3PL_Config_GetFactory;};
	};

	//add the item to the storage
	[_player,_type,[_id,_amount],false] call Server_Factory_Add;
},true] call Server_Setup_Compile;

//adds an item to the _fStorage
["Server_Factory_Add",
{
	private ["_items","_player","_inventory","_newCash","_type","_item","_items","_i","_move","_fail","_obj"];
	_player = param [0,objNull];
	_type = param [1,""];
	_item = param [2,["",1]];
	_move = param [3,true];
	_obj = param [4,nil];
	_fail = false;
	if (_move) then {
		if (!isNil "_obj") then {
			if (isNull _obj) exitwith {_fail = true;};
			deleteVehicle _obj;
		} else {
			private ["_class","_amount","_has"];
			_has = [(_item select 0),(_item select 1),_player] call Server_Inventory_Has;
			if (!_has) exitwith {_fail = true;};
			_inventory = _player getVariable ["player_inventory",[]];
			_class = _item select 0;
			_amount = _item select 1;
			if (_class isEqualTo "cash") then {
				_newcash = (_player getVariable ["player_cash",0]) - _amount;
			} else {
				_inventory = [_inventory, _class, -(_amount), true] call BIS_fnc_addToPairs;
			};
			_player setvariable ["player_inventory",_inventory,true];
			[_player] call Server_Inventory_Verify;
			if (!isNil "_newCash") then {_player setvariable ["player_cash",_newcash,true];};
		};
	};
	if (_fail) exitwith {};

	_storage = _player getvariable ["player_fStorage",[]];
	_newArr = [_type,"items",_player] call A3PL_Config_GetPlayerFStorage;
	{
		if ((_x select 0) == _type) exitwith {_i = _forEachIndex;};
	} foreach _storage;

	if (typeName _newArr != "BOOL") then {
		_newArr = [_newArr, (_item select 0), (_item select 1), true] call BIS_fnc_addToPairs;
		if (isNil "_i") exitwith {};
		(_storage select _i) set [1,_newArr];
	} else {
		_storage pushBack [_type,[[(_item select 0),(_item select 1)]]];
	};

	_player setvariable ["player_fstorage",_storage,true];
	_query = format ["UPDATE players SET f_storage='%1' WHERE uid='%2'",([_storage] call Server_Database_Array),getPlayerUID _player];
	[_query,1] spawn Server_Database_Async;
	

	_newTotal = 0;
	{
		if((_x select 0) isEqualTo (_item select 0)) exitWith {_newTotal = (_x select 1);}
	} forEach _newArr;
	[getPlayerUID _player,"addFactory",["Factory",_type,"Item",(_item select 0),"Amount",(_item select 1),"Total",_newTotal]] call Server_Log_New;
},true] call Server_Setup_Compile;

//script that runs upon collecting
["Server_Factory_Collect",
{
	private ["_player","_type","_item","_i","_query","_storage","_items","_id","_amount"];
	_player = param [0,objNull];
	_type = param [1,""]; //factory name
	_item = param [2,["",1]]; //id of crafting item
	_id = _item select 0;
	_amount = _item select 1;
	_storage = _player getVariable ["player_fstorage",[]];
	_items = [_type,"items",_player] call A3PL_Config_GetPlayerFStorage; //gets an array of items as formatted above
	if (typeName _storage == "BOOL") then {_storage = []};

	//DEAL WITH THE PLAYER_FSTORAGE VARIABLES
	if (!([_id,_amount,_type,_player] call A3PL_Factory_Has)) exitwith {}; //player doesnt have the item in storage he's trying to craft
	//END OF CHECK TO SEE IF WE HAVE ITEM IN FSTORAGE

	_items = [_items, _id, -(_amount), true] call BIS_fnc_addToPairs; //remove item from his storage
	//verify, delete less than 0
	{
		if ((_x select 1) < 1) then
		{
			_items deleteAt _forEachIndex
		};
	} forEach _items;
	//end of verify

	{
		if (_x select 0 == _type) exitwith {_i = _forEachIndex};
	} foreach _storage;

	if (isNil "_i") exitwith {}; //cannot find the factory?

	_newArr = _storage select _i;
	_newArr set [1,_items];

	//_canTake = [_player, _id, _amount] call A3PL_Inventory_CanTake;
	//if(!_canTake) exitwith {[format ["Inventaire: Impossible d'ajouter un objet à votre inventaire car il dépasserait la limite de %1 lb de votre inventaire!",800],"red"] call A3PL_Player_Notification;};
	if (count _items == 0) then
	{
		_storage deleteAt _i; //we can remove the complete array from player_fstorage
	} else
	{
		_storage set [_i,_newArr];
	};
	_player setvariable ["player_fstorage",_storage,true]; //set variable
	_query = format ["UPDATE players SET f_storage='%1' WHERE uid='%2'",([_storage] call Server_Database_Array),getPlayerUID _player];
	[_query,1] spawn Server_Database_Async; //set database
	//END OF DEALING WITH THE PLAYER_FSTORAGE VARIABLES

	//HANDLE CREATION OF ITEM HERE
	[_player,_item,_type] call Server_Factory_Create;
	//END OF HANDLING CREATION OF ITEM
},true] call Server_Setup_Compile;

//Takes care of spawning the item
["Server_Factory_Create",
{
	private ["_player","_id","_item","_amount","_type","_classType","_class","_isFactory"];
	_player = param [0,objNull];
	_item = param [1,["",1]];
	_id = _item select 0;
	_amount = _item select 1;
	_type = param [2,""];
	_classType = param [3,nil];

	_isFactory = _id splitString "_";
	if ((_isFactory select 0) isEqualTo "f") then {_isFactory = true;} else {_isFactory = false;};

	if (_isFactory) then {
		_classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
		_id = [_id,_type,"class"] call A3PL_Config_GetFactory;
	} else {
		if (isNil "_classType") then {
			_classType = "item";
		};
	};
	switch (true) do
	{
		case (_classType isEqualTo "car"):
		{
			private ["_lp","_pos"];
			_lp = [_player,_id,"vehicle",false] call Server_Vehicle_Buy;
			if (_id isKindOf "Ship") then
			{
				_pos = [(getpos _player), 20, 100, 0, 2] call BIS_fnc_findSafePos;
			} else {
				_pos = (getpos _player) findEmptyPosition [3,65,_id];
			};
			if ((count _pos) isEqualTo 0) then {_pos = getpos _player};
			_veh = [_id,_pos,_lp,_player] call Server_Vehicle_Spawn;
			_veh setDir 133.799;
		};
		case (_classType isEqualTo "plane"):
		{
			_lp = [_player,_id,"plane",true] call Server_Vehicle_Buy;
		};
		case (_classType isEqualTo "item"):
		{
			private ["_canPickup","_simulation"];
			_canPickup = [_id,"canPickup"] call A3PL_Config_GetItem;
			_simulation = [_id,"simulation"] call A3PL_Config_GetItem;
			if (_canPickup) then
			{
				[_player,_id,_amount] call Server_Inventory_Add;
			} else {
				private ["_obj","_objClass"];
				if(_amount > 1) exitWith {[localize "STR_SERVER_FACTORY_ONLYRETRIEVEONETHISITEM","red"] call A3PL_Player_Notification; [_player,_type,[_id,_amount],false] call Server_Factory_Add;};
				_objClass = [_id,"class"] call A3PL_Config_GetItem;
				_obj = createVehicle [_objClass, (getpos _player), [], 0, "CAN_COLLIDE"];
				_obj setVariable ["owner",(getPlayerUID _player),true];
				_obj setVariable ["class",_id,true];
				[_obj,_player] remoteExec ["Server_Player_LocalityRequest",2];
			};
		};
		case (_classType IN ["vest","uniform","goggles","headgear","backpack","weapon","magazine","aitem","weaponitem","secweaponitem"]):
		{
			private ["_obj"];
			if (_classType isEqualTo "uniform") then {
				_obj = createVehicle ["A3PL_Clothing", (getpos _player), [], 0, "CAN_COLLIDE"];
			} else {
				_obj = createVehicle ["A3PL_Crate", (getpos _player), [], 0, "CAN_COLLIDE"];
			};
			_obj setVariable ["owner",(getPlayerUID _player),true];
			_obj setVariable ["class","ainv",true];
			_obj setVariable ["ainv",[_classtype,_id,_amount],true];		
		};
	};
	[getPlayerUID _player,"collectFactory",[_type,_item,_amount]] call Server_Log_New;
},true] call Server_Setup_Compile;
