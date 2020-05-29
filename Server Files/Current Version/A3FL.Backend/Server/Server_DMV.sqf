/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_DMV_Add",
{
	private _target = param [0,objNull];
	private _uid = getPlayerUID _target;
	private _license = param [1,"driver"];
	private _add = param [2,true];
	private _licenses = _target getVariable ["licenses",[]];
	if (_add) then {
		if (!(_license IN _licenses)) then {
			_licenses pushback _license;
			[format[localize "STR_SERVER_DMV_ISSUEDLICENSE",[_license,"name"] call A3PL_Config_GetLicense], "green"] remoteExec ["A3PL_Player_Notification",_target];
			[_uid,"license_add",_license] call Server_Log_New;
		};
	} else {
		if (_license IN _licenses) then {
			_licenses = _licenses - [_license];
			[format[localize "STR_SERVER_DMV_REVOKEDLICENSE",[_license,"name"] call A3PL_Config_GetLicense], "red"] remoteExec ["A3PL_Player_Notification",_target];
			[_uid,"license_revoke",_license] call Server_Log_New;
		};
	};
	_target setVariable ["licenses",_licenses,true];
	private _query = format ["UPDATE players SET licenses='%2' WHERE uid ='%1'",_uid,([_licenses] call Server_Database_Array)];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;