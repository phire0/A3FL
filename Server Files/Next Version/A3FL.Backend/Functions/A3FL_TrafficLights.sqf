/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_TrafficLights_Break",
{
	private _terrainobj = nearestTerrainObjects [[2716.79,5477.64,0], [], 10000, false];
	private _trafficlight = _terrainobj select {typeOf _x in ["Land_A3FL_TrafficLight_A","Land_A3FL_TrafficLight_B"]};

	private ["_rand","_objet","_objects"];
	for "_i" from 0 to 1 step 0 do {
		_rand = 100;
		
		if (_rand <= 70) then {
			_objet = selectRandom _trafficlight;
			_objects = nearestObjects [_objet, ["Land_A3FL_TrafficLight_A","Land_A3FL_TrafficLight_B"], 55, true];

			{
				_x setVariable ["A3FL_LightBroken",true];
			} forEach _objects;
		};
		uiSleep 1800;
	};
}] call Server_Setup_Compile;

["A3PL_TrafficLights_Repair",
{
	params [["_trafficlight",objNull,[objNull]]];
	if (isNull _trafficlight) exitWith {};

	if (!(vehicle player == player)) exitwith {["You cannot repair in a vehicle", "red"] call A3PL_Player_Notification;};
	if (Player_ActionDoing) exitwith {["You are already performing an action","red"] call A3PL_Player_Notification;};

	["Traffic light reparation",50] spawn A3PL_Lib_LoadAction;
	_success = true;
	waitUntil{Player_ActionDoing};
	player playMoveNow 'Acts_carFixingWheel';
	while {Player_ActionDoing} do {
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if ((vehicle player) != player) exitWith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
	};
	if(Player_ActionInterrupted || !_success) exitWith {
		_trafficlight setVariable ["A3FL_LightBroken",true];
		["Action cancelled","red"] call A3PL_Player_Notification;
	};

	["You repaired the traffic light","green"] call A3PL_Player_Notification;
	_trafficlight setVariable ["A3FL_LightBroken",false];
}] call Server_Setup_Compile;