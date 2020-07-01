/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define HOUSESLIST ["Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_Mansion01","Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_BostonHouse","Land_A3PL_Shed3","Land_A3PL_Shed4","Land_A3PL_Shed2","Land_John_House_Grey","Land_John_House_Blue","Land_John_House_Red","Land_John_House_Green","Land_A3FL_Mansion","Land_A3FL_Office_Building"]

["Server_Housing_SaveItems",
{
	private _player = param [0,objNull];
	private _uid = param [1,""];
	private _delete = param [2,true];
	private _house = _player getVariable ["house",objNull];
	private _items = nearestObjects [_house,[],30];
	private _allMembers = _house getVariable["owner",[]];
	private _isOwner = false;
	if((_allMembers select 0) isEqualTo _uid) then {_isOwner = true;};
	if(!_isOwner) exitWith {};

	_house setVariable ["furn_loaded",false,false];
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
		_pItems pushback [(typeOf _x),(_x getVariable "class"),(_house worldToModel (getposATL _x)),getDir _x];
		if (_delete) then {deleteVehicle _x;};
	} foreach _itemsToSave;

	private _query = format ["UPDATE houses SET pitems='%1' WHERE location ='%2'",_pItems,(getpos _house)];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

//COMPILE BLOCK
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

["Server_Housing_LoadItemsSimulation",
{
	private _object = param [0,[]];
	_object enableSimulationGlobal false;
},true] call Server_Setup_Compile;

//Compile block warning
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

	//add items [["srifle_EBR_F"],[],[]]
	{_box addWeaponCargoGlobal [_x,1]} foreach _weapons;
	{_box addMagazineCargoGlobal [_x,1]} foreach _magazines;
	{_box addItemCargoGlobal [_x,1]} foreach _actualitems;
	{_box addBackpackCargoGlobal [_x,1]} foreach _backpacks;
	_box setVariable ["storage",_vitems,true];
},true] call Server_Setup_Compile;

["Server_Housing_SaveBox",
{
	private ["_box","_house","_pos","_query","_items"];
	_house = param [0,objNull];
	_box = param [1,objNull];
	_pos = getpos _house;

	//save contents of box into db
	_items = [weaponCargo _box,magazineCargo _box,itemCargo _box,backpackCargo _box];
	_query = format ["UPDATE houses SET items='%1',vitems='%3' WHERE location ='%2'",_items,_pos,(_box getVariable ["storage",[]])];
	[_query,1] spawn Server_Database_Async;

	//delete box
	deleteVehicle _box;

	//set var that makes the box loadable again
	_house setVariable ["box_spawned",nil,false];
},true] call Server_Setup_Compile;

//Initialize houses, assign all doorIDs, on server start
//COMPILE BLOCK WARNING
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

//This function will change/buy the ownership of a house
["Server_Housing_AssignHouse",
{
	private ["_object","_player","_uid","_keyID","_pos","_insert","_var","_signs","_takeMoney","_price"];
	_object = param [0,objNull];
	_player = param [1,objNull];
	_takeMoney = param [2,true];
	_price = param [3,0];
	_uid = getPlayerUID _player;

	_object setVariable ["owner",[_uid],true];

	if (_takeMoney) then
	{
		_player setVariable ["player_bank",((_player getVariable ["player_bank",0]) - _price),true];
	};

	_keyID = [_player,_object,"",false,"house"] call Server_Housing_CreateKey;

	if (!(_object IN Server_HouseList)) then
	{
		Server_HouseList pushback _object;
	};

	_pos = getpos _object;
	_uid = [[_uid]] call Server_Database_Array;
	_insert = format ["INSERT INTO houses (uids,classname,location,doorid,pitems) VALUES ('%1','%2','%3','%4','[]') ON DUPLICATE KEY UPDATE doorID='%3'",_uid,typeOf _object,_pos,_keyID];
	[_insert,1] spawn Server_Database_Async;

	_player setVariable ["house",_object,true];
	_var = _player getVariable ["apt",nil];
	if (!isNil "_var") then
	{
		[_player] call Server_Housing_UnAssignApt;

		_player setVariable ["apt",Nil,true];
		_player setVariable ["aptnumber",Nil,true];
	};

	_signs = nearestObjects [_object, ["Land_A3PL_EstateSign"], 20];
	if (count _signs > 0) then
	{
		(_signs select 0) setObjectTextureGlobal [0,"\A3PL_Objects\Street\estate_sign\house_rented_co.paa"];
	};

},true] call Server_Setup_Compile;

