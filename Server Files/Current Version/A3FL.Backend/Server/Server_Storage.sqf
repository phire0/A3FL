/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Storage_Init",
{
	["UPDATE objects SET plystorage = '1'",1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

#define ILLEGAL_ITEMS ["seed_marijuana","marijuana","cocaine","shrooms","cannabis_bud","cannabis_bud_cured","cannabis_grinded_5g","weed_5g","weed_10g","weed_15g","weed_20g","weed_25g","weed_30g","weed_35g","weed_40g","weed_45g","weed_50g","weed_55g","weed_60g","weed_65g","weed_70g","weed_75g","weed_80g","weed_85g","weed_90g","weed_95g","weed_100g","jug_moonshine","turtle","Gunpowder","keycard"]
["Server_Storage_VehicleVirtual",
{
	private _veh = param [0,objNull];
	private _var = _veh getVariable ["owner",nil];
	if(isNil '_var') exitWith {};
	private _storage = _veh getVariable["storage",[]];
	private _finalStorage = [];
	{
		if(!((_x select 0) IN ILLEGAL_ITEMS)) then {_finalStorage pushback _x;};
	} foreach _storage;
	private _storage = [_finalStorage] call Server_Database_Array;
	private _toQuery = format ["UPDATE objects SET vstorage = '%1' WHERE id = '%2'",_storage,(_var select 1)];
	[_toQuery,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Storage_Vehicle",
{
	private _veh = param [0,objNull];
	private _var = _veh getVariable ["owner",[]];
	if(count(_var) isEqualTo 0) exitWith {};
	private _id = _var select 1;
	private _vehItems = getItemCargo _veh;
	private _vehMags = getMagazineCargo _veh;
	private _vehBackpacks = getBackpackCargo _veh;
	private _oldWeapons = getWeaponCargo _veh;
	private _whitelist = ["srifle_LRR_F","srifle_LRR_SOS_F","A3FL_PepperSpray","A3FL_PoliceBaton","A3PL_High_Pressure","A3PL_Jaws","A3PL_FireAxe","A3PL_FireExtinguisher","A3PL_Pickaxe","A3PL_Shovel","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","hgun_Pistol_Signal_F"];
	private _vehWeapons = [[],[]];
	{
		diag_log str(_x);
		if(_x IN _whitelist) then {
			(_vehWeapons select 0) pushback ((_oldWeapons select 0) select _foreachIndex);
			(_vehWeapons select 1) pushback ((_oldWeapons select 1) select _foreachIndex);
		};
	} foreach (_oldWeapons select 0);
	private _inventory = [_vehItems,_vehMags,_vehBackpacks,_vehWeapons];
	if ((count (_vehItems select 0) isEqualTo 0) && (count (_vehMags select 0) isEqualTo 0) && (count (_vehBackpacks select 0) isEqualTo 0) && (count (_vehWeapons select 0) isEqualTo 0)) then {
		_inventory = [];
	} else {
		_inventory = [_inventory] call Server_Database_Array;
	};
	private _query = format ["UPDATE objects SET istorage = '%2' WHERE id = '%1'",_id,_inventory];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Storage_ReturnVehicles",
{
	private _player = param [0,objNull];
	private _uid = param [1,"-1"];
	private _impound = param [2,0];
	private _type = param [3,"vehicle"];
	private _cid = param [4,0];
	if (_uid == "-1") then {_uid = getplayerUID _player;};
	private _query = "";
	if(_cid isEqualTo 0) then {
		_query = format ["SELECT id,class,customName,fuel,insurance FROM objects WHERE (type = '%3' AND plystorage = '1') AND (uid = '%1' AND impounded='%2') ORDER BY customName",_uid,_impound,_type];
	} else {
		_query = format ["SELECT id,class,customName,fuel,insurance FROM objects WHERE (type = '%2' AND plystorage = '1') AND (cid = '%3' AND impounded='%1') ORDER BY customName",_impound,_type,_cid];
	};
	private _objects = [_query, 2, true] call Server_Database_Async;
	private _returnArray = [];
	{
		private _id = _x select 0;
		private _class = _x select 1;
		private _customName = _x select 2;
		private _fuel = _x select 3;
		private _insurance = _x select 4;
		_returnArray pushBack [_id,_class,_customName,_fuel,_insurance];
	} foreach _objects;
	[_returnArray] remoteExec ["A3PL_Storage_VehicleReceive",_player];
},true] call Server_Setup_Compile;

["Server_Storage_ChangeVehicleName",
{
	private _vehiclePlate = param [0,""];
	private _vehicleNewName = param [1,""];
	private _toQuery = format ["UPDATE objects SET customName = '%1' WHERE id = '%2'",_vehicleNewName,_vehiclePlate];
	[_toQuery,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Storage_RetrieveVehiclePos",
{
	private _class = param [0,""];
	private _player = param [1,objNull];
	private _id = param [2,-1];
	private _storage = param [3,[]];
	private _dir = nil;
	if (count _storage > 3) then {
		_dir = _storage select 3;
		_storage = [_storage select 0,_storage select 1,_storage select 2];
	};
	[format ["UPDATE objects SET plystorage = '0',impounded='0' WHERE id = '%1'",_id],1] spawn Server_Database_Async;
	private _db = [format ["SELECT fuel,color,numpchange,iscustomplate,material,istorage,tuning,damage,insurance,vstorage,cid FROM objects WHERE id = '%1'",_id], 2, false] call Server_Database_Async;
	private _veh = [_class,_storage,_id,_player] call Server_Vehicle_Spawn;

	if(!isNil "_dir") then {_veh setDir _dir;};
	if (_veh isKindOf "Ship") then {
		_veh setpos _storage;
	} else {
		_veh setPosATL _storage;
	};
	if (_veh isKindOf "helicopter") then {
		_veh setOwner (owner _player);
	};

	if ((count _db) != 0) then {
		_veh setFuel (_db select 0);

		private _texture = (_db select 1);
		private _splitted = _texture splitString "";
		if((_splitted select 0) isEqualTo '[') then {_texture = [_texture] call Server_Database_ToArray;};
		if(typeName _texture isEqualTo "ARRAY") then {
			{
				_veh setObjectTextureGlobal[_foreachIndex,_x];
			} foreach _texture;
		} else {
			if(!(_texture isEqualTo "<null>")) then {
				_veh setObjectTextureGlobal [0,_texture];
			};
		};
		

		if((_db select 4) != "<null>") then {
			_veh setObjectMaterialGlobal [0,(_db select 4)];
		};
		_veh setVariable["numPChange",(_db select 2),true];
		_veh setVariable["isCustomPlate",(_db select 3),true];
		if((_db select 8) isEqualTo 1) then {
			_veh setVariable["insurance",true,true];
		} else {
			_veh setVariable["insurance",false,true];
		};

		private _iInventory = [(_db select 5)] call Server_Database_ToArray;
		if ((count _iInventory) > 0) then {
			_items = _iInventory select 0;
			_mags = _iInventory select 1;
			_backpacks = _iInventory select 2;
			_weapons = _iInventory select 3;

			clearItemCargoGlobal _veh;
			clearMagazineCargo _veh;
			clearWeaponCargoGlobal _veh;
			clearBackpackCargoGlobal _veh;
			for "_i" from 0 to ((count (_items select 0)) - 1) do {
				_veh addItemCargoGlobal [((_items select 0) select _i), ((_items select 1) select _i)];
			};
			for "_i" from 0 to ((count (_mags select 0)) - 1) do {
				_veh addMagazineCargoGlobal [((_mags select 0) select _i), ((_mags select 1) select _i)];
			};
			for "_i" from 0 to ((count (_backpacks select 0)) - 1) do {
				_veh addBackpackCargoGlobal [((_backpacks select 0) select _i), ((_backpacks select 1) select _i)];
			};
			for "_i" from 0 to ((count (_weapons select 0)) - 1) do {
				_veh addWeaponCargoGlobal [((_weapons select 0) select _i), ((_weapons select 1) select _i)];
    		};
		};
		private _virtualInventory = [(_db select 9)] call Server_Database_ToArray;
		_veh setVariable["storage",_virtualInventory,true];
		_veh setVariable["cid",(_db select 10),true];

		private _addons = [(_db select 6)] call Server_Database_ToArray;
		if ((count _addons) > 0) then {
			{
				_animName = _x select 0;
				_animPhase = _x select 1;
				_veh animatesource [_animName, _animPhase, true];
			} foreach _addons;
		};
		private _damage = [(_db select 7)] call Server_Database_ToArray;
		if((count _damage) > 0) then {
			_parts = getAllHitPointsDamage _veh;
			for "_i" from 0 to ((count _damage) - 1) do {
				_veh setHitPointDamage [format ["%1",((_parts select 0) select _i)],_damage select _i];
			};
		};
	};
	[getPlayerUID _player,"garageRetrieve",["Class",_class,"Plate",_id]] remoteExec ["Server_Log_New",2];
	[_veh] remoteExec ["A3PL_Vehicle_AddKey",_player];
	[4] remoteExec ["A3PL_Storage_CarRetrieveResponse",_player];
}] call Server_Setup_Compile;

["Server_Storage_RetrieveVehicle",
{
	private _class = param [0,""];
	private _player = param [1,objNull];
	private _id = param [2,-1];
	private _storage = param [3,[]];
	private _whitelistTrailer = ["A3PL_Ski_Base"];
	if ((typeName _storage) isEqualTo "ARRAY") exitwith {
		[_class,_player,_id,_storage] call Server_Storage_RetrieveVehiclePos;
	};

	if (_storage animationPhase "StorageDoor1" > 0.1) exitwith
	{
		diag_log "Server_Storage_RetrieveVehicle";
		[1] remoteExec ["A3PL_Storage_CarRetrieveResponse",_player];
	};

	_query = format ["SELECT fuel,color,numpchange,iscustomplate,material,istorage,tuning,damage,insurance,vstorage,cid FROM objects WHERE id = '%1'",_id];
	_db = [_query, 2, false] call Server_Database_Async;

	_query = format ["UPDATE objects SET plystorage = '0',impounded = '0' WHERE id = '%1'",_id];
	[_query,1] spawn Server_Database_Async;

	[2] remoteExec ["A3PL_Storage_CarRetrieveResponse",_player];
	_veh = [_class,_storage,_id,_player] call Server_Vehicle_Spawn;

	if ((count _db) != 0) then
	{
		_veh setFuel (_db select 0);
		if((_db select 1) != "<null>") then {
			_veh setObjectTextureGlobal [0,(_db select 1)];
		};
		if((_db select 4) != "<null>") then {
			_veh setObjectMaterialGlobal [0,(_db select 4)];
		};
		_veh setVariable["numPChange",(_db select 2),true];
		_veh setVariable["isCustomPlate",(_db select 3),true];
		if((_db select 8) isEqualTo 1) then {
			_veh setVariable["insurance",true,true];
		} else {
			_veh setVariable["insurance",false,true];
		};

		_iInventory = [(_db select 5)] call Server_Database_ToArray;
		if ((count _iInventory) > 0) then {
			_items = _iInventory select 0;
			_mags = _iInventory select 1;
			_backpacks = _iInventory select 2;
			_weapons = _iInventory select 3;

			clearItemCargoGlobal _veh;
			clearMagazineCargo _veh;
			clearWeaponCargoGlobal _veh;
			clearBackpackCargoGlobal _veh;
			for "_i" from 0 to ((count (_items select 0)) - 1) do {
				_veh addItemCargoGlobal [((_items select 0) select _i), ((_items select 1) select _i)];
			};
			for "_i" from 0 to ((count (_mags select 0)) - 1) do {
				_veh addMagazineCargoGlobal [((_mags select 0) select _i), ((_mags select 1) select _i)];
			};
			for "_i" from 0 to ((count (_backpacks select 0)) - 1) do {
				_veh addBackpackCargoGlobal [((_backpacks select 0) select _i), ((_backpacks select 1) select _i)];
			};
			for "_i" from 0 to ((count (_weapons select 0)) - 1) do {
				_veh addWeaponCargoGlobal [((_weapons select 0) select _i), ((_weapons select 1) select _i)];
    		};
		};
		_virtualInventory = [(_db select 9)] call Server_Database_ToArray;
		_veh setVariable["storage",_virtualInventory,true];
		_veh setVariable["cid",(_db select 10),true];
		_addons = [(_db select 6)] call Server_Database_ToArray;
		if ((count _addons) > 0) then {
			{
				_animName = _x select 0;
				_animPhase = _x select 1;
				_veh animatesource [_animName, _animPhase, true];
			} foreach _addons;
		};
		_damage = [(_db select 7)] call Server_Database_ToArray;
		if((count _damage) > 0) then {
			_parts = getAllHitPointsDamage _veh;
			for "_i" from 0 to ((count _damage) - 1) do {
				_veh setHitPointDamage [format ["%1",((_parts select 0) select _i)],_damage select _i];
			};
		};
	};

	if ((_veh isKindOf "ship") && (!(typeOf _veh IN _whitelistTrailer))) then
	{
		_trailer = createVehicle ["A3PL_BoatTrailer_Normal", (getPos _veh), [], 0, 'CAN_COLLIDE'];
		_trailer allowDamage false;
		_veh attachTo [_trailer,[0,0,1.5]];
		_trailer setDir (getDir _storage);
		_trailer setPos (getPos _storage);
		[_veh,_trailer,_player] spawn {
			_veh = param [0,objNull];
			_trailer = param [1,objNull];
			_player = param [2,objNull];
			sleep 1.5;
			_veh setOwner (owner _player);
		};
	};
	[getPlayerUID _player,"garageRetrieve",["Class",_class,"Plate",_id]] remoteExec ["Server_Log_New",2];
	[_veh] remoteExec ["A3PL_Vehicle_AddKey",_player];
	_storage animateSource ["storagedoor",1];
	[_player,_storage,_veh,_id] spawn
	{
		private _player = param [0,ObjNull];
		private _storage = param [1,ObjNull];
		private _veh = param [2,ObjNull];
		private _id = param [3,""];
		private _t = 0;
		while {(_veh distance _storage) < 8} do
		{
			sleep 1;
			_t = _t + 1;
			if (isNull _veh) exitwith {};
			if (_t > 119) exitwith {
				[3] remoteExec ["A3PL_Storage_CarRetrieveResponse",_player];
				[format ["UPDATE objects SET plystorage = '1' WHERE id = '%1'",_id],1] spawn Server_Database_Async;
				Server_Storage_ListVehicles - [_veh];
				[_veh,false] remoteExec ["A3PL_Vehicle_AddKey",_player];
				[_veh] call Server_Vehicle_Despawn;
			};
		};
		_storage animateSource ["storagedoor",0];
	};
},true] call Server_Setup_Compile;

["Server_Storage_StoreVehicle_Pos",
{
	private _player = param [0,ObjNull];
	private _storage = param [1,ObjNull];
	private _toCompany = param [2,0];
	private _uid = getPlayerUID _player;
	private _near = nearestObjects [_player,["Car","Ship","Air","Tank"],25];
	if ((count _near) isEqualTo 0) exitwith {[7] remoteExec ["A3PL_Storage_CarStoreResponse",_player];};

	{
		_var = _x getVariable "owner";
		if (!isNil "_var") then {
			if ((_var select 0) isEqualTo _uid) exitwith {
				_playerCar = _x;
			};
		};
	} foreach _near;
	if (isNil "_playerCar") exitwith {[6] remoteExec ["A3PL_Storage_CarStoreResponse",_player];};

	[_playerCar,_storage,_player,_toCompany] spawn
	{
		private _playerCar = param [0,objNull];
		private _storage = param [1,objNull];
		private _player = param [2,objNull];
		private _toCompany = param[3,0];
		private _t = 0;
		private _fail = false;
		private _class = typeOf _playerCar;
		private _cid = _playerCar getVariable["cid",0];
		if(_toCompany isEqualTo 1) then {_cid = [getPlayerUID _player] call A3PL_Config_GetCompanyID;};
		if(_toCompany isEqualTo 2) then {_cid = 0;};
		while {(_playerCar distance _player > 5) OR (_player IN _playerCar)} do
		{
			_t = _t + 1;
			sleep 1;
			if (isNull _playerCar) exitwith {
				_fail = true;
				[5] remoteExec ["A3PL_Storage_CarStoreResponse",_player];
			};
			if (_t > 119) exitwith {
				[4] remoteExec ["A3PL_Storage_CarStoreResponse",_player];
				_fail = true;
			};
		};
		if (!_fail) then {
			[4] remoteExec ["A3PL_Storage_CarStoreResponse",_player];
		};
		if (!_fail) then
		{
			private _var = _playerCar getVariable ["owner",""];
			private _id = _var select 1;
			private _Path = (getObjectTextures _playerCar) select 0;
			private _Pathformat = format ["%1",_Path];
			private _material = (getObjectMaterials _playerCar) select 0;
			private _materialFormat = format ["%1",_material];
			private _Texture = [_Pathformat, "\", "\\"] call CBA_fnc_replace;
			private _materialLocation = [_materialFormat, "\", "\\"] call CBA_fnc_replace;
			private _damage = [];
			if(count(getAllHitPointsDamage _playerCar) isEqualTo 3) then {
				_damage = [(getAllHitPointsDamage _playerCar) select 2] call Server_Database_Array;
			};
			private _query = format ["UPDATE objects SET plystorage = '1',fuel='%2',color='%3',material='%4', damage='%5', cid='%6' WHERE id = '%1'",_id,(fuel _playerCar),_Texture,_materialLocation,_damage,_cid];
			[_query,1] spawn Server_Database_Async;
			Server_Storage_ListVehicles - [_playerCar];
			[_playerCar,false] remoteExec ["A3PL_Vehicle_AddKey",_player];
			[_playerCar] call Server_Vehicle_Despawn;
			[getPlayerUID _player,"garageStore",["Class",_class,"Plate",_id]] remoteExec ["Server_Log_New",2];
		};
	};
},true] call Server_Setup_Compile;

["Server_Storage_StoreVehicle",
{
	private _player = param [0,ObjNull];
	private _storage = param [1,ObjNull];
	private _toCompany = param [2,0];	
	private _uid = getPlayerUID _player;
	if (_storage animationPhase "StorageDoor1" > 0.1) exitwith {[1] remoteExec ["A3PL_Storage_CarStoreResponse",_player];};
	private _near = nearestObjects [_storage,["Car","Ship","Air"],9];
	private _playerCar = nil;
	if ((count _near) isEqualTo 0) exitwith {[7] remoteExec ["A3PL_Storage_CarStoreResponse",_player];};

	{
		_var = _x getVariable ["owner",["",""]];
		if ((_var select 0) isEqualTo _uid) exitwith {
			_playerCar = _x;
		};
	} foreach _near;
	if (isNil "_playerCar") exitwith {[6] remoteExec ["A3PL_Storage_CarStoreResponse",_player];};

	_storage animateSource ["storagedoor",1];

	[2] remoteExec ["A3PL_Storage_CarStoreResponse",_player];
	[_playerCar,_storage,_player,_toCompany] spawn
	{
		private _playerCar = param [0,objNull];
		private _storage = param [1,objNull];
		private _player = param [2,objNull];
		private _toCompany = param[3,0];
		private _t = 0;
		private _fail = false;
		private _class = typeOf _playerCar;
		private _cid = _playerCar getVariable["cid",0];
		if(_toCompany isEqualTo 1) then {_cid = [getPlayerUID _player] call A3PL_Config_GetCompanyID;};
		if(_toCompany isEqualTo 2) then {_cid = 0;};
		while {(_playerCar distance _storage > 3) OR ((_player IN _playerCar) OR ((_player distance _storage) < 4.8))} do
		{
			_t = _t + 1;
			sleep 1;
			if (isNull _playerCar) exitwith
			{
				_fail = true;
				[5] remoteExec ["A3PL_Storage_CarStoreResponse",_player];
			};
			if (_t > 119) exitwith
			{				
				[4] remoteExec ["A3PL_Storage_CarStoreResponse",_player];
				_fail = true;
			};
		};

		if (!_fail) then {
			[3] remoteExec ["A3PL_Storage_CarStoreResponse",_player];
		};

		_storage animateSource ["storagedoor",0];

		sleep 10;
		if (!_fail) then
		{
			private _var = _playerCar getVariable ["owner",[]];
			private _id = _var select 1;
			private _Path = (getObjectTextures _playerCar) select 0;
			private _material = (getObjectMaterials _playerCar) select 0;
			private _Pathformat = format ["%1",_Path];
			private _materialFormat = format ["%1",_material];
			private _Texture = [_Pathformat, "\", "\\"] call CBA_fnc_replace;
			private _materialLocation = [_materialFormat, "\", "\\"] call CBA_fnc_replace;
			private _damage = [];
			if(count(getAllHitPointsDamage _playerCar) isEqualTo 3) then {
				_damage = [(getAllHitPointsDamage _playerCar) select 2] call Server_Database_Array;
			};
			_query = format ["UPDATE objects SET plystorage = '1',fuel='%2',color='%3',material='%4',damage='%5',cid='%6' WHERE id = '%1'",_id,(fuel _playerCar),_Texture,_materialLocation,_damage,_cid];
			[_query,1] spawn Server_Database_Async;
			Server_Storage_ListVehicles - [_playerCar];
			[_playercar,false] remoteExec ["A3PL_Vehicle_AddKey",_player];
			[_playercar] call Server_Storage_VehicleVirtual;
			[_playerCar] call Server_Storage_Vehicle;
			[_playercar] call Server_Vehicle_Despawn;
			[getPlayerUID _player,"garageStore",["Class",_class,"Plate",_id]] remoteExec ["Server_Log_New",2];
		};
	};
},true] call Server_Setup_Compile;

["Server_Storage_SaveLargeVehicles",
{
	private _playerCar = param [0,objNull];
	private _player = param [1,objNull];
	private _toCompany = param [2,0];
	if (isNull _playerCar) exitwith {};

	[_playerCar] call Server_Storage_VehicleVirtual;

	private _var = _playerCar getVariable ["owner",nil];
	private _id = _var select 1;
	private _Path = (getObjectTextures _playerCar) select 0;
	private _material = (getObjectMaterials _playerCar) select 0;
	private _damage = [];
	if(count(getAllHitPointsDamage _playerCar) isEqualTo 3) then {_damage = [(getAllHitPointsDamage _playerCar) select 2] call Server_Database_Array;};
	private _Pathformat = format ["%1",_Path];
	private _materialFormat = format ["%1",_material];
	private _Texture = [_Pathformat, "\", "\\"] call CBA_fnc_replace;
	private _materialLocation = [_materialFormat, "\", "\\"] call CBA_fnc_replace;
	private _cid = _playerCar getVariable["cid",0];
	if(_toCompany isEqualTo 1) then {_cid = [getPlayerUID _player] call A3PL_Config_GetCompanyID;};
	if(_toCompany isEqualTo 2) then {_cid = 0;};
	_query = format ["UPDATE objects SET plystorage = '1',fuel='%2',color='%3',material='%4',damage='%5',cid='%6' WHERE id = '%1'",_id,(fuel _playerCar),_Texture,_materialLocation,_damage,_cid];
	[_query,1] spawn Server_Database_Async;
	[_playerCar] call Server_Vehicle_Despawn;
},true] call Server_Setup_Compile;

["Server_Fuel_Vehicle",
{
	private _veh = param [0,objNull];
	private _var = _veh getVariable ["owner",[]];
	if(count(_var) isEqualTo 0) exitWith {};
	private _id = _var select 1;
	private _query = format ["UPDATE objects SET fuel = '%2' WHERE id = '%1'",_id,(fuel _veh)];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;