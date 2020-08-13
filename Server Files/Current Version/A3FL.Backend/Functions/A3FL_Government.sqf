/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define CHARMAXLAWCOUNT 120
#define FACTIONBALANCES ["Fire Rescue","US Coast Guard","Sheriff Department","Department of Justice","Marshals Service"]
#define FACTIONMINPAY 200
#define FACTIONMAXPAY 2750

["A3PL_Government_OpenTreasury",
{
	disableSerialization;
	if (!(["fbi"] call A3PL_Government_isFactionLeader)) exitwith {[localize"STR_NewGovernment_AccessErr1","red"] call A3PL_Player_Notification;};

	createDialog "Dialog_Treasury";
	private _display = findDisplay 109;
	private _totalBalance = 0;
	_control = _display displayCtrl 2100;
	{
		if (!((_x select 0) IN FACTIONBALANCES)) then {
			private ["_balanceName","_balanceAmount"];
			_balanceName = _x select 0;
			_balanceAmount = _x select 1;
			_control lbAdd _balanceName;
			_totalBalance = _totalBalance + _balanceAmount;
		};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);
	_control ctrlAddEventhandler ["LBSelChanged",
	{
		private ["_control","_display","_balance","_balanceAmount"];
		_display = findDisplay 109;
		_control = param [0,ctrlNull];
		_balance = _control lbText (lbCurSel _control);
		_balanceAmount = 0;
		{
			if (_x select 0 == _balance) exitwith {_balanceAmount = _x select 1;};
		} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);
		_control = _display displayCtrl 1400;
		_control ctrlSetText (format ["$%1",([_balanceAmount, 1, 0, true] call CBA_fnc_formatNumber)]);
	}];

	_control = _display displayCtrl 1402;
	_control ctrlSetText format ["$%1",([_totalBalance, 1, 0, true] call CBA_fnc_formatNumber)];

	_control = _display displayCtrl 2101;
	{
		_control lbAdd (_x select 0);
	} foreach (missionNameSpace getVariable ["Config_Government_Taxes",[]]);
	_control ctrlAddEventHandler ["LBSelChanged",
	{
		private _display = findDisplay 109;
		private _control = param [0,ctrlNull];
		private _taxSelected = _control lbText (lbCurSel _control);
		private _taxRate = 0;
		{
			if (_x select 0 isEqualTo _taxSelected) exitwith {_taxRate = _x select 1;};
		} foreach (missionNameSpace getVariable ["Config_Government_Taxes",[]]);
		_control = _display displayCtrl 1403;
		_control ctrlSetText format ["%1%2",_taxRate*100,"%"];
	}];

	_control = _display displayCtrl 2102;
	{
		if ((_x select 0) IN FACTIONBALANCES) then {
			private _balanceName = format ["%1 ($%2)",(_x select 0),([(_x select 1), 1, 0, true] call CBA_fnc_formatNumber)];
			private _index = _control lbAdd _balanceName;
			_control lbSetData [_index,_x select 0];
		};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);

	_control = _display displayCtrl 2103;
	{
		private _lawi = _forEachIndex + 1;
		_control lbAdd format ["Decree %1",_lawi];
	} foreach (missionNameSpace getVariable ["Config_Government_Laws",[]]);
	_control ctrlAddEventHandler ["LBSelChanged",
	{
		private _display = findDisplay 109;
		private _control = param [0,ctrlNull];
		private _law = Config_Government_Laws select (lbCurSel _control);
		private _control = _display displayCtrl 1000;
		_control ctrlSetText _law;
		_control = _display displayCtrl 1401;
		_control ctrlSetStructuredText parseText _law;
	}];
}] call Server_Setup_Compile;

["A3PL_Government_MyFactionBalance",
{
	private _player = param [0,player];
	private _justName = param [1,false];
	private _faction = _player getVariable ["faction","citizen"];
	private _balance = [_faction] call A3PL_Config_GetBalance;
	if (_justName) exitwith {_balance;};
	_balanceAmount = 0;
	{
		if ((_x select 0) == _balance) exitwith {_balanceAmount = _x select 1;};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);
	_balanceAmount;
}] call Server_Setup_Compile;

["A3PL_Government_FactionBalance",
{
	private _balance = param [0,""];
	private _balanceAmount = 0;
	{
		if ((_x select 0) isEqualTo _balance) exitwith {_balanceAmount = _x select 1;};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);
	_balanceAmount;
}] call Server_Setup_Compile;

