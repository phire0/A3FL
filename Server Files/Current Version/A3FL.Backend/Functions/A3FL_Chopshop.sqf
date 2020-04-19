["A3PL_Chopshop_Chop",
{
	private ["_car","_cars"];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	_cars = nearestObjects [player, ["Car"], 10];
	_car = _cars select 0;
	_id = _car getVariable "owner" select 1;

	if (_id IN ["WASTE","DELIVER","EXTERMINATOR","KARTING","DMV","ADMIN","ROADSIDE"]) exitWith {[localize"STR_CHOPSHOP_YOUCANTSELLVEHICLEBUSINESS", "red"] call A3PL_Player_Notification;};

	if(count _cars < 1) exitWith {[localize"STR_CHOPSHOP_NOCARNEARPOSITION", "red"] call A3PL_Player_Notification;};
	if (((_car getVariable "owner") select 0) == (getPlayerUID player)) exitWith {[localize"STR_CHOPSHOP_YOUCANTSELLYOURVEHICLE", "red"] call A3PL_Player_Notification;};
	if (_car getVariable ["locked",true]) exitWith {[localize"STR_CHOPSHOP_NEARVEHICLENOTOPEN", "red"] call A3PL_Player_Notification;};
	if (typeOf _car == "A3PL_CVPI_Rusty") exitWith {[localize"STR_CHOPSHOP_YOUCANTSELLTHISVEHICLE", "red"] call A3PL_Player_Notification;};

	[_car,player] remoteExec ["Server_Chopshop_Chop",2];
	[player,20] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;
