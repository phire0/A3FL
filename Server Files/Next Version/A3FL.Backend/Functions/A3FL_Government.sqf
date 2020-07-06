/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define CHARMAXLAWCOUNT 120
#define FACTIONBALANCES ["Fire Rescue","US Coast Guard","Sheriff Department","Department of Justice","Marshals Service","Cartel"]
#define FACTIONMINPAY 200
#define FACTIONMAXPAY 5000

["A3PL_Government_OpenTreasury",
{
	disableSerialization;
	private ["_display","_control","_totalBalance"];

	if (!(["fbi"] call A3PL_Government_isFactionLeader)) exitwith {[localize"STR_NewGovernment_AccessErr1","red"] call A3PL_Player_Notification;};

	createDialog "Dialog_Treasury";
	_display = findDisplay 109;
	_totalBalance = 0;

	//fill balance combos
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

	//set balance total
	_control = _display displayCtrl 1402;
	_control ctrlSetText format ["$%1",([_totalBalance, 1, 0, true] call CBA_fnc_formatNumber)];

	//fill the taxes
	_control = _display displayCtrl 2101;
	{
		_control lbAdd (_x select 0);
	} foreach (missionNameSpace getVariable ["Config_Government_Taxes",[]]);
	_control ctrlAddEventHandler ["LBSelChanged",
	{
		private ["_control","_taxRate","_taxSelected","_display"];
		_display = findDisplay 109;
		_control = param [0,ctrlNull];
		_taxSelected = _control lbText (lbCurSel _control);
		_taxRate = 0;
		{
			if (_x select 0 == _taxSelected) exitwith {_taxRate = _x select 1;};
		} foreach (missionNameSpace getVariable ["Config_Government_Taxes",[]]);
		_control = _display displayCtrl 1403;
		_control ctrlSetText format ["%1%2",_taxRate*100,"%"];
	}];

	//fill factions
	_control = _display displayCtrl 2102;
	{
		if ((_x select 0) IN FACTIONBALANCES) then
		{
			private ["_balanceName","_balanceAmount","_index"];
			_balanceName = format ["%1 (Budget : $%2)",(_x select 0),([(_x select 1), 1, 0, true] call CBA_fnc_formatNumber)];
			_index = _control lbAdd _balanceName;
			_control lbSetData [_index,_x select 0];
		};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);

	//fill laws
	_control = _display displayCtrl 2103;
	{
		private ["_lawi"];
		_lawi = _forEachIndex + 1;
		_control lbAdd format ["Decree %1",_lawi];
	} foreach (missionNameSpace getVariable ["Config_Government_Laws",[]]);

	_control ctrlAddEventHandler ["LBSelChanged",
	{
		private ["_control","_display"];
		_display = findDisplay 109;
		_control = param [0,ctrlNull];
		_law = Config_Government_Laws select (lbCurSel _control);
		_control = _display displayCtrl 1000; //set text to rscedit and rsctext
		_control ctrlSetText _law;
		_control = _display displayCtrl 1401;
		_control ctrlSetStructuredText parseText _law;
	}];
}] call Server_Setup_Compile;

["A3PL_Government_MyFactionBalance",
{
	private ["_player","_faction","_balanceAmount","_balance","_justName"];
	_player = param [0,player];
	_justName = param [1,false]; //if we dont want the balance, but the name of the balance
	_faction = _player getVariable ["faction","citizen"];

	//set structured texts
	_balance = [_faction] call A3PL_Config_GetBalance;
	if (_justName) exitwith {_balance;};
	_balanceAmount = 0;
	{
		if ((_x select 0) == _balance) exitwith {_balanceAmount = _x select 1;};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);
	_balanceAmount;
}] call Server_Setup_Compile;

