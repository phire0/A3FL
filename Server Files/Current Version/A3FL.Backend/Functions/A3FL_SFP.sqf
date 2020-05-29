/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_SFP_SignOn",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};

	if (!(["sfp",player] call A3PL_DMV_Check)) exitwith {[localize"STR_SFP_License","red"] call A3PL_Player_Notification;};

	if ((player getVariable ["job","unemployed"]) == "security") exitwith {[localize"STR_SFP_QuitJob","red"]; call A3PL_NPC_LeaveJob};
	player setVariable ["job","security"];
	[localize"STR_SFP_JobJoin","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_SFP_CheckIn",
{
	private ["_store"];
	_store = param [0,objNull];

	if(_store getVariable ["checkinCooldown",false]) exitWith{[localize"STR_SFP_Secure","red"];};
	_store setVariable ["checkinCooldown",true];

	player setVariable ["player_cash",(player getVariable ["player_cash",0]) + 200,true];
	[localize"STR_SFP_SecureOK","green"] call A3PL_Player_Notification;
	[player, 8] call A3PL_Level_AddXP;
	uiSleep 600;
	_store setVariable ["checkinCooldown",false];
}] call Server_Setup_Compile;