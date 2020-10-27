/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//Player_ObjIntersect replaces cursortarget and is more reliable (is Nil when there is no intersection or object distance > 20m)
//Player_NameIntersect returns the memory interaction point if
//1. 2D distance (player-interaction point/memory point) < 3m
//2. Object distance < 20m
//Otherwise value returns ""
// LIMITATION WARNING: If fire geometry and/or memory points are not properly setup some actions may not show up

// This will calculate a new array (based on defined condition) and feed it to A3PL_Intersect_Lanes based on current nameintersect
['A3PL_Intersect_ConditionCalc',
{
	private _newArray = [];
	{
		if (_this == (_x select 0)) then
		{
			if (call (_x select 3)) then {
				_newArray pushback _x;
			};
		};
	} foreach Config_IntersectArray;
	_newArray;
}] call Server_Setup_Compile;

['A3PL_Intersect_Spikes', {
	private _veh = vehicle player;
	private _spikes = nearestObjects [_veh, ["A3PL_Stinger"], 3];
	if ((count _spikes) < 1) exitwith {};
	private _wheelLF = lineIntersectsWith [AGLToASL (_veh modelToWorldVisual [-1,1.1,-1]),AGLToASL (_veh modelToWorldVisual [-1,0,-3]),_veh];
	private _wheelRF = lineIntersectsWith [AGLToASL (_veh modelToWorldVisual [1,1.1,-1]),AGLToASL (_veh modelToWorldVisual [1,0,-3]),_veh];
	private _wheelLB = lineIntersectsWith [AGLToASL (_veh modelToWorldVisual [-1,-2.4,-1]),AGLToASL (_veh modelToWorldVisual [-1,-1.4,-3]),_veh];
	private _wheelRB = lineIntersectsWith [AGLToASL (_veh modelToWorldVisual [1,-2.4,-1]),AGLToASL (_veh modelToWorldVisual [1,-1.4,-3]),_veh];
	private _spike = _spikes select 0;
	if (_spike IN _wheelLF) then
	{
		private _hit = _veh getVariable "wheelLFSpiked";
		if (!isNil "_hit") exitwith {};
		_veh setVariable ["wheelLFSpiked",true,false];
		"wheel_1_1_steering" call A3PL_Police_SpikeHit;
		_veh spawn {
			sleep 10;
			_this setVariable ["wheelLFSpiked",nil,false];
		};
	};
	if (_spike IN _wheelRF) then
	{
		private _hit = _veh getVariable "wheelRFSpiked";
		if (!isNil "_hit") exitwith {};
		_veh setVariable ["wheelRFSpiked",true,false];
		"wheel_2_1_steering" call A3PL_Police_SpikeHit;
		_veh spawn {
			sleep 10;
			_this setVariable ["wheelRFSpiked",nil,false];
		};
	};
	if (_spike IN _wheelLB) then
	{
		private _hit = _veh getVariable "wheelLBSpiked";
		if (!isNil "_hit") exitwith {};
		_veh setVariable ["wheelLBSpiked",true,false];
		"wheel_1_2_steering" call A3PL_Police_SpikeHit;
		_veh spawn {
			sleep 10;
			_this setVariable ["wheelLBSpiked",nil,false];
		};
	};
	if (_spike IN _wheelRB) then
	{
		private _hit = _veh getVariable "wheelRBSpiked";
		if (!isNil "_hit") exitwith {};
		_veh setVariable ["wheelRBSpiked",true,false];
		"wheel_2_2_steering" call A3PL_Police_SpikeHit;
		_veh spawn {
			sleep 10;
			_this setVariable ["wheelRBSpiked",nil,false];
		};
	};
}] call Server_Setup_Compile;