["A3PL_Government_AddBalance",
{
	disableSerialization;
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_display","_control","_selectedBalance","_selectedBalanceAmount","_transferTo","_amount"];
	_display = findDisplay 109;
	_control = _display displayCtrl 2100;

	if (lbCurSel _control < 0) exitwith {["You did not select a balance to transfer money","red"] call A3PL_Player_Notification;};
	_selectedBalance = _control lbText (lbCurSel _control);
	_selectedBalanceAmount = 0;
	{
		if ((_x select 0) == _selectedBalance) exitwith {_selectedBalanceAmount = _x select 1;};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);

	_control = _display displayCtrl 2102;
	if (lbCurSel _control < 0) exitwith {["You did not select a target to transfer the money","red"] call A3PL_Player_Notification;};
	_transferTo = _control lbData (lbCurSel _control); //get the balance we are transfering to

	_control = _display displayCtrl 1404;
	_amount = parseNumber (ctrlText _control); //get the amount
	if (_amount < 1) exitwith {[localize"STR_NewGovernment_ValidAmnt","red"] call A3PL_Player_Notification;};
	if (_amount > _selectedBalanceAmount) exitwith {["You can not transfer more money than the amount of the current balance you have selected","red"] call A3PL_Player_Notification;};

	[_transferTo,_amount,_selectedBalance] remoteExec ["Server_Government_AddBalance", 2];
}] call Server_Setup_Compile;