//This will set the position of the player to their appartment
["Server_Housing_SetPosApt",
{
	private ["_player","_apt","_aptNumber","_posApts"];
	_player = param [0,objNull];

	_apt = _player getVariable "apt";
	_aptNumber = _player getVariable "aptNumber";

	if ((isNil "_apt") OR (isNil "_aptnumber")) exitwith {diag_log "Error setting player to assigned appartment"};

	//list of appartment spawn positions
	_posApts = [[0.0732422,8.21582],[0.723145,2.35547],[0.729004,-2.39551],[1.8501,-8.38477],[1.23389,8.32764],[1.61963,2.26953],[1.50342,-2.50537],[1.67139,-8.31201]]; //Z doesnt seem to work properly, we will use custom ATL instead
	_posAptsATL = [0.231,0.231,0.231,0.231,3.00974,3.00974,3.00974,3.00974]; //Custom height here, workaround
	_posAptATL = _apt modelToWorld (_posApts select (_aptNumber - 1));

	_player setposATL [(_posAptATL select 0),(_posAptATL select 1),(_posAptsATL select (_aptNumber - 1))];
},true] call Server_Setup_Compile;

["Server_Housing_AssignApt",
{
	private ["_player","_objToAssign","_var","_cannotAssign","_AptToAssign","_doorName"];
	_player = param [0,objNull];

	_list = Server_AptList;
	// if((_player getVariable["faction","citizen"]) == "uscg") then {
	// 	_list = nearestObjects [[2188.62,4991.78,0], ["Land_A3PL_Motel"], 5000];
	// };

	{
		private ["_assigned"];
		_assigned = _x getVariable "Server_AptAssigned";
		if (count _assigned < 8) exitwith
		{
			_objToAssign = _x;
		};
	} foreach _list;


	if (isNil "_objToAssign") exitwith {diag_log "Error assigning apartment to player: None available"};

	_var = _objToAssign getVariable "Server_AptAssigned";
	_cannotAssign = [];

	{
		_cannotAssign pushback (_x select 0);
	} foreach _var;

	_AptToAssign = 1;
	while {_AptToAssign IN _cannotAssign} do
	{
		_AptToAssign = _AptToAssign + 1;
	};

	_var pushBack [_AptToAssign,_player];
	_objToAssign setVariable ["Server_AptAssigned",_var,false];

	_doorName = format ["door_%1",_AptToAssign];

	[_player,_objToAssign,_doorName,false,"motel"] call Server_Housing_CreateKey;

	_player setVariable ["apt",_objToAssign,true];
	_player setVariable ["aptnumber",_AptToAssign,true];
	[_objToAssign,_AptToAssign] remoteExec ["A3PL_Housing_AptAssignedMsg",_player];

	_objToAssign setVariable [(format ["Door_%1_locked",_AptToAssign]),true,true];
},true] call Server_Setup_Compile;

["Server_Housing_UnAssignApt",
{
	private ["_player","_var","_obj","_var1"];
	_player = param [0,objNull];

	//could potentially also use aptNumber
	_var1 = _player getVariable "apt";
	_var = _var1 getVariable "Server_AptAssigned";
	{
		if ((_x select 1) == _player) exitwith
		{
			_var deleteAt _forEachIndex;
			_var1 setVariable ["Server_AptAssigned",_var,false];
		};
	} foreach _var;

},true] call Server_Setup_Compile;


//Function that will run when a player picks up a key
["Server_Housing_PickupKey",
{
	private ["_object","_keyID","_keys"];
	_object = _this select 0;
	if (isNull _object) exitwith {};
	_player = _this select 1;

	if (_object getVariable ["inuse",false]) exitwith {};
	_object setVariable ["inuse",true,false];
	deleteVehicle _object;

	_keyID = _object getVariable "keyID";
	if (isNil "_keyID") exitwith {};
	_keys = _player getVariable "keys";

	_keys pushBack _keyID;
	_player setvariable ["keys",_keys,true];
},true] call Server_Setup_Compile;

