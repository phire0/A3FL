/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_JobFisherman_DeployNet",
{
	private ["_overwater","_a"];
	/*_fishingArea = ["A3PL_Marker_Fish1","A3PL_Marker_Fish2","A3PL_Marker_Fish3","A3PL_Marker_Fish4","A3PL_Marker_Fish5","A3PL_Marker_Fish6","A3PL_Marker_Fish7","A3PL_Marker_Fish8"];
	_canDeploy = false;
	{
		if((player inArea _x)) exitWith {
			_canDeploy = true;
		};
	} forEach _fishingArea;
	if (!_canDeploy) exitwith {
		["You are not in the deploy zone","red"] call A3PL_Player_Notification;
	};*/

	if (!(vehicle player == player)) exitwith {
		["You are inside a vehicle and cannot deploy a net","red"] call A3PL_Player_Notification;
	};

	_overwater = !(position player isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []);
	if (!(_overwater)) exitwith {
		["You are not in the water and cannot deploy a net","red"] call A3PL_Player_Notification;
	};

	/* Clean up any deleted buoys */
	{
		if(isNull _x) then {A3PL_FishingBuoy_Local deleteAt _forEachIndex;};
	} forEach A3PL_FishingBuoy_Local;

	if(count A3PL_FishingBuoy_Local >= 8) exitWith {
		["You have already deployed 8 nets!","red"] call A3PL_Player_Notification;
	};

	if(!(call A3PL_Player_AntiSpam)) exitWith {};

	A3PL_FishingBuoy_Local pushBack player_objIntersect;
	[player,player_objIntersect] remoteExec ["Server_JobFisherman_DeployNet", 2];
}] call Server_Setup_Compile;

["A3PL_JobFisherman_RetrieveNet",
{
	private ["_fishes","_buoy"];
	params[["_buoy",objNull,[objNull]]];

	if (isNull _buoy) exitwith {};

	_fishstate = _buoy getVariable ["fishstate",-1];
	if (_fishstate < 0) exitwith {
		["Error, unable to pickup this net","red"] call A3PL_Player_Notification;
	};

	if (_fishstate < 50) exitwith {
		_message = format["This net is only %1%2 full, wait until it's 100%2.",(_fishstate * 2),"%"];
		[_message,"red"] call A3PL_Player_Notification;
	};

	if(_buoy getVariable ["used",false]) exitWith {
		["Buoy already collected","red"] call A3PL_Player_Notification;
	};

	if(!(call A3PL_Player_AntiSpam)) exitWith {};

	_buoy setVariable ["used",true,true];
	[player, 3] call A3PL_Level_AddXP;
	[player,_buoy] remoteExec ["Server_JobFisherman_GrabNet",2];
}] call Server_Setup_Compile;

["A3PL_JobFisherman_DeployNetSuccess",
{
	[4] call A3PL_JobFisherman_DeployNetResponse;
}] call Server_Setup_Compile;

["A3PL_JobFisherman_DeployNetResponse",
{
	private ["_r"];
	_r = param [0,1];

	switch _r do
	{
		case 0: {["You don't have a bucket to store the fish in","red"] call A3PL_Player_Notification;};
		case 1: {["An error occured on the server, unable to retrieve net","red"] call A3PL_Player_Notification;};
		case 2: {["You don't seem to have a net to deploy","red"] call A3PL_Player_Notification;};
		case 3: {["You picked up the net and received a bucket of fish","green"] call A3PL_Player_Notification;};
		case 4: {["You succesfully deployed a net","green"] call A3PL_Player_Notification;};
		case 5: {["You picked up the net and received a bucket of fish and a mullet you can use for shark/turtle fishing!","green"] call A3PL_Player_Notification;};
		case 6: {["You picked up the net and received a bucket of fish, with the mullet as bait you also caught a catshark!","green"] call A3PL_Player_Notification;};
		case 7: {["You picked up the net and received a bucket of fish, your mullet as bait caught a shark but the shark escaped!","green"] call A3PL_Player_Notification;};
		case 8: {["You picked up the net and received a bucket of fish, your mullet as bait caught a turtle but it escaped!","green"] call A3PL_Player_Notification;};
		case 9: {["You picked up the net and received a bucket of fish, your mullet as bait caught an ILLEGAL turtle","green"] call A3PL_Player_Notification;};
	};
}] call Server_Setup_Compile;

["A3PL_JobFisherman_Bait",
{
	private ["_buoy","_bait"];
	_buoy = param [0,objNull];
	_bait = "none";

	if (!(["mullet",1] call A3PL_Inventory_Has)) exitwith {["You don't have a mullet to bait this net with!","red"] call A3PL_Player_Notification;};

	switch (true) do
	{
		case ((player inArea "A3PL_Marker_Fish3") OR (player inArea "A3PL_Marker_Fish6") OR (player inArea "A3PL_Marker_Fish7")): {_bait = "shark"};
		case (player inArea "A3PL_Marker_Fish5"): {_bait = "turtle"};
	};

	if (_bait == "none") exitwith {["Bait can only be used in a shark or turtle area to catch shark or turtle","red"] call A3PL_Player_Notification;};

	if ((_buoy getVariable ["bait","none"]) == "none") then
	{
		["mullet",-1] call A3PL_Inventory_Add;
		_buoy setVariable ["bait",_bait,true];
		["You succesfully baited this net with a mullet","green"] call A3PL_Player_Notification;
	} else
	{
		["This net is already baited","red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;