["A3PL_Government_SetTax",
{
	disableSerialization;
	private ["_fail","_display","_control","_taxChanged","_rate"];
	_display = findDisplay 109;
	_control = _display displayCtrl 1403;

	//check input
	_fail = false;
	_rate = (ctrlText _control) splitString "%";
	if (count _rate == 0) then {_f = true};
	_rate = parseNumber (_rate select 0);
	if (isnil "_rate") exitwith {[localize"STR_NewGovernment_ValidAmnt","red"] call A3PL_Player_Notification;};
	if ((_rate > 100) OR (_rate < 0)) then {_fail = true};
	if (_fail) exitwith {["Please enter a valid number in the tax rate field between 0% and 100%","red"] call A3PL_Player_Notification;};
	//end of input check

	//get the tax we are changing
	_control = _display displayCtrl 2101;
	if (lbCurSel _control < 0) exitwith {["Select the tax you want to change first!","red"] call A3PL_Player_Notification;};
	_taxChanged = _control lbText (lbCurSel _control);

	_maxvalue = 30;
	switch(_taxChanged) do {
		case "House Tax": {_maxvalue = 5;};
		case "Buy Tax": {_maxvalue = 15;};
		case "Sell Tax": {_maxvalue = 20;};
		case "Import Tax": {_maxvalue = 25;};
		case "Export Tax": {_maxvalue = 25;};
		case "Eco Tax": {_maxvalue = 20;};
	};

	if((parseNumber (((ctrlText 1403) splitString "%") select 0)) > _maxvalue) exitwith {
		[format["This tax cannot exceed %1%2 !",_maxvalue,"%"],"red"] call A3PL_Player_Notification;
	};

	[_taxChanged,((parseNumber (((ctrlText 1403) splitString "%") select 0))/100)] remoteExec ["Server_Government_SetTax", 2];
	//["System: Send request to server to change the taxes, if succesfull a global message will announce the tax rate change.","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Government_NewTax",
{
	private ["_msg","_taxChanged","_oldTaxRate","_newTaxRate"];

	_taxChanged = param [0,""];
	_oldTaxRate = (param [1,0])*100;
	_newTaxRate = (param [2,0])*100;

	_msg = format ["Dear Citizens: The governor has changed %1 from %3%4 to %2%4",_taxChanged,_newTaxRate,_oldTaxRate,"%"];
	[_msg,"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Government_NewLaw",
{
	private ["_lawIndex"];
	_lawIndex = (param [0,0]) + 1;

	_msg = format ["Dear Citizens: The Governor has changed the decree %1, go to City Hall for more information on this decree!",_lawIndex];
	[_msg,"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Government_SetLaw",
{
	disableSerialization;
	private ["_fail","_display","_control","_selectedLaw","_lawText"];
	_display = findDisplay 109;
	_control = _display displayCtrl 2103; // get selected laws
	_selectedLaw = lbCurSel _control;
	if (_selectedLaw == -1) exitwith {["You have not selected any laws to modify","red"] call A3PL_Player_Notification;};

	_lawText = ctrlText (_display displayCtrl 1401);
	if ((count _lawText < 3) OR (count _lawText > CHARMAXLAWCOUNT)) exitwith {["Invalid lenght (3 to 70 chars)","red"] call A3PL_Player_Notification;};

	[0,_selectedLaw,_lawText] remoteExec ["Server_Government_ChangeLaw", 2];
}] call Server_Setup_Compile;

["A3PL_Government_AddLaw",
{
	disableSerialization;
	private ["_fail","_display","_control","_lawText"];
	_display = findDisplay 109;
	_control = _display displayCtrl 2103; // get selected laws

	_lawText = ctrlText (_display displayCtrl 1401);
	if ((count _lawText < 3) OR (count _lawText > CHARMAXLAWCOUNT)) exitwith {["Invalid lenght (3 to 70 chars)","red"] call A3PL_Player_Notification;};

	[1,0,_lawText] remoteExec ["Server_Government_ChangeLaw", 2];
}] call Server_Setup_Compile;

["A3PL_Government_RemoveLaw",
{
	disableSerialization;
	private ["_fail","_display","_control","_selectedLaw"];
	_display = findDisplay 109;
	_control = _display displayCtrl 2103;
	_selectedLaw = lbCurSel _control;
	if (_selectedLaw == -1) exitwith {["You have not selected any decree to delete","red"] call A3PL_Player_Notification;};
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

//opens the faction setup
["A3PL_Government_FactionSetup",
{
	disableSerialization;
	private ["_control","_display","_faction"];
	_faction = param [0,""];
	if (_faction == "") exitwith {["System: no faction send in param","red"] call A3PL_Player_Notification;};

	A3PL_GOVEDITFACTION = _faction;
	createDialog "Dialog_FactionSetup";
	_display = findDisplay 111;
	_display displayAddEventHandler ["Unload",{A3PL_GOVEDITFACTION = nil; A3PL_GOVRANKS = nil; A3PL_GOVPLIST = nil;}]; //clear temp globals

	[player,_faction] remoteExec ["Server_Government_FactionSetupInfo", 2];

	//when press a rank in the rank list
	_control = _display displayCtrl 1502;
	_control ctrlAddEventHandler ["LBSelChanged","call A3PL_Government_UpdateRanks;"];

	//add blueprints categories
	_control = _display displayCtrl 2100;
	_control ctrlAddEventHandler ["LBSelChanged","call A3PL_Government_BPCatChange;"];
	{
		if ((_x select 0) == _faction) exitwith
		{
			private ["_main"];
			_main = [] + _x;
			_main deleteAt 0;
			{_control lbAdd (_x select 0);} foreach _main;
		};
	} foreach Config_Blueprints;
}] call Server_Setup_Compile;

["A3PL_Government_BPCatChange",
{
	disableSerialization;
	private ["_control","_display","_cat","_faction"];
	_display = findDisplay 111;
	_control = _display displayCtrl 2100;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (lbCurSel _control < 0) exitwith {};
	_cat = _control lbText (lbCurSel _control);
	_control = _display displayCtrl 1504;
	lbClear _control;
	{
		if ((_x select 0) == _faction) exitwith
		{
			private _main = [] append _x;
			_main deleteAt 0;
			{
				if ((_x select 0) == _cat) exitwith
				{
					for "_i" from 1 to ((count _x)-1) do
					{
						private ["_index"];
						_index = _control lbAdd (format["%1 - $%2",[(_x select _i) select 0,"name"] call A3PL_Config_GetItem, (_x select _i) select 1]);
						_control lbSetData [_index,(((_x select _i) select 0) + "," + str((_x select _i) select 1))];
					};
				};
			} foreach _main;
		};
	} foreach Config_Blueprints;
}] call Server_Setup_Compile;

["A3PL_Government_BPCreate",
{
	disableSerialization;
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_display","_control","_bp","_data","_class","_price"];
	_display = findDisplay 111;
	_control = _display displayCtrl 1504;
	if (lbCurSel _control < 0) exitwith {["Please select a blueprint","red"] call A3PL_Player_Notification;};

	_bp = _control lbData (lbCurSel _control);
	_faction = player getVariable["faction","citizen"];
	_data = _bp splitString ",";
	_class = _data select 0;
	_price = parseNumber(_data select 1);

	_factionBalance = [player] call A3PL_Government_MyFactionBalance;
	if(_factionBalance < _price) exitwith {
		["The budget of your department does not allow this purchase!","red"] call A3PL_Player_Notification;
	};

	_balance = [_faction] call A3PL_Config_GetBalance;
	[_balance,-_price,"",format["Blueprint %1",_class]] remoteExec ["Server_Government_AddBalance",2];
	[_class,1] call A3PL_Inventory_add;
	[format["You bought a %2 with the budget of: %1 (-$%3)",_balance, [_class,"name"] call A3PL_Config_GetItem, _price],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//receives info from server and inputs data into dialog
["A3PL_Government_FactionSetupReceive",
{
	disableSerialization;
	private ["_control","_display","_faction","_ranks","_playerList","_balanceAmount"];
	_display = findDisplay 111;
	_playerList = param [0,[]];
	_playerList sort true;
	_ranks = param [1,[]];
	// diag_log _ranks;
	// diag_log _playerList;
	A3PL_GOVRANKS = [] + _ranks;
	A3PL_GOVPLIST = [] + _playerList;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (_faction == "") exitwith {["System: Error determining the faction you are editing (_FactionSetupReceive)","red"] call A3PL_Player_Notification;};
	if (isNull _display) exitwith {};

	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		private ["_uid","_name","_index"];
		_name = _x select 0;
		_uid = _x select 1;
		_index = _control lbAdd _name;
		_control lbSetData [_index,_uid];
	} foreach _playerList;

	_control = _display displayCtrl 1502;
	lbClear _control;
	{
		private ["_pay","_name","_index"];
		_name = _x select 0;
		_pay = _x select 2;
		_index = _control lbAdd format ["%1 - $%2",_name,([_pay, 1, 0, true] call CBA_fnc_formatNumber)];
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
	private ["_control","_display","_rank"];
	_display = findDisplay 111;
	_control = _display displayCtrl 1502;
	_rank = _control lbData (lbCurSel _control);
	_control = _display displayCtrl 1500;
	lbClear _control;
	_pay = 0;
	{
		if ((_x select 0) == _rank) then
		{
			_pay = _x select 2;
			{
				private ["_uid","_name"];
				_uid = _x;
				_name = format ["Unknown (%1)",_uid];
				{
					if ((_x select 1) == _uid) then
					{
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
	private ["_control","_display","_person","_personName","_rank"];
	_display = findDisplay 111;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (_faction == "") exitwith {["Erreur impossible de déterminé la faction à éditer!","red"] call A3PL_Player_Notification;};
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["Only the head of the faction can change that","red"] call A3PL_Player_Notification;};
	_control = _display displayCtrl 1501;
	if (lbCurSel _control < 0) exitwith {["Please select a target","red"] call A3PL_Player_Notification;};
	_person = _control lbData (lbCurSel _control); //person we are changing rank for
	_personName = _control lbText (lbCurSel _control);
	_control = _display displayCtrl 1502;
	if (lbCurSel _control < 0) exitwith {["Please select a rank","red"] call A3PL_Player_Notification;};
	_rank = _control lbData (lbCurSel _control);

	[_faction,_person,_rank] remoteExec ["Server_Government_SetRank", 2];
	{
		//remove from other ranks
		private ["_persons","_rankx"];
		_rankx = _x select 0;
		_persons = _x select 1;
		if (_person IN _persons) then
		{
			_persons = _persons - [_person];
			A3PL_GOVRANKS set [_forEachIndex,[(_x select 0),_persons,(_x select 2)]];
		};

		//add to new rank
		if (_rankx == _rank) then
		{
			_persons pushback _person;
		};

	} foreach A3PL_GOVRANKS;
	call A3PL_Government_UpdateRanks;
}] call Server_Setup_Compile;

["A3PL_Government_AddRank",
{
	disableSerialization;
	private ["_control","_display","_rank","_faction","_index","_exist"];
	_display = findDisplay 111;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["Only the head of the faction can change that","red"] call A3PL_Player_Notification;};
	if (_faction == "") exitwith {["System: Error determining the faction you are editing","red"] call A3PL_Player_Notification;};
	_control = _display displayCtrl 1400;
	_rank = ctrlText _control;
	_exist = false;

	//check if exist
	{
		if ((_x select 0) == _rank) exitwith {_exist = true;};//check if rank exist already
	} foreach A3PL_GOVRANKS;
	if (_exist) exitwith {["This rank already exists","red"] call A3PL_Player_Notification;};
	if ((count _rank < 3) OR (count _rank > 30)) exitwith {["Invalid name","red"] call A3PL_Player_Notification;};

	[_faction,_rank] remoteExec ["Server_Government_AddRank", 2];

	//add to listbox locally
	_control = _display displayCtrl 1502;
	_index = _control lbAdd format ["%1 (Paycheck : $0.00)",_rank];
	_control lbSetData [_index,_rank];
	A3PL_GOVRANKS pushback [_rank,[],0];
}] call Server_Setup_Compile;

["A3PL_Government_RemoveRank",
{
	disableSerialization;
	private ["_control","_display","_rank","_faction"];
	_display = findDisplay 111;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["Only the head of the faction can change that","red"] call A3PL_Player_Notification;};
	if (_faction == "") exitwith {["System: Error determining the faction you are editing","red"] call A3PL_Player_Notification;};
	_control = _display displayCtrl 1502;

	if (lbCurSel _control < 0) exitwith {["Please select a rank","red"] call A3PL_Player_Notification;};
	_rank = _control lbData (lbCurSel _control);

	[_faction,_rank] remoteExec ["Server_Government_RemoveRank", 2];

	//remove from listbox locally
	_control = _display displayCtrl 1502;
	_control lbDelete (lbCurSel _control);
}] call Server_Setup_Compile;

["A3PL_Government_SetPay",
{
	disableSerialization;
	private ["_control","_display","_rank","_pay"];
	_display = findDisplay 111;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["Only the head of the faction can change that","red"] call A3PL_Player_Notification;};
	if (_faction == "") exitwith {["System: Error determining the faction you are editing","red"] call A3PL_Player_Notification;};
	_control = _display displayCtrl 1401;
	_pay = parseNumber (ctrlText _control);
	if ((_pay < FACTIONMINPAY) OR (_pay > FACTIONMAXPAY)) exitwith {[format ["Enter a paycheck between $%1 and $%2",FACTIONMINPAY,FACTIONMAXPAY],"red"] call A3PL_Player_Notification;};
	_control = _display displayCtrl 1502; //rank we are changing
	if (lbCurSel _control < 0) exitwith {["Please select a rank","red"] call A3PL_Player_Notification;};
	_rank = _control lbData (lbCurSel _control);

	[_faction,_rank,_pay] remoteExec ["Server_Government_SetPay", 2];

	//set locally
	{
		if ((_x select 0) == _rank) then {
			A3PL_GOVRANKS set [_forEachIndex,[_x select 0,_x select 1,_pay]];
		};
	} foreach (missionNameSpace getVariable ["A3PL_GOVRANKS",[]]);
	lbClear _control;
	{
		private ["_pay","_name","_index"];
		_name = _x select 0;
		_pay = _x select 2;
		_index = _control lbAdd format ["%1 (Paycheck : $%2)",_name,([_pay, 1, 2, true] call CBA_fnc_formatNumber)];
		_control lbSetData [_index,_name];
	} foreach (missionNameSpace getVariable ["A3PL_GOVRANKS",[]]);
}] call Server_Setup_Compile;

["A3PL_Government_Budget",
{
	private["_display","_control","_balanceAmount","_balance"];
	disableSerialization;
	createDialog "Dialog_Budget_Manage";
	_display = findDisplay 140;

	_balance = [player getVariable["faction","citizen"]] call A3PL_Config_GetBalance;
	_balanceAmount = 0;
	{
		if ((_x select 0) == _balance) exitwith {_balanceAmount = _x select 1;};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);

	_control = _display displayCtrl 1201;
	_control ctrlSetStructuredText parseText format ["$%1",[_balanceAmount, 1, 0, true] call CBA_fnc_formatNumber];
}] call Server_Setup_Compile;

["A3PL_Government_BudgetAdd",
{
	private["_display","_control","_value","_pBank","_balance"];
	_display = findDisplay 140;
	_control = _display displayCtrl 1202;
	_value = parseNumber (ctrlText _control);
	if (_value < 1) exitwith {[localize"STR_NewGovernment_ValidAmnt","red"] call A3PL_Player_Notification;};

	_pBank = player getVariable["Player_Bank",0];
	_balance = [player getVariable["faction","citizen"]] call A3PL_Config_GetBalance;

	if(_pBank < _value) exitwith {[format ["You don't have $%1 on your bank account",_value],"red"] call A3PL_Player_Notification;};

	//Money exchange
	player setVariable["Player_Bank",(_pBank-_value),true];
	[_balance,_value, "", format["Transfer from %1",name player]] remoteExec ["Server_Government_AddBalance",2];

	//Notf
	[format ["You have transferred $%1 to the account of %2",_value, _balance],"green"] call A3PL_Player_Notification;
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_Government_BudgetWithdraw",
{
	private["_display","_control","_value","_pBank","_balance"];
	_display = findDisplay 140;
	_control = _display displayCtrl 1202;
	_value = parseNumber (ctrlText _control);
	if (_value < 1) exitwith {[localize"STR_NewGovernment_ValidAmnt","red"] call A3PL_Player_Notification;};

	_pBank = player getVariable["Player_Bank",0];
	_balance = [player getVariable["faction","citizen"]] call A3PL_Config_GetBalance;
	_balanceAmount = 0;
	{
		if ((_x select 0) == _balance) exitwith {_balanceAmount = _x select 1;};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);

	if(_balanceAmount < _value) exitwith {[format ["%2 don't have $%1",_value, _balance],"red"] call A3PL_Player_Notification;};

	//Money exchange
	player setVariable["Player_Bank",(_pBank+_value),true];
	[_balance,-_value, "", format["Withdraw of %1",name player]] remoteExec ["Server_Government_AddBalance",2];

	//Notf
	[format ["You withdrawn $%1 from the account of %2",_value, _balance],"green"] call A3PL_Player_Notification;
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_Government_ReadLaws",
{
	disableSerialization;
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_control","_display","_rank","_pay"];
	createDialog "Dialog_Laws";
	_display = findDisplay 99;

	_control = _display displayCtrl 1500;
	{
		private ["_lawi"];
		_lawi = _forEachIndex + 1;
		_control lbAdd format ["Décret %1 - %2",_lawi,_x];
	} foreach (missionNameSpace getVariable ["Config_Government_Laws",[]]);

	_control = _display displayCtrl 1600;
	_control buttonSetAction "closeDialog 0;";
}] call Server_Setup_Compile;

['A3PL_Government_HistoryOpen', {
	private ["_display","_control","_faction","_isLeader"];
	disableSerialization;

	_faction = player getVariable["faction","citizen"];
	_isLeader = [_faction] call A3PL_Government_isFactionLeader;
	if(!_isLeader) exitWith {[localize"STR_BUSINESS_ONLYLEADERCANUSEMONEYOFFACTION","red"] call A3PL_Player_Notification;};

	createDialog "Dialog_FactionBudget_History";
	_display = findDisplay 138;

	_control = _display displayCtrl 1600;
	_control buttonSetAction "[0] call A3PL_Lib_CloseDialog;";
	[_faction,player] remoteExec ["Server_Government_HistorySetup",2];
}] call Server_Setup_Compile;

['A3PL_Government_HistoryReceive', {
	_history = param [0,[]];

	_display = findDisplay 138;
	_control = _display displayCtrl 1500;
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