/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define LOGLIMIT 12
#define MAXBLOODLVL 5000
#define RESPAWNTIME 600
#define BLOODPERBAG 2000

["A3PL_Medical_Init",
{
	player setVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37],true];
	player setVariable ["A3PL_Medical_Alive",true,true];
}] call Server_Setup_Compile;

["A3PL_Medical_Loop",
{
	private _bloodLevel = [player,"blood"] call A3PL_Medical_GetVar;
	private _temperature = [player,"temp"] call A3PL_Medical_GetVar;
	private _pressure = [player,"pressure"] call A3PL_Medical_GetVar;

	if (_bloodLevel > 0) then {
		private _bloodChange = 0; {
			for "_i" from 1 to (count _x-1) do {
				private _woundArr = _x select _i;
				private _wound = _woundArr select 0;
				private _isTreated = _woundArr select 1;
				if (!_isTreated) then {
					_bloodChange = _bloodChange - ([_wound,"bloodLoss"] call A3PL_Config_GetWound);
				};
			};
		} foreach (player getVariable ["A3PL_Wounds",[]]);
		if (_bloodChange != 0) then {[player,[_bloodChange]] call A3PL_Medical_ApplyVar;};
	};
	if((player getVariable ["A3PL_Wounds",[]]) isEqualTo []) then {player setDamage 0;};
	{
		switch (_forEachIndex) do {
			case (0): {
				["\A3PL_Common\GUI\medical\overlay_blood.paa",1,(_x/MAXBLOODLVL)] call A3PL_HUD_SetOverlay;
				if(_x < MAXBLOODLVL) then {
					player setVariable["bloodOverlay",true,true];
				} else {
					player setVariable["bloodOverlay",false,true];
				};
			};
		};
	} foreach (player getVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37]]);
}] call Server_Setup_Compile;

["A3PL_Medical_PepperSpray",{

	[] spawn {
		_hndl = ppEffectCreate ['dynamicBlur', 505];
		_hndl ppEffectEnable true;
		_hndl ppEffectAdjust [5];
		_hndl ppEffectCommit 0;
		waitUntil {!([player,"head","pepper_spray"] call A3PL_Medical_HasWound)};
		ppEffectDestroy _hndl;
	};
}] call Server_Setup_Compile;

["A3PL_Medical_Hit",
{
	private ["_getHit","_unit","_sHit","_sDamage","_sSource","_sBullet","_tmpDmg","_woundArray"];
	_unit = param [0,objNull];

	_getHit = _unit getVariable ["getHit",[]];
	A3PL_HitTime = nil;
	_unit setVariable ["getHit",nil,false];

	if (player getVariable ["pVar_RedNameOn",false]) exitWith {};
	if(!(player getVariable["A3PL_Medical_Alive",true])  && (player getVariable ["TimeRemaining",600] < 520)) exitWith {player setVariable ["DoubleTapped",true,true];};

	_tmpDmg = 0;
	{
		private ["_sel","_dmg","_bullet"];
		_sel = _x select 0;
		_dmg = _x select 1;
		_bullet = _x select 2;
		_source = _x select 3;
		if (_bullet == "") then {
			if (_dmg > _tmpDmg) then {
				_sHit = _sel;
				_sDamage = _dmg;
				_sBullet = _bullet;
				_tmpDmg = _dmg;
				_sSource = _source;
			};
		} else {
			if ((_dmg > _tmpDmg) && (_sel != "")) then {
				_sHit = _sel;
				_sDamage = _dmg;
				_sBullet = _bullet;
				_tmpDmg = _dmg;
				_sSource = _source;
			};
		};
	} foreach _getHit;

	if (isNil "_sHit") exitwith {};
	if ((_sHit IN ["spine1","spine2","spine3"]) && (_sBullet == "") && (isBurning player)) then {_sBullet = "FireDamage";};

	if (_sBullet IN ["A3PL_Extinguisher_Water_Ball","A3PL_High_Pressure_Water_Ball","A3PL_Medium_Pressure_Water_Ball","A3PL_Low_Pressure_Water_Ball","A3PL_High_Pressure_Foam_Ball","A3PL_Medium_Pressure_Foam_Ball","A3PL_Low_Pressure_Foam_Ball"]) exitwith {};
	if (_sBullet IN ["B_408_Ball"]) exitwith {};
	if (_sBullet IN ["A3PL_Predator_Bullet"]) exitwith {};
	if (_sBullet == "A3PL_Paintball_Bullet") exitwith {
		if ((missionNameSpace getVariable ["A3PL_Medical_PaintballHit",false]) OR (_sSource == player)) exitwith {};
		A3PL_Medical_PaintBallHit = true;
		player playaction "gestureFreeze";
		uiSleep 0.6;
		A3PL_Medical_PaintBallHit = nil;
	};

	[_sHit,_sDamage,_sBullet] call A3PL_Medical_GenerateWounds;
}] call Server_Setup_Compile;

["A3PL_Medical_GetHitPart",
{
	private ["_sHit","_mHit"];
	_sHit = param [0,""];
	_mHit = "head";
	switch (true) do
	{
		case (_sHit IN ["face_hub","head"]): {_mHit = "head"};
		case (_sHit IN ["pelvis","spine1"]): {_mHit = "pelvis"};
		case (_sHit == "spine2"): {_mHit = "torso"};
		case (_sHit IN ["neck","spine3","body"]): {_mHit = "chest"};
		case (_sHit IN ["arms","hands"]): {_mHit = ["right upper arm","right lower arm","left lower arm","left upper arm"] call A3PL_Lib_ArrayRandom;};
		case (_sHit == "legs"): {_mHit = ["right upper leg","right lower leg","left lower leg","left upper leg"] call A3PL_Lib_ArrayRandom;};
	};
	_mHit;
}] call Server_Setup_Compile;

