/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Chopshop_Chop",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _cars = nearestObjects [player, ["Car","Plane","Air","Tank"], 20];
	private _car = _cars select 0;
	private _id = (_car getVariable ["owner",0]) select 1;

	if (_id IN ["WASTE","DELIVER","EXTERMINATOR","KARTING","ADMIN","ROADSIDE"]) exitWith {[localize"STR_CHOPSHOP_YOUCANTSELLVEHICLEBUSINESS", "red"] call A3PL_Player_Notification;};
	if(count _cars < 1) exitWith {[localize"STR_CHOPSHOP_NOCARNEARPOSITION", "red"] call A3PL_Player_Notification;};
	if (((_car getVariable ["owner",""]) select 0) isEqualTo (getPlayerUID player)) exitWith {[localize"STR_CHOPSHOP_YOUCANTSELLYOURVEHICLE", "red"] call A3PL_Player_Notification;};
	if (_car getVariable ["locked",true]) exitWith {[localize"STR_CHOPSHOP_NEARVEHICLENOTOPEN", "red"] call A3PL_Player_Notification;};
	if ((typeOf _car) isEqualTo "A3PL_CVPI_Rusty") exitWith {[localize"STR_CHOPSHOP_YOUCANTSELLTHISVEHICLE", "red"] call A3PL_Player_Notification;};

	[_car,player] remoteExec ["Server_Chopshop_Chop",2];
	[player,20] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;
