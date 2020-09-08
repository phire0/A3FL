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

["Server_Criminal_BlackMarketPos",
{
	private _areas = ["blacksea_1","blacksea_2","blacksea_3","blacksea_4"];
	private _area = _areas select (floor (random (count _areas)));
	private _pos = [_area] call CBA_fnc_randPosArea;
	private _pos = _pos findEmptyPosition [0, 25,(typeOf Ship_Blackmarket)];
	if ((count _pos) isEqualTo 0) exitwith {call Server_Criminal_BlackMarketPos};
	private _nearPlayers = nearestObjects [Ship_Blackmarket,["C_man_1"],200];
	{
		if (!(isPlayer _x)) then {
			_nearPlayers = _nearPlayers - [_x];
		};
	} foreach _nearPlayers;
	if ((count _nearPlayers) > 0) exitwith {};
	if(!surfaceIsWater _pos) exitWith {call Server_Criminal_BlackMarketPos;};
	Ship_Blackmarket setPosASL [(_pos select 0),(_pos select 1),((getposASL ship_blackmarket) select 2)];
},true] call Server_Setup_Compile;

["Server_Criminal_ShipCaptured", {
	Ship_BlackMarket setVariable["captured",true,true];
	sleep 600;
	Ship_BlackMarket setVariable["captured",false,true];
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
		["Springfield",[[8677.95,6458.34,0.00143862,275],[8673.65,6504.24,0.00143862,275],[9006.26,6512.88,0.00143909,275],[8938.83,6588.38,0.00143909,75],[8923.08,6629.81,0.00143909,181]]],
		["Elk City",[[6012.36,7321.21,0.00143909,207],[6051.72,7312.92,0.0014286,302],[6077.33,7394.32,0.00143909,173],[6082.57,7470.16,0.00143814,301],[6062.67,7468.83,0.00143909,301]]],	
		["Boulder City",[[6975.8,7010.36,0.00116158,161],[6916.85,7132.77,0.00144672,148],[6977.97,7127.71,0.00143909,149],[7119.89,7204.71,0.00143862,62],[7147.7,7223.39,0.00143909,240]]],
		["Silverton",[[2488.87,5491.06,0.00143909,218],[2722.26,5560,0.00157595,40],[2711.38,5454.09,0.00143957,200],[2376.85,5433.08,0.00143862,0],[2426.47,5555.59,0.00143862,304]]],
		["Beach Valley",[[4132.32,6139.89,0.00143909,75],[4134.36,6326.75,0.00143909,180],[4167.45,6356.76,0.00143909,87],[4167.34,6344.61,0.00143862,87],[4274.41,6214.34,0.00143862,269]]],
		["Stony Creek",[[3549.65,7489.45,0.00147152,32],[3480.85,7473.86,0.00143886,188],[3470.38,7472.54,0.00143886,188],[3480.99,7731.68,0.0014379,180],[3679.2,7527.47,0.00135922,241]]],
		["Lubbock",[[2122.17,11645.5,0.00143862,0],[2126.94,11662.6,0.00143886,0],[2162.97,11714.5,0.00143886,1],[2236.56,11782.1,0.00143886,57],[2216.82,11946.8,0.00143886,275]]],
		["Salt Point",[[3204.99,12333.2,0.00143898,277],[3224.68,12284.8,0.00143898,177],[3461.07,12253.6,0.00141764,92],[3461.31,12270.3,0.0014081,92],[3319.47,12532.4,0.001441,180]]]
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