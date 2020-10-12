/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//main entry point of script, this script runs every 30 sec
["A3PL_Halloween_Randomiser",
{
	if (!(player inArea "CemeteryArea")) exitwith {};
	if ((random 1) <= 0.1) then
	{
		[] spawn A3PL_Halloween_Angelmode;
	};
	if (((random 1) <= 0.05) && !A3PL_Owns_Guardianscript) then
	{
		[] spawn A3PL_Halloween_SpawnGuardian;
	};
}] call Server_Setup_Compile;

["A3PL_Halloween_turnObject", 
{
	private ["_object","_dir"];	
	_object = param [0,objNull];  
	_dir = ((getPos player select 0) - (getPos _object select 0)) atan2 ((getPos player select 1) - (getPos _object select 1)) + 180;
	_object setDir _dir;
}] call Server_Setup_Compile;

["A3PL_Halloween_Eyecheck",
{
	private["_pos","_eyeDir","_pPos","_impactPos","_norm","_angle","_return","_blurEffect","_ppEffect"];
	
	_object = _this select 0;
	_pos = position _object;
	_pos set[2,(_pos select 2)+0.2];
	_eyeDir = eyeDirection player;
	_pPos = getPosATL player;
	_impactPos = [(_pos select 0)-(_pPos select 0),(_pos select 1)-(_pPos select 1),(_pos select 2)-(_pPos select 2)];
	_norm = sqrt((_impactPos select 0)^2+(_impactPos select 1)^2+(_impactPos select 2)^2);
	_angle = aCos ((_eyeDir select 0)*((_impactPos select 0) / _norm)+((_impactPos select 1) / _norm)*(_eyeDir select 1)+((_impactPos select 2) / _norm)*(_eyeDir select 2));
	_return = false;
	if(_angle < 90) then {
	_return = true;
	} else {
	_return = false;
	};
	_return;
}] call Server_Setup_Compile;
 
 
["A3PL_Halloween_Angelmode",
{
	private ["_angelarray","_hit","_somelogic","_alarm","_walkseconds","_invehicle","_passed","_loc"];
	if (A3PL_Halloween_AngelModeEnabled) exitwith {};
	if (goggles player == "A3PL_Ghost_Necklace") exitwith {
		if ((random 1) <= 0.1) then
		{
			["Your Anti-Ghost necklace made an insane loud noice.","yellow"] call A3PL_Player_Notification;
			player say3D "halloweenhorn";
			_angel = "Land_A3PL_hw_AngelPoint" createVehicleLocal (player modelToWorld [0,10,0]);
			[_angel] call A3PL_Halloween_turnObject;
			_candy = "A3PL_hw_candybucket" createVehicleLocal [0,0,0];
			_light = "A3PL_Camping_Light" createVehicleLocal (Getpos player);
			_light attachto [_angel, [-0.3, 0, -0.15] ]; 
			_candy attachTo [_angel, [0.22, -0.59, 0.44] ]; 
			_timer = time + 10;
			_triggered = false;
			while {(_timer > time) && !(_triggered)} do {
			sleep 0.1;
			if (_angel distance player < 2) then {
				_triggered = true;
				["You received 10 candy from a strange angel.","green"] call A3PL_Player_Notification;
				["candy",10] call A3PL_Inventory_Add;
			};
			};
			deletevehicle _light;
			deletevehicle _candy;
			deletevehicle _angel;
		} else {
			["Your Anti-Ghost necklace made a weird strumbling feeling","yellow"] call A3PL_Player_Notification;
		};
	};
	A3PL_Halloween_AngelModeEnabled = true;
	
	//Creating the angel, face it towards you and give all the default effects
	_angelarray = [];
	{
		_angel = "Land_A3PL_hw_AngelPoint" createVehicleLocal (player modelToWorld _x);
		[_angel] call A3PL_Halloween_turnObject;
		_angelarray = _angelarray + [_angel];
	} foreach [[0,10,0],[5,8,0],[8,0,0],[0,-10,0],[-10,-5,0],[1,-5,0],[-6,-5,0],[8,-3,0]];
	
	"colorCorrections" ppEffectEnable true;
	"colorCorrections" ppEffectAdjust [0.2, 0.75, 0, [0.8,0.9,1,-0.1], [1,1,1,3], [-0.5,0,-1,5]];
	"colorCorrections" ppEffectCommit 1;
	"filmGrain" ppEffectEnable true;
	"filmGrain" ppEffectAdjust [0.1, -1, 0.1, 0.05, 2, false];
	"filmGrain" ppEffectCommit 1;
	_hit = 0;
	player switchmove "ApanPercMsprSnonWnonDf";
	//Create the sound effect on a logic
	_somelogic = "logic" createvehiclelocal (getpos player);
	_somelogic say3D "halloweentheme";
	_somelogic attachTo [player, [0, 0, 1] ]; 
	["You were cursed by the spirit of Eerie.","red"] call A3PL_Player_Notification;
	["This curse will be with you for a minute, Try and escape!","yellow"] call A3PL_Player_Notification;
	["If she catches you 5 times or you don't run, your soul will be hers.","yellow"] call A3PL_Player_Notification;
	//Set default scarylevel and put the end timer.
	_alarm = time + 51; //30 seconds is timer
	
	_walkseconds = 0;
	_invehicle = false;
	_passed = false;
	_hit = 0;
	_loc = 0;
	
	while {!_invehicle && (_walkseconds != 70) && !(_hit > 5) && !_passed} do {
		uiSleep 0.1;
		if (vehicle player != player) then {_invehicle = true;};
		if (((speed player) < 12) && ((speed player) > -7)) then { _walkseconds = _walkseconds + 1;};
		{
			_angel = _x;
			[_angel] call A3PL_Halloween_turnObject;
			if (player distance _angel < 1.6) then {
				deletevehicle _angel;
				_angel = "Land_A3PL_hw_AngelAttack" createVehicleLocal [0,0,0];
				_angel setpos (player modelToWorld [0,1,0]);
				[_angel] call A3PL_Halloween_turnObject;
				_hit = _hit + 1;
				uiSleep 1;
				deletevehicle _angel;
			};
			if (((round random 250) == 50) && !([_angel] call A3PL_Halloween_Eyecheck)) then {
				deletevehicle _angel;
				if ((speed player) < -3) then { _loc = ((random 2) - 5); } else { _loc = ((random 5) - 3);  };
				if (_loc < 1.5 && _loc > -1.5) then {_loc = ((random 3) + 2); }; //Check so it not auto attacks you
				_angel = "Land_A3PL_hw_AngelIdle" createVehicleLocal [0,0,0];
				_angel setpos (player modelToWorld [(random 7 - random 7),_loc,0]);
				[_angel] call A3PL_Halloween_turnObject;
				_angelarray = _angelarray + [_angel];
			} else {
				if ((round random 300) == 50) then {
					if ((speed player) < -3) then { _loc = ((random 2) - 5); } else { _loc = ((random 3) + 3);  };
					_angel = "Land_A3PL_hw_AngelIdle" createVehicleLocal (player modelToWorld [0,_loc,0]);
					[_angel] call A3PL_Halloween_turnObject;
					_angelarray = _angelarray + [_angel];
				};
			};
		} foreach _angelarray;	
		if (time > _alarm) then {_passed = true;};
	}; 
	if ((_walkseconds == 70) OR (_hit > 5)) then {
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [-2, 0.75, 0, [0.8,0.9,1,-0.1], [1,1,1,3], [-0.5,0,-1,5]];
		"colorCorrections" ppEffectCommit 1;
		uiSleep 1;
		{deletevehicle _x;} foreach _angelarray;
		{ 
			_angel = "Land_A3PL_hw_AngelAttack" createVehicleLocal [0,0,0];
			_angel setpos (player modelToWorld _x);
			[_angel] call A3PL_Halloween_turnObject;
			_angelarray = _angelarray + [_angel];
		} foreach [[1,0,0],[1,1,0],[0,1,0],[-1,0,0],[-1,1,0],[-1,-1,0],[0,-1,0],[1,-1,0]];
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [0.2, 0.75, 0, [0.8,0.9,1,-0.1], [1,1,1,3], [-0.5,0,-1,5]];
		"colorCorrections" ppEffectCommit 1;
		(_angelarray select 0) say3D "halloweenhorn";
		uiSleep 2;
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [-2, 0.75, 0, [0.8,0.9,1,-0.1], [1,1,1,3], [-0.5,0,-1,5]];
		"colorCorrections" ppEffectCommit 1;
		uiSleep 0,5;
		if ((round random 10) == 6) then {
			["They caught you! Right before they disappeared, you sneaky ass stole 10 candy",Color_Orange] call A3PL_Player_Notification;
			["candy",10] call A3PL_Inventory_Add;
		} else {
			["They caught you!","red"] call A3PL_Player_Notification;
		};
		{deletevehicle _x;} foreach _angelarray;
		deletevehicle _somelogic;
		"colorCorrections" ppEffectEnable false;
		"filmGrain" ppEffectEnable false;
	};
	if (_passed) then {
		{deletevehicle _x;} foreach _angelarray;
		deletevehicle _somelogic;
		"colorCorrections" ppEffectEnable false;
		"filmGrain" ppEffectEnable false;
		["You successfully escaped the curse, you found 25 candy laying on the floor.","green"] call A3PL_Player_Notification;
		["candy",25] call A3PL_Inventory_Add;
	};
	if (_invehicle) then {
		{deletevehicle _x;} foreach _angelarray;
		deletevehicle _somelogic;
		"colorCorrections" ppEffectEnable false;
		"filmGrain" ppEffectEnable false;
		["The angels disappeared as soon as you got in the car.","yellow"] call A3PL_Player_Notification;
	};
	A3PL_Halloween_AngelModeEnabled = false;
	player switchmove "";
}] call Server_Setup_Compile;


