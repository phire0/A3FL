/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['A3PL_Company_CreateOpen', {
	disableSerialization;
	private _isCorporate = [getPlayerUID player] call A3PL_Config_InCompany;
	if(_isCorporate) exitWith {[localize"STR_COMPANY_YOUALREADYINCOMPANY","red"] call A3PL_Player_Notification;};
	createDialog "Dialog_Company_Create";
}] call Server_Setup_Compile;

['A3PL_Company_Create', {
	disableSerialization;
	private _price = 175000;
	private _display = findDisplay 136;
	private _name = ctrlText (_display displayCtrl 1400);
	private _desc = ctrlText (_display displayCtrl 1401);

	closeDialog 0;

	if((player getVariable["Player_Level",0]) < 6) exitwith {[localize"STR_COMPANY_LEVELCREATE","red"] call A3PL_Player_Notification;};

	private _bank = (player getVariable["Player_Bank",0]);
	if(_bank < _price) exitWith {[format [localize"STR_COMPANY_NoMoneyCreate",_price-_bank],"red"] call A3PL_Player_Notification;};

	[format [localize"STR_COMPANY_YOUCREATECOMPANYFOR",_name,_price],"green"] call A3PL_Player_Notification;
	player setVariable["Player_Bank",_bank-_price,true];
	["Federal Reserve",_price] remoteExec ["Server_Government_AddBalance",2];
	[getPlayerUID player, _name, _desc] remoteExec ["Server_Company_Create",2];
	[player, 120] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

['A3PL_Company_HiringConfirmation', {
	private _cid = param [0,-1];
	private _sender = param [1,objNull];
	private _exit = false;
	private _action = [format["You have been invited to join a company. <br/> Would you like to join ?",_groupName],"Company Invitation","Yes","No"] call BIS_fnc_guiMessage;
	if (!isNil "_action" && {!_action}) exitWith {_exit = true;};
	if(_exit) exitWith{[format[localize"STR_Inter_Notifications_Comphire_Refused",player getVariable["name",""]], "red"] remoteExec ["A3PL_Player_Notification",_sender];};
	[_cid, getPlayerUID player] remoteExec ["Server_Company_Recruit",2];
	[format[localize"STR_Inter_Notifications_Comphire",player getVariable["name",""]], "red"] remoteExec ["A3PL_Player_Notification",_sender];
}] call Server_Setup_Compile;

['A3PL_Company_HasLicense', {
	private _player = param [0,objNull];
	private _license = param[1,""];
	private _cid = [getPlayerUID _player] call A3PL_Config_GetCompanyID;
	private _cLicenses = [_cid, "licenses"] call A3PL_Config_GetCompanyData;
	if(_license IN _cLicenses) then {true;} else {false;};
}] call Server_Setup_Compile;

['A3PL_Company_ManageOpen', {
	disableSerialization;
	private _isCorporate = [getPlayerUID player] call A3PL_Config_InCompany;
	if(!_isCorporate) exitWith {[localize"STR_COMPANY_YOUDONTHAVECOMPANY","red"] call A3PL_Player_Notification;};
	private _isBoss = [getPlayerUID player] call A3PL_Config_IsCompanyBoss;
	if(!_isBoss) exitWith {[localize"STR_COMPANY_YOUDONTLEADEROFCOMPANY","red"] call A3PL_Player_Notification;};

	private _cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	private _companyBudget = [_cid, "bank"] call A3PL_Config_GetCompanyData;

	createDialog "Dialog_Company_Manage";
	private _display = findDisplay 137;
	private _control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format["<t align='right' size='1.2'>$%1</t>",[_companyBudget] call A3PL_Lib_FormatNumber];

	[_cid, player] remoteExec ["Server_Company_ManageSetup",2];
}] call Server_Setup_Compile;

['A3PL_Company_ManageReceive', {
	private ["_display"];
	_desc = param [0,localize"STR_COMPANY_NODESCRIPTION"];
	_empList = param [1,[]];
	_cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;

	_display = findDisplay 137;

	//Employees list
	_control = _display displayCtrl 1500;
	{
		_control lbAdd format ["%1",_x select 0];
		_control lbSetData [(lbSize _control)-1, _x select 1];
		_control lbSetValue [(lbSize _control)-1, _x select 2];
	} foreach _empList;
	_control ctrlAddEventhandler ["LBSelChanged",
	{
		_control = param [0,ctrlNull];
		_display = findDisplay 137;
		_pay = _control lbValue (lbCurSel _control);
		_control = _display displayCtrl 1401;
		_control ctrlSetText format ["%1",_pay];
	}];

	//Desc set
	_control = _display displayCtrl 1402;
	_control ctrlSetText format ["%1",_desc];

	//SAME AS ATM MENU
	//creates list of players online - for transfer option
	{
		_index = lbAdd [5472, format["%1",  name _x]];
		lbSetData [5472, _index, str _x];
	} forEach (playableUnits);

	//Add companies to the list
	{
		if((_x select 0) != _cid) then {
			_index = lbAdd [5472, format[localize"STR_COMPANY_C", _x select 1]];
			lbSetData [5472, _index, str(_x select 0)];
		};
	} forEach Server_Companies;
}] call Server_Setup_Compile;

['A3PL_Company_NameEdit', {
	private _display = findDisplay 137;
	private _newName = ctrlText (_display displayCtrl 1402);
	private _cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	private _pBank = player getVariable["Player_Bank",0];
	private _price = 25000;
	if(_price > _pBank) exitWith {["You need $25.000 to change your company description!", "red"] call A3PL_Player_Notification;};
	player setVariable["Player_Bank",_pBank-_price,true];
	closeDialog 0;
	[_cid, _newName] remoteExec ["Server_Company_SetName",2];
}] call Server_Setup_Compile;

['A3PL_Company_DescEdit', {
	private _display = findDisplay 137;
	private _newDesc = ctrlText (_display displayCtrl 1402);
	private _cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	private _pBank = player getVariable["Player_Bank",0];
	private _price = 5000;
	if(_price > _pBank) exitWith {["You need $5.000 to change your company description!", "red"] call A3PL_Player_Notification;};
	player setVariable["Player_Bank",_pBank-_price,true];
	closeDialog 0;
	[_cid, _newDesc] remoteExec ["Server_Company_SetDesc",2];
}] call Server_Setup_Compile;

['A3PL_Company_Fire', {
	private ["_display","_control","_uid"];
	_display = findDisplay 137;

	_control = _display displayCtrl 1500;
	_uid = _control lbData (lbCurSel _control);
	_cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	_boss = [_cid, "boss"] call A3PL_Config_GetCompanyData;
	if(_uid == _boss) exitWith {
		[localize"STR_COMPANY_YOUCANTDEWHITELISTTHEBOSS", "red"] call A3PL_Player_Notification;
	};
	//Act
	closeDialog 0;
	[_cid, _uid] remoteExec ["Server_Company_Fire",2];
}] call Server_Setup_Compile;

['A3PL_Company_SetPay', {
	private ["_display","_control","_uid"];
	_display = findDisplay 137;
	_newPay = parseNumber(ctrlText (_display displayCtrl 1401));
	_control = _display displayCtrl 1500;
	_uid = _control lbData (lbCurSel _control);
	_cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	//Act
	closeDialog 0;
	[_cid, _uid, _newPay] remoteExec ["Server_Company_SetPay",2];
}] call Server_Setup_Compile;

['A3PL_Company_Transfer', {

	_amount = round(parseNumber(ctrlText 5372));
	_companyTransfer = false;
	if(["(C)", lbText [5472, (lbCurSel 5472)]] call BIS_fnc_inString) then {_companyTransfer = true;} else {_companyTransfer = false;};

	if (((lbCurSel 5472) == -1) || (_amount <= 0)) exitWith {[localize"STR_COMPANY_TRANSFERTERROR", "red"] call A3PL_Player_Notification;};

	_cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	_cBank = [_cid, "bank"] call A3PL_Config_GetCompanyData;
	_cName = [_cid, "name"] call A3PL_Config_GetCompanyData;
	if (_amount > _cBank) exitWith {[localize"STR_COMPANY_YOURCOMPANYDONTHAVETHISMONEY", "red"] call A3PL_Player_Notification;};

	if(_companyTransfer) then {
		_targetCID = parseNumber(lbData [5472, (lbCurSel 5472)]);
		_cTName = [_targetCID] call A3PL_Config_GetCompanyData;

		[_targetCID, _amount, format[localize"STR_COMPANY_TRANSFERFROM",_cName]] remoteExec ["Server_Company_SetBank",2];
		[_cid, -_amount, format[localize"STR_COMPANY_TRANSFERTO",_cTName]] remoteExec ["Server_Company_SetBank",2];

		_format = format[localize"STR_COMPANY_YOUTRANSFERMONEYTOCOMPANYFROMYOURCOMPANY", [_amount] call A3PL_Lib_FormatNumber,_cTName];
	} else {
		_sendTo = lbData [5472, (lbCurSel 5472)];
		_sendToCompile = call compile _sendTo;
		_format = format[localize"STR_COMPANY_YOUTRANSFERMONEYTOPLAYERFROMYOURCOMPANY", [_amount] call A3PL_Lib_FormatNumber, (name _sendToCompile)];
		[format[localize"STR_COMPANY_TRANSFERCOMPANYTOYOU",_amount,_cName], "green"] remoteExec ["A3PL_Player_Notification",_sendTo];
		[_sendToCompile, 'Player_Bank', ((_sendToCompile getVariable 'Player_Bank') + _amount)] remoteExec ["Server_Core_ChangeVar",2];
		[_cid, -_amount, format[localize"STR_COMPANY_TRANSFERTO",name _sendToCompile]] remoteExec ["Server_Company_SetBank",2];
	};
	[_format, "green"] call A3PL_Player_Notification;
	[0] call A3PL_Lib_CloseDialog;
}] call Server_Setup_Compile;

['A3PL_Company_HistoryOpen', {
	private ["_display","_control","_isCorporate","_isBoss","_cid","_companyBudget"];
	disableSerialization;

	_isCorporate = [getPlayerUID player] call A3PL_Config_InCompany;
	if(!_isCorporate) exitWith {[localize"STR_COMPANY_YOUDONTHAVECOMPANY","red"] call A3PL_Player_Notification;};
	_isBoss = [getPlayerUID player] call A3PL_Config_IsCompanyBoss;
	if(!_isBoss) exitWith {[localize"STR_COMPANY_YOUDONTBOSSOFTHISCOMPANY","red"] call A3PL_Player_Notification;};

	_cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;

	createDialog "Dialog_Company_History";
	_display = findDisplay 138;

	//Close
	_control = _display displayCtrl 1600;
	_control buttonSetAction "[0] call A3PL_Lib_CloseDialog;";

	[_cid,player] remoteExec ["Server_Company_HistorySetup",2];
}] call Server_Setup_Compile;

['A3PL_Company_HistoryReceive', {
	_history = param [0,[]];

	_display = findDisplay 138;
	_control = _display displayCtrl 1500;

	if(count _history isEqualTo 0) then
	{
		_control lbAdd localize"STR_COMPANY_NOTRANSACTION";
	}
	else
	{
		{
			if((_x select 0) > 0) then
			{
				_control lbAdd format["%3 | $%1 (%2)", _x select 0, _x select 1, _x select 2];
				_control lbSetColor [_forEachIndex, [0,0.8,0.1,1]];
			}
			else
			{
				_control lbAdd format["%3 | $%1 (%2)", _x select 0, _x select 1, _x select 2];
				_control lbSetColor [_forEachIndex, [0.8,0,0.1,1]];
			};
		} foreach _history;
	};
}] call Server_Setup_Compile;

['A3PL_Company_RegisterOpen', {
	private ["_display","_control"];
	disableSerialization;

	createDialog "Dialog_Company_Register";
	_display = findDisplay 153;

	//Close
	_control = _display displayCtrl 1600;
	_control buttonSetAction "[0] call A3PL_Lib_CloseDialog;";

	[player] remoteExec ["Server_Company_RegisterSetup",2];
}] call Server_Setup_Compile;

['A3PL_Company_RegisterReceive', {
	_companies = param [0,[]];

	if(_companies isEqualTo []) exitWith {};

	_display = findDisplay 153;
	_control = _display displayCtrl 1800;

	if(count _companies isEqualTo 0) then
	{
		_control lbAdd localize"STR_COMPANY_NOCOMPANY";
	}
	else
	{
		{
			_control lbAdd format[localize"STR_COMPANY_CAPITAL", _x select 0, [_x select 1] call A3PL_Lib_FormatNumber];
		} foreach _companies;
	};

	_control = _display displayCtrl 1800;
	_control ctrlAddEventHandler ["LBSelChanged",{
		_display = findDisplay 153;
		_control = _display displayCtrl 1800;
		_data = _companies select (lbCurSel _control);

		_control = _display displayCtrl 1801;
		_control ctrlSetStructuredText parseText format["<t align='right' size='1.2'>%1</t>",_data select 2];

		_control = _display displayCtrl 1802;
		if(isNull(_data select 3)) then {
			_control ctrlSetStructuredText parseText format["<t align='right' size='1.2'>Unknown</t>"];
		} else {
			_control ctrlSetStructuredText parseText format["<t align='right' size='1.2'>%1</t>",_data select 3];
		};
	}];
}] call Server_Setup_Compile;

['A3PL_Company_SendBill', {
	params[
		["_target",objNull,[objNull]],
		["_amount",0,[0]],
		["_desc","",[""]]
	];
	if(_target isEqualTo "") exitWith {};

	private _cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	[_cid, _amount, _desc, _target] remoteExec ["Server_Company_SendBill",2];
	private _amount = [_amount, 1, 0, true] call CBA_fnc_formatNumber;
	[format[localize"STR_SERVER_COMPANY_SENDEDBILL",_amount],"green"] call A3PL_Player_Notification;
	[0] call A3PL_Lib_CloseDialog;
}] call Server_Setup_Compile;

['A3PL_Company_ReceiveBill', {
	private _amount = param [0,0];
	_amount = [_amount, 1, 0, true] call CBA_fnc_formatNumber;
	[format[localize"STR_SERVER_COMPANY_RECEIVEBILL",_amount],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

['A3PL_Company_BillsMenu', {
	private ["_display","_control","_isCorporate","_target"];
	disableSerialization;

	createDialog "Dialog_CompanyBillList";
	_display = findDisplay 139;

	_control = _display displayCtrl 1600;
	_control buttonSetAction "call A3PL_Company_BillPay;";

	_control = _display displayCtrl 1601;
	_control buttonSetAction "closeDialog 0;";

	_control = _display displayCtrl 1201;
	_control ctrlShow false;
	_control = _display displayCtrl 1602;
	_control ctrlShow false;

	if(([getPlayerUID player] call A3PL_Config_IsCompanyBoss)) then {
		_control = _display displayCtrl 1603;
		_control buttonSetAction "call A3PL_Company_BillPayCompany;";
	} else {
		_control = _display displayCtrl 1202;
		_control ctrlShow false;
		_control = _display displayCtrl 1603;
		_control ctrlShow false;
	};

	_control = _display displayCtrl 1500;
	{
		_index = _control lbAdd format["#%1", _forEachIndex];
		_control lbSetData [_index,str(_x select 0)];
		_control lbSetValue [_index,str(_x select 5)];
		if((_x select 5) isEqualTo 0) then {
			_control lbSetColor [_index, [0.8,0,0.1,1]];
		} else {
			_control lbSetColor [_index, [0,0.8,0.1,1]];
		};
	} foreach (player getVariable["player_bills",[]]);

	_control ctrlAddEventHandler ["LBSelChanged",{
		_display = findDisplay 139;
		_control = _display displayCtrl 1500;
		[parseNumber(_control lbData (lbCurSel _control)), player] remoteExec ["Server_Company_LoadBillData",2];
	}];
}] call Server_Setup_Compile;

['A3PL_Company_BillDataReceive', {
	_billId = param [0,-1];
	_billAmount = param [1,0];
	_billDesc = param [2,"Aucune information"];
	_billComp = param [3,"Inconnu"];

	if(_billId isEqualTo -1) exitWith {};

	disableSerialization;
	_display = findDisplay 139;

	_control = _display displayCtrl 1000;
	_control ctrlSetText format ["%1",_billComp];

	_control = _display displayCtrl 1001;
	_control ctrlSetText format ["%1",_billAmount];

	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format["<t align='right' size='1.2'>%1</t>",_billDesc];
}] call Server_Setup_Compile;

['A3PL_Company_BillPay', {
	disableSerialization;
	_display = findDisplay 139;
	_control = _display displayCtrl 1500;
	_isPaid = _control lbValue (lbCurSel _control);
	if(_isPaid isEqualTo 1) exitWith {[format[localize"STR_SERVER_COMPANY_ALREDAYPAID",_amount-_pBank],"red"] call A3PL_Player_Notification;};

	_control = _display displayCtrl 1001;
	_amount = parseNumber (ctrlText _control);

	_pBank = player getVariable["Player_Bank",0];
	if(_pBank < _amount) exitwith {
		[format[localize"STR_SERVER_COMPANY_CANTPAYBILL",_amount-_pBank],"red"] call A3PL_Player_Notification;
	};

	player setVariable["Player_Bank",_pBank - _amount,true];

	_control = _display displayCtrl 1500;
	_bid = parseNumber(_control lbData (lbCurSel _control));

	[_bid,_amount,player] remoteExec ["Server_Company_PayBill"];
	[0] call A3PL_Lib_CloseDialog;
	_amount = [_amount, 1, 0, true] call CBA_fnc_formatNumber;
	[format[localize"STR_SERVER_COMPANY_PAYEDBILL",_amount],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

['A3PL_Company_BillPayCompany', {
	disableSerialization;
	_display = findDisplay 139;
	_control = _display displayCtrl 1500;
	_isPaid = _control lbValue (lbCurSel _control);
	if(_isPaid isEqualTo 1) exitWith {[format[localize"STR_SERVER_COMPANY_ALREDAYPAID",_amount-_pBank],"red"] call A3PL_Player_Notification;};

	_control = _display displayCtrl 1001;
	_amount = parseNumber (ctrlText _control);

	_cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	_companyBudget = [_cid, "bank"] call A3PL_Config_GetCompanyData;
	if(_companyBudget < _amount) exitwith {
		[format[localize"STR_SERVER_COMPANY_CANTPAYBILLCOMPANY",_amount-_companyBudget],"red"] call A3PL_Player_Notification;
	};

	[_cid, -_amount, localize"STR_SERVER_COMPANY_BILLSPAREM"] remoteExec ["Server_Company_SetBank",2];

	_control = _display displayCtrl 1500;
	_bid = parseNumber(_control lbData (lbCurSel _control));

	[_bid,_amount,player] remoteExec ["Server_Company_PayBill"];
	[0] call A3PL_Lib_CloseDialog;
	_amount = [_amount, 1, 0, true] call CBA_fnc_formatNumber;
	[format[localize"STR_SERVER_COMPANY_PAYEDBILLCOMPANY",_amount],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

['A3PL_Company_Paycheck', {
	private _cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	private _payAmount = [getPlayerUID player] call A3PL_Config_GetCompanyPay;
	private _companyBudget = [_cid, "bank"] call A3PL_Config_GetCompanyData;
	if(_payAmount > _companyBudget) exitwith {[format[localize"STR_NewLoop_4"], "red"] call A3PL_Player_Notification;};
	[format[localize"STR_NewLoop_5",_payAmount], "green"] call A3PL_Player_Notification;
	[_cid, -_payAmount, ""] remoteExec ["Server_Company_SetBank",2];
	_payAmount;
}] call Server_Setup_Compile;

['A3PL_Company_Resign', {
	private _uid = getPlayerUID player;
	private _cid = [_uid] call A3PL_Config_GetCompanyID;
	["You resigned from your company.","green"] call A3PL_Player_Notification;
	[_cid, _uid, false] remoteExec ["Server_Company_Fire",2];
}] call Server_Setup_Compile;

/*
	COMPANY SHOPS BELLOW
*/

#define BUSINESSOBJS ["Land_A3FL_Anton_Store","Land_A3PL_Garage","land_smallshop_ded_smallshop_02_f","land_smallshop_ded_smallshop_01_f","Land_A3FL_Brick_Shop_1","Land_A3FL_Brick_Shop_2"]
#define BUSINESSPRICE 800000

['A3PL_Company_OpenBuyShop', {
	private _nearBy = nearestObjects [player, BUSINESSOBJS, 20];
	if (count _nearBy < 1) exitwith {["Error: No business building nearby","red"] call A3PL_Player_Notification;};
	A3PL_Company_BuyObject = _nearBy select 0;

	createDialog "Dialog_CompanyShop_Buy";
	private _display = findDisplay 130;
	private _control = _display displayCtrl 1100;
	_control ctrlSetText format ["$%1",[BUSINESSPRICE, 1, 2, true] call CBA_fnc_formatNumber];
}] call Server_Setup_Compile;

['A3PL_Company_BuyShop', {
	private _cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	private _cBudget = [_cid, "bank"] call A3PL_Config_GetCompanyData;

	if(_cBudget < BUSINESSPRICE) exitWith {[format["You don't have $%1 on your company bank account to buy this shop",[BUSINESSPRICE, 1, 2, true] call CBA_fnc_formatNumber], "red"] call A3PL_Player_Notification;};

	[_cid, -(BUSINESSPRICE), "Bought Shop"] remoteExec ["Server_Company_SetBank",2];
	[A3PL_Company_BuyObject,player,_cid] remoteExec ["Server_Company_BuyShop",2];
	closeDialog 0;
}] call Server_Setup_Compile;

['A3PL_Company_OpenSellShop', {
	private _nearBy = nearestObjects [player, BUSINESSOBJS, 20];
	if (count _nearBy < 1) exitwith {["Error: No business building nearby","red"] call A3PL_Player_Notification;};
	A3PL_Company_BuyObject = _nearBy select 0;

	private _cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	private _shopCid = A3PL_Company_BuyObject getVariable["cid",0];
	if(!(_shopCid isEqualTo _cid)) exitWith {["Your company doesn't own this shop!","red"] call A3PL_Player_Notification;};

	createDialog "Dialog_CompanyShop_Sell";
	private _display = findDisplay 130;
	private _control = _display displayCtrl 1100;
	_control ctrlSetText format ["$%1",[(BUSINESSPRICE*0.7), 1, 2, true] call CBA_fnc_formatNumber];
}] call Server_Setup_Compile;

['A3PL_Company_SellShop', {
	private _cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	private _cBudget = [_cid, "bank"] call A3PL_Config_GetCompanyData;
	private _shopCid = A3PL_Company_BuyObject getVariable["cid",0];
	if(!(_shopCid isEqualTo _cid)) exitWith {["Your company doesn't own this shop!","red"] call A3PL_Player_Notification;};
	[_cid, +(BUSINESSPRICE*0.7), "Sold Shop"] remoteExec ["Server_Company_SetBank",2];
	[A3PL_Company_BuyObject,player] remoteExec ["Server_Company_SellShop",2];
	closeDialog 0;
}] call Server_Setup_Compile;

['A3PL_Company_OpenShop', {
	private _nearBy = nearestObjects [player, BUSINESSOBJS, 20];
	if (count _nearBy < 1) exitwith {["Error: No business building nearby","red"] call A3PL_Player_Notification;};
	A3PL_Company_Building = _nearBy select 0;

	if(A3PL_Company_Building getVariable["inUse",false]) exitWith {["Someone is already using this shop!","red"] call A3PL_Player_Notification;};
	A3PL_Company_Building setVariable["inUse",true,true];
	
	createDialog "Dialog_CompanyShop_Customer";
	private _display = findDisplay 130;
	private _control = _display displayCtrl 1102;
	private _cid = A3PL_Company_Building getVariable["cid",-1];
	private _cName = [_cid, "name"] call A3PL_Config_GetCompanyData;
	_control ctrlSetStructuredText parseText format["<t size='2'>%1</t>",_cName];
	call A3PL_Company_RefreshShop;
}] call Server_Setup_Compile;

['A3PL_Company_ShopBuy', {
	if(!([5] call A3PL_Player_AntiSpam)) exitWith {};
	private _display = findDisplay 130;
	private _control = _display displayCtrl 1500;
	if ((lbCurSel _control) < 0) exitwith {["Please select an item in the list first","red"] call A3PL_Player_Notification;};

	private _itemData = (_control lbData (lbCurSel _control)) splitString ",";
	private _control = _display displayCtrl 1400;
	private _buyAmount = floor(parseNumber (ctrlText _control));
	private _type = _itemData select 0;
	private _class = _itemData select 1;
	private _amount = parseNumber(_itemData select 2);
	private _price = parseNumber(_itemData select 3);
	private _cash = player getVariable["Player_Cash",0];
	private _itemName = "undefined";
	private _canTake = true;
	private _cid = A3PL_Company_Building getVariable["cid",-1];	

	switch(_type) do {
		case ("item"):{
			_itemName = [_class,"name"] call A3PL_Config_GetItem;
		};
		case ("vehicle"): {
			_itemName = getText (configFile >> "CfgVehicles" >> _class >> "displayName");
			_buyAmount = 1;
		};
		case ("plane"): {
			_itemName = getText (configFile >> "CfgVehicles" >> _class >> "displayName");
			_buyAmount = 1;
		};
	};
	_price = _price*_buyAmount;
	if(_buyAmount < 0) exitWith {["Please enter a valid amount!","red"] call A3PL_Player_Notification;};
	if(_buyAmount > _amount) exitWith {["There is not enough stock!","red"] call A3PL_Player_Notification;};
	if(_price > _cash) exitWith {[format["You do not have $%1 to buy %2 %3",_price,_buyAmount,_itemName],"red"] call A3PL_Player_Notification;};

	switch(_type) do {
		case ("item"):{
			if ([_class,"canPickup"] call A3PL_Config_GetItem) then {
				if(([[_class,_buyAmount]] call A3PL_Inventory_TotalWeight) <= Player_MaxWeight) then {
					[_class,_buyAmount] call A3PL_Inventory_Add;
				} else {
					_canTake = false;
				};
			} else {
				private _veh = createVehicle [([_class,"class"] call A3PL_Config_GetItem), getposATL player, [], 0, "CAN_COLLIDE"];
				if (!([_class,"simulation"] call A3PL_Config_GetItem)) then {[_veh] remoteExec ["Server_Vehicle_EnableSimulation",2];};
				_veh setVariable ["class",_class,true];
				_veh setVariable ["owner",getPlayerUID player,true];
			};
		};
		case ("vehicle"): {
			[player,[_class,1],"","car"] remoteExec ["Server_Factory_Create", 2];
		};
		case ("plane"): {
			[player,[_class,1],"","plane"] remoteExec ["Server_Factory_Create", 2];
		};
	};
	if(!_canTake) exitWith {["You cannot carry this amount!","red"] call A3PL_Player_Notification;};
	[_cid, _price, format["Shop %1x%2",_buyAmount,_itemName]] remoteExec ["Server_Company_SetBank",2];
	player setVariable["Player_Cash",(_cash-_price),true];
	[A3PL_Company_Building,_class,_buyAmount,player,true] remoteExec ["Server_Company_ShopRemoveStock",2];
}] call Server_Setup_Compile;

['A3PL_Company_RefreshShop', {
	private _display = findDisplay 130;
	private _stock = A3PL_Company_Building getVariable["stock",[]];
	private _control = _display displayCtrl 1500;

	if(_stock isEqualTo []) then {
		_control lbAdd "The stocks are empty";
	} else {
		lbClear _control;
		{
			private _type = (_x select 0);
			private _class = (_x select 1);
			private _amount = (_x select 2);
			private _price = (_x select 3);
			private _infoString = format["%1,%2,%3,%4",_type,_class,_amount,_price];
			private _name = [_class,_type,"name"] call A3PL_Factory_Inheritance;
			private _i = _control lbAdd format ["(%2x) %1",_name,_amount];
			_control lbSetData [_i,format ["%1",_infoString]];
		} forEach _stock;
		_control ctrlAddEventHandler ["LBSelChanged","call A3PL_Company_ShopStockSelect;"];
	};
}] call Server_Setup_Compile;

['A3PL_Company_OpenShopStock', {
	private _nearBy = nearestObjects [player, BUSINESSOBJS, 20];
	if (count _nearBy < 1) exitwith {["Error: No business building nearby","red"] call A3PL_Player_Notification;};
	A3PL_Company_Building = _nearBy select 0;
	if(A3PL_Company_Building getVariable["inUse",false]) exitWith {["Someone is already using this shop!","red"] call A3PL_Player_Notification;};
	A3PL_Company_Building setVariable["inUse",true,true];
	createDialog "Dialog_CompanyShop_Management";
	call A3PL_Company_RefreshShopStock;
}] call Server_Setup_Compile;

['A3PL_Company_RefreshShopStock', {
	private _display = findDisplay 130;
	private _control = _display displayCtrl 1501;
	private _inventory = player getVariable ["player_inventory",[]];
	private _uid = getPlayerUID player;
	lbClear _control;

	{
		private _id = _x select 0;
		private _amount = _x select 1;
		private _infoString = format["%1,%2,%3","item",_id,_amount];
		private _i = _control lbAdd format ["(%2x) %1",([_id,"name"] call A3PL_Config_GetItem),_amount];
		_control lbSetData [_i,_infoString];
	} foreach _inventory;

	private _near = nearestObjects [player, ["Thing"], 10];
	{
		if ((!isNil {_x getVariable ["ainv",nil]}) || (!isNil {_x getVariable ["finv",nil]}) || (isNil {_x getVariable ["class",nil]})) then {
			_near deleteAt _forEachIndex;
		};
	} foreach _near;
	{
		if ((_x getVariable ["owner",""]) isEqualTo _uid) then {
			private _id = _x getVariable ["class",""];
			private _infoString = format["%1,%2,%3,OBJ_%4","item",_id,1,_x];
			private _i = _control lbAdd format ["(1x) %1",([_id,"name"] call A3PL_Config_GetItem)];
			_control lbSetData [_i,_infoString];
		};
	} foreach _near;

	private _near = nearestObjects [player, ["Car","Tank","Ship","Air","Plane"], 15];
	{
		private _owner = _x getVariable["owner",nil];
		if(!isNil "_owner") then {
			if((_owner select 0) isEqualTo _uid) then {
				private _id = typeOf _x;
				private _displayName = getText (configFile >> "CfgVehicles" >> _id >> "displayName");;
				private _type = if((_x isKindOf "Air") || (_x isKindOf "Plane")) then {"plane"} else {"vehicle"};
				private _infoString = format["%1,%2,%3,OBJ_%4",_type,_id,1,_x];
				private _i = _control lbAdd format ["(1x) %1",_displayName];
				_control lbSetData [_i,_infoString];
			};
		};
	} forEach _near;

	private _stock = A3PL_Company_Building getVariable["stock",[]];
	private _control = _display displayCtrl 1500;
	lbClear _control;
	{
		private _type = (_x select 0);
		private _class = (_x select 1);
		private _amount = (_x select 2);
		private _price = (_x select 3);
		private _infoString = format["%1,%2,%3,%4",_type,_class,_amount,_price];
		private _name = [_class,_type,"name"] call A3PL_Factory_Inheritance;
		private _i = _control lbAdd format ["(%2x) %1",_name,_amount];
		_control lbSetData [_i,format ["%1",_infoString]];
	} forEach _stock;
	_control ctrlAddEventHandler ["LBSelChanged","call A3PL_Company_ShopStockSelect;"];
}] call Server_Setup_Compile;

['A3PL_Company_AddShopStock', {
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _display = findDisplay 130;
	private _control = _display displayCtrl 1501;
	if ((lbCurSel _control) < 0) exitwith {["Please select an item in the list first","red"] call A3PL_Player_Notification;};
	private _itemData = _control lbData (lbCurSel _control);

	private _control = _display displayCtrl 1401;
	private _addAmount = floor(parseNumber (ctrlText _control));
	if(_addAmount < 0) exitWith {["Please enter a valid amount!","red"] call A3PL_Player_Notification;};

	private _control = _display displayCtrl 1403;
	private _addPrice = floor(parseNumber (ctrlText _control));
	if(_addPrice < 0) exitWith {["Please enter a valid price!","red"] call A3PL_Player_Notification;};

	_itemData = _itemData splitString ",";
	if(count(_itemData) < 3) exitWith {["Error while loading item info, please try again!","red"] call A3PL_Player_Notification;};
	private _type = _itemData select 0;
	private _class = _itemData select 1;
	private _amount = parseNumber(_itemData select 2);

	if(_addAmount > _amount) exitWith {["You do not have this amount to add!","red"] call A3PL_Player_Notification;};

	switch(_type) do {
		case "item": {
			if(count(_itemData) isEqualTo 4) then {
				_objString = _itemData select 3;
				_splitted = _objString splitString "_";
				if ((_splitted select 0) isEqualTo "OBJ") then
				{
					private _typeOf = toArray _objString;
					_typeOf deleteAt 0;_typeOf deleteAt 0;_typeOf deleteAt 0;_typeOf deleteAt 0;
					_typeOf = toString _typeOf;
					private _veh = [_typeOf] call A3PL_Lib_vehStringToObj;
					deleteVehicle _veh;
				};
			};
			[_class,-(_addAmount)] call A3PL_Inventory_Add;
		};
		case "vehicle": {
			if(count(_itemData) isEqualTo 4) then {
				_objString = _itemData select 3;
				_splitted = _objString splitString "_";
				if ((_splitted select 0) isEqualTo "OBJ") then
				{
					private _typeOf = toArray _objString;
					_typeOf deleteAt 0;_typeOf deleteAt 0;_typeOf deleteAt 0;_typeOf deleteAt 0;
					_typeOf = toString _typeOf;
					private _veh = [_typeOf] call A3PL_Lib_vehStringToObj;
					[_veh] remoteExecCall ["Server_Vehicle_Sell",2];
				};
			};
			
		};
		case "plane": {
			if(count(_itemData) isEqualTo 4) then {
				_objString = _itemData select 3;
				_splitted = _objString splitString "_";
				if ((_splitted select 0) isEqualTo "OBJ") then
				{
					private _typeOf = toArray _objString;
					_typeOf deleteAt 0;_typeOf deleteAt 0;_typeOf deleteAt 0;_typeOf deleteAt 0;
					_typeOf = toString _typeOf;
					private _veh = [_typeOf] call A3PL_Lib_vehStringToObj;
					[_veh] remoteExecCall ["Server_Vehicle_Sell",2];
				};
			};
		};
	};
	[A3PL_Company_Building,_type,_class,_addAmount,_addPrice,player] remoteExec ["Server_Company_ShopAddStock",2];
}] call Server_Setup_Compile;

['A3PL_Company_RemoveShopStock', {
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _display = findDisplay 130;
	private _control = _display displayCtrl 1500;
	if ((lbCurSel _control) < 0) exitwith {["Please select an item in the list first","red"] call A3PL_Player_Notification;};
	private _itemData = (_control lbData (lbCurSel _control)) splitString ",";
	private _control = _display displayCtrl 1400;
	private _takeAmount = floor(parseNumber (ctrlText _control));
	if(_takeAmount < 0) exitWith {["Please enter a valid amount!","red"] call A3PL_Player_Notification;};
	if(count(_itemData) < 3) exitWith {["Error while loading item info, please try again!","red"] call A3PL_Player_Notification;};
	private _type = _itemData select 0;
	private _class = _itemData select 1;
	private _amount = parseNumber(_itemData select 2);
	if(_takeAmount > _amount) exitWith {["You do not have this amount to add!","red"] call A3PL_Player_Notification;};
	private _canTake = true;
	switch(_type) do {
		case "item": {
			if ([_class,"canPickup"] call A3PL_Config_GetItem) then {
				if(([[_class,_takeAmount]] call A3PL_Inventory_TotalWeight) <= Player_MaxWeight) then {
					[_class,_takeAmount] call A3PL_Inventory_Add;
				} else {
					_canTake = false;
				};
			} else {
				private _veh = createVehicle [([_class,"class"] call A3PL_Config_GetItem), getposATL player, [], 0, "CAN_COLLIDE"];
				if (!([_class,"simulation"] call A3PL_Config_GetItem)) then {[_veh] remoteExec ["Server_Vehicle_EnableSimulation",2];};
				_veh setVariable ["class",_class,true];
				_veh setVariable ["owner",getPlayerUID player,true];
			};
		};
		case "vehicle": {
			[player,[_class,1],"","car"] remoteExec ["Server_Factory_Create", 2];
			_takeAmount = 1;
		};
		case "plane": {
			[player,[_class,1],"","plane"] remoteExec ["Server_Factory_Create", 2];
			_takeAmount = 1;
		};
	};
	if(!_canTake) exitWith {[format [localize "STR_SHOP_NOTENOUGHSPACE",_amount, _itemName],"red"] call A3PL_Player_Notification;};
	[A3PL_Company_Building,_class,_takeAmount,player] remoteExec ["Server_Company_ShopRemoveStock",2];
}] call Server_Setup_Compile;

['A3PL_Company_UpdateStockPrice', {
	private _display = findDisplay 130;
	private _control = _display displayCtrl 1500;
	private _itemData = (_control lbData (lbCurSel _control)) splitString ",";
	if (count(_itemData) < 3) exitWith {["Error while loading item info, please try again!","red"] call A3PL_Player_Notification;};
	private _class = _itemData select 1;
	private _price = parseNumber(_itemData select 3);

	private _control = _display displayCtrl 1403;
	private _addPrice = floor(parseNumber (ctrlText _control));
	if (_addPrice < 0) exitWith {["Please enter a valid price!","red"] call A3PL_Player_Notification;};
	if (_price isEqualTo _addPrice) exitWith {["ARE YOU FUCKING RETARDED?","red"] call A3PL_Player_Notification;};

	private _control = _display displayCtrl 1101;
	_control ctrlSetStructuredText parseText format["$%1",[_addPrice, 1, 0, true] call CBA_fnc_formatNumber];	
	[A3PL_Company_Building,_class,_addPrice,player] remoteExec ["Server_Company_ShopResetPrice",2];
}] call Server_Setup_Compile;

['A3PL_Company_ShopStockSelect', {
	private _display = findDisplay 130;
	private _control = _display displayCtrl 1500;
	private _itemData = (_control lbData (lbCurSel _control)) splitString ",";
	if(count(_itemData) < 3) exitWith {["Error while loading item info, please try again!","red"] call A3PL_Player_Notification;};
	private _amount = parseNumber(_itemData select 2);
	private _price = parseNumber(_itemData select 3);

	private _control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format["%1",_amount];
	private _control = _display displayCtrl 1101;
	_control ctrlSetStructuredText parseText format["$%1",[_price, 1, 0, true] call CBA_fnc_formatNumber];
}] call Server_Setup_Compile;