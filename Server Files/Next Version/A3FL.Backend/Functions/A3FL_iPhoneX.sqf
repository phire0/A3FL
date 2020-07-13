/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_iPhoneX_AppCall",
{
	private["_display","_control"];
	disableSerialization;

	createDialog "A3PL_iPhone_appCall";
	_display = findDisplay 98000;
	_callSettings = player getVariable ["A3PL_iPhoneX_CallSettings", ""];
	if !(isNil "_callSettings") then {
		if !(_callSettings isEqualTo []) then {
			_phoneNumberContact = _callSettings select 1;
			_control = _display displayCtrl 97661;
			_control ctrlSetText ([_phoneNumberContact] call A3PL_iPhoneX_GetContactName);

			_phoneNumberSendCall = player getVariable ["A3PL_iPhoneX_PhoneNumberSendCall",""];
			if ((_callSettings select 0) isEqualTo "1") then {ctrlShow [97667,true];ctrlShow [97663,true];buttonSetAction [97663, "_sound = player getVariable [""A3PL_iPhoneX_SoundCall"",objNull];if (!isNull _sound) then {deleteVehicle _sound;}; playSound3D [""A3PL_Common\GUI\phone\sounds\endcall_sound.ogg"", player, false, getPosASL player, 5, 1, 5]; [] spawn A3PL_iPhoneX_EndCall; _phoneNumberContact = player getVariable [""A3PL_iPhoneX_PhoneNumberReceiveCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberContact] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];_control = _display displayCtrl 97670;_control ctrlSetText (_callSettings select 2);};
			if ((_callSettings select 0) isEqualTo "2") then {
				ctrlShow [97675,true]; ctrlShow [97676,true]; ctrlShow [97677,true]; ctrlShow [97678,true];
				buttonSetAction [97676, "[] spawn A3PL_iPhoneX_StartCall; _phoneNumberSendCall = player getVariable [""A3PL_iPhoneX_PhoneNumberSendCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberSendCall] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_StartCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];
				buttonSetAction [97678, "_sound = player getVariable [""A3PL_iPhoneX_SoundCall"",objNull];if (!isNull _sound) then {deleteVehicle _sound;}; playSound3D [""A3PL_Common\GUI\phone\sounds\endcall_sound.ogg"", player, false, getPosASL player, 5, 1, 5]; [] spawn A3PL_iPhoneX_EndCall; _phoneNumberSendCall = player getVariable [""A3PL_iPhoneX_PhoneNumberSendCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberSendCall] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];};
			if ((_callSettings select 0) isEqualTo "3") then {
				ctrlShow [97667,true];ctrlShow [97663,true];ctrlShow [97668,true];ctrlShow [97664,true];ctrlShow [97669,true];ctrlShow [97665,true]; ctrlShow [97671,true]; ctrlShow [97672,true]; ctrlShow [97673,true]; ctrlShow [97674,true];
				if (A3PL_phoneNumberActive isEqualTo _phoneNumberSendCall) then {
					buttonSetAction [97663, "closeDialog 0; [] spawn A3PL_iPhoneX_EndCall;_phoneNumberContact = player getVariable [""A3PL_iPhoneX_PhoneNumberReceiveCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberContact] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];
				} else {
					buttonSetAction [97663, "closeDialog 0; [] spawn A3PL_iPhoneX_EndCall;_phoneNumberSendCall = player getVariable [""A3PL_iPhoneX_PhoneNumberSendCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberSendCall] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];
				};
				_control = _display displayCtrl 97670;
				_control ctrlSetText (_callSettings select 2);

				_hour = _callSettings select 3;
				_minute = _callSettings select 4;
				_second = _callSettings select 5;

				while {A3PL_phoneInCall} do {
					_time = format["%1:%2:%3", if (_hour < 10) then {"0" + (str _hour)} else {_hour}, if (_minute < 10) then {"0" + (str _minute)} else {_minute}, if (_second < 10) then {"0" + (str _second)} else {_second}];
					_second = _second + 1;
					if (_second >= 60) then {_second = 0; _minute = _minute + 1};
					if (_minute >= 60) then {_minute = 0; _hour = _hour + 1};
					_control ctrlSetText _time;
					player setVariable ["A3PL_iPhoneX_CallSettings", ["3", _phoneNumberContact, _time, _hour, _minute, _second]];
					uiSleep 1;
				};
			};
		};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SendCall",
{
	private["_phoneNumberContact","_display","_iPhone_X_phoneNumber","_exists"];
	disableSerialization;
	closeDialog 0;

	_phoneNumberContact = _this select 0;
	_error = false;
	if (_phoneNumberContact in ["Number", ""]) exitWith {['Invalid number',"red"] call A3PL_Player_Notification;};
	if ((count _phoneNumberContact) > 10) exitWith {['Invalid number',"red"] call A3PL_Player_Notification;};

	if !(isNil "A3PL_phoneNumberPrimary") then {if (A3PL_phoneNumberPrimary isEqualTo _phoneNumberContact) then {_error = true};};
	if !(isNil "A3PL_phoneNumberSecondary") then {if (A3PL_phoneNumberSecondary isEqualTo _phoneNumberContact) then {_error = true};};
	if !(isNil "A3PL_phoneNumberEnterprise") then {if (A3PL_phoneNumberEnterprise isEqualTo _phoneNumberContact) then {_error = true};};
	if (_error) exitWith {["You cannot call this number","red"] call A3PL_Player_Notification; _error = false;};

	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", []];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", []];
	player setVariable ["A3PL_iPhoneX_CallSettings", []];
	player setVariable ["A3PL_iPhoneX_SoundCall", objNull];

	A3PL_phoneCallOn = false;
	A3PL_phoneInCall = false;
	if ((_phoneNumberContact isEqualTo "911") OR (_phoneNumberContact isEqualTo "912")) then
	{
		A3PL_phoneCallOn = true;
		player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", A3PL_phoneNumberActive];
		player setVariable ["A3PL_iPhoneX_CallSettings", ["1", _phoneNumberContact, "Call in progress..."]];
		[player, A3PL_phoneNumberActive, _phoneNumberContact] remoteExec ["Server_iPhoneX_callSwitchboard",2];
		_sound = "Land_HelipadEmpty_F" createVehicle position player; _sound attachTo [player, [0, 0, 0]]; _sound say3D ["sendcall_sound",10,1]; player setVariable ["A3PL_iPhoneX_SoundCall",_sound];
		ctrlShow [97667,true];
		ctrlShow [97663,true];
		buttonSetAction [97663, "_sound = player getVariable [""A3PL_iPhoneX_SoundCall"",objNull];if (!isNull _sound) then {deleteVehicle _sound;}; playSound3D [""A3PL_Common\GUI\phone\sounds\endcall_sound.ogg"", player, false, getPosASL player, 5, 1, 5];[] spawn A3PL_iPhoneX_EndCall;_fd = [""fifr""] call A3PL_Lib_FactionPlayers;_cops = [""fisd""] call A3PL_Lib_FactionPlayers;{[A3PL_phoneNumberActive] remoteExec [""A3PL_iPhoneX_EndCallSwitchboard"", _x];} foreach _cops;{[A3PL_phoneNumberActive] remoteExec [""A3PL_iPhoneX_EndCallSwitchboard"", _x];} foreach _fd;"];
		[] spawn A3PL_iPhoneX_AppCall;
	} else {
		[player] remoteExec ["Server_iPhoneX_GetListNumber",2];

		waitUntil {!(isNil "A3PL_iPhoneX_ListNumberClient")};
		waitUntil {!(A3PL_iPhoneX_ListNumberClient isEqualTo [])};

		[] spawn A3PL_iPhoneX_AppCall;
		_exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberContact] call BIS_fnc_findNestedElement;
		if (!(_exists isEqualTo [])) then {
			A3PL_phoneCallOn = true;
			player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", A3PL_phoneNumberActive];
			player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", _phoneNumberContact];
			player setVariable ["A3PL_iPhoneX_CallSettings", ["1", _phoneNumberContact, "Call in progress..."]];
			[player, A3PL_phoneNumberActive, _phoneNumberContact] remoteExec ["A3PL_iPhoneX_ReceiveCall", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)];
			_sound = "Land_HelipadEmpty_F" createVehicle position player; _sound attachTo [player, [0, 0, 0]]; _sound say3D ["sendcall_sound",10,1]; player setVariable ["A3PL_iPhoneX_SoundCall",_sound];
			ctrlShow [97667,true];
			ctrlShow [97663,true];
			buttonSetAction [97663, "_sound = player getVariable [""A3PL_iPhoneX_SoundCall"",objNull];if (!isNull _sound) then {deleteVehicle _sound;}; playSound3D [""A3PL_Common\GUI\phone\sounds\endcall_sound.ogg"", player, false, getPosASL player, 5, 1, 5]; [] spawn A3PL_iPhoneX_EndCall; _phoneNumberContact = player getVariable [""A3PL_iPhoneX_PhoneNumberReceiveCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberContact] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];
		} else {
			player say3D ["endcall_sound",10,1];
			A3PL_iPhoneX_ListNumberClient = [];
			closeDialog 0;
		};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_ReceiveCall",
{
	private["_from","_display","_iPhone_X_phoneNumber","_iPhone_X_unhook_hangup","_exists"];
	disableSerialization;

	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_from = [_this,1,"",[""]] call BIS_fnc_param;
	_phoneNumberContact = [_this,2,"",[""]] call BIS_fnc_param;

	_ownerID = owner _unit;

	if !(A3PL_phoneNumberActive isEqualTo _phoneNumberContact) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _ownerID];};

	if (A3PL_phoneCallOn) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _ownerID];};
	if (A3PL_phoneInCall) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _ownerID];};

	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", []];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", []];
	player setVariable ["A3PL_iPhoneX_CallSettings", []];
	player setVariable ["A3PL_iPhoneX_SoundCall", objNull];
	A3PL_phoneInCall = false;

	[player] remoteExec ["Server_iPhoneX_GetListNumber",2];

	waitUntil {!(isNil "A3PL_iPhoneX_ListNumberClient")};
	waitUntil {!(A3PL_iPhoneX_ListNumberClient isEqualTo [])};

	A3PL_phoneCallOn = true;
	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", _from];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", A3PL_phoneNumberActive];
	player setVariable ["A3PL_iPhoneX_CallSettings", ["2", _from]];

	_iPhone_Settings = profileNamespace getVariable ["A3PL_iPhoneX_Settings",[2,1,0]];
	if ((_iPhone_Settings select 2) isEqualTo 0) then {
		_soundReceive = "receivecall_sound_%1";
		_soundReceive = format[_soundReceive, (_iPhone_Settings select 1)];
		_sound = "Land_HelipadEmpty_F" createVehicle position player; _sound attachTo [player, [0, 0, 0]]; _sound say3D [_soundReceive,10,1]; player setVariable ["A3PL_iPhoneX_SoundCall",_sound];
	};

	["Your phone is ringing...","yellow"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_ReceiveCallSwitchboard",
{
	private["_from","_display","_iPhone_X_phoneNumber","_iPhone_X_unhook_hangup","_exists"];
	disableSerialization;

	_index = _this select 0;
	_from = _this select 1;
	_fromNum = _this select 2;
	_phoneNumberContact = _this select 3;

	if !(A3PL_phoneNumberActive isEqualTo _phoneNumberContact) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _from];};

	if (A3PL_phoneCallOn) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _from];};
	if (A3PL_phoneInCall) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _from];};

	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", []];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", []];
	player setVariable ["A3PL_iPhoneX_CallSettings", []];
	player setVariable ["A3PL_iPhoneX_SoundCall", objNull];
	A3PL_phoneInCall = false;

	[player] remoteExec ["Server_iPhoneX_GetListNumber",2];

	waitUntil {!(isNil "A3PL_iPhoneX_ListNumberClient")};
	waitUntil {!(A3PL_iPhoneX_ListNumberClient isEqualTo [])};

	_exists = [A3PL_switchboard, _fromNum] call BIS_fnc_findNestedElement;

	A3PL_phoneCallOn = true;
	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", _fromNum];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", A3PL_phoneNumberActive];
	player setVariable ["A3PL_iPhoneX_CallSettings", ["2", _fromNum]];

	closeDialog 0;
	[] spawn A3PL_iPhoneX_appCall;

	if (!(_exists isEqualTo [])) then {
		A3PL_switchboard = ([A3PL_switchboard, (_exists select 0)] call BIS_fnc_removeIndex);
		[A3PL_switchboard] remoteExec ["Server_iPhoneX_setSwitchboard",2];
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_StartCall",
{
	private["_phoneNumber"];
	disableSerialization;

	A3PL_phoneInCall = true;

	_display = findDisplay 98000;
	_iPhone_X_informations = _display displayCtrl 97670;
	_iPhone_X_informations ctrlSetText "Call in progress...";

	_sound = player getVariable ["A3PL_iPhoneX_SoundCall",objNull];
	if (!isNull _sound) then {deleteVehicle _sound;};
	_phoneNumberSendCall = player getVariable ["A3PL_iPhoneX_PhoneNumberSendCall",""];
	_phoneNumberContact = player getVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall",""];
	[(call TFAR_fnc_activeSwRadio), format["%1", _phoneNumberSendCall]] call TFAR_fnc_setSwFrequency;

	_ctrl = [97675,97676,97677,97678];
	{(_display displayCtrl _x) ctrlShow false;} forEach _ctrl;
	ctrlShow [97667,true];
	ctrlShow [97663,true];
	ctrlShow [97668,true];
	ctrlShow [97664,true];
	ctrlShow [97669,true];
	ctrlShow [97665,true];
	ctrlShow [97671,true];
	ctrlShow [97672,true];
	ctrlShow [97673,true];
	ctrlShow [97674,true];

	if ((A3PL_phoneNumberActive) isEqualTo (_phoneNumberSendCall)) then {
		buttonSetAction [97663, "[] spawn A3PL_iPhoneX_EndCall; _phoneNumberContact = player getVariable [""A3PL_iPhoneX_PhoneNumberReceiveCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberContact] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];
	} else {
		buttonSetAction [97663, "[] spawn A3PL_iPhoneX_EndCall; _phoneNumberSendCall = player getVariable [""A3PL_iPhoneX_PhoneNumberSendCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberSendCall] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];
	};
	_control = _display displayCtrl 97661;
	_control ctrlSetText ([_phoneNumberContact] call A3PL_iPhoneX_GetContactName);

	_hour = 0;
	_minute = 0;
	_second = 0;
	while {A3PL_phoneInCall} do
	{
		_time = format["%1:%2:%3", if (_hour < 10) then {"0" + (str _hour)} else {_hour}, if (_minute < 10) then {"0" + (str _minute)} else {_minute}, if (_second < 10) then {"0" + (str _second)} else {_second}];
		_second = _second + 1;
		if (_second >= 60) then {_second = 0; _minute = _minute + 1};
		if (_minute >= 60) then {_minute = 0; _hour = _hour + 1};
		_iPhone_X_informations ctrlSetText _time;
		player setVariable ["A3PL_iPhoneX_CallSettings", ["3", _phoneNumberContact, _time, _hour, _minute, _second]];
		uiSleep 1;
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_EndCall",
{
	private["_type","_display","_iPhone_X_phoneNumber"];
	disableSerialization;

	_display = findDisplay 98000;
	_iPhone_X_phoneNumber = _display displayCtrl 97661;
	_iPhone_X_informations = _display displayCtrl 97670;

	_sound = player getVariable ["A3PL_iPhoneX_SoundCall",objNull];
	if (!isNull _sound) then {deleteVehicle _sound;};

	if (A3PL_phoneInCall) then {_info = "Call ended";};

	_iPhone_X_phoneNumber ctrlSetText "";
	_iPhone_X_informations ctrlSetText "";
	A3PL_iPhoneX_ListNumberClient = [];
	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", []];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", []];
	player setVariable ["A3PL_iPhoneX_CallSettings", []];
	player setVariable ["A3PL_iPhoneX_SoundCall", objNull];
	A3PL_phoneCallOn = false;
	A3PL_phoneInCall = false;
	[(call TFAR_fnc_activeSwRadio), 1, (getPlayerUid player)] call TFAR_fnc_SetChannelFrequency;
	closeDialog 0;

	//Animation
	if(!isNil "A3PL_Phone_Call") then {deleteVehicle A3PL_Phone_Call;};
	player playAction "gesturenod";
}] call Server_Setup_Compile;

["A3PL_iPhoneX_EndCallSwitchboard",
{
	private["_type","_display","_iPhone_X_phoneNumber"];
	disableSerialization;

	_fromNum = _this select 0;

	if !(isNil A3PL_phoneNumberEnterprise) then {
		if ((A3PL_phoneNumberEnterprise isEqualTo "911") OR (A3PL_phoneNumberEnterprise isEqualTo "912")) then {
			_exists = [A3PL_switchboard, _fromNum] call BIS_fnc_findNestedElement;
			if (!(_exists isEqualTo [])) then {
				A3PL_switchboard = ([A3PL_switchboard, (_exists select 0)] call BIS_fnc_removeIndex);
				[A3PL_switchboard] remoteExec ["Server_iPhoneX_SetSwitchboard",2];
			};
		};
	};
	[(call TFAR_fnc_activeSwRadio), 1, (getPlayerUid player)] call TFAR_fnc_SetChannelFrequency;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SwitchboardReceive",
{
	private ["_from","_to","_nameContact"];
	disableSerialization;
	_from = _this select 0;
	_to = _this select 1;

	if (_to IN ["911","912"]) then {
		if(!isNil "A3PL_phoneNumberEnterprise") then {
			if ((_to isEqualTo A3PL_phoneNumberEnterprise)) then {
				["Someone is calling on the emergency line","yellow"] call A3PL_Player_Notification;
				playSound3D ["A3PL_Common\GUI\phone\sounds\emergency_sound.ogg", player, false, getPosASL player, 5, 1, 5];
				player setVariable["iPhone_911_Call",true,false];
				uiSleep 60;
				player setVariable["iPhone_911_Call",nil,false];
			};
		};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AddPhoneNumber",
{
	private["_type","_price","_phoneNumber","_bank","_isUsed","_addXP"];
	params[
		["_type","",[""]]
	];
	disableSerialization;
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	_price = 0;
	_var = "";
	_addXP = 0;
	switch(_type) do {
		case("1"): {
			_price = 800;
			_var = "A3PL_phoneNumberPrimary";
			_addXP = 25;
		};
		case("2"): {
			_price = 50000;
			_var = "A3PL_phoneNumberSecondary";
			_addXP = 50;
		};
		case("3"): {
			_price = 30000;
			_var = "A3PL_phoneNumberEnterprise";
			_addXP = 100;
		};
	};
	if(_var isEqualTo "") exitWith {};

	_bank = (player getVariable["Player_Bank",0]);
	if(_bank < _price) exitWith {[format [localize"STR_iPhoneX_NeedCash",_price-_bank],"red"] call A3PL_Player_Notification;};
	if(!isNil _var) exitWith {[localize"STR_iPhoneX_AleradyHave","red"] call A3PL_Player_Notification;};

	_phoneNumber = [6,3];
	for "_i" from 0 to 4 do {
		_phoneNumber pushBack (selectRandom [0,1,2,3,4,5,6,7,8,9]);
	};
	_phoneNumber = _phoneNumber joinString "";

	[player, _phoneNumber] remoteExec ["Server_iPhoneX_NumberIsUsed",2];
	waitUntil {!(isNil 'A3PL_iPhoneX_NumberIsUsed')};
	_isUsed = A3PL_iPhoneX_NumberIsUsed;
	A3PL_iPhoneX_NumberIsUsed = nil;
	if (A3PL_iPhoneX_NumberIsUsed) exitWith {[localize"STR_iPhoneX_ErrorSetNumber","red"] call A3PL_Player_Notification;};

	[(getPlayerUID player), _phoneNumber, _type] remoteExec ["Server_iPhoneX_addPhoneNumber",2];
	uiSleep 3;
	[player] remoteExec ["Server_iPhoneX_getPhoneNumber",2];

	[format ["Your number is %1",_phoneNumber],"green"] call A3PL_Player_Notification;
	player setVariable["Player_Bank",_bank-_price,true];
	[player, _addXP] call A3PL_Level_AddXP;
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_setPhoneNumber",
{
	private ["_numberSet","_type"];
	params[
		["_numberSet","",[""]],
		["_type","",[""]]
	];
	if (_numberSet isEqualTo "") exitWith {[localize"STR_iPhoneX_ErroNumber","red"] call A3PL_Player_Notification;};
	switch(_type) do {
		case("Primary"): {A3PL_phoneNumberPrimary = _numberSet;};
		case("Secondary"): {A3PL_phoneNumberSecondary = _numberSet;};
		case("Enterprise"): {A3PL_phoneNumberEnterprise = _numberSet;};
		case("Active"): {A3PL_phoneNumberActive = _numberSet;};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AddContact",
{
	private["_uid","_contacts","_nameContact","_phoneNumberContact","_exists"];
	disableSerialization;

	if (count A3PL_contacts > 100) exitWith {["Contacts limit reached","red"] call A3PL_Player_Notification;};

	_uid = getPlayerUID player;
	_contacts = A3PL_contacts;
	_nameContact = ctrlText 97605;
	_phoneNumberContact = ctrlText 97606;
	_noteContact = ctrlText 97658;

	_nameContact = _nameContact splitString "'" joinString " ";
	_noteContact = _noteContact splitString "'" joinString " ";

	if (_nameContact in ["Identity", ""]) exitWith {["Invalid identity","red"] call A3PL_Player_Notification;};
	if (_phoneNumberContact in ["Number", ""]) exitWith {["Invalid number","red"] call A3PL_Player_Notification;};
	if (_noteContact isEqualTo "Note") then {_noteContact = ""};

	_exists = [_contacts, _phoneNumberContact] call BIS_fnc_findNestedElement;
	if (!(_exists isEqualTo [])) exitWith {["This contact already exists","red"] call A3PL_Player_Notification;};

	_contacts pushBack [_nameContact, _phoneNumberContact, _noteContact];
	A3PL_contacts = [_contacts,[],{_x select 0},"ASCEND"] call BIS_fnc_sortBy;
	[_uid, _nameContact, _phoneNumberContact, _noteContact] remoteExec ["Server_iPhoneX_SaveContact",2];

	{ctrlDelete _x;} count (player getVariable ["iPhoneX_PhoneContacts", []]);
	call A3PL_iPhoneX_AppContactsList;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_DeleteContact",
{
	private _number = [_this,0,"",[""]] call BIS_fnc_param;
	[player,_number] remoteExec ["Server_iPhoneX_DeleteContact",2];
	uiSleep 0.5;
	closeDialog 0;
	call A3PL_iPhoneX_AppContactsList;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AddConversation",
{
	private["_uid","_conversations","_nameContact","_phoneNumberContact","_exists","_error"];
	disableSerialization;

	if (count A3PL_conversations > 100) exitWith {["Conversations limit reached","red"] call A3PL_Player_Notification;};

	_uid = getPlayerUID player;
	_conversations = A3PL_conversations;
	_nameContact = ctrlText 97607;
	_phoneNumberContact = ctrlText 97608;
	_message = "No message";
	_error = false;

	_nameContact = _nameContact splitString "'" joinString " ";
	_message = _message splitString "'" joinString " ";

	if (_nameContact in ["Identity", ""]) exitWith {["Invalid identity","red"] call A3PL_Player_Notification;};
	if (_phoneNumberContact in ["Number", ""]) exitWith {["Invalid number","red"] call A3PL_Player_Notification;};
	if !(isNil "A3PL_phoneNumberPrimary") then {if (A3PL_phoneNumberPrimary isEqualTo _phoneNumberContact) then {_error = true};};
	if !(isNil "A3PL_phoneNumberSecondary") then {if (A3PL_phoneNumberSecondary isEqualTo _phoneNumberContact) then {_error = true};};

	if (_error) exitWith {["You cannot create a conversation with this number","red"] call A3PL_Player_Notification; _error = false;};

	_exists = [_conversations, _phoneNumberContact] call BIS_fnc_findNestedElement;
	if (!(_exists isEqualTo [])) exitWith {["This conversation already exists","red"] call A3PL_Player_Notification;};

	_conversations pushBack [_nameContact, _phoneNumberContact, "Aucun message reçu"];
	A3PL_conversations = [_conversations,[],{_x select 0},"ASCEND"] call BIS_fnc_sortBy;
	[_uid, _nameContact, _phoneNumberContact, _message] remoteExec ["Server_iPhoneX_SaveConversation",2];

	{ctrlDelete _x;} count (player getVariable ["iPhoneX_PhoneConversations", []]);
	_error = false;
	closeDialog 0;
	call A3PL_iPhoneX_AppSMSList;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppAddConversation",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appAddConversation";
}] call Server_Setup_Compile;

["A3PL_iPhoneX_GetContactName",
{
	_number = param[0,""];
	if(_number isEqualTo "") exitWith{};
	_contactName = _number;
	{
		if(_x select 1 isEqualTo _number) exitwith {_contactName = _x select 0;};
	} forEach A3PL_contacts;
	_contactName;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSMS",
{
	private["_index","_control","_nameContact","_phoneNumberContact","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_nameContactAppSMS"];
	disableSerialization;

	_index = _this select 0;
	_nameContact = _this select 1;
	_phoneNumberContact = _this select 2;

	createDialog "A3PL_iPhone_appSMS";
	_display = findDisplay 99100;

	if (isNil "A3PL_phoneNumberActive") then
	{
		ctrlEnable [97621,false];
		ctrlEnable [97622,false];
		ctrlEnable [97623,false];
	};

	_control = _display displayCtrl 97002;
	if !(isNil "A3PL_phoneNumberEnterprise") then
	{
		if (A3PL_phoneNumberEnterprise isEqualTo _phoneNumberContact) then
		{
			ctrlEnable [97621,false];
			ctrlShow [97621,false];
			ctrlEnable [97622,false];
			ctrlEnable [97623,false];
			_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSMSEnterprise.paa";
		};
	};

	if !(isNil "A3PL_phoneNumberEnterprise") then
	{
		if !(A3PL_phoneNumberEnterprise isEqualTo _phoneNumberContact) then
		{
			_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSMS.paa";
		};
	} else {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSMS.paa";
	};

	{ctrlDelete _x;} count (player getVariable ["iPhoneX_ConversationsMS", []]);

	player setVariable ["iPhoneX_CurrentConversation", []];

	_control = _display displayCtrl 97620;
	_control ctrlSetText _nameContact;

	if (isNil "A3PL_phoneNumberActive") exitWith {};
	if (A3PL_phoneNumberActive isEqualTo []) exitWith {};

	if !(isNil "A3PL_phoneNumberEnterprise") then {
		if (A3PL_phoneNumberEnterprise isEqualTo _phoneNumberContact) then {
			[player, _phoneNumberContact] remoteExec ["Server_iPhoneX_getSMSEnterprise",2];
		};
	};

	if !(isNil "A3PL_phoneNumberEnterprise") then
	{
		if !(A3PL_phoneNumberEnterprise isEqualTo _phoneNumberContact) then
		{
			[player, A3PL_phoneNumberActive, _phoneNumberContact] remoteExec ["Server_iPhoneX_GetSMS",2];
		};
	} else {
		[player, A3PL_phoneNumberActive, _phoneNumberContact] remoteExec ["Server_iPhoneX_GetSMS",2];
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSMSFromContact",
{
	private["_uid","_nameContact","_phoneNumberContact","_conversations","_exists"];
	disableSerialization;

	_uid = getPlayerUID player;
	_nameContact = _this select 0;
	_phoneNumberContact = _this select 1;
	_conversations = A3PL_conversations;
	_message = "No message";

	_exists = [_conversations, _phoneNumberContact] call BIS_fnc_findNestedElement;
	if (_exists isEqualTo []) then
	{
		_conversations pushBack [_nameContact, _phoneNumberContact];
		A3PL_conversations = [_conversations,[],{_x select 0},"ASCEND"] call BIS_fnc_sortBy;
		[_uid, _nameContact, _phoneNumberContact, _message] remoteExec ["Server_iPhoneX_SaveConversation",2];
		{ctrlDelete _x;} count (player getVariable ["iPhoneX_PhoneConversations", []]);
	};
	[_nameContact, _phoneNumberContact] spawn A3PL_iPhoneX_AppSMSNew;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSMSList",
{
	private["_display","_ctrlGrp","_ctrlList","_nameContact","_phoneNumberContact","_tmp","_ctrlList","_pos"];
	disableSerialization;

	createDialog "A3PL_iPhone_appSMSList";
	_display = findDisplay 98900;
	_ctrlGrp = (_display displayCtrl 97516);
	_ctrlList = [];

	if (isNil "A3PL_phoneNumberActive") then {
		ctrlEnable [97655,false];
	};

	{ctrlDelete _x;} count (player getVariable ["iPhoneX_PhoneConversations", []]);
	{ctrlDelete _x;} count (player getVariable ["iPhoneX_ConversationsMS", []]);

	player setVariable ["iPhoneX_CurrentConversation", []];
	if (!(A3PL_conversations isEqualTo [])) then {
		{
			_nameContact = _x select 0;
			_phoneNumberContact = _x select 1;
			_lastSMS = _x select 2;
			_tmp = _display ctrlCreate ["iPhone_X_conversations", -1, _ctrlGrp];
			_ctrlList pushBack _tmp;
			_pos = ctrlPosition _tmp;
			_pos set [1, (_pos select 1) + (_pos select 3) * _forEachIndex];
			(_tmp controlsGroupCtrl 98101) ctrlSetText _nameContact;
			(_tmp controlsGroupCtrl 98102) ctrlSetText _lastSMS;
			_tmp ctrlAddEventHandler ["MouseButtonDown",format ["closeDialog 0; [%1, '%2', '%3'] spawn A3PL_iPhoneX_AppSMS;", _forEachIndex, _nameContact, _phoneNumberContact]];
			_tmp ctrlSetPosition _pos;
			_tmp ctrlCommit 0;
		} forEach A3PL_conversations;
	};
	player setVariable ["iPhoneX_PhoneConversations", _ctrlList];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSMSNew",
{
	private["_nameContact","_phoneNumberContact","_display","_control"];
	disableSerialization;

	_nameContact = _this select 0;
	_phoneNumberContact = _this select 1;

	createDialog "A3PL_iPhone_appSMS";
	_display = findDisplay 99100;

	if (isNil "A3PL_phoneNumberActive") then {
		ctrlShow [97621,false];
		ctrlShow [97622,false];
		ctrlShow [97623,false];
	};

	_control = _display displayCtrl 97620;
	_control ctrlSetText _nameContact;
	if (A3PL_phoneNumberActive isEqualTo []) exitWith {};
	[player, A3PL_phoneNumberActive, _phoneNumberContact] remoteExec ["Server_iPhoneX_getSMS",2];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSwitchboard",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appSwitchBoard";
	private _display = findDisplay 98800;
	if (A3PL_phoneNumberActive isEqualTo []) exitWith {};
	if !(isNil "A3PL_phoneNumberActive") then {
		[player] remoteExec ["Server_iPhoneX_GetSwitchboard",2];
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppTwitter",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appTwitter";

	private _display = findDisplay 98100;
	private _ctrlGrp = (_display displayCtrl 98101);
	private _tweets = A3PL_TwitterChatPhone;
	if (!(_tweets isEqualTo [])) then {
		reverse _tweets;
		{
			private _name = _x select 0;
			private _tweet = _x select 1;
			private _nameColor = _x select 2;
			private _tmp = _display ctrlCreate ["iPhone_X_Tweet", -1, _ctrlGrp];
			private _pos = ctrlPosition _tmp;
			_pos set [1, (_pos select 1) + (_pos select 3) * _forEachIndex];
			(_tmp controlsGroupCtrl 98301) ctrlSetStructuredText parseText format ["<t color='%1'>%2</t>",_nameColor,_name];
			(_tmp controlsGroupCtrl 98302) ctrlSetStructuredText parseText format ["<t color='#1C1C1C'>%1</t>",_tweet];
			(_tmp controlsGroupCtrl 98302) ctrlSetPosition [(ctrlPosition (_tmp controlsGroupCtrl 98302)) select 0, (ctrlPosition (_tmp controlsGroupCtrl 98302)) select 1, (ctrlPosition (_tmp controlsGroupCtrl 98302)) select 2, ctrlTextHeight (_tmp controlsGroupCtrl 98302)];
			_tmp ctrlAddEventHandler ["MouseButtonDown",format ['["%1","light-blue"] call A3PL_Player_Notification;', _tweet]];
			_tmp ctrlSetPosition _pos;
			_tmp ctrlCommit 0;
		} forEach _tweets;
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppTwitterPost",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appTwitterPost";
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Contacts",
{
	private _contacts = [_this,0,[],[[]]] call BIS_fnc_param;
	if ((_contacts isEqualTo [[]]) || (isNil "_contacts")) then {_contacts = [];};
	A3PL_contacts = _contacts;
	if (isNil "A3PL_contacts") then {A3PL_contacts = []};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Conversations",
{
	private _conversations = [_this,0,[],[[]]] call BIS_fnc_param;
	if (_conversations isEqualTo [[]]) then {_conversations = [];};
	A3PL_conversations = _conversations;
	if (isNil "A3PL_conversations") then {A3PL_conversations = []};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_EditString",
{
	_message = "Salut :)";

	_toFind = ":)";
	_replaceBy = "lol";

	_numberCharToReplace = count _toFind;
	_numberFind = _message find _toFind;

	while {_numberFind != -1} do {
		_numberFind = _message find _toFind;
		if (_numberFind isEqualTo -1) exitWith {};
		_splitMessage = _message splitString "";
		_splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
		_splitMessage set [_numberFind, _replaceBy];
		_message = _splitMessage joinString "";
	};

	_message = "1491";
	_message = _message splitString "" joinString " ";

	_toFind = " ";
	_replaceBy = ",";

	_numberCharToReplace = count _toFind;
	_numberFind = _message find _toFind;

	while {_numberFind != -1} do {
		_numberFind = _message find _toFind;
		if (_numberFind isEqualTo -1) exitWith {};
		_splitMessage = _message splitString "";
		_splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
		_splitMessage set [_numberFind, _replaceBy];
		_message = _splitMessage joinString "";
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_NumberIsUsed",
{
	A3PL_iPhoneX_NumberIsUsed = (param[0, false]);
}] call Server_Setup_Compile;

["A3PL_iPhoneX_ListNumber",
{
	private ["_listNumberClient"];
	_listNumberClient = [_this,0,[],[[]]] call BIS_fnc_param;
	if (_listNumberClient isEqualTo [[]]) then {_listNumberClient = [];};
	A3PL_iPhoneX_ListNumberClient = _listNumberClient;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_NewSMS",
{
	private ["_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_fromNum","_toNum","_message","_type","_tmp","_textCtrl","_backgroundCtrl","_posGrp","_posTxt","_textHeight","_posBG","_tmpPos","_diff","_toFind","_replaceBy","_a"];
	disableSerialization;

	{ctrlDelete _x;} count (player getVariable ["iPhoneX_ConversationsMS", []]);

	_display = findDisplay 99100;
	_ctrlGrp = (_display displayCtrl 97511);
	_ctrlList = [];
	if (!(A3PL_SMS isEqualTo [])) then {
		{
			_fromNum = _x select 0;
			_toNum = _x select 1;
			_message = _x select 2;

			_a = 0;
			while {_a < 11} do {
				_toFind = [";)","<3",":)",":fuck",":hi",":o",":dac",":p",":@",":-(",":("];
	            _toFind = _toFind select _a;
	            _replaceBy = ["<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_cleinoeil.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_coeur.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_content.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_fuck.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_hi.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_o.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_ok.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_p.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pascontent.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pleure.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_triste.paa'/>"];
				_replaceBy = _replaceBy select _a;
				_numberCharToReplace = count _toFind;
				_numberFind = _message find _toFind;
				while {_numberFind != -1} do {
					_numberFind = _message find _toFind;
					if (_numberFind isEqualTo -1) exitWith {};
					_splitMessage = _message splitString "";
					_splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
					_splitMessage set [_numberFind, _replaceBy];
					_message = _splitMessage joinString "";
				};
				_a = _a + 1;
			};

			_size = 0.5 * safezoneH;
			_message = format["<t size='%1' color='#000000'>%2</t>",_size,_message];
			_type = ["iPhone_X_sendSMS", "iPhone_X_receiveSMS"] select ((_x select 1) == A3PL_phoneNumberActive);
			_tmp = _display ctrlCreate [_type, -1, _ctrlGrp];
			_backgroundCtrl = (_tmp controlsGroupCtrl 98111);
			_textCtrl = (_tmp controlsGroupCtrl 98112);
			_textCtrl ctrlSetStructuredText parseText _message;
			_posGrp = ctrlPosition _tmp;
			_posBG = ctrlPosition _backgroundCtrl;
			_posTxt = ctrlPosition _textCtrl;
			_textHeight = ctrlTextHeight _textCtrl;

			if (!(_ctrlList isEqualTo [])) then {
				_tmpPos = ctrlPosition (_ctrlList select ((count _ctrlList) - 1));
				_posGrp set [1, ((_tmpPos select 1) + (_tmpPos select 3) + 0.001)];
			} else {
				_posGrp set [1, (_posGrp select 1) + 0.005];
			};

			if (_textHeight > (_posBG select 3)) then {
				_diff = (_textHeight - (_posBG select 3));
				_posGrp set [3, ((_posGrp select 3) + _diff)];
				_posBG set [3, ((_posBG select 3) + _diff)];
				_posTxt set [3, ((_posTxt select 3) + (_diff))];
				_posTxt set [1, (((_posBG select 3) / 2) - ((_posTxt select 3) / 2))];
			};

			_tmp ctrlSetPosition _posGrp;
			_textCtrl ctrlSetPosition _posTxt;
			_backgroundCtrl ctrlSetPosition _posBG;
			_tmp ctrlCommit 0;
			_textCtrl ctrlCommit 0;
			_backgroundCtrl ctrlCommit 0;
			_ctrlList pushBack _tmp;
		} forEach A3PL_SMS;
	};

	player setVariable ["iPhoneX_ConversationsMS", _ctrlList];
	_ctrlGrp = (_display displayCtrl 97511);
	_ctrlGrp ctrlSetAutoScrollSpeed 0.000001;
	_ctrlGrp ctrlSetAutoScrollDelay 0.000001;
	uiSleep 0.2;
	_ctrlGrp ctrlSetAutoScrollSpeed -1;
	ctrlSetFocus _ctrlGrp;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SetJobNumber",
{
	private ["_job","_number"];
	_job = [_this,0,"unemployed",["unemployed"]] call BIS_fnc_param;
	// if (_job isEqualTo "") exitWith {diag_log "ERROR - PHONE NUMBER ENTERPRISE"};
	_number = "";
	switch(_job) do {
		case ("doj"): {_number = "912";};
		case ("usms"): {_number = "911";};
		case ("uscg"): {_number = "911";};
		case ("fisd"): {_number = "911";};
		case ("fifr"): {_number = "911";};
	};
	A3PL_phoneNumberEnterprise = _number;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_ReceiveSMS",
{
	private ["_uid","_from","_message","_SMS","_conversations","_nameContact","_exists","_phoneNumberContact","_date","_hour","_minute","_time","_display","_ctrlDisplay","_ctrlGrp"];
	disableSerialization;

	_uid = getPlayerUID player;
	_from = _this select 0;
	_message = _this select 1;
	_to = _this select 2;
	_position = _this select 3;
	_actualPos = _this select 4;
	_SMS = A3PL_SMS;
	_conversations = A3PL_conversations;

	if(isNil "A3PL_contacts") then {[player] remoteExec ["Server_iPhoneX_GetContacts",2];};

	_nameContact = [A3PL_contacts, _from] call BIS_fnc_findNestedElement;
	if (_nameContact isEqualTo []) then {_nameContact = _from} else {
		_nameContact = [A3PL_contacts, [(_nameContact select 0), 0]] call BIS_fnc_returnNestedElement;
	};

	if ((_to isEqualTo "911") OR (_to isEqualTo "912")) then
	{
		if (_to isEqualTo A3PL_phoneNumberEnterprise) then
		{
			if (!(_to isEqualTo "911") OR !(_to isEqualTo "912")) then {_position = "unknown"};
			_SMS pushBack [_from, _message, _position];
			[_actualPos,format["911 - %1",_from],"ColorRed","mil_warning",60] spawn A3PL_Lib_CreateMarker;

			{ctrlDelete _x;} count (player getVariable ["iPhoneX_ConversationsMS", []]);

			_hour = str (date select 3);
			_minute  = str (date select 4);
			_time = format["%1h%2", if(count _hour == 1) then {("0" + _hour)} else {_hour}, if(count _minute == 1) then {("0" + _minute)} else {_minute}];

			_nameContact = format ["%1", _nameContact];
			player setVariable ["iPhone_X_lastSMS",[_namecontact, _message, _time, _from]];

			_iPhone_Settings = profileNamespace getVariable ["A3PL_iPhoneX_Settings",[2,1,0]];
			if ((_iPhone_Settings select 2) isEqualTo 0) then {
				if ((_to isEqualTo "911") OR (_to isEqualTo "912")) then {
					playSound3D ["A3PL_Common\GUI\phone\sounds\emergency_sound.ogg", player, false, getPosASL player, 5, 1, 5];
					["New 911 Text Recieved","blue"] call A3PL_Player_Notification;
					[format["911 : %1",_message],"blue"] call A3PL_Player_Notification;
					player setVariable["iPhone_911_Text",true,false];
					uiSleep 60;
					player setVariable["iPhone_911_Text",nil,false];
				} else {
					playSound3D ["A3PL_Common\GUI\phone\sounds\notification_sound.ogg", player, false, getPosASL player, 5, 1, 5];
					["You have recieved a text on your company phone","blue"] call A3PL_Player_Notification;
				};
			};
		};
	} else {
		_exists = [_conversations, _from] call BIS_fnc_findNestedElement;
		if (_exists isEqualTo []) then {
			_conversations pushBack [_nameContact, _from, _message];
			A3PL_conversations = [_conversations,[],{_x select 0},"ASCEND"] call BIS_fnc_sortBy;
			[_uid, _nameContact, _from, _message] remoteExec ["Server_iPhoneX_SaveConversation",2];
			{
				ctrlDelete _x;
			} count (player getVariable ["iPhoneX_PhoneConversations", []]);
		} else {
			[player, _from, _message] remoteExec ["Server_iPhoneX_SaveLastSMS", 2];
		};
		if (_to isEqualTo A3PL_phoneNumberActive) then
		{
			_phoneNumberContact = player getVariable ["iPhoneX_CurrentConversation", ""];
			if (_from isEqualTo _phoneNumberContact) then
			{
				_SMS pushBack [_from, A3PL_phoneNumberActive, _message];
				{ctrlDelete _x;} count (player getVariable ["iPhoneX_ConversationsMS", []]);
				call A3PL_iPhoneX_newSMS;
			};

			_hour = str (date select 3);
			_minute  = str (date select 4);
			_time = format["%1h%2", if(count _hour == 1) then {("0" + _hour)} else {_hour}, if(count _minute == 1) then {("0" + _minute)} else {_minute}];

			_a = 0;
			while {_a < 11} do {
				_toFind = [";)","<3",":)",":fuck",":hi",":o",":dac",":p",":@",":-(",":("];
	            _toFind = _toFind select _a;
	            _replaceBy = ["<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_cleinoeil.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_coeur.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_content.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_fuck.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_hi.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_o.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_ok.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_p.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pascontent.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pleure.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_triste.paa'/>"];
				_replaceBy = _replaceBy select _a;
				_numberCharToReplace = count _toFind;
				_numberFind = _message find _toFind;
				while {_numberFind != -1} do {
					_numberFind = _message find _toFind;
					if (_numberFind isEqualTo -1) exitWith {};
					_splitMessage = _message splitString "";
					_splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
					_splitMessage set [_numberFind, _replaceBy];
					_message = _splitMessage joinString "";
				};
				_a = _a + 1;
			};
			player setVariable ["iPhone_X_lastSMS",[_namecontact, _message, _time, _from]];
			_iPhone_Settings = profileNamespace getVariable ["A3PL_iPhoneX_Settings",[2,1,0]];
			if ((_iPhone_Settings select 2) isEqualTo 0) then {
				playSound3D ["A3PL_Common\GUI\phone\sounds\notification_sound.ogg", player, false, getPosASL player, 5, 1, 5];
			};
			["You have received an SMS","yellow"] call A3PL_Player_Notification;
			playSound3D ["A3PL_Common\GUI\phone\sounds\notification_sound.ogg", player, false, getPosASL player, 5, 1, 5];
		};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SendSMS",
{
	private ["_message","_SMS","_phoneNumberContact","_display","_ctrlDisplay","_ctrlGrp"];
	disableSerialization;

	_message = _this select 0;
	if (_message isEqualTo "Message...") exitWith {["Message incorrect","red"] call A3PL_Player_Notification;};
	_message = _message splitString "'%" joinString " ";
	_message = _message splitString '"' joinString " ";

	_SMS = A3PL_SMS;
	_phoneNumberContact = player getVariable ["iPhoneX_CurrentConversation", ""];

	playSound3D ["A3PL_Common\GUI\phone\sounds\smssend.ogg", player, false, getPosASL player, 5, 1, 5];
	uiSleep random 0.2;

	_SMS pushBack [A3PL_phoneNumberActive, _phoneNumbercontact, _message];
	[player, A3PL_phoneNumberActive, _phoneNumberContact, _message] remoteExec ["Server_iPhoneX_SendSMS", 2];

	{ctrlDelete _x;} count (player getVariable ["iPhoneX_ConversationsMS", []]);
	call A3PL_iPhoneX_NewSMS;

	_display = findDisplay 99100;
	_ctrlGrp = (_display displayCtrl 97511);
	_ctrlGrp ctrlSetAutoScrollSpeed 0.000001;
	_ctrlGrp ctrlSetAutoScrollDelay 0.000001;
	uiSleep 0.2;
	_ctrlGrp ctrlSetAutoScrollSpeed -1;
	ctrlSetFocus _ctrlGrp;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SMS",
{
	private ["_phoneNumberContact","_result","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_fromNum","_toNum","_message","_type","_tmp","_textCtrl","_backgroundCtrl","_posGrp","_posTxt","_textHeight","_posBG","_tmpPos","_diff"];
	disableSerialization;
	_phoneNumberContact = [_this,0,"",[""]] call BIS_fnc_param;
	_result = [_this,1,[],[[]]] call BIS_fnc_param;
	reverse _result;

	if (_result isEqualTo [[]]) then {_result = [];};
	A3PL_SMS = _result;

	_display = findDisplay 99100;
	_ctrlGrp = (_display displayCtrl 97511);
	_ctrlList = [];

	if (!(A3PL_SMS isEqualTo [])) then {
		{
			_fromNum = _x select 0;
			_toNum = _x select 1;
			_message = _x select 2;

			_a = 0;
			while {_a < 11} do {
				_toFind = [";)","<3",":)",":fuck",":hi",":o",":dac",":p",":@",":-(",":("];
	            _toFind = _toFind select _a;
	            _replaceBy = ["<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_cleinoeil.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_coeur.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_content.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_fuck.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_hi.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_o.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_ok.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_p.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pascontent.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pleure.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_triste.paa'/>"];
				_replaceBy = _replaceBy select _a;
				_numberCharToReplace = count _toFind;
				_numberFind = _message find _toFind;
				while {_numberFind != -1} do {
					_numberFind = _message find _toFind;
					if (_numberFind isEqualTo -1) exitWith {};
					_splitMessage = _message splitString "";
					_splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
					_splitMessage set [_numberFind, _replaceBy];
					_message = _splitMessage joinString "";
				};
				_a = _a + 1;
			};

			_size = 0.5 * safezoneH;
			_message = format["<t size='%1' color='#000000'>%2</t>",_size,_message];
			_type = ["iPhone_X_sendSMS", "iPhone_X_receiveSMS"] select ((_x select 1) == A3PL_phoneNumberActive);
			if((_x select 1) == A3PL_phoneNumberActive) then {
				_type = "iPhone_X_receiveSMS";
			} else {
				_type = "iPhone_X_sendSMS";
			};
			_tmp = _display ctrlCreate [_type, -1, _ctrlGrp];
			_backgroundCtrl = (_tmp controlsGroupCtrl 98111);
			_textCtrl = (_tmp controlsGroupCtrl 98112);
			_textCtrl ctrlSetStructuredText parseText _message;
			_posGrp = ctrlPosition _tmp;
			_posBG = ctrlPosition _backgroundCtrl;
			_posTxt = ctrlPosition _textCtrl;
			_textHeight = ctrlTextHeight _textCtrl;

			if (!(_ctrlList isEqualTo [])) then {
				_tmpPos = ctrlPosition (_ctrlList select ((count _ctrlList) - 1));
				_posGrp set [1, ((_tmpPos select 1) + (_tmpPos select 3) + 0.001)];
			} else {
				_posGrp set [1, (_posGrp select 1) + 0.005];
			};

			if (_textHeight > (_posBG select 3)) then {
				_diff = (_textHeight - (_posBG select 3));
				_posGrp set [3, ((_posGrp select 3) + _diff)];
				_posBG set [3, ((_posBG select 3) + _diff)];
				_posTxt set [3, ((_posTxt select 3) + (_diff))];
				_posTxt set [1, (((_posBG select 3) / 2) - ((_posTxt select 3) / 2))];
			};
			_tmp ctrlSetPosition _posGrp;
			_textCtrl ctrlSetPosition _posTxt;
			_backgroundCtrl ctrlSetPosition _posBG;
			_tmp ctrlCommit 0;
			_textCtrl ctrlCommit 0;
			_backgroundCtrl ctrlCommit 0;
			_ctrlList pushBack _tmp;
		} forEach A3PL_SMS;
	};

	player setVariable ["iPhoneX_CurrentConversation", _phoneNumberContact];
	player setVariable ["iPhoneX_ConversationsMS", _ctrlList];

	_ctrlGrp ctrlSetAutoScrollSpeed 0.000001;
	_ctrlGrp ctrlSetAutoScrollDelay 0.000001;
	uiSleep 0.2;
	_ctrlGrp ctrlSetAutoScrollSpeed -1;
	ctrlSetFocus _ctrlGrp;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SMSEnterprise",
{
	private ["_phoneNumberContact","_result","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_fromNum","_toNum","_message","_type","_tmp","_textCtrl","_backgroundCtrl","_posGrp","_posTxt","_textHeight","_posBG","_tmpPos","_diff"];
	disableSerialization;
	_result = [_this,0,[],[[]]] call BIS_fnc_param;

	if (_result isEqualTo [[]]) then {_result = [];};
	A3PL_SMS = _result;

	_display = findDisplay 99100;
	_ctrlGrp = (_display displayCtrl 97511);
	_ctrlList = [];

	if (!(A3PL_SMS isEqualTo [])) then {
		{
			_fromNum = _x select 0;
			_message = _x select 1;
			_position = _x select 2;
			_a = 0;
       		while {_a < 11} do {
	            _toFind = [";)","<3",":)",":fuck",":hi",":o",":dac",":p",":@",":-(",":("];
	            _toFind = _toFind select _a;
	            _replaceBy = ["<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_cleinoeil.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_coeur.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_content.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_fuck.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_hi.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_o.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_ok.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_p.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pascontent.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pleure.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_triste.paa'/>"];
	            _replaceBy = _replaceBy select _a;
	            _numberCharToReplace = count _toFind;
	            _numberFind = _message find _toFind;
            	while {_numberFind != -1} do {
	           		_numberFind = _message find _toFind;
	            	if (_numberFind isEqualTo -1) exitWith {};
		            _splitMessage = _message splitString "";
		            _splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
		            _splitMessage set [_numberFind, _replaceBy];
		            _message = _splitMessage joinString "";
	            };
           		_a = _a + 1;
        	};
			_size = 0.5 * safezoneH;
			_message = format["<t size='%1' color='#000000'>%2</t><br></br><t color='#F10000'>From : %3</t><br></br><t color='#F10000'>Position : %4</t>",_size,_message, _fromNum, _position];
			_tmp = _display ctrlCreate ["iPhone_X_SMSEnterprise", -1, _ctrlGrp];
			_backgroundCtrl = (_tmp controlsGroupCtrl 98058);
			_textCtrl = (_tmp controlsGroupCtrl 98059);
			_tmp ctrlAddEventHandler ["MouseButtonDown",format ["[%1, '%2', '%3'] spawn A3PL_iPhoneX_AppSMS;", _forEachIndex, _fromNum, _fromNum]];
			_textCtrl ctrlSetStructuredText parseText _message;
			_posGrp = ctrlPosition _tmp;
			_posBG = ctrlPosition _backgroundCtrl;
			_posTxt = ctrlPosition _textCtrl;
			_textHeight = ctrlTextHeight _textCtrl;

			if (!(_ctrlList isEqualTo [])) then {
				_tmpPos = ctrlPosition (_ctrlList select ((count _ctrlList) - 1));
				_posGrp set [1, ((_tmpPos select 1) + (_tmpPos select 3) + 0.001)];
			} else {
				_posGrp set [1, (_posGrp select 1) + 0.005];
			};

			if (_textHeight > (_posBG select 3)) then {
				_diff = (_textHeight - (_posBG select 3));
				_posGrp set [3, ((_posGrp select 3) + _diff)];
				_posBG set [3, ((_posBG select 3) + _diff)];
				_posTxt set [3, ((_posTxt select 3) + (_diff))];
				_posTxt set [1, (((_posBG select 3) / 2) - ((_posTxt select 3) / 2))];
			};

			_tmp ctrlSetPosition _posGrp;
			_textCtrl ctrlSetPosition _posTxt;
			_backgroundCtrl ctrlSetPosition _posBG;
			_tmp ctrlCommit 0;
			_textCtrl ctrlCommit 0;
			_backgroundCtrl ctrlCommit 0;
			_ctrlList pushBack _tmp;
		} forEach A3PL_SMS;
	};

	player setVariable ["iPhoneX_CurrentConversation", A3PL_phoneNumberEnterprise];
	player setVariable ["iPhoneX_ConversationsMS", _ctrlList];

	_ctrlGrp ctrlSetAutoScrollSpeed 0.000001;
	_ctrlGrp ctrlSetAutoScrollDelay 0.000001;
	uiSleep 0.2;
	_ctrlGrp ctrlSetAutoScrollSpeed -1;
	ctrlSetFocus _ctrlGrp;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Switchboard",
{
	private ["_result","_from","_fromNum","_tmp","_pos","_ctrlGrp","_display","_ctrlList"];
	disableSerialization;
	_result = [_this,0,[],[[]]] call BIS_fnc_param;

	if (_result isEqualTo [[]]) then {_result = [];};
	A3PL_switchboard = _result;

	_display = findDisplay 98800;
	_ctrlGrp = (_display displayCtrl 98261);
	_ctrlList = [];

	{ctrlDelete _x;} count (player getVariable ["A3PL_iPhoneX_SwitchboardClient", []]);

	if (!(A3PL_switchboard isEqualTo [])) then {
		{
			_from = _x select 0;
			_fromNum = _x select 1;
			_tmp = _display ctrlCreate ["iPhone_X_switchboard", -1, _ctrlGrp];
			_ctrlList pushBack _tmp;
			_pos = ctrlPosition _tmp;
			_pos set [1, (_pos select 1) + (_pos select 3) * _forEachIndex];
			(_tmp controlsGroupCtrl 98056) ctrlSetText _fromNum;
			_tmp ctrlAddEventHandler ["MouseButtonDown",format ["[%1, '%2', '%3', '%4'] spawn A3PL_iPhoneX_receiveCallSwitchboard;", _forEachIndex, _from, _fromNum, A3PL_phoneNumberActive]];
			_tmp ctrlSetPosition _pos;
			_tmp ctrlCommit 0;
		} forEach A3PL_switchboard;
	};
	player setVariable ["A3PL_iPhoneX_SwitchboardClient", _ctrlList];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SwitchboardSend",
{
	private _result = [_this,0,[],[[]]] call BIS_fnc_param;
	if (_result isEqualTo [[]]) then {_result = [];};
	A3PL_switchboard = _result;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Locked",
{
	private["_display","_control"];
	disableSerialization;

	if(!isNull (findDisplay 97000)) exitWith {};
	if (A3PL_phoneCallOn) exitWith {[] spawn A3PL_iPhoneX_AppCall;};

	if(player getVariable["iPhone_911_Text",false]) exitWith {[1, 'Emergency services', '911'] spawn A3PL_iPhoneX_AppSMS;};
	if(player getVariable["iPhone_911_Call",false]) exitWith {[] spawn A3PL_iPhoneX_AppSwitchboard;};

	createDialog "A3PL_iPhone_Locked";
	_display = findDisplay 97000;

	_control = _display displayCtrl 97002;
	_wallpaperActive = "A3PL_Common\GUI\phone\iPhone_X_background_%1.paa";
	_iPhone_Settings = profileNamespace getVariable ["A3PL_iPhoneX_Settings",[2,1,0]];
	_control ctrlSetText format[_wallpaperActive, (_iPhone_Settings select 0)];

	_control = _display displayCtrl 97800;
	if !(isNil "A3PL_phoneNumberActive") then {_control ctrlSetText A3PL_phoneNumberActive;};

	private _control = _display displayCtrl 1000;
	private _FIFR = count(["fifr"] call A3PL_Lib_FactionPlayers);
	private _FISD = count(["fisd"] call A3PL_Lib_FactionPlayers);
	private _CG = count(["uscg"] call A3PL_Lib_FactionPlayers);
	private _FIMS = count(["usms"] call A3PL_Lib_FactionPlayers);
	_control ctrlSetStructuredText parseText format ["<t align='center'>
		<img image='\A3PL_Common\icons\fire.paa'/><t color='#ffffff'> %1 </t>
		<t color='#ffffff'> %2 </t><img image='\A3PL_Common\icons\faction_sheriff.paa'/><br/>
		<img image='\A3PL_Common\icons\faction_cg.paa'/><t color='#ffffff'> %3 </t>
		<t color='#ffffff'> %4 </t><img image='\A3PL_Common\icons\usms.paa'/></t>",_FIFR,_FISD,_CG,_FIMS];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Home",
{
	private["_display","_control","_wallpaperActive"];
	disableSerialization;

	createDialog "A3PL_iPhone_Home";
	waitUntil{!isNull (findDisplay 97100)};
	_display = findDisplay 97100;

	_control = _display displayCtrl 97002;
	_wallpaperActive = "A3PL_Common\GUI\phone\iPhone_X_background_%1.paa";
	_iPhone_Settings = profileNamespace getVariable ["A3PL_iPhoneX_Settings",[2,1,0]];
	_control ctrlSetText format[_wallpaperActive, (_iPhone_Settings select 0)];

	if ((player getVariable ["job","unemployed"]) IN ["uscg","fifr","fisd","usms","doj"]) then {
		ctrlShow [97101,true];
		ctrlShow [97102,true];
	};
	if (((player getVariable ["job","unemployed"]) IN ["uscg","fifr","fisd","usms"]) || (["vfd",player] call A3PL_DMV_Check)) then {
		ctrlShow [97103,true];
		ctrlShow [97104,true];
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appPhone",
{
	disableSerialization;
	createDialog "A3PL_iPhone_Phone";
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appContactsList",
{
	private["_display","_ctrlGrp","_ctrlList"];
	disableSerialization;
	createDialog "A3PL_iPhone_ContactsList";

	_display = findDisplay 97400;
	_ctrlGrp = (_display displayCtrl 97514);
	_ctrlList = [];
	{ctrlDelete _x;} count (player getVariable ["iPhoneX_PhoneContacts", []]);

	if (!(A3PL_contacts isEqualTo [])) then {
		{
			private["_nameContact","_phoneNumberContact","_noteContact","_pos","_tmp"];
			_nameContact = _x select 0;
			_phoneNumberContact = _x select 1;
			_noteContact = _x select 2;
			_tmp = _display ctrlCreate ["iPhone_X_contacts", -1, _ctrlGrp];
			_ctrlList pushBack _tmp;
			_pos = ctrlPosition _tmp;
			_pos set [1, (_pos select 1) + (_pos select 3) * _forEachIndex];
			(_tmp controlsGroupCtrl 98002) ctrlSetText _nameContact;
			(_tmp controlsGroupCtrl 98003) ctrlSetText _phoneNumberContact;
			_tmp ctrlAddEventHandler ["MouseButtonDown",format ["closeDialog 0; [%1, '%2', '%3', '%4'] spawn A3PL_iPhoneX_AppContact;", _forEachIndex, _nameContact, _phoneNumberContact, _noteContact]];
			_tmp ctrlSetPosition _pos;
			_tmp ctrlCommit 0;
		} forEach A3PL_contacts;
	};
	player setVariable ["iPhoneX_PhoneContacts", _ctrlList];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppContact",
{
	private["_display","_control"];
	disableSerialization;
	_index = param [0,-1];
	_nameContact = param [1,""];
	_numberContact = param [2,""];
	_noteContact = param [3,""];

	createDialog "A3PL_iPhone_appContact";

	_display = findDisplay 97500;
	if (isNil "A3PL_phoneNumberActive") then {ctrlEnable [97657,false];};

	_control = _display displayCtrl 97609;
	_control ctrlSetText _nameContact;

	_control = _display displayCtrl 97610;
	_control ctrlSetText _numberContact;

	_control = _display displayCtrl 97659;
	_control ctrlSetText _noteContact;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppAddContact",
{
	private["_display"];
	disableSerialization;
	createDialog "A3PL_iPhone_appAddContact";
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppUber",
{
	private["_display"];
	disableSerialization;
	createDialog "A3PL_iPhone_appUber";
	_display = findDisplay 97700;

	_button1 = _display displayCtrl 10719;
	_button2 = _display displayCtrl 10720;
	_button3 = _display displayCtrl 10721;

	_text1 = _display displayCtrl 10616;
	_text2 = _display displayCtrl 10617;
	_text3 = _display displayCtrl 10618;

	if (player getVariable ["job","unemployed"] == "uber") then {
        if (A3PL_Uber_JobActive) then {
            _text3 ctrlSetText "End current drive";
            _button3 buttonSetAction "call A3PL_Uber_EndJob;";
        };
    };
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppCalculator",
{
	private["_display"];
	disableSerialization;
	createDialog "A3PL_iPhone_appCalculator";
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppTax",
{
	private["_display","_ctrlGrp"];
	disableSerialization;
	createDialog "A3PL_iPhone_appTax";
	_display = findDisplay 97900;
	_ctrlGrp = (_display displayCtrl 97901);

	_taxesArray = [
		["Cartel Tax",["Cartel Tax"] call A3PL_Config_GetTaxes]
	];

	{
		private _displayText = _x select 0;
		private _displayValue = _x select 1;
		private _tmp = _display ctrlCreate ["iPhone_X_switchboard", -1, _ctrlGrp];
		private _pos = ctrlPosition _tmp;
		_pos set [1, (_pos select 1) + (_pos select 3) * _forEachIndex];
		(_tmp controlsGroupCtrl 98056) ctrlSetText format["%1 : %2%3",_displayText, _displayValue, "%"];
		_tmp ctrlSetPosition _pos;
		_tmp ctrlCommit 0;
	} forEach _taxesArray;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appBank",
{
	private["_display","_pBank"];
	disableSerialization;
	createDialog "A3PL_iPhone_appBank";
	_display = findDisplay 99400;
	_pBank = player getVariable["Player_Bank",0];
	_control = _display displayCtrl 99400;
	_control ctrlSetStructuredText parseText format ["<t align='center' size='1.3'>$%1</t>",[_pBank, 1, 0, true] call CBA_fnc_formatNumber];
	_control = _display displayCtrl 99402;
	{
		_index = _control lbAdd format["%1", _x getVariable ["name","unknown"]];
		_control lbSetData [_index, str _x];
	} forEach (playableUnits - [player]);
}] call Server_Setup_Compile;

["A3PL_iPhoneX_bankSend",
{
	private["_display","_pBank"];
	disableSerialization;
	_display = findDisplay 99400;
	_pBank = player getVariable["Player_Bank",0];
	_cooldown = player getVariable["transferCooldown",nil];
	if(!isNil '_cooldown') exitWith {["You can only transfer money every 10 minutes!", "red"] call A3PL_Player_Notification;};

	_control = _display displayCtrl 99401;
	_amount = round(parseNumber(ctrlText _control));
	if(_amount < 1) then {["Please enter a valid number", "red"] call A3PL_Player_Notification;};
	if(_amount > _pBank) exitWith {[localize"STR_Various_INVALIDAMOUNT", "red"] call A3PL_Player_Notification;};
	if(_amount > 100000) exitWith {["You cannot send more than $100.000 per transfer", "red"] call A3PL_Player_Notification;};
	_control = _display displayCtrl 99402;
	_sendTo = _control lbData (lbCurSel _control);

	if(_sendTo isEqualTo "") exitWith {["Please select a recipient.", "red"] call A3PL_Player_Notification;};
	_sendToCompile = call compile _sendTo;

	[getPlayerUID player,"bankAppTransfer",[str(_sendToCompile getVariable["name","unknown"]), str(_amount)]] remoteExec ["Server_Log_New",2];

	[player, 'Player_Bank', ((player getVariable 'Player_Bank') - _amount)] remoteExec ["Server_Core_ChangeVar",2];
	[format[localize"STR_ATM_YOUTRANSFERAMOUNTTOPLAYER", [_amount] call A3PL_Lib_FormatNumber, (_sendToCompile getVariable ["name","unknown"])], "green"] call A3PL_Player_Notification;
	[_sendToCompile, 'Player_Bank', ((_sendToCompile getVariable 'Player_Bank') + _amount)] remoteExec ["Server_Core_ChangeVar",2];
	[format[localize"STR_ATM_YOURECEIVETRANSFER",_amount], "green"] remoteExec ["A3PL_Player_Notification",_sendToCompile];

	player setVariable["transferCooldown",true,false];
	[] spawn {
		sleep 600;
		player setVariable["transferCooldown",nil,false];
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appGang",
{
	disableSerialization;
	_group = group player;
	_gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') then {
		call A3PL_iPhoneX_appGangCreation;
	} else {
		call A3PL_iPhoneX_appGangManagement;
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appGangBank",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appGangBank";
	private _group = group player;
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	private _display = findDisplay 102100;
	private _gBank = _gang select 4;
	private _control = _display displayCtrl 99400;
	_control ctrlSetStructuredText parseText format ["<t align='center' size='1.3'>$%1</t>",[_gBank, 1, 0, true] call CBA_fnc_formatNumber];
	_control = _display displayCtrl 99402;
	{
		_index = _control lbAdd format["%1", _x getVariable ["name","unknown"]];
		_control lbSetData [_index, str _x];
	} forEach playableUnits;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_gangBankSend",
{
	disableSerialization;
	private _display = findDisplay 102100;
	private _group = group player;
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	private _gBank = _gang select 4;
	private _cooldown = player getVariable["transferCooldown",nil];
	if(!isNil '_cooldown') exitWith {["You can only transfer money every 10 minutes!", "red"] call A3PL_Player_Notification;};

	_control = _display displayCtrl 99401;
	_amount = round(parseNumber(ctrlText _control));
	if(_amount < 1) then {["Please enter a valid number", "red"] call A3PL_Player_Notification;};
	if(_amount > _gBank) exitWith {[localize"STR_Various_INVALIDAMOUNT", "red"] call A3PL_Player_Notification;};
	if(_amount > 100000) exitWith {["You cannot send more than $100.000 per transfer", "red"] call A3PL_Player_Notification;};

	_control = _display displayCtrl 99402;
	_sendTo = _control lbData (lbCurSel _control);
	if(_sendTo isEqualTo "") exitWith {["Please select a recipient.", "red"] call A3PL_Player_Notification;};
	_sendToCompile = call compile _sendTo;

	[getPlayerUID player,"gangBankAppTransfer",[str(_sendToCompile getVariable["name","unknown"]), str(_amount)]] remoteExec ["Server_Log_New",2];

	[_group, -_amount] call A3PL_Gang_AddBank;
	[format[localize"STR_GANG_TRANSFERED", [_amount] call A3PL_Lib_FormatNumber, (_sendToCompile getVariable ["name","unknown"])], "green"] call A3PL_Player_Notification;

	[_sendToCompile, 'Player_Bank', ((_sendToCompile getVariable 'Player_Bank') + _amount)] remoteExec ["Server_Core_ChangeVar",2];
	[format[localize"STR_ATM_YOURECEIVETRANSFER",_amount], "green"] remoteExec ["A3PL_Player_Notification",_sendToCompile];

	player setVariable["transferCooldown",true,false];
	[] spawn {
		sleep 600;
		player setVariable["transferCooldown",nil,false];
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appGangManagement",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appGangManagement";
	private _display = findDisplay 99300;
	private _group = group player;
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};

	_control = _display displayCtrl 2100;
	{
		_index = _control lbAdd format["%1", _x getVariable ["name","unknown"]];
		_control lbSetData [_index, getPlayerUID _x];
	} forEach (playableUnits - [player]);

	_control = _display displayCtrl 1500;
	{
		if((getPlayerUID _x) IN (_gang select 3)) then {
			_index = _control lbAdd format["%1", _x getVariable ["name","unknown"]];
			_control lbSetData [_index, getPlayerUID _x];
		};
	} forEach AllPlayers;

	_control = _display displayCtrl 1101;
	_control ctrlSetStructuredText parseText format ["<t align='center' size='1.3'>$%1</t>",[(_gang select 4), 1, 0, true] call CBA_fnc_formatNumber];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_GangSetLead",
{
	disableSerialization;
	private _display = findDisplay 99300;
	private _control = _display displayCtrl 1500;
	private _uid = _control lbData (lbCurSel _control);
	if (_uid isEqualTo "") exitWith {["Please select a target.","red"] call A3PL_Player_Notification;};
	[_uid] call A3PL_Gang_SetLead;
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_GangInvite",
{
	disableSerialization;
	private _display = findDisplay 99300;
	private _control = _display displayCtrl 2100;
	private _uid = (_control lbData (lbCurSel _control));
	if(_uid isEqualTo "") exitWith {["Please select a target.","red"] call A3PL_Player_Notification;};
	diag_log format["A3PL_iPhoneX_GangInvite| _uid : %1",_uid];
	[_uid] call A3PL_Gang_Invite;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_GangKick",
{
	disableSerialization;
	private _display = findDisplay 99300;
	private _control = _display displayCtrl 1500;
	private _target = _control lbData (lbCurSel _control);
	if (_target isEqualTo "") exitWith {["Please select a target.","red"] call A3PL_Player_Notification;};

	private _group = group player;
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	if((_target isEqualTo (_gang select 1)) || _target isEqualTo (getPlayerUID player)) exitWith {[format ["You cannot fire yourself"],"red"] call A3PL_Player_Notification;};

	[_target, true] call A3PL_Gang_RemoveMember;
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appGangCreation",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appGangCreation";
}] call Server_Setup_Compile;

["A3PL_iPhoneX_CreateGang",
{
	disableSerialization;
	private _gangPrice = 100000;
	private _pBank = player getVariable["Player_Bank",0];
	if(_pBank < _gangPrice) exitWith {[format["You are missing $%1 in your bank account to create a gang",_gangPrice - _pBank],"red"] call A3PL_Player_Notification;};

	private _gangName = ctrlText 99201;
	if((_gangName isEqualTo "") || {(count _gangName > 15)}) exitWith {[format["Invalid name",_gangPrice - _pBank],"red"] call A3PL_Player_Notification;};
	player setVariable["Player_Bank",_pBank-_gangPrice,true];
	[_gangName] call A3PL_Gang_Create;
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appKeys",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appKeys";
	private _display = findDisplay 99500;
	private _control = _display displayCtrl 99500;
	if(count(A3PL_Player_Vehicles) > 0) then {
		{
			_control lbAdd format ["%1",getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
			_control lbSetData [(lbSize _control)-1,str(_forEachIndex)];
		} forEach A3PL_Player_Vehicles;
	} else {
		_control lbAdd "No keys";
		_control lbSetData [(lbSize _control)-1,""];
	};
	private _control = _display displayCtrl 99402;
	{
		if (player distance _x < 5) then {
			_index = _control lbAdd format["%1", _x getVariable["db_id","0"]];
			_control lbSetData [_index, str _x];
		};
	} forEach (playableUnits - [player]);
}] call Server_Setup_Compile;

["A3PL_iPhoneX_giveKeys",
{
	disableSerialization;
	private _display = findDisplay 99500;
	private _control = _display displayCtrl 99500;
	if ((_control lbData (lbCurSel _control)) isEqualTo "") exitWith {["Please select a key.","red"] call A3PL_Player_Notification;};
	private _key = _control lbData (lbCurSel _control);
	private _key = A3PL_Player_Vehicles select parseNumber(_key);
	private _control = _display displayCtrl 99402;
	if ((_control lbData (lbCurSel _control)) isEqualTo "") exitWith {["Please select a target.","red"] call A3PL_Player_Notification;};
	private _target = _control lbData (lbCurSel _control);
	private _target = call compile _target;

	[_key] remoteExec ["A3PL_Vehicle_AddKey",_target];
	[format["You gave the key of your %1.",getText(configFile >> "CfgVehicles" >> (typeOf _key) >> "displayName")],"green"] call A3PL_Player_Notification;
	[format["You received the key of a %1.",getText(configFile >> "CfgVehicles" >> (typeOf _key) >> "displayName")],"green"] remoteExec ["A3PL_Player_Notification",_target];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appNews",
{
	disableSerialization;
	if !(([getPlayerUID player] call A3PL_Config_IsCompanyBoss) || ([(player getVariable["faction","citizen"])] call A3PL_Government_isFactionLeader)) exitWith {
		["This app is only available for company or faction leaders","red"] call A3PL_Player_Notification;
	};
	createDialog "A3PL_iPhone_appNews";
	["You must pay $50,000 in order to perform this action.","yellow"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SendNews",
{
	disableSerialization;
	private _display = findDisplay 99600;
	private _control = _display displayCtrl 1400;
	private _title = ctrlText _control;
	private _control = _display displayCtrl 1401;
	private _message = ctrlText _control;

	if(_title isEqualTo "") exitWith {["Please enter a title","red"] call A3PL_Player_Notification;};
	if(_message isEqualTo "") exitWith {["Please enter a message","red"] call A3PL_Player_Notification;};

	private _pBank = player getVariable["Player_Bank",0];
	private _newsPrice = 50000;
	if(_pBank < _newsPrice) exitWith {[format["You are missing $%1 in your bank account to pay the ad",_newsPrice-_pBank],"red"] call A3PL_Player_Notification;};

	player setVariable["Player_Bank",_pBank-_newsPrice,true];
	private _sender = player getVariable["name","unknown"];
	[_title,_message, _sender] remoteExec ["A3PL_Player_News",-2];
	closeDialog 0;
	[getPlayerUID player,"News",[_message]] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appRadios",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appRadios";
	private _display = findDisplay 99700;
	private _control = _display displayCtrl 99701;
	private _radios = [
		["all","DMV",30],
		["all","FIFR",40],
		["all","FIMS",50],
		["all","FISD",60],
		["all","USCG",70],
		["all","DOJ",80]
	];
	{
		private _radioName = _x select 1;
		private _radioFreq = _x select 2;
		private _tmp = _display ctrlCreate ["iPhone_Details_Radios", -1, _control];
		private _pos = ctrlPosition _tmp;
		_pos set [1, (_pos select 1) + (_pos select 3) * _forEachIndex];
		(_tmp controlsGroupCtrl 98002) ctrlSetText _radioName;
		(_tmp controlsGroupCtrl 98003) ctrlSetText format["%1 MHz",_radioFreq];
		_tmp ctrlAddEventHandler ["MouseButtonDown",format ['["%1", %2] call A3PL_iPhoneX_SwitchFreq;', _radioName, _radioFreq]];
		_tmp ctrlSetPosition _pos;
		_tmp ctrlCommit 0;
	} forEach _radios;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SwitchFreq",
{
	private _name = [_this,0,"",[""]] call BIS_fnc_param;
	private _freq = [_this,1,-1,[-1]] call BIS_fnc_param;
	if(_freq < 0) exitWith {["Invalid frequency","red"] call A3PL_Player_Notification;};
	private _radio = (call TFAR_fnc_activeLrRadio);
	[_radio, str(_freq)] call TFAR_fnc_setLrFrequency;
	[format["You switched frequency to %2 (%1).",_name, _freq],"blue"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appFactory",
{
	createDialog "A3PL_iPhone_appFactory";
	private _display = findDisplay 99800;
	private _control = _display displayCtrl 99801;
	private _whitelist = ["Chemical Plant","Steel Mill","Oil Refinery","Goods Factory","Food Processing Plant","Vehicles Faction","Faction Weapons","Legal Weapon Factory","Marine Factory","Aircraft Factory","Car Parts Factory","Vehicle Factory","Clothing Factory","Vest Factory","Headgear Factory","Goggle Factory"];
	{
		private["_time","_tmp","_pos","_tmp","_name"];
		_time = [_x] call A3PL_Factory_GetRemaining;
		_name = [_x] call A3PL_Factory_GetRemainingName;
		if(_time != "Available") then {_time = [_time] call A3PL_Factory_AdjustRemaining;};
		_tmp = _display ctrlCreate ["iPhone_Details_Factory", -1, _control];
		_pos = ctrlPosition _tmp;
		_pos set [1, (_pos select 1) + (_pos select 3) * _forEachIndex];
		(_tmp controlsGroupCtrl 98002) ctrlSetText _x;
		(_tmp controlsGroupCtrl 98003) ctrlSetText format["%1",_time];
		_tmp ctrlSetPosition _pos;
		_tmp ctrlCommit 0;
		if(_time != "Available") then {_tmp ctrlAddEventHandler ["MouseButtonDown",format ['["The manufacture of your %3 %1 will be completed in %2","orange"] call A3PL_Player_Notification;',_name,_time,"x"]];};
	} forEach _whitelist;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appLevel",
{
	disableSerialization;
	private _currentLevel = player getvariable ['Player_Level',0];
	private _currentXP = player getVariable ['Player_XP',0];
	private _nextLevel = (_currentLevel + 1);
	private _nextLevelXP = [_currentLevel] call A3PL_Config_GetLevel;
	private _barEnd = (_currentXP / _nextLevelXP);

	createDialog "A3PL_iPhone_appLevel";
	private _display = findDisplay 99900;

	private _format = format["<t align='center' color='#F6F6F6'>Actual Level : %1</t>", _currentLevel];
	private _control = _display displayCtrl 99901;
	_control ctrlSetStructuredText (parseText _format);

	private _format = format["<t align='center' color='#F6F6F6'>Next Level : %1</t>", _nextLevel];
	private _control = _display displayCtrl 99902;
	_control ctrlSetStructuredText (parseText _format);

	private _format = format["<t align='center' color='#F6F6F6'>XP : %1 / %2</t>", _currentXP, _nextLevelXP];
	private _control = _display displayCtrl 99903;
	_control ctrlSetStructuredText (parseText _format);

	private _control = _display displayCtrl 99904;
	_control progressSetPosition _barEnd;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appBills",
{
	private _bills = param[0,[]];
	disableSerialization;
	createDialog "A3PL_iPhone_appBills";
	private _display = findDisplay 100000;
	private _control = _display displayCtrl 100001;
	{
		private["_billID","_companyName","_amount","_desc"];
		_billID = _x select 0;
		_companyName = _x select 1;
		_amount = _x select 2;
		_desc = _x select 3;
		_index = _control lbAdd format["%1", _companyName, _amount];
		_control lbSetData [_index, _desc];
		_control lbSetValue [_index, _billID];
	} forEach _bills;
	_control ctrlAddEventHandler ["LBSelChanged",
	{
		private ["_control","_display","_desc"];
		_display = findDisplay 100000;
		_control = param [0,ctrlNull];
		_desc = _control lbData (lbCurSel _control);
		_control = _display displayCtrl 100002;
		_control ctrlSetText _desc;
	}];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appCreateBill",
{
	disableSerialization;
	private _isCorporate = [getPlayerUID player] call A3PL_Config_InCompany;
	if(!_isCorporate) exitWith {[localize"STR_COMPANY_YOUDONTHAVECOMPANY","red"] call A3PL_Player_Notification;};
	createDialog "A3PL_iPhone_appCreateBill";
	private _display = findDisplay 101000;
	private _control = _display displayCtrl 101001;
	{
		_index = _control lbAdd format["%1", _x getVariable ["name","unknown"]];
		_control lbSetData [_index, str(_x)];
	} forEach AllPlayers - [player];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_sendBill",
{
	disableSerialization;
	private _display = findDisplay 101000;
	private _control = _display displayCtrl 101001;
	private _target = _control lbData (lbCurSel _control);
	if(_target isEqualTo "") exitWith {["Please select a target.", "red"] call A3PL_Player_Notification;};
	private _target = call compile _target;

	private _control = _display displayCtrl 101002;
	private _amount = parseNumber (ctrlText _control);
	if(_amount < 1) exitWith {["Invalid amount.", "red"] call A3PL_Player_Notification;};

	private _control = _display displayCtrl 101003;
	private _description = ctrlText _control;
	if(_description isEqualTo "") exitWith {["Please enter a description.", "red"] call A3PL_Player_Notification;};
	[_target, _amount, _description] call A3PL_Company_SendBill;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appCBillsLaunch",
{
	private _isCorporate = [getPlayerUID player] call A3PL_Config_InCompany;
	if(!_isCorporate) exitWith {[localize"STR_COMPANY_YOUDONTHAVECOMPANY","red"] call A3PL_Player_Notification;};
	closeDialog 0;
	[player] remoteExec ["Server_Company_LoadCBillPhone",2];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_appCompaniesBills",
{
	private _bills = param[0,[]];
	disableSerialization;
	createDialog "A3PL_iPhone_appCompaniesBills";
	private _display = findDisplay 102000;
	private _control = _display displayCtrl 102001;
	{
		private _billID = _x select 0;
		private _amount = _x select 1;
		private _desc = _x select 2;
		private _targetName = _x select 3;
		private _index = _control lbAdd format["%1 - $%2", _targetName, [_amount, 1, 0, true] call CBA_fnc_formatNumber];
		_control lbSetData [_index, _desc];
		_control lbSetValue [_index, _billID];
	} forEach _bills;
	_control ctrlAddEventHandler ["LBSelChanged",
	{
		private _display = findDisplay 102000;
		private _control = param [0,ctrlNull];
		private _desc = _control lbData (lbCurSel _control);
		private _control = _display displayCtrl 102002;
		_control ctrlSetText _desc;
	}];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSound",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appSounds";

	private _display = findDisplay 98700;
	private _iPhone_X_sound_1 = _display displayCtrl 97714;
	private _iPhone_X_sound_2 = _display displayCtrl 97715;
	private _iPhone_X_sound_3 = _display displayCtrl 97716;
	private _iPhone_Settings = profileNamespace getVariable ["A3PL_iPhoneX_Settings",[2,1,0]];
	private _soundActive = _iPhone_Settings select 1;
	if (_soundActive == 1) then {_iPhone_X_sound_1 ctrlSetTextColor [0.027,0.576,0.047,1];} else {_iPhone_X_sound_1 ctrlSetTextColor [0,0,0,1];};
	if (_soundActive == 2) then {_iPhone_X_sound_2 ctrlSetTextColor [0.027,0.576,0.047,1];} else {_iPhone_X_sound_2 ctrlSetTextColor [0,0,0,1];};
	if (_soundActive == 3) then {_iPhone_X_sound_3 ctrlSetTextColor [0.027,0.576,0.047,1];} else {_iPhone_X_sound_3 ctrlSetTextColor [0,0,0,1];};

	private _control = _display displayCtrl 97717;
	if ((_iPhone_Settings select 2) isEqualTo 0) then {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	} else {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppGeneral",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appGeneral";
	private _display = findDisplay 98600;
	private _control = _display displayCtrl 99719;
	if (profilenamespace getVariable ["A3PL_HUD_Enabled",true]) then {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};
	_control = _display displayCtrl 99718;
	if (profilenamespace getVariable ["A3PL_Twitter_Enabled",true]) then {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};
	_control = _display displayCtrl 99721;
	if (profilenamespace getVariable ["Player_EnableID",true]) then {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};
	_control = _display displayCtrl 99722;
	if (profilenamespace getVariable ["A3PL_Notifications_Enabled",true]) then {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};
	_control = _display displayCtrl 99723;
	if (profilenamespace getVariable ["A3PL_HELP_Enabled",false]) then {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};
	_control = _display displayCtrl 99724;
	if (profilenamespace getVariable ["A3PL_MarkerHelp_Enabled",true]) then {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};
	_control = _display displayCtrl 99725;
	if (profilenamespace getVariable ["A3PL_ShowGrass",true]) then {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};
	_control = _display displayCtrl 99726;
	if (profilenamespace getVariable ["A3PL_ShowGPS",true]) then {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppWallpaper",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appWallpaper";
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSettings",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appSettings";
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSIM",
{
	disableSerialization;
	createDialog "A3PL_iPhone_appSIM";
	private _display = findDisplay 98400;

	ctrlShow [97719,false];
	ctrlShow [97720,false];
	ctrlShow [97721,false];

	private _iPhone_X_SIM_1 = _display displayCtrl 97616;
	private _iPhone_X_SIM_2 = _display displayCtrl 97617;
	private _iPhone_X_SIM_3 = _display displayCtrl 97618;

	if !(isNil "A3PL_phoneNumberPrimary") then {_iPhone_X_SIM_1 ctrlSetText format["PRIMARY : %1", A3PL_phoneNumberPrimary]; ctrlShow [97719,true];};
	if !(isNil "A3PL_phoneNumberSecondary") then {_iPhone_X_SIM_2 ctrlSetText format["SECONDARY : %1", A3PL_phoneNumberSecondary]; ctrlShow [97720,true];};
	if !(isNil "A3PL_phoneNumberEnterprise") then {_iPhone_X_SIM_3 ctrlSetText format["COMPANY : %1", A3PL_phoneNumberEnterprise]; ctrlShow [97721,true];};

	if !(isNil "A3PL_phoneNumberActive") then {
		if !(isNil "A3PL_phoneNumberPrimary") then {
			if (A3PL_phoneNumberActive isEqualTo A3PL_phoneNumberPrimary) then {_iPhone_X_SIM_1 ctrlSetTextColor [0.027,0.576,0.047,1]; ctrlShow [97719,false];} else {_iPhone_X_SIM_1 ctrlSetTextColor [0,0,0,1]; ctrlShow [97719,true];};
		};
		if !(isNil "A3PL_phoneNumberSecondary") then {
			if (A3PL_phoneNumberActive isEqualTo A3PL_phoneNumberSecondary) then {_iPhone_X_SIM_2 ctrlSetTextColor [0.027,0.576,0.047,1]; ctrlShow [97720,false];} else {_iPhone_X_SIM_2 ctrlSetTextColor [0,0,0,1]; ctrlShow [97720,true];};
		};
		if !(isNil "A3PL_phoneNumberEnterprise") then {
			if (A3PL_phoneNumberActive isEqualTo A3PL_phoneNumberEnterprise) then {_iPhone_X_SIM_3 ctrlSetTextColor [0.027,0.576,0.047,1]; ctrlShow [97721,false];} else {_iPhone_X_SIM_3 ctrlSetTextColor [0,0,0,1]; ctrlShow [97721,false];};
		};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Silent",
{
	disableSerialization;
	private _display = findDisplay 98700;
	private _control = _display displayCtrl 97717;
	private _iPhone_Settings = profileNamespace getVariable ["A3PL_iPhoneX_Settings",[2,1,0]];
	if ((_iPhone_Settings select 2) isEqualTo 0) then {
		_iPhone_Settings set[2,1];
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_iPhone_Settings set[2,0];
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};
	profileNamespace setVariable ["A3PL_iPhoneX_Settings",_iPhone_Settings];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Sound",
{
	private _id = param[0,0];
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _iPhone_Settings = profileNamespace getVariable ["A3PL_iPhoneX_Settings",[2,1,0]];
	_iPhone_Settings set[1, _id];
	profileNamespace setVariable ["A3PL_iPhoneX_Settings",_iPhone_Settings];

	private _soundReceive = format["receivecall_sound_%1", _id];
	player say3D [_soundReceive,10,1];
	["You change your ringing tone","green"] call A3PL_Player_Notification;

	if(!isNull (findDisplay 98700)) then {
		_display = findDisplay 98700;
		_iPhone_X_sound_1 = _display displayCtrl 97714;
		_iPhone_X_sound_2 = _display displayCtrl 97715;
		_iPhone_X_sound_3 = _display displayCtrl 97716;

		_soundActive = _iPhone_Settings select 1;
		if (_soundActive == 1) then {_iPhone_X_sound_1 ctrlSetTextColor [0.027,0.576,0.047,1];} else {_iPhone_X_sound_1 ctrlSetTextColor [0,0,0,1];};
		if (_soundActive == 2) then {_iPhone_X_sound_2 ctrlSetTextColor [0.027,0.576,0.047,1];} else {_iPhone_X_sound_2 ctrlSetTextColor [0,0,0,1];};
		if (_soundActive == 3) then {_iPhone_X_sound_3 ctrlSetTextColor [0.027,0.576,0.047,1];} else {_iPhone_X_sound_3 ctrlSetTextColor [0,0,0,1];};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Wallpaper",
{
	private _id = param[0,0];
	private _iPhone_Settings = profileNamespace getVariable ["A3PL_iPhoneX_Settings",[2,1,0]];
	_iPhone_Settings set[0, _id];
	profileNamespace setVariable ["A3PL_iPhoneX_Settings",_iPhone_Settings];
	["You changed your wallpaper","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_isPhoneOpen",
{
	disableSerialization;
	private _isOpen = false;
	private _displayArray = [];
	{
		if(!isNull _x) exitWith {_isOpen = true;};
	} forEach _displayArray;
	if(_isOpen) exitWith {};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SyncData",
{
	private _lastSync = player getVariable["lastSync",diag_tickTime-310];
	if(_lastSync >= diag_tickTime-300) exitWith {};
	player setVariable["lastSync",diag_tickTime];
	private _uid = getPlayerUID player;
	[player, _uid, false] remoteExec["Server_Gear_Save",2];
	['You have successfully synced your data.',"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SetParam",
{
	disableSerialization;
	private _cid = param[0,0];
	private _var = param[1,""];
	private _display = findDisplay 98600;
	private _control = _display displayCtrl _cid;
	if (profilenamespace getVariable [_var,true]) then {
		profilenamespace setVariable [_var,false];
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	} else {
		profilenamespace setVariable [_var,true];
		_control ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	};
	if(_var isEqualTo "A3PL_ShowGrass") then {
		if (profilenamespace getVariable ["A3PL_ShowGrass",true]) then {
			setTerrainGrid 25;
		} else {
			setTerrainGrid 50;
		};
	};
}] call Server_Setup_Compile;
