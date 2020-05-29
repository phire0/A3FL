/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Twitter_HandleMsg",
{
	private _playerid = param [0,""];
	private _msg = param [1,""];
	private _msgcolor = param [2,""];
	private _namepicture = param [3,""];
	private _name = param [4,""];
	private _namecolor = param [5,""];
	private _query = format["INSERT INTO chatlog (name, steamid, chatmessage, messageinfo) VALUES('%1','%2','%3', '%4')",_name,_playerid,([_msg] call Server_Twitter_StripQuotes),([[_namepicture,_namecolor,_msgcolor]] call Server_Database_Array)];
	[_query,1] call Server_Database_Async;
	if (!isDedicated) then {
		[_msg,_msgcolor,_namepicture,_name,_namecolor,""] remoteExec ["A3PL_Twitter_NewMsg", 2];
	} else {
		[_msg,_msgcolor,_namepicture,_name,_namecolor,""] remoteExec ["A3PL_Twitter_NewMsg", -2];
	};
},true] call Server_Setup_Compile;

//remove ' from string
["Server_Twitter_StripQuotes",
{
	private _msg = toArray (param [0,""]);
	private _del = [];
	{
		if (_x == 39) then {_del pushback _forEachIndex};
	} foreach _msg;
	{
		_msg deleteAt (_x - _forEachIndex);
	} foreach _del;
	_msg = toString _msg;
	_msg;
},true] call Server_Setup_Compile;