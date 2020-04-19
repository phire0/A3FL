["A3PL_Level_AddXP", {
	private _player = param [0,objNull];
	private _toAdd = param [1,0];
	private _currentLevel = _player getvariable 'Player_Level';
	private _currentXP = _player getVariable 'Player_XP';
	private _nextLevelXP = [_currentLevel, 'next'] call A3PL_Config_GetLevel;
	if(_toAdd >= (_nextLevelXP - _currentXP)) then {
		_player setVariable['Player_Level',_currentLevel + 1,true];
		_player setVariable['Player_XP',0,true];
		[format[localize"STR_LEVEL_LevelUpgrade",_currentLevel + 1],"green"] call A3PL_Player_Notification;
		_loop = _toAdd - (_nextLevelXP - _currentXP);
		[_player, _loop] spawn A3PL_Level_AddXP;
	} else {
		_toAdd = _toAdd * A3PL_Event_DblXP;
		_player setVariable['Player_XP',_currentXP + _toAdd,true];
		if(_toAdd != 0) then {
			[format[localize"STR_LEVEL_ExpUpgrade",_toAdd],"green"] call A3PL_Player_Notification;
		};
		_Level = _player getvariable 'Player_Level';
		_XP = _player getVariable 'Player_XP';
		[_player] remoteExec ["Server_Player_Level_Save", 2];
	};
}] call Server_Setup_Compile;

["A3PL_Level_Boost", {
	private ["_level","_coeff"];
	_level = player getVariable["Player_Level",0];
	_coeff = _level / 100;
	_coeff;
}] call Server_Setup_Compile;