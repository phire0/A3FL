/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

/*
	FIFR Rescue Truck Interactions
*/
[
	"A3PL_Pierce_Rescue",
	"Rotate Truck Ladder",
	{
		private _veh = player_objintersect;
		if(_veh animationSourcePhase "Ladder_Rotate" isEqualTo 0) then {
			_veh animateSource["Ladder_Rotate",2];
		} else {
			_veh animateSource["Ladder_Rotate",0];
		};
	}
],
[
	"A3PL_Pierce_Rescue",
	"Climb Truck Ladder",
	{
		private _veh = player_objintersect;
		player setPos (_veh modelToWorld [0,-5,1]);
		player setDir (getDir _veh);
	}
],
[
	"A3PL_Pierce_Rescue",
	"Extend/Retract Spotlight",
	{
		private _veh = player_objintersect;
		if(_veh animationSourcePhase "Top_Spot_Rotate" isEqualTo 0) then {
			_veh animateSource["Top_Spot_Rotate",3];
		} else {
			_veh animateSource["Top_Spot_Rotate",0];
			_veh animateSource["Top_Lights",0];
		};
	}
],
[
	"A3PL_Pierce_Rescue",
	"Spotlight On/off",
	{
		private _veh = player_objintersect;
		if(_veh animationSourcePhase "Top_Lights" isEqualTo 0) then {
			_veh animateSource["Top_Lights",1];
		} else {
			_veh animateSource["Top_Lights",0];
		};
	}
],
[
	"A3PL_Pierce_Rescue",
	"Grab Scene Light #1",
	{
		private _veh = player_objintersect;
		if(_veh animationPhase "scene_light_1" isEqualTo 0) then {
			_veh animate["scene_light_1",1];
			private _light = "A3PL_SceneLight" createVehicle position player;
			_light setVariable["owner",getPlayerUID player,true];
			_light setVariable["class","scene_light",true];
			player action ["lightOn",_light];
		};
	}
],
[
	"A3PL_Pierce_Rescue",
	"Grab Scene Light #2",
	{
		private _veh = player_objintersect;
		if(_veh animationPhase "scene_light_2" isEqualTo 0) then {
			_veh animate["scene_light_2",1];
			private _light = "A3PL_SceneLight" createVehicle position player;
			_light setVariable["owner",getPlayerUID player,true];
			_light setVariable["class","scene_light",true];
			player action ["lightOn",_light];
		};
	}
],
[
	"A3PL_Pierce_Rescue",
	"Return Scene Light #1",
	{
		private _veh = player_objintersect;
		if(_veh animationPhase "scene_light_1" isEqualTo 1) then {
			private _nearLights = nearestObjects [player, ["A3PL_SceneLight"], 10];
			if(count(_nearLights) isEqualTo 0) exitWith {["No scene light nearby.","red"] call A3PL_Player_Notification;};
			deleteVehicle (_nearLights select 0);
			_veh animate["scene_light_1",0];
		};
	}
],
[
	"A3PL_Pierce_Rescue",
	"Return Scene Light #2",
	{
		private _veh = player_objintersect;
		if(_veh animationPhase "scene_light_2" isEqualTo 1) then {
			private _nearLights = nearestObjects [player, ["A3PL_SceneLight"], 10];
			if(count(_nearLights) isEqualTo 0) exitWith {["No scene light nearby.","red"] call A3PL_Player_Notification;};
			deleteVehicle (_nearLights select 0);
			_veh animate["scene_light_2",0];
		};
	}
],

