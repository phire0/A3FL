/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_DMV_Open",
{
	disableSerialization;
	private ["_display","_control","_nearPlayers"];
	createDialog "Dialog_DMV";
	_display = findDisplay 21;
	_control = _display displayCtrl 1500;

	//fill player list
	_nearPlayers = [];
	{
		if ((player distance _x) < 10 && (getPlayerUID _x) != (getPlayerUID player)) then {_nearPlayers pushback _x};
	} foreach allPlayers;
	{
		_index = _control lbAdd (format ["%1",(_x getVariable ["name",(name _x)])]);
		_control lbSetData [_index,(getPlayerUID _x)];
	} foreach _nearPlayers;

	//lb player list changed eh
	_control ctrlAddEventHandler ["LBSelChanged",{_this call A3PL_DMV_LBChanged;}];

	//Button eventhandler
	_control = _display displayCtrl 1600;
	_control ctrlAddEventHandler ["ButtonDown",{[true] call A3PL_DMV_Add;}];
	_control = _display displayCtrl 1601;
	_control ctrlAddEventHandler ["ButtonDown",{[false] call A3PL_DMV_Add;}];

	//licenses that can be added
	_control = _display displayCtrl 2100;
	_pJob = player getVariable ["job","unemployed"];
	{
		private _id = _x select 0;
		private _name = _x select 1;
		private _type = _x select 2;
		private _canIssue = _x select 3;
		private _canRevoke = _x select 4;
		if((_pJob IN _canIssue) || {_pJob IN _canRevoke}) then {
			if(_type) then {
				_index = _control lbAdd format["%1 (Company)",_name];
				_control lbSetData [_index,_id];
				_control lbSetValue [_index, parseNumber _type];
			} else {
				_index = _control lbAdd format["%1 (Individual)",_name];
				_control lbSetData [_index,_id];
				_control lbSetValue [_index, parseNumber _type];
			};
		};
	} foreach Config_Licenses;
}] call Server_Setup_Compile;

["A3PL_DMV_LBChanged",
{
	private ["_display","_control","_index"];
	_display = findDisplay 21;
	_control = param [0,ctrlNull];
	_index = param [1,-1];
	_player = [(_control lbData _index)] call A3PL_Lib_UIDToObject;
	if (_index < 0) exitwith {};
	if (isNull _player) exitwith {};

	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		_control lbAdd format ["%1",([_x,"name"] call A3PL_Config_GetLicense)];
	} foreach (_player getVariable ["licenses",[]]);
}] call Server_Setup_Compile;

