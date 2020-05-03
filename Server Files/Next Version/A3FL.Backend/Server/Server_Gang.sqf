/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Gang_Load",
{
	private _player = param [0,objNull];
	private _req = format["SELECT id, owner, name, members, bank, maxmembers FROM gangs WHERE active='1' AND members LIKE '%2%1%2'",getPlayerUID _player,'%'];
	private _gang = [_req, 2] call Server_Database_Async;
	if(count(_gang) > 0) then {
		_gang = [_gang select 0, _gang select 1, _gang select 2, [_gang select 3] call Server_Database_ToArray, _gang select 4, _gang select 5];
		[_gang] remoteExec ["A3PL_Gang_SetData",_player];
	};
},true] call Server_Setup_Compile;

["Server_Gang_Create",
{
	params [
		["_owner",objNull,[objNull]],
		["_gangName","",[""]]
	];
	private _uid = getPlayerUID _owner;
	private _group = group _owner;
	private _gangName = [_gangName] call Server_Database_EsapeString;
	private _query = format ["SELECT id FROM gangs WHERE name='%1' AND active='1'",_gangName];
	private _queryResult = [_query,2] call Server_Database_Async;

	if (!(count _queryResult isEqualTo 0)) exitWith {[format[localize"STR_SERVER_GANG_GROUPALREADYEXIST",_gangName], "red"] remoteExec ["A3PL_Player_Notification",_owner];};

	private _gangMembers = [_uid];
	private _query = format ["INSERT INTO gangs(owner, name, members) VALUES('%1','%2','%3')",_uid,_gangName,_gangMembers];
	[_query,1] call Server_Database_Async;

	sleep 1;

	private _req = format["SELECT id, owner, name, members, bank, maxmembers FROM gangs WHERE active='1' AND members LIKE '%2%1%2'",_uid,'%'];
	private _gang = [_req, 2] call Server_Database_Async;
	_group setVariable["gang_data",_gang,true];
	[_group] remoteExecCall ["A3PL_Gang_Created",_owner];
},true] call Server_Setup_Compile;

["Server_Gang_SaveMembers",
{
	private _group = param [0,grpNull];
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	private _groupID = _gang select 0;
	private _members = _gang select 3;
	[format ["UPDATE gangs SET members='%1' WHERE id='%2'",_members,_groupID], 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Gang_SaveBank",
{
	private _group = param [0,grpNull];
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	private _groupID = _gang select 0;
	private _bank = _gang select 4;
	[format ["UPDATE gangs SET bank='%1' WHERE id='%2'",_bank,_groupID], 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Gang_SaveMaxMembers",
{
	private _group = param [0,grpNull];
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	private _groupID = _gang select 0;
	private _maxMembers = _gang select 5;
	[format ["UPDATE gangs SET maxmembers='%1' WHERE id='%2'",_maxMembers,_groupID], 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Gang_DeleteGang",
{
	private _group = param [0,grpNull];
	private _gang = _group getVariable["gang_data",nil];
	if(isNil '_gang') exitWith {};
	private _groupID = _gang select 0;
	deleteGroup _group;
	[format["DELETE FROM gangs WHERE id = '%1'",_groupID], 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Gang_SetLead",
{
	private _group = param [0,grpNull];
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	private _groupID = _gang select 0;
	private _owner = _gang select 1;
	[format ["UPDATE gangs SET owner='%1' WHERE id='%2'",_owner,_groupID], 1] call Server_Database_Async;
	private _owner = [_owner] call A3PL_Lib_UIDToObject;
	[format[localize"STR_SERVER_GANG_SETLEADER"], "red"] remoteExec ["A3PL_Player_Notification",_owner];
},true] call Server_Setup_Compile;