/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Inventory_Verify", {
	private _player = param [0,objNull];
	private _change = false;
	{
		if ((_x select 1) < 1) then {
			_index = _forEachIndex;
			(_player getVariable "Player_Inventory") set [_index, "REMOVE"];
			_change = true;
		};
	} forEach (_player getVariable "Player_Inventory");
	if (_change) then {
		_player setVariable ["Player_Inventory", ((_player getVariable "Player_Inventory") - ["REMOVE"]), true];
	};
	[] remoteExec ["A3PL_Inventory_SetCurrent",_player];
}, true] call Server_Setup_Compile;

["Server_Inventory_Add", {
	private _player = param [0,objNull];
	private _class = param [1,""];
	private _amount = param [2,0];

	if (_class isEqualTo "cash") exitwith {
		private _playerMoney = _player getVariable ["Player_Cash",0];
		if (isNil "_playerMoney") exitwith {};
		[_player,"Player_Cash",(_playerMoney + _amount)] call Server_Core_ChangeVar;
	};
	if (isNull _player) exitWith {};
	private _newArray = [(_player getVariable 'Player_Inventory'), _class, _amount] call BIS_fnc_addToPairs;
	_player setVariable ['Player_Inventory', _newArray, true];
	[_player] call Server_Inventory_Verify;
	[] remoteExec ["A3PL_Inventory_SetCurrent",_player];
}, true] call Server_Setup_Compile;

["Server_Inventory_Pickup", {
	private _player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
	private _obj = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
	private _amount = [_this, 2, 0, [0]] call BIS_fnc_param;

	if (isNull _player) exitWith {diag_log "ERROR: _player null in Server_Inventory_Pickup";};
	if (isNull _obj) exitwith {diag_log format ["ERROR: _obj null in Server_Inventory_Pickup - Player: %1",name _player];};

	private _class = _obj getVariable ["class",nil];
	if (isNil "_class") exitwith {diag_log format ["ERROR: _class nil in Server_Inventory_Pickup - Player: %1",name _player];};

	if (_obj getVariable ["used",false]) exitwith {};
	_obj setVariable ["used",true,false];

	if (_class isEqualTo "cash") then {_amount = _obj getVariable "cash";};
	
	deleteVehicle _obj;
	[_player,_class,_amount] call Server_Inventory_Add;
	[getPlayerUID _player,"PickupItem",[_class,_amount]] call Server_Log_New;
}, true] call Server_Setup_Compile;

["Server_Inventory_Drop", {
	private _player = param [0,objNull];
	private _obj = param [1,objNull];
	private _class = param [2,""];
	private _amount = param [3,1];
	if (isNull(_player)) exitWith {diag_log "ERROR: _player in Server_Inventory_Drop is null"};
	[_obj,"class",_class] call Server_Core_ChangeVar;
	if (_amount != 1) then {[_obj,"amount",_amount] call Server_Core_ChangeVar;};
	[_obj,"owner",(getPlayerUID _player)] call Server_Core_ChangeVar;
	if(_class IN ["doorkey","housekey"]) exitwith {};
	if(_class isEqualTo "cash") then {[_obj,"cash",_amount] call Server_Core_ChangeVar;};
	[_player, _class, -(_amount)] call Server_Inventory_Add;
	[getPlayerUID _player,"DropItem",[_class,_amount]] call Server_Log_New;
}, true] call Server_Setup_Compile;

["Server_Inventory_Return", {
	private _class = [_this, 0, '', ['']] call BIS_fnc_param;
	private _player = param [1,objNull];
	private _amount = [(_player getVariable 'Player_Inventory'), _class, 0] call BIS_fnc_getFromPairs;
	_amount;
},true] call Server_Setup_Compile;

["Server_Inventory_Has", {
	private _class = param [0,""];
	private _amount = param [1,1];
	private _player = param [2,objNull];
	if (_class isEqualTo "cash") exitwith {if (_player getVariable ["player_cash",0] >= _amount) then {true;} else {false;};};
	private _inventoryAmount = [_class,_player] call Server_Inventory_Return;
	if (_inventoryAmount < _amount) exitWith {false};
	true
},true] call Server_Setup_Compile;

["Server_Inventory_RemoveAll",
{
	private _player = param [0,objNull];
	_player setVariable ["player_inventory",[],true];
	_player setVariable ["player_cash",0,true];
	[_player,getPlayerUID _player,false] call Server_Gear_Save;
},true] call Server_Setup_Compile;

["Server_Inventory_TotalWeight",
{
	private _return = 0;
	private _itemToAdd = param [0,[]];
	private _player = param [1,objNull];
	private _inventory = _player getVariable ["player_inventory",[]];
	if (count _itemToAdd > 0) then {
		{
			_inventory = [_inventory, (_x select 0), (_x select 1), true] call BIS_fnc_addToPairs;
		} foreach _itemToAdd;
	};
	{
		private _amount = _x select 1;
		private _itemWeight = ([_x select 0, 'weight'] call A3PL_Config_GetItem) * _amount;
		private _return = _return + _itemWeight;
	} forEach _inventory;
	_return;
}] call Server_Setup_Compile;