/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Shrooms_Loop",
{
	private _shrooms = nearestObjects [(getMarkerPos "Shroom_Picking"), ["A3FL_Mushroom"], 40, true];
	private _shroomsCount = count nearestObjects [(getMarkerPos "Shroom_Picking"), ["A3FL_Mushroom"], 40, true];
	private _players = count ((getMarkerPos "Shroom_Picking") nearEntities ["Man", 50]);
	if (_players < 1 && _shroomsCount > 0) then {
		{
			deleteVehicle _x;
		} foreach _shrooms;
	} else {
		if (_players > 0 && _shroomsCount < 15) then {
			private _amountToSpawn = 5 + (round random 3);
			for "_i" from 1 to (_amountToSpawn-_shroomsCount) do
			{
				private _randPos = ["Shroom_Picking"] call CBA_fnc_randPosArea;
				private _shroom = createVehicle ["A3FL_Mushroom", _randPos, [], 0, "CAN_COLLIDE"];
				_shroom enableSimulationGlobal false;
				_shroom setVariable ["class","shrooms",true];
				_shroom setDir (random 360);
			};
		};
	};
},true] call Server_Setup_Compile;

// 1 - South of go karting
// 2 - Civ shooting range
// 3 - south of race track
// 4 - Church at steel mill
// 5 - Port on new island
["Server_Shrooms_MoveMarker",
{
	private _markerArea = "Shroom_Picking";
	private _markerLabel = "Shrooms_Field";
	private _locations = [[7403,6286],[10327,7839],[4014,5459],[4300,6945],[2295,12000]];
	private _currentLocation = missionNamespace getVariable ["MushroomAreaLocation",0];
	private _nextLocation = selectRandom _locations;
	if((_nextLocation find _locations) isEqualTo _currentLocation) exitWith {[] spawn Server_Shrooms_MoveMarker;};
	_markerArea setMarkerPos _nextLocation;
	_markerLabel setMarkerPos _nextLocation;
	missionNamespace setVariable ["MushroomAreaLocation",(_locations find _nextLocation)];
	[] remoteExec["A3PL_Player_SetMarkers",-2];
},true] call Server_Setup_Compile;
