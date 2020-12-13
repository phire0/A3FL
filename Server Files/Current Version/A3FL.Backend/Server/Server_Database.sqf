/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#include "Server_Macro.hpp"

['Server_Database_ToArray', {
	private["_array"];
	_array = [_this,0,"",[""]] call BIS_fnc_param;
	if(_array == "") exitWith {[]};
	_array = toArray(_array);

	for "_i" from 0 to (count _array)-1 do
	{
		_sel = _array select _i;
		if(_sel == 96) then
		{
			_array set[_i,39];
		};
	};

	_array = toString(_array);
	_array = call compile format["%1", _array];
	_array;	
},true,true] call Server_Setup_Compile;

['Server_Database_Array',
{
	private["_array"];
	_array = param [0,[]];
	_array = str _array;
	_array = toArray(_array);

	for "_i" from 0 to (count _array)-1 do
	{
		_sel = _array select _i;
		if((_i != 0 && _i != ((count _array)-1))) then
		{
			if(_sel == 34) then
			{
				_array set[_i,96];
			};
		};
	};

	toString(_array);	
},true] call Server_Setup_Compile;

['Server_Database_Setup', {
	private ['_database', '_protocol', '_protocolOptions', '_return', '_result', '_randomNumber', '_extDBCustomID'];
	
	_database = [_this,0,"",[""]] call BIS_fnc_param;
	_protocol = [_this,1,"",[""]] call BIS_fnc_param;
	_protocolOptions = [_this,2,"",[""]] call BIS_fnc_param;
	_return = false;
	
	if ( isNil {uiNamespace getVariable "extDBCustomID"} ) then {
		// extDB Version
		_result = "extDB3" callExtension "9:VERSION";
		
		diag_log format ["extDB3: Version: %1", _result];
		
		if(_result == "") exitWith {diag_log "extDB3: Failed to Load"; false};

		// extDB Connect to Database
		_result = call compile ("extDB3" callExtension format["9:ADD_DATABASE:%1", _database]);
		
		if (_result select 0 isEqualTo 0) exitWith {
				diag_log format ["extDB3: Error Database: %1", _result]; 
				false
		};
		
		diag_log "extDB3: Connected to Database";
		
		// Generate Randomized Protocol Name
		_randomNumber = round(random(999999));
		_extDBCustomID = str(_randomNumber);
		
		extDBCustomID = compileFinal _extDBCustomID;
		
		// extDB Load Protocol
		_result = call compile ("extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%1:%2:%3:%4", _database, _protocol, _extDBCustomID, _protocolOptions]);
		
		if ((_result select 0) isEqualTo 0) exitWith {
				diag_log format ["extDB3: Error Database Setup: %1", _result]; 
				false
		};
		
		diag_log format ["extDB3: Initalized %1 Protocol", _protocol];
		
		// Save Randomized ID
		uiNamespace setVariable ["extDBCustomID", _extDBCustomID];

		_return = true;
	} else {
		extDBCustomID = compileFinal str(uiNamespace getVariable "extDBCustomID");
		
		diag_log "extDB3: Already Setup";

		_return = true;
	};
	_return
}, true, true] call Server_Setup_Compile;

//COMPILE BLOCK FUNCTION!!!
['Server_Database_Async', {
	private["_queryResult","_key","_return","_loop"];
	params [["_queryStmt","",[""]],["_mode",1,[0]],["_multiarr",false,[false]]];

	_key = "extDB3" callExtension format["%1:%2:%3", _mode, (call extDBCustomID), _queryStmt];

	if(EQUAL(_mode,1)) exitWith {true};

	_key = call compile format["%1",_key];
	_key = SEL(_key,1);

	_queryResult = "";
	_loop = true;
	while{_loop} do {
		_queryResult = EXTDB format["4:%1", _key];
		if (EQUAL(_queryResult,"[5]")) then {
			// extDB3 returned that result is Multi-Part Message
			_queryResult = "";
			while{true} do {
				_pipe = EXTDB format["5:%1", _key];
				if(_pipe == "") exitWith {_loop = false};
				_queryResult = _queryResult + _pipe;
			};
		} else {
			if (EQUAL(_queryResult,"[3]")) then {
				//diag_log format ["extDB3: uiSleep [4]: %1", diag_tickTime];
				//uiSleep 0.1;
			} else {
				_loop = false;
			};
		};
	};
	
	_queryResult = call compile _queryResult;
	
	if(EQUAL(SEL(_queryResult,0),0)) exitWith {diag_log format ["extDB3: Protocol Error: %1", _queryResult]; []};
	_return = SEL(_queryResult,1);
	
	if(!_multiarr && count _return > 0) then {
		_return = SEL(_return,0);
	};

	_return;
}, true, true] call Server_Setup_Compile;

['Server_Database_EsapeString', {
	private _string = [_this,0,"",[""]] call BIS_fnc_param;
	private _filter = ["'","/","`",":","|",";",",","{","}","-","<",">","&"];
	private _string = toArray _string;
	private _del = [];
	{
		if (_x in _filter) then {_del pushback _forEachIndex;};
	} forEach _string;
	{
		_string deleteAt (_x - _forEachIndex);
	} foreach _del;
	toString _string;
}, true] call Server_Setup_Compile;


// [[123,123]] call Server_Database_ArrayToSqlIN
// returns: "(123,123)"
//COMPILE BLOCK FUNCTIONS WARNING!!
["Server_Database_ArrayToSqlIN",
{
	private ["_return","_input","_return"];
	_input = param [0,""];
	_input = call compile (format ["%1",_input]);
	
	_return = toArray (format ["%1",_input]);
	_input = toArray (format ["%1",_input]);

	{
		if (_x == 91) then
		{
			_return set [_forEachIndex,40];
		};
		if (_x == 93) then
		{
			_return set [_forEachIndex,41];
		};
	} foreach _input;
	_return = toString _return;
	_return;
},true,true] call Server_Setup_Compile;