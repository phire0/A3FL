/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Locker_Rent",
{
	private _locker = _this select 0;
	[_locker, player] remoteExec ["Server_Locker_Insert", 2];
}] call Server_Setup_Compile;

["A3PL_Locker_Sell",
{
	private _locker = _this select 0;
	[_locker, player] remoteExec ["Server_Locker_Sell", 2];
}] call Server_Setup_Compile;