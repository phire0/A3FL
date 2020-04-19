["Server_Player_Level_Save",{
	private _player = param [0,objNull];
	private _level = _player getvariable ['Player_Level',0];
	private _xp = _player getvariable ['Player_XP',0];
	[format ["UPDATE players SET level='%1', xp='%2' WHERE uid='%3'",_level,_xp,getPlayerUID _player],1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_Player_UpdatePaycheck",{
	private _player = param [0,objNull];
	private _paycheck = param [1,0];
	private _query = format ["UPDATE players SET paycheck='%1' WHERE uid='%2'",_paycheck,getPlayerUID _player];
	[_query,1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_Player_LocalityRequest", {
    private _obj = _this select 0;
    private _player = _this select 1;
    if (!((owner _obj) == (owner _player))) then {
        _obj setOwner (owner _player);
    };
}] call Server_Setup_Compile;

["Server_Player_Whitelist",{
	private _uid = param [0,""];
	private _faction = param [1,""];
	[format ["UPDATE players SET faction='%1' WHERE uid='%2'",_faction,_uid],1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_Player_AdminWatch",{
	private _watchID = param [0,""];
	private _uid = param [1,""];
	[format ["UPDATE players SET adminWatch='%1' WHERE uid='%2'",_watchID,_uid],1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;