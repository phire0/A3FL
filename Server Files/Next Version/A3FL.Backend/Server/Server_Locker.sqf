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
	params[
		["_locker", objNull, [objNull]],
		["_player", objNull, [objNull]]
	];

	private _query = format ["SELECT owner FROM lockers WHERE owner = '%1'", (getPlayerUID _player)];
	private _result = [_query, 2] call Server_Database_Async;

	if ((count _result) > 0) exitWith {
		["You already own a locker.","red"] remoteExec ["A3PL_Player_Notification",(owner _player)];
	};

	private _lockerPrice = 10000;
	private _playerBank = _player getVariable ["Player_Bank", 0];

	if(_playerBank < _lockerPrice) exitWith {
		[format[localize "STR_INTSECT_LOCKERNEEDMONEY",(_lockerPrice-_playerBank)], "red"] remoteExec ["A3PL_Player_Notification", (owner _player)];
	};

	_player setVariable ["Player_Bank", (_playerBank - _lockerPrice), true];
	_locker setVariable ["owner", (getPlayerUID _player), true];

	[format[localize "STR_INTSECT_LOCKERBOUGHT",_lockerPrice], "green"] remoteExec ["A3PL_Player_Notification", (owner _player)];
	["Federal Reserve", _lockerPrice] call Server_Government_AddBalance;
	[(getPlayerUID player), "BuyLocker", []] call Server_Log_New;

	private _query = format ["INSERT INTO lockers(locker, owner) VALUES ('%1','%2')",_locker, getPlayerUID _player];
	[_query, 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

['Server_Locker_Sell', {
	params[
		["_locker", objNull, [objNull]],
		["_player", objNull, [objNull]]
	];

	
	if !((_locker getVariable ["owner"]) isEqualTo (getPlayerUID _player)) exitWith {
		["You do not own this locker, if this is an error please let us know.", "red"] remoteExec ["A3PL_Player_Notification", (owner _player)];
	};

	private _salePrice = 5000;
	private _playerBank = _player getVariable ["Player_Bank", 0];

	_player setVariable ["Player_Bank", (_playerBank + _salePrice), true];
	_locker setVariable ["owner", "", true];

	[format["You have sold your locker and have received $%1 in your bank account.", _salePrice], "green"] remoteExec ["A3PL_Player_Notification", (owner _player)];
	[(getPlayerUID player), "SellLocker", []] call Server_Log_New;

	private _query = format ["DELETE FROM lockers WHERE locker = '%1' AND owner = '%2'", _locker, (getPlayerUID _player)];
	[_query, 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

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