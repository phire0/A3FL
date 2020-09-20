/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#include "\a3\editor_f\Data\Scripts\dikCodes.h"
#define KINDOF_ARRAY(a,b) [##a,##b] call {_veh = _this select 0;_types = _this select 1;_res = false; {if (_veh isKindOf _x) exitWith { _res = true };} forEach _types;_res}

["A3PL_EventHandlers_Setup",
{
	call A3PL_EventHandlers_HandleDamage;
	call A3PL_EventHandlers_Take;
	call A3PL_EventHandlers_Fired;
	call A3PL_EventHandlers_FiredNear;
	call A3PL_EventHandlers_OpenMap;
	call A3PL_EventHandlers_InventoryOpened;
	call A3PL_EventHandlers_RadioAnim;

	[] spawn {
		waitUntil {!isnull (findDisplay 46)};
		(findDisplay 46) displayAddEventHandler ["KeyDown", {_this call A3PL_EventHandlers_HandleDown;}];
		(findDisplay 46) displayAddEventHandler ["KeyUp", {_this call A3PL_EventHandlers_HandleUp;}];
		player addEventHandler ["InventoryOpened", {_this call A3PL_Prevent_Patdown_Cloning;}];

		["ArmA 3 Fishers Life","interaction_key", "Interaction Menu",
		{
			if(!(player getVariable["A3PL_Medical_Alive",true])) exitWith {};
			if (!isNil "A3PL_Interaction_KeyDown") exitwith {};
			A3PL_Interaction_KeyDown = true;
			if(alive player) then {
				[player_objintersect] call A3PL_Interaction_loadInteraction;
			};
		},

		{
			if(player getVariable ["Incapacitated",false]) exitWith {};
			if (!isNil "A3PL_Interaction_KeyDown") then {
				A3PL_Interaction_KeyDown = Nil;
			};
			if (!isNull (findDisplay 1000)) then
			{
				(findDisplay 1000) closeDisplay 0;
			};
			true;
		}, [DIK_E, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","bargates_key", "Open/Close Bargates",
		{
			private _bargate = (nearestObjects [player, ["Land_A3FL_DOC_Gate","Land_A3PL_BarGate","Land_A3PL_BarGate_Left","Land_A3PL_BarGate_Right"], 20]) select 0;
			private _veh = typeOf (vehicle player);
			private _source = true;
			if(_veh IN Config_Police_Vehs) then {
				private _anim = switch(typeOf _bargate) do {
					case "Land_A3PL_Bargate_Right": {"bargate2"};
					case "Land_A3PL_Bargate_Left": {"bargate1"};
					case "Land_A3FL_DOC_Gate": {
						private _distanceOne = player distance2D (_bargate modelToWorldVisual (_bargate selectionPosition ["Gate_1_Pos","Memory"]));
						private _distanceTwo = player distance2D (_bargate modelToWorldVisual (_bargate selectionPosition ["Gate_2_Pos","Memory"]));
						_source = false;
						if(_distanceTwo>_distanceOne) then {
							"Gate_1"
						} else {
							"Gate_2"
						};
					};
					default {
						private _distanceOne = player distance2D (_bargate modelToWorldVisual (_bargate selectionPosition ["button_bargate1","Memory"]));
						private _distanceTwo = player distance2D (_bargate modelToWorldVisual (_bargate selectionPosition ["button_bargate2","Memory"]));
						if(_distanceTwo>_distanceOne) then {
							"bargate1"
						} else {
							"bargate2"
						};
					};
				};
				if(_source) then {
					if ((_bargate animationSourcePhase _anim) < 0.5) then {
					_bargate animateSource [_anim,1];
					} else {
						_bargate animateSource [_anim,0];
					};
				} else {
					if ((_bargate animationPhase _anim) < 0.5) then {
						_bargate animate [_anim,1];
					} else {
						_bargate animate [_anim,0];
					};
				};	
			};
		}, "", [DIK_N, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","highbeams_key", "Toggle High Beams",
		{
			private _veh = vehicle player;
			if(!(_veh isKindOf "Car") && !((driver _veh) isEqualTo player)) exitWith {};
				if (_veh animationSourcePhase "High_Beam" < 0.5) then {
					_veh animateSource ["High_Beam",1];
				} else {
					_veh animateSource ["High_Beam",0];
				};
		}, "", [DIK_COLON, [true, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","enginekeep_key", "Keep Engine Running Toggle",
		{
			private _veh = vehicle player;
			if((!(_veh isKindOf "Car") && !((driver _veh) isEqualTo player)) || (vehicle player isEqualTo player)) exitWith {};
				if (_veh getVariable ["EngineOn",0] isEqualTo 0) then {
					_veh setVariable ["EngineOn",1,true];
					["The engine of this vehicle will now remain running when you exit","green"] call A3PL_Player_Notification;
				} else {
					_veh setVariable ["EngineOn",0,true];
					["The engine of this vehicle will now stop running when you exit","red"] call A3PL_Player_Notification;
				};
		}, "", [DIK_INSERT, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","lockunlock_key", "Lock/Unlock Vehicle",
		{
			_veh = objNull;
			if((vehicle player) isEqualTo player) then {
				_veh = player_objintersect;
			} else {
				_veh = vehicle player;
			};
			if(isNull _veh) exitWith {};
			if(!(_veh IN A3PL_Player_Vehicles)) exitWith {};
			if((player distance _veh) > 10) exitWith {};
			if(_veh getVariable ["locked",true]) then {
				_veh setVariable ["locked",false,true];
				[localize "STR_INTER_UNLOCKVD", "green"] call A3PL_Player_Notification;
				playSound3D ["A3PL_Common\effects\carunlock.ogg", _veh, true, _veh, 3, 1, 30];
			} else {
				_veh setVariable ["locked",true,true];
				[localize "STR_INTER_LOCKVD", "red"] call A3PL_Player_Notification;
				playSound3D ["A3PL_Cars\Common\Sounds\A3PL_Car_Lock.ogg", _veh, true, _veh, 3, 1, 30];
			};
		}, "", [DIK_U, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","trunk_key", "Open/Close Vehicle Trunk",
		{
			private["_veh"];
			if (animationState player in ["A3PL_TakenHostage","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitwith {[localize"STR_EVENTHANDLERS_RESTRAINACTION","red"] call A3PL_Player_Notification;};
			_veh = player_objintersect;
			if(!((vehicle player) isEqualTo player)) then {_veh = vehicle player;};

			if(!(_veh isKindOf "Car") && !((typeOf _veh) isEqualTo "A3PL_EMS_Locker")) exitWith {diag_log "exit 1";};
			if ((player distance _veh > 5)) exitWith {diag_log "exit 2";};
			if ((_veh getVariable["locked",false])) exitWith {[localize"STR_EVENTHANDLERS_UnlockCar","red"] call A3PL_Player_Notification;};
			if(isNull _veh || {isNil '_veh'}) exitWith {diag_log "exit 3";};
			if(((typeOf _veh) isEqualTo "A3PL_EMS_Locker") && {(_veh getVariable["owner",""]) != (getPlayerUID player)}) exitWith {diag_log "exit 4";};
			if([typeOf (_veh)] call A3PL_Config_HasStorage) then {
				[_veh] call A3PL_Vehicle_OpenStorage;
			};
		}, "", [DIK_T, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","phone_key", "Open Cell Phone",
		{
			if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
			player setVariable ["inventory_opened", nil, true];
			if (!([] call A3PL_Lib_HasPhone)) exitwith {[localize"STR_EVENTHANDLERS_PHONENEEDED","red"] call A3PL_Player_Notification;};
			if (animationState player in ["A3PL_TakenHostage","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitwith {[localize"STR_EVENTHANDLERS_RESTRAINACTION","red"] call A3PL_Player_Notification;};
			call A3PL_iPhoneX_Locked;
		}, "", [DIK_G, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","twitter_key", "Open Twitter Post",
		{
			if(underwater (vehicle player)) exitWith {["You cannot use your phone while underwater","red"] call A3PL_Player_Notification;};
			if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
			if (animationState player in ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitwith {[localize"STR_EVENTHANDLERS_RESTRAINACTION","red"] call A3PL_Player_Notification;};
			if(!dialog) then {[] spawn A3PL_iPhoneX_appTwitterPost;};
		}, "", [DIK_U, [false, true, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","holster_gun", "Holster/Unholster",
		{
			if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
			if (currentWeapon player != "") exitWith {
				A3PL_Holster = currentWeapon player;
				player action ["SwitchWeapon", player, player, 100];
				player switchCamera cameraView;
				true;
			};
			if(!isNil "A3PL_Holster" && {A3PL_Holster != ""}) exitWith {
				player selectWeapon A3PL_Holster;
				true;
			};
		}, "", [DIK_H, [true, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","surrender", "Surrender",
		{
			if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
			if(((getPosATL player) select 2) > 1) exitWith {};
			if((speed player) > 0) exitWith {};
			if((vehicle player) isEqualTo player) then {[player,true] call A3PL_Police_Surrender;};
		}, "", [DIK_B, [true, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","medical_menu", "Medical Menu",
		{
			if (!isNull (findDisplay 73)) exitWith
			{
				(findDisplay 73) closeDisplay 0;
			};
			[player] spawn A3PL_Medical_Open;
		}, "", [DIK_COMMA, [true, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","e_inventory", "Virtual Inventory",
		{
			if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
			if(vehicle player == player) then {
				if (!isNull (findDisplay 1001)) exitWith
				{
					(findDisplay 1001) closeDisplay 0;
				};
				call A3PL_Inventory_Open;
			} else {
				_veh = vehicle player;
				if ((_veh getVariable["locked",true])) exitWith {[localize"STR_EVENTHANDLERS_UnlockCar","red"] call A3PL_Player_Notification;};
					if(isNull _veh || {isNil '_veh'}) exitWith {};
					if([typeOf (_veh)] call A3PL_Config_HasStorage) then {
						[_veh] call A3PL_Vehicle_OpenStorage;
					};
			};
		}, "", [DIK_I, [true, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","ear_plug", "Ear Plug",
		{
			if (soundVolume < 0.1) then {
				1 fadeSound 1;
			} else {
				1 fadeSound (round((soundVolume - 0.1)*10)/10);
			};
			[format[localize"STR_EVENTHANDLERS_Volume",(soundVolume*100),'%'],"yellow"] call A3PL_Player_Notification;
		}, "", [DIK_O, [true, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","vault_key", "Vault Key",
		{
			_max_height = 4.3;
		 if(!(player getVariable["A3PL_Medical_Alive",true])) exitWith {};
		 if(speed player < 8) exitWith {};
		 if((player == vehicle player) && (player getvariable ["jump",true]) && (isTouchingGround player)) then  {

		 player setvariable ["jump",false];

		_height = 6-((load player)*10);
		_vel = velocity player;
		_dir = direction player;
		_speed = 0.4;
		if (_height > _max_height) then {_height = _max_height};
			player setVelocity [(_vel select 0)+(sin _dir*_speed),(_vel select 1)+(cos _dir*_speed),(_vel select 2)+_height];

			[player,"AovrPercMrunSrasWrflDf"] remoteExec ["A3PL_Lib_SyncAnim",0];
			player spawn {sleep 2; player setvariable ["jump",true]};
		};
	}, "", [DIK_V, [true, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","animation_1", "(Animation) Hello",
		{
			if(vehicle player == player && !(animationState player in ["A3PL_TakenHostage","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"])) then {
				if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
				player playAction "Gesture_wave";
				true;
			};
		}, "", [DIK_1, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","animation_2", "(Animation) Finger",
		{
			if(vehicle player == player && !(animationState player in ["A3PL_TakenHostage","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"])) then {
				if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
				player playAction "Gesture_finger";
				true;
			};
		}, "", [DIK_2, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","animation_3", "(Animation) Watching",
		{
			if(vehicle player == player && !(animationState player in ["A3PL_TakenHostage","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"])) then {
				if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
				player playAction "Gesture_watching";
				true;
			};
		}, "", [DIK_3, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","animation_4", "(Animation) Dance 1",
		{
			if(vehicle player == player && !(animationState player in ["A3PL_TakenHostage","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"])) then {
				if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
				if ((animationState player) != "A3PL_Dance_House1") then
				{
					[player, "A3PL_Dance_House1"] remoteExec ["A3PL_Lib_SyncAnim",0];
					if(Player_ActionDoing) then {Player_ActionInterrupted = true;};
				} else
				{
					[player, ""] remoteExec ["A3PL_Lib_SyncAnim",0];
				};
				true;
			};
		}, "", [DIK_4, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","animation_5", "(Animation) Dance 2",
		{
			if(vehicle player == player && !(animationState player in ["A3PL_TakenHostage","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"])) then {
				if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
				if ((animationState player) != "A3PL_Dance_Samba") then
				{
					[player, "A3PL_Dance_Samba"] remoteExec ["A3PL_Lib_SyncAnim",0];
					if(Player_ActionDoing) then {Player_ActionInterrupted = true;};
				} else
				{
					[player, ""] remoteExec ["A3PL_Lib_SyncAnim",0];
				};
				true;
			};
		}, "", [DIK_5, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","animation_6", "(Animation) Dab",
		{
			if(vehicle player == player && !(animationState player in ["A3PL_TakenHostage","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"])) then {
				if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
				player playAction "gesture_dab";
				true;
			};
		}, "", [DIK_6, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","animation_7", "(Animation) Naruto Run",
		{
			if(vehicle player == player && !(animationState player in ["A3PL_TakenHostage","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"])) then {
				if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
				player playAction "Foski_StopNarutoRun";
				true;
			};
		}, "", [DIK_7, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","animation_8", "(Animation) Dance 3",
		{
			if(vehicle player == player && !(animationState player in ["A3PL_TakenHostage","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"])) then {
				if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
				if ((animationState player) != "Acts_Dance_01") then
				{
					[player, "Acts_Dance_01"] remoteExec ["A3PL_Lib_SyncAnim",0];
					if(Player_ActionDoing) then {Player_ActionInterrupted = true;};
				} else
				{
					[player, ""] remoteExec ["A3PL_Lib_SyncAnim",0];
				};
				true;
			};
		}, "", [DIK_8, [false, false, false]]] call CBA_fnc_addKeybind;

		["ArmA 3 Fishers Life","animation_9", "(Animation) Dance 4",
		{
			if(vehicle player == player && !(animationState player in ["A3PL_TakenHostage","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"])) then {
				if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith{};
				if ((animationState player) != "Acts_Dance_02") then
				{
					[player, "Acts_Dance_02"] remoteExec ["A3PL_Lib_SyncAnim",0];
					if(Player_ActionDoing) then {Player_ActionInterrupted = true;};
				} else
				{
					[player, ""] remoteExec ["A3PL_Lib_SyncAnim",0];
				};
				true;
			};
		}, "", [DIK_9, [false, false, false]]] call CBA_fnc_addKeybind;

		(findDisplay 46) displayAddEventHandler ["MouseButtonUp",
		{
			private ["_button"];
			_button = (param [1,-1]) + 65536;
			if (_button IN (actionKeys "Action")) then
			{
				[] spawn A3PL_Interaction_ActionKey;
			};
		}];
	};
}] call Server_Setup_Compile;

["A3PL_Prevent_Patdown_Cloning",
{
	if(player getVariable ["patdown",false]) then {
		[localize"STR_EVENTHANDLERS_DUPLICATION","red"] call A3PL_Player_Notification;
		[getPlayerUID player,"PatdownPhisCloningAtempt",[]] remoteExec ["Server_Log_New",2];
		true;
	};
}] call Server_Setup_Compile;

["A3PL_Prevent_Patdown_Cloning",
{
	if(player getVariable ["patdown",false]) then {
		[localize"STR_EVENTHANDLERS_DUPLICATION","red"] call A3PL_Player_Notification;
		[getPlayerUID player,"PatdownPhisCloningAtempt",[]] remoteExec ["Server_Log_New",2];
		true;
	};
}] call Server_Setup_Compile;

["A3PL_EventHandlers_Fired",
{
	player addEventHandler ["Fired",
	{
		private _weapon = param [1,""];
		private _ammo = param [4,""];
		if (_weapon IN ["A3PL_FireAxe","A3PL_Pickaxe","A3PL_Shovel","A3FL_BaseballBat","A3FL_PoliceBaton","A3FL_GolfDriver","A3PL_Scypthe"]) then
		{
			player playAction "GestureSwing";
			if(((typeOf player_objintersect) isEqualTo "Land_A3FL_Fishers_Jewelry") && {player_nameintersect IN ["case_break_1","case_break_2","case_break_3","case_break_4","case_break_5","case_break_6","case_break_7","case_break_8","case_break_9"]}) exitWith {
				call A3PL_Jewelry_GlassDamage;
			};
			if (player inArea "LumberJack_Rectangle") then {
				if (_weapon isEqualTo "A3PL_FireAxe") then {call A3PL_Lumber_FireAxe;};
			} else {
				call A3PL_FD_HandleFireAxe;
			};
		};
		if (_weapon isEqualTo "A3PL_Jaws") then {call A3PL_FD_HandleJaws;};
		if (_ammo isEqualTo "A3FL_Mossberg_590K_Breach") then {call A3PL_Police_HandleBreach;};
	}];
}] call Server_Setup_Compile;

["A3PL_EventHandlers_HandleDown",
{
	params["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];

	if(isNil "A3PL_Manual_KeyDown") then {A3PL_Manual_KeyDown = false};

	if (_dikCode == 59) exitWith {
		if (pVar_AdminMenuGranted) exitWith
		{
			call A3PL_AdminOpen;
		};
	};

	if (_dikCode == 60) exitWith {
		if (pVar_AdminMenuGranted) then {
			if (pVar_CursorTargetEnabled) then {
				pVar_CursorTargetEnabled = false;
			} else {
				[] spawn A3PL_AdminCursorTarget;
			};
		};
	};

	if (_dikCode == 61) exitWith {
		if (pVar_AdminMenuGranted) then {
			disableSerialization;
			pVar_AdminPrePosition = getPosATL player;

			player hideObjectGlobal true;

			if (!isObjectHidden player) then
			{
				[] spawn {
					[player] remoteExec ["A3PL_Lib_HideObject", 2];
					uisleep 0.5;
				};
			};

			["Initialize", [player, [], false, true, true, false, true, true, true, true]] call BIS_fnc_EGSpectator;
			[player,"spectate",[format ["ENABLED"]]] remoteExec ["Server_AdminLoginsert", 2];

			_spectatorCamera = ["GetCamera"] call BIS_fnc_EGSpectatorCamera;
			_magicCarpet = "logic" createVehicleLocal (getpos _spectatorCamera);
			player attachTo [_magicCarpet,[0,0,0]];
			while {!isNull (findDisplay 60492)} do
			{
				_magicCarpet setPosATL (getPosATL _spectatorCamera);
				uiSleep 0.1;
			};

			[] spawn {
				waitUntil {!isNull findDisplay 49};
				["Terminate"] call BIS_fnc_EGSpectator;
				[player,false] remoteExec ["A3PL_Lib_HideObject", 2];
				(findDisplay 49) closeDisplay 1;
				waitUntil {isNull findDisplay 49};
			};

			deleteVehicle _magicCarpet;
			detach player;
			player setposATL (missionNameSpace getVariable ['pVar_AdminPrePosition',getposATL player]);
			pVar_AdminPrePosition = nil;
			player hideObjectGlobal true;
		};
	};

	if (_dikCode == 62) exitWith {
		if !("Debug" IN (player getVariable ["dbVar_AdminPerms",[]])) exitWith {};
		call A3PL_Debug_Open;
	};

	if((_dikCode IN [30,31,32,21]) && (Player_ActionDoing)) exitWith {

	};

	if ((_dikCode > 1 && _dikCode < 5) && {vehicle player != player} && {typeOf vehicle player in Config_Police_Vehs} && {(player == driver (vehicle player))}) exitWith {
		[(_dikCode-1)] call A3PL_Vehicle_SirenHotkey;
		true;
	};

	if ((_dikCode > 5 && _dikCode < 14) && {vehicle player != player} && {!A3PL_Manual_KeyDown} && {typeOf vehicle player in Config_Police_Vehs} && {(player == driver (vehicle player))}) exitWith {
		[(_dikCode-1)] call A3PL_Vehicle_SirenHotkey;
		A3PL_Manual_KeyDown = true;
		true;
	};

	if ((_dikCode == 82) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
		player_objintersect lock false;
		player action["GetInDriver",player_objintersect];
		player_objintersect lock true;
	true;
	};

	if ((_dikCode == 79) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
		[player_objintersect] call A3PL_Admin_AttachTo;
	true;
	};

	if ((_dikCode == 80) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
		call A3PL_Admin_DetachAll;
	true;
	};

	if ((_dikCode == 81) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
		[player_objintersect] remoteExec ["Server_Police_Impound",2];
	true;
	};

	if ((_dikCode == 75) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
		[player_objintersect] call A3PL_Vehicle_Despawn;
	true;
	};

	if ((_dikCode == 76) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
		player moveInCargo player_objintersect;
	true;
	};

	if ((_dikCode == 77) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
		[player_objintersect] call A3PL_Admin_EjectAll;
	true;
	};

	if ((_dikCode == 71) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
		[player,"admin_heal",[player_objintersect getVariable["name","unknown"]]] remoteExec ["Server_AdminLoginsert", 2];
		player_objintersect setDamage 0;
		player_objintersect setVariable ["A3PL_Medical_Alive",true,true];
		player_objintersect setVariable ["A3PL_Wounds",[],true];
		player_objintersect setVariable ["A3PL_MedicalVars",[5000,"120/80",37],true];
	true;
	};

	if ((_dikCode == 72) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
		[player,"admin_repair",[typeOf player_objintersect]] remoteExec ["Server_AdminLoginsert", 2];
		player_objintersect setdammage 0;
		true;
	};

	if ((_dikCode == 73) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
		[player,"admin_refuel",[typeOf player_objintersect]] remoteExec ["Server_AdminLoginsert", 2];
		player_objintersect setFuel 1;
		true;
	};
	false;
}] call Server_Setup_Compile;

["A3PL_EventHandlers_HandleUp", //exit with true to overwrite default arma keys, and prevent rpt errors
{
	params["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];

	//Siren Hotkeys (up)
	_dikCodeBegin = 4;
	if (vehicle player IN ["A3PL_Pierce_Rescue","A3PL_Pierce_Pumper","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","Jonzie_Ambulance","A3PL_Tahoe_FD","A3PL_Tahoe_PD"]) then {_dikCodeBegin = 5};
	if ((_dikCode > _dikCodeBegin && _dikCode < 14) && {vehicle player != player} && {typeOf vehicle player in Config_Police_Vehs}) exitWith {
		[(_dikCode-1)] call A3PL_Vehicle_SirenHotkey;
		A3PL_Manual_KeyDown = false;
		true;
	};

	//Scroll menu
	if (_dikCode IN (actionKeys "Action")) then
	{
		[] spawn A3PL_Interaction_ActionKey;
		true;
	};
}] call Server_Setup_Compile;

//Take eventhandler for player
["A3PL_EventHandlers_Take",
{
	player addEventHandler ["Take",
	{
		_itemClass = param [2,""];
		if (_itemClass == "A3PL_High_Pressure_Holder") then {
			player setAmmo ["A3PL_High_Pressure_Holder",0];
		};
		if (_itemClass IN ["A3PL_High_Pressure_Water_Mag","A3PL_Medium_Pressure_Water_Mag","A3PL_Low_Pressure_Water_Mag"]) then {
			player removeMagazine _itemClass;
		};

		if (_itemClass == "A3PL_FD_Mask") then {
			[localize"STR_EVENTHANDLERS_OBJECTINVENTORYADD","green"] call A3PL_Player_Notification;
			removeGoggles player;
			player removeItem "A3PL_FD_Mask";
			["fd_mask",1] call A3PL_Inventory_Add;
		};

		if (_itemClass == "A3PL_Shovel") then {
			player removeMagazines "A3PL_ShovelMag";
			player addMagazine "A3PL_ShovelMag";
		};
		if (_itemClass == "A3PL_Pickaxe") then {
			player removeMagazines "A3PL_PickAxeMag";
			player addMagazine "A3PL_PickAxeMag";
		};
		if (_itemClass == "A3PL_Jaws") then {
			player removeMagazines "A3PL_FireaxeMag";
			player addMagazine "A3PL_FireaxeMag";
		};
		if (_itemClass == "A3PL_Fireaxe") then {
			player removeMagazines "A3PL_FireaxeMag";
			player addMagazine "A3PL_FireaxeMag";
		};
		if (_itemClass == "A3PL_Scythe") then {
			player removeMagazines "A3PL_ScytheMag";
			player addMagazine "A3PL_ScytheMag";
		};
		if (_itemClass == "A3FL_GolfDriver") then {
			player removeMagazines "A3FL_GolfDriverMag";
			player addMagazine "A3FL_GolfDriverMag";
		};
		if (_itemClass == "A3FL_BaseballBat") then {
			player removeMagazines "A3FL_BaseballBatMag";
			player addMagazine "A3FL_BaseballBatMag";
		};
		if (_itemClass == "A3FL_PoliceBaton") then {
			player removeMagazines "A3FL_PoliceBatonMag";
			player addMagazine "A3FL_PoliceBatonMag";
		};

		if (_itemClass IN ["U_B_Protagonist_VR","U_I_Protagonist_VR","U_O_Protagonist_VR"]) then {
			if (!(["motorhead"] call A3PL_Lib_hasPerk)) then {
				[localize"STR_EVENTHANDLERS_MotorheadPerk","red"] call A3PL_Player_Notification;
				if ((uniform player) == _itemClass) then {removeUniform player;};
				player removeItem _itemClass;
			};
		};

		if (_itemClass IN ["A3PL_IronMan_Outfit_Uniform","A3PL_Cap_Amer_Outfit_Uniform","A3PL_Deadpool_Outfit_Uniform","A3PL_Deadpool_Mask","A3PL_IronMan_Mask","A3PL_Anon_mask","A3PL_Ghost_Necklace","G_EyeProtectors_F","A3PL_Crown","A3PL_Tiara","A3PL_CancerRib_Cap","A3PL_Conehat","A3PL_Cowboy","A3PL_Mexicanhat","A3PL_Sombrero","A3PL_Grn_Lantern_Outfit_Uniform",
			"A3PL_BubblegumCheetas_Uniform","A3PL_Donald_Duck_Uniform","A3PL_Eatsleep_Uniform","A3PL_GotGuns_Uniform""A3PL_JurasGolf_Uni_Uniform","A3PL_Jumpsuit_Uniform","A3PL_Kendra_Uniform","A3PL_Mcflirtles_Employee_Uniform","A3PL_Moonshine_Willy_Uniform","A3PL_Sicarios_Cartel_Uniform","A3PL_SkyDesigns_CEO_Uniform","A3PL_Surf_Lifesave_Uniform","A3PL_Ghostbusters_Belt","A3PL_Anon_mask","A3PL_GhostBusters_Cap","A3PL_Horse_Mask","A3PL_LavendarRibbon_Fedora","A3PL_Yelnats_Janitorial_Cap"]) then {
			if (!(["things"] call A3PL_Lib_hasPerk)) then {
				[localize"STR_EVENTHANDLERS_ThingsPerk","red"] call A3PL_Player_Notification;
				if ((uniform player) == _itemClass) then {removeUniform player;};
				if ((headgear player) == _itemClass) then {removeHeadgear player;};
				if ((goggles player) == _itemClass) then {removeGoggles player;};
				if ((vest player) == _itemClass) then {removeVest player;};
				if ((backpack player) == _itemClass) then {removeBackpack player;};
				player removeItem _itemClass;
			};
		};
	}];
}] call Server_Setup_Compile;

["A3PL_EventHandlers_OpenMap",
{
	addMissionEventHandler ["Map", {
		params ["_mapIsOpened","_mapIsForced"];
		if (_mapIsOpened) then {
			call A3PL_Markers_OpenMap;
		} else {
			("A3PL_Map_Filter" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
		};
	}];
}] call Server_Setup_Compile;

["A3PL_EventHandlers_HandleDamage",
{
	player addEventHandler ["HandleDamage",
	{
		private _unit = _this select 0;
		private _selection = _this select 1;
		private _damage = _this select 2;
		private _source = _this select 3;
		private _projectile = _this select 4;
		private _dmg = 0;
		if((_projectile isEqualTo "A3FL_PepperSpray_Ball") && (_unit isEqualTo _source)) exitWith {_dmg;};
		if (_damage > 0) then {
			private _hit = _unit getVariable ["getHit",[]];
			_hit pushback [_selection,_damage,_projectile,_source];
			_unit setVariable ["getHit",_hit,false];
		};
		player setVariable ["lastDamage",(_source getVariable["db_id",0]),true];
		[_unit] spawn A3PL_Medical_Hit;
		_dmg;
	}];
}] call Server_Setup_Compile;

["A3PL_EventHandlers_FiredNear",
{
	player addEventHandler ["FiredNear",
	{
		if(player getVariable ["pVar_RedNameOn",false]) exitWith {};
		private _distance = param [2,100];
		private _weaponClass = param [3,""];
		private _except = ["A3PL_FireExtinguisher","CMFlareLauncher","A3PL_Machinery_Bucket","A3PL_Machinery_Pickaxe","A3PL_Taser","A3PL_Taser2","A3PL_High_Pressure","A3PL_FireAxe","A3PL_Pickaxe","A3PL_Shovel","A3PL_Jaws","A3PL_High_Pressure","A3PL_Scythe","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","A3FL_BaseballBat","A3FL_PoliceBaton","A3FL_GolfDriver","A3FL_PepperSpray"];
		if(_distance <= 30 && (!(_weaponClass IN _except))) then {
			Player_LockView = true;
			Player_LockView_Time = time + (2 * 60);
		};
	}];
}] call Server_Setup_Compile;

["A3PL_EventHandlers_InventoryOpened",
{
	player removeAllEventHandlers "InventoryOpened";
	player addEventHandler ["InventoryOpened",
	{
		params [
			["_unit", objNull, [objNull]],
			["_container", objNull, [objNull]],
			["_secContainer", objNull, [objNull]]
		];
		private _handle = false;
		{
			if((_x isEqualTo A3FL_Seize_Storage)) exitWith  {
				_isLead = ["fims"] call A3PL_Government_isFactionLeader;
				_isLocked = _x getVariable["locked",true];
				if(!_isLead && _isLocked) exitWith  {
					["The storage is locked","red"] call A3PL_Player_Notification;
					_handle = true;
				};
			};
			if(((typeOf _x) isEqualTo "A3PL_EMS_Locker")) exitWith  {
				if (_x animationSourcePhase "door_1" != 1) then {
					_owner = _x getVariable["owner",""];
					if(!((getPlayerUID player) isEqualTo _owner)) exitWith  {
						["The locker is closed","red"] call A3PL_Player_Notification;
						_handle = true;
					};
				} else {
					["This locker is closed",Color_Red] call A3PL_Player_Notification;
				};
			};
		} count [_container, _secContainer];
		_handle;
	}];
}] call Server_Setup_Compile;

["A3PL_EventHandlers_RadioAnim",
{
	["player", "OnBeforeTangent", {
		private _transmit = _this select 4;
		private _vest = vest player;
		private _vestList = [
			"","A3PL_DutyBelt","A3PL_Rangemaster_belt_blk","A3PL_Ghostbusters_Belt","A3PL_Holster_1","V_LegStrapBag_black_F","V_LegStrapBag_coyote_F","V_LegStrapBag_olive_F","A3PL_Sheriff_Belt_Test","A3PL_Rangemaster_belt",
			"A3PL_Clean_Safety_Vest","A3PL_Clean_Safety_Vest_Orange","A3PL_DMV_Safety_Vest","A3PL_FakeNews_Safety","A3PL_VFD_IC_Vest","A3PL_VFD_Vest","A3PL_FIFR_RideAlong_Safety","A3PL_FIFR_Safety","A3PL_FIFR_Safety_Command","A3PL_FIFR_Safety_EMT","A3PL_FIFR_Safety_Fire","A3PL_FIFR_Safety_Lieutenant","A3PL_FIFR_Safety_Paramedic","A3PL_FISD_Safety_Traffic","A3PL_USCG_Ground_Safety_Vest","A3PL_USCG_Safety_Vest_Yellow","A3PL_Waste_Manage_Vest"
		];
		if(_transmit) then {
			if (_vest IN _vestList) then {
				player playActionNow "A3FL_RadioAnim_01";
			} else {
				player playActionNow "A3FL_RadioAnim_02";
			};
		}  else {
			player playActionNow "GestureNod";
		};
	}, Player] call TFAR_fnc_addEventHandler;
}] call Server_Setup_Compile;
