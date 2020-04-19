["Server_Hunting_HandleLoop",
{
	["goat",[8703.66,8172.92,0],["Goat","Goat02","Goat03"],200,10] spawn Server_Hunting_Spawn;
	sleep 5;
	["wildboar",[6601.76,7517.37,0],["WildBoar"],230,10] spawn Server_Hunting_Spawn;
	sleep 5;
	["sheep",[6934.04,7442.04,0],["Sheep","Sheep02","Sheep03"],200,10] spawn Server_Hunting_Spawn;
	sleep 5;
	["cow",[4178.184,5381.45,0],["Cow01","Cow02","Cow03","Cow04","Cow05"],200,10] spawn Server_Hunting_Spawn;
},true] call Server_Setup_Compile;

["Server_Hunting_Spawn",
{
	private _siteVar = format ["A3PL_Animals_%1",(param [0,"def"])];
	private _sitePos = param [1,[]];
	private _animalList = param [2,[]];
	private _genDist = param [3,5];
	private _animalCount = param [4,5];
	private _radius = param [5,_genDist];
	private _dist = 10000;
	private _siteAnimals = missionNameSpace getVariable [_siteVar,[]];
	private _deleteAnimals = [];
	{
		if (isNull _x) then
		{
			_deleteAnimals = _deleteAnimals + [_x];
		};
	} foreach _siteAnimals;	
	{
		_siteAnimals = _siteAnimals - [_x];
	} foreach _deleteAnimals;
	
	{
		_checkDist = (_x distance2D _sitePos);
		if (_checkDist < _dist) then {_dist = _checkDist};
	} forEach allPlayers;

	if (_dist < _genDist) then 
	{
		_i = count _siteAnimals;
		while {_i < _animalCount} do 
		{
			_animal = _animalList select (round ((random ((count _animalList) - 0.01)) - 0.499));
			_pos = [((_sitePos select 0) - _radius + random (_radius * 2)), ((_sitePos select 1) - _radius + random (_radius * 2)), 0];
			_unit = createAgent [_animal,_pos,[],0,"NONE"];
			_unit setDir (random 360);
			_siteAnimals = _siteAnimals + [_unit];
			_i = _i + 1;
			sleep 0.05;
		};
		missionNameSpace setVariable [_siteVar,_siteAnimals];
	} else  {
		{deleteVehicle _x} forEach _siteAnimals;
		missionNameSpace setVariable [_siteVar,[]];
	};
},true] call Server_Setup_Compile;