["A3PL_Halloween_SpawnGuardian",
{
	private ["_spawnLocations","_aiMonster","_light"];
	
	if (!(((date select 3) >= 20) OR ((date select 3) <= 7))) exitwith {};
	_spawnLocations = [[5693.53,6113.73,0.00143337],
	[5677.13,6140.61,0.431991],
	[5654.19,6130.34,0.00138855],
	[5618.1,6148.03,0.00138283],
	[5629.78,6169.26,0.00144768],
	[5606.05,6175.39,0.00139618],
	[5574.35,6169.31,0.393019],
	[5556.81,6163.65,0.0014286],
	[5571.3,6140.43,0.00140572],
	[5566.17,6114.79,0.00137901],
	[5551.87,6096.89,0.00143814]];

	_aiMonster = createAgent ["C_man_p_beggar_F", (_spawnLocations select (round random count _spawnLocations)), [], 1, "CAN_COLLIDE"];
	// _aiMonster = (createGroup civilian) createUnit ["C_man_p_beggar_F",(_spawnLocations select (round random count _spawnLocations)), [], 0, ""]; 
	[_aiMonster] remoteExec ["Server_Dogs_HandleLocality", 2]; 
	_aiMonster adduniform "a3pl_skeleton_uniform";
	_aiMonster addweapon "A3PL_Scythe";
	_aiMonster allowdamage false;
	_aiMonster setAnimSpeedCoef 1.2;
	_light = "A3PL_Camping_Light" createvehicle (Getpos player);
	_light attachto [_aiMonster, [0.035,-.11,-0.1], "RightHandMiddle1"];
	_aiMonster setVariable ["name","The Guardian of the Cemetery",true];
	_aiMonster setvariable ["health",3,true];
	_aiMonster setvariable ["attack",[false,false],true];
	_aiMonster setvariable ["lightsource",_light,false];
	_aiMonster setBehaviour "SAVE";
	_aiMonster setCombatMode "BLUE";
	_aiMonster forceWalk true;
	[_aiMonster] spawn A3PL_Halloween_Guardian;
	A3PL_Owns_Guardianscript = true;
	_aiMonster addEventHandler ["HandleDamage",
	{
		private ["_source","_bullet","_target"];
		_target = param [0,objNull];
		_source = param [3,objNull];
		_bullet = param [4,""];
		_damage = 0;
		if (_bullet == "A3PL_Predator_bullet") then
		{
			[_source,_target] call A3PL_Halloween_HitGuardian;
		};
		_damage;
	}];
}] call Server_Setup_Compile;