["A3PL_Government_AddBalance",
{
	disableSerialization;
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _display = findDisplay 109;
	private _control = _display displayCtrl 2100;
	if (lbCurSel _control < 0) exitwith {["You did not select a balance to transfer money","red"] call A3PL_Player_Notification;};
	private _selectedBalance = _control lbText (lbCurSel _control);
	private _selectedBalanceAmount = 0;
	{
		if ((_x select 0) isEqualTo _selectedBalance) exitwith {_selectedBalanceAmount = _x select 1;};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);
	_control = _display displayCtrl 2102;
	if (lbCurSel _control < 0) exitwith {["You did not select a target to transfer the money","red"] call A3PL_Player_Notification;};
	_transferTo = _control lbData (lbCurSel _control);
	_control = _display displayCtrl 1404;
	_amount = parseNumber (ctrlText _control);
	if (_amount < 1) exitwith {[localize"STR_NewGovernment_ValidAmnt","red"] call A3PL_Player_Notification;};
	if (_amount > _selectedBalanceAmount) exitwith {["You can not transfer more money than the amount of the current balance you have selected","red"] call A3PL_Player_Notification;};
	[_transferTo,_amount,_selectedBalance] remoteExec ["Server_Government_AddBalance", 2];
}] call Server_Setup_Compile;

["A3PL_Government_SetTax",
{
	disableSerialization;
	private _display = findDisplay 109;
	private _control = _display displayCtrl 1403;
	private _fail = false;
	private _rate = (ctrlText _control) splitString "%";
	if (count _rate == 0) then {_f = true};
	private _rate = parseNumber (_rate select 0);
	if (isnil "_rate") exitwith {[localize"STR_NewGovernment_ValidAmnt","red"] call A3PL_Player_Notification;};
	if ((_rate > 100) OR (_rate < 0)) then {_fail = true};
	if (_fail) exitwith {["Please enter a valid number in the tax rate field between 0% and 100%","red"] call A3PL_Player_Notification;};
	private _control = _display displayCtrl 2101;
	if (lbCurSel _control < 0) exitwith {["Select the tax you want to change first!","red"] call A3PL_Player_Notification;};
	private _taxChanged = _control lbText (lbCurSel _control);
	[_taxChanged,((parseNumber (((ctrlText 1403) splitString "%") select 0))/100)] remoteExec ["Server_Government_SetTax", 2];
}] call Server_Setup_Compile;

