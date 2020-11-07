/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Shop_Open",
{
	private ["_shop","_display","_currency","_control","_pos","_posConfig","_cam"];
	_shop = param [0,""];
	_currency = param [1,"player_cash"];
	_npc = param [2, cursorobject];

	disableSerialization;
	if(player getVariable ["inventory_opened",false]) exitwith {
		[getPlayerUID player,"InventoryShopCloningAttempt",[]] remoteExec ["Server_Log_New",2];
		['Please close this and try to re-open',"red"] call A3PL_Player_Notification;
	};
	if (!(player_itemClass isEqualTo "")) exitwith {
		[getPlayerUID player,"InventoryShopOpenWithItemAttempt",[]] remoteExec ["Server_Log_New",2];
		['Drop what you have on hand and try again',"red"] call A3PL_Player_Notification;
	};

	_posConfig = [_shop,"pos"] call A3PL_Config_GetShop;
	if (typeName _posConfig isEqualTo "CODE") then {_pos = call _posConfig;};
	if (typeName _posConfig isEqualTo "OBJECT") then {_pos = getposASL _posConfig;};

	createDialog "Dialog_Shop";
	_display = findDisplay 20;

	_allItems = [_shop] call A3PL_Config_GetShop;
	_control = _display displayCtrl 1500;
	{
		private ["_itemType","_itemClass","_itemName"];
		_itemType = _x select 0;
		_itemClass = _x select 1;
		switch (_itemType) do
		{
			case ("item"):{_itemName = [_itemClass,"name"] call A3PL_Config_GetItem;};
			case ("aitem"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
			case ("backpack"): { _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
			case ("uniform"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
			case ("vest"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
			case ("headgear"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
			case ("vehicle"): { _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
			case ("plane"): { _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
			case ("weapon"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
			case ("weaponPrimary"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
			case ("magazine"): { _itemName = getText (configFile >> "CfgMagazines" >> _itemClass >> "displayName");};
			case ("goggles"): { _itemName = getText (configFile >> "CfgGlasses" >> _itemClass >> "displayName");};
		};

		if ([_itemClass,"canPickup"] call A3PL_Config_GetItem) then {
			_amount = [_itemClass] call A3PL_Inventory_Return;
			if(_amount > 0) then {
				_i = _control lbAdd format["%1 (Inv: %2x)",_itemName,_amount];
			} else {
				_i = _control lbAdd _itemName;
			};
		} else {
			if(_itemType in ["vehicle","plane"]) then {
				_objects = nearestObjects [player,[_itemClass],10,true];
				if((count _objects) > 0) then {
					_i = _control lbAdd format ["%1 (Near: %2x)",_itemName,(count _objects)];
				} else {
					_i = _control lbAdd format ["%1",_itemName];
				};
			} else {
				_i = _control lbAdd _itemName;
			};
		};
		if(!isNil "_i") then {_control lbSetData [_i,_itemClass];};
	} foreach _allItems;

	_control = _display displayCtrl 1602;
	_control ctrlAddEventHandler ["ButtonDown",format ["['%1','%2'] call A3PL_Shop_Buy;",_shop,_currency]];
	_control = _display displayCtrl 1603;
	_control ctrlAddEventHandler ["ButtonDown",format ["['%1','%2'] call A3PL_Shop_Sell;",_shop,_currency]];
	_control = _display displayCtrl 1500;
	_control ctrlAddEventHandler ["LBSelChanged",format ["['%1', '%2'] spawn A3PL_Shop_ItemSwitch;",_shop, _currency]];

	A3PL_SHOP_CAMERA = "camera" camCreate (ASLToAGL eyePos _npc);
	A3PL_SHOP_CAMERA camSetRelPos [0,0,0];
	A3PL_SHOP_CAMERA cameraEffect ["internal", "BACK"];
	A3PL_SHOP_CAMERA camCommit 0;
	showCinemaBorder false;

	A3PL_SHOP_NPC = _npc;

	[_shop, _currency] spawn A3PL_Shop_ItemSwitch;
	_control = _display displayCtrl 1500;
	_control lbSetCurSel 0;

	[A3PL_SHOP_CAMERA] spawn
	{
		disableSerialization;
		_display = findDisplay 20;
		waitUntil { isNull _display };
		deleteVehicle A3PL_SHOP_ITEMPREVIEW;
		{deleteVehicle _x;} foreach _this;
		A3PL_SHOP_ITEMPREVIEW = nil;
		player cameraEffect ["terminate", "BACK"];
	};

	_control = _display displayCtrl 1900;
	_control sliderSetRange [-180, 180];
	_control sliderSetPosition 0;
	_control ctrlAddEventHandler ["SliderPosChanged",
	{
		A3PL_SHOP_ITEMPREVIEW setDir (param [1,180]);
	}];
}] call Server_Setup_Compile;

["A3PL_Shop_Buy",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_taxed","_display","_control","_shop","_currency","_allItems","_price","_item","_itemBuy","_itemType","_itemClass","_itemName","_amount","_totalPrice","_stockCheck","_index"];
	_shop = param [0,""];
	_shopObject = cursorobject;
	_currency = param [1,"player_cash"];
	_display = findDisplay 20;
	_allItems = [_shop] call A3PL_Config_GetShop;
	_taxedAmount = 0;

	_control = _display displayCtrl 1500;
	_index = lbCurSel _control;
	if(_index < 0) exitwith {};
	_item = _allItems select _index;
	_itemType = _item select 0;
	_itemClass = _item select 1;
	_itemBuy = _item select 2;

	_amount = 1;
	if (_itemType IN ["item","magazine"]) then
	{
		_control = _display displayCtrl 1400;
		_amount = parseNumber (ctrlText _control);
	};
	if (_amount < 1) exitwith {[localize "STR_SHOP_ENTERVALAMOUNT","red"] call A3PL_Player_Notification;};

	_stockCheck = true;
	if (_shop IN Config_Shops_StockSystem) then
	{
		if (isNull _shopObject) exitwith {_stockCheck = false};
		if (((_shopObject getVariable ["stock",[]]) select _index) < _amount) then {_stockCheck = false;};
	};
	if (!_stockCheck) exitwith {["There is not enough stock available to buy this item!","red"] call A3PL_Player_Notification;};

	_totalPrice = round(_itemBuy*_amount);
	_taxed = [_shop] call A3PL_Config_isTaxed;
	if(_taxed) then {
		_taxName = [_shop, "tax"] call A3PL_Config_GetTaxSeting;
		_totalPrice = _totalPrice + floor(_totalPrice*([_taxName] call A3PL_Config_GetTaxes));
	};

	_moneyCheck = false;
	switch (_currency) do
	{
		case ("candy"):
		{
			if (["candy",_totalprice] call A3PL_Inventory_Has) then {_moneyCheck = true;} else {
				[format[localize "STR_SHOP_NOTENOUGHCANDY",_totalprice-(["candy"] call A3PL_Inventory_Return)],"red"] call A3PL_Player_Notification;
			};
		};
		case ("gift"):
		{
			if (["gift",_totalprice] call A3PL_Inventory_Has) then {_moneyCheck = true;} else {
				[format[localize "STR_SHOP_NOTENOUGHGIFT",_totalprice-(["gift"] call A3PL_Inventory_Return)],"red"] call A3PL_Player_Notification;
			};
		};
		case ("dirty_cash"):
		{
			if (["dirty_cash",_totalPrice] call A3PL_Inventory_Has) then {_moneyCheck = true;} else {
				[format[localize "STR_SHOP_NOTENOUGHDIRTYMONEY",_totalprice-(["dirty_cash"] call A3PL_Inventory_Return)],"red"] call A3PL_Player_Notification;
			};
		};
		default
		{
			if ((player getVariable [_currency,0]) >= _totalPrice) then {_moneyCheck = true;} else {
				[format[localize "STR_SHOP_NOTENOUGHMONEY",_totalPrice-(player getVariable [_currency,0])],"red"] call A3PL_Player_Notification;
			};
		};
	};
	if (!_moneyCheck) exitwith {};

	if (_shop IN Config_Shops_StockSystem) then
	{
		[_shopObject,_index,_amount] call A3PL_ShopStock_Decrease;
	};

	_itemName = "UNKNOWN";
	_canTake = true;
	switch (_itemType) do
	{
		case ("item"):
		{
			if ([_itemClass,"canPickup"] call A3PL_Config_GetItem) then
			{
				if(([[_itemClass,_amount]] call A3PL_Inventory_TotalWeight) <= Player_MaxWeight) then {
					[_itemClass,_amount] call A3PL_Inventory_Add;
				} else {
					_canTake = false;
				};
			} else
			{
				private ["_veh"];
				_veh = createVehicle [([_itemClass,"class"] call A3PL_Config_GetItem), getposATL player, [], 0, "CAN_COLLIDE"];
				if (!([_itemClass,"simulation"] call A3PL_Config_GetItem)) then
				{
					[_veh] remoteExec ["Server_Vehicle_EnableSimulation",2];
				};
				if(_itemClass IN ["SMG_Part_Body","SMG_Part_Trigger","SMG_Part_Barrel","SMG_Part_Stock","SMG_Part_Grip"]) then
				{
					_veh setVariable ["ainv",["item",_itemClass,1],true];
				};
				_veh setVariable ["class",_itemClass,true];
				_veh setVariable ["owner",getPlayerUID player,true];
			};
			_itemName = [_itemClass,"name"] call A3PL_Config_GetItem;
		};
		case ("backpack"): {player addBackPack _itemClass; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("uniform"): {player addUniform _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("vest"): {player addVest _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("headgear"): {player addHeadgear _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("aitem"): {player addItem _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("vehicle"): {[player,[_itemClass,1],"","car"] remoteExec ["Server_Factory_Create", 2]; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("plane"): {[player,[_itemClass,1],"","plane"] remoteExec ["Server_Factory_Create", 2]; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("weapon"): {
			_itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");
			if(_itemClass isEqualTo "A3PL_FireExtinguisher") then {
				player addWeapon _itemClass;
				uiSleep 0.1;
				player addMagazines["A3PL_Extinguisher_Water_Mag", 1];
			} else {
				player addItem _itemClass;
			};
		};
		case ("weaponPrimary"): {player addWeapon _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("magazine"): {player addMagazines [_itemClass, _amount];_itemName = getText (configFile >> "CfgMagazines" >> _itemClass >> "displayName");};
		case ("goggles"): {player addGoggles _itemClass; _itemName = getText (configFile >> "CfgGlasses" >> _itemClass >> "displayName");};
	};
	if(!_canTake) exitWith {[format [localize "STR_SHOP_NOTENOUGHSPACE",_amount, _itemName],"red"] call A3PL_Player_Notification;};

	switch (_currency) do
	{
		case ("candy"):
		{
			["candy",-(_totalPrice)] call A3PL_Inventory_Add;
			[format [localize "STR_SHOP_BOUGHTITEMCANDY",_itemName,_totalPrice,(["candy"] call A3PL_Inventory_Return),_amount],"green"] call A3PL_Player_Notification;
		};
		case ("gift"):
		{
			["gift",-(_totalPrice)] call A3PL_Inventory_Add;
			[format [localize "STR_SHOP_BOUGHTITEMGIFT",_itemName,_totalPrice,(["gift"] call A3PL_Inventory_Return),_amount],"green"] call A3PL_Player_Notification;
		};
		case ("dirty_cash"):
		{
			["dirty_cash",-(_totalPrice)] call A3PL_Inventory_Add;
			[format [localize "STR_SHOP_BOUGHTITEMDIRTYMONEY",_itemName,_totalPrice,(["dirty_cash"] call A3PL_Inventory_Return)-_totalPrice,_amount],"green"] call A3PL_Player_Notification;
		};
		default
		{
			_isGangControlled = [_shopObject] call A3PL_Gang_GangTax;
			if(!(isNil "_isGangControlled")) then {
				_taxedAmount = _totalPrice / 100 * 5;
				[(_isGangControlled select 0),round(_taxedAmount)] remoteExec ["Server_Gang_UpdateGangBalance",2];
				[(_isGangControlled select 0),round(_taxedAmount),"purchased"] remoteExec ["Server_Gang_NotifyPurchase",2];

			};
			if(_taxed) then {
				_taxBudget = [_shop, "tax"] call A3PL_Config_GetTaxSeting;
				_taxName = [_shop, "tax"] call A3PL_Config_GetTaxSeting;
				_taxes = [_taxName] call A3PL_Config_GetTaxes;

				[format [localize "STR_SHOP_BOUGHITEMCASHTAXES",_itemName,[(_totalPrice + _taxedAmount), 1, 0, true] call CBA_fnc_formatNumber,[((player getVariable [_currency,0]) - _totalPrice + _taxedAmount), 1, 0, true] call CBA_fnc_formatNumber,_amount, _taxes*100, [floor(_totalPrice*_taxes), 1, 0, true] call CBA_fnc_formatNumber, "%"],"green"] call A3PL_Player_Notification;
				[_taxBudget,floor(_totalPrice*_taxes)] remoteExec ["Server_Government_AddBalance",2];
			} else {
				[format [localize "STR_SHOP_BOUGHITEMCASH",_itemName,[(_totalPrice + _taxedAmount), 1, 0, true] call CBA_fnc_formatNumber,[((player getVariable [_currency,0]) - _totalPrice + _taxedAmount), 1, 0, true] call CBA_fnc_formatNumber,_amount],"green"] call A3PL_Player_Notification;
			};
			player setVariable [_currency,((player getVariable [_currency,0]) - _totalPrice + _taxedAmount),true];
		};
	};

	[_shop, _currency] spawn A3PL_Shop_ItemSwitch;
	[getPlayerUID player,"buyShop",[_itemName,_amount]] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_Shop_Sell",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_shop","_has","_allItems","_price","_currency","_item","_itemBuy","_itemSell","_itemType","_itemClass","_itemName","_index","_display","_isAbove"];
	_shop = param [0,""];
	_currency = param [1,"player_cash"];
	_shopObject = cursorobject;
	_taxedAmount = 0;

	_display = findDisplay 20;
	_allItems = [_shop] call A3PL_Config_GetShop;


	_control = _display displayCtrl 1500;
	_index = lbCurSel _control;
	if(_index < 0) exitwith {};
	_item = _allItems select _index;
	_itemType = _item select 0;
	_itemClass = _item select 1;
	_itemSell = _item select 3;

	_amount = 1;
	if (_itemType IN ["item","magazine"]) then
	{
		_control = _display displayCtrl 1400;
		_amount = parseNumber (ctrlText _control);
	};
	if (_amount < 1) exitwith {[localize "STR_SHOP_ENTERVALAMOUNT","red"] call A3PL_Player_Notification;};
	if(_itemClass IN ["log","cocaine_brick"] && _amount > 1) exitwith {["You can only sell one item at a time!","red"] call A3PL_Player_Notification;};

	_isAbove = false;
	if (_shop IN Config_Shops_StockSystem) then
	{
		private ["_stockVar","_newStock"];
		_stockVar = cursorobject getVariable ["stock",[]];
		_newStock = (_stockVar select _index)+_amount;
		if (_newStock > 500) then {_isAbove = true;};
	};
	if (_isAbove) exitwith
	{
		["Can not sell this item quantity because the store does not need more stock! (maximum stock of 500)","red"] call A3PL_Player_Notification;
	};

	if (_itemClass isEqualTo "net") exitwith {[localize "STR_SHOP_SELLNETS","red"] call A3PL_Player_Notification;};
	if (_itemClass isEqualTo "bucket_empty") exitwith {[localize "STR_SHOP_SELLEMPTYBUCKETS","red"] call A3PL_Player_Notification;};

	_itemName = "UNKNOWN";
	_has = false;
	switch (_itemType) do
	{
		case ("item"):
		{
			if ([_itemClass,_amount] call A3PL_Inventory_Has) then
			{
				[_itemClass,-(_amount)] call A3PL_Inventory_Add;
				_has = true;
			} else
			{
				if (!([_itemClass,"canPickup"] call A3PL_Config_GetItem)) then
				{
					_near = nearestObjects [player, [([_itemClass,"class"] call A3PL_Config_GetItem)], 20, true];
					{
						if ((_x getVariable "class") isEqualTo _itemClass) exitwith
						{
							deleteVehicle _x;
							_has = true;
						};
					} foreach _near;
				};
			};
			_itemName = [_itemClass,"name"] call A3PL_Config_GetItem;
		};
		case ("backpack"):
		{
			if ((backpack player) isEqualTo _itemClass) then
			{
				removeBackpack player;
				_itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");
				_has = true;
			};
		};
		case ("vehicle"):
		{
			private _vehicles = nearestObjects [player,["Car","Tank","Air","Plane","Ship"],20];
			private _vehicle = objNull;
			if ((count _vehicles) < 1) exitwith {["Please bring it closer to the store!","red"] call A3PL_Player_Notification;};
			{
				if (((typeOf _x) == _itemClass) && {((_x getVariable ["owner",[]]) select 0) isEqualTo (getPlayerUID player)}) exitwith {
					_vehicle = _x;
				};
			} foreach _vehicles;
			if (isNull _vehicle) exitwith {["Please bring it closer to the store! (Only the owner of the vehicle can sell it)","red"] call A3PL_Player_Notification;};
			[_vehicle] remoteExec ["Server_Vehicle_Sell",2];
			_itemName = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
			_has = true;
		};
		case ("plane"):
		{
			private _vehicles = nearestObjects [player,["Car","Tank","Air","Plane","Ship"],20];
			private _vehicle = objNull;
			if (count _vehicles < 1) exitwith {["You can not find your vehicle nearby! Thank you to bring it closer to the store to sell!"] call A3PL_Player_Notification;};
			{
				if (((_x getVariable ["owner",[]]) select 0) isEqualTo (getPlayerUID player) && (typeOf _x) isEqualTo _itemClass) exitwith {
					_vehicle = _x;
				};
			} foreach _vehicles;
			if (isNull _vehicle) exitwith {["You can not find your vehicle nearby! Thank you to bring it closer to the store to sell! (Only the owner of the vehicle can sell it)"] call A3PL_Player_Notification;};
			[_vehicle] remoteExec ["Server_Vehicle_Sell",2];
			_itemName = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
			_has = true;
		};
		case ("weapon"):
		{
			if (_itemClass IN (weapons player)) then
			{
				if(_itemClass isEqualTo (handgunWeapon player)) then {
					player removeWeapon _itemClass;
				} else {
					player removeItem _itemClass;
				};
				_itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");
				_has = true;
			};
		};
		case ("weaponPrimary"):
		{
			if (_itemClass IN (weapons player)) then
			{
				_itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");
				player removeWeapon _itemClass;
				_has = true;
			};
		};
		case ("magazine"):
		{
			_MagCount = {_x isEqualTo _itemClass} count magazines player;
			if(_MagCount >= _amount) then {
				_has = true;
				for "_i" from 0 to _amount do {player removeMagazine _itemClass;};
			};
			_itemName = getText (configFile >> "CfgMagazines" >> _itemClass >> "displayName");
		};
	};
	if (!_has) exitwith {[localize "STR_SHOP_DONTHAVEITEM","red"] call A3PL_Player_Notification;};
	if (_shop IN Config_Shops_StockSystem) then
	{
		[cursorobject,_index,_amount] call A3PL_ShopStock_Add;
	};

	switch (_currency) do
	{
		case ("candy"):
		{
			["candy",_itemSell] call A3PL_Inventory_Add;
			[format [localize "STR_SHOP_SOLDITEMCANDY",_itemName,_itemSell,(["candy"] call A3PL_Inventory_Return)],"green"] call A3PL_Player_Notification;
		};
		case ("gift"):
		{
			["gift",_itemSell] call A3PL_Inventory_Add;
			[format [localize "STR_SHOP_SOLDITEMGIFT",_itemName,_itemSell,(["gift"] call A3PL_Inventory_Return)],"green"] call A3PL_Player_Notification;
		};
		case ("dirty_cash"):
		{
			["dirty_cash",(_itemSell*_amount)] call A3PL_Inventory_Add;
			[format [localize "STR_SHOP_SOLDITEMDIRTYMONEY",_itemName,(_itemSell*_amount),(["dirty_cash"] call A3PL_Inventory_Return)+(_itemSell*_amount),_amount],"green"] call A3PL_Player_Notification;
		};
		default
		{
			_totalPrice = round(_itemSell*_amount);
			_taxed = [_shop] call A3PL_Config_isTaxed;
			_isGangControlled = [_shopObject] call A3PL_Gang_GangTax;
			if(!(isNil "_isGangControlled")) then {
				_taxedAmount = _totalPrice / 100 * 5;
				[(_isGangControlled select 0),round(_taxedAmount)] remoteExec ["Server_Gang_UpdateGangBalance",2];
				[(_isGangControlled select 0),round(_taxedAmount),"sold"] remoteExec ["Server_Gang_NotifyPurchase",2];

			};
			if(_taxed) then {
				_taxBudget = [_shop, "tax"] call A3PL_Config_GetTaxSeting;
				_taxName = [_shop, "tax"] call A3PL_Config_GetTaxSeting;
				_tAmount = [_taxName] call A3PL_Config_GetTaxes;

				_basePrice = _totalPrice;
				_totalPrice = round(_totalPrice - (_totalPrice*(_tAmount)));

				player setVariable [_currency,((player getVariable [_currency,0]) + _totalPrice - _taxedAmount),true];
				[format [localize "STR_SHOP_SOLDITEMTAXES",_itemName,[(_totalPrice - _taxedAmount), 1, 0, true] call CBA_fnc_formatNumber,_amount,_tAmount*100,[(floor(_basePrice-_totalPrice)), 1, 0, true] call CBA_fnc_formatNumber,"%"],"green"] call A3PL_Player_Notification;
				[_taxBudget,floor(_basePrice-_totalPrice)] remoteExec ["Server_Government_AddBalance",2];
			} else {
				player setVariable [_currency,((player getVariable [_currency,0]) + _totalPrice - _taxedAmount),true];
				[format [localize "STR_SHOP_SOLDITEM",_itemName,[(_totalPrice - _taxedAmount), 1, 0, true] call CBA_fnc_formatNumber,[(player getVariable [_currency,0]), 1, 0, true] call CBA_fnc_formatNumber,_amount],"green"] call A3PL_Player_Notification;
			};

			
		};
	};

	[_shop, _currency] spawn A3PL_Shop_ItemSwitch;
	[getPlayerUID player,"sellShop",[_itemName,_amount]] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_Shop_ItemSwitch",
{
	disableSerialization;
	private ["_display","_shop","_index","_allItems","_allItemsCount","_item","_itemType","_itemClass","_itemName","_ItemBuy","_itemSell","_pos","_posConfig","_itemObjectClass","_weaponHolder"];
	_shop = param [0,""];
	_currencyType = param [1,'player_cash'];

	_shopObject = A3PL_SHOP_NPC;

	_display = findDisplay 20;
	_control = _display displayCtrl 1500;
	_allItems = [_shop] call A3PL_Config_GetShop;

	_posConfig = [_shop,"pos"] call A3PL_Config_GetShop;
	if (typeName _posConfig isEqualTo "CODE") then {_pos = call _posConfig;};
	if (typeName _posConfig isEqualTo "OBJECT") then {_pos = getposASL _posConfig;};

	_index = lbCurSel _control;
	_item = _allItems select _index;
	if(_index < 0) exitwith {};
	_itemType = _item select 0;
	_itemClass = _item select 1;
	_itemBuy = _item select 2;
	_itemSell = _item select 3;
	_itemLevel = _item select 4;

	_isGangControlled = [_shopObject] call A3PL_Gang_GangTax;
	if(!(isNil "_isGangControlled")) then {
		_itemSell = _itemSell - (_itemSell / 100 * 5);
		_itemBuy = _itemBuy + (_itemBuy / 100 * 5);
	};

	_type = "item";
	switch (_itemType) do
	{
		case ("aitem"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("item"):
		{
			_itemName = [_itemClass,"name"] call A3PL_Config_GetItem;
			_itemObjectClass = [_itemClass,"class"] call A3PL_Config_GetItem;
			if (((_itemClass splitString "_") select 0) isEqualTo "furn") then {_type = "furn";};
		};
		case ("backpack"): { _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "backpack"; };
		case ("uniform"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "uniform"; };
		case ("vest"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "vest"; };
		case ("headgear"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "headgear"; };
		case ("vehicle"): { _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "vh"; };
		case ("plane"): { _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "vh"; };
		case ("weapon"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("weaponPrimary"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("magazine"): { _itemName = getText (configFile >> "CfgMagazines" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("goggles"): { _itemName = getText (configFile >> "CfgGlasses" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "goggles"; };
	};

	_stockCtrl = _display displayCtrl 1102;
	_priceBCtrl = _display displayCtrl 1100;
	_priceSCtrl = _display displayCtrl 1101;
	_buyBtn = _display displayCtrl 1602;
	_sellBtn = _display displayCtrl 1603;

	if (_shop IN Config_Shops_StockSystem) then {
		private ["_stockVar","_newStock"];
		_stockVar = _shopObject getVariable ["stock",[]];
		if((count _stockVar) isEqualTo 0) exitwith {closeDialog 0;['The stock is not properly defined for this shop (report this)',"red"] call A3PL_Player_Notification;};
		_stock = (_stockVar select _index);
		_stockCtrl ctrlSetStructuredText parseText format ["<t align='right'>%1</t>",_stock];
	} else {
		_stockCtrl ctrlSetStructuredText parseText format ["<t align='right'>Unlimited</t>"];
	};

	_currency = switch(_currencyType) do {
		case("gift"): {"Gift x"};
		case("candy"): {"Candy x"};
		default {"$"};
	};

	if(_itemBuy >= 0) then {
		if(_itemBuy isEqualTo 0) then {
			_priceBCtrl ctrlSetStructuredText parseText format ["<t align='right'>Free</t>"];
		} else {
			_priceBCtrl ctrlSetStructuredText parseText format ["<t align='right'>%1%2</t>",_currency, [_itemBuy, 1, 0, true] call CBA_fnc_formatNumber];
		};
		_buyBtn ctrlEnable true;
	} else {
		_priceBCtrl ctrlSetStructuredText parseText format ["<t align='right'>Not Purchasable</t>"];
		_buyBtn ctrlEnable false;
	};

	if(_itemSell >= 0) then {
		_priceSCtrl ctrlSetStructuredText parseText format ["<t align='right'>%1%2</t>",_currency, [_itemSell, 1, 0, true] call CBA_fnc_formatNumber];
		_sellBtn ctrlEnable true;
	} else {
		_priceSCtrl ctrlSetStructuredText parseText format ["<t align='right'>Unsaleable</t>"];
		_sellBtn ctrlEnable false;
	};

	_playerLevel = player getVariable["Player_Level",0];
	if(_playerLevel < _itemLevel) then {
		_priceBCtrl ctrlSetStructuredText parseText format ["<t align='right' color='#FD1703'>Level %1 needed</t>",_itemLevel];
		_priceSCtrl ctrlSetStructuredText parseText format ["<t align='right' color='#FD1703'>Level %1 needed</t>",_itemLevel];
		_buyBtn ctrlEnable false;
		_sellBtn ctrlEnable false;
	};

	if (!isNil "A3PL_SHOP_ITEMPREVIEW") then { deleteVehicle A3PL_SHOP_ITEMPREVIEW; uiSleep 0.1; };

	if(_type IN ["headgear","goggles","uniform","vest","backpack"]) then {
		A3PL_SHOP_ITEMPREVIEW = "C_man_p_beggar_F" createvehicleLocal [0,0,0];
		A3PL_SHOP_ITEMPREVIEW setPosASL [14321.1,15.9644,1017.32];
		A3PL_SHOP_ITEMPREVIEW enableSimulation false;

		A3PL_SHOP_ITEMPREVIEW setUnitLoadout (getUnitLoadout player);

		switch (_type) do {
			case("headgear"): {A3PL_SHOP_ITEMPREVIEW addHeadGear _itemClass;};
			case("goggles"): {A3PL_SHOP_ITEMPREVIEW addGoggles _itemClass;};
			case("uniform"): {A3PL_SHOP_ITEMPREVIEW addUniform _itemClass;};
			case("vest"): {A3PL_SHOP_ITEMPREVIEW addVest _itemClass;};
			case("backpack"): {A3PL_SHOP_ITEMPREVIEW addBackPack _itemClass;};
		};
		_type = "clothing";
	} else {
		switch (_type) do
		{
			case ("wh"):
			{
				A3PL_SHOP_ITEMPREVIEW = "groundWeaponHolder" createVehicleLocal (getpos Player);
				switch (_itemType) do
				{
					case ("weapon"): {A3PL_SHOP_ITEMPREVIEW addWeaponCargo [_itemClass,1];};
					case ("magazine"): {A3PL_SHOP_ITEMPREVIEW addMagazineCargo [_itemClass,1];};
					case ("aitem"): {A3PL_SHOP_ITEMPREVIEW addItemCargo [_itemClass,1];};
					case ("weaponitem"): {A3PL_SHOP_ITEMPREVIEW addItemCargo [_itemClass,1];};
					case ("secweaponitem"): {A3PL_SHOP_ITEMPREVIEW addItemCargo [_itemClass,1];};
				};
			};
			case default
			{
				A3PL_SHOP_ITEMPREVIEW = _itemObjectClass createVehicleLocal [_pos select 0,_pos select 1,(_pos select 2)+0.9];
				A3PL_SHOP_ITEMPREVIEW allowDamage false;
			};
		};
	};


	if(_type != "clothing") then {
		switch (_itemClass) do {
			case ("A3PL_Jaws"): { A3PL_SHOP_ITEMPREVIEW setposATL [_pos select 0,_pos select 1,(_pos select 2)+1.2]; };
			case default { A3PL_SHOP_ITEMPREVIEW setposATL [_pos select 0,_pos select 1,(_pos select 2)+0.9]; };
		};
		if ((typeName _posConfig) isEqualTo "OBJECT") then { A3PL_SHOP_ITEMPREVIEW setDir (getDir _posConfig); };
	};

	switch (_type) do
	{
		case ("vh"):
		{
			A3PL_SHOP_CAMERA camSetTarget A3PL_SHOP_ITEMPREVIEW;
			A3PL_SHOP_CAMERA camSetRelPos [6,7,0.3];
			A3PL_SHOP_CAMERA camCommit 0;
		};
		case ("furn"):
		{
			A3PL_SHOP_ITEMPREVIEW enableSimulation false;
			A3PL_SHOP_CAMERA camSetTarget A3PL_SHOP_ITEMPREVIEW;
			A3PL_SHOP_CAMERA camSetRelPos [2,3,1];
			A3PL_SHOP_CAMERA camCommit 0;
		};
		case ("clothing"):
		{
			A3PL_SHOP_CAMERA camSetTarget A3PL_SHOP_ITEMPREVIEW;
			A3PL_SHOP_CAMERA camSetRelPos [2,3,1];
			A3PL_SHOP_CAMERA camCommit 0;
		};
		case default
		{
			A3PL_SHOP_ITEMPREVIEW enableSimulation false;
			A3PL_SHOP_CAMERA camSetTarget A3PL_SHOP_ITEMPREVIEW;
			A3PL_SHOP_CAMERA camSetRelPos [-0.9,0.15,0.3];
			A3PL_SHOP_CAMERA camCommit 0;
		};
	};

	if (_itemType IN ["item","magazine"]) then
	{
		_control = _display displayCtrl 1400;
		_control ctrlSetText "1";
		_control ctrlSetFade 0;
		_control ctrlCommit 0;
		_control = _display displayCtrl 1000;
		_control ctrlSetFade 0;
		_control ctrlCommit 0;
	} else
	{
		_control = _display displayCtrl 1400;
		_control ctrlSetFade 1;
		_control ctrlCommit 0;
		_control = _display displayCtrl 1000;
		_control ctrlSetFade 1;
		_control ctrlCommit 0;
	};
}] call Server_Setup_Compile;