//Generate a wound array, based on hit
["A3PL_Medical_GenerateWounds",
{
	private ["_sHit","_sDamage","_sBullet"];
	_sHit = param [0,""];
	_sDamage = param [1,0];
	_sBullet = param [2,""];

	switch (true) do {
		case (_sBullet IN ["A3PL_TaserBullet","A3PL_Taser2_Ammo"]): {
			[] call A3PL_Lib_Ragdoll;
			if((vest player) isEqualTo "A3PL_SuicideVest") then {[] call A3PL_Criminal_SuicideVest;};
			[player,([_sHit] call A3PL_Medical_GetHitPart),"taser"] call A3PL_Medical_ApplyWound;
 		};
		if (_sBullet IN ["A3FL_PepperSpray_Ball"]) exitwith {
				[player,"head","pepper_spray"] call A3PL_Medical_ApplyWound;
				[] call A3PL_Medical_PepperSpray;
		};
		case (_sBullet IN ["A3PL_PickAxe_Bullet","A3PL_Shovel_Bullet","A3PL_Fireaxe_Bullet","A3PL_Machete_Bullet","A3PL_Axe_Bullet","A3FL_BaseballBat_Bullet","A3FL_GolfDriver"]): {
			[player,([_sHit] call A3PL_Medical_GetHitPart),"cut"] call A3PL_Medical_ApplyWound;
			_chance = random 100;
			if(_chance > 50) then {
				[] call A3PL_Lib_Ragdoll;
				[player,([_sHit] call A3PL_Medical_GetHitPart),"bruise"] call A3PL_Medical_ApplyWound;
			};
		};
		case ((_sHit == "") && (_sBullet == "") && (vehicle player != player)):
		{
			if (_sDamage > 0.005) then
			{
				if(((driver (vehicle player)) isEqualTo player) && (_sDamage > 0.009)) then {
					_fifr = ["fifr"] call A3PL_Lib_FactionPlayers;
					if((count(_fifr) >= 5)) then {
						_chance = random 100;
						if(_chance > 85) then {
							vehicle player setVariable["trapped",true,true];
							["You have crashed and are trapped inside your vehicle, FIFR has been called!","red"] call A3PL_Player_Notification;
							["911: Someone is trapped in their vehicle, check your map for the location!","red","fifr",3] call A3PL_Lib_JobMessage;
							[position player, "Trapped in Vehicle","ColorRed"] remoteExec ["A3PL_Lib_CreateMarker",_fifr];
						};
						_fireChance = random 100;
						if((_sDamage > 0.04) && (_fireChance > 90)) then {
							[(getPosATL player)] call A3PL_Fire_StartFire;
							["Your vehicle has gone on fire due to a crash, FIFR has been called!","red"] call A3PL_Player_Notification;
							["911: A vehicle fire has been reported, check your map for the location!","red","fifr",3] call A3PL_Lib_JobMessage;
							[position player, "Vehicle Fire","ColorRed"] remoteExec ["A3PL_Lib_CreateMarker",_fifr];
						};
					};
				};
				_injuries = round (random 3);
				for "_i" from 1 to _injuries do {
					_parts = ["torso","pelvis","left upper leg","left lower leg","right upper leg","head","chest","right lower leg","right upper arm","left upper arm","left lower arm","right lower arm"];
					_part = _parts select (round (random [0,5,11]));
					switch (true) do
					{
						case (_part == "head"): { if (!([player,_part,"concussion_minor"] call A3PL_Medical_HasWound)) then { [player,"head","concussion_minor"] call A3PL_Medical_ApplyWound; }; };
						case default {[player,_part,(["cut","bruise","wound_minor"] call A3PL_Lib_ArrayRandom)] call A3PL_Medical_ApplyWound;};
					};
				};
			};

			if (_sDamage >= 0.016) then {
				_injuries = round (random 4);
				for "_i" from 1 to _injuries do {
					_parts = ["torso","pelvis","left upper leg","left lower leg","right upper leg","chest","right lower leg","head","right upper arm","left lower arm","right lower arm","left upper arm"];
					_part = _parts select (round (random [0,5,11]));
					switch (true) do {
						case (_part == "head"): { if (!([player,_part,"concussion_major"] call A3PL_Medical_HasWound)) then { [player,"head","concussion_major"] call A3PL_Medical_ApplyWound; }; };
						case default { [player,_part,(["cut","bruise","wound_minor","wound_major","bone_broken","bone_broken"] call A3PL_Lib_ArrayRandom)] call A3PL_Medical_ApplyWound; };
					};
				};
			};
		};
		case ((_sHit IN ["pelvis","head"]) && (_sBullet == "") && (vehicle player == player)): {
			if ((count (nearestObjects [player,["A3PL_Goose_Default"],5])) > 0) exitwith {};
			if ((count (nearestObjects [player,["Land_Pier_F"],50])) > 0) exitwith {};

			if (_sDamage >= 0.1 && _sDamage < 0.25) then {
				_injuries = round (random 2);
				for "_i" from 1 to _injuries do {
					_parts = ["left lower leg","right upper leg","left lower leg","pelvis","left upper leg","right upper leg","left upper leg","right lower leg","left lower leg","left upper leg","head","right upper leg","right lower leg","head","head","right lower leg"];
					_part = _parts select (round (random [0,7,15]));
					switch (true) do
					{
						case (_part == "head"): { [player,"head","concussion_minor"] call A3PL_Medical_ApplyWound; };
						case default { [player,_part,(["cut","bruise","wound_minor"] call A3PL_Lib_ArrayRandom)] call A3PL_Medical_ApplyWound; };
					};
				};
			};
			if (_sDamage > 0.25) then
			{
				_injuries = 1 + round (random 1);
				for "_i" from 1 to _injuries do
				{
					_parts = ["left lower leg","right upper leg","left lower leg","left upper leg","pelvis","left upper leg","right lower leg","left lower leg","left upper leg","head","right upper leg","right upper leg","right lower leg","head","head","right lower leg"];
					_part = _parts select (round (random [0,7,15]));
					switch (true) do
					{
						case (_part == "head"): { [player,"head","concussion_major"] call A3PL_Medical_ApplyWound; };
						case default { [player,_part,(["cut","bruise","wound_major","bone_broken"] call A3PL_Lib_ArrayRandom)] call A3PL_Medical_ApplyWound; };
					};
				};
			};
		};

		case (_sBullet == "FireDamage"): {
			_fireDamage = (player getVariable ["A3PL_FireDamage",0]) + 1;
			player setVariable ["A3PL_FireDamage",_fireDamage,false];
			if ((_fireDamage > 6 && _fireDamage < 10)) then
			{
				_parts = ["torso","torso","torso","pelvis","left upper leg","left lower leg","right upper leg","chest","right lower leg","right upper arm","torso","right lower arm","left lower arm","left upper arm","right lower arm","left lower arm","head","right lower arm","head","head","head"];
				_part = _parts select (round (random [0,8,20]));
				if (_part == "chest") then {
					if(((goggles player) == "A3PL_FD_Mask") && (_vest == "A3PL_FD_Oxygen")) then {
						if((uniform player) != "A3PL_FD_Protective_Uniform") then {
							_wound = (["burn_second","burn_first","burn_second"] call A3PL_Lib_ArrayRandom);
							if (!([player,_part,_wound] call A3PL_Medical_HasWound)) then {[player,_part,_wound] call A3PL_Medical_ApplyWound;};
						};
					} else {
						if((uniform player) == "A3PL_FD_Protective_Uniform") then {
							_wound = (["smoke_minor","smoke_medium"] call A3PL_Lib_ArrayRandom);
							if (!([player,_part,_wound] call A3PL_Medical_HasWound)) then {[player,_part,_wound] call A3PL_Medical_ApplyWound;};
						} else {
							_wound = (["smoke_minor","smoke_medium","burn_second","burn_first","burn_second"] call A3PL_Lib_ArrayRandom);
							if (!([player,_part,_wound] call A3PL_Medical_HasWound)) then {[player,_part,_wound] call A3PL_Medical_ApplyWound;};
						};
					};
				} else {
					if((uniform player) != "A3PL_FD_Protective_Uniform") then {[player,_part,(["burn_first","burn_second"] call A3PL_Lib_ArrayRandom)] call A3PL_Medical_ApplyWound;};
				};
				[] spawn {
					if (missionNameSpace getVariable ["A3PL_MedicalVar_BurnLoop",false]) exitwith {};
					A3PL_MedicalVar_BurnLoop = true;
					uiSleep 2;
					if (!isBurning player) then {player setVariable ["A3PL_FireDamage",nil,false]};
					A3PL_MedicalVar_BurnLoop = nil;
				};
			};
			if (_fireDamage > 13) then
			{
				_parts = ["torso","torso","torso","pelvis","left upper leg","left lower leg","right upper leg","chest","right lower leg","right upper arm","torso","right lower arm","left lower arm","left upper arm","right lower arm","left lower arm","head","right lower arm","head","head","head"];
				_part = _parts select (round (random [0,5,20]));
				if (_part == "chest") then
				{
					_wound = (["smoke_medium","smoke_major","burn_second","burn_third"] call A3PL_Lib_ArrayRandom);
					if(((goggles player) == "A3PL_FD_Mask") && (_vest == "A3PL_FD_Oxygen")) then {
						if((uniform player) != "A3PL_FD_Protective_Uniform") then {
							_wound = (["burn_second","burn_third"] call A3PL_Lib_ArrayRandom);
							if (!([player,_part,_wound] call A3PL_Medical_HasWound)) then {[player,_part,_wound] call A3PL_Medical_ApplyWound;};
						};
					} else  {
						if((uniform player) == "A3PL_FD_Protective_Uniform") then {
							_wound = (["smoke_medium","smoke_major"] call A3PL_Lib_ArrayRandom);
							if (!([player,_part,_wound] call A3PL_Medical_HasWound)) then {[player,_part,_wound] call A3PL_Medical_ApplyWound;};
						} else {
							_wound = (["smoke_medium","smoke_major","burn_second","burn_third"] call A3PL_Lib_ArrayRandom);
							if (!([player,_part,_wound] call A3PL_Medical_HasWound)) then {[player,_part,_wound] call A3PL_Medical_ApplyWound;};
						};
					};
				} else {
					if((uniform player) != "A3PL_FD_Protective_Uniform") then {[player,_part,(["burn_first","burn_second"] call A3PL_Lib_ArrayRandom)] call A3PL_Medical_ApplyWound;};
				};
				player setVariable ["A3PL_FireDamage",nil,false];
			};
		};

		case ((_sHit IN ["face_hub","head"]) && (_sBullet != "")): {
			_wound = "bullet_head";
			[player,"head",_wound] call A3PL_Medical_ApplyWound;
		};
		case ((_sHit IN ["pelvis","spine1"]) && (_sBullet != "")): {
			_wound = (["bullet_minor","bullet_minor","bullet_major"] call A3PL_Lib_ArrayRandom);
			[player,"pelvis",_wound] call A3PL_Medical_ApplyWound;
		};
		case ((_sHit == "spine2") && (_sBullet != "")): {
			_wound = (["bullet_minor","bullet_minor","bullet_major"] call A3PL_Lib_ArrayRandom);
			[player,"torso",_wound] call A3PL_Medical_ApplyWound;
		};

		case ((_sHit IN ["neck","spine3","body"]) && (_sBullet != "")): {
			private _vest = vest player;
			private _kevlar = 0;
			if((_vest != "")) then {_kevlar = getNumber(configFile >> "CfgWeapons" >> _vest >> "ItemInfo" >> "mass");};
			if((_vest) isEqualTo "A3PL_SuicideVest") then {[] call A3PL_Criminal_SuicideVest;};
			if(_kevlar == 0) then {
				_wound = "bullet_major";
				[player,"chest",_wound] call A3PL_Medical_ApplyWound;
			} else {
				if(_kevlar >= 80) then {
					_wound = "bullet_minor";
					[player,"chest",_wound] call A3PL_Medical_ApplyWound;
				} else {
					if(_kevlar >= 40) then {
						_wound = "bullet_minor";
						[player,"chest",_wound] call A3PL_Medical_ApplyWound;
					} else {
						_wound = "bullet_major";
						[player,"chest",_wound] call A3PL_Medical_ApplyWound;
					};
				};
			};
			_chance = round(random 100);
			if(_chance >= 60) then {[player,"chest","breathing"] call A3PL_Medical_ApplyWound;};
		};

		case ((_sHit IN ["arms","hands"]) && (_sBullet != "")): {
			_part = ["right upper arm","right lower arm","left lower arm","left upper arm"] call A3PL_Lib_ArrayRandom;
			_wound = "bullet_minor";
			[player,_part,_wound] call A3PL_Medical_ApplyWound;
		};
		case ((_sHit == "legs") && (_sBullet != "")): {
			_part = ["right upper leg","right lower leg","left lower leg","left upper leg"] call A3PL_Lib_ArrayRandom;
			_wound = "bullet_minor";
			[player,_part,_wound] call A3PL_Medical_ApplyWound;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Medical_ApplyWound",
{
	private ["_part","_wound","_partF","_player","_set","_wounds"];
	_player = param [0,objNull];
	_part = param [1,""];
	_wound = param [2,""];
	_dmg = param [3,0];
	_partF = false;
	_set = true;
	_wounds = _player getVariable ["A3PL_Wounds",[]];

	{
		if ((_x select 0) == _part) then {
			if (count _x > 4) exitwith {_partF=true;_set=false;};
			_x pushback [_wound,false];
			_partF = true;
		};
	} foreach _wounds;

	if (!_partF) then {
		_wounds pushback [_part,[_wound,false]];
		switch(true) do {
			case (_part IN ["right upper leg","right lower leg","left lower leg","left upper leg"]): {
				if(_wound IN ["wound_minor","wound_major","cut","bone_broken"]) then {
					private _currentDamage = player getHit "legs";
					_player setHit ["legs", _currentDamage + 0.1];
				};
			};
			case (_part IN ["arms","hands"]): {
				if(_wound IN ["wound_minor","wound_major","cut","bone_broken"]) then {
					_player setHit ["arms", 0.5];
					_player setHit ["hands", 0.5];
				};
			};
			case (_part IN ["face_hub","head"]): {
				if(_wound IN ["wound_minor","wound_major","cut","bone_broken","bullet_head","pepper_spray"]) then {
					_player setHit ["head", 0.5];
				};
			};
			case (_part IN ["chest"]): {
				_player setHit ["body", 0.5];
			};
		};
	};

	if (_set) then {
		private ["_bloodLoss"];
		_player setVariable ["A3PL_Wounds",_wounds,true];
		[_player,format ["%1 sustained a %2 on the %3",(_player getVariable ["name",name _player]),([_wound,"name"] call A3PL_Config_GetWound),_part],[1, 0, 0, 1]] call A3PL_Medical_AddLog;
		_bloodLoss = [_wound,"bloodLossInstant"] call A3PL_Config_GetWound;
		if (_bloodLoss > 0) then {[_player,[-(_bloodLoss)]] call A3PL_Medical_ApplyVar;};
	};

	_format = "";
	switch(_part) do {
		case ("head"): {_format = "You are wounded at the head"};
		case ("chest"): {_format = "You are wounded at the chest"};
		case ("torso"): {_format = "You are wounded at the torso"};
		case ("pelvis"): {_format = "You are wounded at the pelvis"};
		case ("left upper leg"): {_format = "You are wounded at the left thigh"};
		case ("left lower leg"): {_format = "You are wounded at the left leg"};
		case ("right upper leg"): {_format = "You are wounded at the right thigh"};
		case ("right lower leg"): {_format = "You are wounded at the right leg"};
		case ("left upper arm"): {_format = "You are wounded at the left arm"};
		case ("left lower arm"): {_format = "You are wounded at the left forearm"};
		case ("right upper arm"): {_format = "You are wounded at the right arm"};
		case ("right lower arm"): {_format = "You are wounded at the right forearm"};
	};
	[_format, "red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Medical_GetVar",
{
	private ["_player","_var","_vars","_return"];
	_player = param [0,objNull];
	_var = param [1,""];
	_vars = _player getVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37]];
	_return = 0;
	switch (_var) do {
		case ("blood"):{_return = _vars select 0;};
		case ("pressure"):{_return = _vars select 1;};
		case ("temperature"):{_return = _vars select 2;};
		case default {_return = _vars select 0;};
	};
	_return;
}] call Server_Setup_Compile;

//apply a medical var e.g. blood,temperature,blood pressure and sync that variable to the network
//_change should be in format ["blood","pressure","temperature"]
["A3PL_Medical_ApplyVar",
{
	private _player = param [0,player];
	private _change = param [1,[]];
	private _medicalVar = _player getVariable ["A3PL_MedicalVars",[5000,"120/80",37]];
	{
		_bloodValue = (_medicalVar select 0);
		_newValue = (_medicalVar select _forEachIndex) + _x;
		if (_newValue < 0) then {_newValue = 0;};
		switch (_forEachIndex) do {
			if (_player isEqualTo player) then {
				case (0): {
					private _newBloodLvl = _bloodValue + (_x);
					if (_newBloodLvl <= 0) then {
						_newBloodLvl = 0;
						if (player getVariable["A3PL_Medical_Alive",true]) then {[] spawn A3PL_Medical_Die;};
					};
					["\A3PL_Common\GUI\medical\overlay_blood.paa",1,(_newBloodLvl/5000)] call A3PL_HUD_SetOverlay;
					player setVariable["bloodOverlay",true,true];
				};
			};
			if (_newValue > 5000) then {_newValue = 5000;};
			_medicalVar set [_forEachIndex,_newValue];
		};
	} foreach _change;
	_player setVariable ["A3PL_MedicalVars",_medicalVar,true];
	[(findDisplay 73)] call A3PL_Medical_LoadParts;
}] call Server_Setup_Compile;

["A3PL_Medical_Die",
{
	private ["_effect","_timer","_exit"];
	_effect = ["DynamicBlur",[5]] call A3PL_Lib_PPEffect;

	closeDialog 0;
	moveOut player;
	[false] call A3PL_Lib_Ragdoll;

	if ((player getVariable "dbVar_AdminLevel") < 3) then {
		disableUserInput true;
	};

	_timer = A3PL_Respawn_Time;
	player setVariable ["TimeRemaining",_timer,true];

	player setVariable ["tf_voiceVolume", 0, true];
	player setVariable ["A3PL_Medical_Alive",false,true];

	player setVariable ["Zipped",false,true];
	player setVariable ["Cuffed",false,true];

	[player,"Incapacitated"] remoteExec ["A3PL_Lib_SyncAnim",-2];

	Player_Drugs = [0,0,0];

	_exit = false;
	while {!(player getVariable ["A3PL_Medical_Alive",true])} do
	{
		_lastDamage = player getVariable ["lastDamage",0];
		if(player getVariable ["DoubleTapped",false]) then {
			_format = format ["<t color='#ff0000' <t size='5' font='PuristaSemiBold' align='center'>Unconscious!</t>"
			+ "<br/>"
			+ "<t size='2'> You CANNOT remember the events leading to your death! </t>"
			+ "<br/>"
			+ "<t size='2'> Time Remaining: </t><t size='2'>%1</t>"
			+ "<br/>"
			+ "<t size='2'> Killed By: </t><t size='2'>%2</t>"
			+ "<br/>",_timer,_lastDamage];
			titleText [_format, "PLAIN",-1,true,true];
			if ((animationState player) != "Incapacitated") then {
				[player,"Incapacitated"] remoteExec ["A3PL_Lib_SyncAnim",-2];
			};
		} else {
			_format = format ["<t color='#ff0000' <t size='5' font='PuristaSemiBold' align='center'>Unconscious!</t>"
			+ "<br/>"
			+ "<t size='2'> You CAN remember the events leading to your death! </t>"
			+ "<br/>"
			+ "<t size='2'> Time Remaining: </t><t size='2'>%1</t>"
			+ "<br/>"
			+ "<t size='2'> Killed By: </t><t size='2'>%2</t>"
			+ "<br/>",_timer,_lastDamage];
			titleText [_format, "PLAIN",-1,true,true];
			if ((animationState player) != "AinjPpneMstpSnonWnonDnon") then {
				[player,"AinjPpneMstpSnonWnonDnon"] remoteExec ["A3PL_Lib_SyncAnim",-2];
			};
		};
		uiSleep 1;
		_timer = _timer - 1;
		player setVariable ["TimeRemaining",_timer,true];
		if (_timer <= 0) exitwith {
			ppEffectDestroy _effect;
			[] call A3PL_Medical_Respawn;
			_exit = true;
		};
	};
	if(_exit) exitWith {};

	player setVariable ["tf_voiceVolume", 1, true];
	player setVariable ["A3PL_Medical_Alive",true,true];
	player setVariable ["DoubleTapped",false,true];
	player setVariable ["TimeRemaining",nil,true];

	[] call A3PL_Medical_LowerAlcohol;
	[] call A3PL_Medical_LowerDrugs;

	disableUserInput false;
	_effect ppEffectEnable false;
	ppEffectDestroy _effect;
	[player,"PlayerProne"] remoteExec ["A3PL_Lib_SyncAnim",-2];
}] call Server_Setup_Compile;

["A3PL_Medical_LowerAlcohol",
{
	if(Player_Alcohol >= 80) then {
		Player_Alcohol = 50;
		profileNamespace setVariable ["player_alcohol",Player_Alcohol];
	};
}] call Server_Setup_Compile;

["A3PL_Medical_LowerDrugs",
{
	{
		if(_x >= 80) then {
			Player_Drugs set[_forEachIndex, 50];
		};
	} foreach Player_Drugs;
	profileNamespace setVariable ["player_drugs",Player_Drugs];
}] call Server_Setup_Compile;

//Check if we have a wound or combination of wounds
["A3PL_Medical_HasWound",
{
	private ["_player","_part","_wound","_hasWound"];
	_player = param [0,objNull];
	_part = param [1,""];
	_woundsCheck = param [2,"",["",[]]];
	_hasWound = false;

	if (typeName _woundsCheck == "STRING") then {_woundsCheck = [_woundsCheck];};
	{
		_wound = _x;
		{
			if ((_x select 0) == _part) exitwith
			{
				for "_i" from 1 to (count _x-1) do
				{
					private ["_woundArr"];
					_woundArr = _x select _i;
					if ((_woundArr select 0) == _wound) exitwith
					{
						_hasWound = true;
					};
				};
			};
		} foreach (_player getVariable ["A3PL_Wounds",[]]);
	} foreach _woundsCheck;
	_hasWound;
}] call Server_Setup_Compile;

["A3PL_Medical_TreatWoundButton",
{
	disableSerialization;
	private ["_part","_wound","_control","_display","_player","_isEMS","_exit"];
	_display = findDisplay 73;

	//get player
	_player = missionNameSpace getVariable ["A3PL_MedicalVar_Target",objNull];
	if (isNull _player) exitwith {["Error: Unknown target"] call A3PL_Player_Notification;};

	//get part we have selected
	_part = missionNameSpace getVariable ["A3PL_MedicalVar_CurrentPart",nil];
	if (isNil "_part") exitwith {["Unable to determine the selected body part"] call A3PL_Player_Notification;};

	//get treatment we have selected
	_control = _display displayCtrl 1502;
	if (lbCurSel _control == -1) exitwith {["Please select a treatment"] call A3PL_Player_Notification;};
	_item = _control lbData (lbCurSel _control);

	_isEMS = (player getVariable ["job","unemployed"]) == "fifr";

	_exit = false;
	switch (_item) do
	{
		case ("medS_bloodbag"):
		{
			if (!([_item,1] call A3PL_Inventory_Has)) exitwith {["You don't have that"] call A3PL_Player_Notification; _exit = true;};
			if (_isEMS) then
			{
				if (([_player,"blood"] call A3PL_Medical_GetVar) >= 5000) exitwith {["This patient already has a maximum of blood"] call A3PL_Player_Notification;};
				if (player_itemClass == _item) then {[] call A3PL_Inventory_Clear};
				["medS_bloodbag",-1] call A3PL_Inventory_Add;
				[_player,[BLOODPERBAG]] call A3PL_Medical_ApplyVar;
				["You administered a blood test to this patient!","green"] call A3PL_Player_Notification;
				[player,format ["EMS %1 administered a blood bag",(player getVariable ["name",name player])],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
				[(findDisplay 73),_player] call A3PL_Medical_LoadParts;
				[player, 1] call A3PL_Level_AddXP;
			}
			else
			{
				["You are not on-duty as an EMS and can't administer a blood pack"] call A3PL_Player_Notification;
			};
			_exit = true;
		};
		case ("pull_taser"): {
			if ([_player,_part,"taser"] call A3PL_Medical_HasWound) then {
				[_player,_part,"taser","",lbCurSel 1501] call A3PL_Medical_Treat;
			};
			_exit = true;
		};
	};
	if (_exit) exitwith {};

	//get wound we have selected
	_control = _display displayCtrl 1501;
	if (lbCurSel _control == -1) exitwith {["You have no wound selected"] call A3PL_Player_Notification;};
	_wound = _control lbData (lbCurSel _control);

	//check if correct item is being applied
	if ((_item == ([_wound,"itemTreat"] call A3PL_Config_GetWound)) OR ((_item == ([_wound,"itemHeal"] call A3PL_Config_GetWound)) && _isEMS)) then {
		[_player,_part,_wound,_item,lbCurSel 1501] call A3PL_Medical_Treat;
		if (_item != "") then
		{
			if (player_itemClass == _item) then {[] call A3PL_Inventory_Clear}; //if we have it in our hand we should probably delete it to prevent duplication
			[_item,-1] call A3PL_Inventory_Add;
		};
	} else {
		["This item can't be used to treat this wound"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Medical_Treat",
{
	private ["_part","_wound","_woundName","_player","_isEMS","_item"];
	_player = param [0,objNull];
	_part = param [1,""];
	_wound = param [2,""];
	_woundName = [_wound,"name"] call A3PL_Config_GetWound;
	_item = param [3,""];
	_woundIndex = param [4,0];
	_isEMS = (player getVariable ["job","unemployed"]) == "fifr";
	_wounds = _player getVariable ["A3PL_Wounds",[]];

	{
		if ((_x select 0) == _part) exitwith
		{
			_i = _woundIndex + 1;
			_woundArr = _x select _i;
			if ((_woundArr select 0) == _wound) exitwith
			{
				if ((_item == ([_wound,"itemHeal"] call A3PL_Config_GetWound)) && _isEMS) exitwith {
					["You succesfully healed a wound","green"] call A3PL_Player_Notification;
					[format ["You succesfully healed a %1 wound",_woundName],"green"] call A3PL_Player_Notification;
					[_player,format ["EMS %1 healed a %2 wound",(player getVariable ["name",name player]),_woundName],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
					_x deleteAt _i;

					switch(true) do
					{
						case (_part IN ["right upper leg","right lower leg","left lower leg","left upper leg"]): {
							_player setHit ["legs", 0];
						};
						case (_part IN ["arms","hands"]): {
							_player setHit ["arms", 0];
							_player setHit ["hands", 0];
						};
						case (_part IN ["face_hub","head"]): {
							_player setHit ["head", 0];
						};
						case (_part IN ["chest"]): {
							_player setHit ["body", 0];
						};
					};
				};

				if ([_wound,"doesTreatHeal"] call A3PL_Config_GetWound) then
				{
					[format ["You succesfully treated a %1 wound",_woundName],"green"] call A3PL_Player_Notification;
					if ((player getVariable ["job","unemployed"]) == "fifr") then {
						[_player,format ["EMS %1 treated a %2 wound on the %3",(player getVariable ["name",name player]),_woundName],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
					} else {
						[_player,format ["%1 treated a %2 wound on the %3",(player getVariable ["name",name player]),_woundName],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
					};
					_x deleteAt _i;
					switch(true) do
					{
						case (_part IN ["right upper leg","right lower leg","left lower leg","left upper leg"]):
						{
							_player setHit ["legs", 0];
						};
						case (_part IN ["arms","hands"]):
						{
							_player setHit ["arms", 0];
							_player setHit ["hands", 0];
						};
						case (_part IN ["face_hub","head"]): {
							_player setHit ["head", 0];
						};
						case (_part IN ["chest"]): {
							_player setHit ["body", 0];
						};
					};
				} else {
					if ((player getVariable ["job","unemployed"]) == "fifr") then {
						[_player,format ["EMS %1 treated a %2 wound on the %3",(player getVariable ["name",name player]),_woundName],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
						switch(true) do {
							case (_part IN ["right upper leg","right lower leg","left lower leg","left upper leg"]):
							{
								_player setHit ["legs", 0];
							};
							case (_part IN ["arms","hands"]):
							{
								_player setHit ["arms", 0];
								_player setHit ["hands", 0];
							};
							case (_part IN ["face_hub","head"]): {
								_player setHit ["head", 0];
							};
							case (_part IN ["chest"]): {
								_player setHit ["body", 0];
							};
						};
					} else {
						[_player,format ["%1 treated a %2 wound on the %3",(player getVariable ["name",name player]),_woundName,_part],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
					};
					["You succesfully treated a wound, you may still require medical attention","green"] call A3PL_Player_Notification;
					[format ["You treated a %1 wound, you may still require medical attention",_woundName]] call A3PL_Player_Notification;
					_woundArr set [1,true];
				};
			};
			if (count _x < 2) then { (_player getVariable ["A3PL_Wounds",[]]) deleteAt _forEachIndex; };
		};
	} foreach _wounds;

	[(findDisplay 73),_player] call A3PL_Medical_LoadParts;
	[] call A3PL_Medical_SelectPart;
	_player setVariable ["A3PL_Wounds",_wounds,true];
}] call Server_Setup_Compile;

["A3PL_Medical_AddLog",
{
	private ["_text","_color","_log","_player"];
	_player = param [0,player];
	_text = param [1,""];
	_color = param [2,""];
	_log = _player getVariable ["A3PL_MedicalLog",[]];
	if (count _log >= LOGLIMIT) then {_log deleteAt 0;};
	_log pushback [format ["%2:%3 - %1",_text,(date select 3),(date select 4)],_color];
	_player setVariable ["A3PL_MedicalLog",_log,true];
}] call Server_Setup_Compile;

["A3PL_Medical_ClearLog",
{
	private ["_player"];
	if ((player getVariable ["job","unemployed"]) != "fifr") exitwith {["Only EMS can erase that"] call A3PL_Player_Notification;};
	_player = param [0,A3PL_MedicalVar_Target];
	if (isNull _player) exitwith {};
	_player setVariable ["A3PL_MedicalLog",nil,true];
	[(findDisplay 73),_player] call A3PL_Medical_LoadParts;
}] call Server_Setup_Compile;

//open the medical menu
["A3PL_Medical_Open",
{
	disableSerialization;
	private ["_display","_control","_unit"];
	_unit = param [0,player];

	createDialog "dialog_medical";
	_display = findDisplay 73;

	if(!([player,"head","pepper_spray"] call A3PL_Medical_HasWound)) then {
		[] spawn {
		_hndl = ppEffectCreate ['dynamicBlur', 505];
		_hndl ppEffectEnable true;
		_hndl ppEffectAdjust [5];
		_hndl ppEffectCommit 0;
		waitUntil {isNull findDisplay 73};
		ppEffectDestroy _hndl;
		};
	};

	//setup variables
	A3PL_MedicalVar_CurrentPart = "chest";
	A3PL_MedicalVar_Target = _unit;
	["chest"] call A3PL_Medical_SelectPart;

	//nil variables
	_display displayAddEventHandler ["unLoad",
	{
		A3PL_MedicalVar_CurrentPart = nil;
		A3PL_MedicalVar_Controls = nil;
	}];

	//set patient text
	_control = _display displayCtrl 1100;
	if (_unit == player) then {
		_control ctrlSetStructuredText parseText format ["<t size='1.4' align='center' font='PuristaSemiBold'>%1</t>",toUpper (player getVariable ["name",name player])];
	} else {
		_control ctrlSetStructuredText parseText format ["<t size='1.4' align='center' font='PuristaSemiBold'>%1</t>",toUpper ([_unit] call A3PL_Player_GetNameTag)];
	};

	//add button eventhandlers
	{
		buttonSetAction [1602+_forEachIndex,format ["['%1'] call A3PL_Medical_SelectPart;",_x]];
	} foreach ["head","chest","torso","pelvis","left upper leg","left lower leg","right upper leg","right lower leg","right upper arm","left upper arm","left lower arm","right lower arm"];
	buttonSetAction [1601,"[] call A3PL_Medical_TreatWoundButton"];
	buttonSetAction [1600,"[] call A3PL_Medical_ClearLog"];

	//load wounds
	[_display,_unit] call A3PL_Medical_LoadParts;
	while {!isNull _display} do {
		uiSleep 0.2;
		[] call A3PL_Medical_LoadItems;
	};
}] call Server_Setup_Compile;

["A3PL_Medical_LoadItems",
{
	disableSerialization;
	private ["_part","_display","_control","_player","_lbArray"];
	_player = missionNameSpace getVariable ["A3PL_MedicalVar_Target",objNull];
	_part = missionNameSpace getVariable ["A3PL_MedicalVar_CurrentPart","chest"];
	//add treatments for this part
	//load treatments,and items to treat
	_display = findDisplay 73;
	_control = _display displayCtrl 1502;
	_lbArray = [];
	switch (true) do
	{
		case ([_player,_part,"taser"] call A3PL_Medical_HasWound):
		{
			_lbArray pushback ["Pull out taser dart","pull_taser"];
		};
		case (_part IN ["right upper arm","left upper arm","left lower arm","right lower arm"]): {
			private ["_itemName","_itemAmount"];
			_itemName = "medS_bloodbag";
			_itemAmount = [_itemName] call A3PL_Inventory_Return;
			if ([_itemName,1] call A3PL_Inventory_Has) then {
				_lbArray pushback [(format ["%1 (x%2)",([_itemName,"name"] call A3PL_Config_GetItem),_itemAmount]),_itemName];
			};
		};
	};

	{
		private ["_itemName","_itemAmount","_index"];
		_itemName = _x select 0;
		_itemAmount = _x select 1;
		if ((_itemName find "med_") == 0) then {
			_lbArray pushback [(format ["%1 (x%2)",[_itemName,"name"] call A3PL_Config_GetItem,_itemAmount]),_itemName];
		};
	} foreach (player getVariable ["player_inventory",[]]);

	//add all the listbox stuff
	lbClear _control;
	{
		_index = _control lbAdd (_x select 0);
		_control lbSetData [_index,(_x select 1)];
	} foreach _lbArray;

}] call Server_Setup_Compile;

//display wounds on the base model inside the dialog
//This also loads the treatments available
["A3PL_Medical_LoadParts",
{
	disableSerialization;
	private ["_display","_control","_player","_log","_vars"];
	_display = param [0,(findDisplay 73)];
	_player = param [1,missionNameSpace getVariable ["A3PL_MedicalVar_Target",objNull]];
	_vars = _player getVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37]];

	if (isNull _display) exitwith {};

	_control = _display displayCtrl 1101;
	_control ctrlSetStructuredText parseText format ["<t size='1.3' align='center' font='PuristaSemiBold'>%1°C</t>",(_vars select 2)];

	_control = _display displayCtrl 1102;
	_control ctrlSetStructuredText parseText format ["<t size='1.3' align='center' font='PuristaSemiBold'>%1</t>",(_vars select 1)];

	_control = _display displayCtrl 1103;
	_control ctrlSetStructuredText parseText format ["<t size='1.3' align='center' font='PuristaSemiBold'>%1L</t>",(_vars select 0)/1000];

	_control = _display displayCtrl 1500;
	_log = [] + (_player getVariable ["A3PL_MedicalLog",[]]);
	reverse _log;
	lbClear _control;
	{
		 private _index = _control lbAdd (_x select 0);
		 _control lbSetColor [_index,(_x select 1)];
	} foreach _log;

	if (!isNil {missionNameSpace getVariable ["A3PL_MedicalVar_Controls",nil]}) then
	{
		{ctrlDelete _x;} foreach A3PL_MedicalVar_Controls;
	};

	_wounds = _player getVariable ["A3PL_Wounds",[]];
	if (count _wounds > 0) then
	{
		A3PL_MedicalVar_Controls = [];
		{
			private ["_control","_img","_color"];
			switch (_x select 0) do
			{
				case ("head"): {_img = "head"};
				case ("chest"): {_img = "spine03"};
				case ("torso"): {_img = "spine02"};
				case ("pelvis"): {_img = "spine01"};
				case ("left upper leg"): {_img = "right_leg_upper"};
				case ("left lower leg"): {_img = "right_leg_lower"};
				case ("right upper leg"): {_img = "left_leg_upper"};
				case ("right lower leg"): {_img = "left_leg_lower"};
				case ("left upper arm"): {_img = "right_arm_upper"};
				case ("left lower arm"): {_img = "right_arm_lower"};
				case ("right upper arm"): {_img = "left_arm_upper"};
				case ("right lower arm"): {_img = "left_arm_lower"};
			};
			if (isNil "_img") exitwith {["Erreur Médicale Système: _img non défini dans Medical_LoadParts (Signaler cette erreur)"] call A3PL_Player_Notification;};

			_color = "";
			for "_i" from 1 to (count _x-1) do
			{
				private ["_woundArr"];
				_woundArr = _x select _i;
				if (_woundArr select 1) then { if (!(_color IN ["red","orange"])) then { _color = "green"; }; } else
				{
					_color = [_woundArr select 0,"color"] call A3PL_Config_GetWound;
				};
				if (_color == "red") exitwith {};
			};

			_control = _display ctrlCreate ["RscPicture",-1];
			_control ctrlSetPosition (ctrlPosition (_display displayCtrl 1201));
			_control ctrlCommit 0;
			_control ctrlSetText format ["\A3PL_Common\GUI\medical\man_%1_%2.paa",_img,_color];
			A3PL_MedicalVar_Controls pushback _control;
		} foreach (_player getVariable ["A3PL_Wounds",[]]);
	};
}] call Server_Setup_Compile;

//what happends when we select a body part
["A3PL_Medical_SelectPart",
{
	disableSerialization;
	private ["_display","_control","_part","_player"];
	_part = param [0,A3PL_MedicalVar_CurrentPart];
	_player = missionNameSpace getVariable ["A3PL_MedicalVar_Target",objNull];
	A3PL_MedicalVar_CurrentPart = _part;

	_partName = "";
	switch(_part) do {
		case ("head"): {_partName = "head"};
		case ("chest"): {_partName = "chest"};
		case ("torso"): {_partName = "torso"};
		case ("pelvis"): {_partName = "pelvis"};
		case ("left upper leg"): {_partName = "left thigh"};
		case ("left lower leg"): {_partName = "left leg"};
		case ("right upper leg"): {_partName = "right thigh"};
		case ("right lower leg"): {_partName = "right leg"};
		case ("left upper arm"): {_partName = "left arm"};
		case ("left lower arm"): {_partName = "left forearm"};
		case ("right upper arm"): {_partName = "right arm"};
		case ("right lower arm"): {_partName = "right forearm"};
	};
	//set selected part text
	_display = findDisplay 73;
	_control = _display displayCtrl 1104;
	_control ctrlSetStructuredText parseText format ["<t size='1.3' align='center' font='PuristaSemiBold'>%1</t>",toUpper _partName];

	//listbox with wounds
	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		if (_x select 0 == _part) then {
			for "_i" from 1 to (count _x-1) do {
				private ["_woundArr","_index","_woundClass","_color"];
				_woundArr = _x select _i;
				_woundClass = _woundArr select 0;
				_index = _control lbAdd ([_woundClass,"name"] call A3PL_Config_GetWound);
				_control lbSetData [_index,_woundClass];
				_color = [_woundClass,"color"] call A3PL_Config_GetWound;
				switch (_color) do {
					case ("red"): {_color = [1, 0, 0, 1];};
					case ("orange"): {_color = [0.5, 0.5, 0, 1];};
					case ("green"): {_color = [0, 1, 0, 1];};
				};
				if (typeName _color == "ARRAY") then { _control lbSetColor [_index,_color];	};
			};
		};
	} foreach (_player getVariable ["A3PL_Wounds",[]]);
}] call Server_Setup_Compile;

["A3PL_Medical_Respawn",
{
	player setVariable ["DoubleTapped",false,true];
  	player switchMove "";
	disableUserInput false;
  	player setVariable ["Incapacitated",false,true];
	player setVariable ["Cuffed",false,true];
	player setVariable ["Zipped",false,true];
	player setDamage 0;
	player setVariable ["A3PL_Wounds",[],true];
	player setVariable ["A3PL_Medical_Alive",true,true];
	player setVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37],true];
	player setVariable ["A3PL_MedicalLog",nil,true];
	player setVariable ["TimeRemaining",nil,true];

	Player_Hunger = 100;
	Player_Thirst = 100;
	profileNamespace setVariable ["player_hunger",Player_Hunger];
	profileNamespace setVariable ["player_thirst",Player_Thirst];

	Player_Alcohol = 0;
	Player_Drugs = [0,0,0];
	profileNamespace setVariable ["player_alcohol",Player_Alcohol];
	profileNamespace setVariable ["player_drugs",Player_Drugs];

    closeDialog 0;

    removeHeadgear player;
    removeGoggles player;
    removeAllItemsWithMagazines player;
    removeAllWeapons player;
    removeAllContainers player;

    [player] remoteExec ["Server_Inventory_RemoveAll", 2];
	if(player getVariable "gender" == "male") then {
    	player addUniform (["A3PL_citizen2_Uniform","A3PL_citizen3_Uniform","A3PL_citizen4_Uniform","A3PL_citizen5_Uniform"] select (round (random 3)));
	} else {
    	player addUniform (["woman1","woman2","woman3"] select (round (random 2)));
	};

	player setVariable ["jailed",false,true];
	player setVariable ["jailtime",nil,true];
	[player] remoteExec ["Server_Criminal_RemoveJail", 2];

	player setPos [2616.57,5470.4,0.00143385];
	player setdir 99;
	player playAction "PlayerStand";
	player setVariable ["tf_voiceVolume", 1, true];
}] call Server_Setup_Compile;

["A3PL_Medical_Heal",
{
	if (!A3PL_FD_Clinic) exitwith {["You can not be healed here when the FIFR is available!","red"] call A3PL_Player_Notification;};

	private _healPrice = 600;
	private _pCash = player getVariable ["player_cash",0];
	private _npc = player_objintersect;
	if (_healPrice > _pCash) exitwith {[format [localize"STR_NPC_FIFRHEALERROR",_healPrice-_pCash]] call A3PL_Player_notification;};

	player setVariable ["player_cash",(player getVariable ["player_cash",0]) - _healPrice,true];
	["Federal Reserve",_healPrice] remoteExec ["Server_Government_AddBalance",2];

	["You must wait 2 minutes before being fully treated, stay nearby!","orange"] call A3PL_Player_Notification;
	if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
	["Patching you up...",120] spawn A3PL_Lib_LoadAction;
	_success = true;
	waitUntil{Player_ActionDoing};
	while {Player_ActionDoing} do {
		if (!(vehicle player == player)) exitwith {_success = false;};
		if (player distance2D _npc > 10) then {_success = false;}
	};

	if(Player_ActionInterrupted || !_success) exitWith {
		Player_ActionInterrupted = true;
		["Treatment cancelled!", "red"] call A3PL_Player_Notification;
	};

	["You are completely treated","green"] call A3PL_Player_Notification;

	player setDamage 0;
	player setVariable ["A3PL_Wounds",[],true];
	player setVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37],true];
	player setVariable ["A3PL_Medical_Alive",true,true];
	['fifr_healdone'] call A3PL_NPC_Start;
}] call Server_Setup_Compile;

["A3PL_Medical_Heal_Ill",
{
	private ["_healPrice","_pCash"];
	_healPrice = 4500;
	_pCash = player getVariable ["player_cash",0];
	if (_healPrice > _pCash) exitwith {[format [localize"STR_NPC_FIFRHEALERROR",_healPrice-_pCash]] call A3PL_Player_notification;};
	player setVariable ["player_cash",(player getVariable ["player_cash",0]) - _healPrice,true];

	player setVariable ["A3PL_Wounds",[],true];
	player setVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37],true];
	['fifr_healdoneill'] call A3PL_NPC_Start;
}] call Server_Setup_Compile;

["A3PL_Medical_ChestCompressions",{
	private _target = param [0,objNull];
	private _isBeingRevived = _target getVariable["reviving",false];
	private _success = true;

	if(_isBeingRevived) exitWith {["Someone is already performing CPR on this person","red"] call A3PL_Player_Notification;};
	if (Player_ActionDoing) exitwith {["You are already doing an action","red"] call A3PL_Player_Notification;};

    player playmove "AinvPknlMstpSnonWnonDr_medic0";
	[_target] spawn
	{
		private ["_target"];
		_target = param [0,objNull];
		if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
		["CPR in progress...",30] spawn A3PL_Lib_LoadAction;
		_success = true;
		waitUntil{Player_ActionDoing};
		while {Player_ActionDoing} do {
			if(!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
			if (!(vehicle player == player)) exitwith {_success = false;};
			if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
			diag_log str (animationState player);
			if (animationState player != "AinvPknlMstpSnonWnonDr_medic0") then {player playmove "AinvPknlMstpSnonWnonDr_medic0";}
		};
		player switchMove "";

		if(Player_ActionInterrupted || !_success) exitWith {
			Player_ActionInterrupted = true;
			["CPR Cancelled!", "red"] call A3PL_Player_Notification;
			if (vehicle player == player) then {player switchMove "";};
		};

		_target getVariable["reviving",false];

		private _chance = random 100;
		if(["cpr",player] call A3PL_DMV_Check) then {_chance = random 50;};
		if((player getVariable ["job", "unemployed"]) IN ["fifr"]) then {_chance = 0;};
		if(_chance <= 25) then {
			[_target,[1500]] call A3PL_Medical_ApplyVar;
			_target setVariable ["A3PL_Medical_Alive",true,true];
			["Resuscitation performed successfully", "green"] call A3PL_Player_Notification;
			[player,10] call A3PL_Level_AddXP;
		} else {
			["CPR Failed", "red"] call A3PL_Player_Notification;
		};
		player playMoveNow "";
		_target setVariable["reviving",false,true];
	};
}] call Server_Setup_Compile;
