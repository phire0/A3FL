/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Fire_StartFire",
{
	private _position = param [0,[]];
	private _dir = windDir;
	[_position,_dir] remoteExec ["Server_Fire_StartFire", 2];
}] call Server_Setup_Compile;

["A3PL_Fire_Matches",
{
	if (player_itemClass != "matches") exitwith {[localize"STR_NewFire_NoMatches","red"] call A3PL_Player_Notification;};

	private _fifr = ["fifr"] call A3PL_Lib_FactionPlayers;
	if ((count(_fifr)) < 5) exitwith {[localize"STR_NewFire_5FIFRMatches","red"] call A3PL_Player_Notification;};
	
	private _matches = Player_Item;
	[player_itemClass,-1] call A3PL_Inventory_Add;
	Player_Item = objNull;
	Player_ItemClass = '';
	deleteVehicle _matches;

	[getPosATL player] call A3PL_Fire_StartFire;
	[getPlayerUID player,"startedFire",[getPosATL player]] remoteExec ["Server_Log_New",2];
	
	private _marker = createMarker [format ["fire_%1",random 4000], position player];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "A3PL_Markers_FIFD";
	_marker setMarkerText "FIRE";
	_marker setMarkerColor "ColorWhite";
	
	[localize"STR_NewFire_AlertFire","red","fifr",3] call A3PL_Lib_JobMessage;
	["A3PL_Common\effects\firecall.ogg",150,2,10] spawn A3PL_FD_FireStationAlarm;
	
	uiSleep 600;
	deleteMarker _marker;
}] call Server_Setup_Compile;