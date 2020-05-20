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
	private ["_r","_crateArray","_modelpos","_x","_y","_nearPlayers","_nearVeh"];
	_crateArray = attachedObjects ship_blackmarket;
	_r = round (random 1);
	_modelPos = [];

	//near check
	_nearPlayers = nearestObjects [ship_blackmarket,["C_man_1"],200];
	{
		if (!(isPlayer _x)) then
		{
			_nearPlayers = _nearPlayers - [_x];
		};
	} foreach _nearPlayers;

	if (count _nearPlayers > 0) exitwith {};

	if (_r == 1) then
	{
		_x = round (random 14000);
		_y = round (random 4000);
	} else
	{
		_x = round (random 14000);
		_y = (round (random 5100)) + 9600;
	};

	if(!surfaceIsWater [_x,_y,0]) exitWith {[] call Server_Criminal_BlackMarketPos;};

	ship_blackmarket setposASL [_x,_y,((getposASL ship_blackmarket) select 2)];

	//set move waypoint
	Driver_BlackMarket move ([Ship_BlackMarket, 3500, random 360] call BIS_fnc_relPos);
},true] call Server_Setup_Compile;

["Server_Criminal_BlackMarketNear",
{
	private ["_near","_nearObjects","_nearPlayers","_nearVeh"];
	_near = nearestObjects [ship_blackmarket,["man"],200];
	_nearPlayers = [];
	{
		if ((alive _x) && (isPlayer _x)) then
		{
			_nearPlayers pushback _x;
		};
	} foreach _near;
	_nearVeh = nearestObjects [ship_blackmarket,["Ship"],70];
	_nearVeh = _nearVeh - [ship_blackMarket];
	{
		if ((count (crew _x)) >= 1) then
		{
			_nearPlayers pushback _x;
		};
	} foreach _nearVeh;

	if ((count _nearPlayers) > 0) then
	{
		//Driver_BlackMarket stop true;
		Driver_BlackMarket disableAI "ALL";
		Ship_BlackMarket disableAI "ALL";
		Ship_BlackMarket setVelocity [0,0,0];
	} else
	{
		//Driver_BlackMarket stop false;
		Ship_BlackMarket enableAI "ALL";
		Driver_BlackMarket enableAI "ALL";
	};
},true] call Server_Setup_Compile;