//To-Dev : ["A3PL_Intersect_Lines", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
['A3PL_Intersect_Lines', {
	if (isDedicated) exitwith {};
	["A3PL_Intersect_Lines", "onEachFrame", {
		private _exit = false;
		private _veh = vehicle player;
		if(!(_veh isEqualTo player)) then {
			if(count(player nearEntities ["A3PL_Stinger", 3]) > 0) then {
			    call A3PL_Intersect_Spikes;
			};
			if(speed _veh > 1) exitWith {_exit=true;};
		};
		if(_exit) exitWith {};

		private _begPos = positionCameraToWorld [0,0,0];
		private _begPosASL = AGLToASL _begPos;
		private _endPos = positionCameraToWorld [0,0,1000];
		private _endPosASL = AGLToASL _endPos;
		private _ins = lineIntersectsSurfaces [_begPosASL, _endPosASL, player, objNull, true, 1, "FIRE", "NONE"];

		if (_ins isEqualTo []) exitWith {};
		_ins select 0 params ["_pos", "_norm", "_obj", "_parent"];
		if (isNull _obj) exitwith {
			private _cur = cursortarget;
			if (!isNull cursortarget) exitwith {
				Player_ObjIntersect = cursortarget;
				Player_NameIntersect = "";
					if ("GroundWeaponHolder" isEqualTo (typeOf _cur)) then {
						private _name = "Gear";
						private _icon = "\a3\ui_f\data\gui\cfg\Hints\gear_ca.paa";
						drawIcon3D [_icon, [1,1,1,1], getpos _cur, 1, 1, 45,_name, 1, 0.05, "PuristaSemiBold"];
					};
			};
			Player_ObjIntersect = player;
			Player_NameIntersect = "";
		};
		
		if (!(getModelInfo _parent select 2) && ((player distance _obj) < 5)) exitWith {
			Player_NameIntersect = "";
			Player_ObjIntersect = _obj;
			{
				if ((_x select 0) == (typeOf _obj)) then {
					private _name = _x select 1;
					private _icon = _x select 2;
					drawIcon3D [_icon, [1,1,1,1], getPos _obj, 1, 1, 45,_name, 1, 0.05, "PuristaSemiBold"];
				};
			} foreach Config_Intersect_NoName;
		};
		if(!(getModelInfo _parent select 2)) exitWith {};

		private _ins2 = [_parent, "FIRE"] intersect [_begPos, _endPos];
		if (_ins2 isEqualTo []) exitWith {
			Player_NameIntersect = "";
			Player_ObjIntersect = _veh;
		};

		_ins2 select 0 params ["_name", "_dist"];
		private _selPos = _obj selectionPosition [_name,"Memory"];
		private _realZero = (player_objintersect isKindOf "House") && {_selPos isEqualTo [0,0,0]};
		if ((_dist >= 4) || {_realZero}) exitwith {
			Player_NameIntersect = "";
			Player_ObjIntersect = _obj;
		};
		if (player_nameIntersect != _name) then {Player_selectedIntersect = 0;};

		Player_NameIntersect = _name;
		Player_ObjIntersect = _obj;

		private _posAGL = _obj modelToWorldVisual (_selPos);
		private _icon = "\a3\ui_f\data\map\GroupIcons\icon_default.paa";
		private _config = (_name call A3PL_Intersect_ConditionCalc);
		private _countConfig = (count _config) - 1;
		if ( player_selectedIntersect > _countConfig) then {
			player_selectedIntersect = _countConfig;
		};
		if(player_selectedIntersect < 0) exitWith {};

		private _configSel = _config select Player_selectedIntersect;
		private _name = format ["→ %1 ←",_configSel select 1];
		private _icon = _configSel select  2;
		drawIcon3D [_icon, [1,1,1,1], _posAGL, 1, 1, 45,_name, 1, 0.05, "PuristaSemiBold"];

		if (_countConfig > player_selectedIntersect) then {
			_posAGL = [_posAGL select 0,_posAGL select 1, (_posAGL select 2) - ((_begPosASL distance _posAGL) / 50)];
			_configSel = _config select (Player_selectedIntersect + 1);
			_name = _configSel select 1;
			_icon = _configSel select 2;
			drawIcon3D ["", [1,1,1,1], _posAGL, 0, 0, 0,_name, 1, 0.036, "PuristaSemiBold"];
		};
		if (player_selectedIntersect > 0) then {
			_posAGL = [_posAGL select 0,_posAGL select 1, (_posAGL select 2) + ((_begPosASL distance _posAGL) / 35)];
			_configSel = _config select (Player_selectedIntersect - 1);
			_name = _configSel select 1;
			_icon = _configSel select 2;
			drawIcon3D ["", [1,1,1,1], _posAGL, 0, 0, 0,_name, 1, 0.036, "PuristaSemiBold"];
		};
	}] call BIS_fnc_addStackedEventHandler;
}] call Server_Setup_Compile;

