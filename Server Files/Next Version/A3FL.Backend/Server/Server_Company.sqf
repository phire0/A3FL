/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Company_LoadAll",
{
	private _companies = ["SELECT id, name, boss, employees, bank, licenses FROM companies WHERE disabled = '0'", 2,true] call Server_Database_Async;
	Server_Companies = [];
	{
		Server_Companies pushback ([_x select 0, _x select 1, _x select 2, [_x select 3] call Server_Database_ToArray,_x select 4, [_x select 5] call Server_Database_ToArray]);
	} foreach _companies;
	publicVariable "Server_Companies";
},true] call Server_Setup_Compile;

["Server_Company_Create",
{
	private _uid = param [0,""];
	private _name = param [1,""];
	private _desc = param [2,""];
	private _employees = [[_uid, 0]];
	private _employees = [_employees] call Server_Database_Array;
	private _name = [_name] call Server_Database_EsapeString;
	private _desc = [_desc] call Server_Database_EsapeString;
	private _query = format ["INSERT INTO companies(name, description, boss, employees) VALUES ('%1','%2','%3','%4')",_name, _desc, _uid, _employees];
	[_query, 1] call Server_Database_Async;
	[] spawn {
		sleep 5;
		call Server_Company_LoadAll;
	};
},true] call Server_Setup_Compile;

["Server_Company_LoadBills",
{
	private _target = param [0,objNull];
	private _query = format ["SELECT * FROM companies_bills WHERE recipient_id='%1'",getPlayerUID _target];
	private _bills = [_query, 2, true] call Server_Database_Async;
	_target setVariable["player_bills", _bills,true];
},true] call Server_Setup_Compile;

["Server_Company_SetPay",
{
	private _id = param [0,-1];
	private _uid = param [1,""];
	private _pay = param [2,0];
	private _employees = [_id, "employees"] call A3PL_Config_GetCompanyData;
	{if((_x select 0) == _uid) exitWith {_employees set[_forEachIndex,[_x select 0, _pay]];};} foreach _employees;
	{
		if((_x select 0) == _id) exitWith {
			Server_Companies set[_forEachIndex,[_x select 0, _x select 1, _x select 2, _employees, _x select 4, _x select 5, _x select 6]];
		};
	} foreach Server_Companies;
	publicVariable "Server_Companies";
	_employees = [_employees] call Server_Database_Array;
	_query = format ["UPDATE companies SET employees = '%1' WHERE id = '%2'",_employees, _id];
	[_query, 1] call Server_Database_Async;
	{
		if((getPlayerUID _x) == _uid) exitWith {
			[format[localize "STR_SERVER_COMPANY_EMPLOYERCHANGEDSALARY",_pay], "green"] remoteExec ["A3PL_Player_Notification",_x];
		};
	} foreach (playableUnits);
},true] call Server_Setup_Compile;

