["Server_Police_Impound",
{
	private _veh = param [0,objNull];
	if (isNull _veh) exitwith {};
	private _var = _veh getVariable ["owner",nil];
	if (!isNil "_var") then {
		private _id = _var select 1;
		private _query = format ["UPDATE objects SET plystorage = '1',impounded='1',fuel='%2' WHERE id = '%1'",_id,(fuel _veh)];
		[_query,1] spawn Server_Database_Async;
	};
	[_veh] call Server_Vehicle_Despawn;
	if (!isNil "_id") then {
		private _player = [(_var select 0)] call A3PL_Lib_UIDToObject;
		if (!isNull _player) then {[] remoteExec ["A3PL_Police_ImpoundMsg",(owner _player)];};
	};
},true] call Server_Setup_Compile;

['Server_Police_Database',
{
	private _player = _this select 0;
	private _name = _this select 1;
	private _call = _this select 2;
	switch (_call) do {
		case "lookup": {
			private _query = format ["SELECT
			(SELECT gender FROM players WHERE name = '%1') AS gender,
			(SELECT dob FROM players WHERE name = '%1') AS DOB,
			(SELECT COUNT(Actiontype) FROM policedatabase WHERE Actiontype='warrant' AND uid = (SELECT uid FROM players WHERE name='%1')) AS warrantAmount,
			(SELECT COUNT(Actiontype) FROM policedatabase WHERE Actiontype='arrest' AND uid = (SELECT uid FROM players WHERE name='%1')) AS arrestAmount,
			(SELECT COUNT(Actiontype) FROM policedatabase WHERE Actiontype='ticket' AND uid = (SELECT uid FROM players WHERE name='%1')) AS ticketAmount,
			(SELECT COUNT(Actiontype) FROM policedatabase WHERE Actiontype='warning' AND uid = (SELECT uid FROM players WHERE name='%1')) AS warningAmount,
			(SELECT COUNT(Actiontype) FROM policedatabase WHERE Actiontype='report' AND uid = (SELECT uid FROM players WHERE name='%1')) AS reportAmount,
			(SELECT pasportdate FROM players WHERE name = '%1') AS pasportDate,
			(SELECT licenses FROM players WHERE name = '%1') AS licenses,
			(SELECT bank FROM players WHERE name = '%1') AS bank
			FROM players
			WHERE uid = (SELECT uid FROM players WHERE name='%1')
			LIMIT 1", _name];
			private _return = [_query, 2] call Server_Database_Async;
			if(count(_return) > 0) then {
				private _query = format ["SELECT uid FROM players WHERE name='%1'", _name];
				private _uid = ([_query, 2] call Server_Database_Async) select 0;
				private _query = format ["SELECT name FROM companies WHERE employees LIKE '%2%1%2'", _uid, "%"];
				private _company = [_query, 2] call Server_Database_Async;
				if(count(_company) == 0) then {
					_return pushBack "none";
				} else {
					_return pushBack(_company select 0);
				};
			};
			[_name,_call,_return] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "lookupvehicles": {
			private _query = format ["SELECT id,class,stolen,insurance FROM objects WHERE (uid = (SELECT uid FROM players WHERE name='%1')) AND NOT type='object'",_name];
			private _return = [_query, 2,true] call Server_Database_Async;
			[_name,_call,_return] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "lookuplicense": {
			private _query = format ["SELECT name, (SELECT stolen FROM objects WHERE id='%1') AS stolen, (SELECT class FROM objects WHERE id = '%1') AS class, (SELECT insurance FROM objects WHERE id = '%1') AS insured FROM players WHERE uid = (SELECT uid FROM objects WHERE (type='vehicle' OR type='plane') AND id='%1')",_name];
			private _return = [_query, 2] call Server_Database_Async;
			_return pushBack _name;
			[_name,_call,_return] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "lookupcompany": {
			private _query = format ["SELECT name, description, (SELECT name FROM players WHERE uid=(SELECT boss FROM companies WHERE name='%1')) AS boss, bank, licenses FROM companies WHERE name = '%1'",_name];
			private _return = [_query, 2] call Server_Database_Async;
			[_name,_call,_return] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "lookupaddress": {
			private _queryUID = format["SELECT uid FROM players WHERE name='%1'",_name];
			private _uid = ([_queryUID, 2] call Server_Database_Async) select 0;
			private _query = format ["SELECT location FROM houses WHERE uids LIKE '%1%2%1'","%",_uid];
			private _return = [([_query, 2] call Server_Database_Async) select 0];
			_return pushBack _name;
			[_name,_call,_return] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "markstolen": {
			private _query = format ["SELECT id,stolen FROM objects WHERE id = '%1'",_name];
			private _return = [_query, 2] call Server_Database_Async;
			if(_return select 1 != 0) exitWith {
				private _output = format[localize"STR_SERVER_POLICE_MARKSTOLENALREADYMARKEDSTOLEN",_name];
				[_name,_call,_output] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			};
			if(count _return > 0) exitWith {
				private _id = _return select 0;
				private _query = format ["UPDATE objects set stolen='1' WHERE ID='%1'",_id];
				[_query, 1] call Server_Database_Async;
				private _output = format[localize"STR_SERVER_POLICE_MARKSTOLEN",_name];
				[_name,_call,_output] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			};
			private _output = localize"STR_SERVER_POLICE_LICENSEPLATEINVALID";
			[_name,_call,_output] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "markfound": {
			private _query = format ["SELECT id,stolen FROM objects WHERE id = '%1'",_name];
			private _return = [_query, 2] call Server_Database_Async;
			if(_return select 1 != 1) exitWith {
				private _output = format[localize"STR_SERVER_POLICE_VEHICLENOTMARKEDSTOLEN",_name];
				[_name,_call,_output] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			};
			if(count _return > 0) exitWith {
				private _id = _return select 0;
				private _query = format ["UPDATE objects set stolen='0' WHERE ID='%1'",_id];
				[_query, 1] call Server_Database_Async;
				private _output = format[localize"STR_SERVER_POLICE_VEHICLEMARKEDSTOLEN",_name];
				[_name,_call,_output] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			};
			private _output = localize"STR_SERVER_POLICE_LICENSEPLATEINVALID";
			[_name,_call,_output] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "warrantlist":
		{
			private _query = format ["SELECT title,time,issuedby FROM policedatabase WHERE (uid = (SELECT uid FROM players WHERE name='%1')) AND (actiontype='warrant')",_name];
			private _return = [_query, 2, true] call Server_Database_Async;
			[_name,_call,_return] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "warrantinfo": {
			private _query = format ["SELECT time,issuedby,info FROM policedatabase WHERE uid = (SELECT UID FROM players WHERE name = '%1') AND actiontype='warrant' LIMIT 1 OFFSET %2",_name,(_this select 3)];
			private _return = [_query, 2] call Server_Database_Async;
			[_name,_call,_return] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "removewarrant": {
			private _query = format ["SELECT ID FROM policedatabase WHERE uid = (SELECT UID FROM players WHERE name = '%1') AND actiontype='warrant' LIMIT 1 OFFSET %2",_name,(_this select 3)];
			private _return = [_query, 2] call Server_Database_Async;
			if(count _return > 0) exitWith {
				private _id = _return select 0;
				private _query = format ["DELETE FROM policedatabase WHERE ID='%1'",_id];
				[_query, 1] call Server_Database_Async;
				private _output = format[localize"STR_SERVER_POLICE_SUCCESSFULLYDELETEDWARRANT",_name];
				[_name,_call,_output] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			};
			private _output = localize"STR_SERVER_POLICE_IDINVALIDUSECOMMANDWARRANTLIST";
			[_name,_call,_output] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "ticketlist": {
			private _query = format ["SELECT time,info,issuedby FROM policedatabase WHERE (uid = (SELECT uid FROM players WHERE name='%1')) AND (actiontype='ticket')",_name];
			private _return = [_query, 2,true] call Server_Database_Async;
			[_name,_call,_return] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "arrestlist": {
			private _query = format ["SELECT time,info,issuedby FROM policedatabase WHERE (uid = (SELECT uid FROM players WHERE name='%1')) AND (actiontype='arrest')",_name];
			private _return = [_query, 2,true] call Server_Database_Async;
			[_name,_call,_return] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "warninglist": {
			private _query = format ["SELECT time,info,issuedby FROM policedatabase WHERE (uid = (SELECT uid FROM players WHERE name='%1')) AND (actiontype='warning')",_name];
			private _return = [_query, 2,true] call Server_Database_Async;
			[_name,_call,_return] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
		};
		case "insertwarrant": {
			private _title = _name select 1;
			private _info = _name select 2;
			private _issuedBy = _name select 3;
			private _name = _name select 0;
			private _query = format ["SELECT uid FROM players WHERE name='%1'",_name];
			private _return = [_query, 2, true] call Server_Database_Async;
			if(count _return < 1) then {
				[_name,_call,localize"STR_SERVER_POLICE_NAMEOFCITIZENINVALID"] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			} else {
				private _uid = (_return select 0) select 0;
				private _query = format ["INSERT INTO policedatabase (UID, ActionType, Info, Title, IssuedBy, Time) VALUES ('%1', 'warrant', '%2', '%3', '%4', NOW())",_uid,_info,_title,_issuedBy,_name];
				[_query,1] call Server_Database_Async;
				[_name,_call,format[localize"STR_SERVER_POLICE_YOUINSEREIDWITHSUCCESS",_name]] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			};
		};
		case "insertticket": {
			private _amount = _name select 1;
			private _info = _name select 2;
			private _issuedBy = _name select 3;
			private _name = _name select 0;
			private _query = format ["SELECT uid FROM players WHERE name='%1'",_name];
			private _return = [_query, 2, true] call Server_Database_Async;
			if(count _return < 1) then {
				[_name,_call,localize"STR_SERVER_POLICE_NAMEOFCITIZENINVALID"] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			} else {
				private _uid = (_return select 0) select 0;
				private _query = format ["INSERT INTO policedatabase (UID, ActionType, Info, Amount, IssuedBy, Time) VALUES ('%1', 'ticket', '%2', '%3', '%4', NOW())",_uid,_info,_amount,_issuedBy,_name];
				[_query, 1] call Server_Database_Async;
				[_name,_call,format[localize"STR_SERVER_POLICE_YOUINSERETICKETWITHSUCCESS",_name]] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			};
		};
		case "insertwarning": {
			private _title = _name select 1;
			private _info = _name select 2;
			private _issuedBy = _name select 3;
			private _name = _name select 0;
			private _query = format ["SELECT uid FROM players WHERE name='%1'",_name];
			private _return = [_query, 2, true] call Server_Database_Async;
			if(count _return < 1) then {
				[_name,_call,localize"STR_SERVER_POLICE_NAMEOFCITIZENINVALID"] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			} else {
				private _uid = (_return select 0) select 0;
				private _query = format ["INSERT INTO policedatabase (UID, ActionType, Info, Title, IssuedBy, Time) VALUES ('%1', 'warning', '%2', '%3', '%4', NOW())",_uid,_info,_title,_issuedBy,_name];
				[_query,1] call Server_Database_Async;
				[_name,_call,format[localize"STR_SERVER_POLICE_YOUINSEREWITHSUCCESSWARNING",_name]] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			};
		};
		case "insertreport": {
			private _title = _name select 1;
			private _info = _name select 2;
			private _issuedBy = _name select 3;
			private _name = _name select 0;
			private _query = format ["SELECT uid FROM players WHERE name='%1'",_name];
			private _return = [_query, 2, true] call Server_Database_Async;
			if(count _return < 1) then {
				[_name,_call,localize"STR_SERVER_POLICE_NAMEOFCITIZENINVALID"] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			} else {
				private _uid = (_return select 0) select 0;
				private _query = format ["INSERT INTO policedatabase (UID, ActionType, Info, Title, IssuedBy, Time) VALUES ('%1', 'report', '%2', '%3', '%4', NOW())",_uid,_info,_title,_issuedBy,_name];
				[_query, 1] call Server_Database_Async;
				[_name,_call,format[localize"STR_SERVER_POLICE_YOUINSEREWITHSUCCESSRAPPORT",_name]] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			};
		};
		case "insertarrest": {
			private _time = _name select 1;
			private _info = _name select 2;
			private _issuedBy = _name select 3;
			private _name = _name select 0;
			private _query = format ["SELECT uid FROM players WHERE name='%1'",_name];
			private _return = [_query, 2, true] call Server_Database_Async;
			if(count _return < 1) then {
				[_name,_call,localize"STR_SERVER_POLICE_NAMEOFCITIZENINVALID"] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			} else {
				private _uid = (_return select 0) select 0;
				private _query = format ["INSERT INTO policedatabase (UID, ActionType, Info, Amount, IssuedBy, Time) VALUES ('%1', 'arrest', '%2', '%3', '%4', NOW())",_uid,_info,_time,_issuedBy,_name];
				[_query, 1] call Server_Database_Async;
				[_name,_call,format[localize"STR_SERVER_POLICE_YOUINSEREWITHSUCCESSARREST",_name]] remoteExec ["A3PL_Police_DatabaseEnterReceive",(owner _player)];
			};
		};
	};
},true] call Server_Setup_Compile;

["Server_Police_PayTicket",
{
	private _ticketAmount = param [0,1];
	private _civ = param [1,objNull];
	private _cop = param [2,objNull];
	if ((isNull _civ) OR (isNull _cop)) exitwith {};
	private _cash = _civ getVariable ["player_cash",0];
	private _bank = _civ getVariable ["player_bank",0];
	if ((_ticketAmount > _cash) && (_ticketAmount > _bank)) exitwith {[3] remoteExec ["A3PL_Police_ReceiveTicket",Player_TicketCop, 2];};
	if(_ticketAmount <= _cash) then {
		[_civ,"Player_Cash",(_cash - _ticketAmount)] call Server_Core_ChangeVar;
	} else {
		[_civ,"Player_Bank",(_bank - _ticketAmount )] call Server_Core_ChangeVar;
	};
	["Federal Reserve",_ticketAmount] remoteExec ["Server_Government_AddBalance",2];
},true] call Server_Setup_Compile;

["Server_Police_JailPlayer",
{
	params[["_time",0,[0]],["_target",objNull,[objNull]]];
	private _uid = getPlayerUID _target;
	private _exit = false;
	if(_time < 0) exitWith {};
	{
		if ((_x select 0) == _target) exitwith
		{
			Server_Jailed_Players set [_forEachIndex,[_x select 0,_x select 1,_time]];
			_target setVariable ["jailtime",_time,true];
			_exit = true;
		};
	} foreach Server_Jailed_Players;
	if (_exit) exitwith {};
	Server_Jailed_Players pushBack [_target,getPlayerUID _target,_time];
	private _query = format ["UPDATE players SET jail=%1 WHERE uid = '%2'",_time,_uid];
	[_query, 1] call Server_Database_Async;

	_target	setVariable["jail_mark",true,true];
	_target setVariable ["jailtime",_time,true];
	_target setVariable ["jailed",true,true];
},true] call Server_Setup_Compile;

["Server_Police_JailLoop",
{
	{
		private _target = _x select 0;
		private _uid = _x select 1;
		private _time = _x select 2;
		if(isNull _target) exitWith {
			private _query = format ["UPDATE players SET jail=%1 WHERE uid = '%2'",_time,_uid];
			[_query, 1] call Server_Database_Async;
			Server_Jailed_Players deleteAt _forEachIndex;
		};
		if(_time <= 1) exitWith {
			_target setVariable ["jailtime",0,true];
			_target setVariable ["jailed",false,true];
			[] remoteExec ["A3PL_Police_ReleasePlayer",_target];
			Server_Jailed_Players deleteAt _forEachIndex;
			private _query = format ["UPDATE players SET jail=%1 WHERE uid = '%2'",0,_uid];
			[_query, 1] call Server_Database_Async;
		};
		_target setVariable ["jailtime",(_time-1),true];
		Server_Jailed_Players set [_forEachIndex, [_target,_uid,(_time-1)]];
	} forEach Server_Jailed_Players;
},true] call Server_Setup_Compile;

["Server_Police_SeizureLoad",
{
	private _storage = A3FL_Seize_Storage;
	private _aitems = Server_SeizureStorage select 0;
	private _mags = Server_SeizureStorage select 1;
	private _backpacks = Server_SeizureStorage select 2;
	private _weapons = Server_SeizureStorage select 3;
	private _virtual = Server_SeizureStorage select 4;
	for "_i" from 0 to ((count (_aitems select 0)) - 1) do {
		_storage addItemCargoGlobal [((_aitems select 0) select _i), ((_aitems select 1) select _i)];
	};
	for "_i" from 0 to ((count (_mags select 0)) - 1) do {
		_storage addMagazineCargoGlobal [((_mags select 0) select _i), ((_mags select 1) select _i)];
	};
	for "_i" from 0 to ((count (_backpacks select 0)) - 1) do {
		_storage addBackpackCargoGlobal [((_backpacks select 0) select _i), ((_backpacks select 1) select _i)];
	};
	for "_i" from 0 to ((count (_weapons select 0)) - 1) do {
		_storage addWeaponCargoGlobal [((_weapons select 0) select _i), ((_weapons select 1) select _i)];
	};
	_storage setVariable["storage",_virtual,true];
},true] call Server_Setup_Compile;

["Server_Police_SeizureSave",
{
	private _storage = A3FL_Seize_Storage;
	private _aitems = getItemCargo _storage;
	private _mags = getMagazineCargo _storage;
	private _backpacks = getBackpackCargo _storage;
	private _weapons = getWeaponCargo _storage;
	private _virtual = _storage getVariable["storage", []];
	private _inventory = [_aitems,_mags,_backpacks,_weapons,_virtual];
	private _inventory = [_inventory] call Server_Database_Array;
	private _query = format ["UPDATE persistent_vars SET value='%2' WHERE var = '%1'",'Server_SeizureStorage',_inventory];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;