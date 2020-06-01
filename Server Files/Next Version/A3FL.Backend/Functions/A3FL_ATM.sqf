/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['A3PL_ATM_Open', {
	private ['_bankBalance', '_cashBalance', '_index'];

	_bankBalance = player getVariable ['Player_Bank',0];
	_cashBalance = call A3PL_Inventory_GetCash; //should prevent withdrawing and account for factory usage

	['Dialog_ATM'] call A3PL_Lib_CreateDialog;

	//setup text
	ctrlSetText [4974, [_bankBalance, 1, 0, true] call CBA_fnc_formatNumber]; //[_bankBalance] call A3PL_Lib_FormatNumber];
	ctrlSetText [4975, [_cashBalance, 1, 0, true] call CBA_fnc_formatNumber]; //[_cashBalance] call A3PL_Lib_FormatNumber];
	ctrlSetText [5372, '0'];

	//creates list of players online - for transfer option
	{
		_index = lbAdd [5472, format["%1", name _x]];
		lbSetData [5472, _index, str _x];
	} forEach (playableUnits - [player]);

	//Add companies to the list
	{
		_index = lbAdd [5472, format[localize"STR_ATM_COMPANY", _x select 1]];
		lbSetData [5472, _index, str(_x select 0)];
	} forEach (Server_Companies);
}] call Server_Setup_Compile;

['A3PL_ATM_Deposit', {
	private ['_amount', '_format'];

	_amount = round(parseNumber(ctrlText 5372));

	if (((TypeName _amount) != 'SCALAR') || (_amount <= 0)) exitWith {
		[localize"STR_Various_INVALIDAMOUNT", "red"] call A3PL_Player_Notification;
	};

	if (!([_amount] call A3PL_Player_HasCash)) exitWith {
		[localize"STR_Various_INVALIDAMOUNT", "red"] call A3PL_Player_Notification;
	};

	[player, 'Player_Cash', ((player getVariable 'Player_Cash') - _amount)] remoteExec ["Server_Core_ChangeVar",2];
	[player, 'Player_Bank', ((player getVariable 'Player_Bank') + _amount)] remoteExec ["Server_Core_ChangeVar",2];
	
	[0] call A3PL_Lib_CloseDialog;

	_format = format[localize"STR_ATM_YOUDEPOSITAMOUNTINYOURBANKACCOUNT", [_amount] call A3PL_Lib_FormatNumber];
	[_format, "green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

['A3PL_ATM_Withdraw', {
	private ['_amount', '_format'];

	_amount = round(parseNumber(ctrlText 5372));

	if (((TypeName _amount) != 'SCALAR') || (_amount <= 0)) exitWith {
		[localize"STR_Various_INVALIDAMOUNT", "red"] call A3PL_Player_Notification;
	};

	if (!([_amount] call A3PL_Player_HasBank)) exitWith {
		[localize"STR_Various_INVALIDAMOUNT", "red"] call A3PL_Player_Notification;
	};

	[player, 'Player_Bank', ((player getVariable 'Player_Bank') - _amount)] remoteExec ["Server_Core_ChangeVar",2];
	[player, 'Player_Cash', ((player getVariable 'Player_Cash') + _amount)] remoteExec ["Server_Core_ChangeVar",2];

	[0] call A3PL_Lib_CloseDialog;

	_format = format[localize"STR_ATM_YOUWITHDRAWAMOUNTOFYOURBANKACCOUNT", [_amount] call A3PL_Lib_FormatNumber];
	[_format, "green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

['A3PL_ATM_Transfer', {
	private ['_amount', '_sendTo', '_sendToCompile', '_format','_companyTransfer'];

	_amount = round(parseNumber(ctrlText 5372));
	_companyTransfer = false;
	if([localize"STR_ATM_COMPANY2", lbText [5472, (lbCurSel 5472)]] call BIS_fnc_inString) then {_companyTransfer = true;} else {_companyTransfer = false;};
	
	if (((lbCurSel 5472) == -1) || (_amount <= 0)) exitWith {
		[localize"STR_Various_INVALIDAMOUNT", "red"] call A3PL_Player_Notification;
	};

	if (!([_amount] call A3PL_Player_HasBank)) exitWith {
		[localize"STR_ATM_INSUFFISANTAMOUNTINYOURBANKACCOUNT", "red"] call A3PL_Player_Notification;
	};

	[player, 'Player_Bank', ((player getVariable 'Player_Bank') - _amount)] remoteExec ["Server_Core_ChangeVar",2];

	if(_companyTransfer) then {
		_cid = parseNumber(lbData [5472, (lbCurSel 5472)]);
		[_cid, _amount, format[localize"STR_ATM_TRANSFER",player getVariable ["name","unknown"]]] remoteExec ["Server_Company_SetBank",2];
		_format = format[localize"STR_ATM_YOUTRANSFERAMOUNTTOCOMPANY", [_amount] call A3PL_Lib_FormatNumber];
	} else {
		_sendTo = lbData [5472, (lbCurSel 5472)];
		_sendToCompile = call compile _sendTo;
		if(isNull _sendToCompile) exitWith {_format = "Error: Unable to transfer";};
		_format = format[localize"STR_ATM_YOUTRANSFERAMOUNTTOPLAYER", [_amount] call A3PL_Lib_FormatNumber, (name _sendToCompile)];
		[format[localize"STR_ATM_YOURECEIVETRANSFER",_amount], "green"] remoteExec ["A3PL_Player_Notification",_sendToCompile];
		[_sendToCompile, 'Player_Bank', ((_sendToCompile getVariable 'Player_Bank') + _amount)] remoteExec ["Server_Core_ChangeVar",2];
	};
	[_format, "green"] call A3PL_Player_Notification;
	[0] call A3PL_Lib_CloseDialog;
},false,true] call Server_Setup_Compile;

['A3PL_ATM_MenuOpen', {
	createDialog "Dialog_ATM_Menu";
	private _bankBalance = player getVariable ['Player_Bank',0];
	ctrlSetText [4974, format["$%1",[_bankBalance, 1, 0, true] call CBA_fnc_formatNumber]];
}] call Server_Setup_Compile;