["Server_Company_SetName",
{
	private _id = param [0,-1];
	private _name = param [1,""];
	private _query = format ["UPDATE companies SET name = '%1' WHERE id = '%2'",_desc, _id];
	[_query, 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Company_SetDesc",
{
	private _id = param [0,-1];
	private _desc = param [1,""];
	private _query = format ["UPDATE companies SET description = '%1' WHERE id = '%2'",_desc, _id];
	[_query, 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Company_SetBank",
{
	private _id = param [0,-1];
	private _change = param [1,0];
	private _extData = param [2,localize"STR_SERVER_COMPANY_UNKNOWNPROVENANCE"];
	private _query = format ["SELECT bank FROM companies WHERE id = '%1'",_id];
	private _actual = [_query, 2] call Server_Database_Async;
	private _bank = (_actual select 0) + _change;
	private _query = format ["UPDATE companies SET bank = '%1' WHERE id = '%2'",_bank, _id];
	[_query, 1] call Server_Database_Async;
	{
		if(_id == (_x select 0)) exitWith {
			Server_Companies set[_forEachIndex,[_x select 0, _x select 1, _x select 2, _x select 3, _bank, _x select 5, _x select 6]];
		};
	} foreach Server_Companies;
	publicVariable "Server_Companies";
	if(_extData != "") then {[_id,_change,_extData] call Server_Company_AddLog;};
},true] call Server_Setup_Compile;

["Server_Company_SetLicenses",
{
	private _id = param [0,-1];
	private _license = param [1,""];
	private _add = param [2,true];
	private _query = format ["SELECT licenses FROM companies WHERE id = '%1'",_id];
	private _licenses = [_query, 2] call Server_Database_Async;
	private _licenses = [(_licenses select 0)] call Server_Database_ToArray;
	if (_add) then {
		if (!(_license IN _licenses)) then {_licenses pushback _license;};
	} else {
		if (_license IN _licenses) then {_licenses = _licenses - [_license];};
	};
	private _query = format ["UPDATE companies SET licenses = '%1' WHERE id = '%2'",[_licenses] call Server_Database_Array, _id];
	[_query, 1] call Server_Database_Async;
	{
		if(_id == (_x select 0)) exitWith {
			Server_Companies set[_forEachIndex,[_x select 0, _x select 1, _x select 2, _x select 3, _x select 4, _licenses, _x select 6]];
		};
	} foreach Server_Companies;
	publicVariable "Server_Companies";
},true] call Server_Setup_Compile;

["Server_Company_Recruit",
{
	private _id = param [0,-1];
	private _uid = param [1,""];
	private _query = format ["SELECT employees FROM companies WHERE id = '%1'",_id];
	private _actual = [_query, 2] call Server_Database_Async;
	private _actual = [(_actual select 0)] call Server_Database_ToArray;
	_actual pushback [_uid,0];
	private _new = [_actual] call Server_Database_Array;
	private _query = format ["UPDATE companies SET employees = '%1' WHERE id = '%2'",_actual, _id];
	[_query, 1] call Server_Database_Async;
	{
		if(_id == (_x select 0)) exitWith {
			Server_Companies set[_forEachIndex,[_x select 0, _x select 1, _x select 2, _actual, _x select 4, _x select 5, _x select 6]];
		};
	} foreach Server_Companies;
	publicVariable "Server_Companies";

	_cName = [_id, "name"] call A3PL_Config_GetCompanyData;
	{
		if((getPlayerUID _x) == _uid) exitWith {[format[localize "STR_SERVER_COMPANY_HIREDCOMPANY",_cName], "green"] remoteExec ["A3PL_Player_Notification",_x];};
	} foreach (playableUnits);
},true] call Server_Setup_Compile;

["Server_Company_Fire",
{
	private _id = param [0,-1];
	private _uid = param [1,""];
	private _fired = param[2,true];
	private _query = format ["SELECT employees FROM companies WHERE id = '%1'",_id];
	private _actual = [_query, 2] call Server_Database_Async;
	private _actual = [(_actual select 0)] call Server_Database_ToArray;

	{if((_x select 0) isEqualTo _uid) exitWith {_actual deleteAt _forEachIndex;};} foreach _actual;

	private _query = format ["UPDATE companies SET employees = '%1' WHERE id = '%2'",_actual, _id];
	[_query, 1] call Server_Database_Async;
	{
		if(_id isEqualTo (_x select 0)) exitWith {
			Server_Companies set[_forEachIndex,[_x select 0, _x select 1, _x select 2, _actual, _x select 4, _x select 5, _x select 6]];
		};
	} foreach Server_Companies;
	publicVariable "Server_Companies";

	if(_fired) then {
		private _cName = [_id, "name"] call A3PL_Config_GetCompanyData;
		{
			if((getPlayerUID _x) isEqualTo _uid) exitWith {[format[localize "STR_SERVER_COMPANY_FIREDCOMPANY",_cName], "red"] remoteExec ["A3PL_Player_Notification",_x];};
		} foreach (playableUnits);
	};
},true] call Server_Setup_Compile;

["Server_Company_ManageSetup",
{
	private _id = param [0,-1];
	private _player = param [1,objNull];
	private _desc = [format ["SELECT description FROM companies WHERE id='%1'",_id], 2] call Server_Database_Async;
	private _desc = _desc select 0;
	private _companyEmployees = [_id, "employees"] call A3PL_Config_GetCompanyData;
	private _empList = [];
	{
		private _name = ([format ["SELECT name FROM players WHERE uid='%1'",_x select 0], 2] call Server_Database_Async) select 0;
		_empList pushback ([_name, _x select 0, _x select 1]);
	} foreach _companyEmployees;
	[_desc,_empList] remoteExec ["A3PL_Company_ManageReceive",(owner _player)];
},true] call Server_Setup_Compile;

["Server_Company_AddLog",
{
	private _id = param [0,-1];
	private _change = param [1,0];
	private _extData = param [2,""];
	private _query = format ["INSERT INTO companies_log(cid, value, description, date_transaction) VALUES ('%1','%2','%3', NOW())",_id, _change, _extData];
	[_query, 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Company_HistorySetup",
{
	private _id = param [0,-1];
	private _player = param [1,objNull];
	private _query = format ["SELECT value, description, date_transaction FROM companies_log WHERE cid='%1'",_id];
	private _logs = [_query, 2, true] call Server_Database_Async;
	[_logs] remoteExec ["A3PL_Company_HistoryReceive",(owner _player)];
},true] call Server_Setup_Compile;

["Server_Company_RegisterSetup",
{
	private _id = param [0,-1];
	private _player = param [1,objNull];
	private _return = [];
	private _query = format ["SELECT name, bank, description, boss FROM companies"];
	private _companies = [_query, 2, true] call Server_Database_Async;
	{
		_phone = [format ["SELECT phone_number FROM iphone_phone_numbers WHERE player_id = '%1' AND type_id = '3'",_companies select 3], 2] call Server_Database_Async;
		_return pushBack [_x select 0, _x select 1, _x select 2, _phone select 0];
	} foreach _companies;
	[_return] remoteExec ["A3PL_Company_RegisterReceive",(owner _player)];
},true] call Server_Setup_Compile;

["Server_Company_SendBill",
{
	private _cid = param [0,-1];
	private _amount = param [1,0];
	private _desc = param [2,"No description provided"];
	private _target = param [3,objNull];
	private _targetUID = getPlayerUID _target;
	private _query = format ["INSERT INTO companies_bills(cid, recipient_id, description, amount, date_bill) VALUES ('%1','%2','%3','%4', NOW())",_cid, _targetUID, _desc, _amount];
	[_query, 1] call Server_Database_Async;
	[_amount] remoteExec ["A3PL_Company_ReceiveBill",(owner _target)];
	[_target] remoteExec ["Server_Company_LoadBills",2];
},true] call Server_Setup_Compile;

["Server_Company_PayBill",
{
	private _id = param [0,-1];
	private _amount = param [1,0];
	private _player = param [2,objNull];
	private _query = format ["UPDATE companies_bills SET active = '0' WHERE id = '%1'", _id];
	[_query, 1] call Server_Database_Async;

	private _query = format ["SELECT cid FROM companies_bills WHERE id='%1'",_id];
	private _companyID = ([_query, 2] call Server_Database_Async) select 0;
	[_companyID, _amount, format["Bill %1",name _player]] remoteExec ["Server_Company_SetBank",2];
	[_player] remoteExec ["Server_Company_LoadBills",2];
},true] call Server_Setup_Compile;

["Server_Company_LoadBillData",
{
	private _id = param [0,-1];
	private _target = param [1,objNull];
	private _query = format ["SELECT description, amount, cid FROM companies_bills WHERE id='%1'",_id];
	private _billData = [_query, 2] call Server_Database_Async;
	private _query = format ["SELECT name FROM companies WHERE id='%1'",_billData select 2];
	private _companyName = [_query, 2] call Server_Database_Async;
	private _companyName = _companyName select 0;
	[_id, _billData select 1, _billData select 0, _companyName] remoteExec ["A3PL_Company_BillDataReceive",(owner _target)];
},true] call Server_Setup_Compile;

["Server_Company_LoadCBillPhone",
{
	private _player = param [0,objNull];
	private _cid = [getPlayerUID _player] call A3PL_Config_GetCompanyID;
	private _query = format ["SELECT companies_bills.cid, companies_bills.amount, companies_bills.description, players.name FROM companies_bills, players WHERE players.uid = companies_bills.recipient_id AND companies_bills.cid = '%1'",_cid];
	private _result = [_query, 2, true] call Server_Database_Async;
	[_result] remoteExec ["A3PL_iPhoneX_appCompaniesBills",owner _player];
},true] call Server_Setup_Compile;

["Server_Company_BuyShop",
{
	private _shop = param[0,objNull];
	private _player = param[1,objNull];
	private _cid = param[2,0];

	private _query = format ["INSERT INTO companies_shops(cid,location) VALUES('%1','%2')", _cid, (getpos _shop)];
	[_query,1] spawn Server_Database_Async;

	sleep 3;
	["You bought a shop for your company!", "green"] remoteExec ["A3PL_Player_Notification",_player];
	[] call Server_Company_LoadShop;
},true] call Server_Setup_Compile;

["Server_Company_SellShop",
{
	private _shop = param[0,objNull];
	private _player = param[1,objNull];

	private _query = format ["DELETE FROM companies_shops WHERE location ='%1'", (getpos _shop)];
	[_query,1] spawn Server_Database_Async;

	_shop setVariable ["id",nil,true];
	_shop setVariable ["cid",nil, true];
	_shop setVariable ["stock",nil, true];

	private _signs = nearestObjects [_pos, ["Land_A3PL_BusinessSign"], 25,true];
	if (count _signs > 0) then {
		(_signs select 0) setObjectTextureGlobal [0,"\A3PL_Objects\Street\business_sign\business_sale_co.paa"];
	};

	["You succesfully sold your company shop!", "green"] remoteExec ["A3PL_Player_Notification",_player];
},true] call Server_Setup_Compile;

["Server_Company_LoadShop",
{
	private _shopList = ["Land_A3PL_Garage","land_smallshop_ded_smallshop_02_f","land_smallshop_ded_smallshop_01_f","Land_A3FL_Brick_Shop_1","Land_A3FL_Brick_Shop_2"];
	private _shops = ["SELECT companies_shops.cid, companies_shops.location, companies_shops.stock, companies.name FROM companies_shops, companies WHERE companies_shops.cid = companies.id", 2, true] call Server_Database_Async;

	{
		private _cid = (_x select 0);
		private _pos = call compile (_x select 1);
		private _stock = [(_x select 2)] call Server_Database_ToArray;
		private _company = (_x select 3);

		private _near = nearestObjects [_pos, _shopList, 10,true];
		if ((count _near) isEqualTo 0) exitwith {[format ["DELETE FROM companies_shops WHERE location = '%1'",_pos],1] spawn Server_Database_Async;};

		private _shop = (_near select 0);
		if (!([_pos,(getpos _shop)] call BIS_fnc_areEqual)) then {
			_query = format ["UPDATE companies_shops SET location='%1' WHERE location ='%2'", (getpos _shop), _pos];
			[_query,1] spawn Server_Database_Async;
		};

		private _signs = nearestObjects [_pos, ["Land_A3PL_BusinessSign"], 25,true];
		if (count _signs > 0) then {
			(_signs select 0) setObjectTextureGlobal [0,"\A3PL_Objects\Street\business_sign\business_rented_co.paa"];
		};

		_shop setVariable ["cid",_cid, true];
		_shop setVariable ["stock",_stock, true];

		private _marker = createMarker [format ["company%1",floor random 3000], _pos];
		_marker setMarkerSize [0.7, 0.7];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "A3PL_Markers_Business";
		_marker setMarkerText _company;
	} foreach _shops;
},true] call Server_Setup_Compile;

["Server_Company_ShopItemsUpdate",
{
	private _shop = param[0,objNull];
	private _stock = param[1,[]];

	_shop setVariable["stock",_stock,true];

	_stock = [_stock] call Server_Database_Array;
	_query = format ["UPDATE companies_shops SET stock='%2' WHERE location ='%1'", (getpos _shop), _stock];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Company_ShopAddStock",
{
	params[
		["_shop",objNull,[objNull]],
		["_addType","",[""]],
		["_addItem","",[""]],
		["_addAmount",0,[0]],
		["_addPrice",0,[0]],
		["_inst",objNull,[objNull]]
	];
	private _currentStock = _shop getVariable["stock",[]];
	private _stock = [];
	private _found = false;
	{
		_type = (_x select 0);
		_class = (_x select 1);
		_amount = (_x select 2);
		_price = (_x select 3);
		if(_class isEqualTo _addItem) then {
			_stock pushback [_type,_class,(_amount+_addAmount),_addPrice];
			_found = true;
		} else {
			_stock pushback [_type,_class,_amount,_price];
		};
	} foreach _currentStock;

	if(!_found) then {
		_stock pushback [_addType,_addItem,_addAmount,_addPrice];
	};
	[_shop,_stock] call Server_Company_ShopItemsUpdate;
	[] remoteExecCall ["A3PL_Company_RefreshShopStock",_inst];
},true] call Server_Setup_Compile;

["Server_Company_ShopRemoveStock",
{
	params[
		["_shop",objNull,[objNull]],
		["_bItem","",[""]],
		["_bAmount",0,[0]],
		["_inst",objNull,[objNull]],
		["_customer",false,[false]]
	];
	private _currentStock = _shop getVariable["stock",[]];
	private _stock = [];
	{
		_type = (_x select 0);
		_class = (_x select 1);
		_amount = (_x select 2);
		_price = (_x select 3);
		if(_class isEqualTo _bItem) then {
			if(!(_amount isEqualTo _bAmount)) then {
				_stock pushback [_type,_class,(_amount-_bAmount),_price];
			};
		} else {
			_stock pushback [_type,_class,_amount,_price];
		};
	} foreach _currentStock;
	[_shop,_stock] call Server_Company_ShopItemsUpdate;
	if(_customer) then {
		[] remoteExecCall ["A3PL_Company_RefreshShop",_inst];
	} else {
		[] remoteExecCall ["A3PL_Company_RefreshShopStock",_inst];
	};
},true] call Server_Setup_Compile;

["Server_Company_ShopResetPrice",
{
	params[
		["_shop",objNull,[objNull]],
		["_cItem","",[""]],
		["_cPrice",0,[0]],
		["_inst",objNull,[objNull]]
	];
	private _currentStock = _shop getVariable["stock",[]];
	private _stock = [];
	{
		_type = (_x select 0);
		_class = (_x select 1);
		_amount = (_x select 2);
		_price = (_x select 3);
		if(_class isEqualTo _cItem) then {
			_stock pushback [_type,_class,_amount,_cPrice];
		} else {
			_stock pushback [_type,_class,_amount,_price];
		};
	} foreach _currentStock;
	[_shop,_stock] call Server_Company_ShopItemsUpdate;
	[] remoteExecCall ["A3PL_Company_RefreshShopStock",_inst];
},true] call Server_Setup_Compile;