["A3PL_Government_NewTax",
{
	private _taxChanged = param [0,""];
	private _oldTaxRate = (param [1,0])*100;
	private _newTaxRate = (param [2,0])*100;
	_msg = format ["Dear Citizens: The government has changed %1 from %3%4 to %2%4",_taxChanged,_newTaxRate,_oldTaxRate,"%"];
	[_msg,"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Government_NewLaw",
{
	private _lawIndex = (param [0,0]) + 1;
	[format ["Dear Citizens: The Governor has changed the decree %1, go to City Hall for more information on this decree!",_lawIndex],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Government_SetLaw",
{
	disableSerialization;
	private _display = findDisplay 109;
	private _control = _display displayCtrl 2103;
	private _selectedLaw = lbCurSel _control;
	private _lawText = ctrlText (_display displayCtrl 1401);
	if (_selectedLaw isEqualTo -1) exitwith {["You have not selected any laws to modify","red"] call A3PL_Player_Notification;};
	if ((count _lawText < 3) OR (count _lawText > CHARMAXLAWCOUNT)) exitwith {["Invalid lenght (3 to 70 chars)","red"] call A3PL_Player_Notification;};
	[0,_selectedLaw,_lawText] remoteExec ["Server_Government_ChangeLaw", 2];
}] call Server_Setup_Compile;

["A3PL_Government_AddLaw",
{
	disableSerialization;
	private _display = findDisplay 109;
	private _control = _display displayCtrl 2103;
	private _lawText = ctrlText (_display displayCtrl 1401);
	if ((count _lawText < 3) OR (count _lawText > CHARMAXLAWCOUNT)) exitwith {["Invalid lenght (3 to 70 chars)","red"] call A3PL_Player_Notification;};
	[1,0,_lawText] remoteExec ["Server_Government_ChangeLaw", 2];
}] call Server_Setup_Compile;

["A3PL_Government_RemoveLaw",
{
	disableSerialization;
	private _display = findDisplay 109;
	private _control = _display displayCtrl 2103;
	private _selectedLaw = lbCurSel _control;
	if (_selectedLaw isEqualTo -1) exitwith {["You have not selected any decree to delete","red"] call A3PL_Player_Notification;};
	[-1,_selectedLaw] remoteExec ["Server_Government_ChangeLaw", 2];
}] call Server_Setup_Compile;

["A3PL_Government_isFactionLeader",
{
	private _faction = param [0,"citizen"];
	private _player = param [1,player];
	private _isLeader = false;
	private _playerUID = getPlayerUID _player;
	private _admins = ["76561198070895974","76561198111737316","76561198343727655","76561198201783651","76561198096687678"];
	if(_playerUID IN _admins) exitWith {true;};
	{
		if ((_x select 0) isEqualTo _faction) exitwith {
			if (_playerUID IN (_x select 1)) then {_isLeader = true;};
		};
	} foreach (missionNameSpace getVariable ["Config_Government_FactionLead",[]]);
	_isLeader;
}] call Server_Setup_Compile;

["A3PL_Government_FactionSetup",
{
	disableSerialization;
	private ["_control","_display","_faction"];
	_faction = param [0,""];
	if (_faction isEqualTo "") exitwith {["System: no faction send in param","red"] call A3PL_Player_Notification;};

	A3PL_GOVEDITFACTION = _faction;
	createDialog "Dialog_FactionSetup";
	_display = findDisplay 111;
	_display displayAddEventHandler ["Unload",{A3PL_GOVEDITFACTION = nil; A3PL_GOVRANKS = nil; A3PL_GOVPLIST = nil;}];

	[player,_faction] remoteExec ["Server_Government_FactionSetupInfo", 2];

	_control = _display displayCtrl 1502;
	_control ctrlAddEventHandler ["LBSelChanged","call A3PL_Government_UpdateRanks;"];

	_control = _display displayCtrl 2100;
	_control ctrlAddEventHandler ["LBSelChanged","call A3PL_Government_CatChange;"];
	{
		if ((_x select 0) isEqualTo _faction) exitwith
		{
			private ["_main"];
			_main = [] + _x;
			_main deleteAt 0;
			{_control lbAdd (_x select 0);} foreach _main;
		};
	} foreach Config_FactionItems;
}] call Server_Setup_Compile;

["A3PL_Government_FactionSetupReceive",
{
	disableSerialization;
	private _display = findDisplay 111;
	private _playerList = param [0,[]];
	_playerList sort true;
	private _ranks = param [1,[]];
	A3PL_GOVRANKS = [] + _ranks;
	A3PL_GOVPLIST = [] + _playerList;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (isNull _display) exitwith {};

	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		private _name = _x select 0;
		private _uid = _x select 1;
		private _index = _control lbAdd _name;
		_control lbSetData [_index,_uid];
	} foreach _playerList;

	_control = _display displayCtrl 1502;
	lbClear _control;
	{
		private _name = _x select 0;
		private _pay = _x select 2;
		private _index = _control lbAdd format ["%1 - $%2",_name,([_pay, 1, 0, true] call CBA_fnc_formatNumber)];
		_control lbSetData [_index,_name];
	} foreach _ranks;

	_balanceAmount = [player] call A3PL_Government_MyFactionBalance;
	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format ["$%1",([_balanceAmount, 1, 0, true] call CBA_fnc_formatNumber)];
	_control = _display displayCtrl 1101;
	_control ctrlSetStructuredText parseText format ["%1 members",(count _playerList)];
}] call Server_Setup_Compile;

["A3PL_Government_UpdateRanks",
{
	disableSerialization;
	private _display = findDisplay 111;
	private _control = _display displayCtrl 1502;
	private _rank = _control lbData (lbCurSel _control);
	private _control = _display displayCtrl 1500;
	lbClear _control;
	private _pay = 0;
	{
		if ((_x select 0) isEqualTo _rank) then
		{
			_pay = _x select 2;
			{
				private _uid = _x;
				private _name = format ["Unknown (%1)",_uid];
				{
					if ((_x select 1) isEqualTo _uid) then {
						_name = _x select 0;
					};
				} foreach A3PL_GOVPLIST;
				_control lbAdd _name;
			} foreach (_x select 1);
		};
	} foreach (A3PL_GOVRANKS);
	_control = _display displayCtrl 1401;
	_control ctrlSetText str(_pay);
}] call Server_Setup_Compile;

["A3PL_Government_SetRank",
{
	disableSerialization;
	private _display = findDisplay 111;
	private _faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (_faction isEqualTo "") exitwith {["Error, unable to determine the faction!","red"] call A3PL_Player_Notification;};
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["Only the head of the faction can change that","red"] call A3PL_Player_Notification;};
	private _control = _display displayCtrl 1501;
	if (lbCurSel _control < 0) exitwith {["Please select a target","red"] call A3PL_Player_Notification;};
	private _person = _control lbData (lbCurSel _control);
	private _personName = _control lbText (lbCurSel _control);
	private _control = _display displayCtrl 1502;
	if (lbCurSel _control < 0) exitwith {["Please select a rank","red"] call A3PL_Player_Notification;};
	private _rank = _control lbData (lbCurSel _control);

	[_faction,_person,_rank] remoteExec ["Server_Government_SetRank", 2];
	{
		private _rankx = _x select 0;
		private _persons = _x select 1;
		if (_person IN _persons) then {
			_persons = _persons - [_person];
			A3PL_GOVRANKS set [_forEachIndex,[(_x select 0),_persons,(_x select 2)]];
		};
		if (_rankx isEqualTo _rank) then {
			_persons pushback _person;
		};
	} foreach A3PL_GOVRANKS;
	call A3PL_Government_UpdateRanks;
}] call Server_Setup_Compile;

["A3PL_Government_Fire",
{
	disableSerialization;
	private _display = findDisplay 111;
	private _faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (_faction isEqualTo "") exitwith {["Error, unable to determine the faction!","red"] call A3PL_Player_Notification;};
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["Only the head of the faction can change that","red"] call A3PL_Player_Notification;};
	private _control = _display displayCtrl 1501;
	if (lbCurSel _control < 0) exitwith {["Please select a target","red"] call A3PL_Player_Notification;};
	private _person = _control lbData (lbCurSel _control);

	[_faction,_person] remoteExec ["Server_Government_UnsetRank", 2];
	[_person, "citizen"] remoteExec ["Server_Player_Whitelist",2];

	{
		private _persons = _x select 1;
		if (_person IN _persons) then {
			_persons = _persons - [_person];
			A3PL_GOVRANKS set [_forEachIndex,[(_x select 0),_persons,(_x select 2)]];
		};
	} foreach A3PL_GOVRANKS;
	call A3PL_Government_UpdateRanks;

	private _unit = [_person] call A3PL_Lib_UIDToObject;
	if(!isNull _unit) then {
		["You have been removed from your faction","red"] remoteExec ["A3PL_Player_Notification",_unit];
		_unit setVariable["faction","citizen",true];
		_unit setVariable["job","unemployed",true];
	};
}] call Server_Setup_Compile;

["A3PL_Government_AddRank",
{
	disableSerialization;
	private _display = findDisplay 111;
	private _faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (_faction isEqualTo "") exitwith {["System: Error determining the faction you are editing","red"] call A3PL_Player_Notification;};
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["Only the head of the faction can change that","red"] call A3PL_Player_Notification;};
	private _control = _display displayCtrl 1400;
	private _rank = ctrlText _control;
	private _exist = false;
	{
		if ((_x select 0) isEqualTo _rank) exitwith {_exist = true;};
	} foreach A3PL_GOVRANKS;
	if (_exist) exitwith {["This rank already exists","red"] call A3PL_Player_Notification;};
	if ((count _rank < 3) OR (count _rank > 30)) exitwith {["Invalid name","red"] call A3PL_Player_Notification;};

	[_faction,_rank] remoteExec ["Server_Government_AddRank", 2];
	private _control = _display displayCtrl 1502;
	private _index = _control lbAdd format ["%1 (Paycheck : $0.00)",_rank];
	_control lbSetData [_index,_rank];
	A3PL_GOVRANKS pushback [_rank,[],0];
}] call Server_Setup_Compile;