//Function that will run when a player drops a key
["Server_Housing_dropKey",
{
	private ["_object","_keyID","_keys"];
	_object = _this select 0;
	if (isNull _object) exitwith {};
	_player = _this select 1;
	_keys = _player getVariable "keys";
	_keyID = _object getVariable "keyID";
	{
		if (_x == _keyID) exitwith
		{
			_keys deleteAt _forEachIndex;
		};
	} foreach _keys;
	_player setVariable ["keys",_keys,true];
},true
] call Server_Setup_Compile;

//This function will create and assign key
//arguments:
["Server_Housing_CreateKey",
{
	private ["_obj","_keys","_player","_id","_name"];
	_player = param [0,objNull];
	_uid = getPlayerUID _player;
	_obj = param [1,objNull];
	_door = param [2,objNull];
	_saveKey = param [3,true];
	_id = "";
	_name = param [4,""];


	if (!(_obj isKindOf "house")) exitwith {};

	if (_name == "motel") then
	{
		private ["_var"];
		_name = _this select 2;
		_var = _obj getVariable ["doorID",[]];
		_keyNames = ["door_1","door_2","door_3","door_4","door_5","door_6","door_7","door_8"];
		_playerKeys = _player getVariable ["keys",[]];

		{
			if(_x IN _keyNames) then {
				_playerKeys deleteAt _forEachIndex;
			};
		} forEach _playerKeys;

		_id = _door;
		_var pushback [[_uid],_door,_name];

		_obj setVariable ["doorID",_var,true];
		_player setVariable["keys",_playerKeys,true];
	};

	if(_name == "warehouse") then {
	_id = [8] call Server_Housing_GenerateID;
	_obj setVariable ["doorID",[_uid,_id],true];
	};

	if(_name == "house") then {
	_id = [5] call Server_Housing_GenerateID;
	_obj setVariable ["doorID",[_uid,_id],true];
	};

	if(_name == "greenhouse") then {
		_id = [4] call Server_Housing_GenerateID;
		_obj setVariable ["doorID",[_uid,_id],true];
	};


	_keys = _player getVariable ["keys",[]];
	_keys pushback _id;
	_player setVariable ["keys",_keys,true];

	if (_name == "house") then
	{
		if (_saveKey) then
		{
			_query = format ["UPDATE houses SET doorid='%1' WHERE location ='%2'",_id,(getpos _obj)];
			[_query,1] spawn Server_Database_Async;
		};
		[_player] call Server_Housing_SaveKeys;
	};
	if (_name == "warehouse") then
	{
		if (_saveKey) then
		{
			_query = format ["UPDATE warehouses SET doorid='%1' WHERE location ='%2'",_id,(getpos _obj)];
			[_query,1] spawn Server_Database_Async;
		};
		[_player] call Server_Housing_SaveKeys;
	};
	_id;
},true] call Server_Setup_Compile;


//not used anymore
["Server_Housing_ClearKeys",
{
	private ["_keys","_keysToRemove","_listAllHouseID"];

	_keys = param [0,[]];
	if (count _keys == 0) exitwith {_keys};
	_keysToRemove = [];
	_ListAllHouseID = [];

	{
		_ListAllHouseID pushback ((_x getVariable ["doorID",[]]) select 1);
	} foreach Server_HouseList;

	{
		if (count _x == 4) then //remove all motel/apt keys
		{
			_keysToRemove pushback _x;
		} else
		{
			if (!(_x IN _ListAllHouseID)) then //doorid is not in _ListAllHouseID
			{
				_keysToRemove pushback _x;
			};
		};
	} foreach _keys;

	{
		_keys = _keys - [_x];
	} foreach _keysToRemove;

	_keys
},true] call Server_Setup_Compile;

