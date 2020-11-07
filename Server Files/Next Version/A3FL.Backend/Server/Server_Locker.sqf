/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['Server_Locker_Load', {
	private _lockers = ["SELECT locker, owner, items, objects, vstorage FROM lockers", 2, true] call Server_Database_Async;
	{
		private _locker = call compile (_x select 0);
		_locker setVariable ["owner",_x select 1,true];
		private _items = call compile (_x select 2);
		private _vStorage = [(_x select 4)] call Server_Database_ToArray;
		_locker setVariable["storage",_vStorage,true];
		{_locker addWeaponCargoGlobal [_x,1]} foreach (_items select 0);
		{_locker addMagazineCargoGlobal [_x,1]} foreach (_items select 1);
		{_locker addItemCargoGlobal [_x,1]} foreach (_items select 2);
		{_locker addBackpackCargoGlobal [_x,1]} foreach (_items select 3);
	} foreach _lockers;
},true] call Server_Setup_Compile;

['Server_Locker_Insert', {
	private _locker = _this select 0;
	private _player = _this select 1;
	private _query = format ["INSERT INTO lockers(locker, owner) VALUES ('%1','%2')",_locker, getPlayerUID _player];
	[_query, 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

['Server_Locker_OwnsLocker', {
	params[
		["_player", objNull, [objNull]]
		["_locker", objNull, [objNull]]
	];

	if (isNull _player) exitWith {};

	private _query = format ["SELECT owner FROM lockers WHERE owner = '%1'", (getPlayerUID _player)];
	private _return = [_query, 2] call Server_Database_Async;
	
	[_player, _locker, ((count _return) > 0)] remoteExec ["A3PL_Locker_Rent_Receive", (owner _player)];
}, true] call Server_Setup_Compile;

['Server_Locker_Save', {
	private _lockers = ["SELECT locker, owner, items, objects FROM lockers", 2, true] call Server_Database_Async;
	{
		private _locker = call compile (_x select 0);
		private _objects = [];
		private _items = [weaponCargo _locker, magazineCargo _locker, itemCargo _locker, backpackCargo _locker];
		private _storage = [_locker getVariable["storage",[]]] call Server_Database_Array;;
		private _query = format["UPDATE lockers SET items='%1',objects='%2',vstorage='%3' WHERE locker ='%4'",_items,_objects,_storage,_locker];
		[_query,1] spawn Server_Database_Async;
	} foreach _lockers;
},true] call Server_Setup_Compile;