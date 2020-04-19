["Server_JobRoadWorker_Mark",
{
	private _veh = param [0,objNull];
	if (isNull _veh) exitwith {};
	_veh setVariable ["impound",true,true];
	private _roadworkers = ["Roadside",true] call A3PL_Lib_FactionPlayers;
	Server_JobRoadWorker_Marked pushback _veh;
	publicVariable "Server_JobRoadWorker_Marked";
	[_veh] remoteExec ["A3PL_JobRoadWorker_MarkResponse", _roadworkers];
},true] call Server_Setup_Compile;

["Server_JobRoadWorker_UnMark",
{
	private _veh = param [0,objNull];
	if (isNull _veh) exitwith {};
	_veh setVariable ["impound",nil,true];
	if (_veh IN Server_JobRoadWorker_Marked) then {
		Server_JobRoadWorker_Marked = Server_JobRoadWorker_Marked - [_veh];
		publicVariable "Server_JobRoadWorker_Marked";
	};
},true] call Server_Setup_Compile;

["Server_JobRoadWorker_Impound",
{
	private _veh = param [0,objNull];
	private _player = param [1,objNull];
	private _cash = 2000;
	if (((_veh getVariable "owner") select 0) != (getPlayerUID _player)) then {
		[format[localize"STR_SERVER_ROAD_PAY",_cash],"green"] remoteExec ["A3PL_Player_Notification",_player];
		[_player,"Player_Cash",((_player getVariable ["player_cash",0]) + _cash)] call Server_Core_ChangeVar;
	};
	[_veh] call Server_Police_Impound;
},true] call Server_Setup_Compile;