//Currently has a limit of 20m. Can be changed in A3PL_Intersect_Lines
//This function simply returns player object if player is not looking at anything (aka nothing is being intersected)
['A3PL_Intersect_Cursortarget', {
	if (isNil "Player_ObjIntersect") exitwith {player};
	Player_ObjIntersect
}] call Server_Setup_Compile;

['A3PL_Intersect_CursortargetName', {
	if (isNil "Player_NameIntersect") exitwith {player};
	Player_NameIntersect
}] call Server_Setup_Compile;

['A3PL_Intersect_HandleDoors', {
	private _obj = call A3PL_Intersect_cursortarget;
	private _name = Player_NameIntersect;

	if ((typeOf _obj) isEqualTo "Land_A3FL_Fishers_Jewelry") exitwith {[_obj,_name] call A3PL_Jewelry_HandleDoor;};
	if ((typeOf _obj) isEqualTo "Land_A3PL_Prison") exitwith {[_obj,_name] call A3PL_Prison_HandleDoor;};
	if ((typeOf _obj) isEqualTo "Land_A3FL_DOC_Gate") exitwith {[_obj,_name] call A3PL_PrisonGate_HandleDoor;};
	if ((typeOf _obj) IN ["Land_A3FL_DOC_Wall_Tower","Land_A3FL_DOC_Wall_Tower_Corner"]) exitwith {[_obj,_name] call A3PL_PrisonTower_HandleDoor;};


	private _split = _name splitstring "_";
	if ((((_split select 0) find "garagedoor") != -1) || (((_split select 0) find "hangardoor") != -1)) exitwith
	{
		if ((typeOf _obj) IN ["Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_A3PL_Greenhouse","Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1"]) exitwith
		{
			if (isNil {_obj getVariable "unlocked"}) exitwith
			{
				_format = format[localize'STR_NewIntersect_3'];
				[_format, "red"] call A3PL_Player_Notification;
			};
			if (count _split > 2) then
			{
				[_obj,(_split select 0),false] call A3PL_Lib_ToggleAnimation;
			} else
			{
				[_obj,(_split select 0)] call A3PL_Lib_ToggleAnimation;
			};
		};

		_canUse = true;
		switch (typeOf _obj) do
		{
			case ("Land_A3PL_Firestation"): {
				if (!((player getVariable ["faction","citizen"]) IN ["fifr"]) && !(["vfd",player] call A3PL_DMV_Check)) exitwith {
					_canUse = false;
				};
			};
		};
		if (!_canUse) exitwith {[localize"STR_NewIntersect_1"] call A3PL_Player_Notification;};
		[_obj,(_split select 0)] call A3PL_Lib_ToggleAnimation;
	};

	if ((_split select 0) == "door") then
	{
		private _canUse = true;
		switch (typeOf _obj) do
		{
			case ("Land_A3FL_SheriffPD"): { if ((_name IN ["door_10","door_11","door_12","door_15"]) && !((player getVariable ["job","unemployed"]) IN ["uscg","fisd","fims"])) exitwith {_canUse = false}; };
			case ("Land_A3PL_Sheriffpd"): { if ((_name IN ["door_3","door_4","door_11","door_18","door_19","door_20","garagedoor_button"]) && !((player getVariable ["job","unemployed"]) IN ["uscg","fisd","fims"])) exitwith {_canUse = false}; };
			case ("Land_A3PL_Clinic"): { if ((_name IN ["door_3","door_4","door_5","door_6","door_7","door_8","door_9","door_10","door_11"]) && !((player getVariable ["job","unemployed"]) IN ["fifr"])) exitwith {_canUse = false}; };
			case ("Land_A3PL_Prison"): { if (((_name find "button") != -1) && !((player getVariable ["job","unemployed"]) IN ["fims"])) exitwith {_canUse = false}; };
			case ("Land_A3PL_Firestation"): {
				if (!((player getVariable ["faction","citizen"]) IN ["fifr"]) && !(["vfd",player] call A3PL_DMV_Check)) exitwith {
					_canUse = false;
				};
			};
		};
		if (!_canUse) exitwith {[localize"STR_NewIntersect_1"] call A3PL_Player_Notification;};

		if (((typeOf _obj) IN ["Land_A3PL_Motel","Land_A3PL_Greenhouse"]) || ((typeOf _obj) IN Config_Houses_List) || ((typeOf _obj) IN Config_Warehouses_List)) exitwith
		{
			switch (true) do
			{
				case ((typeOf _obj) isEqualTo "Land_A3PL_Motel"):
				{
					if (_name IN ["door_9","door_10","door_11","door_12","door_13","door_14","door_15","door_16"]) then
					{
						if ((_obj getVariable ["Door_1_locked",true])) exitwith {_format = format[localize'STR_NewIntersect_2'];[_format, "red"] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_2_locked",true])) exitwith {_format = format[localize'STR_NewIntersect_2'];[_format, "red"] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_3_locked",true])) exitwith {_format = format[localize'STR_NewIntersect_2'];[_format, "red"] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_4_locked",true])) exitwith {_format = format[localize'STR_NewIntersect_2'];[_format, "red"] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_5_locked",true])) exitwith {_format = format[localize'STR_NewIntersect_2'];[_format, "red"] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_6_locked",true])) exitwith {_format = format[localize'STR_NewIntersect_2'];[_format, "red"] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_7_locked",true])) exitwith {_format = format[localize'STR_NewIntersect_2'];[_format, "red"] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_8_locked",true])) exitwith {_format = format[localize'STR_NewIntersect_2'];[_format, "red"] call A3PL_Player_Notification;};
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) IN ["Land_A3FL_Office_Building"]):
				{
					if (_name IN ["door_1","door_2","door_3","door_4"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};

						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) isEqualTo "Land_A3PL_ModernHouse3"):
				{
					if (_name IN ["door_1","door_2","door_3","door_16","door_17","door_18"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};

						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) IN ["Land_A3FL_House1_Cream","Land_A3FL_House1_Green","Land_A3FL_House1_Blue","Land_A3FL_House1_Brown","Land_A3FL_House1_Yellow","Land_A3FL_House3_Cream","Land_A3FL_House3_Green","Land_A3FL_House3_Blue","Land_A3FL_House3_Brown","Land_A3FL_House3_Yellow"]):
				{
					if (_name IN ["door_1","door_2","door_3","door_4","door_5"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else {
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};
				case ((typeOf _obj) IN []):
				{
					if (_name IN ["door_1","door_2","door_3","door_4","door_5"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else {
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) IN Config_Houses_List):
				{
					if (_name IN ["door_1","door_2","door_3"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};

						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) isEqualTo "Land_A3FL_Anton_Modern_Bungalow"):
				{
					if (_name IN ["door_1","door_2","door_2","door_4"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};

						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) isEqualTo "Land_Mansion01"):
				{
					if (_name IN ["door_8","door_1"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};

						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) IN ["Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_A3PL_Greenhouse","Land_A3PL_BostonHouse","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_Shed2","Land_A3PL_Shed3","Land_A3PL_Shed4","Land_John_House_Grey","Land_John_House_Blue","Land_John_House_Red","Land_John_House_Green"]):
				{
					if (_name IN ["door_1","door_2"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};
				case ((typeOf _obj) isEqualTo "Land_John_Hangar"):
				{
					if (_name IN ["door_1","door_2"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};

						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) isEqualTo "Land_"):
				{
					if (_name IN ["door_1","door_2"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) isEqualTo "Land_A3FL_Warehouse"):
				{
					if (_name IN ["door_1","door_2","door_3","door_5","door_6","door_7","door_8"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};

						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) IN ["Land_A3FL_House1_Cream","Land_A3FL_House1_Green","Land_A3FL_House1_Blue","Land_A3FL_House1_Brown","Land_A3FL_House1_Yellow","Land_A3FL_House3_Cream","Land_A3FL_House3_Green","Land_A3FL_House3_Blue","Land_A3FL_House3_Brown","Land_A3FL_House3_Yellow"]):
				{
					if (_name IN ["door_1","door_2","door_3","door_4","door_5"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format[localize'STR_NewIntersect_2'];
							[_format, "red"] call A3PL_Player_Notification;
						};

						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

			};
		};
		[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
		if ((_name IN ["door_3_button","door_3_button2","door_5_button","door_5_button2","door_7_button","door_7_button2","door_9_button","door_9_button2","door_13_button","door_13_button2"]) && ((typeOf _obj) IN ["Land_A3PL_Sheriffpd","Land_A3FL_SheriffPD"])) then
		{
			_doorN = (parseNumber (_split select 1)) + 1;
			[_obj,format ["%1_%2",(_split select 0),_doorN],false] call A3PL_Lib_ToggleAnimation;
		};
	};
}] call Server_Setup_Compile;