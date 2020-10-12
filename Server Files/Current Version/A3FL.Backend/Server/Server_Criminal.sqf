/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Criminal_RemoveJail", {
	private _player = param [0,objNull];
	private _query = format ["UPDATE players SET jail='0' WHERE uid = '%1'", getPlayerUID _player];
	private _return = [_query, 1] call Server_Database_Async;
	{
		if((_x select 0) isEqualTo _player) exitwith {
			Server_Jailed_Players deleteAt _forEachIndex;
		};
	} foreach Server_Jailed_Players;
},true] call Server_Setup_Compile;

["Server_Criminal_TurtlesMove",
{
	private _markerArea = "A3PL_Marker_Fish5";
	private _markerLabel = "Fishing5";
	private _locations = [[6878,12890],[1406,2095],[7326,3808],[1421,13334]];
	private _currentLocation = missionNamespace getVariable ["TurtleAreaLocation",0];
	private _nextLocation = selectRandom _locations;
	if((_nextLocation find _locations) isEqualTo _currentLocation) exitWith {[] spawn Server_Criminal_TurtlesMove;};
	_markerArea setMarkerPos _nextLocation;
	_markerLabel setMarkerPos _nextLocation;
	missionNamespace setVariable ["TurtleAreaLocation",(_locations find _nextLocation)];
	[] remoteExec["A3PL_Player_SetMarkers",-2];
},true] call Server_Setup_Compile;

["Server_Criminal_MoveNPCs",
{
	private _npcs = [npc_ill_trader,npc_ill_moonshine,npc_ill_cocaine,npc_ill_shrooms,npc_ill_weed];
	private _locations = [
		["Northdale",[[10216.7,8721.46,0.00143909,87],[9959.04,8649.18,0.00143909,89],[10111.1,8772.97,0.00143957,90]]],
		["Deadwood",[[9881.59,7811.93,0.00143957,174],[9885.51,7793.14,0.00142431,88]]],
		["Springfield",[[8677.95,6458.34,0.00143862,275],[8673.65,6504.24,0.00143862,275],[8938.83,6588.38,0.00143909,75],[8923.08,6629.81,0.00143909,181]]],
		["Elk City",[[6051.72,7312.92,0.0014286,302],[6077.33,7394.32,0.00143909,173],[6071.47,7461.49,0.00143862,120]]],
		["Boulder City",[[6916.85,7132.77,0.00144672,148],[7119.89,7204.71,0.00143862,62],[7147.7,7223.39,0.00143909,240]]],
		["Silverton",[[2638.02,5596.66,0.00144958,292],[2644.61,5536.74,0.00143862,307],[2455.08,5535.31,0.00143719,204],[2512.13,5604.48,0.00143909,233]]],
		["Beach Valley",[[4132.32,6139.89,0.00143909,75],[4134.36,6326.75,0.00143909,180]]],
		["Stony Creek",[[3549.65,7489.45,0.00147152,32],[3470.38,7472.54,0.00143886,188]]],
		["Lubbock",[[2162.97,11714.5,0.00143886,1],[2236.56,11782.1,0.00143886,57],[2216.82,11946.8,0.00143886,275]]],
		["Salt Point",[[3204.99,12333.2,0.00143898,277],[3224.68,12284.8,0.00143898,177],[3319.47,12532.4,0.001441,180]]]
	];
	private _usedTown = [];
	{
		private _selectedTown = (_locations call BIS_fnc_selectRandom);
		while{(_selectedTown select 0) IN _usedTown} do {
			_selectedTown = (_locations call BIS_fnc_selectRandom);
		};
		_usedTown pushback (_selectedTown select 0);
		_newPosition = (_selectedTown select 1) call BIS_fnc_selectRandom;
		_x setPos [_newPosition select 0,_newPosition select 1,_newPosition select 2];
		_x setDir (_newPosition select 3);
	} foreach _npcs;
},true] call Server_Setup_Compile;