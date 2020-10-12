/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Karts_Rent",
{
	if ((player getVariable ["job","unemployed"]) == "KARTING") exitwith {[localize"STR_KART_KARTLOCATIONSTOP","red"]; call A3PL_NPC_LeaveJob};
	if (!(player inArea "A3PL_Marker_SallySpeedway")) exitwith {[localize"STR_KART_KARTLOCATIONTELEPORT"] call A3PL_Player_Notification;};
	player setVariable ["job","karting"];
	["C_Kart_01_F",(getpos player),"KARTING","A3PL_Marker_SallySpeedway"] spawn A3PL_Lib_JobVehicle_Assign;
	[localize"STR_KART_KARTLOCATIONSTART","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
