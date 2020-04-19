["A3PL_Locker_Rent",
{
	private _locker = _this select 0;
	private _lockerPrice = 9000;
	private _playerCash = player getVariable["Player_Cash",0];
	if(_lockerPrice > _playerCash) exitWith {[format[localize "STR_INTSECT_LOCKERNEEDMONEY",_lockerPrice-_playerCash], "red"] call A3PL_Player_Notification;};
	player setVariable ["Player_Cash",(_playerCash - _lockerPrice),true];
	_locker setVariable["owner",getPlayerUID player,true];
	[_locker, player] remoteExec ["Server_Locker_Insert",2];
	[format[localize "STR_INTSECT_LOCKERBOUGHT",_lockerPrice], "green"] call A3PL_Player_Notification;
	["Federal Reserve",_lockerPrice] remoteExec ["Server_Government_AddBalance",2];
}] call Server_Setup_Compile;