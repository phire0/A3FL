/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/
//deleteMarker "Server_Events_ShipWreck"; Server_Events_Current = nil; call Server_Events_Random
["Server_Events_Random",
{
	private _allEvents = [
		Server_Events_ShipWreck
	];
	if(!isNil "Server_Events_Current") exitWith {};

	[] spawn (selectRandom _allEvents);
},true] call Server_Setup_Compile;

["Server_Events_Start",
{
	private _eventName = param[0,""];
	Server_Events_Current = _eventName;
},true] call Server_Setup_Compile;

["Server_Events_End",
{
	Server_Events_Current = nil;
},true] call Server_Setup_Compile;

["Server_Events_ShipWreck",
{
	["Ship Wreck"] call Server_Events_Start;
	["ALERT! ALERT! A shipwreck has been detected in the waters of Fishers Island! Go and try to recover it's content!","yellow"] remoteExec ["A3PL_Player_Notification", -2];
	private _eventDuration = 30*60;
	private _wreckArray = ["Land_Boat_06_wreck_F","Land_Wreck_Traw2_F","Land_Wreck_Traw_F","Land_UWreck_FishingBoat_F"];
	private _lootArray = [];
	private _posArray = [[11641.9,11825.5,0],[7551.55,10823.9,0],[506.756,9011.15,0],[1277.59,3179.49,0],[6526.55,4337.69,0],[9980.81,7063.11,0],[10721.6,3939.42,0],[6533.32,7144.09,0]] call BIS_fnc_selectRandom;

	private _marker = createMarker ["Server_Events_ShipWreck", _posArray];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "A3PL_Markers_USCG";
	_marker setMarkerText " SHIP WRECK LOCATED";
	_marker setMarkerColor "ColorWhite";

	private _wreck = (_wreckArray call BIS_fnc_selectRandom) createVehicle _posArray;
	_wreck allowDamage false;
	_wreck setDir (random 359);

	private _boxPos = [(_posArray select 0) - random 15,(_posArray select 1) + random 10,_posArray select 2];
	private _itemBox = "B_supplyCrate_F" createVehicle _boxPos;
	_itemBox allowDamage false;
    _itemBox setDir (90);

    sleep _eventDuration;

	deleteVehicle _itembox;
	deleteVehicle _wreck;
	deleteMarker _marker;
	call Server_Events_End;
	["The shipwreck has been recovered!","yellow"] remoteExec ["A3PL_Player_Notification", -2];
},true] call Server_Setup_Compile;