["A3PL_Government_RemoveRank",
{
	disableSerialization;
	private _display = findDisplay 111;
	private _faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["Only the head of the faction can change that","red"] call A3PL_Player_Notification;};
	if (_faction == "") exitwith {["System: Error determining the faction you are editing","red"] call A3PL_Player_Notification;};
	private _control = _display displayCtrl 1502;
	if (lbCurSel _control < 0) exitwith {["Please select a rank","red"] call A3PL_Player_Notification;};
	private _rank = _control lbData (lbCurSel _control);
	[_faction,_rank] remoteExec ["Server_Government_RemoveRank", 2];
	private _control = _display displayCtrl 1502;
	_control lbDelete (lbCurSel _control);
}] call Server_Setup_Compile;

["A3PL_Government_SetPay",
{
	disableSerialization;
	private _display = findDisplay 111;
	private _faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["Only the head of the faction can change that","red"] call A3PL_Player_Notification;};
	if (_faction == "") exitwith {["System: Error determining the faction you are editing","red"] call A3PL_Player_Notification;};
	private _control = _display displayCtrl 1401;
	private _pay = parseNumber (ctrlText _control);
	if ((_pay < FACTIONMINPAY) OR (_pay > FACTIONMAXPAY)) exitwith {[format ["Enter a paycheck between $%1 and $%2",FACTIONMINPAY,FACTIONMAXPAY],"red"] call A3PL_Player_Notification;};
	private _control = _display displayCtrl 1502;
	if (lbCurSel _control < 0) exitwith {["Please select a rank","red"] call A3PL_Player_Notification;};
	private _rank = _control lbData (lbCurSel _control);
	[_faction,_rank,_pay] remoteExec ["Server_Government_SetPay", 2];

	{
		if ((_x select 0) isEqualTo _rank) then {
			A3PL_GOVRANKS set [_forEachIndex,[_x select 0,_x select 1,_pay]];
		};
	} foreach (missionNameSpace getVariable ["A3PL_GOVRANKS",[]]);
	lbClear _control;
	{
		private _name = _x select 0;
		private _pay = _x select 2;
		private _index = _control lbAdd format ["%1 - $%2",_name,([_pay, 1, 0, true] call CBA_fnc_formatNumber)];
		_control lbSetData [_index,_name];
	} foreach (missionNameSpace getVariable ["A3PL_GOVRANKS",[]]);
}] call Server_Setup_Compile;