["A3PL_Halloween_Guardian",
{
	private ["_aiMonster","_walkLocations","_randomWalkLoc","_target"];
	
	_aiMonster = param [0,objNull];
	debugmonster = _aiMonster;
	_walkLocations = 
	[
		[5733.3,6071.76,0.00143242],
		[5677.91,6107.12,0.00143909],
		[5700.2,6156.91,0.00139046],
		[5601.05,6194.1,0.00140858],
		[5537.24,6137.91,0.0014143],
		[5590.04,6132.52,0.00140095],
		[5711.79,6022.86,0.257222],
		[5524.24,6077.23,0.00136948]
	];
	_randomWalkLoc = (_walkLocations select ((round random count _walkLocations) -1));
	_aiMonster setDestination [_randomWalkLoc, "LEADER PLANNED", true];

	while {(((date select 3) >= 20) OR ((date select 3) <= 7)) && (_aiMonster getvariable "health" > 0) && (_aiMonster inArea "CemeteryArea")} do
	{
		uiSleep 0.5;
		if (isnil "_randomWalkLoc") then { _randomWalkLoc = [5711.79,6022.86,0.257222]};
		if (!(_aiMonster getvariable "attack" select 0)) then {_aiMonster setBehaviour "SAVE";}; //AI loves to cry and be stupid when shots are fired
		 
		 // Find closest player out of all allPlayers
		_closestPlayer = allPlayers select 0;
		_closestDistance = _aiMonster distance _closestPlayer;
		{
			_distCheck = _aiMonster distance _x;
			if (_distCheck < _closestDistance) then {
				_closestPlayer = _x;
				_closestDistance = _distCheck;
			};
		} foreach allPlayers;
		
		if ((_randomWalkLoc distance _aiMonster < 5) && !(_aiMonster getvariable "attack" select 0)) then {
			_randomWalkLoc = (_walkLocations select ((round random count _walkLocations) -1));
			_aiMonster setDestination [_randomWalkLoc, "LEADER PLANNED", true];
		};
		
		if (_aiMonster getvariable "attack" select 0) then {
			_target = _aiMonster getvariable "attack" select 1;
			_aiMonster setDestination [(getpos _target), "LEADER PLANNED", true];
			if (!(_target inArea "CemeteryArea")) then {
				_aiMonster setvariable ["attack",[false,false],true];
				_randomWalkLoc = (_walkLocations select ((round random count _walkLocations) -1));
				_aiMonster setDestination [_randomWalkLoc, "LEADER PLANNED", true];
				_aiMonster forceWalk true;
				_aiMonster setAnimSpeedCoef 1.2;
			};
			if ((_target distance _aiMonster) <= 2.5) then {
				_aiMonster setvariable ["attack",[false,false],true];
				_randomWalkLoc = (_walkLocations select ((round random count _walkLocations) -1));
				_aiMonster setDestination [_randomWalkLoc, "LEADER PLANNED", true];
				_aiMonster forceWalk true;
				_aiMonster setAnimSpeedCoef 1.2;
				_aiMonster switchmove "Acts_Executioner_Backhand";
				uiSleep 0.75;
				_aiMonster switchmove "";
				_target setpos [5480.36,6060.6,0.00143242];
				_target setdir 60;
				["The Guardian of the Cemetery teleported you out.","red"] call A3PL_Player_Notification;
			};
		} else {
			if ((_closestDistance < 50) && (_closestPlayer inArea "CemeteryArea")) then {
				_aiMonster setvariable ["attack",[true,_closestPlayer],true];
				_aiMonster forceWalk false;
				_aiMonster setAnimSpeedCoef 2;
				
			};
			
		};
		
	};
	_aiMonster setdammage 1;
	uiSleep 2;
	Deletevehicle (_aiMonster getvariable "lightsource");
	deletevehicle _aiMonster;
}] call Server_Setup_Compile;

["A3PL_Halloween_HitGuardian",
{
	private ["_player","_target","_health"];
	
	_player = param [0,objNull];
	_target = param [1,objNull];
	
	//checks
	if (currentweapon _player != "A3PL_Predator") exitwith {};
	if (isnil {_target getvariable "health"}) exitwith {};
	if (!(_player inArea "CemeteryArea")) exitwith {};
	
	//attack this player if shooting
	if (!((_target getvariable "attack") select 0)) then 
	{
		_target setvariable ["attack",[true,_player],true];
		_target forceWalk false;
		_target setAnimSpeedCoef 2;		
	};
	
	//take health
	_health = _target getvariable "health";
	_target setvariable ["health",(_health - 1),true];
	if ((_target getvariable "health") == 0) exitwith {
		[_target] remoteExec ["A3PL_Halloween_Finalblow", _player]; 
		A3PL_Owns_Guardianscript = false;
	};
	
}] call Server_Setup_Compile;

["A3PL_Halloween_Finalblow",
{
	["You blew the final hit on the guardian and received 5 candy.","green"] call A3PL_Player_Notification;
	["candy",5] call A3PL_Inventory_Add;
}] call Server_Setup_Compile;