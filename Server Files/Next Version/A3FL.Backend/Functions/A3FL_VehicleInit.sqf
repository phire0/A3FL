/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//Handle Vehicle Inits - Client Side
//U stands for unloaded, the loading screen copies this (compileFinal to prevent hacking) into A3PL_HandleVehicleInit, this will run all vehicle inits located in config.cpp as soon as this function excists
//Vehicle inits can simply be disabled by disabling this variable being copied in A3PL_Loading
['A3PL_Vehicle_HandleInitU', {
	private ['_class','_initfunction','_veh',"_iscar","_canTow"];

	if (isDedicated) exitwith {};

	_veh = ((_this select 0) select 0) select 0;
	_class = typeOf _veh;

	_veh addEventHandler ["ContainerOpened",
	{
		_container = param [0,objNull];
		if (_container getVariable ["locked",true]) then
		{
			[] spawn A3PL_Lib_CloseInventoryDialog;
			[localize"STR_NewVehicleInit_1","red"] call A3PL_Player_Notification;
		};
	}];

	_isCar = _veh isKindOf "Car";
	if (_isCar) then
	{
		switch (typeOf _veh) do
		{
			case ("A3PL_P362"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;_veh call A3PL_Vehicle_Init_A3PL_F150;};
			case ("A3PL_P362_TowTruck"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_MailTruck"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_F150"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_F150_Marker"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_F150_Marker_PD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Ram"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Rover"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Wrangler"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_BMW_M3"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Charger"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Charger_PD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Charger_PD_Slicktop"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Charger69"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Mustang"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Mustang_PD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Mustang_PD_Slicktop"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_CVPI"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_CVPI_PD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_CVPI_PD_Slicktop"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_CVPI_Taxi"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Tahoe"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Tahoe_PD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Tahoe_PD_Slicktop"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Tahoe_FD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("Jonzie_Ambulance"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Camaro"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_VetteZR1"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_BMW_X5"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Gallardo"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Mustang_PD_Slicktop"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Pierce_Ladder"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Pierce_Heavy_Ladder"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Pierce_Pumper"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Pierce_Rescue"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_CVPI_Rusty"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Fuel_Van"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Transport_Van"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Silverado"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_911GT2"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_CRX"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Silverado_PD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Challenger_Hellcat"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_VetteZR1_PD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_P362_Garbage_Truck"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_E350"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Charger15"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Suburban"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_CLS63"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Fatboy"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_1100R"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Knucklehead"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Monster"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Kx"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Urus"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_GMCVandura"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Taurus"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Taurus_PD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Taurus_PD_ST"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Charger15_PD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Charger15_PD_ST"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Charger15_FD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Raptor"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Raptor_PD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("M_explorer"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Raptor_PD_ST"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Fatboy_PD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
			case ("A3PL_Taurus_FD"): {_veh call A3PL_Vehicle_Init_A3PL_Engine;};
		};
		_veh call A3PL_Vehicle_Init_A3PL_Dealer;
	};

	_veh addEventHandler ["ContainerClosed",
	{
		_container = param [0,objNull];
		[_container] remoteExec ["Server_Storage_Vehicle", 2];
	}];
	_initfunction = !isNil ('A3PL_Vehicle_Init_' + _class);

	if (_initfunction) then
	{
		_veh call (missionNamespace getVariable ('A3PL_Vehicle_Init_' + _class));
	};

	_canTow = false;
	{
		if (_veh isKindOf _x) then {_canTow = true;};
	} foreach A3PL_HitchingVehicles;
	if (_canTow) then {_veh call A3PL_Vehicle_Init_A3PL_F150;};
}] call Server_Setup_Compile;

//a general init for only allowing vehicles to start by pressing engine button
["A3PL_Vehicle_Init_A3PL_Engine",
{
	private ["_veh"];
	_veh = _this;
	_veh addEventHandler ["Engine", {
		private ["_var"];
		_var = (_this select 0) getVariable "ignition";
		if ((isNil "_var") && (local(_this select 0))) then {
			(vehicle player) engineOn false;
		};
	}];
}] call Server_Setup_Compile;

//GetIn eventhandler to determine if we should start out loop for dealing with dealer vehicles
["A3PL_Vehicle_Init_A3PL_Dealer",
{
	private ["_veh"];
	_veh = _this;

	_veh addEventHandler ["GetIn",
	{
		private ["_veh","_position","_unit"];
		_veh = param [0,objNull];
		_position = param [1,""];
		_unit = param [2,objNull];
		if (player != _unit OR _position != "driver") exitwith {};
		if (!(_veh getVariable ["dealer",false])) exitwith {};

		[_veh] spawn
		{
			_veh = param [0,objNull];
			while {player IN _veh} do
			{
				if ((speed _veh > 16) OR (speed _veh < -16)) then
				{
					_veh setVelocity [0,0,0];
					[localize"STR_NewVehicleInit_2","red"] call A3PL_Player_Notification;
				};
				uiSleep 1;
			};
		};
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_Motorboat",
{
	private ["_veh"];
	_veh = _this;
	_veh addEventHandler ["HandleDamage",
	{
		private ["_veh","_bullet","_damage"];
		_veh = param [0,objNull];
		_damage = param [2,0];
		_bullet = param [4,""];

		if (_bullet == "B_65x39_Caseless_yellow") then
		{
			_damage = 0;
		};

		_damage
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_C_Heli_Light_01_civil_F",
{
	private _veh = _this;
	_veh animate["addDoors",1];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_MiniExcavator",
{
	private ["_veh"];
	_veh = _this;
	_veh addEventHandler ["GetIn",
	{
		_veh = vehicle player;
		_position = param [1,""];
		_unit = param [2,objNull];
		player action ["ManualFire", _veh];
		if ((_veh animationPhase "Bucket") > 0.5) then
		{
			_veh removeMagazineTurret  ["A3PL_JackhammerMag",[0]];
			_veh removeWeaponTurret ["A3PL_Machinery_Pickaxe",[0,0]];
			_veh addWeaponTurret ["A3PL_Machinery_Bucket",[0,0]];
			_veh addMagazineTurret ["A3PL_BucketMag",[0]];
		};
		if ((_veh animationPhase "Jackhammer") > 0.5) then
		{
			_veh removeMagazineTurret  ["A3PL_BucketMag",[0]];
			_veh removeWeaponTurret ["A3PL_Machinery_Bucket",[0,0]];
			_veh addWeaponTurret ["A3PL_Machinery_Pickaxe",[0,0]];
			_veh addMagazineTurret ["A3PL_JackhammerMag",[0]];
		};
		if ((_veh animationPhase "Claw") > 0.5) then
		{
			_veh removeMagazineTurret  ["A3PL_BucketMag",[0]];
			_veh removeWeaponTurret ["A3PL_Machinery_Bucket",[0,0]];
			_veh addWeaponTurret ["A3PL_Machinery_Pickaxe",[0,0]];
			_veh addMagazineTurret ["A3PL_JackhammerMag",[0]];
		};
		[] spawn
		{
			forksdokeydown =
			{
				_key = _this select 1;
				_return = false;
				switch _key do
				{
					case 75: // NUM_4
					{
						_val = vehicle player animationSourcePhase "Cabin";
						_valu = _val + 0.01;
						if (_valu >= 6.3) then {_valu = 6.3};
						vehicle player animateSource ["Cabin",_valu];
						_return = true;
					};
					case 77: // NUM_6
					{
						_val = vehicle player animationSourcePhase "Cabin";
						_valu = _val - 0.01;
						if (_valu <= -6.3) then {_valu = -6.3};
						vehicle player animateSource ["Cabin",_valu];
						_return = true;
					};
					case 72: // NUM_8
					{
						_val = vehicle player animationSourcePhase "arm";
						_valu = _val + 0.01;
						if (_valu >= 1) then {_valu = 1};
						vehicle player animateSource ["arm",_valu];
						_return = true;
					};
					case 80: // NUM_2
					{
						_val = vehicle player animationSourcePhase "arm";
						_valu = _val - 0.01;
						if (_valu <= -1) then {_valu = -1};
						vehicle player animateSource ["arm",_valu];
						_return = true;
					};
					case 73: // NUM_9
					{
						_val = vehicle player animationSourcePhase "frontArm";
						_valu = _val + 0.01;
						if (_valu >= 1) then {_valu = 1};
						vehicle player animateSource ["frontArm",_valu];
						_return = true;
					};
					case 81: // NUM_3
					{
						_val = vehicle player animationSourcePhase "frontArm";
						_valu = _val - 0.01;
						if (_valu <= -1) then {_valu = -1};
						vehicle player animateSource ["frontArm",_valu];
						_return = true;
					};
					case 71: // NUM_7
					{
						_val = vehicle player animationSourcePhase "attachment";
						_valu = _val + 0.02;
						if (_valu >= 1) then {_valu = 1};
						vehicle player animateSource ["attachment",_valu];
						_return = true;
					};
					case 79: // NUM_1
					{
						_val = vehicle player animationSourcePhase "attachment";
						_valu = _val - 0.02;
						if (_valu <= -1) then {_valu = -1};
						vehicle player animateSource ["attachment",_valu];
						_return = true;
					};
				};
				_return;
			};
			waituntil {!(IsNull (findDisplay 46))};
			_forkskeys = (FindDisplay 46) DisplayAddEventHandler ["keydown","_this call forksdokeyDown"];
			waitUntil {typeOf vehicle player != "A3PL_MiniExcavator"};
			(finddisplay 46) displayremoveeventhandler ["keydown",_forkskeys];
		};
	}];
	_veh addEventHandler ["Fired",
	{
		_veh = param [0,objNull];
		_wep = param [1,objNull];
		if ((!(_wep IN ["A3PL_Machinery_Bucket","A3PL_Shovel"])) OR ((_veh animationPhase "Jackhammer") > 0.5)) exitwith
		{
			_veh removeMagazineTurret  ["A3PL_BucketMag",[0]];
			_veh removeWeaponTurret ["A3PL_Machinery_Bucket",[0,0]];
		};
		[_veh] spawn
		{
			_veh = param [0,objNull];
			while {(_veh animationSourcePhase "attachment") < 0.99} do {
				_val = _veh animationSourcePhase "attachment";
				_valu = _val + 0.02;
				_veh animateSource ["attachment",_valu];
			};
			_veh removeMagazineTurret  ["A3PL_BucketMag",[0]];
			_veh removeMagazinesTurret ["A3PL_JackhammerMag",[0]];
			waitUntil {(_veh animationSourcePhase "attachment") < -0.9};
			_veh addMagazineTurret ["A3PL_BucketMag",[0]];
		};
	}];
}] call Server_Setup_Compile;

['A3PL_Vehicle_Init_A3PL_Ski_Base',
{
	private ['_veh'];
	_veh = _this;

	if (local _veh) then {_veh allowDamage false};

	_veh addEventHandler ["Local", {
		if (_this select 1) then {
			(_this select 0) allowDamage false;
		};
	}];

	_veh addEventHandler ["GetIn",
	{
		private ["_veh","_pos","_unit"];
		_unit = _this select 2;
		_pos = _this select 1;
		_veh = _this select 0;

		if (_unit == player) then
		{
			_veh animate ["wheel",1];

			[_veh] spawn
			{
				private ["_veh","_bank"];
				_veh = param [0,objNull];
				waituntil {sleep 0.5; player IN _veh};
				while {player IN _veh} do
				{
					_bank = (_veh call BIS_fnc_getPitchBank) select 1;
					if ((_bank > 60) OR (_bank < -60)) then
					{
						private ["_attachedTo","_dir","_vel","_y","_p","_r"];
						_attachedTo = (ropeAttachedTo _veh);
						if (isNull _attachedTo) exitwith {};

						_dir = getDir _attachedTo;
						_vel = velocity _veh;
						_y = getdir _veh;
						_p = 0;
						_r = 0;
						_veh setVectorDirAndUp
						[
						 [ sin _y * cos _p,cos _y * cos _p,sin _p],
						 [ [ sin _r,-sin _p,cos _r * cos _p],-_y] call BIS_fnc_rotateVector2D
						];
						_veh setVelocity _vel;
						_veh setDir _dir;
					};
					sleep 0.5;
				};
			};
		};
	}];

	_veh addEventHandler ["GetOut",
	{
		private ["_veh","_pos","_unit"];
		_unit = _this select 2;
		_pos = _this select 1;
		_veh = _this select 0;

		if (_unit == player) then
		{
			_veh animate ["wheel",0];
		};
	}];
}] call Server_Setup_Compile;

//List of all Client Side inits
//Format: A3PL_Vehicle_Init_CLASSNAME
['A3PL_Vehicle_Init_A3PL_F150',
{
	private ["_veh"];
	_veh = _this;
	_veh addEventHandler ["GetIn",
	{
		private ["_veh","_pos","_unit"];
		_veh = _this select 0;
		_pos = _this select 1;
		_unit = _this select 2;

		if (!local _unit) exitwith {};
		if (_pos != "driver") exitwith {};

		[_veh] spawn
		{
			_veh = param [0,objNull];
			while {player == driver _veh} do
			{
				_trailerArray = nearestObjects [(_veh modelToWorld [0,-4,0]), ["A3PL_Trailer_Base"], 6.5];
				_trailerArray = _trailerArray select 0;
				if (!isNil "_trailerArray") then
				{
					if (_trailerArray animationSourcePhase "Hitched" > 4 && _veh animationSourcePhase "Throttle" > 0.1 && _veh animationSourcePhase "Speed" < 3) then
					{
						_vel = velocity _veh;
						_dir = getDir _veh;
						_speed = 0.3;
						_newVel =
						[
							(_vel select 0) + (sin _dir * _speed),
							(_vel select 1) + (cos _dir * _speed),
							(_vel select 2)
						];
						_veh setVelocity _newVel;

						_vel = velocity _trailerArray;
						_dir = getDir _trailerArray;
						_newVel =
						[
							(_vel select 0) + (sin _dir * _speed),
							(_vel select 1) + (cos _dir * _speed),
							(_vel select 2)
						];
						_trailerArray setVelocity _newVel;
					};

					if( _veh animationSourcePhase "Gear" == -1 && _trailerArray animationSourcePhase "Hitched" > 4 && _veh animationSourcePhase "Throttle" > 0.1 && _veh animationSourcePhase "Speed" < 3) then
					{
						_vel = velocity _veh;
						_dir = getDir _veh;
						_speed = -0.3;
						_newVel =
						[
							(_vel select 0) + (sin _dir * _speed),
							(_vel select 1) + (cos _dir * _speed),
							(_vel select 2)
						];
						_veh setVelocity _newVel;

						_vel = velocity _trailerArray;
						_dir = getDir _trailerArray;
						_speed = -0.5;
						_newVel =
						[
							(_vel select 0) + (sin _dir * _speed),
							(_vel select 1) + (cos _dir * _speed),
							(_vel select 2)
						];
						_trailerArray setVelocity _newVel;
					};
				};
			sleep 1;
			};
		};
	}];
}] call Server_Setup_Compile;

['A3PL_Vehicle_Init_A3PL_Jayhawk', {
	private ['_veh','_basket'];
	_veh = _this;
	_veh addEventHandler ["GetIn",
	{
		_veh = param [0,objNull];
		_position = param [1,""];
		_unit = param [2,objNull];
		if (!local _unit) exitwith {};
		if (_position IN ["gunner","driver"]) then
		{
			[_veh] spawn A3PL_ATC_GetInAircraft;
		};
	}];
	_veh addEventHandler ["Engine", {
		if ((((_this select 0) animationPhase "ignition_Switch") < 0.5) && (player IN (_this select 0))) then {
			(vehicle player) engineOn false;
		};
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_Heli_Medium01_H",
{
	private ['_veh'];
	_veh = _this;
	_veh setVariable ["clearance",true,true];
	_veh setVariable ["Inspection",[],false];
	_veh addEventHandler ["GetIn",
	{
		_veh = param [0,objNull];
		_position = param [1,""];
		_unit = param [2,objNull];
		if (!local _unit) exitwith {};
		if (_position IN ["gunner","driver"]) then
		{
			[_veh] spawn A3PL_ATC_GetInAircraft;
		};
	}];
	_veh addEventHandler ["Engine", {
		if ((((_this select 0) animationPhase "switch_starter") < 1.9) && (player IN (_this select 0))) then {
			(vehicle player) engineOn false;
		};
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_Heli_Medium01_Coastguard_H",
{
	_this call A3PL_Vehicle_Init_Heli_Medium01_H;
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_Heli_Medium01_Sheriff_H",
{
	_this call A3PL_Vehicle_Init_Heli_Medium01_H;
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_Heli_Medium01_Luxury_H",
{
	_this call A3PL_Vehicle_Init_Heli_Medium01_H;
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_Heli_Medium01_Medic_H",
{
	_this call A3PL_Vehicle_Init_Heli_Medium01_H;
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_Heli_Medium01_Military_H",
{
	_this call A3PL_Vehicle_Init_Heli_Medium01_H;
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_Heli_Medium01_Veteran_H",
{
	_this call A3PL_Vehicle_Init_Heli_Medium01_H;
}] call Server_Setup_Compile;

['A3PL_Vehicle_Init_A3PL_Patrol', {
	private ['_veh'];
	_veh = _this;

	if (local _veh) then {_veh allowDamage false};
	_veh setVehicleAmmoDef (5000000);

	_veh addEventHandler ["Local", {
		if (_this select 1) then {
			(_this select 0) allowDamage false;
		};
	}];
}] call Server_Setup_Compile;

['A3PL_Vehicle_Init_A3PL_Cutter', {
	private ['_veh'];

	_veh = _this;

	if (local _veh) then {_veh allowDamage false};

	_veh addEventHandler ["Local", {if (_this select 1) then {(_this select 0) allowDamage false; };}];

	// THIS COULD POTENTIALLY CAUSE LAG since 'ANIMATE' is MP syncronised, to be tested!!
	_veh addEventHandler ["Fired",{
		[(_this select 0)] spawn {
			(_this select 0) animate ["gunback",0.5];

			sleep 0.4;

			(_this select 0) animate ["gunback",0];
		};
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_Goose_Base",
{
	private ["_veh"];
	_veh = _this;
	_veh setVariable ["clearance",true,true];
	_veh addEventHandler ["Local",
	{
		_veh = param [0,objNull];
		_local = param [1,false];

		//if this is the computer locality was changed to
		if (_local) then
		{
			//_veh allowDamage false;
			[_veh] spawn A3PL_Goose_Platform;
		};
	}];
	if (getplayerUID player == "_SP_PLAYER_") then {[_veh] spawn A3PL_Goose_Platform;}; //test platform script in SP

	_veh addEventHandler ["GetIn",
	{
		_veh = param [0,objNull];
		_position = param [1,""];
		_unit = param [2,objNull];

		if (!local _unit) exitwith {};

		if (_position IN ["gunner","driver"]) then
		{
			[_veh] spawn A3PL_ATC_GetInAircraft;
		};
	}];

	_veh addEventHandler ["Engine",
	{
		if ((((_this select 0) animationSourcePhase "Ignition") < 0.5) && (local (vehicle player))) then
		{
			(_this select 0) engineOn false;
		};
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_RHIB",
{
	_veh addEventHandler ["HandleDamage",
	{
		private ["_damage","_bullet","_unit","_dmg"];
		_veh = _this select 0;
		_selection = _this select 1;
		_damage = _this select 2;
		_source = _this select 3;
		_projectile = _this select 4;

		if (_projectile == "B_408_Ball") then {
			_veh setHit ["engine_hit",1];
		};
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_Goose_USCG",
{
	_this call A3PL_Vehicle_Init_A3PL_Goose_Base;
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_Cessna172",
{
	private ["_veh"];
	_veh = _this;
	_veh setVariable ["clearance",true,true];
	_veh addEventHandler ["GetIn",
	{
		_veh = param [0,objNull];
		_position = param [1,""];
		_unit = param [2,objNull];

		if (!local _unit) exitwith {};

		if (_position IN ["gunner","driver"]) then
		{
			[_veh] spawn A3PL_ATC_GetInAircraft;
		};
	}];

	_veh addEventHandler ["Engine",
	{
		if ((((_this select 0) animationSourcePhase "Ignition") < 0.5) && (local (vehicle player))) then
		{
			(_this select 0) engineOn false;
		};
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_Tahoe_PD",
{
	private ["_veh"];
	_veh = _this;
	_veh addEventHandler ["GetIn",
	{
		_veh = param [0,objNull];
		_position = param [1,""];
		_unit = param [2,objNull];

		if (!local _unit) exitwith {};

		if (_position == "driver") then
		{
			[_veh] spawn A3PL_Police_RadarLoop;
			[_veh] spawn A3PL_Vehicle_DriverSpotlight;
		};
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3FL_LCM", {
	private _veh = _this;
	_veh addEventHandler ["GetIn",
	{
		_veh = param [0,objNull];
		_position = param [1,""];
		_unit = param [2,objNull];

		if (!local _unit) exitwith {};

		if (_position == "driver") then
		{
			[_veh] spawn A3PL_Vehicle_LCMRamp;
		};
	}];
	_veh addEventHandler ["HandleDamage",
	{
		private _veh = _this select 0;
		private _projectile = _this select 4;
		if (_projectile IN ["B_408_Ball","Sh_105mm_HEAT_MP_T_Red"]) then {
			_veh setFuel 0;
		};
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_Tahoe_PD_Slicktop",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_CVPI_PD_Slicktop",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_CVPI_PD",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Mustang_PD",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Mustang_PD_Slicktop",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Charger_PD",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Charger_PD_Slicktop",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Silverado_PD",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Taurus_PD",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Taurus_PD_ST",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Raptor_PD",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Charger15_PD",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Charger15_PD_ST",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Charger15_FD",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_Raptor_PD_ST",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_VetteZR1_PD",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Taurus_PD",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Taurus_PD_ST",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;
["A3PL_Vehicle_Init_A3PL_Taurus_FD",{_this call A3PL_Vehicle_Init_A3PL_Tahoe_PD;}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_CVPI_Taxi",
{
	private ["_veh"];
	_veh = _this;

	_veh addEventHandler ["GetIn",
	{
		_veh = param [0,objNull];
		_position = param [1,""];
		_unit = param [2,objNull];

		if (!local _unit) exitwith {};

		if (_position == "driver") then
		{
			[_veh] spawn A3PL_JobTaxi_FareLoop;
		};
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_MobileCrane",
{
	private ["_veh"];
	_veh = _this;

	_veh addEventHandler ["GetIn",
	{
		_veh = param [0,objNull];
		_position = param [1,""];
		_unit = param [2,objNull];

		if (!local _unit) exitwith {};

		if (_position == "driver") then
		{
			[_veh] spawn A3PL_IE_CraneGetIn;
		};
	}];
}] call Server_Setup_Compile;

['A3PL_Vehicle_Init_A3PL_Stinger',
{
	private ["_veh"];
	_veh = ((_this select 0) select 0) select 0; //fix this later jonzie

	_veh addEventHandler ["EpeContact",
	{
		_Stinger = _this select 0;
		if (_Stinger animationSourcePhase "Deploy_Stinger" == 0) exitWith {};
		_threshold = 0.5;
		_wheels = [];
		_stingerPoints = [];
		_wheelHits = [];
		_objects = nearestObjects [_Stinger, ["Car_F"], 25]; //Search for nearest objects
		_veh = objNull;
		if (count _objects > 0) then {_veh = _objects select 0;};
		if (speed _veh < 1) exitWith {};
		//How many columns of wheels, e.g Left and Right. If you had a column in the middle of the vehicle it would be 3
		for "_x" from 1 to 2 do
		{
			// How many rows of wheels
			for "_y" from 1 to 3 do {
				_wheels = _wheels + [[format ["%1_%2", _x, _y], _veh modelToWorld (_veh selectionPosition (format ["wheel_%1_%2_bound", _x, _y]))]];
			};
		};

		for "_i" from 1 to 52 do
		{
			_stingerPoints = _stingerPoints + [[_i, _Stinger modelToWorld (_Stinger selectionPosition (format ["Arm_%1_Hit", _i]))]];
		};

		{
			_wheel = _x select 0;
			_bound = _x select 1;

			{
				_distance = _bound distance (_x select 1);
				if (_distance < _threshold) then {
					//Add the wheel into the wheel hit array because it was hit by a spike
					_wheelHits = _wheelHits + [_wheel];
				};
			} forEach _stingerPoints;
		} forEach _wheels;

		//Actually pop the tire
		{
			_wheel = _x;
			_hitPoint = "";

			if (_wheel == "1_1") then {
				_hitPoint = "HitLFWheel";
			};
			if (_wheel == "1_2") then {
				_hitPoint = "HitLF2Wheel";
			};
			if (_wheel == "1_3") then {
				_hitPoint = "HitLMWheel";
			};
			if (_wheel == "2_1") then {
				_hitPoint = "HitRFWheel";
			};
			if (_wheel == "2_2") then {
				_hitPoint = "HitRF2Wheel";
			};
			if (_wheel == "2_3") then {
				_hitPoint = "HitRMWheel";
			};

			_veh setHitPointDamage [_hitPoint, 1];
		} forEach _wheelHits;
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Init_A3PL_P362_TowTruck",
{
	private ["_veh"];
	_veh = _this;
	_veh setVariable ["Towing",false,true];
}] call Server_Setup_Compile;

/*
['A3PL_Vehicle_Init_A3PL_P362',
{
	private ["_veh"];
	_veh = _this;
	_veh addEventHandler ["GetIn",
	{
		private ["_veh","_pos"];
		_veh = param [0,objNull];
		_pos = param [1,""];
		_unit = param [2,objNull];
		if (! (local _unit)) exitwith {};
		if (_pos != "driver") exitwith {};

		if(_veh animationSourcePhase "Hitched" > 1) then
		{
			_veh setCenterOfMass [[-0.00324621,0.641651,0.878189],4];
		} else
        {
			_veh setCenterOfMass [[-0.00324621,0.163791,0.878501],4];
		};
	}];
}] call Server_Setup_Compile;
*/
