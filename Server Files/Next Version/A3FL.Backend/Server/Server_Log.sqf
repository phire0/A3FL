/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Log_New",
{
	private ["_uid","_action","_data","_insert","_dataString"];
	_uid = param [0,""];
	_action = param [1,""];
	_data = param [2,[]];

	//Example Call
	//[getPlayerUID player,"ACTION",["Data","Array"]] remoteExec ["Server_Log_New", 2];
	//[getPlayerUID _player,"ACTION",["Data","Array"]] call Server_Log_New;
	_dataString = "";
	
	if ((typeName _data) == "ARRAY") then {
		{
			if(_dataString == "") then {
				_dataString = _x;
			} else {
				_dataString = format["%1:%2 ",_dataString,_x];
			};
		} forEach _data;
	} else {
		_dataString = _data;
	};

	_strArray = _dataString splitString "";
	_dataString = "";
	{if(!(_x IN ["'"])) then {_dataString = _dataString + _x;};} forEach _strArray;

	_insert = format ["INSERT INTO logs (uid, type, data) VALUES ('%1','%2','%3')",_uid,_action,_dataString];
	[_insert,1] spawn Server_Database_Async;

}, true] call Server_Setup_Compile;

["Server_AdminLoginsert",
{

	_admin = _this select 0; //player
	_adminname = format ["%1 (%2)",_admin getvariable ["name","Undefined"],name _admin];
	_adminuid = getPlayerUID _admin;
	_type = _this select 1; //string
	_data = _this select 2;
	
	_dataString = "";

	{
		if(_dataString == "") then {
			_dataString = _X;
		} else {
			_dataString = format["%1:%2",_dataString,_x];
		};
	} forEach _data;

	_insert = format ["INSERT INTO adminlogs (adminname, uid, type, data) VALUES ('%1','%2','%3','%4')",_adminname,_adminuid,_type,_dataString];
	[_insert,1] spawn Server_Database_Async;

}, true] call Server_Setup_Compile;