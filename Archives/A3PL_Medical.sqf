#define LOGLIMIT 12
#define MAXBLOODLVL 5000
#define RESPAWNTIME 600
#define BLOODPERBAG 2000

["A3PL_Medical_Init",
{
	player setVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37],true];
	player setVariable ["A3PL_Medical_Alive",true,true];
	A3PL_MedicalVar_Unconscious = nil;
}] call Server_Setup_Compile;

//run every x sec
["A3PL_Medical_Loop",
{
	private ["_bloodLevel","_temperature","_pressure"];
	_bloodLevel = [player,"blood"] call A3PL_Medical_GetVar;
	_temperature = [player,"temp"] call A3PL_Medical_GetVar;
	_pressure = [player,"pressure"] call A3PL_Medical_GetVar;
	
	if (_bloodLevel > 0) then
	{
		private ["_bloodChange"];
		_bloodChange = 0;
		{
			for "_i" from 1 to (count _x-1) do
			{
				private ["_woundArr","_wound","_isTreated"];
				_woundArr = _x select _i;
				_wound = _woundArr select 0;
				_isTreated = _woundArr select 1;
				if (!_isTreated) then {
					_bloodChange = _bloodChange - ([_wound,"bloodLoss"] call A3PL_Config_GetWound);
				};
			};
		} foreach (player getVariable ["A3PL_Wounds",[]]);
		if (_bloodChange != 0) then {[player,[_bloodChange]] call A3PL_Medical_ApplyVar;};
	};
	if(player getVariable ["A3PL_Wounds",[]] isEqualTo []) then {
		player setDamage 0;
	};
	//set overlay to correct blood level
	{
		switch (_forEachIndex) do
		{
			case (0):
			{
				["\A3PL_Common\GUI\medical\overlay_blood.paa",1,(_x/MAXBLOODLVL)] call A3PL_HUD_SetOverlay;
			};
		};
	} foreach (player getVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37]]);
}] call Server_Setup_Compile;

["A3PL_Medical_Hit",
{
	private ["_getHit","_unit","_sHit","_sDamage","_sSource","_sBullet","_tmpDmg","_woundArray"];
	_unit = param [0,objNull];

	sleep 0.1;

	//reset variables
	_getHit = _unit getVariable ["getHit",[]];
	A3PL_HitTime = nil;
	_unit setVariable ["getHit",nil,false];

	if((A3PL_MedicalVar_Unconscious) && (player getVariable "TimeRemaining" < 480)) then {player setVariable ["DoubleTapped",true,true];};

	//find what selection was hit
	_tmpDmg = 0;
	{
		private ["_sel","_dmg","_bullet"];
		_sel = _x select 0;
		_dmg = _x select 1;
		_bullet = _x select 2;
		_source = _x select 3;
		if (_bullet == "") then
		{
			if (_dmg > _tmpDmg) then
			{
				_sHit = _sel;
				_sDamage = _dmg;
				_sBullet = _bullet;
				_tmpDmg = _dmg;
				_sSource = _source;
			};
		} else
		{
			if ((_dmg > _tmpDmg) && (_sel != "")) then
			{
				_sHit = _sel;
				_sDamage = _dmg;
				_sBullet = _bullet;
				_tmpDmg = _dmg;
				_sSource = _source;
			};
		};
	} foreach _getHit;
	if (isNil "_sHit") exitwith {};
	if (_sHit IN ["spine1","spine2","spine3"] && _sBullet == "" && isBurning player) then {_sBullet = "FireDamage";};

	//ignore hit from some bullets
	if (_sBullet == "B_408_Ball") exitwith {}; //ignore 408(sniper) bullet
	if (_sBullet == "A3PL_Predator_Bullet") exitwith {}; //ignore predator bullet damage
	if (_sBullet == "B_762x51_Ball") exitwith {}; //ignore hunting rifle bullet
	if (_sBullet == "A3PL_Paintball_Bullet") exitwith //deal with paintballs
	{
		if ((missionNameSpace getVariable ["A3PL_Medical_PaintballHit",false]) OR (_sSource == player)) exitwith {};
		A3PL_Medical_PaintBallHit = true;
		player playaction "gestureFreeze";
		[] spawn
		{
			sleep 0.6;
			A3PL_Medical_PaintBallHit = nil;
		};
	};

	//generate wound
	[_sHit,_sDamage,_sBullet] call A3PL_Medical_GenerateWounds;

}] call Server_Setup_Compile;