["A3PL_Government_Budget",
{
	disableSerialization;
	createDialog "Dialog_Budget_Manage";
	private _display = findDisplay 140;
	private _balance = [player getVariable["faction","citizen"]] call A3PL_Config_GetBalance;
	private _balanceAmount = 0;
	{
		if ((_x select 0) isEqualTo _balance) exitwith {_balanceAmount = _x select 1;};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);
	private _control = _display displayCtrl 1201;
	_control ctrlSetStructuredText parseText format ["$%1",[_balanceAmount, 1, 0, true] call CBA_fnc_formatNumber];
}] call Server_Setup_Compile;

["A3PL_Government_BudgetAdd",
{
	private _display = findDisplay 140;
	private _control = _display displayCtrl 1202;
	private _value = parseNumber (ctrlText _control);
	if (_value < 1) exitwith {[localize"STR_NewGovernment_ValidAmnt","red"] call A3PL_Player_Notification;};

	_pBank = player getVariable["Player_Bank",0];
	_balance = [player getVariable["faction","citizen"]] call A3PL_Config_GetBalance;
	if(_pBank < _value) exitwith {[format ["You don't have $%1 on your bank account",_value],"red"] call A3PL_Player_Notification;};

	player setVariable["Player_Bank",(_pBank-_value),true];
	[_balance,_value, "", format["Transfer from %1",name player]] remoteExec ["Server_Government_AddBalance",2];
	[format ["You have transferred $%1 to the account of %2",_value, _balance],"green"] call A3PL_Player_Notification;
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_Government_BudgetWithdraw",
{
	private _display = findDisplay 140;
	private _control = _display displayCtrl 1202;
	private _value = parseNumber (ctrlText _control);
	if (_value < 1) exitwith {[localize"STR_NewGovernment_ValidAmnt","red"] call A3PL_Player_Notification;};

	private _pBank = player getVariable["Player_Bank",0];
	private _balance = [player getVariable["faction","citizen"]] call A3PL_Config_GetBalance;
	private _balanceAmount = 0;
	{
		if ((_x select 0) isEqualTo _balance) exitwith {_balanceAmount = _x select 1;};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);

	if(_balanceAmount < _value) exitwith {[format ["%2 don't have $%1",_value, _balance],"red"] call A3PL_Player_Notification;};

	player setVariable["Player_Bank",(_pBank+_value),true];
	[_balance,-_value, "", format["Withdraw of %1",name player]] remoteExec ["Server_Government_AddBalance",2];
	[format ["You withdrawn $%1 from the account of %2",_value, _balance],"green"] call A3PL_Player_Notification;
	closeDialog 0;
}] call Server_Setup_Compile;

['A3PL_Government_HistoryOpen', {
	disableSerialization;
	private _faction = player getVariable["faction","citizen"];
	private _isLeader = [_faction] call A3PL_Government_isFactionLeader;
	if(!_isLeader) exitWith {[localize"STR_BUSINESS_ONLYLEADERCANUSEMONEYOFFACTION","red"] call A3PL_Player_Notification;};
	createDialog "Dialog_FactionBudget_History";
	private _display = findDisplay 138;
	private _control = _display displayCtrl 1600;
	_control buttonSetAction "[0] call A3PL_Lib_CloseDialog;";
	[_faction,player] remoteExec ["Server_Government_HistorySetup",2];
}] call Server_Setup_Compile;

['A3PL_Government_HistoryReceive', {
	private _history = param [0,[]];
	private _display = findDisplay 138;
	private _control = _display displayCtrl 1500;
	if(count _history isEqualTo 0) then {
		_control lbAdd localize"STR_COMPANY_NOTRANSACTION";
	} else {
		{
			if((_x select 0) > 0) then{
				_control lbAdd format["%3 | $%1 (%2)", _x select 0, _x select 1, _x select 2];
				_control lbSetColor [_forEachIndex, [0,0.8,0.1,1]];
			} else {
				_control lbAdd format["%3 | $%1 (%2)", _x select 0, _x select 1, _x select 2];
				_control lbSetColor [_forEachIndex, [0.8,0,0.1,1]];
			};
		} foreach _history;
	};
}] call Server_Setup_Compile;

["A3PL_Government_FactionPay",
{
	private _factionBalanceError = false;
	private _factionBalance = [player] call A3PL_Government_MyFactionBalance;
	private _rankName = [_job,"rank", getPlayerUID player] call A3PL_Config_GetFactionRankData;
	private _payAmount = [_job,"pay", getPlayerUID player] call A3PL_Config_GetFactionRankData;
	if(_factionBalance < _payAmount) then {_factionBalanceError = true;};
	if(_factionBalanceError) exitwith {[format[localize"STR_NewLoop_2"], "red"] call A3PL_Player_Notification;};
	_balance = [_job] call A3PL_Config_GetBalance;
	[_balance, -_payAmount] remoteExec ["Server_Government_AddBalance",2];
	[format[localize"STR_NewLoop_3",_rankName,(_payAmount * A3PL_Event_Paycheck)], "green"] call A3PL_Player_Notification;
	_payAmount;
}] call Server_Setup_Compile;

["A3PL_Government_CatChange",
{
	disableSerialization;
	private _display = findDisplay 111;
	private _control = _display displayCtrl 2100;
	private _faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (lbCurSel _control < 0) exitwith {};
	private _cat = _control lbText (lbCurSel _control);
	private _control = _display displayCtrl 1504;
	lbClear _control;
	{
		if ((_x select 0) isEqualTo _faction) exitwith
		{
			private _main = [] + _x;
			_main deleteAt 0;
			{
				if ((_x select 0) isEqualTo _cat) exitwith
				{
					{
						private _index = _control lbAdd (format["%1 - $%2",[(_x select 1),"name"] call A3PL_Config_GetItem, ([_x select 2, 1, 0, true] call CBA_fnc_formatNumber)]);
						_control lbSetData [_index,_x select 1];
						_control lbSetValue [_index,_x select 2];
					} foreach (_x select 1);
				};
			} foreach _main;
		};
	} foreach Config_FactionItems;
}] call Server_Setup_Compile;

["A3PL_Government_ItemBuy",
{
	disableSerialization;
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _display = findDisplay 111;
	private _control = _display displayCtrl 1504;
	if (lbCurSel _control < 0) exitwith {["Please select an item","red"] call A3PL_Player_Notification;};

	private _faction = player getVariable["faction","citizen"];
	private _class = _control lbData (lbCurSel _control);
	private _price = _control lbValue (lbCurSel _control);

	private _factionBalance = [player] call A3PL_Government_MyFactionBalance;
	if(_factionBalance < _price) exitwith {["The budget of your department does not allow this purchase!","red"] call A3PL_Player_Notification;};
	private _balance = [_faction] call A3PL_Config_GetBalance;
	[_balance,-_price,"",format["Buy Item %1",_class]] remoteExec ["Server_Government_AddBalance",2];
	[_class,1] call A3PL_Inventory_add;
	[format["You bought a %1 your department budget (-$%2)", [_class,"name"] call A3PL_Config_GetItem, ([_price, 1, 0, true] call CBA_fnc_formatNumber)],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;