/*
	Patrol Boat Interactions
*/
[
	"A3PL_Patrol",
	localize"STR_INTSECT_UNLOCKPATROL",
	{
		private _veh = player_objintersect;
		if(_veh getVariable["locked",true]) then {
			_veh setVariable["locked",false,true];
		} else {
			_veh setVariable["locked",true,true];
		};
	}
],
[
	"A3PL_Patrol",
	localize"STR_INTSECT_DRIVESHIP",
	{player moveInDriver player_objintersect;}
],
[
	"A3PL_Patrol",
	localize"STR_INTSECT_CARGOSHIP",
	{player moveInCargo player_objintersect;}
],
[
	"A3PL_Patrol",
	localize"STR_INTSECT_CONTREXTING",
	{player moveInCommander player_objintersect;}
],
[
	"A3PL_Jayhawk",
	"Board Helicopter (Seat)",
	{
		[player_objintersect] spawn {
			private _veh = _this select 0;
			_veh animate ["door3",1];
			uiSleep 0.5;
			_veh lock 1;
			moveOut player;
			_value = getNumber (configFile >> "CfgVehicles" >> (typeOf _veh) >> "transportSoldier");_list = fullCrew [_veh, "cargo"];_freeseats = count _list;if (_freeseats >= _value) exitwith {};
			player action ["GetInCargo", _veh];
			_veh lock 2;
		};
	}
],
[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_BOARDHELISSIDE",
	{
		[player_objintersect] spawn {
			private _veh = _this select 0;
			_veh lock 1;
			moveOut player;
			player action ["GetInTurret", _veh,[1]];
			_veh lock 2;
		};
	}
],
[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_SWITCHBAT",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "Battery" < 0.5) exitwith {
			_veh animate ["battery",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["battery",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_APUGEN",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "gen1" < 0.5) exitwith {
			if (_veh animationPhase "battery" < 0.5) exitwith {["Battery is off","red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "ecs" < 0.5) exitwith {["ECS is not on APU Boost","red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "fuelpump" > 0.5) exitwith {["Fuel Pump is not on APU Boost","red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "apucontrol" < 0.5) exitwith {["APU Control is not on APU Boost","red"] call A3PL_Player_Notification;};
			_veh animate ["gen1",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["gen1",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3PL_Jayhawk",
	format [localize"STR_INTSECT_ENGGEN",1],
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "gen2" < 0.5) exitwith {
			_veh animate ["gen2",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["gen2",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3PL_Jayhawk",
	format [localize"STR_INTSECT_ENGGEN",2],
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "gen3" < 0.5) exitwith {
			_veh animate ["gen3",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["gen3",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_ECSSTART",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "ecs" < 0.5) exitwith {
			_veh animate ["ecs",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["ecs",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_FUELPUMP",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "fuelpump" < 0.5) exitwith {
			_veh animate ["fuelpump",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["fuelpump",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_APUCONT",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "apucontrol" < 0.5) exitwith {
			_veh animate ["apucontrol",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["apucontrol",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_SWITCHIGN",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "ignition_Switch" > 0.5) exitwith {
			_veh animate ["ignition_Switch",0];
			_veh engineOn false;
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		if (_veh animationPhase "ignition_Switch" < 0.5) exitwith {
			if (_veh animationPhase "battery" < 0.5) exitwith {["Battery is turned off", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "ecs" > 0.5) exitwith {["ECS is not on Engine", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "fuelpump" < 0.5) exitwith {["Fuel Pump is not on Fuel Prime", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "apucontrol" < 0.5) exitwith {["APU Control is not on APU Boost", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "gen1" < 0.5) exitwith {["APU is OFF", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "ctail" > 0.5) exitwith {["Helicopter is not unfolded", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "gen2" < 0.5) exitwith {["Generator 2 is not turned on", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "gen3" < 0.5) exitwith {["Generator 3 is not turned on", "red"] call A3PL_Player_Notification;};
			_veh animate ["gen1",0];
			_veh animate ["ignition_Switch",1];
			[_veh] spawn {
				private ['_veh'];
				_veh = _this select 0;
				sleep 1;
				_veh engineOn true;
			};
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["ignition_Switch",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"",
	localize"STR_INTSECT_TOGGLEFLOATS",
	{
		private _veh = player_objintersect;
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Battery is turned off", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Floats" < 0.5) then {
			 _veh animateSource ["Floats",1];
		} else {
			_veh animateSource ["Floats",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TOGGLEFP",
	{
		private _veh = player_objintersect;
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Battery is turned off", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Fuelpump" < 0.5) then {
			 _veh animateSource ["Fuelpump",1];
		} else {
			_veh animateSource ["Fuelpump",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TOGGLEBAT",
	{
		private _veh = player_objintersect;
		if (_veh animationSourcePhase "Batteries" < 0.9) then {
			 _veh animateSource ["Batteries",1];
		} else {
			_veh animateSource ["Batteries",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_ADJFLDWN",
	{
		private _veh = player_objintersect;
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Battery is turned off", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Flaps" < 0.5) then {
			 _veh animateSource ["Flaps",0.5];
			 player action ["flapsDown",_veh];
		} else {
			if (_veh animationSourcePhase "Flaps" == 0.5) then {
				_veh animateSource ["Flaps",1];
				player action ["flapsDown",_veh];
			};
		};
	}
],
[
	"",
	localize"STR_INTSECT_ADJFLUP",
	{
		_veh = player_objintersect;
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Battery is turned off", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Flaps" > 0.5) then {
			 _veh animateSource ["Flaps",0.5];
			 player action ["flapsUp",_veh];
		} else {
			if (_veh animationSourcePhase "Flaps" == 0.5) then {
				_veh animateSource ["Flaps",0];
				player action ["flapsUp",_veh];
			};
		};
	}
],
[
	"",
	localize"STR_INTSECT_SWITCHGEN",
	{
		private _veh = player_objintersect;
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Battery is turned off", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Generator" < 0.5) then {
			 _veh animateSource ["Generator",1];
		} else {
			_veh animateSource ["Generator",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_SWITCHIGN2",
	{
		private _veh = player_objintersect;
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Battery is turned off", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Generator" < 0.9 && (_veh isKindOf "A3PL_Goose_Base")) exitwith {["Generator is turned off", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Fuelpump" < 0.9) exitwith {["Fuel Pump is turned off", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Ignition" < 0.9) then {
			if (!(_veh getVariable ["clearance",false])) exitwith {["No ATC clearance, please switch to 126mhz for clearance", "red"] call A3PL_Player_Notification;};
			_veh animateSource ["Ignition",1];
			uiSleep 0.5;
			_veh engineOn true;
		} else {
			_veh animateSource ["Ignition",0];
			_veh engineOn false;
		};
	}
],
[
	"",
	"Switch Ignition/Starter Left",
	{
		private _veh = player_objintersect;
		if (!(_veh isKindOf "A3PL_Goose_Base")) exitwith {};
		if (_veh animationSourcePhase "goose_bat" < 0.9) exitwith {["Battery is turned off", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "goose_gen" < 0.9) exitwith {["Generator is turned off", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "goose_fuelpump" < 0.9) exitwith {["Fuel Pump is turned off", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "goose_ign" == 0.5) then {
			private _lEngRPM1 = _veh animationPhase "rotorL";
			uiSleep 0.1;
			if (_lEngRPM1 == (_veh animationPhase "rotorL")) then {
				_leftEngineOn = false;
			} else {
				_leftEngineOn = true;
			};
			if (_leftEngineOn) then {
				_veh animate ["rotorL",(_veh animationPhase "rotorL")];
				_veh animateSource ["goose_ign",0];
			} else {
				if (!isEngineOn _veh) exitwith {["Startup the right engine first", "red"] call A3PL_Player_Notification;};
				_veh animateSource ["goose_ign",0];
				_veh animate ["rotorL",10000];
			};
			_t = 0;
			waituntil {sleep 1; _t = _t + 1; if (_t > 4) exitwith{}; _veh animationSourcePhase "goose_ign" == 0};
			_veh animateSource ["goose_ign",0.5];
		};
	}
],
[
	"",
	localize"STR_INTSECT_EXRELADDER",
	{[player_objintersect,"ladder",false] call A3PL_Lib_ToggleAnimation;}
],
[
	"",
	localize"STR_INTSECT_PICKUPLAD",
	{[player_objintersect] spawn A3PL_Pickup_Ladder;}
],
[
	"",
	format [localize"STR_INTSECT_CLIMBUPL",1],
	{player action ["ladderUp", player_objIntersect, 0, 0];}
],
[
	"",
	format [localize"STR_INTSECT_CLIMBUPL",2],
	{player action ["ladderUp", player_objIntersect, 1, 0];}
],
[
	"",
	format [localize"STR_INTSECT_CLIMBUPL",3],
	{player action ["ladderUp", player_objIntersect, 2, 0];}
],
[
	"",
	format [localize"STR_INTSECT_CLIMBUPL",4],
	{player action ["ladderUp", player_objIntersect, 3, 0];}
],
[
	"",
	format [localize"STR_INTSECT_CLIMBUPL",5],
	{player action ["ladderUp", player_objIntersect, 4, 0];}
],
[
	"",
	format [localize"STR_INTSECT_CLIMBDOWNL",1],
	{player action ["ladderDown", player_objIntersect, 0, 1];}
],

[
	"",
	format [localize"STR_INTSECT_CLIMBDOWNL",2],
	{player action ["ladderDown", player_objIntersect, 1, 1];}
],
[
	"",
	format [localize"STR_INTSECT_CLIMBDOWNL",3],
	{player action ["ladderDown", player_objIntersect, 2, 1];}
],
[
	"",
	format [localize"STR_INTSECT_CLIMBDOWNL",4],
	{player action ["ladderDown", player_objIntersect, 3, 1];}
],
[
	"",
	format [localize"STR_INTSECT_CLIMBDOWNL",5],
	{player action ["ladderDown", player_objIntersect, 4, 1];}
],
[
	"",
	localize"STR_INTSECT_TOGCOLLIGHT",
	{
		private _veh = player_objIntersect;
		private _collisionLightOn = _veh getVariable ["collisionLightOn",false];
		if (_collisionLightOn) then {
			player action ["CollisionLightOff", _veh];
			_veh animateSource ["collision_lights",0];
			_veh setVariable ["collisionLightOn",false,true];
			[localize"STR_QuickActions_Notif_Vehicles_CollisionLightsOFF", "red"] call A3PL_Player_Notification;
		} else {
			player action ["CollisionLightOn", _veh];
			_veh animateSource ["collision_lights",1];
			_veh setVariable ["collisionLightOn",true,true];
			[localize"STR_QuickActions_Notif_Vehicles_CollisionLightsON", "green"] call A3PL_Player_Notification;
		};
	}
],
[
    "",
    localize"STR_INTSECT_TOGGRAMP",
    {
        private _veh = player_objintersect;
        if ((_veh animationSourcePhase "truck_flatbed") < 0.3) then {
            [_veh,0] spawn A3PL_Vehicle_TowTruck_Ramp_down;
        } else {
			[_veh,-0.230112] spawn A3PL_Vehicle_TowTruck_Ramp_up;
        };
    }
],
[
    "",
    localize"STR_INTSECT_TOGREARSPOTL",
    {
		private _veh = player_objintersect;
		if (_veh animationPhase "Spotlights" < 0.5) then {
			_veh animate ["Spotlight_Switch",1];_veh animate ["Spotlights",1];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOn",_veh];};
		} else {
			_veh animate ["Spotlight_Switch",0];_veh animate ["Spotlights",0];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOff",_veh];};
		};
    }
],
[
    "",
    localize"STR_INTSECT_ENTERASENG",
    {
		private _veh = player_objIntersect;
		_veh lock 0;
		player action ["getInCargo", _veh, 0];
		_veh lock 2;
    }
],
[
    "",
    localize"STR_INTSECT_ENTASCAP",
    {
		private _veh = player_objIntersect;
		_veh lock 0;
		player action ["getInTurret", _veh, [1]];
		_veh lock 2;
    }
],
[
    "",
    localize"STR_INTSECT_ENTERASGUN",
    {
		private _veh = player_objIntersect;
		_veh lock 0;
		player action ["getInTurret", _veh, [0]];
		_veh lock 2;
    }
],
[
    "",
    localize"STR_INTSECT_ENTERASBOWG",
    {
    	private _veh = player_objIntersect;
		_veh lock 0;
		player action ["getInTurret", _veh, [2]];
		_veh lock 2;
    }
],
[
	"",
	localize"STR_INTSECT_TOGLPF",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Platform_1" isEqualTo 0) then {
			_veh animate ["Platform_1",1];
		} else {
			_veh animate ["Platform_1",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TOGRPF",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Platform_2" isEqualTo 0) then {
			_veh animate ["Platform_2",1];
		} else{
			_veh animate ["Platform_2",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_GRABLLB",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Lifebuoy_1" isEqualTo 0) then
		{
			_veh animate ["Lifebuoy_1",1];
			["Lifebuoy",1] call A3PL_Inventory_add;
			["Lifebuoy"] call A3PL_Inventory_Use;
			sleep 2;
			private _Lifebuoy = Player_Item;
			_Lifebuoy setVariable ["locked",false,true];
			private _rope = ropeCreate [_veh, "Lifebuoy_1_point", _Lifebuoy, [0.00587467,0.55251,0.329934], 15];
			_veh setVariable ["Left_rope",_rope,true];
		};
	}
],
[
	"",
	localize"STR_INTSECT_PUTBACKLLB",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Lifebuoy_1" == 1 && player_itemClass == "Lifebuoy") then
		{
			[false] call A3PL_Inventory_PutBack;
			["Lifebuoy",-1] call A3PL_Inventory_add;
			_veh animate ["Lifebuoy_1",0];
			private _rope = _veh getVariable "Left_rope";
			ropeDestroy _rope;
		};
	}
],
[
	"",
	localize"STR_INTSECT_GRABRLB",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Lifebuoy_2" == 0) then
		{
			_veh animate ["Lifebuoy_2",1];
			["Lifebuoy",1] call A3PL_Inventory_add;
			["Lifebuoy"] call A3PL_Inventory_Use;
			sleep 2;
			private _Lifebuoy = Player_Item;
			private _rope = ropeCreate [_veh, "Lifebuoy_2_point", _Lifebuoy, [0.00587467,0.55251,0.329934], 15];
			_Lifebuoy setVariable ["locked",false,true];
			_veh setVariable ["Right_rope",_rope,true];
		};
	}
],
[
	"",
	localize"STR_INTSECT_PBRLIFEB",
	{
		private _veh = player_objIntersect;
		if (((_veh animationPhase "Lifebuoy_2") isEqualTo 1) && (player_itemClass isEqualTo "Lifebuoy")) then {
			[false] call A3PL_Inventory_PutBack;
			["Lifebuoy",-1] call A3PL_Inventory_add;
			_veh animate ["Lifebuoy_2",0];
			private _rope = _veh getVariable "Right_rope";
			ropeDestroy _rope;
		};
	}
],
[
    "",
    localize"STR_INTSECT_REARFLOODL",
    {
        private _veh = vehicle player;
        if (_veh animationPhase "Ambo_Switch_7" < 0.5) then {
            _veh animate ["Ambo_Switch_7",1];_veh animate ["R_Floodlights",1];
        } else {
            _veh animate ["Ambo_Switch_7",0];_veh animate ["R_Floodlights",0];
        };
    }
],
[
    "",
    localize"STR_INTSECT_INTLIGHTS",
    {
        private _veh = vehicle player;
        if (_veh animationPhase "Ambo_Switch_10" < 0.5) then {
            _veh animate ["Ambo_Switch_10",1];_veh animate ["Interior_Lights",1];
        } else {
            _veh animate ["Ambo_Switch_10",0];_veh animate ["Interior_Lights",0];
        };
    }
],
[
    "",
    localize"STR_INTSECT_USESTRETCH",
    {
        /*_veh = player_objIntersect;
        if((typeOf _veh) == "A3PL_EMS_Stretcher") then {
        	[player_objintersect] spawn A3PL_Pickup_Stretcher;
        } else {
        	if (_veh animationSourcePhase "Stretcher" == 0) then
       		{
           		_veh animateSource ["Stretcher", 25];	//21
           		sleep 7;
           		_stretcher = createVehicle ["A3PL_EMS_Stretcher", (_veh modelToWorld [0,-4.5,-1.8]), [], 0, "CAN_COLLIDE"];
           		_stretcher setDir(360 + (getDir _veh));
           		_stretcher setVariable["locked",false,true];
           		_stretcher setVariable["class","stretcher",true];
	        };
        };*/
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Stretcher" isEqualTo 0) then {
       		_veh animateSource ["Stretcher", 21];
       	} else {
       		_veh animateSource ["Stretcher", 0];
       	};
    }
],
[
    "",
    localize"STR_INTSECT_STORESTRETCH",
    {
		private _veh = player_objIntersect;
		private _ambo = nearestObjects[player, ["A3PL_E350","jonzie_ambulance"],5];
		if(count _ambo == 0) exitwith {};
		_ambo = _ambo select 0;
		_ambo animateSource ["Stretcher", 0];
		deleteVehicle _veh;
    }
],
[
	"",
	localize"STR_INTSECT_TAKELADDER",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Ladder" isEqualTo 0) then {
			_veh animate ["Ladder",1];
			private _Ladder = createVehicle ["A3PL_Ladder", position player, [], 0, "CAN_COLLIDE"];
			_Ladder setVariable ["class","Ladder",true];
			[_Ladder] spawn A3PL_Pickup_Ladder;
		};
	}
],
[
	"",
	localize"STR_INTSECT_PUTBACKLAD",
	{
		private _veh = player_objIntersect;
		private _Ladder = nearestObject [player, "A3PL_Ladder"];
		if ((_veh animationPhase "Ladder") isEqualTo 1) then	{
			detach _Ladder;
			deleteVehicle _Ladder;
			_veh animate ["Ladder",0];
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_TAKEHOSE",1],
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Hose_1" < 0.99) then {
			private _val = _veh animationPhase "Hose_1";
			private _valu = _val + 0.25;
			if (_valu >= 1) then {_valu = 1};
			_veh animate ["Hose_1",_valu];
			["FD_Hose",1] call A3PL_Inventory_add;
			["FD_Hose"] call A3PL_Inventory_Use;
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_TAKEHOSE",2],
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Hose_2" < 0.99) then {
			private _val = _veh animationPhase "Hose_2";
			private _valu = _val + 0.25;
			if (_valu >= 1) then {_valu = 1};
			_veh animate ["Hose_2",_valu];
			["FD_Hose",1] call A3PL_Inventory_add;
			["FD_Hose"] call A3PL_Inventory_Use;
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_TAKEHOSE",3],
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Hose_3" < 0.99) then
		{
			private _val = _veh animationPhase "Hose_3";
			private _valu = _val + 0.25;
			if (_valu >= 1) then {_valu = 1};
			_veh animate ["Hose_3",_valu];
			["FD_Hose",1] call A3PL_Inventory_add;
			["FD_Hose"] call A3PL_Inventory_Use;
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_TAKEHOSE",4],
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Hose_4" < 0.99) then {
			private _val = _veh animationPhase "Hose_4";
			private _valu = _val + 0.25;
			if (_valu >= 1) then {_valu = 1};
			_veh animate ["Hose_4",_valu];
			["FD_Hose",1] call A3PL_Inventory_add;
			["FD_Hose"] call A3PL_Inventory_Use;
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_TAKEHOSE",5],
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Hose_5" < 0.99) then
		{
			private _val = _veh animationPhase "Hose_5";
			private _valu = _val + 0.25;
			if (_valu >= 1) then {_valu = 1};
			_veh animate ["Hose_5",_valu];
			["FD_Hose",1] call A3PL_Inventory_add;
			["FD_Hose"] call A3PL_Inventory_Use;
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_PUTBACKHOSE",1],
	{
		private _veh = player_objIntersect;
		if (player_itemClass == "FD_Hose") then {
			[false] call A3PL_Inventory_PutBack;
			["FD_Hose",-1] call A3PL_Inventory_add;
			private _val = _veh animationPhase "Hose_1";
			private _valu = _val - 0.25;
			if (_valu <= 0) then {_valu = 0};
			_veh animate ["Hose_1",_valu];
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_PUTBACKHOSE",2],
	{
		private _veh = player_objIntersect;
		if (player_itemClass == "FD_Hose") then
		{
			[false] call A3PL_Inventory_PutBack;
			["FD_Hose",-1] call A3PL_Inventory_add;
			private _val = _veh animationPhase "Hose_2";
			private _valu = _val - 0.25;
			if (_valu <= 0) then {_valu = 0};
			_veh animate ["Hose_2",_valu];
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_PUTBACKHOSE",3],
	{
		private _veh = player_objIntersect;
		if (player_itemClass == "FD_Hose") then {
			[false] call A3PL_Inventory_PutBack;
			["FD_Hose",-1] call A3PL_Inventory_add;
			private _val = _veh animationPhase "Hose_3";
			private _valu = _val - 0.25;
			if (_valu <= 0) then {_valu = 0};
			_veh animate ["Hose_3",_valu];
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_PUTBACKHOSE",4],
	{
		private _veh = player_objIntersect;
		if (player_itemClass == "FD_Hose") then
		{
			[false] call A3PL_Inventory_PutBack;
			["FD_Hose",-1] call A3PL_Inventory_add;
			private _val = _veh animationPhase "Hose_4";
			private _valu = _val - 0.25;
			if (_valu <= 0) then {_valu = 0};
			_veh animate ["Hose_4",_valu];
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_PUTBACKHOSE",5],
	{
		private _veh = player_objIntersect;
		if (player_itemClass == "FD_Hose") then
		{
			[false] call A3PL_Inventory_PutBack;
			["FD_Hose",-1] call A3PL_Inventory_add;
			private _val = _veh animationPhase "Hose_5";
			private _valu = _val - 0.25;
			if (_valu <= 0) then {_valu = 0};
			_veh animate ["Hose_5",_valu];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TOGCONTCOV",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Controller_Cover" == 0) then {
			_veh animate ["Controller_Cover",1];
		} else {
			_veh animate ["Controller_Cover",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TOGDSFOUT",
	{
		private _veh = vehicle player;
		if (_veh animationPhase "Outrigger_1" == 0) then {
			_veh animate ["Outrigger_1",1];_veh animate ["Outrigger_1_1_Flash",1];_veh animate ["Outrigger_1_2_Flash",1];_veh animate ["FT_Switch_1",1];
		} else {
			_veh animate ["Outrigger_1",0];_veh animate ["Outrigger_1_1_Flash",0];_veh animate ["Outrigger_1_2_Flash",0];_veh animate ["FT_Switch_1",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TOGDROUT",
	{
		private _veh = vehicle player;
		if (_veh animationPhase "Outrigger_2" == 0) then {
			_veh animate ["Outrigger_2",1];_veh animate ["Outrigger_2_1_Flash",1];_veh animate ["Outrigger_2_2_Flash",1];_veh animate ["FT_Switch_2",1];
		} else {
			_veh animate ["Outrigger_2",0];_veh animate ["Outrigger_2_1_Flash",0];_veh animate ["Outrigger_2_2_Flash",0];_veh animate ["FT_Switch_2",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TOGPSFOUT",
	{
		private _veh = vehicle player;
		if (_veh animationPhase "Outrigger_3" == 0) then {
			_veh animate ["Outrigger_3",1];_veh animate ["Outrigger_3_1_Flash",1];_veh animate ["Outrigger_3_2_Flash",1];_veh animate ["FT_Switch_3",1];
		} else {
			_veh animate ["Outrigger_3",0];_veh animate ["Outrigger_3_1_Flash",0];_veh animate ["Outrigger_3_2_Flash",0];_veh animate ["FT_Switch_3",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TOGPSROUT",
	{
		private _veh = vehicle player;
		if (_veh animationPhase "Outrigger_4" == 0) then {
			_veh animate ["Outrigger_4",1];_veh animate ["Outrigger_4_1_Flash",1];_veh animate ["Outrigger_4_2_Flash",1];_veh animate ["FT_Switch_4",1];
		} else {
			_veh animate ["Outrigger_4",0];_veh animate ["Outrigger_4_1_Flash",0];_veh animate ["Outrigger_4_2_Flash",0];_veh animate ["FT_Switch_4",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TORADSOUT",
	{
		private _veh = vehicle player;
		if (_veh animationPhase "OutriggerFoot_1" isEqualTo 0) then {
			_veh animate ["OutriggerFoot_1",1];_veh animate ["OutriggerFoot_2",1];_veh animate ["FT_Switch_5",1];
		} else {
			_veh animate ["OutriggerFoot_1",0];_veh animate ["OutriggerFoot_2",0];_veh animate ["FT_Switch_5",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TORAPSOUT",
	{
		private _veh = vehicle player;
		if (_veh animationPhase "OutriggerFoot_3" isEqualTo 0) then {
			_veh animate ["OutriggerFoot_3",1];_veh animate ["OutriggerFoot_4",1];_veh animate ["FT_Switch_6",1];
		} else {
			_veh animate ["OutriggerFoot_3",0];_veh animate ["OutriggerFoot_4",0];_veh animate ["FT_Switch_6",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_PSFLOODL",
	{
		private _veh = vehicle player;
		if (_veh animationPhase "PS_Floodlights" isEqualTo 0) then {
			_veh animate ["FT_Switch_9",1];_veh animate ["PS_Floodlights",1];
		} else {
			_veh animate ["FT_Switch_9",0];_veh animate ["PS_Floodlights",0];
		};
		if (_veh animationPhase "ft_switch_9" < 0.5) then {
			_veh animate ["ft_switch_9",1];_veh animate ["driver_floodlight",1];
			_veh setHit ["light_s",1];
		} else {
			_veh animate ["ft_switch_9",0];_veh animate ["driver_floodlight",0];
			_veh setHit ["light_s",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_DSFLOODL",
	{
		private _veh = vehicle player;
		if (_veh animationPhase "DS_Floodlights" isEqualTo 0) then {
			_veh animate ["FT_Switch_8",1];_veh animate ["DS_Floodlights",1];
		} else {
			_veh animate ["FT_Switch_8",0];_veh animate ["DS_Floodlights",0];
		};
		if (_veh animationPhase "ft_switch_8" < 0.5) then {
			_veh animate ["ft_switch_8",1];_veh animate ["passenger_floodlight",1];
			_veh setHit ["light_s2",1];
		} else {
			_veh animate ["ft_switch_8",0];_veh animate ["passenger_floodlight",0];
			_veh setHit ["light_s2",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_PERILIGHT",
	{
		private _veh = vehicle player;
		if (_veh animationPhase "FT_Switch_10" isEqualTo 0) then {
			_veh animate ["FT_Switch_10",1];_veh animate ["DS_Floodlights",1];_veh animate ["PS_Floodlights",1];_veh animate ["FT_Switch_8",0];_veh animate ["FT_Switch_9",0];
		} else {
			_veh animate ["FT_Switch_10",0];_veh animate ["DS_Floodlights",0];_veh animate ["PS_Floodlights",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_LADDERFLOODL",
	{
		private _veh = vehicle player;
		if (_veh animationPhase "Ladder_Spotlight" isEqualTo 0) then {
			_veh animate ["FT_Switch_11",1];_veh animate ["Ladder_Spotlight",1];
		} else {
			_veh animate ["FT_Switch_11",0];_veh animate ["Ladder_Spotlight",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_LADDERCAM",
	{
		private _veh = vehicle player;
		if (_veh animationPhase "Ladder_Cam" isEqualTo 0) then {
			_veh animate ["FT_Switch_12",1];_veh animate ["Ladder_Cam",1];_veh animate ["Reverse_Cam",0];
		} else {
			_veh animate ["FT_Switch_12",0];_veh animate ["Ladder_Cam",0];
		};
	}
],
[
    "",
    localize"STR_INTSECT_ENTASLADOP",
    {
        private _veh = player_objIntersect;
		_veh lock 0;
		player action ["getInTurret", _veh, [0]];
		_veh lock 2;
    }
],
[
	"",
	localize"STR_INTSECT_LORALADRACK",
	{
		private _veh = player_objIntersect;
		if ((_veh animationSourcePhase "Ladder_Holder") isEqualTo 0) then{
			_veh animateSource  ["Ladder_Holder", 1];
		} else {
			_veh animateSource  ["Ladder_Holder", 0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TONOFFPUMP",
	{
		private _veh = player_objIntersect;
		if (!(_veh isKindOf "Car")) exitwith {};
		if (_veh animationPhase "FT_Pump_Switch" isEqualTo 0) then {
			_veh animate ["FT_Pump_Switch", 1];
			_PumpSound = createSoundSource ["A3PL_FT_Pump", getpos _veh, [], 0];
			_PumpSound attachTo [_veh, [0, 0, 0], "pos_switches"];
			_veh setVariable ["PumpSound",_PumpSound,true];
			[_veh] spawn A3PL_FD_LadderHeavyLoop;
		} else {
			_veh animate ["FT_Pump_Switch", 0];
			_PumpSound = _veh getVariable "PumpSound";
			deleteVehicle _PumpSound;
		};
	}
],
[
	"A3PL_Pierce_Pumper",
	localize"STR_INTSECT_OPCLDISCH",
	{
		private _veh = player_objintersect;
		private _animName = player_nameintersect;
		if (_animName isEqualTo "") exitwith {};
		if (_animName == "ft_lever_8" && (_veh animationPhase "ft_lever_8" < 0.5)) then {
			[_veh] spawn A3PL_FD_EngineLoop;
		};
		[_veh,_animName,false] call A3PL_Lib_ToggleAnimation;
	}
],
[
	"A3PL_Silverado_FD_Brush",
	localize"STR_INTSECT_OPCLDISCH",
	{
		private _veh = player_objintersect;
		private _animName = player_nameintersect;
		if (_animName isEqualTo "") exitwith {};
		if (((_animName == "bt_lever_1") && (_veh animationPhase "bt_lever_1" < 0.5))) then {
			[_veh] spawn A3PL_FD_BrushLoop;
		};
		[_veh,_animName,false] call A3PL_Lib_ToggleAnimation;
	}
],
[
	"",
	localize"STR_INTSECT_OPCLINLET",
	{
		private _veh = player_objintersect;
		private _animName = player_nameintersect;

		if(_animName isEqualTo "") exitWith {};
		if((typeOf _veh) isEqualTo "A3PL_Pierce_Pumper") then {
			if (_animName isEqualTo "ft_lever_8" && (_veh animationPhase "ft_lever_8" < 0.5)) then {
				[_veh] spawn A3PL_FD_EngineLoop;
			};
		};
		if((typeOf _veh) isEqualTo "A3PL_Silverado_FD_Brush") then {
			if (((_animName isEqualTo "bt_lever_1") && (_veh animationPhase "bt_lever_1" < 0.5))) then {
				[_veh] spawn A3PL_FD_BrushLoop;
			};
		};
		[_veh,_animName,false] call A3PL_Lib_ToggleAnimation;
	}
],
[
	"A3PL_Pierce_Heavy_Ladder",
	localize"STR_INTSECT_CONHOSETOLADIN",
	{[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;}
],
[
	"",
	localize"STR_INTSECT_CONHOSETOENGIN",
	{[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;}
],
[
	"",
	localize"STR_INTSECT_CONHOSETOENGDIS",
	{[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;}
],
[
    "",
    localize"STR_INTSECT_TGLFAIRAVAIL",
    {
		private _veh = player_objintersect;
		if ((_veh animationSourcePhase "Fair_Available") < 0.5) then {
			_veh animateSource ["Fair_Available",1];
		} else {
			_veh animateSource ["Fair_Available",0];
		};
    }
],
[
	"",
	localize"STR_INTSECT_STARTFAIR",
	{[player_objIntersect] call A3PL_JobTaxi_FareStart;}
],
[
	"",
	localize"STR_INTSECT_PAUSEFAIR",
	{[player_objIntersect] call A3PL_JobTaxi_FarePause;}
],
[
	"",
	localize"STR_INTSECT_STOPFAIR",
	{[player_objIntersect] call A3PL_JobTaxi_FarePause;}
],
[
	"",
	localize"STR_INTSECT_RESETFAIR",
	{[player_objIntersect] call A3PL_JobTaxi_FareReset;}
],
[
	"",
	localize"STR_INTSECT_ENTCODR",
	{
		[player_objIntersect] spawn {
			private _veh = param [0,objNull];
			_veh animateDoor ["Door_RF", 1];
			sleep 0.4;
			player moveInGunner _veh;
			_veh animateDoor ["Door_RF", 0];
		};
	}
],
[
    "A3PL_P362",
    localize"STR_INTSECT_AIRSUSCONT",
    {
        private _veh = player_objintersect;
        if (_veh animationSourcePhase "ASC" < 0.8) then {
            _veh animate ["ASC_Switch",1];
			_veh animateSource ["ASC",1];
			_veh setCenterOfMass [[0.00631652,0.1,-1.03015],8];
			_veh setMass [35000,8];
        } else {
            _veh animate ["ASC_Switch",0];
			_veh animateSource ["ASC",0];
			_veh setMass [13000,8];
			_veh setCenterOfMass [[0.00631652,-0.28197,-1.03015],8];
        };
    }
],
[
    "",
    localize"STR_INTSECT_LEFTALLLIGHT",
    {
        private _veh = player_objintersect;
        if (_veh animationPhase "PD_Switch_9" < 0.5) then {
            _veh animate ["PD_Switch_9",1];
			_veh animate ["DS_Floodlights",1];
        } else {
            _veh animate ["PD_Switch_9",0];
			_veh animate ["DS_Floodlights",0];
        };
    }
],
[
    "",
    localize"STR_INTSECT_RIGHTALLLIGHT",
    {
        private _veh = player_objintersect;
        if (_veh animationPhase "PD_Switch_10" < 0.5) then {
            _veh animate ["PD_Switch_10",1];_veh animate ["PS_Floodlights",1];
        } else {
            _veh animate ["PD_Switch_10",0];_veh animate ["PS_Floodlights",0];
        };
    }
],
[
    "",
    localize"STR_INTSECT_TOGSPOTLIGHT",
    {
        private _veh = player_objintersect;
        if (_veh animationSourcePhase "Spotlight" < 0.5 && _veh animationPhase "Spotlight_Addon" > 0.5) then {
            _veh animateSource ["Spotlight",1];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOn",_veh];};
        } else {
            _veh animateSource ["Spotlight",0];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOff",_veh];};
        };

    }
],
[
    "",
    localize"STR_INTSECT_RADARMASTER",
    {
        private _veh = player_objintersect;
        if (_veh animationPhase "Radar_Master" < 0.5) then {
            _veh animate ["Radar_Master",1];
			if ((_veh animationPhase "Radar_Front" < 0.5) && (_veh animationPhase "Radar_Rear" < 0.5)) then {_veh animate ["Radar_Front",1];};
        } else {
            _veh animate ["Radar_Master",0];
        };
    }
],
[
    "",
    localize"STR_INTSECT_REARRADAR",
    {
        private _veh = player_objintersect;
		if (_veh animationPhase "Radar_Rear" < 0.5) then {
            _veh animate ["Radar_Rear",1];
			_veh animate ["Radar_Front",0];
			if (player == driver _veh) then {
				_veh setVariable ["forward",false,false];
			} else {
				_veh setVariable ["forward",false,true];
			};
        };
    }
],
[
    "",
    localize"STR_INTSECT_FRONTRADAR",
    {
        _veh = player_objintersect;
		if (_veh animationPhase "Radar_Front" < 0.5) then {
            _veh animate ["Radar_Front",1];
			_veh animate ["Radar_Rear",0];
			if (player == driver _veh) then {
				_veh setVariable ["forward",true,false];
			} else {
				_veh setVariable ["forward",true,true];
			};
        };
    }
],
[
	"",
	localize"STR_INTSECT_RESETLOCKFAST",
	{
		private _veh = vehicle player;
		if (player == driver _veh) then {
			_veh setVariable ["lockfast",nil,false];
			_veh setVariable ["locktarget",nil,false];
			[_veh,"lockfast",0] call A3PL_Police_RadarSet;
			[_veh,"locktarget",0] call A3PL_Police_RadarSet;
		} else {
			_veh setVariable ["lockfast",nil,true];
			_veh setVariable ["locktarget",nil,true];
			[_veh,"lockfast",0] call A3PL_Police_RadarSet;
			[_veh,"locktarget",0] call A3PL_Police_RadarSet;
		};
	}
],
[
    "",
    localize"STR_INTSECT_TURNONOFFLAP",
    {
        private _veh = player_objintersect;
        if (_veh animationPhase "Laptop_Top" < 0.5) then {
            _veh animateSource ["Laptop_Top",1];
        } else {
            _veh animateSource ["Laptop_Top",0];
        };
    }
],
[
    "",
    localize"STR_INTSECT_ACCPOLDB",
    {
    	if((typeOf player_objintersect) IN ["Land_A3FL_DOC_Gate","Land_A3PL_CH"]) then {
    		if (isNull (findDisplay 211) && (player getVariable ["job","unemployed"]) IN ["fisd","uscg","fims","doj"]) then {
				call A3PL_Police_DatabaseOpen;
			};
    	} else {
    		if (isNull (findDisplay 211) && (player_objintersect animationPhase "Laptop_Top" > 0.5)) then {
    			if ((player getVariable ["job","unemployed"]) isEqualTo "fifr") then {
    				call A3PL_FD_DatabaseOpen;
    			} else {
    				call A3PL_Police_DatabaseOpen;
    			};				
			};
    	};
    }
],
[
    "",
    localize"STR_INTSECT_SWIVELLAP",
    {
        _veh = player_objintersect;
        if (_veh animationPhase "Laptop" < 0.5) then {
            _veh animate ["Laptop",1];
        } else {
            _veh animate ["Laptop",0];
        };
    }
],
[
    "",
    localize"STR_INTSECT_HIGHBEAM",
    {
        private _veh = player_objintersect;
        if (_veh animationSourcePhase "High_Beam" == 0) then {
            _veh animate ["High_Beam_Switch",1];_veh animateSource ["High_Beam",1];
        } else {
            _veh animate ["High_Beam_Switch",0];_veh animateSource ["High_Beam",0];
        };
    }
],
[
	"",
	localize"STR_INTSECT_REVERSECAM",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "Reverse_Cam" == 0) then {
			_veh animate ["Reverse_Cam",1];
		} else {
			_veh animate ["Reverse_Cam",0];
		};
	}
],
[
    "",
    localize"STR_INTSECT_AIRHORN",
    {
        private _veh = player_objintersect;
        if (_veh animationPhase "FT_Switch_33" < 0.5) then  {
            [5] call A3PL_Vehicle_SirenHotkey;
        } else {
            [5] call A3PL_Vehicle_SirenHotkey;
						[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],
[
    "",
    localize"STR_INTSECT_ELECHORN",
    {
        private _veh = player_objintersect;
        if (_veh animationPhase "FT_Switch_34" < 0.5) then {
            [6] call A3PL_Vehicle_SirenHotkey;
        } else {
            [6] call A3PL_Vehicle_SirenHotkey;
			[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],
[
    "",
    localize"STR_INTSECT_ELECAIRH",
    {
        private _veh = player_objintersect;
        if (_veh animationPhase "FT_Switch_35" < 0.5) then {
            [7] call A3PL_Vehicle_SirenHotkey;
        } else {
            [7] call A3PL_Vehicle_SirenHotkey;
			[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],
[
    "",
    localize"STR_INTSECT_RUMBLERMAN",
    {
        private _veh = player_objintersect;
        if (_veh animationPhase "FT_Switch_36" < 0.5) then {
            [8] call A3PL_Vehicle_SirenHotkey;
        } else {
            [8] call A3PL_Vehicle_SirenHotkey;
			[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],
[
    "",
    localize"STR_INTSECT_T3YELP",
    {
        private _veh = player_objintersect;
        if (_veh animationPhase "FT_Switch_37" < 0.5) then {
            [9] call A3PL_Vehicle_SirenHotkey;
        } else {
            [9] call A3PL_Vehicle_SirenHotkey;
			[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],
[
    "",
    localize"STR_INTSECT_MASTERON",
    {[2] call A3PL_Vehicle_SirenHotkey;}
],
[
    "",
    localize"STR_INTSECT_TOGLIGHTB",
    {
       private _veh = player_objintersect;
        if (_veh animationSourcePhase "lightbar" < 0.5) then {
            [2] call A3PL_Vehicle_SirenHotkey;
        } else {
            [1] call A3PL_Vehicle_SirenHotkey;
        };
    }
],
[
    "",
    localize"STR_INTSECT_DIRECTMASTER",
    {
		private _veh = player_objintersect;
		if (_veh animationPhase "Directional_Switch" < 0.5) then {
		    _veh animate ["Directional_Switch",1];_veh animate ["Directional",1];if (_veh animationPhase "Directional_Control_Noob" == 0) then{_veh animate ["Directional_L",1];};if (_veh animationPhase "Directional_Control_Noob" == 17.5) then{_veh animate ["Directional",0];_veh animate ["Directional_S",0];_veh animate ["Directional_F",1];};
		} else {
		    _veh animate ["Directional_Switch",0];
		    if (_veh animationPhase "Directional_Control_Noob" == 17.5) then {
		    	_veh animate ["Directional_S",0];
		    	_veh animate ["Directional_F",0];
			};
			_veh animate ["Directional",0];
		};
    }
],
[
    "",
    localize"STR_INTSECT_DIRECTCONTR",
    {
        private _veh = player_objintersect;
        if (_veh animationPhase "Directional_Control_Noob" == 0) then {
            _veh animate ["Directional_Control_Noob",6.5];_veh animate ["Directional_L",0];_veh animate ["Directional_R",1];
        };
        if (_veh animationPhase "Directional_Control_Noob" == 6.5) then {
            _veh animate ["Directional_Control_Noob",12];_veh animate ["Directional_R",0];_veh animate ["Directional_S",1];
        };
        if (_veh animationPhase "Directional_Control_Noob" == 12) then {
            _veh animate ["Directional_Control_Noob",17.5];_veh animate ["Directional_S",0];if (_veh animationPhase "Directional_Switch" == 1) then {_veh animate ["Directional_F",1];_veh animate ["Directional",0];};
        };
        if (_veh animationPhase "Directional_Control_Noob" == 17.5) then {
            _veh animate ["Directional_Control_Noob",0];_veh animate ["Directional_F",0];_veh animate ["Directional_L",1];if (_veh animationPhase "Directional_Switch" == 1) then{_veh animate ["Directional",1];};
        };
    }
],
[
    "",
    localize"STR_INTSECT_SIRENMASTER",
    {
        private _veh = player_objintersect;
        if (_veh animationPhase "Siren_Control_Switch" < 0.5) then {
            _veh animate ["Siren_Control_Switch",1];
			[3] call A3PL_Vehicle_SirenHotkey;
        } else {
            _veh animate ["Siren_Control_Switch",0];
			[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
        if (_veh animationPhase "sirenswitch_1" < 0.5) then {
            _veh animate ["sirenswitch_1",1];
			[3] call A3PL_Vehicle_SirenHotkey;
        } else {
            _veh animate ["sirenswitch_1",0];
			[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],
[
    "",
    localize"STR_INTSECT_SIRENCONTR",
    {[4] call A3PL_Vehicle_SirenHotkey;}
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",1],
    {
        private _veh = player_objintersect;
        if (_veh animationSourcePhase "Cargo_Door_1" < 0.5) then {
            _veh animateSource ["Cargo_Door_1",1];
        } else {
            _veh animateSource ["Cargo_Door_1",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",2],
    {
       	private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_2" < 0.5) then {
            _veh animateSource ["Cargo_Door_2",1];
        } else {
            _veh animateSource ["Cargo_Door_2",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",3],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_3" < 0.5) then {
            _veh animateSource ["Cargo_Door_3",1];
        } else {
            _veh animateSource ["Cargo_Door_3",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",4],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_4" < 0.5) then {
            _veh animateSource ["Cargo_Door_4",1];
        } else {
            _veh animateSource ["Cargo_Door_4",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",5],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_5" < 0.5) then {
            _veh animateSource ["Cargo_Door_5",1];
        } else {
            _veh animateSource ["Cargo_Door_5",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",6],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_6" < 0.5) then {
            _veh animateSource ["Cargo_Door_6",1];
        } else {
            _veh animateSource ["Cargo_Door_6",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",7],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_7" < 0.5) then {
            _veh animateSource ["Cargo_Door_7",1];
        } else {
            _veh animateSource ["Cargo_Door_7",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",8],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_8" < 0.5) then {
            _veh animateSource ["Cargo_Door_8",1];
        } else {
            _veh animateSource ["Cargo_Door_8",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",9],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_9" < 0.5) then {
            _veh animateSource ["Cargo_Door_9",1];
        } else {
            _veh animateSource ["Cargo_Door_9",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",10],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_10" < 0.5) then {
            _veh animateSource ["Cargo_Door_10",1];
        } else {
            _veh animateSource ["Cargo_Door_10",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",11],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_11" < 0.5) then {
            _veh animateSource ["Cargo_Door_11",1];
        } else {
            _veh animateSource ["Cargo_Door_11",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",12],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_12" < 0.5) then {
            _veh animateSource ["Cargo_Door_12",1];
        } else {
            _veh animateSource ["Cargo_Door_12",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",13],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_13" < 0.5) then {
            _veh animateSource ["Cargo_Door_13",1];
        } else {
            _veh animateSource ["Cargo_Door_13",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",14],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_14" < 0.5) then {
            _veh animateSource ["Cargo_Door_14",1];
        } else {
            _veh animateSource ["Cargo_Door_14",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",15],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_15" < 0.5) then {
            _veh animateSource ["Cargo_Door_15",1];
        } else {
            _veh animateSource ["Cargo_Door_15",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",16],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_16" < 0.5) then {
            _veh animateSource ["Cargo_Door_16",1];
        } else {
            _veh animateSource ["Cargo_Door_16",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",17],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_17" < 0.5) then {
            _veh animateSource ["Cargo_Door_17",1];
        } else {
            _veh animateSource ["Cargo_Door_17",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",18],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_18" < 0.5) then {
            _veh animateSource ["Cargo_Door_18",1];
        } else {
            _veh animateSource ["Cargo_Door_18",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",19],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_19" < 0.5) then {
            _veh animateSource ["Cargo_Door_19",1];
        } else {
            _veh animateSource ["Cargo_Door_19",0];
        };
    }
],
[
    "",
    format [localize"STR_INTSECT_OCCOMPT",20],
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Cargo_Door_20" < 0.5) then {
            _veh animateSource ["Cargo_Door_20",1];
        } else {
            _veh animateSource ["Cargo_Door_20",0];
        };
    }
],
[
    "",
    localize"STR_INTSECT_OPCLDOOR",
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase player_nameintersect == 0) then {
            _veh animateDoor [player_nameintersect, 1];
        } else {
            _veh animateDoor [player_nameintersect, 0];
        };
    }
],
[
    "",
    localize"STR_INTSECT_OCLOCKERDOOR",
    {
    	private _obj = call A3PL_Intersect_cursortarget;
		private _name = Player_NameIntersect;
		private _split = _name splitstring "_";
		private _animationName = (_split select 0);
		if ((_obj animationSourcePhase _animationName) < 0.5) then {
			[_obj,true,true] remoteExec ["Server_Vehicle_EnableSimulation", 2];
			sleep 1.2;
			_obj animateSource [_animationName,1];
		} else {
			_obj animateSource [_animationName,0];
			waitUntil{(_obj animationSourcePhase _animationName) isEqualTo 0};
			[_obj,false,true] remoteExec ["Server_Vehicle_EnableSimulation", 2];
		};
	}
],
[
    "",
    localize"STR_INTSECT_LOCKERSTORE",
    {
		if (!isNull Player_Item) exitwith {
			call A3PL_Placeables_QuickAction;
		};
		private _attached = [] call A3PL_Lib_Attached;
		if (count _attached == 0) exitwith {};
		if ((typeOf (_attached select 0)) IN Config_Placeables) then {
			call A3PL_Placeables_QuickAction;
		};
    }
],
[
    "",
    localize"STR_INTSECT_BUYLOCKER",
    {[player_objintersect] call A3PL_Locker_Rent;}
],
[
	"",
	localize"STR_INTSECT_SELLLOCKER",
	{[player_objintersect] call A3PL_Locker_Sell;}
],
[
	"A3PL_MailTruck",
	localize"STR_INTSECT_OPCLMAILTD",
	{
		private _veh = player_objintersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_Lock", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "mailtruck_trunk" < 0.5) then	{
			_veh animateSource ["mailtruck_trunk",1];
		} else {
			_veh animateSource ["mailtruck_trunk",0];
		};
	}
],
[
	"A3PL_Drill_Trailer",
	localize"STR_INTSECT_REDRARM",
	{
		private _drill = player_objintersect;
		if (typeOf _drill != "A3PL_Drill_Trailer") exitwith {};
		private _a = _drill animationSourcePhase "drill_arm_position";
		if (_a > 0) exitwith {
			if (_drill animationSourcePhase "drill" > 0) exitwith {[localize"STR_QuickActions_Notif_Vehicles_DrillAnimationSourcePhase","red"] call A3PL_Player_Notification;};
			_drill animateSource ["drill_arm_position",0];
		};
		_drill animateSource ["drill_arm_position",1];
	}
],
[
	"A3PL_Drill_Trailer",
	localize"STR_INTSECT_REDRARMD",
	{[player_objintersect] call A3PL_JobWildcat_Drill;}
],
[
	"A3PL_PumpJack",
	localize"STR_INTSECT_STARTJPUMP",
	{
		[player_objintersect] call A3PL_JobOil_PumpStart;
	}
],

[
	"",
	"Refuel Jerrycan",
	{[player_objintersect] spawn A3PL_Hydrogen_Connect;}
],
[
	"",
	localize"STR_INTSECT_CONGASHOSE",
	{[player_objintersect] spawn A3PL_Hydrogen_Connect;}
],
[
	"",
	localize"STR_INTSECT_LRRAMP",
	{[player_objintersect] call A3PL_Vehicle_TrailerRamp;}
],
[
	"A3PL_Ski_Base",
	localize"STR_INTSECT_PUSKI",
	{
		if (!isNull player_item) exitwith {[localize"STR_QuickActions_Notif_Vehicles_DepositSki", "red"] call A3PL_Player_Notification;};
		call A3PL_Placeables_QuickAction;
	}
],
[
	"A3PL_Ski_Base",
	localize"STR_INTSECT_ATTDETROPE",
	{
		private _ski = player_objintersect;
		if (!(_ski isKindOf "A3PL_Ski_Base")) exitwith {[localize"STR_QuickActions_Notif_Vehicles_FindSKi", "red"] call A3PL_Player_Notification;};
		if (!(isNull (ropeAttachedTo _ski))) exitwith {
			{ropeDestroy _x;} foreach (ropes (ropeAttachedTo _ski));
			[localize"STR_QuickActions_Notif_Vehicles_RopeAttach", "red"] call A3PL_Player_Notification;
		};
		private _boat = nearestObjects [_ski, ["C_Boat_Civil_01_F"], 10];
		_boat = _boat - [_ski];
		if (count _boat < 1) exitwith {[localize"STR_QuickActions_Notif_Vehicles_BoatProximitySki", "red"] call A3PL_Player_Notification;};
		_boat = _boat select 0;
		if (!(isNull attachedTo _boat)) exitwith {
			[localize"STR_QuickActions_Notif_Vehicles_SkiTrailer", "red"] call A3PL_Player_Notification;
		};
		if (_boat == _ski) exitwith {["System Error: Unable to attach a rope", "red"] call A3PL_Player_Notification;};
		if ((ropeAttachedTo _boat) == _ski) exitwith {["System Error: Unable to attach a rope", "red"] call A3PL_Player_Notification;};
		private _rope = ropeCreate [_boat, [0, -2.2, -0.5], _ski, "rope", 10];
		if (isNull _rope) exitwith {[localize"STR_QuickActions_Notif_Vehicles_ErrorSki", "red"] call A3PL_Player_Notification;};
		[localize"STR_QuickActions_Notif_Vehicles_RopeAttached", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	localize"STR_INTSECT_ENTERDRIVER",
	{
		private _veh = player_objintersect;
		private _anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_Locked", "red"] call A3PL_Player_Notification;};
		if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {
			[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;
		};
		[_veh,_anim] spawn {
			private _veh = _this select 0;
			private _anim = _this select 1;
			_veh lock 1;
			player action ["GetInDriver", _veh];
			switch (true) do {
				case (_veh isKindOf "helicopter"): {
					_veh animate [_anim,1];
					sleep 2;
					_veh animate [_anim,0];
				};
				case (_veh isKindOf "car"): {
					sleep 0.8;
					_veh animate [_anim,1];
					sleep 1;
					_veh animate [_anim,0];
				};
			};
			_veh lock 2;
		};
	}
],
[
	"",
	localize"STR_INTSECT_LUVEHDOORS",
	{
		private _locked = player_objintersect getVariable ["locked",true];
		if (_locked) then {
			player_objintersect setVariable ["locked",false,true];
			[localize"STR_QuickActions_Notif_Vehicles_UnLockCar", "green"] call A3PL_Player_Notification;
		} else {
			player_objintersect setVariable ["locked",true,true];
			[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;
		};
	}
],
[
	"",
	localize"STR_INTSECT_REPVEH",
	{
		if (isNull player_objintersect) exitwith {};
		[player_objintersect] spawn A3PL_Vehicle_Repair;
	}
],
[
	"",
	localize"STR_INTSECT_RESSCOOT",
	{
		private _intersect = player_objintersect;
		if (isNull _intersect) exitwith {};
		_pos = getPos _intersect;
		_intersect setPos [_pos select 0,_pos select 1,_pos select 2];
	}
],
[
	"A3PL_Yacht",
	localize"STR_INTSECT_USEYACHTL",
	{
		private ["_veh","_name","_posTop","_posBottom","_setPos"];
		_veh = player_objIntersect;
		_name = player_nameIntersect;
		if (_name == "yacht_ladder2") then {
			_posTop = player distance (_veh modelToWorld(_veh selectionPosition "ladder2_down"));
			_posBottom = player distance (_veh modelToWorld(_veh selectionPosition "ladder2_up"));
			if (_posTop < _posBottom) then {
				_setpos = (_veh modelToWorld (_veh selectionPosition "ladder2_up"));
				player setpos [_setpos select 0,_setpos select 1,(_setpos select 2) - 3.45];
			} else {
				_setpos = (_veh modelToWorld(_veh selectionPosition "ladder2_down"));
				player setpos [_setpos select 0,_setpos select 1,(_setpos select 2) - 3];
			};
		} else {
			_posTop = player distance (_veh modelToWorld(_veh selectionPosition "ladder1_down"));
			_posBottom = player distance (_veh modelToWorld(_veh selectionPosition "ladder1_up"));
			if (_posTop < _posBottom) then {
				_setpos = (_veh modelToWorld(_veh selectionPosition "ladder1_up"));
				player setpos [_setpos select 0,_setpos select 1,(_setpos select 2) - 3.45];
			} else {
				_setpos = (_veh modelToWorld(_veh selectionPosition "ladder1_down"));
				player setpos [_setpos select 0,_setpos select 1,(_setpos select 2) - 3];
			};
		};
	}
],
[
	"",
	localize"STR_INTSECT_ENTCOPIL",
	{
		private _veh = player_objintersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};
		if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {
			[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;
		};
		player moveInTurret [_veh,[0]];
	}
],
[
	"",
	localize"STR_INTSECT_ENTASPASS",
	{
		private _veh = player_objintersect;
		private _anim = player_nameIntersect;
		private _value = getNumber (configFile >> "CfgVehicles" >> (typeOf _veh) >> "transportSoldier");
		private _list = fullCrew [_veh, "cargo"];
		private _freeseats = count (_list);
		if (_freeseats >= _value && (!(typeOf _veh IN [(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])]))) exitwith {};
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};
		if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {
			[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;
		};
		if (_veh isKindOf "Plane" or (typeOf _veh IN [(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])])) exitwith {
			player moveInCargo _veh;
		};
		if (typeOf _veh IN [(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])]) exitwith {
			player moveInCargo _veh;
		};
		[_veh,_anim] spawn {
			private _veh = _this select 0;
			private _anim = _this select 1;
			_veh animate [_anim,1];
			sleep 1;
			if (_veh isKindOf "helicopter") then {sleep 2;};
			_veh animate [_anim,0];
		};
		_veh lock 1;
		if (_veh isKindOf "helicopter") then {
			player action ["GetInTurret", _veh, [0]];
		} else {
			_value = getNumber (configFile >> "CfgVehicles" >> (typeOf _veh) >> "transportSoldier");_list = fullCrew [_veh, "cargo"];_freeseats = count _list;if (_freeseats >= _value) exitwith {};
			player action ["GetInCargo", _veh];
		};
		_veh lock 2;
	}
],
[
	"",
	localize"STR_INTSECT_EXITVEH",
	{
		private _veh = player_objintersect;
		private _anim = player_nameintersect;
		[_veh,_anim] spawn
		{
			private _veh = _this select 0;
			private _anim = _this select 1;
			_veh animate [_anim,1];
			sleep 1;
			if (_veh isKindOf "helicopter") then {
				if (_anim == "door3") exitwith {};
				sleep 2;
			};
			_veh animate [_anim,0];
		};
		_veh lock 1;
		player leaveVehicle _veh;
		unassignVehicle player;
		if (((speed vehicle player) < 1) && (vehicle player getVariable ["EngineOn",0] isEqualTo 0)) then {
			player action ["GetOut", (vehicle player)];
			[]spawn {if (player getVariable ["Cuffed",true]) then {sleep 1.5;player setVelocityModelSpace [0,3,1];[player,"a3pl_handsupkneelcuffed"] remoteExec ["A3PL_Lib_SyncAnim",-2];};};
		} else {
			player action ["eject", (vehicle player)];
			[]spawn {if (player getVariable ["Cuffed",true]) then {sleep 1.5;player setVelocityModelSpace [0,3,1];[player,"a3pl_handsupkneelcuffed"] remoteExec ["A3PL_Lib_SyncAnim",-2];};};
		};
		_veh lock 2;
	}
],
[
	"",
	localize"STR_INTSECT_IGNITION",
	{
		private _veh = player_objintersect;
		if (isEngineOn _veh) exitwith {
			_veh engineOn false;
			[localize"STR_QuickActions_Notif_Vehicles_EngineOFF", "red"] call A3PL_Player_Notification;
		};
		_veh setVariable ["Ignition",true,false];
		_veh engineOn true;
		[_veh] spawn {
			private _veh = _this select 0;
			sleep 0.1;
			(_veh) setVariable ["Ignition",nil,false];
			[localize"STR_QuickActions_Notif_Vehicles_EngineON", "green"] call A3PL_Player_Notification;
			player action ["lightOn",_veh];
			_veh animateSource ["Head_Lights",3000];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TOGSIR",
	{
		private _veh = player_objintersect;
		private _atc = attachedObjects _veh;
		private _sirenObj = _veh getVariable "sirenObj";
		if (isNil "_sirenObj") then {
			private _sirenObj = createSoundSource ["A3PL_PoliceSiren", getpos _veh, [], 0];
			_sirenObj attachTo [_veh,[0,0,0]];
			_veh setVariable ["sirenObj",_sirenObj,true];
		} else {
			detach _sirenObj;
			deleteVehicle _sirenObj;
			_veh setVariable ["sirenObj",Nil,true];
			{
				_type = format["%1",typeOf _x];
				if(_type == "#dynamicsound") then {deleteVehicle _x;};
			} foreach nearestObjects [_veh,[],10];
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_TOGMANUAL",1],
	{
		private _veh = player_objintersect;
		private _atc = attachedObjects _veh;
		private _sirenObj = _veh getVariable "manualObj";
		if (isNil "_sirenObj") then {
			_sirenObj = createSoundSource ["A3PL_PoliceSirenM1", getpos _veh, [], 0];
			_sirenObj attachTo [_veh,[0,0,0]];
			_veh setVariable ["manualObj",_sirenObj,true];
		} else {
			detach _sirenObj;
			deleteVehicle _sirenObj;
			_veh setVariable ["manualObj",Nil,true];
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_TOGMANUAL",2],
	{
		private _veh = player_objintersect;
		private _atc = attachedObjects _veh;
		private _sirenObj = _veh getVariable "manualObj";
		if (isNil "_sirenObj") then {
			_sirenObj = createSoundSource ["A3PL_PoliceSirenM2", getpos _veh, [], 0];
			_sirenObj attachTo [_veh,[0,0,0]];
			_veh setVariable ["manualObj",_sirenObj,true];
		} else {
			detach _sirenObj;
			deleteVehicle _sirenObj;
			_veh setVariable ["manualObj",Nil,true];
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_TOGMANUAL",3],
	{
		private _veh = player_objintersect;
		private _atc = attachedObjects _veh;
		private _sirenObj = _veh getVariable "manualObj";
		if (isNil "_sirenObj") then {
			_sirenObj = createSoundSource ["A3PL_PoliceSirenM3", getpos _veh, [], 0];
			_sirenObj attachTo [_veh,[0,0,0]];
			_veh setVariable ["manualObj",_sirenObj,true];
		} else {
			detach _sirenObj;
			deleteVehicle _sirenObj;
			_veh setVariable ["manualObj",Nil,true];
		};
	}
],
[
	"",
	localize"STR_INTSECT_TOGHEADL",
	{
		private _veh = player_objintersect;
		if (isLightOn _veh) then {
			player action ["lightOff",_veh];
			[localize"STR_QuickActions_Notif_Vehicles_LightsOFF", "red"] call A3PL_Player_Notification;
			_veh animateSource ["Head_Lights",0];

			private _trailerArray = nearestObjects [(_veh modelToWorld [0,-4,0]), ["A3PL_Trailer_Base"], 6.5];
			_trailerArray = _trailerArray select 0;
			if (!isNil "_trailerArray") then {_trailerArray animate ["Tail_Lights",0];};
		} else {
			player action ["lightOn",_veh];
			[localize"STR_QuickActions_Notif_Vehicles_LightsON", "green"] call A3PL_Player_Notification;
			_veh animateSource ["Head_Lights",3000];
			private _trailerArray = nearestObjects [(_veh modelToWorld [0,-4,0]), ["A3PL_Trailer_Base"], 6.5];
			_trailerArray = _trailerArray select 0;
			if (!isNil "_trailerArray") then
			{
				_trailerArray animate ["Tail_Lights",1];
			};
		};
	}
],
[
	"",
	localize"STR_INTSECT_OPCLTRUNK",
	{
		private _veh = player_objintersect;
		if (_veh animationSourcePhase "trunk" < 0.5) then {
			_veh animateSource ["trunk",1];
		} else {
			_veh animateSource ["trunk",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_HITCHTRLER",
	{
		private _f = false;
		if (typeOf player_objintersect == "A3PL_DrillTrailer_Default") then {
			if (((player_objintersect animationSourcePhase "drill") > 0) OR ((player_objintersect animationSourcePhase "drill_arm_position") > 0)) then {
				_f = true;
			};
		};
		if (_f) exitwith {[localize"STR_QuickActions_Notif_Vehicles_Hitch", "red"] call A3PL_Player_Notification;};
		[player_objIntersect] call A3PL_Vehicle_Trailer_Hitch;
	}
],
[
	"",
	localize"STR_INTSECT_CLIMBINTYA",
	{player setPos (player_objintersect modelToWorld (player_objintersect selectionPosition "climbYacht"));}
],
[
	"",
	localize"STR_INTSECT_UNHITCHTRL",
	{[player_objintersect] call A3PL_Vehicle_Trailer_Unhitch;}
],
[
	"",
	localize"STR_INTSECT_OPCLTRAILD",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "door" < 0.1) then {
			[_veh] spawn {
				private _veh = _this select 0;
				_veh animate ["door_lock",1];
				sleep 1.9;
				_veh animate ["Door",1];
			};
		} else {
			[_veh] spawn {
				private _veh = _this select 0;
				_veh animate ["Door",0];
				sleep 1.9;
				_veh animate ["door_lock",0];
			};
		};
	}
],
[
	"",
	localize"STR_INTSECT_LRTRAILERR",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "ramp1" < 0.1) then {
			[_veh] spawn {
				private _veh = _this select 0;
				_veh animate ["ramp1",1];
				sleep 1.9;
				_veh animate ["ramp2",1];
			};
		} else {
			[_veh] spawn {
				private _veh = _this select 0;
				_veh animate ["ramp2",0];
				sleep 1.9;
				_veh animate ["ramp1",0];
			};
		};
	}
],
[
	"",
	localize"STR_INTSECT_UnloadVehicle",
	{[player_Objintersect] spawn A3PL_Vehicle_TowTruck_Unloadcar;}
],
[
	"",
	localize"STR_INTSECT_LoadVehicle",
	{[player_objIntersect] spawn A3PL_Vehicle_TowTruck_Loadcar;}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",1],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [0]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",2],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [1]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",3],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [2]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",4],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [3]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",5],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [4]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",6],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [5]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",7],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [6]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",8],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [7]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",9],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [8]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",10],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [9]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",11],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [10]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",12],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [11]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",13],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [12]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",14],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [13]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",15],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [14]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",16],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [15]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",17],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [16]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",18],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [17]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",19],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [18]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",20],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [19]];
		_veh lock 2;
	}
],

[
	"",
	format [localize"STR_INTSECT_SITINSEAT",1],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 0];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",2],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 1];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",3],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 2];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",4],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 3];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",5],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 4];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",6],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 5];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",7],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 6];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",8],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 7];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",9],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 8];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",10],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 9];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",11],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 10];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",12],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 11];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",13],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 12];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",14],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 13];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",15],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 14];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",16],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 15];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",17],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 16];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",18],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 17];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",19],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 18];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",20],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 19];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",21],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 20];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",22],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 21];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",23],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 22];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",24],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 23];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",25],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 24];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",26],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 25];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",27],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 26];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",28],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 27];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",29],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 28];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",30],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 29];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",31],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 30];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",32],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 31];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",33],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 32];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",34],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 33];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",35],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 34];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",36],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 35];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",37],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 36];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",38],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 37];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",39],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 38];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",40],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 39];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",41],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 40];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",42],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 41];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",43],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 42];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",44],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 43];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",45],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 44];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",46],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 45];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",47],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 46];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",48],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 47];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",49],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 48];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",50],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 49];
		_veh lock 2;
	}
],

[
	"",
	localize"STR_INTSECT_MOVETODRIVER",
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToDriver", _veh];
		_veh lock 2;
	}
],



[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",1],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [0]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",2],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [1]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",3],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [2]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",4],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [3]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",5],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [4]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",6],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [5]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",7],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [6]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",8],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [7]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",9],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [8]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",10],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [9]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",11],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [10]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",12],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [11]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",13],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [12]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",14],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [13]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",15],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [14]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",16],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [15]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",17],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [16]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",18],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [17]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",19],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [18]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",20],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [19]];
		_veh lock 2;
	}
],

[
	"",
	localize"STR_INTSECT_MOVETOCOPIL",
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 0];
		_veh lock 2;
	}
],

[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",1],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 0];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",2],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 1];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",3],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 2];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",4],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 3];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",5],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 4];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",6],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 5];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",7],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 6];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",8],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 7];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",9],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 8];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",10],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 9];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",11],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 10];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",12],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 11];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",13],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 12];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",14],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 13];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",15],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 14];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",16],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 15];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",17],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 16];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",18],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 17];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",19],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 18];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",20],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 19];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",21],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 20];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",22],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 21];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",23],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 22];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",24],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 23];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",25],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 24];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",26],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 25];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",27],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 26];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",28],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 27];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",29],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 28];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",30],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 29];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",31],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 30];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",32],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 31];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",33],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 32];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",34],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 33];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",35],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 34];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",36],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 35];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",37],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 36];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",38],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 37];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",39],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 38];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",40],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 39];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",41],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 40];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",42],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 41];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",43],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 42];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",44],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 43];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",45],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 44];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",46],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 45];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",47],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 46];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",48],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 47];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",49],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 48];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",50],
	{
		private _veh = player_objIntersect;
		if(_veh getVariable ["locked",true]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_lockCar", "red"] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {[localize"STR_QuickActions_Notif_Vehicles_CantEnterCuff", "red"] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 49];
		_veh lock 2;
	}
],
[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_UNFOJAYHWK",
	{
		private _veh = player_objIntersect;
		if ((_veh animationSourcePhase "Jayhawk_Fold") > 0.5) exitwith {
			_veh animateSource ["Jayhawk_Fold",0];
			_veh animate ["RotorManual",0];
		};
		if ((_veh animationSourcePhase "Jayhawk_Fold") < 0.5) exitwith {
			[_veh] spawn {
				private _veh = _this select 0;
				_veh animate ["RotorManual",1-(_veh animationPhase "rotor")];
				sleep 2;
				_veh animateSource ["Jayhawk_Fold",1];
			};
		};
	}
],
[
    "",
    localize"STR_INTSECT_COCKLIGHT",
    {
		private _veh = player_objIntersect;
        private _delete = false;
        private _d = objNull;
		if(_veh animationSourcePhase "Cockpit_Lights" > 0.5)then {
        	_veh animateSource ["Cockpit_Lights",0];
			if (!(player == (vehicle player turretUnit [0]))) then {
				if(isnull (_veh turretUnit [0]))then {
					_delete=true;
					_d = createAgent ["VirtualMan_F", [0,0,0], [], 0, "FORM"];
					_d moveInTurret [_veh,[0]];
				};
			};
        	(_veh turretUnit [0]) action ["searchlightOff",  _veh];
        	if(_delete)then{moveout _d; deleteVehicle _d;};
        } else {
        	_veh animateSource ["Cockpit_Lights",1];
        	if(isnull (_veh turretUnit [0]))then {
        		_delete=true;
        		_d = createAgent ["VirtualMan_F", [0,0,0], [], 0, "FORM"];
        		_d moveInTurret [_veh,[0]];
        	};
        	(_veh turretUnit [0]) action ["searchlightOn",  _veh];
        	if(_delete)then{moveout _d; deleteVehicle _d;};
        };
    }
],
[
    "",
    localize"STR_INTSECT_TOGDOZBLAD",
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "groundShov" < 0.5) then {
            _veh animateSource ["groundShov",1];
        } else {
            _veh animateSource ["groundShov",-0.5];
        };
    }
],
[
    "",
    localize"STR_INTSECT_DETATTACHM",
    {
		[] spawn {
			_veh = player_objintersect;
			_posveh = _veh selectionPosition "Turret1_pos";
			_pos = _veh modeltoworld _posveh;
			if(!(call A3PL_Player_AntiSpam)) exitWith {};
			if ((_veh animationPhase "Bucket") > 0.5) exitWith {
				_Bucket = "A3PL_MiniExcavator_Bucket" createvehicle [0,0,0];
				[player,_veh,_Bucket] remoteExec ["Server_Vehicle_AtegoHandle", 2];
				_veh removeMagazineTurret  ["A3PL_BucketMag",[0]];
				_veh removeWeaponTurret ["A3PL_Machinery_Bucket",[0,0]];
				_veh removeMagazineTurret  ["A3PL_JackhammerMag",[0]];
				_veh removeWeaponTurret ["A3PL_Machinery_Pickaxe",[0,0]];
				uiSleep 0.1;
				_Bucket setVariable ["class","ME_Bucket",true];
				_Bucket setVariable ["owner",getPlayerUID player,true];
				_veh animate ["Bucket",0];
				_Bucket attachTo [_veh, [(_posveh select 0),(_posveh select 1),(_posveh select 2)-0.6]];
				detach _Bucket;
				uiSleep 0.1;
				_veh animate ["Attachment",0];
			};
			if ((_veh animationPhase "Jackhammer") > 0.5) exitWith {
				_Bucket = "A3PL_MiniExcavator_Jackhammer" createvehicle [0,0,0];
				[player,_veh,_Bucket] remoteExec ["Server_Vehicle_AtegoHandle", 2];
				_veh removeMagazineTurret  ["A3PL_BucketMag",[0]];
				_veh removeWeaponTurret ["A3PL_Machinery_Bucket",[0,0]];
				_veh removeMagazineTurret  ["A3PL_JackhammerMag",[0]];
				_veh removeWeaponTurret ["A3PL_Machinery_Pickaxe",[0,0]];
				uiSleep 0.1;
				_Bucket setVariable ["class","ME_Jackhammer",true];
				_Bucket setVariable ["owner",getPlayerUID player,true];
				_veh animate ["Jackhammer",0];
				_Bucket attachTo [_veh, _posveh];
				detach _Bucket;
				uiSleep 0.1;
				_veh animate ["Attachment",0];
			};
			if ((_veh animationPhase "Claw") > 0.5) exitWith {
				_Bucket = "A3PL_MiniExcavator_Claw" createvehicle [0,0,0];
				[player,_veh,_Bucket] remoteExec ["Server_Vehicle_AtegoHandle", 2];
				uiSleep 0.1;
				_Bucket setVariable ["class","ME_Claw",true];
				_Bucket setVariable ["owner",getPlayerUID player,true];
				_veh animate ["Claw",0];
				_Bucket attachTo [_veh, _posveh];
				detach _Bucket;
				uiSleep 0.1;
				_veh animate ["Attachment",0];
			};
		};
    }
],
[
    "",
    localize"STR_INTSECT_CONNBUCKET",
    {
        private _veh = player_objIntersect;
        if (_veh animationPhase "Attachment" < 0.5) then {
            _veh animate ["Bucket",1];
			_veh animate ["Attachment",1];
			[Player_ItemClass,-1] call A3PL_Inventory_Add;
			[false] call A3PL_Inventory_PutBack;
        };
    }
],
[
    "A3PL_MiniExcavator",
    localize"STR_INTSECT_CONNECTCLAW",
    {
        private _veh = player_objIntersect;
		if (_veh animationPhase "Attachment" < 0.5) then {
            _veh animate ["Claw",1];
			_veh animate ["Attachment",1];
			[Player_ItemClass,-1] call A3PL_Inventory_Add;
			[false] call A3PL_Inventory_PutBack;
        };
    }
],
[
    "",
    localize"STR_INTSECT_CONNJACKHAM",
    {
        private _veh = player_objIntersect;
        if (_veh animationPhase "Attachment" < 0.5) then {
            _veh animate ["Jackhammer",1];
			_veh animate ["Attachment",1];
			[Player_ItemClass,-1] call A3PL_Inventory_Add;
			[false] call A3PL_Inventory_PutBack;
        };
    }
],
[
    "",
    localize"STR_INTSECT_TOGGLESL",
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Spotlight" < 0.5) then {
            _veh animateSource ["Spotlight",1];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOn",_veh];};
        } else {
            _veh animateSource ["Spotlight",0];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOff",_veh];};
        };
    }
],
[
	"",
	localize"STR_INTSECT_TOGROTBR",
	{
		private _veh = player_objIntersect;
		if ((!("inspect_hitengine1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitengine2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithrotor1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithrotor2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithrotor3" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithrotor4" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitvrotor1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitvrotor2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitvrotor3" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hittransmission1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitfuel1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitgear1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitgear2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitgear3" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitgear4" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithstabilizerl11" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithstabilizerr11" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitlight1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitpitottube1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitpitottube2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitstaticport1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitstaticport2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitvstabilizer11" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_intake1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_intake2" IN (player_objIntersect getVariable "Inspection")))) exitwith {["Please complete the pre flight check", "red"] call A3PL_Player_Notification;};
		if (_veh animationPhase "switch_rotor_brake" < 0.5) then {_veh animate ["switch_rotor_brake",1];["Rotor Brake Disengaged", "green"] call A3PL_Player_Notification;} else {_veh animate ["switch_rotor_brake",0];["Rotor Brake Engaged", "red"] call A3PL_Player_Notification;};
	}
],
[
	"",
	localize"STR_INTSECT_TOGBATT",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "switch_rotor_brake" < 0.5) exitwith {["Please contact CFI for instructions", "red"] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Batteries" < 0.5) then {_veh animateSource ["Batteries",1];["Batteries On", "green"] call A3PL_Player_Notification;} else {_veh animateSource ["Batteries",0];["Batteries Off", "red"] call A3PL_Player_Notification;sleep 0.5;_veh animate ["Switch_Radio_Atc",1];["ATC Radio Off", "red"] call A3PL_Player_Notification;};
	}
],
[
	"",
	localize"STR_INTSECT_TOGATCR",
	{
		private _veh = player_objIntersect;
		if (_veh animationSourcePhase "Batteries" < 0.5) exitwith {_veh animate ["Switch_Radio_Atc",0];["Please contact CFI for instructions", "red"] call A3PL_Player_Notification;};
		if (_veh animationPhase "Switch_Radio_Atc" < 0.5) then {
			_veh animate ["Switch_Radio_Atc",1];
			if ((player getVariable "job") IN ["uscg","fifr","fisd"]) then {_veh setVariable ["clearance",true,true];};
			TF_lr_dialog_radio = player call TFAR_fnc_VehicleLR;
			TF_lr_dialog_radio call TFAR_fnc_setActiveLrRadio;
			call TFAR_fnc_onLrDialogOpen;
		};
		if (_veh animationPhase "Switch_Radio_Atc" > 0.5) then {
			TF_lr_dialog_radio = player call TFAR_fnc_VehicleLR;
			TF_lr_dialog_radio call TFAR_fnc_setActiveLrRadio;
			call TFAR_fnc_onLrDialogOpen;
		};
	}
],
[
	"",
	format [localize"STR_INTSECT_THROTCL",1],
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Switch_Radio_Atc" < 0.5) exitwith {["Please contact CFI for instructions", "red"] call A3PL_Player_Notification;};
		if (!(_veh getVariable ["clearance",false])) exitwith {["No ATC clearance, please switch to 126mhz for clearance", "red"] call A3PL_Player_Notification;};
		if (_veh animationPhase "switch_throttle" < 0.5) then {_veh animate ["switch_throttle",1];["Throttle Closed (Engine 1)", "green"] call A3PL_Player_Notification;} else {_veh animate ["switch_throttle",0];["Throttle Open (Engine 1)", "red"] call A3PL_Player_Notification;};
	}
],
[
	"",
	format [localize"STR_INTSECT_TOGSTARENG",1],
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "switch_throttle" < 0.5) exitwith {["Please contact CFI for instructions", "red"] call A3PL_Player_Notification;};
		if (!(_veh getVariable ["clearance",false])) exitwith {["No ATC clearance, please switch to 126mhz for clearance", "red"] call A3PL_Player_Notification;};
		if (_veh animationPhase "switch_starter" < 0.5) then {_veh animate ["switch_starter",1];["Starter Engaged (Engine 1)", "green"] call A3PL_Player_Notification;} else {_veh engineOn false;_veh animate ["switch_starter",0];["Starter Disengaged (Engine 1)", "red"] call A3PL_Player_Notification;};
	}
],
[
	"",
	format [localize"STR_INTSECT_THROTCL",2],
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "switch_starter" < 0.5) exitwith {["Please contact CFI for instructions", "red"] call A3PL_Player_Notification;};
		if (!(_veh getVariable ["clearance",false])) exitwith {["No ATC clearance, please switch to 126mhz for clearance", "red"] call A3PL_Player_Notification;};
		if (_veh animationPhase "switch_throttle2" < 0.5) then {_veh animate ["switch_throttle2",1];_veh animatesource ["throttleRTD1",0];["Throttle Closed (Engine 2)", "green"] call A3PL_Player_Notification;} else {_veh animate ["switch_throttle2",0];["Throttle Open (Engine 2)", "red"] call A3PL_Player_Notification;};
	}
],
[
	"",
	format [localize"STR_INTSECT_TOGSTARENG",2],
	{
		private _veh = player_objIntersect;
		if ((_veh animationPhase "switch_throttle2" < 0.5)or(player_objintersect animationSourcePhase "Inspect_Panel2_1" > 0.5)or(player_objintersect animationSourcePhase "Inspect_Panel1_1" > 0.5)) exitwith {["Please contact CFI for instructions", "red"] call A3PL_Player_Notification;};
		if (!(_veh getVariable ["clearance",false])) exitwith {["No ATC clearance, please switch to 126mhz for clearance", "red"] call A3PL_Player_Notification;};
		if (_veh animationPhase "switch_throttle2" > 0.5) then {
			["Starter Engaged (Engine 2)", "green"] call A3PL_Player_Notification;
			_veh animate ["switch_starter",2];
			sleep 1;
			_veh engineOn true;
			sleep 32;
			_veh animate ["switch_starter",0];
			["Starter Disengaged (Engine 2)", "orange"] call A3PL_Player_Notification;
			sleep 0.5;
			["Starter Disengaged (Engine 1)", "orange"] call A3PL_Player_Notification;
			sleep 0.5;
			_veh animate ["switch_throttle",0];
			["Throttle Open (Engine 1)", "orange"] call A3PL_Player_Notification;
			sleep 0.5;
			_veh animate ["switch_throttle2",0];
			["Throttle Open (Engine 2)", "orange"] call A3PL_Player_Notification;
		}
		else
		{_veh engineOn false;_veh animate ["switch_starter",1];["Starter Disengaged (Engine 2)", "red"] call A3PL_Player_Notification;};
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPENG",1],
	{
		private _veh = player_objIntersect;
		if (_veh animationSourcePhase "Inspect_Panel1_1" < 0.5) exitwith {};
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitengine1";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli1", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPENG",2],
	{
		private _veh = player_objIntersect;
		if (_veh animationSourcePhase "Inspect_Panel2_1" < 0.5) exitwith {};
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitengine2";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli2", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPMAINROT",1],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithrotor1";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli3", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPMAINROT",2],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithrotor2";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli4", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPMAINROT",3],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithrotor3";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli5", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPMAINROT",4],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithrotor4";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli6", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPTAILROT","#1"],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitvrotor1";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli7", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPTAILROT","#2"],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitvrotor2";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli8", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPTAILROT","Hub"],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitvrotor3";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli9", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	localize"STR_INTSECT_INSPTRANS",
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hittransmission1";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli10", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	localize"STR_INTSECT_INSPFUEL",
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitfuel1";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli11", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPGEAR",1],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitgear1";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli12", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPGEAR",2],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitgear2";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli13", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPGEAR",3],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitgear3";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli14", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPGEAR",4],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitgear4";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli15", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPHORSTAB",1],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithstabilizerl11";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli16", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPHORSTAB",2],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithstabilizerr11";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli17", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	localize "STR_INTSECT_INSPLL",
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitlight1";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli18", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPPTUB",1],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitpitottube1";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli19", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPPTUB",2],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitpitottube2";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli20", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPSTP",1],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitstaticport1";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli21", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPSTP",2],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitstaticport2";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli22", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	localize"STR_INTSECT_INSPVERSTAB",
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitvstabilizer11";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli23", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPINT",1],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_intake1";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli24", "green"] call A3PL_Player_Notification;
	}
],
[
	"",
	format [localize"STR_INTSECT_INSPINT",2],
	{
		private _veh = player_objIntersect;
		private _Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_intake2";
		_veh setVariable ["Inspection",_Inspection,true];
		[localize"STR_QuickActions_Notif_Vehicles_InspectHeli25", "green"] call A3PL_Player_Notification;
	}
],

