/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['Server_iPhoneX_AddPhoneNumber',
{
	private ["_unit","_phoneNumber","_type","_serialNumber","_query"];
	_unit = [_this,0,"",[""]] call BIS_fnc_param;
	_phoneNumber = [_this,1,"",[""]] call BIS_fnc_param;
	_type = [_this,2,"",[""]] call BIS_fnc_param;

	if (_unit isEqualTo "" || _phoneNumber isEqualTo "" || _type isEqualTo "") exitWith {};

	_serialNumber = [];
	for "_i" from 0 to 14 do {
		_serialNumber pushBack (selectRandom ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",0,1,2,3,4,5,6,7,8,9]);
	};
	_serialNumber = _serialNumber joinString "";
	_query = format ["INSERT INTO iphone_phone_numbers (player_id, phone_number, type_id, serial_number) VALUES ('%1', '%2', '%3', '%4')", _unit, _phoneNumber, _type, _serialNumber];
	[_query,1] call Server_Database_Async;
},true] call Server_Setup_Compile;

['Server_iPhoneX_CallSwitchboard',
{
	private ["_unit","_phoneNumberActive","_ownerID","_playerUID"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberActive = [_this,1,"",[""]] call BIS_fnc_param;
	_phoneNumberContact = [_this,2,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberActive isEqualTo "" || _phoneNumberContact isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	if (_phoneNumberContact isEqualTo "911") then {
		A3PL_iPhoneX_switchboard pushBack [_ownerID, _phoneNumberActive];
		[_phoneNumberActive, _phoneNumberContact] remoteExec ["A3PL_iPhoneX_switchboardReceive"];
		[A3PL_iPhoneX_switchboard] remoteExec ["A3PL_iPhoneX_switchboardSend", _ownerID];
	};
},true] call Server_Setup_Compile;

['Server_iPhoneX_NumberIsUsed',
{
	private ["_unit", "_phoneNumber","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumber = [_this,1,"",[""]] call BIS_fnc_param;
	if ((isNil "_unit") || {_phoneNumber isEqualTo ""}) exitWith {};
	_query = format ["SELECT phone_number FROM iphone_phone_numbers WHERE phone_number='%1'", _phoneNumber];
	_result = [_query,2] call Server_Database_Async;
	if((count _result) > 0) then {_result = true;} else {_result = false;};
	[_result] remoteExec ["A3PL_iPhoneX_NumberIsUsed", owner _unit];
},true] call Server_Setup_Compile;

['Server_iPhoneX_DeleteContact',
{
	private ["_unit","_phoneNumberContact","_playerUID","_query"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberContact = [_this,1,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberContact isEqualTo "") exitWith {};
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["DELETE FROM iphone_contacts WHERE player_id='%1' AND phone_number_contact='%2'", _playerUID, _phoneNumberContact];
	[_query,1] call Server_Database_Async;

	uiSleep 1;
	[_unit] remoteExec ["Server_iPhoneX_GetContacts",2];
},true] call Server_Setup_Compile;

['Server_iPhoneX_GetContacts',
{
	private ["_unit","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT name_contact, phone_number_contact, note_contact FROM iphone_contacts WHERE player_id='%1' ORDER BY name_contact", _playerUID];
	_result = [_query,2,true] call Server_Database_Async;

	if (_result isEqualTo []) then {
		private _uscgContact = ["Emergency services", "911","FISD, USCG, FIMS, FIFR"];
		private _fifrContact = ["Department of Justice", "912", "Department of Justice"];
		_query = format ["INSERT INTO iphone_contacts (player_id, name_contact, phone_number_contact, note_contact) VALUES ('%1', '%2', '%3', '""%4""'), ('%1', '%5', '%6', '""%7""')", _playerUID, _uscgContact select 0, _uscgContact select 1, _uscgContact select 2, _fifrContact select 0, _fifrContact select 1, _fifrContact select 2];
		[_query,1] call Server_Database_Async;
		sleep 2;
		[_unit] remoteExec ["Server_iPhoneX_GetContacts",2];
	} else {
		[_result] remoteExec ["A3PL_iPhoneX_Contacts", _ownerID];
	};
},true] call Server_Setup_Compile;

['Server_iPhoneX_GetConversations',
{
	private ["_unit","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT name_contact, phone_number_contact, last_sms FROM iphone_conversations WHERE player_id='%1' ORDER BY name_contact", _playerUID];
	_result = [_query,2,true] call Server_Database_Async;
	if (_result isEqualTo []) then {
		private _message = "No message";
		private _uscgContact = ["Emergency services", "911"];
		private _fifrContact = ["Department of Justice", "912"];

		_query = format ["INSERT INTO iphone_conversations (player_id, name_contact, phone_number_contact, last_sms) VALUES ('%1','%2','%3','""%6""'), ('%1','%4','%5','""%6""')", _playerUID, _uscgContact select 0, _uscgContact select 1, _fifrContact select 0, _fifrContact select 1, _message];
		[_query,1] call Server_Database_Async;
		uiSleep 2;
		[_unit] remoteExec ["Server_iPhoneX_GetConversations",2];
	} else {
		[_result] remoteExec ["A3PL_iPhoneX_Conversations", _ownerID];
	};
},true] call Server_Setup_Compile;

['Server_iPhoneX_GetListNumber',
{
	private _unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	if (isNil "_unit") exitWith {};
	[A3PL_iPhoneX_ListNumber] remoteExec ["A3PL_iPhoneX_listNumber", owner _unit];
},true] call Server_Setup_Compile;

['Server_iPhoneX_GetPhoneNumber',
{
	private ["_unit","_ownerID","_playerUID","_query","_resultPrimary","_resultSecondary","_resultEnterprise","_resultActive","_inList"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT phone_number FROM iphone_phone_numbers WHERE player_id='%1' AND type_id='1'", _playerUID];
	_resultPrimary = [_query,2] call Server_Database_Async;

	if !(_resultPrimary isEqualTo []) then {
		if (_resultPrimary isEqualType []) then {_resultPrimary = _resultPrimary select 0;};
		[_resultPrimary,"Primary"] remoteExec ["A3PL_iPhoneX_setPhoneNumber", _ownerID];
	};

	_query = format ["SELECT phone_number FROM iphone_phone_numbers WHERE player_id='%1' AND type_id='2'", _playerUID];
	_resultSecondary = [_query,2] call Server_Database_Async;

	if !(_resultSecondary isEqualTo []) then {
		if (_resultSecondary isEqualType []) then {_resultSecondary = _resultSecondary select 0;};
		[_resultSecondary,"Secondary"] remoteExec ["A3PL_iPhoneX_setPhoneNumber", _ownerID];
	};

	_query = format ["SELECT phone_number FROM iphone_phone_numbers WHERE player_id='%1' AND type_id='3'", _playerUID];
	_resultEnterprise = [_query,2] call Server_Database_Async;

	if !(_resultEnterprise isEqualTo []) then {
		if (_resultEnterprise isEqualType []) then {_resultEnterprise = _resultEnterprise select 0;};
		[_resultEnterprise,"Enterprise"] remoteExec ["A3PL_iPhoneX_setPhoneNumber", _ownerID];
		if (_resultEnterprise isEqualTo "911") then {[A3PL_iPhoneX_switchboard] remoteExec ["A3PL_iPhoneX_switchboardSend",2]};
	};

	_query = format ["SELECT phone_number_active FROM iphone_phone_numbers_active WHERE player_id='%1'", _playerUID];
	_resultActive = [_query,2] call Server_Database_Async;

	if !(_resultActive isEqualTo []) then {
		if (_resultActive isEqualType []) then {_resultActive = _resultActive select 0;};
		[_resultActive, "Active"] remoteExecCall ["A3PL_iPhoneX_setPhoneNumber", _ownerID];
	} else {
		if !(_resultPrimary isEqualTo []) then {
			[_unit, _resultPrimary] remoteExec ["Server_iPhoneX_savePhoneNumberActive", 2];
		};
	};
	[_unit] remoteExec ["Server_iPhoneX_GetContacts",2];
	[_unit] remoteExec ["Server_iPhoneX_GetConversations",2];


	_inList = ([A3PL_iPhoneX_ListNumber, _resultPrimary] call BIS_fnc_findNestedElement);
	if (_inList isEqualTo []) then {
		A3PL_iPhoneX_ListNumber pushBack [_resultPrimary, _ownerID];
	} else {
		A3PL_iPhoneX_ListNumber set [(_inList select 0), [_resultPrimary, _ownerID]];
	};

	_inList = ([A3PL_iPhoneX_ListNumber, _resultSecondary] call BIS_fnc_findNestedElement);
	if (_inList isEqualTo []) then {
		A3PL_iPhoneX_ListNumber pushBack [_resultSecondary, _ownerID];
	} else {
		A3PL_iPhoneX_ListNumber set [(_inList select 0), [_resultSecondary, _ownerID]];
	};
},true] call Server_Setup_Compile;

['Server_iPhoneX_GetPhoneNumberActive',
{
	private ["_unit","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT phone_number_active FROM iphone_phone_numbers_active WHERE player_id='%1'", _playerUID];
	_result = [_query,2] call Server_Database_Async;

	if !(_result isEqualTo []) then {
		if (_result isEqualType []) then {_result = _result select 0;};
		[_result,"Active"] remoteExec ["A3PL_iPhoneX_setPhoneNumber", owner _unit];
	};
},true] call Server_Setup_Compile;

['Server_iPhoneX_GetPhoneNumberEnterprise',
{
	private ["_unit","_ownerID","_playerUID"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT phone_number FROM iphone_phone_numbers WHERE player_id='%1' AND type_id='3'", _playerUID];
	_result = [_query,2] call Server_Database_Async;

	if !(_result isEqualTo []) then {
		if (_result isEqualType []) then {_result = _result select 0;};
		[_result,"Enterprise"] remoteExec ["A3PL_iPhoneX_setPhoneNumber", owner _unit];
	} else {
		[nil,"Enterprise"] remoteExec ["A3PL_iPhoneX_setPhoneNumber", owner _unit];
	};
},true] call Server_Setup_Compile;

['Server_iPhoneX_GetSMS',
{
	private ["_unit","_phoneNumberActive","_phoneNumberContact","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberActive = [_this,1,"",[""]] call BIS_fnc_param;
	_phoneNumberContact = [_this,2,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberActive isEqualTo "" || _phoneNumberContact isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	["DELETE FROM iphone_messages WHERE to_num = '911' AND date < DATE_SUB(NOW(),INTERVAL 15 MINUTE)",1] call Server_Database_Async;

	_query = format ["SELECT from_num, to_num, message FROM iphone_messages WHERE (from_num='%1' AND to_num='%2') OR (from_num='%2' AND to_num='%1') ORDER BY date", _phoneNumberActive, _phoneNumberContact];
	_result = [_query,2,true] call Server_Database_Async;
	reverse _result;
	[_phoneNumberContact, _result] remoteExec ["A3PL_iPhoneX_SMS", _ownerID];
},true] call Server_Setup_Compile;

['Server_iPhoneX_GetSMSEnterprise',
{
	private ["_unit","_phoneNumberActive","_phoneNumberContact","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberContact = [_this,1,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberContact isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT from_num, message, position FROM iphone_messages WHERE to_num='%1' ORDER BY date", _phoneNumberContact];
	_result = [_query,2,true] call Server_Database_Async;

	[_result] remoteExec ["A3PL_iPhoneX_SMSEnterprise", _ownerID];
},true] call Server_Setup_Compile;

['Server_iPhoneX_SaveContact',
{
	private ["_uid","_ownerPhoneNumber","_nameContact","_phoneNumberContact","_query"];
	_uid  = [_this,0,"",[""]] call BIS_fnc_param;
	_nameContact = [_this,1,"",[""]] call BIS_fnc_param;
	_phoneNumberContact = [_this,2,"",[""]] call BIS_fnc_param;
	_noteContact = [_this,3,"",[""]] call BIS_fnc_param;

	if (_uid isEqualTo "" || _nameContact isEqualTo "" || _phoneNumberContact isEqualTo "") exitWith {};

	_query = format ["INSERT INTO iphone_contacts (player_id, name_contact, phone_number_contact, note_contact) VALUES ('%1', '%2', '%3', '""%4""')", _uid, _nameContact, _phoneNumberContact, _noteContact];
	[_query,1] call Server_Database_Async;
},true] call Server_Setup_Compile;

['Server_iPhoneX_SaveConversation',
{
	private ["_uid","_nameContact","_phoneNumberContact","_query"];
	_uid  = [_this,0,"",[""]] call BIS_fnc_param;
	_nameContact = [_this,1,"",[""]] call BIS_fnc_param;
	_phoneNumberContact = [_this,2,"",[""]] call BIS_fnc_param;
	_message = [_this,3,"",[""]] call BIS_fnc_param;

	if (_uid isEqualTo "" || _nameContact isEqualTo "" || _phoneNumberContact isEqualTo "" || _message isEqualTo "") exitWith {};

	_query = format ["INSERT INTO iphone_conversations (player_id, name_contact, phone_number_contact, last_sms) VALUES ('%1','%2','%3','""%4""')", _uid, _nameContact, _phoneNumberContact, _message];
	[_query,1] call Server_Database_Async;
},true] call Server_Setup_Compile;

['Server_iPhoneX_SaveLastSMS',
{
	private ["_uid","_nameContact","_phoneNumberContact","_message","_query"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberContact = [_this,1,"",[""]] call BIS_fnc_param;
	_message = [_this,2,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberContact isEqualTo "" || _message isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["UPDATE iphone_conversations SET last_SMS='""%1""' WHERE phone_number_contact='%2' AND player_id='%3'", _message, _phoneNumberContact, _playerUID];
	[_query,1] call Server_Database_Async;

	[_unit] remoteExec ["A3PL_iPhoneX_getConversations",2];
},true] call Server_Setup_Compile;

['Server_iPhoneX_SavePhoneNumberActive',
{
	private ["_unit","_phoneNumberActive","_ownerID","_playerUID"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberActive = [_this,1,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberActive isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["INSERT INTO iphone_phone_numbers_active (player_id, phone_number_active) VALUES ('%1', '%2')", _playerUID, _phoneNumberActive];
	[_query,1] call Server_Database_Async;

	[_phoneNumberActive,"Active"] remoteExec ["A3PL_iPhoneX_setPhoneNumber", _ownerID];
},true] call Server_Setup_Compile;

['Server_iPhoneX_SendSMS',
{
	private ["_unit","_from","_to","_message","_query","_exists"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_from  = [_this,1,"",[""]] call BIS_fnc_param;
	_to = [_this,2,"",[""]] call BIS_fnc_param;
	_message = [_this,3,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _from isEqualTo "" || _to isEqualTo "" || _message isEqualTo "") exitWith {};

	_position = mapGridPosition _unit;
	_actualPos = getPos _unit;
	_query = format ["INSERT INTO iphone_messages (from_num, to_num, message, position) VALUES ('%1', '%2', '""%3""', '%4')", _from, _to, _message, _position];
	[_query,1] call Server_Database_Async;

	if(_to IN ["911","912"]) then {
		if (_to isEqualTo "911") then {
			{[_from, _message, _to, _position,_actualPos] remoteExec ["A3PL_iPhoneX_receiveSMS", _x];} foreach (["uscg"] call A3PL_Lib_FactionPlayers);
			{[_from, _message, _to, _position,_actualPos] remoteExec ["A3PL_iPhoneX_receiveSMS", _x];} foreach (["fisd"] call A3PL_Lib_FactionPlayers);
			{[_from, _message, _to, _position,_actualPos] remoteExec ["A3PL_iPhoneX_receiveSMS", _x];} foreach (["usms"] call A3PL_Lib_FactionPlayers);
			{[_from, _message, _to, _position,_actualPos] remoteExec ["A3PL_iPhoneX_receiveSMS", _x];} foreach (["fifr"] call A3PL_Lib_FactionPlayers);
		};
		if (_to isEqualTo "912") then {
			{[_from, _message, _to, _position] remoteExec ["A3PL_iPhoneX_receiveSMS", _x];} foreach (["doj"] call A3PL_Lib_FactionPlayers);
		};
	} else {
		_exists = [A3PL_iPhoneX_ListNumber, _to] call BIS_fnc_findNestedElement;
		if (!(_exists isEqualTo [])) then {
			[_from, _message, _to, _position] remoteExec ["A3PL_iPhoneX_receiveSMS", ((A3PL_iPhoneX_ListNumber select (_exists select 0)) select 1)];
		};
	};
},true] call Server_Setup_Compile;

['Server_iPhoneX_UpdatePhoneNumberActive',
{
	private ["_unit","_phoneNumberActive","_playerUID"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberActive = [_this,1,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberActive isEqualTo "") exitWith {};
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["UPDATE iphone_phone_numbers_active SET phone_number_active='%2' WHERE player_id='%1'", _playerUID, _phoneNumberActive];
	[_query,1] call Server_Database_Async;
	[_phoneNumberActive,"Active"] remoteExec ["A3PL_iPhoneX_setPhoneNumber", owner _unit];
},true] call Server_Setup_Compile;

['Server_iPhoneX_GetSwitchboard',
{
	params [["_unit",objNull,[objNull]]];
	[A3PL_iPhoneX_switchboard] remoteExec ["A3PL_iPhoneX_switchboard", owner _unit];
},true] call Server_Setup_Compile;

['Server_iPhoneX_SetSwitchboard',
{
	params[["_data",[],[[]]]];
	A3PL_iPhoneX_switchboard = _data;
	{
		[A3PL_iPhoneX_switchboard] remoteExec ["A3PL_iPhoneX_switchboard", _x];
	} foreach allPlayers;
},true] call Server_Setup_Compile;
