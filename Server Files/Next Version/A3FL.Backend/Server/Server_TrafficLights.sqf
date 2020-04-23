["Server_TrafficLights_A",
{
	params [["_trafficlight",objNull,[objNull]]];

	if (!(typeOf _trafficlight isEqualTo "Land_A3FL_TrafficLight_A") || {isNull _trafficlight}) exitwith {};
	uiSleep 3;

	for "_i" from 0 to 1 step 0 do {
		if (_trafficlight getVariable ["A3FL_LightBroken",false]) then {
			for "_j" from 1 to 13 step 1 do {
				_trafficlight animateSource ["red_light_source", 0, true];
				_trafficlight animateSource ["orange_light_source", 1, true];
				_trafficlight animateSource ["green_light_source", 0, true];
				uiSleep 2;
				_trafficlight animateSource ["red_light_source", 0, true];
				_trafficlight animateSource ["orange_light_source", 0, true];
				_trafficlight animateSource ["green_light_source", 0, true];
				uiSleep 1;
			};
		} else {
			_trafficlight animateSource ["green_light_source", 1, true];
			_trafficlight animateSource ["orange_light_source", 0, true];
			_trafficlight animateSource ["red_light_source", 0, true];
			uiSleep 15;
			_trafficlight animateSource ["red_light_source", 0, true];
			_trafficlight animateSource ["green_light_source", 0, true];
			_trafficlight animateSource ["orange_light_source", 1, true];
			uiSleep 4;
			_trafficlight animateSource ["red_light_source", 1, true];
			_trafficlight animateSource ["orange_light_source", 0, true];
			_trafficlight animateSource ["green_light_source", 0, true];
			uiSleep 20;
		};
	};
},true] call Server_Setup_Compile;

["Server_TrafficLights_B",
{
	params [["_trafficlight",objNull,[objNull]]];

	if (!(typeOf _trafficlight isEqualTo "Land_A3FL_TrafficLight_B") || {isNull _trafficlight}) exitwith {};

	uiSleep 3;

	for "_i" from 0 to 1 step 0 do {
		if (_trafficlight getVariable ["A3FL_LightBroken",false]) then {
			for "_j" from 1 to 13 step 1 do {
				_trafficlight animateSource ["red_light_source", 0, true];
				_trafficlight animateSource ["orange_light_source", 1, true];
				_trafficlight animateSource ["green_light_source", 0, true];
				uiSleep 2;
				_trafficlight animateSource ["red_light_source", 0, true];
				_trafficlight animateSource ["orange_light_source", 0, true];
				_trafficlight animateSource ["green_light_source", 0, true];
				uiSleep 1;
			};
		} else {
			_trafficlight animateSource ["red_light_source", 1, true];
			_trafficlight animateSource ["orange_light_source", 0, true];
			_trafficlight animateSource ["green_light_source", 0, true];
			uiSleep 20;
			_trafficlight animateSource ["green_light_source", 1, true];
			_trafficlight animateSource ["red_light_source", 0, true];
			_trafficlight animateSource ["orange_light_source", 0, true];
			uiSleep 15;
			_trafficlight animateSource ["orange_light_source", 1, true];
			_trafficlight animateSource ["green_light_source", 0, true];
			_trafficlight animateSource ["red_light_source", 0, true];
			uiSleep 4;
		};
	};
},true] call Server_Setup_Compile;

["Server_TrafficLights_Loop",
{
	private _terrainobj = nearestTerrainObjects [[2716.79,5477.64,0], [], 10000, false];
	private _objectsA = _terrainobj select {typeOf _x isEqualTo "Land_A3FL_TrafficLight_A"};
	private _objectsB = _terrainobj select {typeOf _x isEqualTo "Land_A3FL_TrafficLight_B"};

	{
		[_x] spawn Server_TrafficLights_A;
	} forEach _objectsA;

	{
		[_x] spawn Server_TrafficLights_B;
	} forEach _objectsB;
},true] call Server_Setup_Compile;