/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Inventory_Get", {
	private _player = param [0,player];
	private _inv = _player getVariable ["player_inventory",[]];
	_inv;
}] call Server_Setup_Compile;

["A3PL_Inventory_GetCash", {
	private _player = param [0,player];
	private _cash = _player getvariable ["player_cash",0];
	_cash;
}] call Server_Setup_Compile;

["A3PL_Inventory_Clear",
{
	private _obj = param [0,Player_Item];
	private _delete = param [1,true];
	private _setNull = param [2,true];
	if (_delete) then {
		deleteVehicle _obj;
	};
	if (_setNull) then {
		Player_Item = objNull;
		Player_ItemClass = '';
	};
}] call Server_Setup_Compile;

["A3PL_Inventory_Add", {
	private _class = param [0,""];
	private _amount = param [1,0];
	private _exit = false;
	if(_amount > 0) then {
		if (([[_class,_amount]] call A3PL_Inventory_TotalWeight) > Player_MaxWeight) exitwith {
			_exit = true;
			[format [localize"STR_NewInventory_1",Player_MaxWeight],"red"] call A3PL_Player_Notification;
		};
	};
	if(_exit) exitwith {};
	[player, _class, _amount] remoteExec ["Server_Inventory_Add",2];
}] call Server_Setup_Compile;

["A3PL_Inventory_SetCurrent", {
	private _weight = [] call A3PL_Inventory_TotalWeight;
	if(_weight < 200) then {
		if(isForcedWalk player) then {player forceWalk false;};
	} else {
		if(!isForcedWalk player) then {player forceWalk true;};
	};
}] call Server_Setup_Compile;

["A3PL_Inventory_Remove", {
	private _class = param [0,""];
	private _amount = param [1,1];
	[_class, -(_amount)] call A3PL_Inventory_Add;
}] call Server_Setup_Compile;

["A3PL_Inventory_Verify", {
	private _player = param [0,player];
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
	[] call A3PL_Inventory_SetCurrent;
}] call Server_Setup_Compile;

["A3PL_Inventory_Return", {
	private _class = param [0,""];
	private _player = param [1,player];
	private _amount = [(_player getVariable ["Player_Inventory",[]]), _class, 0] call BIS_fnc_getFromPairs;
	_amount;
}] call Server_Setup_Compile;

["A3PL_Inventory_Has", {
	private _class = param [0,""];
	private _amount = param [1,1];
	private _player = param [2,player];
	if (_class isEqualTo "cash") exitwith {if (_player getVariable ["player_cash",0] >= _amount) then {true;} else {false;};};
	private _inventoryAmount = [_class,_player] call A3PL_Inventory_Return;
	if (_inventoryAmount < _amount) exitWith {false};
	true
}] call Server_Setup_Compile;

["A3PL_Inventory_TotalWeight",
{
	private ["_inventory"];
	private _return = 0;
	private _itemToAdd = _this;
	private _player = player;
	if (count _itemToAdd > 1) then {
		_itemToAdd = _itemToAdd select 0;
		_inventory = [(_itemToAdd select 1)] call A3PL_Inventory_Get;
	} else {
		_inventory = [player] call A3PL_Inventory_Get;
	};
	if (count _itemToAdd > 0) then {
		{
			_inventory = [_inventory, (_x select 0), (_x select 1), true] call BIS_fnc_addToPairs;
		} foreach _itemToAdd;
	};

	{
		private ["_amount", "_itemWeight"];
		_amount = _x select 1;
		_itemWeight = ([_x select 0, 'weight'] call A3PL_Config_GetItem) * _amount;
		_return = _return + _itemWeight;
	} forEach _inventory;
	_return;
}] call Server_Setup_Compile;