[
	"",
	"Toggle Left Engine Hatch",
	{
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Inspect_Panel1_1" < 0.5) then {
            _veh animateSource ["Inspect_Panel1_1",1];
        } else {
            _veh animateSource ["Inspect_Panel1_1",0];
        };
    }
],
[
	"",
	"Toggle Right Engine Hatch",
	{
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Inspect_Panel2_1" < 0.5) then {
            _veh animateSource ["Inspect_Panel2_1",1];
        } else {
            _veh animateSource ["Inspect_Panel2_1",0];
        };
    }
],
[
    "",
    localize"STR_INTSECT_SPINSIGN",
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "LPlate" < 0.5) then {
            _veh animateSource ["LPlate",1];
        } else {
			_veh animateSource ["LPlate",0];
        };
    }
],
[
	"",
	localize"STR_INTSECT_USEJERRYC",
	{[player_objintersect] spawn A3PL_Vehicle_Jerrycan;}
],

[
	"",
	localize"STR_INTSECT_ANCHOR",
	{[player_objintersect] spawn A3PL_Vehicle_Anchor;}
],
[
	"A3PL_WheelieBin",
	localize"STR_INTSECT_TrashPick",
	{[player_objintersect] call A3PL_Inventory_Pickup;}
],
[
	"A3PL_WheelieBin",
	localize"STR_INTSECT_TrashLoad",
	{[player_objintersect] call A3PL_Waste_LoadBin;}
],
[
	"A3PL_P362_Garbage_Truck",
	localize"STR_INTSECT_TrashDischarge",
	{[player_objintersect,player_nameintersect] call A3PL_Waste_UnloadBin;}
],
[
	"",
	localize"STR_INTSECT_TrashSlideLeft",
	{
		private _veh = player_objIntersect;
		if (_veh animationSourcePhase "Bin1" < 0.5) then {[_veh,"bin1"] call A3PL_Waste_FlipBin;};
	}
],
[
	"",
	localize"STR_INTSECT_TrashLwLeft",
	{
		private _veh = player_objIntersect;
		if (_veh animationSourcePhase "Bin1" > 0.5) then{_veh animateSource  ["Bin1", 0.1];};
	}
],
[
	"",
	localize"STR_INTSECT_TrashSlideRight",
	{
		private _veh = player_objIntersect;
		if (_veh animationSourcePhase "Bin2" < 0.5) then {[_veh,"bin2"] call A3PL_Waste_FlipBin;};
	}
],
[
	"",
	localize"STR_INTSECT_TrashLwRight",
	{
		private _veh = player_objIntersect;
		if (_veh animationSourcePhase "Bin2" > 0.5) then {_veh animateSource  ["Bin2", 0.1];};
	}
],
[
	"",
	localize"STR_INTSECT_TrashOpen",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Lid" < 0.5) then {_veh animate  ["Lid", 1];};
	}
],
[
	"",
	localize"STR_INTSECT_TrashClose",
	{
		private _veh = player_objIntersect;
		if (_veh animationPhase "Lid" > 0.5) then {_veh animate  ["Lid", 0];};
	}
],
[
	"",
	localize"STR_INTSECT_UPLWRAMP",
	{[player_objintersect] call A3PL_Vehicle_TrailerAttachObjects;}
],
[
	"",
	"Toggle Mooring Line",
	{call A3PL_Vehicle_Mooring;}
],
[
    "",
    localize"STR_INTSECT_HITCHFOLD",
    {
        private _veh = player_objIntersect;
        if (_veh animationSourcePhase "Hitch_Fold" < 0.5) then {
            _veh animateSource ["Hitch_Fold",1];
        } else {
            _veh animateSource ["Hitch_Fold",0];
        };
    }
],
[
	"C_Van_02_transport_F",
	localize"STR_INTSECT_DRVDOOR",
	{
		private _veh = player_objintersect;
		private _name = Player_NameIntersect;
		if (_name != "door1") exitwith {};
		if (_veh animationSourcePhase "Door_1_source" == 0) then {
			_veh animateDoor ["Door_1_source", 1];
		} else {
			_veh animateDoor ["Door_1_source", 0];
		};
	}
],
[
	"C_Van_02_transport_F",
	localize"STR_INTSECT_PSGDOOR",
	{
		private _veh = player_objintersect;
		private _name = Player_NameIntersect;
		if (_name != "door2") exitwith {};
		if (_veh animationSourcePhase "Door_2_source" < 0.5) then {
			_veh animateDoor ["Door_2_source", 1];
		} else {
			_veh animateDoor ["Door_2_source", 0];
		};
	}
],
[
	"C_Van_02_transport_F",
	localize"STR_INTSECT_LATDOOR",
	{
		private _veh = player_objintersect;
		private _name = Player_NameIntersect;
		if (_name != "door3") exitwith {};
		if (_veh animationSourcePhase "Door_3_source" < 0.5) then {
			_veh animateDoor ["Door_3_source", 1];
		} else {
			_veh animateDoor ["Door_3_source", 0];
		};
	}
],
[
    "",
    "Toggle Gooseneck",
    {[player_objintersect] call A3PL_Vehicle_Toggle_Gooseneck;}
],
[
	"A3FL_AS_365",
	localize"STR_INTSECT_SWITCHBAT",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "Battery" < 0.5) exitwith {
			_veh animate ["battery",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["battery",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3FL_AS_365",
	localize"STR_INTSECT_APUGEN",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "gen1" < 0.5) exitwith {
			if (_veh animationPhase "battery" < 0.5) exitwith {["Battery is off","red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "ecs" < 0.5) exitwith {["ECS is not on APU Boost","red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "fuelpump" > 0.5) exitwith {["Fuel Pump is not on APU Boost","red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "apucontrol" < 0.5) exitwith {["APU Control is not on APU Boost","red"] call A3PL_Player_Notification;};
			_veh animate ["gen1",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["gen1",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3FL_AS_365",
	format [localize"STR_INTSECT_ENGGEN",1],
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "gen2" < 0.5) exitwith {
			_veh animate ["gen2",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["gen2",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3FL_AS_365",
	format [localize"STR_INTSECT_ENGGEN",2],
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "gen3" < 0.5) exitwith {
			_veh animate ["gen3",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["gen3",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3FL_AS_365",
	localize"STR_INTSECT_ECSSTART",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "ecs" < 0.5) exitwith {
			_veh animate ["ecs",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["ecs",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3FL_AS_365",
	localize"STR_INTSECT_FUELPUMP",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "fuelpump" < 0.5) exitwith {
			_veh animate ["fuelpump",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["fuelpump",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3FL_AS_365",
	localize"STR_INTSECT_APUCONT",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "apucontrol" < 0.5) exitwith {
			_veh animate ["apucontrol",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["apucontrol",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],
[
	"A3FL_AS_365",
	localize"STR_INTSECT_SWITCHIGN",
	{
		private _veh = player_objintersect;
		if (_veh animationPhase "ignition_Switch" > 0.5) exitwith {
			_veh animate ["ignition_Switch",0];
			_veh engineOn false;
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		if (_veh animationPhase "ignition_Switch" < 0.5) exitwith {
			if (_veh animationPhase "battery" < 0.5) exitwith {["Battery is turned off", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "ecs" > 0.5) exitwith {["ECS is not on Engine", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "fuelpump" < 0.5) exitwith {["Fuel Pump is not on Fuel Prime", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "apucontrol" < 0.5) exitwith {["APU Control is not on APU Boost", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "gen1" < 0.5) exitwith {["APU is OFF", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "gen2" < 0.5) exitwith {["Generator 2 is not turned on", "red"] call A3PL_Player_Notification;};
			if (_veh animationPhase "gen3" < 0.5) exitwith {["Generator 3 is not turned on", "red"] call A3PL_Player_Notification;};
			_veh animate ["gen1",0];
			_veh animate ["ignition_Switch",1];
			[_veh] spawn {
				private ['_veh'];
				_veh = _this select 0;
				sleep 1;
				_veh engineOn true;
			};
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["ignition_Switch",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
]