["Server_Company_LoadAll",
{
	private _companies = ["SELECT id, name, boss, employees, bank, licenses, storage FROM companies WHERE disabled = '0'", 2,true] call Server_Database_Async;
	Server_Companies = [];
	{
		Server_Companies pushback ([_x select 0, _x select 1, _x select 2, [_x select 3] call Server_Database_ToArray,_x select 4, [_x select 5] call Server_Database_ToArray, [_x select 6] call Server_Database_ToArray]);
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
		[] call Server_Company_LoadAll;
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
	private _query = format ["SELECT employees FROM companies WHERE id = '%1'",_id];
	private _actual = [_query, 2] call Server_Database_Async;
	private _actual = [(_actual select 0)] call Server_Database_ToArray;

	{if(_x select 0 == _uid) exitWith {_actual deleteAt _forEachIndex;};} foreach _actual;
	private _new = [_actual] call Server_Database_Array;
	private _query = format ["UPDATE companies SET employees = '%1' WHERE id = '%2'",_actual, _id];
	[_query, 1] call Server_Database_Async;
	{
		if(_id == (_x select 0)) exitWith {
			Server_Companies set[_forEachIndex,[_x select 0, _x select 1, _x select 2, _actual, _x select 4, _x select 5, _x select 6]];
		};
	} foreach Server_Companies;
	publicVariable "Server_Companies";
	private _cName = [_id, "name"] call A3PL_Config_GetCompanyData;
	{
		if((getPlayerUID _x) == _uid) exitWith {[format[localize "STR_SERVER_COMPANY_FIREDCOMPANY",_cName], "red"] remoteExec ["A3PL_Player_Notification",_x];};
	} foreach (playableUnits);
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

["Server_Company_SaveStorage",
{
	private _cid = param [0,-1];
	private _data = param[1,[]];
	if(_cid < 0) exitWith {};
	{
		if(_id == (_x select 0)) exitWith {
			Server_Companies set[_forEachIndex,[_x select 0, _x select 1, _x select 2, _x select 3, _x select 4, _x select 5, _data]];
		};
	} foreach Server_Companies;
	publicVariable "Server_Companies";
	private _data = [_data] call Server_Database_Array;
	private _query = format ["UPDATE companies SET storage = '%1' WHERE id = '%2'",_data, _cid];
	[_query, 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Company_GetStorageData",
{
	private _cid = param [0,-1];
	private _player = param [1,objNull];
	private _query = format ["SELECT storage FROM companies WHERE id='%1'",_cid];
	private _result = [_query, 2] call Server_Database_Async;
	private _storage = [_result select 0] call Server_Database_ToArray;
	[_storage, _result select 1] remoteExec ["A3PL_Company_StorageDataReceived",_player];
},true] call Server_Setup_Compile;