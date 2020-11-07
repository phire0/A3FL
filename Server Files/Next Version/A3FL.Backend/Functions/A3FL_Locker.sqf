/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Locker_Rent_Receive",
{
	params[
		["_player", objNull, [objNull]]
		["_locker", objNull, [objNull]]
		["_ownsLocker", false, [true]]
	];

	if (_ownsLocker) exitWith {
		["You already own a locker", "red"] call A3PL_Player_Notification;
	};

	private _lockerPrice = 10000;
	private _playerCash = player getVariable["Player_Bank",0];
	
	if(_lockerPrice > _playerCash) exitWith {[format[localize "STR_INTSECT_LOCKERNEEDMONEY",_lockerPrice-_playerCash], "red"] call A3PL_Player_Notification;};
	
	player setVariable ["Player_Bank",(_playerCash - _lockerPrice),true];
	_locker setVariable["owner",getPlayerUID player,true];
	
	[_locker, player] remoteExec ["Server_Locker_Insert",2];
	
	[format[localize "STR_INTSECT_LOCKERBOUGHT",_lockerPrice], "green"] call A3PL_Player_Notification;
	
	["Federal Reserve",_lockerPrice] remoteExec ["Server_Government_AddBalance",2];
	[getPlayerUID player,"BuyLocker",[]] remoteExec ["Server_Log_New",2];

}] call Server_Setup_Compile;

["A3PL_Locker_Rent",
{
	params[
		["_locker", objNull, [objNull]]
	];

	[player, _locker] remoteExec ["Server_Locker_OwnsLocker", 2];
}] call Server_Setup_Compile;