//[player,'driver',true] remoteExec ["Server_DMV_Add",2];
["A3PL_DMV_Add",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _add = param [0,true];
	private _display = findDisplay 21;
	private _control = _display displayCtrl 1500;
	private _index = lbCurSel _control;
	if (_index < 0) exitwith {[localize"STR_DMV_SELECTIONPLAYER","red"] call A3PL_Player_Notification;};
	private _target = [(_control lbData _index)] call A3PL_Lib_UIDToObject;
	if (isNull _target) exitwith {[localize"STR_DMV_LICENSENOTFOUND","red"] call A3PL_Player_Notification;};

	private _control = _display displayCtrl 2100;
	if ((lbCurSel _control) < 0) exitwith {[localize"STR_DMV_SELECTIONLICENSE","red"] call A3PL_Player_Notification;};
	private _isCompany = (_control lbValue (lbCurSel _control)) IsEqualTo 1;
	private _inCompany = [getPlayerUID _target] call A3PL_Config_InCompany;
	if (_isCompany && (!_inCompany)) exitWith {[localize"STR_DMV_LICNOTCOMP","red"] call A3PL_Player_Notification;};	

	private _license = _control lbData (lbCurSel _control);
	private _unable = false;
	private _canIssue = [_license,"canIssue"] call A3PL_Config_GetLicense;
	private _canRevoke = [_license,"canRevoke"] call A3PL_Config_GetLicense;
	private _pJob = player getVariable["job","unemployed"];
	
	if(_add && {!(_pJob IN _canIssue)}) exitWith {["You can only revoke this license","red"] call A3PL_Player_Notification;};
	if(!_add && {_pJob IN _canIssue}) exitWith {["You can only issue this license","red"] call A3PL_Player_Notification;};

	if(!_isCompany) then {
		private _licenses = _target getVariable ["licenses",[]];
		if (_add) then {
			if (_license in _licenses) then {_unable = true;};
		} else {
			if (!(_license in _licenses)) then {_unable = true;};
		};
		if (_unable) exitwith {[localize"STR_DMV_ERRORLICENSEALREADYEXIST","red"] call A3PL_Player_Notification;};
		[_target,_license,_add] remoteExec ["Server_DMV_Add",2];
		if (_add) then {
			[format [localize"STR_DMV_GIVELICENSE",_target getVariable ["name",(name _target)],[_license,"name"] call A3PL_Config_GetLicense],"green"] call A3PL_Player_Notification;
		} else {
			[format [localize"STR_DMV_REVOKELICENSE",_target getVariable ["name",(name _target)],[_license,"name"] call A3PL_Config_GetLicense],"green"] call A3PL_Player_Notification;
		};
	} else {
		private _cid = [getPlayerUID _target] call A3PL_Config_GetCompanyID;
		[_cid,_license,_add] remoteExec ["Server_Company_SetLicenses",2];
		if (_add) then {
			[format [localize"STR_DMV_GIVELICENSECOMP",_target getVariable ["name",(name _target)],[_license,"name"] call A3PL_Config_GetLicense],"green"] call A3PL_Player_Notification;
		} else {
			[format [localize"STR_DMV_REVOKELICENSECOMP",_target getVariable ["name",(name _target)],[_license,"name"] call A3PL_Config_GetLicense],"green"] call A3PL_Player_Notification;
		};
	};
}] call Server_Setup_Compile;

["A3PL_DMV_Check", {
	private _license = param [0,"driver"];
	private _player = param [1,player];
	private _plicenses = _player getVariable ["licenses",[]];
	if (_license IN _plicenses) then {true;} else {false;};
}] call Server_Setup_Compile;

["A3PL_DMV_StartTest",{
	if(player getVariable['player_cash',0] < 500) exitWith {['You do not have enough money for the driving test!','red'] call A3PL_Player_Notification;};
	if(['driver'] call A3PL_DMV_Check) exitWith {['You already have a driving license!','red'] call A3PL_Player_Notification;};
	['dmv_drivingtest1'] call A3PL_NPC_Start;
	_cash = player getVariable ['player_cash',0];
	player setVariable ['player_cash',(_cash - 500),true];
	["Federal Reserve",500] remoteExec ["Server_Government_AddBalance",2];
}] call Server_Setup_Compile;

["A3PL_DMV_StartTest2",{
	if(player getVariable['player_cash',0] < 2500) exitWith {['You do not have enough money for the commercial driving test!','red'] call A3PL_Player_Notification;};
	if(['cdl'] call A3PL_DMV_Check) exitWith {['You already have a driving license!','red'] call A3PL_Player_Notification;};
	['dmv_cdltest1'] call A3PL_NPC_Start;
	_cash = player getVariable ['player_cash',0];
	player setVariable ['player_cash',(_cash - 2500),true];
	["Federal Reserve",500] remoteExec ["Server_Government_AddBalance",2];
}] call Server_Setup_Compile;

["A3PL_DMV_StartTest3",{
	if(player getVariable['player_cash',0] < 10000) exitWith {['You do not have enough money for the motorcycle test!','red'] call A3PL_Player_Notification;};
	if(['motorcycle'] call A3PL_DMV_Check) exitWith {['You already have a driving license!','red'] call A3PL_Player_Notification;};
	['dmv_motorcycletest1'] call A3PL_NPC_Start;
	_cash = player getVariable ['player_cash',0];
	player setVariable ['player_cash',(_cash - 10000),true];
	["Federal Reserve",500] remoteExec ["Server_Government_AddBalance",2];
}] call Server_Setup_Compile;