["A3PL_Medical_GetHitPart",
{
	private ["_sHit","_mHit"];
	_sHit = param [0,""];
	_mHit = "head"; //medical system hit location

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

//generate a wound array, based on hit
["A3PL_Medical_GenerateWounds",
{
	private ["_sHit","_sDamage","_sBullet"];
	_sHit = param [0,""];
	_sDamage = param [1,0];
	_sBullet = param [2,""];

	//debug
	//systemChat format ["%1 %2 %3",_sHit,_sDamage,_sBullet];

	//Generate wounds
	switch (true) do
	{
		case (_sBullet == "A3PL_TaserBullet"): //deal with taser damage
		{
			[] call A3PL_Lib_Ragdoll;
			[player,([_sHit] call A3PL_Medical_GetHitPart),"taser"] call A3PL_Medical_ApplyWound;
 		};

		case (_sBullet IN ["A3PL_High_Pressure_Water_Ball","A3PL_Medium_Pressure_Water_Ball","A3PL_Low_Pressure_Water_Ball","A3PL_High_Pressure_Foam_Ball","A3PL_Medium_Pressure_Foam_Ball","A3PL_Low_Pressure_Foam_Ball","A3PL_Extinguisher_Water_Ball"]): //deal with damage from high water pressure
		{
			[player,([_sHit] call A3PL_Medical_GetHitPart),"bruise"] call A3PL_Medical_ApplyWound;
		};

		case (_sBullet IN ["A3PL_Scythe_Bullet","A3PL_PickAxe_Bullet","A3PL_Shovel_Bullet","A3PL_Fireaxe_Bullet","A3PL_Machete_Bullet","A3PL_Knife_Bullet","A3PL_Shank_Bullet","A3PL_Axe_Bullet"]):
		{
			[player,([_sHit] call A3PL_Medical_GetHitPart),"cut"] call A3PL_Medical_ApplyWound;
		};

		case ((_sHit == "") && (_sBullet == "") && (vehicle player != player)): //damage from hitting a wall
		{
			if ((_sDamage > 0.005) && (_sDamage < 0.015)) then //minor vehicle hit
			{
				_injuries = round (random 3);
				for "_i" from 1 to _injuries do
				{
					_parts = ["torso","pelvis","left upper leg","left lower leg","right upper leg","head","chest","right lower leg","right upper arm","left upper arm","left lower arm","right lower arm"];
					_part = _parts select (round (random [0,5,11]));
					switch (true) do
					{
						case (_part == "head"): { if (!([player,_part,"concussion_minor"] call A3PL_Medical_HasWound)) then { [player,"head","concussion_minor"] call A3PL_Medical_ApplyWound; }; };
						case default {[player,_part,(["cut","bruise","wound_minor"] call A3PL_Lib_ArrayRandom)] call A3PL_Medical_ApplyWound;};
					};
				};
			};

			if (_sDamage >= 0.016) then
			{
				_injuries = round (random 4);
				for "_i" from 1 to _injuries do
				{
					_parts = ["torso","pelvis","left upper leg","left lower leg","right upper leg","chest","right lower leg","head","right upper arm","left lower arm","right lower arm","left upper arm"];
					_part = _parts select (round (random [0,5,11]));
					switch (true) do
					{
						case (_part == "head"): { if (!([player,_part,"concussion_major"] call A3PL_Medical_HasWound)) then { [player,"head","concussion_major"] call A3PL_Medical_ApplyWound; }; };
						case default { [player,_part,(["cut","bruise","wound_minor","wound_major","bone_broken","bone_broken"] call A3PL_Lib_ArrayRandom)] call A3PL_Medical_ApplyWound; };
					};
				};
			};
		};

		case ((_sHit IN ["pelvis","head"]) && (_sBullet == "") && (vehicle player == player)): //damage from falling down
		{
			if ((count (nearestObjects [player,["A3PL_Goose_Default"],5])) > 0) exitwith {}; //ignore fall damage if a goose nearby, bypass
			if ((count (nearestObjects [player,["Land_Pier_F"],50])) > 0) exitwith {}; //ignore fall damage if near a pier, big chance it's from a crane eject

			if (_sDamage >= 0.1 && _sDamage < 0.25) then
			{
				_injuries = round (random 2);
				for "_i" from 1 to _injuries do
				{
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

		case (_sBullet == "FireDamage"):
		{
			_fireDamage = (player getVariable ["A3PL_FireDamage",0]) + 1;
			player setVariable ["A3PL_FireDamage",_fireDamage,false];

			if ((_fireDamage > 6 && _fireDamage < 10)) then
			{
				_parts = ["torso","torso","torso","pelvis","left upper leg","left lower leg","right upper leg","chest","right lower leg","right upper arm","torso","right lower arm","left lower arm","left upper arm","right lower arm","left lower arm","head","right lower arm","head","head","head"];
				_part = _parts select (round (random [0,8,20]));
				if (_part == "chest") then {
					if(((goggles player) == "A3PL_FD_Mask")) then {
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
				[] spawn
				{
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
					if(((goggles player) == "A3PL_FD_Mask")) then {
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

		case ((_sHit IN ["face_hub","head"]) && (_sBullet != "")):
		{
			_wound = "bullet_head";
			[player,"head",_wound] call A3PL_Medical_ApplyWound;
		};

		case ((_sHit IN ["pelvis","spine1"]) && (_sBullet != "")):
		{
			_wound = (["bullet_minor","bullet_minor","bullet_major"] call A3PL_Lib_ArrayRandom);
			[player,"pelvis",_wound] call A3PL_Medical_ApplyWound;
		};

		case ((_sHit == "spine2") && (_sBullet != "")):
		{
			_wound = (["bullet_minor","bullet_minor","bullet_major"] call A3PL_Lib_ArrayRandom);
			[player,"torso",_wound] call A3PL_Medical_ApplyWound;
		};

		case ((_sHit IN ["neck","spine3","body"]) && (_sBullet != "")):
		{
			_wound = ["bullet_minor","bullet_minor","bullet_major"] call A3PL_Lib_ArrayRandom;
			[player,"chest",_wound] call A3PL_Medical_ApplyWound;
		};

		case ((_sHit IN ["arms","hands"]) && (_sBullet != "")):
		{
			_part = ["right upper arm","right lower arm","left lower arm","left upper arm"] call A3PL_Lib_ArrayRandom;
			_wound = "bullet_minor";
			[player,_part,_wound] call A3PL_Medical_ApplyWound;
		};

		case ((_sHit == "legs") && (_sBullet != "")):
		{
			_part = ["right upper leg","right lower leg","left lower leg","left upper leg"] call A3PL_Lib_ArrayRandom;
			_wound = "bullet_minor";
			[player,_part,_wound] call A3PL_Medical_ApplyWound;
		};
	};
}] call Server_Setup_Compile;

/*
	[
		[
			"head",
			["burn_first",false],
			["burn_first",false]
		]
	]
*/
["A3PL_Medical_ApplyWound",
{
	private ["_part","_wound","_partF","_player","_set","_wounds"];
	_player = param [0,objNull];
	_part = param [1,""];
	_wound = param [2,""];
	_partF = false; //_partFound
	_set = true;
	_wounds = _player getVariable ["A3PL_Wounds",[]];
	if (player getVariable ["pVar_RedNameOn",false]) exitwith {[format ["Medical Debug: You're in Adminmode, taking damage to the %1",_part],Color_Orange] call A3PL_Player_Notification;};
	//check if we already have a part defined
	{
		if ((_x select 0) == _part) then
		{
			if (count _x > 5) exitwith {_partF=true;_set=false;}; //dont add more than 5 wounds per part, network performance
			_x pushback [_wound,false];
			_partF = true;
		};
	} foreach _wounds;

	//create the part in the wound array if it doesn't exist
	if (!_partF) then
	{
		_wounds pushback [_part,[_wound,false]];
		switch(true) do
		{
			case (_part IN ["right upper leg","right lower leg","left lower leg","left upper leg"]):
			{
				_player setHit ["legs", 0.5];
			};
			case (_part IN ["arms","hands"]):
			{
				_player setHit ["arms", 0.5];
				_player setHit ["hands", 0.5];
			};
			case (_part IN ["face_hub","head"]): {
				_player setHit ["head", 0.5];
			};
			case (_part IN ["neck","spine3","body"]): {
				_player setHit ["body", 0.5];
			};
		};
	};

	if (_set) then
	{
		private ["_bloodLoss"];
		_player setVariable ["A3PL_Wounds",_wounds,true];
		[_player,format ["%1 sustained a %2 on the %3",(_player getVariable ["name",name _player]),([_wound,"name"] call A3PL_Config_GetWound),_part],[1, 0, 0, 1]] call A3PL_Medical_AddLog;
		_bloodLoss = [_wound,"bloodLossInstant"] call A3PL_Config_GetWound;
		if (_bloodLoss > 0) then {[_player,[-(_bloodLoss)]] call A3PL_Medical_ApplyVar;};
	};

	[format ["Medical Debug: Applying a %1 wound to the %2",_wound,_part],Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Medical_GetVar",
{
	private ["_player","_var","_vars","_return"];
	_player = param [0,objNull];
	_var = param [1,""];
	_vars = _player getVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37]];
	switch (_var) do
	{
		case ("blood"):
		{
			_return = _vars select 0;
		};
		case ("pressure"):
		{
			_return = _vars select 1;
		};
		case ("temperature"):
		{
			_return = _vars select 2;
		};
	};
	_return;
}] call Server_Setup_Compile;

//apply a medical var e.g. blood,temperature,blood pressure and sync that variable to the network
//_change should be in format ["blood","pressure","temperature"]
["A3PL_Medical_ApplyVar",
{
	private ["_player","_change","_medicalVar","_newValue"];
	_player = param [0,player];
	_change = param [1,[]];

	_medicalVar = _player getVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37]];
	{
		_newValue = (_medicalVar select _forEachIndex) + _x;
		if (_newValue < 0) then {_newValue = 0;};
		switch (_forEachIndex) do
		{
			if (_player == player) then //take care of instant changes
			{
				case (0): //blood level change
				{
					private ["_newBloodLvl"];
					_newBloodLvl = (_medicalVar select 0) + _x;
					if (_newBloodLvl <= 0) then
					{
						_newBloodLvl = 0;
						if (isNil "A3PL_MedicalVar_Unconscious") then {[] spawn A3PL_Medical_Die;};
					};
					if(!(_player getVariable["A3PL_Medical_Alive",true]) && (_newBloodLvl > 0)) then {_player setVariable ["A3PL_Medical_Alive",true,true];};
					["\A3PL_Common\GUI\medical\overlay_blood.paa",1,(_newBloodLvl/MAXBLOODLVL)] call A3PL_HUD_SetOverlay;
				};
			};
			if (_newValue > MAXBLOODLVL) then {_newValue = MAXBLOODLVL;};
			_medicalVar set [_forEachIndex,_newValue];
		};
	} foreach _change;

	_player setVariable ["A3PL_MedicalVars",_medicalVar,true];
	[(findDisplay 73)] call A3PL_Medical_LoadParts; //if the medical menu is open we can refresh the blood level
}] call Server_Setup_Compile;

["A3PL_Medical_Die",
{
	private ["_effect","_timer"];
	A3PL_MedicalVar_Unconscious = true;
	_effect = ["DynamicBlur",[5]] call A3PL_Lib_PPEffect;

	closeDialog 0;

	player setVariable ["TimeRemaining",600,true];

	_timer = player getVariable "TimeRemaining";
	moveOut player;
	[player,"Incapacitated"] remoteExec ["A3PL_Lib_SyncAnim",-2];
	player setVariable ["tf_voiceVolume", 0, true];
	if (pVar_AdminMenuGranted) then {
		disableUserInput false;
	} else {
		disableUserInput true;
	};
	player setVariable ["A3PL_Medical_Alive",false,true];
	//if (([player,"blood"] call A3PL_Medical_GetVar) > 0) then {[player,[-(MAXBLOODLVL)]] call A3PL_Medical_ApplyVar};
	while {!(player getVariable ["A3PL_Medical_Alive",true])} do
	{
		if(player getVariable "DoubleTapped") then {
			[format["<t size='1' font='PuristaSemiBold'>YOU ARE UNCONSCIOUS<br/>Your heart will stop in %1 seconds<br/><br/>
			You CANNOT remember the events leading to your death!</t>",_timer], 0, 0, 1, 0, 0] spawn BIS_fnc_dynamicText;
		if ((animationState player) != "AinjPpneMstpSnonWnonDnon") then { [player,"AinjPpneMstpSnonWnonDnon"] remoteExec ["A3PL_Lib_SyncAnim",-2]; }; //fix zombie bug
		} else {
		[format["<t size='1' font='PuristaSemiBold'>YOU ARE UNCONSCIOUS<br/>Your heart will stop in %1 seconds<br/><br/>
			You CAN remember the events leading to your death!</t>",_timer], 0, 0, 1, 0, 0] spawn BIS_fnc_dynamicText;
		if ((animationState player) != "Incapacitated") then { [player,"Incapacitated"] remoteExec ["A3PL_Lib_SyncAnim",-2]; }; //fix zombie bug
		};
		uiSleep 1;
		_timer = _timer - 1;
		player setVariable ["TimeRemaining",_timer,true];
		if (_timer <= 0) exitwith {[] call A3PL_Medical_Respawn;};
	};
	player setVariable ["A3PL_Medical_Alive",true,true];
	player setVariable ["tf_voiceVolume", 1, true];
	player switchMove "";
	A3PL_MedicalVar_Unconscious = nil;
	player setVariable ["DoubleTapped",false,true];
	disableUserInput false;
	_effect ppEffectEnable false;
	ppEffectDestroy _effect;
}] call Server_Setup_Compile;

//Check if we have a wound or combination of wounds
["A3PL_Medical_HasWound",
{
	private ["_player","_part","_wound","_hasWound"];
	_player = param [0,objNull];
	_part = param [1,""];
	_woundsCheck = param [2,"",["",[]]];
	_hasWound = false;

	if (typeName _woundsCheck == "STRING") then
	{
		_woundsCheck = [_woundsCheck];
	};

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
	if (isNull _player) exitwith {["System Medical: Unable to identify target, did the player leave the server?"] call A3PL_Player_Notification;};

	//get part we have selected
	_part = missionNameSpace getVariable ["A3PL_MedicalVar_CurrentPart",nil];
	if (isNil "_part") exitwith {["System Medical: Unable to determine the selected body part"] call A3PL_Player_Notification;};

	//get treatment we have selected
	_control = _display displayCtrl 1502;
	if (lbCurSel _control == -1) exitwith {["System Medical: You have no treatment/item selected!"] call A3PL_Player_Notification;};
	_item = _control lbData (lbCurSel _control);

	//isEMS check
	_isEMS = (player getVariable ["job","unemployed"]) == "fifr";

	_exit = false;
	//check if we are using a special treatment
	switch (_item) do
	{
		case ("medS_bloodbag"):
		{
			if (!([_item,1] call A3PL_Inventory_Has)) exitwith {["System Medical: You don't have this item"] call A3PL_Player_Notification; _exit = true;};
			if (_isEMS) then
			{
				if (([_player,"blood"] call A3PL_Medical_GetVar) >= 5000) exitwith {["System Medical: This patient already has maximum blood"] call A3PL_Player_Notification;};
				if (player_itemClass == _item) then {[] call A3PL_Inventory_Clear};
				["medS_bloodbag",-1] call A3PL_Inventory_Add;
				[_player,[BLOODPERBAG]] call A3PL_Medical_ApplyVar;
				["System Medical: You administered a blood pack to this patient!",Color_Green] call A3PL_Player_Notification;
				[_player,format ["EMS %1 administered a blood bag",(_player getVariable ["name",name _player])],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
				[(findDisplay 73),_player] call A3PL_Medical_LoadParts;
			} else
			{
				["System Medical: You are not on-duty as an EMS and can't administer a blood pack"] call A3PL_Player_Notification;
			};
			_exit = true;
		};
		case ("pull_taser"):
		{
			if ([_player,_part,"taser"] call A3PL_Medical_HasWound) then
			{
				[_player,_part,"taser",""] call A3PL_Medical_Treat;
			};
			_exit = true;
		};
	};

	if (_exit) exitwith {}; //we dealt with a special treatment item already

	//get wound we have selected
	_control = _display displayCtrl 1501;
	if (lbCurSel _control == -1) exitwith {["System Medical: You have no wound selected"] call A3PL_Player_Notification;};
	_wound = _control lbData (lbCurSel _control);

	//check if correct item is being applied
	if ((_item == ([_wound,"itemTreat"] call A3PL_Config_GetWound)) OR ((_item == ([_wound,"itemHeal"] call A3PL_Config_GetWound)) && _isEMS)) then
	{
		[_player,_part,_wound,_item] call A3PL_Medical_Treat;
		if (_item != "") then
		{
			if (player_itemClass == _item) then {[] call A3PL_Inventory_Clear}; //if we have it in our hand we should probably delete it to prevent duplication
			[_item,-1] call A3PL_Inventory_Add;
		};
	} else
	{
		if (_isEMS) then
		{
			["System Medical: This item can't be used to treat this wound (Or you are not on-duty as an EMS?)"] call A3PL_Player_Notification;
		} else
		{
			["System Medical: This item can't be used to treat this wound"] call A3PL_Player_Notification;
		};
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
	_isEMS = (player getVariable ["job","unemployed"]) == "fifr";
	_wounds = _player getVariable ["A3PL_Wounds",[]];

	{
		if ((_x select 0) == _part) exitwith
		{
			for "_i" from 1 to (count _x-1) do
			{
				private ["_woundArr"];
				_woundArr = _x select _i;
				if ((_woundArr select 0) == _wound) exitwith
				{
					//healing a wound by EMS
					if ((_item == ([_wound,"itemHeal"] call A3PL_Config_GetWound)) && _isEMS) exitwith
					{
						["System Medical: You succesfully healed a wound",Color_Green] call A3PL_Player_Notification;
						[format ["System Medical: You succesfully healed a %1 wound",_woundName]] call A3PL_Player_Notification;
						[_player,format ["EMS %1 healed a %2 wound",(player getVariable ["name",name player]),_woundName],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
						_x deleteAt _i;
					};

					//is this an item that heals or not?
					if ([_wound,"doesTreatHeal"] call A3PL_Config_GetWound) then
					{
						[format ["System Medical: You succesfully treated a %1 wound",_woundName],Color_Green] call A3PL_Player_Notification;
						if ((player getVariable ["job","unemployed"]) == "fifr") then
						{
							[_player,format ["FIFR %1 treated a %2 wound on the %3",(player getVariable ["name",name player]),_woundName,_part],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
						} else
						{
							[_player,format ["%1 treated a %2 wound on the %3",(player getVariable ["name",name player]),_woundName,_part],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
						};
						_x deleteAt _i;
					} else
					{
						if ((player getVariable ["job","unemployed"]) == "fifr") then
						{
							[_player,format ["FIFR: %1 treated a %2 wound on the %3",(player getVariable ["name",name player]),_woundName,_part],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
						} else
						{
							[_player,format ["%1 treated a %2 wound on the %3",(player getVariable ["name",name player]),_woundName,_part],[0, 1, 0, 1]] call A3PL_Medical_AddLog;
						};
						["System Medical: You succesfully treated a wound, you may still require medical attention",Color_Green] call A3PL_Player_Notification;
						[format ["System: You treated a %1 wound, you may still require medical attention",[_woundName,"name"] call A3PL_Config_GetWound]] call A3PL_Player_Notification;
						_woundArr set [1,true];
					};
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
	if (count _log >= LOGLIMIT) then //limit log for network performance
	{
		_log deleteAt 0; //delete
	};
	_log pushback [format ["%2:%3 - %1",_text,(date select 3),(date select 4)],_color];
	_player setVariable ["A3PL_MedicalLog",_log,true];
}] call Server_Setup_Compile;

["A3PL_Medical_ClearLog",
{
	private ["_player"];

	//ems check
	if ((player getVariable ["job","unemployed"]) != "fifr") exitwith {["System Medical: Only FIFR can clear this log"] call A3PL_Player_Notification;};

	//Clear log
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
	if (_unit == player) then
	{
		_control ctrlSetStructuredText parseText format ["<t size='1.4' align='center' font='PuristaSemiBold'>%1</t>",toUpper (player getVariable ["name",name player])];
	} else
	{
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

	//loop
	while {!isNull _display} do
	{
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
		case ([_player,_part,"taser"] call A3PL_Medical_HasWound): //add ability to pull out a taser dart
		{
			_lbArray pushback ["Pull out taser dart","pull_taser"];
		};
		case (_part IN ["right upper arm","left upper arm","left lower arm","right lower arm"]):
		{
			private ["_itemName","_itemAmount"];
			_itemName = "medS_bloodbag";
			_itemAmount = [_itemName] call A3PL_Inventory_Return;
			if ([_itemName,1] call A3PL_Inventory_Has) then
			{
				_lbArray pushback [(format ["%1 (x%2)",([_itemName,"name"] call A3PL_Config_GetItem),_itemAmount]),_itemName];
			};
		};
	};

	{
		private ["_itemName","_itemAmount","_index"];
		_itemName = _x select 0;
		_itemAmount = _x select 1;
		if ((_itemName find "med_") == 0) then //only add medical items to the treatment listbox
		{
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
	_vars = _player getVariable ["A3PL_MedicalVars",[MAXBLOODLVL]];

	//exit if display is null
	if (isNull _display) exitwith {};

	//temperature
	_control = _display displayCtrl 1101;
	_control ctrlSetStructuredText parseText format ["<t size='1.3' align='center' font='PuristaSemiBold'>%1°C</t>",(_vars select 2)];

	//blood presure
	_control = _display displayCtrl 1102;
	_control ctrlSetStructuredText parseText format ["<t size='1.3' align='center' font='PuristaSemiBold'>%1</t>",(_vars select 1)];

	//load blood level
	_control = _display displayCtrl 1103;
	_control ctrlSetStructuredText parseText format ["<t size='1.3' align='center' font='PuristaSemiBold'>%1L</t>",(_vars select 0)/1000];

	//Load Log
	_control = _display displayCtrl 1500;
	_log = [] + (_player getVariable ["A3PL_MedicalLog",[]]); //prevent editing original array
	reverse _log; //reverse log (recent first)
	lbClear _control;
	{
		 private ["_index"];
		 _index = _control lbAdd (_x select 0);
		 _control lbSetColor [_index,(_x select 1)];
	} foreach _log;

	//delete all previous images that display wounds on the base model
	if (!isNil {missionNameSpace getVariable ["A3PL_MedicalVar_Controls",nil]}) then
	{
		{
			ctrlDelete _x;
		} foreach A3PL_MedicalVar_Controls;
	};

	//create new images of wounds on the base model
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
			if (isNil "_img") exitwith {["System Medical Error: Undefined _img in Medical_LoadParts (Report this error)"] call A3PL_Player_Notification;};

			//color the part based on severity
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

			//create the rscpicture
			_control = _display ctrlCreate ["RscPicture",-1];
			_control ctrlSetPosition (ctrlPosition (_display displayCtrl 1201));
			_control ctrlCommit 0;
			_control ctrlSetText format ["\A3PL_Common\GUI\medical\man_%1_%2.paa",_img,_color];
			A3PL_MedicalVar_Controls pushback _control;
		} foreach (_player getVariable ["A3PL_Wounds",[]]);
	};

}] call Server_Setup_Compile;

//Run when a player is "killed"
["A3PL_Medical_Kill",
{
    params[["_killer",objNull,[objNull]]];

    _sName = _killer getVariable ["name","ERROR"];
    _sRealName = name _killer;
    _sPos = getPos _killer;
    _sWeapon = currentWeapon _killer;
    _pos = getPos player;
    _weapon = currentWeapon _killer;

    [getPlayerUID player,"Killed",[format["%1 (%2)",_sName,_sRealName],_sPos,_sWeapon,_pos,_weapon]] remoteExec ["Server_Log_New", 2];

    /* Put him incapacitated on the ground */
	moveOut player;
    player playMove "Incapacitated";
    player setVariable ["Incapacitated",true,true];

    /* Apply Damage? */
    player setDamage 0.99;    /* Disabled pending Kane's Review */

    /* Disable TFAR */
    player setVariable ["tf_voiceVolume", 0, true];

    /* Start death screen stuff.... */
    createDialog "Deathscreen";

	(findDisplay 1020) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true };"];

    /* Disable Respawn button */
    ctrlEnable [1600, false];

    [A3PL_Respawn_Time] spawn A3PL_Medical_Monitor;

}] call Server_Setup_Compile;

["A3PL_Medical_Monitor",
{
	private ["_distance","_allplayers"];
    params[["_time",0,[0]]];

    /* While the player is "dead" */
    while {player getVariable ["Incapacitated",false]} do {
        _time = _time - 1;
        _distance = -1;

		//if player closed display
		if (isNull (findDisplay 1020)) then
		{
			createDialog "Deathscreen";
			ctrlEnable [1600, false];
		};

		//if player is not in correct animation
		if (!(animationState player == "Incapacitated")) then
		{
			player playMove "Incapacitated";
		};

        //Loop through players - find medics - get the closest one
		_allplayers = allPlayers - [player];
        {
            if(player getVariable ["job","unemployed"] == "fifr") then
			{
                _new = player distance _x;
                if(_distance == -1 || {_new > _distance}) then
				{
                    _distance = _new;
                };
            };
        } forEach _allPlayers;

        /* Set Distance of Closest Medic */
        if(_distance < 0) then {
            ctrlSetText[1001, "No Medics"];
        } else {
            ctrlSetText[1001, format["Nearest Medic: %1m",_distance]];
        };

        /* TODO - Write Func to calcuate Min:Sec */
        ctrlSetText[1002, format["Respawn In %1",_time]];

        /* Enable Respawn Button */
        if(_time < 1) then {
            ctrlSetText[1002, "Respawn Available"];
            ctrlEnable [1600, true];
        };

        uiSleep 1;
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

	//set selected part text
	_display = findDisplay 73;
	_control = _display displayCtrl 1104;
	_control ctrlSetStructuredText parseText format ["<t size='1.3' align='center' font='PuristaSemiBold'>%1</t>",toUpper _part];

	//listbox with wounds
	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		if (_x select 0 == _part) then
		{
			for "_i" from 1 to (count _x-1) do
			{
				private ["_woundArr","_index","_woundClass","_color"];
				_woundArr = _x select _i;
				_woundClass = _woundArr select 0;
				_index = _control lbAdd ([_woundClass,"name"] call A3PL_Config_GetWound);
				_control lbSetData [_index,_woundClass];
				_color = [_woundClass,"color"] call A3PL_Config_GetWound;
				switch (_color) do
				{
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
    player switchMove "";
		
		player setVariable ["DoubleTapped",false,true];
    player setVariable ["Incapacitated",false,true];
		player setVariable ["Cuffed",false,true];
		player setVariable ["Zipped",false,true];
		player setDamage 0;
	//[player, false] call TFAR_fnc_forceSpectator;
	player setVariable ["A3PL_Wounds",[],true];
	player setVariable ["A3PL_Medical_Alive",true,true];
	player setVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37],true];
	if ((count (player getVariable ["A3PL_MedicalLog",[]])) > 0) then
	{
		[player] call A3PL_Medical_ClearLog;
	};

	player_hunger = 100;

    /* Close any open dialogs (deathscreen) */
    closeDialog 0;

    //rip their shit
    removeHeadgear player;
    removeAllItemsWithMagazines player;
    removeAllWeapons player;
    removeAllContainers player;

    //Clear inventory
    [[player], "Server_Inventory_RemoveAll", false] call BIS_fnc_MP;

    /*Add Default Clothing */
    player addUniform (["A3PL_citizen2_Uniform","A3PL_citizen3_Uniform","A3PL_citizen4_Uniform","A3PL_citizen5_Uniform"] select (round (random 3)));

    /* Remove Prison Time */
	player setVariable ["jailed",false,true];
	player setVariable ["jailtime",null,true];
	[player] remoteExec ["Server_Criminal_RemoveJail", 2];

    /* Teleport the player to clinic? */
	player setPos [2506.33,5456.31,0.001441];
	player setdir 180;
	player playAction "PlayerStand";
}] call Server_Setup_Compile;

["A3PL_Medical_Revive",
{
	player setVariable ["Incapacitated",false,true];
	disableUserInput false;
	player setVariable ["TimeRemaining",nil,true];
    player switchMove "";
    player setVariable ["tf_voiceVolume", 1, true];
    player playAction "PlayerProne";

    /* Close any Dialogs Open (DeathScreen) */
    closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_Medical_Heal",
{
	if ((count(["fifr"] call A3PL_Lib_FactionPlayers)) > 0) exitwith {["System: You cannot use Doctor Bob when EMS is available!",Color_Red] call A3PL_Player_Notification;};
	if (100 > (player getVariable ["player_cash",0])) exitwith {[format ["System: You don't have enough money to be healed."]] call A3PL_Player_notification;};
	player setVariable ["player_cash",(player getVariable ["player_cash",0]) - 100,true];
	player setDamage 0;
	player setVariable ["A3PL_Wounds",[],true];
	player setVariable ["A3PL_MedicalVars",[MAXBLOODLVL,"120/80",37],true];
	['fifr_healdone'] call A3PL_NPC_Start;
}] call Server_Setup_Compile;

["A3PL_Medical_ChestCompressions",
{
	private ["_target"];
	_target = param [0,objNull];

	if (!Player_ActionCompleted) exitwith {["You are already doing an action",Color_Red] call A3PL_Player_Notification;};
	player playMoveNow "AinvPknlMstpSnonWnonDr_medic0";
	Player_ActionCompleted = false;
	["CPR in progress...",8] spawn A3PL_Lib_LoadAction;
	while {sleep 2; !Player_ActionCompleted} do {player playMove 'AinvPknlMstpSnonWnonDr_medic0';};

	_chance = random 100;
	if((player getVariable ["job", "unemployed"]) == "fifr") then {_chance = _chance - 80;};
	if(_chance <= 5) then
	{
		[_target,[1200]] call A3PL_Medical_ApplyVar;
		_target setVariable ["A3PL_Medical_Alive",true,true];
		_target setVariable ["A3PL_MedicalVars",[500,"120/80",37],true];
		["Resuscitation performed successfully", Color_Green] call A3PL_Player_Notification;
	}
	else
	{
		["CPR has failed", Color_Red] call A3PL_Player_Notification;
	};
	player playMoveNow "";
}] call Server_Setup_Compile;