["A3PL_Inventory_Open", {
	if(player getVariable ["patdown",false]) then {[getPlayerUID player,"PatdownVirtCloningAtempt",[]] remoteExec ["Server_Log_New",2];};
	if(player getVariable ["patdown",false]) exitwith {[localize'STR_NewInventory_2',"red"] call A3PL_Player_Notification;};
	if(player getVariable["inventory_opened",false]) exitWith {};

	if((vehicle player == player) && (!(animationState player IN ["crew"]))) then {
		player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon';
	};

	player setVariable ["inventory_opened", true, true];

	['Dialog_Inventory'] call A3PL_Lib_CreateDialog;

	[] call A3PL_Inventory_Populate;
	[] spawn {
		_hndl = ppEffectCreate ['dynamicBlur', 505];
		_hndl ppEffectEnable true;
		_hndl ppEffectAdjust [5];
		_hndl ppEffectCommit 0;

		waitUntil {isNull findDisplay 1001};
	  if(!([player,"head","pepper_spray"] call A3PL_Medical_HasWound)) then {
		ppEffectDestroy _hndl;
		};
		player setVariable ["inventory_opened", false, true];
	};
}] call Server_Setup_Compile;

["A3PL_Inventory_Populate", {
	private ['_display','_keys',"_cash"];
	_display = findDisplay 1001;

	buttonSetAction [14671, "[] call A3PL_Inventory_Use"];
	buttonSetAction [14672,
	"
		private ['_display','_amount'];
		_amount = parseNumber (ctrlText 14471);
		if (_amount <= 0) exitwith {[localize'STR_NewInventory_3','red'] call A3PL_Player_Notification;};
		['',true] call A3PL_Inventory_Use;
		[true,_amount] call A3PL_Inventory_Drop;
	"];
	buttonSetAction [14674, "[0] call A3PL_Lib_CloseDialog"];

	_control = _display displayCtrl 14571;
	{
		private ["_itemName", "_amount", "_index","_itemWeight"];
		_itemName = [_x select 0, "name"] call A3PL_Config_GetItem;
		_amount = _x select 1;
		_itemWeight = ([_x select 0, "weight"] call A3PL_Config_GetItem) * _amount;

		_index = _control lbAdd format["%2 %1 (%3 lbs)", _itemName, _amount, _itemWeight];
		_control lbSetData [_index, _x select 0];
	} forEach ([] call A3PL_Inventory_Get);

	_capacity = round(((call A3PL_Inventory_TotalWeight)/Player_MaxWeight)*100);
	_capColor = switch(true) do {
		case (_capacity < 20): {"#00FF00"};
		case (_capacity >= 50): {"#FFFF00"};
		case (_capacity >= 75): {"#FFA500"};
		case (_capacity >= 100): {"#ff0000"};
		default {"#ffffff"};
	};
	_control = _display displayCtrl 14072;
	_control ctrlSetStructuredText parseText format["<t font='PuristaSemiBold' align='left' size='1.35'>Capacity : <t color='%3'>%1%2</t></t>", _capacity, "%", _capColor];

	_control = _display displayCtrl 14471;
	_control ctrlSetText "1";

	_keys = player getVariable "keys";
	if (isNil "_keys") exitwith {};
	{
		_count = count _x;
		if (count _x == 4) then {
				_index = lbAdd [1900,format ["Greenhouse Key (%1)",_x]];
				lbSetData [1900, _index,_x];
		};
		if (count _x == 5) then {
				_index = lbAdd [1900,format ["House Key (%1)",_x]];
				lbSetData [1900, _index,_x];
		};
		if (count _x == 6) then
		{
			_index = lbAdd [1900,"Motel Key"];
			lbSetData [1900, _index,_x];
		};
		if (count _x == 8) then {
				_index = lbAdd [1900,format ["Warehouse Key (%1)",_x]];
				lbSetData [1900, _index,_x];
		};

	} forEach (player getVariable ["keys",[]]);

	if(count(player getVariable ["licenses",[]]) == 0) then {
		lbAdd [1503,"No License"];
	} else {
		{
			lbAdd [1503,([_x,"name"] call A3PL_Config_GetLicense)];
		} forEach (player getVariable ["licenses",[]]);
	};

	_cash = player getVariable "Player_Cash";
	if (isNil "_cash") exitwith {};
	if (_cash == 0) exitwith {};
	_index = lbAdd [14571, format["$%1", [player getVariable ["Player_Cash",0]] call A3PL_Lib_MoneyFormat]];
	lbSetData [14571, _index, "cash"];
}] call Server_Setup_Compile;

["A3PL_Inventory_Use",
{
	disableSerialization;
	private ['_selection', '_classname', '_itemClass', '_itemDir', '_canUse', '_format',"_display","_attach"];
	_className = param [0,""];
	_forDrop = param [1,false];
	_amount = 1;
	if (_className isEqualTo "") then
	{
		_display = findDisplay 1001;
		_selection = lbCurSel 14571;
		_classname = lbData [14571, _selection];
		_amount = floor(parseNumber (ctrlText (_display displayCtrl 14471)));
	};

	_itemClass = [_classname, 'class'] call A3PL_Config_GetItem;
	_itemDir = [_classname, 'dir'] call A3PL_Config_GetItem;
	_canUse = [_classname, 'canUse'] call A3PL_Config_GetItem;
	_attach = [_classname, 'attach'] call A3PL_Config_GetItem;
	_maxTake = [_classname, 'maxTake'] call A3PL_Config_GetItem;

	if ((_selection isEqualTo -1) && (!isNil "_display")) exitWith {};
	if (_canUse isEqualTo false) exitWith {[localize"STR_NewInventory_4", "red"] call A3PL_Player_Notification;};
	if ((animationState player) isEqualTo "A3PL_TakenHostage") exitwith {[localize"STR_NewInventory_5","red"] call A3PL_Player_Notification;};
	if (!(player isEqualTo (vehicle player))) exitwith {[localize"STR_NewInventory_6", "red"] call A3PL_Player_Notification;};
	if (animationState player IN ["a3pl_handsuptokneel","a3pl_handsupkneelgetcuffed","a3pl_cuff","a3pl_handsupkneelcuffed","a3pl_handsupkneelkicked","a3pl_cuffkickdown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","a3pl_handsupkneel"]) exitWith {[localize"STR_NewInventory_7", "red"] call A3PL_Player_Notification;};
	if (!(isNull Player_Item)) then {[false] call A3PL_Inventory_PutBack;};

	
	if(_amount < 1) exitWith {[localize"STR_NewInventory_11","red"] call A3PL_Player_Notification;};
	if (!([_classname,_amount] call A3PL_Inventory_Has)) exitwith {[localize"STR_NewInventory_11","red"] call A3PL_Player_Notification;};

	_maxTakeErr = false;
	if(!_forDrop) then {
		if (_amount > _maxTake) exitwith {
			[format["You can only take %1 of this item at once",_maxTake],"red"] call A3PL_Player_Notification;
			_maxTakeErr = true;
		};
	};
	if(_maxTakeErr) exitWith {};

	Player_ItemAmount = _amount;
	Player_Item = _itemClass createVehicle (getPos player);
	if (_classname isEqualTo "popcornbucket") then {
		Player_Item attachTo [player, _attach, 'LeftHand'];
	} else {
		Player_Item attachTo [player, _attach, 'RightHand'];
	};

	if (((vehicle player) isEqualTo player) && (!(animationState player IN ["crew"]))) then {player playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWpstDnon';};

	Player_Item setDir _itemDir;
	Player_ItemClass = _classname;
	if (!isNil "_display") then {[0] call A3PL_Lib_CloseDialog;};

	[Player_Item,_attach] spawn A3PL_Placeable_AttachedLoop;
	_format = format[localize'STR_NewInventory_9', Player_ItemAmount, [Player_ItemClass, 'name'] call A3PL_Config_GetItem];
	[_format, "yellow"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Inventory_PutBack", {
	private ['_itemClass', '_displayNotification', '_format'];
	_itemClass = Player_ItemClass;
	_displayNotification = [_this, 0, true, [true]] call BIS_fnc_param;

	if (_itemClass isEqualTo "") exitwith {["There is no itemClass assigned", "red"] call A3PL_Player_Notification;};

	detach Player_Item;
	deleteVehicle Player_Item;

	Player_Item = objNull;
	Player_ItemClass = '';
	Player_ItemAmount = nil;
	if (_displayNotification isEqualTo true) then {
		if (!(animationState player IN ["crew"])) then {
			player playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWpstDnon';
		};
		_format = format[localize"STR_NewInventory_10", [_itemClass, 'name'] call A3PL_Config_GetItem];
		[_format, "yellow"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Inventory_Drop", {
	private _setPos = param [0,true];
	private _amount = param [1,1];
	private _itemClass = param [2,Player_ItemClass];;
	private _obj = Player_Item;
	private _droppedItems = server getVariable 'droppedObjects';
	if(!isNil 'Player_ItemAmount') then {_amount = Player_ItemAmount;};

	if(_amount < 1) exitWith {["Please enter a valid amount","red"] call A3PL_Player_Notification;};
	if (!([_itemClass,_amount] call A3PL_Inventory_Has)) exitwith {[localize"STR_NewInventory_11","red"] call A3PL_Player_Notification;};

	if (isNull _obj) exitwith
	{
		[localize"STR_NewInventory_12","red"] call A3PL_Player_Notification;
	};

	if (!isNil "Player_isEating") exitwith
	{
		[localize"STR_NewInventory_13","red"] call A3PL_Player_Notification;
	};

	if (!isNil "Player_isDrinking") exitwith
	{
		[localize"STR_NewInventory_25","red"] call A3PL_Player_Notification;
	};

	if (!(animationState player IN ["crew"])) then
	{
		player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
	};

	if (_setPos) then
	{
		if(_itemClass == "FD_Mask") then {
			deleteVehicle _obj;
			_holder = createVehicle ["GroundWeaponHolder", getposATL player, [], 0, "CAN_COLLIDE"];
			_holder addItemCargoGlobal ["A3PL_FD_Mask",1];
		} else {
			detach _obj;
			_obj setPosASL (AGLtoASL (player modelToWorld [0,1,0]));
		};
	};

	Player_Item = objNull;
	Player_ItemClass = '';

	switch (_itemclass) do
	{
		case "doorkey": {[_obj, player] remoteExec ['Server_Housing_dropKey', 2];};
		case "cash": {[player,_obj,_itemClass,Player_ItemAmount] remoteExec ["Server_Inventory_Drop", 2];};
		default {[player,_obj,_itemClass,_amount] remoteExec ["Server_Inventory_Drop", 2];};
	};

	_format = format[localize"STR_NewInventory_14", _amount, [_itemClass, 'name'] call A3PL_Config_GetItem];
	[_format, "green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Inventory_Pickup", {
	private ["_obj", "_format","_exit","_attachedTo","_canPickup","_amount"];
	_obj = param [0,objNull];
	_moveToHand = param [1,false];

	if (isNull _obj) exitwith {[localize"STR_NewInventory_15", "red"] call A3PL_Player_Notification;};

	_classname = _obj getVariable "class";
	if (isNil "_classname") exitwith {[localize"STR_NewInventory_16", "red"] call A3PL_Player_Notification;};

	if (!isNull Player_Item) exitwith {
		_format = format[localize"STR_NewInventory_17"];
		[_format, "red"] call A3PL_Player_Notification;
	};

	_attachedTo = attachedTo _obj;
	if (!isNull _attachedTo) then {
		if ((isPlayer _attachedTo) && (!(_attachedTo isKindOf "Car"))) then {
			_exit = true;
		};
	};
	if (!isNil "_exit") exitwith {
		_format = format[localize"STR_NewInventory_18"];
		[_format, "red"] call A3PL_Player_Notification;
	};

	_canPickup = true;
	if (((count (_obj getVariable ["ainv",[]])) != 0) OR ((count (_obj getVariable ["finv",[]])) != 0)) exitwith {
		[_obj] call A3PL_Placeables_Pickup;
	};
	_canPickup = [_classname,"canPickup"] call A3PL_Config_GetItem;
	if (!_canPickup) exitwith
	{
		[_obj] call A3PL_Placeables_Pickup;
	};

	if (typeOf _obj == "A3PL_FD_HoseEnd1_Float") then
	{
		private ["_hydrant"];
		_hydrant = (nearestObjects [_obj,["Land_A3PL_FireHydrant"], 1]) select 0;
		if (!isNil "_hydrant") then
		{
			_hydrant animateSource ["cap_hide",0];
		};
	};

	if (_classname == "apple" && !simulationEnabled _obj) exitwith {[_obj] spawn A3PL_Resources_Picking;};
	if (_classname == "shrooms" && !simulationEnabled _obj) exitwith {[_obj] spawn A3PL_Shrooms_Pick;};

	player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';

	if (player_objIntersect getVariable ["inUse",false]) exitWith {};
	player_objIntersect setVariable ["inUse",true,true];

	_amount = _obj getVariable ["amount",1];
	switch (_classname) do {
		case "doorkey": {[_obj, player] remoteExecCall ["Server_Housing_PickupKey", 2];};
		case "cash": {[player, _obj] remoteExecCall ["Server_Inventory_Pickup", 2]};
		default {[player, _obj, _amount] remoteExecCall ["Server_Inventory_Pickup", 2];};
	};

	if (_moveToHand) then
	{
		[_classname] call A3PL_Inventory_Use;
	};

	_format = format[localize"STR_NewInventory_19",_amount, [_classname, "name"] call A3PL_Config_GetItem];
	[_format, "green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Inventory_Throw", {
	[] spawn {
		private ['_obj', '_itemClass', '_playerVelocity', '_playerDir'];

		_obj = Player_Item;
		_itemClass = Player_ItemClass;

		if(_itemClass in ["A3PL_BucketFull","A3PL_Bucket","bucket_empty","bucket_full"]) exitWith {
			[localize"STR_NewInventory_20","red"] call A3PL_Player_Notification;
		};

		if (isNull _obj) exitwith
		{
			[localize"STR_NewInventory_21","red"] call A3PL_Player_Notification;
		};

		if (!isNil "Player_isEating") exitwith
		{
			[localize"STR_NewInventory_22","red"] call A3PL_Player_Notification;
		};

		if (!isNil "Player_isDrinking") exitwith
		{
			[localize"STR_NewInventory_25","red"] call A3PL_Player_Notification;
		};

		if (count (player nearObjects ["A3PL_Container_Ship", 100]) > 0) exitwith
		{
			[localize"STR_NewInventory_23","red"] call A3PL_Player_Notification;
		};

		player playaction "Gesture_throw";

		sleep 0.5;

		detach _obj;

		_playerVelocity = velocity player;
		_playerDir = direction player;

		_obj setVelocity [((_playerVelocity select 0) + (sin _playerDir * 7)), ((_playerVelocity select 1) + (cos _playerDir * 7)), ((_playerVelocity select 2) + 7)];

		switch (_itemClass) do {
			case "doorkey": {[_obj, player] remoteExec ['Server_Housing_dropKey', 2];};
			case "cash": {[player,_obj,_itemClass,Player_ItemAmount] remoteExec["Server_Inventory_Drop", 2];};
			default {[player,_obj,_itemClass] remoteExec["Server_Inventory_Drop", 2];};
		};

		Player_Item = objNull;
		Player_ItemClass = '';
	};
}] call Server_Setup_Compile;

["A3PL_Inventory_CanTake", {
	private ["_player", "_item","_amount","_itemToAdd","_inventory","_return"];

	_player = param [0,objNull];
	_item = param [1,""];
	_amount = param [2,1];
	_itemToAdd = [_item,_amount];
	_inventory = [_player] call A3PL_Inventory_Get;

	{
		_inventory = [_inventory, (_x select 0), (_x select 1), true] call BIS_fnc_addToPairs;
	} foreach _itemToAdd;
	_return = 0;
	{
		private ["_amount", "_itemWeight"];
		_amount = _x select 1;
		_itemWeight = ([_x select 0, 'weight'] call A3PL_Config_GetItem) * _amount;
		_return = _return + _itemWeight;
	} forEach _inventory;

	if(_return > 800) then {
		_can = false;
	} else {
		_can = true;
	};
	_can;
}] call Server_Setup_Compile;