//This will save all the keys of a specific player
['Server_Housing_SaveKeys',
{
	private ["_uid","_player","_keys"];
	_player = param [0,objNull];
	_uid = param [1,getPlayerUID _player];
	_keys = _player getVariable "keys";

	if (isNil "_keys") exitwith {};
	_query = format ["UPDATE players SET userkey='%1' WHERE uid ='%2'",([_keys] call Server_Database_Array),_uid];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;


["Server_Housing_GenerateID",
{
	private ['_r','_return','_digits'];
	_digits = _this select 0;

	//,0,1,2,3,4,5,6,7,8,9
	_r = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
	_return = [];
	for "_i" from 1 to _digits do
	{
		_return pushback (_r select (floor (random (count _r - 1))));
	};
	_return = _return joinString "";
	_return;
},true] call Server_Setup_Compile;

["Server_Housing_Sold",
{
	_pos = _this select 0;
	_clientPart = _this select 1;
	_sign = _this select 2;
	_house = _this select 3;

	_sign setVariable["houseSelling",false,true];
	_sign setObjectTextureGlobal [0,"\A3PL_Objects\Street\estate_sign\house_sale_co.paa"];

	_uids = _house getVariable ["owner",[]];
	_query = format ["DELETE FROM houses WHERE location ='%1'",getPos(_house)];
	[_query,1] spawn Server_Database_Async;

	_uid = _uids select 0;

	_house setVariable ["owner",nil,true];
	_house setVariable ["doorid",nil,true];

	_furnitures = nearestObjects [_pos, ["Thing"], 100];
	{if((_x getVariable "owner") isEqualTo _uid) then {deleteVehicle _x;};} foreach _furnitures;

	{
		if(getPlayerUID _x isEqualTo _uid) then {
			_pBank = _x getVariable["Player_Bank",0];
			_x setVariable["Player_Bank",_pBank + _clientPart,true];
			_x setVariable ["keys",[],true];
			_x setVariable ["house",nil,true];
			[format[localize"STR_SERVER_HOUSING_SELLHOUSE",_clientPart], "green"] remoteExec ["A3PL_Player_Notification",_x];
		};
	} foreach allPlayers;
},true] call Server_Setup_Compile;

["Server_Housing_AddMember",
{
	_owner = param [0,objNull];
	_new = param [1,objNull];
	_house = param [2,objNull];

	_actuals = _house getVariable "owner";

	if((_actuals find (getPlayerUID _new)) != -1) exitWith {};

	_actuals pushback(getPlayerUID _new);
	_house setVariable["owner", _actuals,true];

	_actuals = [_actuals] call Server_Database_Array;
	_query = format ["UPDATE houses SET uids='%1' WHERE location ='%2'",_actuals,(getpos _house)];
	[_query,1] spawn Server_Database_Async;

	//Give new member key and set var
	_new setVariable ["house",_house,true];
	_var = _new getVariable ["apt",nil];
	if (!isNil "_var") then
	{
		//unassign appartment, just in case
		[_new] call Server_Housing_UnAssignApt;
		//Nil apt variable, just in case
		_new setVariable ["apt",nil,true];
		_new setVariable ["aptnumber",nil,true];
	};
	_keysid = (_house getVariable ["doorID",[]]) select 1;
	_keys = _new getVariable ["keys",[]];
	_keys pushBack _keysid;

	_new setVariable ["keys",_keys,true];

	[localize"STR_SERVER_HOUSING_YOUNOWCOLOCHOUSE","green"] remoteExec ["A3PL_Player_Notification",owner _new];
	[_house] remoteExec ["A3PL_Housing_SetMarker",_new];
},true] call Server_Setup_Compile;

["Server_Housing_RemoveMember",
{
	_old = param [0,objNull];
	_house = param [1,objNull];
	_uid = getPlayerUID _old;
	_allMembers = _house getVariable "owner";
	if((_allMembers find _uid) != -1) then {
		_allMembers deleteAt (_allMembers find (getPlayerUID _old));
		_house setVariable["owner", _allMembers,true];

		_allMembers = [_allMembers] call Server_Database_Array;
		_query = format ["UPDATE houses SET uids='%1' WHERE location ='%2'", _allMembers, (getpos _house)];
		[_query,1] spawn Server_Database_Async;

		[_old] call Server_Housing_AssignApt;

		_keys = _old getVariable ["keys",[]];
		_keys deleteAt (_keys find (_house getVariable "doorid" select 1));
		_old setVariable ["keys",_keys,true];
		_old setVariable ["house",nil,true];
		[localize"STR_SERVER_HOUSING_YOUNOWEXCOLOC","yellow"] remoteExec ["A3PL_Player_Notification",owner _old];
	};
},true] call Server_Setup_Compile;
