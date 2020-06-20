/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Vehicle_OpenStorage",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	disableSerialization;
	private ["_veh","_display","_control"];

	if(vehicle player == player) then {
		_veh = param[0,vehicle player];
	} else {
	_veh = param [0,player_objintersect];
	};

	if ((isNull _veh)) exitwith {[localize"STR_NewVehicle_1"] call A3PL_Player_Notification;};

	if (_veh getVariable ["inuse",false]) exitwith {[localize"STR_NewVehicle_2","red"] call A3PL_Player_Notification;};
	_veh setVariable ["inuse",true,true];

	if((vehicle player == player) && (!(animationState player IN ["crew"]))) then {
		player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon';
	};

	createDialog "Dialog_VehicleStorage";

	_display = findDisplay 30;
	A3PL_Veh_Interact = _veh;

	[_display] call A3PL_Vehicle_StorageFillLB;

	_control = _display displayCtrl 1600;
	_control ctrlAddeventhandler ["ButtonDown",{[] call A3PL_Vehicle_AddToVehicle;}];
	_control = _display displayCtrl 1601;
	_control ctrlAddeventhandler ["ButtonDown",{[] call A3PL_Vehicle_TakeFromVehicle;}];

	_display displayAddEventHandler ["unload",{A3PL_Veh_Interact setVariable ["inuse",nil,true]; A3PL_Veh_Interact = nil;}];

	[] spawn {
		private _hndl = ppEffectCreate ['dynamicBlur', 505];
		_hndl ppEffectEnable true;
		_hndl ppEffectAdjust [5];
		_hndl ppEffectCommit 0;
		waitUntil {isNull findDisplay 30};
		ppEffectDestroy _hndl;
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_AddToVehicle",
{
	private["_itemAmount","_vehicleStorage","_inventory"];
	disableSerialization;
	_display = findDisplay 30;

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	_itemAmount = parseNumber (ctrlText 1400);
	if (_itemAmount < 1) exitwith {[localize"STR_NewVehicle_3","red"] call A3PL_Player_Notification;};

	_control = _display displayCtrl 1500;
	_index = lbCurSel _control;
	if (_control lbText _index == "") exitwith {[localize"STR_NewVehicle_4","red"] call A3PL_Player_Notification;};

	_vehicleStorage = A3PL_Veh_Interact getVariable ["storage",[]];
	_inventory = player getVariable ["player_inventory",[]];

	if (_itemAmount > ((_inventory select _index) select 1)) exitwith {[localize"STR_NewVehicle_5","red"] call A3PL_Player_Notification;};
	_itemClass = (_inventory select _index) select 0;

	_vehCapacity = [(typeOf A3PL_Veh_Interact)] call A3PL_Config_GetVehicleCapacity;
	_itemTotalWeight = ([_itemClass, 'weight'] call A3PL_Config_GetItem) * _itemAmount;
	_vehTotalWeight = [A3PL_Veh_Interact] call A3PL_Vehicle_TotalWeight;
	if ((_itemTotalWeight + _vehTotalWeight) > _vehCapacity) exitwith {[format [localize"STR_NewVehicle_6"],"red"] call A3PL_Player_Notification;};

	A3PL_Veh_Interact setVariable ["storage",([_vehicleStorage, _itemClass, _itemAmount,false] call BIS_fnc_addToPairs),true];
	player setVariable ["player_inventory",([_inventory, _itemClass, -(_itemAmount),false] call BIS_fnc_addToPairs),true];
	[] call A3PL_Inventory_Verify;
	[_display,A3PL_Veh_Interact] call A3PL_Vehicle_StorageFillLB;
}] call Server_Setup_Compile;

["A3PL_Vehicle_TakeFromVehicle",
{
	disableSerialization;
	_display = findDisplay 30;

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	_itemAmount = parseNumber (ctrlText 1401);
	if (_itemAmount < 1) exitwith {[localize"STR_NewVehicle_7","red"] call A3PL_Player_Notification;};

	_control = _display displayCtrl 1501;
	_index = lbCurSel _control;
	if (_control lbText _index == "") exitwith {[localize"STR_NewVehicle_8","red"] call A3PL_Player_Notification;};

	_vehicleStorage = A3PL_Veh_Interact getVariable ["storage",[]];
	_inventory = player getVariable ["player_inventory",[]];

	if (_itemAmount > ((_vehicleStorage select _index) select 1)) exitwith {[localize"STR_NewVehicle_9","red"] call A3PL_Player_Notification;};
	_itemClass = (_vehicleStorage select _index) select 0;

	if (([[_itemClass,_itemAmount]] call A3PL_Inventory_TotalWeight) > Player_MaxWeight) exitwith {[format [localize"STR_NewVehicle_10"],"red"] call A3PL_Player_Notification;};

	A3PL_Veh_Interact setVariable ["storage",([_vehicleStorage, _itemClass, -(_itemAmount),false] call BIS_fnc_addToPairs),true];
	player setVariable ["player_inventory",([_inventory, _itemClass, _itemAmount,false] call BIS_fnc_addToPairs),true];
	[A3PL_Veh_Interact] call A3PL_Vehicle_StorageVerify;
	[] call A3PL_Inventory_Verify;
	[_display,A3PL_Veh_Interact] call A3PL_Vehicle_StorageFillLB;
}] call Server_Setup_Compile;

["A3PL_Vehicle_StorageVerify", {
	private ["_veh", "_index", "_forEachIndex","_change"];
	_veh = param [0,objNull];
	_change = false;
	{
		if ((_x select 1) < 1) then {
			_index = _forEachIndex;
			(_veh getVariable "storage") set [_index, "REMOVE"];
			_change = true;
		};
	} forEach (_veh getVariable "storage");

	if (_change) then
	{
		_veh setVariable ["storage", ((_veh getVariable "storage") - ["REMOVE"]), true];
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_StorageFillLB",
{
	private ["_display","_control"];
	_display = param [0,displayNull];

	/* Player Capacity */
	_totalWeight = [] call A3PL_Inventory_TotalWeight;
	_capacity = round((_totalWeight/Player_MaxWeight)*100);
	_capColor = switch(true) do {
		case (_capacity < 20): {"#00FF00"};
		case (_capacity >= 50): {"#FFFF00"};
		case (_capacity >= 75): {"#FFA500"};
		case (_capacity >= 100): {"#ff0000"};
		default {"#ffffff"};
	};
	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format["<t font='PuristaSemiBold' align='center' size='1.35' color='%3'>%1%2</t>", _capacity, "%", _capColor];

	/* Vehcile Capacity */
	_vehTotalWeight = [A3PL_Veh_Interact] call A3PL_Vehicle_TotalWeight;
	_vehCapacity = [(typeOf A3PL_Veh_Interact)] call A3PL_Config_GetVehicleCapacity;
	_capacity = round((_vehTotalWeight/_vehCapacity)*100);
	_capColor = switch(true) do {
		case (_capacity < 20): {"#00FF00"};
		case (_capacity >= 50): {"#FFFF00"};
		case (_capacity >= 75): {"#FFA500"};
		case (_capacity >= 100): {"#ff0000"};
		default {"#ffffff"};
	};
	_control = _display displayCtrl 1101;
	_control ctrlSetStructuredText parseText format["<t font='PuristaSemiBold' align='center' size='1.35' color='%3'>%1%2</t>", _capacity, "%", _capColor];

	/* Player Inventory Listbox */
	_control = _display displayCtrl 1500;
	lbClear _control;
	{
		private ["_itemName", "_amount", "_index","_itemWeight"];
		_itemName = [_x select 0, "name"] call A3PL_Config_GetItem;
		_amount = _x select 1;
		_itemWeight = ([_x select 0, "weight"] call A3PL_Config_GetItem) * _amount;

		_index = _control lbAdd format["%2 %1 (%3 lbs)", _itemName, _amount, _itemWeight];
		_control lbSetData [_index, _x select 0];
	} forEach ([] call A3PL_Inventory_Get);

	/* Vehicle Inventory Listbox */
	_vehInventory = A3PL_Veh_Interact getVariable["storage",[]];
	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		private ["_itemName", "_amount", "_index","_itemWeight"];
		_itemName = [_x select 0, "name"] call A3PL_Config_GetItem;
		_amount = _x select 1;
		_itemWeight = ([_x select 0, "weight"] call A3PL_Config_GetItem) * _amount;

		_index = _control lbAdd format["%2 %1 (%3 lbs)", _itemName, _amount, _itemWeight];
		_control lbSetData [_index, _x select 0];
	} forEach _vehInventory;
}] call Server_Setup_Compile;

["A3PL_Vehicle_TotalWeight",
{
	private _veh = param [0,objNull];
	private _return = 0;
	private _inventory = _veh getVariable["storage",[]];
	{
		private ["_amount", "_itemWeight"];
		_amount = _x select 1;
		_itemWeight = ([_x select 0, 'weight'] call A3PL_Config_GetItem) * _amount;
		_return = _return + _itemWeight;
	} forEach _inventory;
	_return;
}] call Server_Setup_Compile;

["A3PL_Vehicle_AddKey",
{
	private _veh = param [0,objNull];
	private _add = param [1,true];
	if(_add) then {
		if(_veh IN A3PL_Player_Vehicles) exitWith {};
		A3PL_Player_Vehicles pushback _veh;
	} else {
		A3PL_Player_Vehicles = A3PL_Player_Vehicles - [_veh];
	};
	[A3PL_Player_Vehicles, getPlayerUID player] remoteExec ["Server_Vehicle_SaveKeys",2];
	[] call A3PL_Vehicle_KeysVerify;
}] call Server_Setup_Compile;

["A3PL_Vehicle_SetAllKeys",
{
	private _keys = param [0,[]];
	{
		A3PL_Player_Vehicles pushBack _x;
	} forEach _keys;
	[] call A3PL_Vehicle_KeysVerify;
}] call Server_Setup_Compile;

["A3PL_Vehicle_KeysVerify",
{
	private _tmp = A3PL_Player_Vehicles;
	{
		if((isNull _x)) then {
			_tmp deleteAt _forEachIndex;
		};
	} forEach A3PL_Player_Vehicles;
	A3PL_Player_Vehicles = _tmp;
}] call Server_Setup_Compile;

//This function clears all soundSources from an object
//[_veh,true] call A3PL_Vehicle_SoundSourceClear <- that will clear all siren objects from vehicle
//[_veh,false,true] call A3PL_Vehicle_SoundSourceClear <- that will clear only manual siren object from vehicle
//[_veh,false,false] call A3PL_Vehicle_SoundSourceClear <- that will clear only the siren object from vehicle
["A3PL_Vehicle_SoundSourceClear",
{
	private ["_veh"];
	_veh = param [0,objNull];
	_clearAll = param [1,true];
	_clearManual = param [2,true];
	_clearAnim = param [3,true];

	if (_clearAnim) exitwith {
		{deleteVehicle _x} forEach (_veh getVariable "SoundSource");
		_veh animate ["SoundSource_1",0, true];_veh animate ["SoundSource_2",0, true];
		_veh animate ["SoundSource_3",0, true];_veh animate ["SoundSource_4",0, true];
		_veh animate ["SoundSource_5",0, true];_veh animate ["SoundSource_6",0, true];
		_veh animate ["SoundSource_7",0, true];_veh animate ["SoundSource_8",0, true];
		_veh animate ["SoundSource_9",0, true];_veh animate ["SoundSource_10",0, true];
		_veh animate ["SoundSource_11",0, true];_veh animate ["SoundSource_12",0, true];
		_veh animate ["SoundSource_13",0, true];_veh animate ["SoundSource_14",0, true];
		_veh animate ["SoundSource_15",0, true];_veh animate ["SoundSource_16",0, true];
		_veh animate ["SoundSource_17",0, true];_veh animate ["SoundSource_18",0, true];
		_veh animate ["SoundSource_19",0, true];_veh animate ["SoundSource_20",0, true];
	};
	if (_clearAll) exitwith {
		{
			if ((typeOf _x) == "#dynamicSound") then {deleteVehicle _x;};
		} forEach (attachedObjects _veh);
	};
	if (_clearManual) then {
		deleteVehicle (_veh getVariable ["manual",objNull]); //We have to do it this way because setVariable doesn't work on soundSources... retarded and causes siren getting stuck on rare occasions
	} else {
		deleteVehicle (_veh getVariable ["siren",objNull]);
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_SoundSourceCreate",
{
	private ["_sirenType","_veh","_classname","_Siren","_SoundSource_1","_SoundSource_2","_SoundSource_3","_SoundSource_4"];
	_veh = _this;
	_classname = typeOf _veh;
	if(_classname == "C_man_1") then {[getPlayerUID player,"SirenBugAttempt",[]] remoteExec ["Server_Log_New",2];};
	if(_classname == "C_man_1") exitwith {[localize'STR_NewVehicle_11',"red"] call A3PL_Player_Notification;};
	switch (true) do
	{
		case (_classname IN ["A3PL_Pierce_Rescue","A3PL_Pierce_Pumper","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder"]): {_sirenType = "fire";};
		case (_classname IN ["A3PL_Tahoe_FD","A3PL_Taurus_FD","A3PL_Silverado_FD","A3PL_Silverado_FD_Brush"]): {_sirenType = "fire_FR";};
		case (_classname IN ["A3PL_F150_Marker_PD","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_CVPI_PD_Slicktop","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_CVPI_PD","A3PL_RBM","A3PL_Motorboat_Rescue","A3PL_Motorboat_Police","A3PL_Silverado_PD","A3PL_Silverado_PD_ST","A3PL_VetteZR1_PD","A3PL_Raptor_PD","A3PL_Raptor_PD_ST","A3PL_Taurus_PD","A3PL_Taurus_PD_ST","A3PL_Charger15_PD","A3PL_Charger15_PD_ST"]): {_sirenType = "police";};
		case (_classname IN ["Jonzie_Ambulance","A3PL_E350"]): {_sirenType = "ems";};
		case (_classname IN ["A3PL_P362_TowTruck","A3PL_F150_Marker"]): {_sirenType = "civ";};
		case (_classname IN ["A3PL_Yacht","A3PL_Container_Ship","A3PL_Yacht_Pirate","A3PL_Cutter","A3PL_Motorboat","A3PL_RHIB","A3FL_LCM"]): {_sirenType = "Ship";};
		default {_sirenType = "police";};
	};
	switch (_sirenType) do
	{
		case "police":
		{
			_SoundSource_1 = createSoundSource ["A3PL_FSUO_Siren", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_FSS_Phaser", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_FSS_Priority", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_SoundSource_4 = createSoundSource ["A3PL_FSS_Rumbler", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "fire":
		{
			_SoundSource_1 = createSoundSource ["A3PL_EQ2B_Wail", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_Whelen_Warble", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_AirHorn_1", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "fire_FR":
		{
			_SoundSource_1 = createSoundSource ["A3PL_FSUO_Siren", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_Whelen_Priority3", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_FIPA20A_Priority", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_SoundSource_4 = createSoundSource ["A3PL_Electric_Horn", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "ems":
		{
			_SoundSource_1 = createSoundSource ["A3PL_Whelen_Siren", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_Whelen_Priority", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_Whelen_Priority2", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_SoundSource_4 = createSoundSource ["A3PL_Electric_Airhorn", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "civ": {};
		case "Ship": {};
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_SirenHotkey",
{
	private ["_veh","_classname","_sirenType"];
	params[["_action",0,[0]]];
	_veh = vehicle player;
	_classname = typeOf _veh;
	switch (true) do
	{
		case (_classname IN ["A3PL_Pierce_Rescue","A3PL_Pierce_Pumper","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder"]): {_sirenType = "fire";};
		case (_classname IN ["A3PL_Tahoe_FD"]): {_sirenType = "fire_FR";};
		case (_classname IN ["A3PL_F150_Marker_PD","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_CVPI_PD_Slicktop","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_CVPI_PD","A3PL_RBM","A3PL_Motorboat_Rescue","A3PL_Motorboat_Police","A3PL_Silverado_PD","A3PL_VetteZR1_PD","A3PL_Raptor_PD","A3PL_Raptor_PD_ST","A3PL_Taurus_PD","M_explorer"]): {_sirenType = "police";};
		case (_classname IN ["Jonzie_Ambulance","A3PL_E350"]): {_sirenType = "ems";};
		case (_classname IN ["A3PL_P362_TowTruck","A3PL_F150_Marker"]): {_sirenType = "civ";};
		case (_classname IN ["A3PL_Yacht","A3PL_Container_Ship","A3PL_Yacht_Pirate","A3PL_Cutter","A3PL_Motorboat","A3PL_RHIB","A3FL_LCM"]): {_sirenType = "Ship";};
		default {_sirenType = "police";};
	};

	switch (_sirenType) do
	{
		case "police":
		{
			switch (_action) do
			{
				case 1 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animate ["Siren_Control_Switch",0];
					_veh animate ["Directional_Switch",0];
					_veh animate ["Directional_F",0];
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
					};
				};
				case 2 :
				{
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
						_veh call A3PL_Vehicle_SoundSourceCreate;
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					} else
					{
						_veh animateSource ["Lightbar",1];
						player action ["lightOn",_veh];
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					};
				};
				case 3 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;

					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animateSource ["Lightbar",1];
					player action ["lightOn",_veh];
					_veh animate ["Siren_Control_Switch",1];
					_veh animate ["Siren_Control_Noob",12];
					_veh animate ["SoundSource_1",1, true];
					_veh animate ["Directional_Switch",1];
					_veh animate ["Directional_F",1];
				};
				case 4 :
				{
					if (_veh animationPhase "SoundSource_2" == 0) then
					{
						_veh animate ["SoundSource_2",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{

						_veh animate ["SoundSource_2",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 5 :
				{
					if (_veh animationPhase "SoundSource_3" < 0.5 && {A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_3",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_3",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 6 :
				{
					if (_veh animationPhase "SoundSource_4" < 0.5 && {A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_4",1, true];
						_veh animate ["FT_Switch_37",1];
					}else
					{
						_veh animate ["SoundSource_4",0, true];
						_veh animate ["FT_Switch_37",0];
					};
				};
				case 7 :
				{
	        if (_veh animationPhase "PD_Switch_9" < 0.5) then {
	            _veh animate ["PD_Switch_9",1];
							_veh animate ["DS_Floodlights",1];
	        } else {
	            _veh animate ["PD_Switch_9",0];
							_veh animate ["DS_Floodlights",0];
		        };
				};
				case 8 :
				{
					if (_veh animationPhase "PD_Switch_10" < 0.5) then {
	            _veh animate ["PD_Switch_10",1];
							_veh animate ["PS_Floodlights",1];
	        } else {
	            _veh animate ["PD_Switch_10",0];
							_veh animate ["PS_Floodlights",0];
	        };
				};
				case 9 :
				{
	        if (_veh animationSourcePhase "Spotlight" < 0.5 && _veh animationPhase "Spotlight_Addon" > 0.5) then {
	            _veh animateSource ["Spotlight",1];
				if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOn",_veh];};
	        } else {
	            _veh animateSource ["Spotlight",0];
				if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOff",_veh];};
	        };
				};
			};
		};
		case "ems":
		{
			switch (_action) do
			{
				case 1 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animate ["Siren_Control_Switch",0];
					_veh animate ["Directional_Switch",0];
					_veh animate ["Directional_F",0];
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
					};
				};
				case 2 :
				{
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
						_veh call A3PL_Vehicle_SoundSourceCreate;
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					} else
					{
						_veh animateSource ["Lightbar",1];
						player action ["lightOn",_veh];
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					};
				};
				case 3 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animateSource ["Lightbar",1];
					player action ["lightOn",_veh];
					_veh animate ["Siren_Control_Switch",1];
					_veh animate ["Siren_Control_Noob",12];
					_veh animate ["SoundSource_1",1, true];
					_veh animate ["Directional_Switch",1];
					_veh animate ["Directional_F",1];
				};
				case 4 :
				{
					if (_veh animationPhase "SoundSource_2" < 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_2",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_2",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 5 :
				{
					if (_veh animationPhase "SoundSource_3" < 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_3",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_3",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 6 :
				{
					if (_veh animationPhase "SoundSource_4" > 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_4",1, true];
						_veh animate ["FT_Switch_37",1];
					}else
					{
						_veh animate ["SoundSource_4",0, true];
						_veh animate ["FT_Switch_37",0];
					};
				};
			};
		};
		case "fire_FR":
		{
			switch (_action) do
			{
				case 1 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animate ["Siren_Control_Switch",0];
					_veh animate ["Directional_Switch",0];
					_veh animate ["Directional_F",0];
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
					};
				};
				case 2 :
				{
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
						_veh call A3PL_Vehicle_SoundSourceCreate;
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					} else
					{
						_veh animateSource ["Lightbar",1];
						player action ["lightOn",_veh];
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					};
				};
				case 3 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animateSource ["Lightbar",1];
					player action ["lightOn",_veh];
					_veh animate ["Siren_Control_Switch",1];
					_veh animate ["Siren_Control_Noob",12];
					_veh animate ["SoundSource_1",1, true];
					_veh animate ["Directional_Switch",1];
					_veh animate ["Directional_F",1];
				};
				case 4 :
				{
					if (_veh animationPhase "SoundSource_2" < 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_2",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_2",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 5 :
				{
					if (_veh animationPhase "SoundSource_3" < 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_3",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_3",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 6 :
				{
					if (_veh animationPhase "SoundSource_4" > 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_4",1, true];
						_veh animate ["FT_Switch_37",1];
					}else
					{
						_veh animate ["SoundSource_4",0, true];
						_veh animate ["FT_Switch_37",0];
					};
				};
			};
		};
		case "fire":
		{
			switch (_action) do
			{
				case 1 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animate ["Siren_Control_Switch",0];
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
						_veh animate ["Directional_Switch",0];
						_veh animate ["Directional_F",0];
					};
				};
				case 2 :
				{
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
						_veh call A3PL_Vehicle_SoundSourceCreate;
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					} else
					{
						_veh animateSource ["Lightbar",1];
						player action ["lightOn",_veh];
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					};
				};
				case 3 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animateSource ["Lightbar",1];
					player action ["lightOn",_veh];
					_veh animate ["Siren_Control_Switch",1];
					_veh animate ["Siren_Control_Noob",12];
					_veh animate ["SoundSource_1",1, true];
				};
				case 4 :
				{
					if (_veh animationPhase "SoundSource_2" < 0.5) then
					{
						_veh animate ["SoundSource_2",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_2",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 5 :
				{
					if (_veh animationPhase "SoundSource_3" < 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_3",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_3",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
			};
		};
		case "civ":
		{
			switch (_action) do
			{
				case 1 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh animate ["Siren_Control_Switch",0];
					_veh animate ["Directional_Switch",0];
					_veh animate ["Directional_F",0];
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
					};
				};
				case 2 :
				{
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
						_veh animate ["Directional_Switch",0];
						_veh animate ["Directional_F",0];
					} else
					{
						_veh animateSource ["Lightbar",1];
						player action ["lightOn",_veh];
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					};
				};
			};
		};
		case "Ship":
		{
			switch (_action) do
			{
				case 1 :
				{
					if (_veh animationPhase "SoundSource_1" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
					};
				};
				case 2 :
				{
					if (_veh animationPhase "SoundSource_1" < 0.5) then
					{
						_veh animate ["SoundSource_1",1, true];
					};
				};
			};
		};
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_DestroyedMsg",{[localize"STR_NewVehicle_12", "red"] call A3PL_Player_Notification;}] call Server_Setup_Compile;

["A3PL_Vehicle_Repair",
{
	private ["_car","_success"];
	_car = param [0,objNull];
	if (isNull _car) exitwith {};
	if (animationstate player == "Acts_carFixingWheel") exitwith {[localize"STR_NewVehicle_13", "red"] call A3PL_Player_Notification;};
	if (!(vehicle player isEqualTo player)) exitwith {[localize"STR_NewVehicle_14", "red"] call A3PL_Player_Notification;};
	if (Player_ActionDoing) exitwith {[localize"STR_NewVehicle_15","red"] call A3PL_Player_Notification;};
	["Repairing...",30] spawn A3PL_Lib_LoadAction;
	_success = true;
	waitUntil{Player_ActionDoing};
	player playMoveNow 'Acts_carFixingWheel';
	while {Player_ActionDoing} do {
		if ((player distance2D _car) > 15) exitwith {_success = false};
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if ((vehicle player) != player) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
		if ((animationstate player) != "Acts_carFixingWheel") then {player playMoveNow 'Acts_carFixingWheel';};
	};
	player playMoveNow "";
	if(Player_ActionInterrupted || !_success) exitWith {[localize"STR_NewVehicle_16","red"] call A3PL_Player_Notification;};

	[localize"STR_NewVehicle_17", "green"] call A3PL_Player_Notification;
	_car setdammage 0.2;
	[player_item] call A3PL_Inventory_Clear;
	[player,"repairwrench",-1] remoteExec ["Server_Inventory_Add",2];
	[player,2] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_Vehicle_Trailer_Unhitch",
{
	private _trailer = _this select 0;
	private _TruckArray = nearestObjects [(_trailer modelToWorld [0,3,0]), A3PL_HitchingVehicles, 6.5];
	if (count _TruckArray == 0) exitwith {[localize"STR_NewVehicle_18", "red"] call A3PL_Player_Notification;};
	private _truck = _TruckArray select 0;
	[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	[_truck] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	_trailer animateSource ["Hitched",0,true];
	_truck animateSource ["Hitched",0,true];
	[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	[_truck] remoteExec ["Server_Vehicle_EnableSimulation", 2];
}] call Server_Setup_Compile;


["A3PL_Vehicle_Trailer_Hitch",
{
	private ["_truck","_TruckArray","_FrontTrailer","_trailer","_offset","_ramp"];
	_trailer = param [0,objNull];
	_offset = 3;
	_ramp = false;
	if (typeOf _trailer IN ["A3PL_Lowloader"]) then
	{
		_offset = 5;
		if (_trailer animationPhase "ramp" > 0) then {_ramp = true;};
	};
	if (_ramp) exitwith {[localize"STR_NewVehicle_19", "red"] call A3PL_Player_Notification;};

	_TruckArray = nearestObjects [(_trailer modelToWorld [0,_offset,0]), A3PL_HitchingVehicles, 16.5];
	if (count _TruckArray == 0) exitwith {[localize"STR_NewVehicle_20", "red"] call A3PL_Player_Notification;};
	_truck = _truckArray select 0;
	_truck allowDamage false;
	switch(true) do {
		case (typeOf _trailer isEqualTo "A3PL_Lowloader"): {
			_trailer attachTo [_truck, [0, -6.185, -0.2]];
			detach _trailer;
		};
		case (typeOf _trailer isEqualTo "A3PL_Tanker_Trailer"): {
			_trailer attachTo [_truck, [0, -6.9, -0.05]];
			detach _trailer;
		};
		case (typeOf _trailer isEqualTo "A3PL_Box_Trailer"): {
			_trailer attachTo [_truck, [0, -7.9, -0.05]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck isEqualTo "A3PL_Ram")): {
			_trailer attachTo [_truck, [0, -7.55, -0.85]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck isEqualTo "A3PL_Ram")): {
			_trailer attachTo [_truck, [0, -4.485, -0.85]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck isEqualTo "A3PL_Ram")): {
			_trailer attachTo [_truck, [0, -5.48, -0.85]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck IN ["A3PL_F150"])): {
			_trailer attachTo [_truck, [0, -7.73, -0.28]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck IN ["A3PL_F150"])): {
			_trailer attachTo [_truck, [0, -4.73, -0.48]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck IN ["A3PL_F150"])): {
			_trailer attachTo [_truck, [0, -5.75, -0.48]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck IN ["A3PL_F150_Marker"])): {
			_trailer attachTo [_truck, [0, -8.05, 1.27]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck IN ["A3PL_F150_Marker"])): {
			_trailer attachTo [_truck, [0, -5.025, 1.13]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck IN ["A3PL_F150_Marker"])): {
			_trailer attachTo [_truck, [0, -6.03, 1.2]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck IN ["A3PL_Silverado","A3PL_Silverado_PD"])): {
			_trailer attachTo [_truck, [0, -7.87, -0.42]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck IN ["A3PL_Silverado","A3PL_Silverado_PD"])): {
			_trailer attachTo [_truck, [0, -4.84, -0.53]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck IN ["A3PL_Silverado","A3PL_Silverado_PD"])): {
			_trailer attachTo [_truck, [0, -5.84, -0.53]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck IN ["A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_FD"])): {
			_trailer attachTo [_truck, [0, -7.5, -0.13]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck IN ["A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_FD"])): {
			_trailer attachTo [_truck, [0, -4.48, -0.31]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck IN ["A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_FD"])): {
			_trailer attachTo [_truck, [0, -5.5, -0.23]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -7.08, -0.9]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -4.02, -0.95]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -5.02, -1]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -7.28, -0.23]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -4.25, -0.35]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -5.25, -0.32]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck == "A3PL_Camaro")): {
			_trailer attachTo [_truck, [0, -4.38, -0.32]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck == "A3PL_Camaro")): {
			_trailer attachTo [_truck, [0, -5.36, -0.22]];
			detach _trailer;
		};

		default {};
	};

	if ((!(local _truck)) OR (!(local _trailer))) then
	{
		[_truck,_trailer] remoteExec ["Server_Vehicle_Trailer_Hitch",2];
	};

	[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	[_truck] remoteExec ["Server_Vehicle_EnableSimulation", 2];

	_trailer animateSource ["Hitched",20,true];
	_truck animateSource ["Hitched",20,true];

	[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	[_truck] remoteExec ["Server_Vehicle_EnableSimulation", 2];

	[] spawn {uiSleep 60;_truck allowDamage true;};
}] call Server_Setup_Compile;

["A3PL_Vehicle_TrailerAttach",
{
	private ["_trailer","_boats","_boat"];

	_trailer = param [0,objNull];
	if (typeOf _trailer != "A3PL_Small_Boat_Trailer") exitwith {["System: Incorrect type (try again)", "red"] call A3PL_Player_Notification;};
	_boats = nearestObjects [_trailer, ["Ship"], 6];
	if (count _boats < 1) exitwith
	{
		[localize"STR_NewVehicle_21", "red"] call A3PL_Player_Notification;
	};

	_boat = _boats select 0;

	switch (typeOf _boat) do
	{
		case ("A3PL_RHIB"): {_boat attachTo [_trailer,[0,-0.57,0.9]];};
		case default {_boat attachTo [_trailer,[0,-0.25,0.9]]; };
	};
	[_boat] remoteExec ["Server_Vehicle_EnableSimulation", 2];
}] call Server_Setup_Compile;

["A3PL_Vehicle_BigTrailerAttach",
{
	private ["_trailer","_boats","_boat"];

	_trailer = param [0,objNull];
	//if (typeOf _trailer != "A3PL_Boat_Trailer") exitwith {["System: Incorrect type (try again)", "red"] call A3PL_Player_Notification;};
	_boats = nearestObjects [_trailer, ["Ship"], 12];
	if (count _boats < 1) exitwith
	{
		[localize"STR_NewVehicle_22", "red"] call A3PL_Player_Notification;
	};

	_boat = _boats select 0;

	switch (typeOf _boat) do
	{
		case ("A3PL_RHIB"): {_boat attachTo [_trailer,[0,-0.57,0.9]];};
		case ("A3PL_RBM"): {_boat attachTo [_trailer,[-0.199707,-1.18896,2.68]];};
		case default {_boat attachTo [_trailer,[0,-0.25,0.9]]; };
	};
	[_boat] remoteExec ["Server_Vehicle_EnableSimulation", 2];
}] call Server_Setup_Compile;

["A3PL_Vehicle_TrailerRamp",
{
	private ["_trailer"];
	_trailer = param [0,objNull];
	if (isNull _trailer) exitwith {[localize"STR_NewVehicle_23", "red"] call A3PL_Player_Notification;};
	if (!(_trailer isKindOf "Car")) exitwith {[localize"STR_NewVehicle_24", "red"] call A3PL_Player_Notification;};
	if (!(local _trailer)) exitwith {[localize"STR_NewVehicle_25", "red"] call A3PL_Player_Notification;};
	_truck = getPos _trailer nearestObject "A3PL_P362";
	//first check if ramp is up
	if ((_trailer animationPhase "ramp") < 0.5) then
	{
		//lower the ramp
		_trailer animate ["ramp",1];

		[_trailer] spawn
		{
			private ["_trailer","_t"];
			_trailer = param [0,objNull];
			if (isNull _trailer) exitwith {};
			_t = 0;
			waitUntil {sleep 0.1; _t = _t + 0.1; (_t >= 6) OR ((_trailer animationPhase "ramp" >= 1))}; //wait until the the ramp is fully lowered
			if (_trailer animationPhase "ramp" < 0.9) exitwith {_trailer animate ["ramp",0,true]};
			if (!(local _trailer)) exitwith {_trailer animate ["ramp",0,true]};

			//disable simulation on trailer so vehicles can be moved up
			[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];

			//detach the vehicles on the trailer
			{
				detach _x;
			} foreach (attachedObjects _trailer);
		};
	}
	else
	{
		private ["_vehicles","_vehiclesTrailer"];

		//attach all vehicles on the trailer
		_vehicles = nearestObjects [_trailer, ["Air","Thing","LandVehicle","Ship"], 10]; //nearest vehicles
		_vehicles = _vehicles - [_trailer];
		_vehicles = _vehicles - [_truck];
		_vehiclesTrailer = []; //vehicles actually on the trailer
		{
			if ((getpos _x) inArea [_trailer modelToWorld [0,0,0], 6.1, 1,(getDir _trailer+90), true]) then
			{
				_vehiclesTrailer pushback _x;
			};
		} foreach _vehicles;

		//attach only the vehicles on the actual trailer
		{
			//_x attachTo [_trailer];
			[_x,_trailer] call BIS_Fnc_AttachToRelative;
		} foreach _vehiclesTrailer;

		//enablesimulation on the trailer again
		[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];

		//raise the ramp
		_trailer animate ["ramp",0,true];
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_Toggle_Gooseneck",
{
	private ["_trailer"];
	_trailer = param [0,objNull];
	if (isNull _trailer) exitwith {[localize"STR_NewVehicle_26", "red"] call A3PL_Player_Notification;};
	if (!(_trailer isKindOf "Car")) exitwith {[localize"STR_NewVehicle_27", "red"] call A3PL_Player_Notification;};
	if (!(local _trailer)) exitwith {[localize"STR_NewVehicle_28", "red"] call A3PL_Player_Notification;};
	_truck = getPos _trailer nearestObject "A3PL_P362";
	//first check if ramp is up
	if ((_trailer animationSourcePhase "Gooseneck_Hide") < 0.5) then
	{
		//lower the ramp
		_trailer animateSource ["Gooseneck_Hide",1];

		[_trailer] spawn
		{
			private ["_trailer","_t"];
			_trailer = param [0,objNull];
			if (isNull _trailer) exitwith {};
			_t = 0;
			waitUntil {sleep 0.1; _t = _t + 0.1; (_t >= 6) OR ((_trailer animationSourcePhase "Gooseneck_Hide" >= 1))}; //wait until the the ramp is fully lowered
			if (_trailer animationSourcePhase "Gooseneck_Hide" < 0.9) exitwith {_trailer animateSource ["Gooseneck_Hide",0]};
			if (!(local _trailer)) exitwith {_trailer animateSource ["Gooseneck_Hide",0]};

			//disable simulation on trailer so vehicles can be moved up
			[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];

			//detach the vehicles on the trailer
			{
				detach _x;
			} foreach (attachedObjects _trailer);
		};
	} else
	{
		private ["_vehicles","_vehiclesTrailer"];

		//attach all vehicles on the trailer
		_vehicles = nearestObjects [_trailer, ["Air","Thing","LandVehicle","Ship"], 10]; //nearest vehicles
		_vehicles = _vehicles - [_trailer];
		_vehicles = _vehicles - [_truck];
		_vehiclesTrailer = []; //vehicles actually on the trailer
		{
			if ((getpos _x) inArea [_trailer modelToWorld [0,0,0], 6.1, 1,(getDir _trailer+90), true]) then
			{
				_vehiclesTrailer pushback _x;
			};
		} foreach _vehicles;

		//attach only the vehicles on the actual trailer
		{
			//_x attachTo [_trailer];
			[_x,_trailer] call BIS_Fnc_AttachToRelative;
		} foreach _vehiclesTrailer;

		//enablesimulation on the trailer again
		[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];

		//raise the ramp
		_trailer animateSource ["Gooseneck_Hide",0];
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_TrailerAttachObjects",
{
	private ["_trailer"];
	_trailer = param [0,objNull];
	if (isNull _trailer) exitwith {[localize"STR_NewVehicle_29", "red"] call A3PL_Player_Notification;};
	if (!(_trailer isKindOf "Car")) exitwith {[localize"STR_NewVehicle_30", "red"] call A3PL_Player_Notification;};
	if (!(local _trailer)) exitwith {[localize"STR_NewVehicle_31", "red"] call A3PL_Player_Notification;};
	//first check if ramp is up
	if ((_trailer animationsourcePhase "Ramp") < 0.5) then
	{
		//lower the ramp
		_trailer animatesource ["Ramp",1];
		[_trailer] spawn
		{
			private ["_trailer","_t"];
			_trailer = param [0,objNull];
			if (isNull _trailer) exitwith {};
			_t = 0;
			waitUntil {sleep 0.1; _t = _t + 0.1; (_t >= 6) OR ((_trailer animationsourcePhase "Ramp" >= 1))}; //wait until the the ramp is fully lowered
			if (_trailer animationsourcePhase "Ramp" < 0.9) exitwith {_trailer animatesource ["Ramp",0]};
			if (!(local _trailer)) exitwith {_trailer animatesource ["Ramp",0]};

			//disable simulation on trailer so vehicles can be moved up
			[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];

			//detach the vehicles on the trailer
			{
				detach _x;
			} foreach (attachedObjects _trailer);
		};
	} else
	{
		private ["_vehicles","_vehiclesTrailer"];

		//attach all vehicles on the trailer
		_vehicles = nearestObjects [_trailer, ["Air","Thing","LandVehicle","Ship"], 10]; //nearest vehicles
		_vehicles = _vehicles - [_trailer];
		_vehiclesTrailer = []; //vehicles actually on the trailer
		{
			if ((getpos _x) inArea [_trailer modelToWorld [0,0,0], 3.1, 1,(getDir _trailer+90), true]) then
			{
				_vehiclesTrailer pushback _x;
			};
		} foreach _vehicles;

		//attach only the vehicles on the actual trailer
		{
			//_x attachTo [_trailer];
			[_x,_trailer] call BIS_Fnc_AttachToRelative;
		} foreach _vehiclesTrailer;

		//enablesimulation on the trailer again
		[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];
		_trailer animatesource ["Ramp",0];
	};
}] call Server_Setup_Compile;

//toggles rope (ONLY DOWN, UP IS HANDLED BY TOW)
["A3PL_Vehicle_TowTruck_Unloadcar",
{
	private ["_truck","_towpoint","_towing","_alignment","_distance","_height","_Eheight","_angle","_shift","_roleon","_pullup","_traytilt","_unload","_pushdown","_roleoff","_Ramp_up","_Edistance","_towingmass","_truckmass","_Fuel_lvl","_Supported_Vehicles","_UnSupported_Vehicles","_wheel1","_wheel2","_type","_stablecar","_stablize"];
	_truck = _this select 0;
	_towing = _truck getVariable "Towed_Car";
	if ((!local _truck) OR ((!isNull _towing) && (!local _towing))) exitWith {[player,_truck,_towing] remoteExec ["Server_Vehicle_AtegoHandle", 2];[localize"STR_NewVehicle_35"] call A3PL_Player_Notification;};
	if (_truck == _towing) exitWith {};
	_pushdown = true;
	_roleoff = true;
	_distance = 0;
	_Edistance = 0;
	_height = 0;
	_Eheight = 0;
	_shift = 0;
	_angle = 0;
	_towingXYZ = _towing getVariable "XYZ";
	_height = _towingXYZ select 0;
	_Edistance = _towingXYZ select 1;
	_distance = _towingXYZ select 2;
	_Eheight = _towingXYZ select 3;
	_towingdir = _towingXYZ select 4;
	_truckmass = _towingXYZ select 5;
	_towingmass = getMass _towing;
	//_totalmass = _truckmass - _towingmass;
	//_truck setMass [_totalmass,17];
	_Fuel_lvl = fuel _truck;
	//_truck setFuel 0;
	if ((_truck animationSourcePhase "truck_flatbed") < 0.5) then {[_truck,_angle] spawn A3PL_Vehicle_TowTruck_Ramp_down;}else {_angle = -0.230112;};
	while {_pushdown} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" == 1};
		_towing attachTo [_truck,[_shift,_distance,_Eheight],"flatbed_middle"];
		_distance = _distance - 0.01;
		_Eheight = _Eheight - 0.002346;
		if (_distance <= -2.2) then {_pushdown = false;_height = _Eheight;};
		sleep 0.01;
	};
	while {_roleoff} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" == 1};
		_towing attachTo [_truck,[_shift,_distance,_height],"flatbed_middle"];
		_towing setvectorUp [0,_angle,1];
		_distance = _distance - 0.012;
		_height = _height - 0.000846;
		_angle = _angle + 0.000846;
		If (_angle >= 0) then {_roleoff = false;};
		sleep 0.01;
	};
	//[_towing] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	detach _towing;
	_towing setPos getPos _towing;
	_towing setVelocity [0, 0, 1];
	//_truck setFuel _Fuel_lvl;
	_truck setVariable ["Towing",false,true];
	_towing setVariable ["Towed", false, true];
}] call Server_Setup_Compile;

["A3PL_Vehicle_TowTruck_Loadcar",
{
	private ["_truck","_towpoint","_towing","_alignment","_distance","_height","_Eheight","_angle","_shift","_roleon","_pullup","_traytilt","_unload","_pushdown","_roleoff","_Ramp_up","_Edistance","_towingmass","_truckmass","_Fuel_lvl","_Supported_Vehicles","_UnSupported_Vehicles","_wheel1","_wheel2","_type","_stablecar","_stablize"];
	_truck = _this select 0;
	_towpoint = "Land_HelipadEmpty_F" createVehicleLocal (getpos _truck);
	_towpoint attachTo [_truck,[0,-6.41919,-2.1209]];
	_towing = (getpos _towpoint) nearestObject "AllVehicles";
	_alignment = [_truck, _towing] call BIS_fnc_relativeDirTo;
	if ((_towpoint distance _towing) >= 6) exitWith {deleteVehicle _towpoint;[localize"STR_NewVehicle_36", "yellow"] call A3PL_Player_Notification;};
	deleteVehicle _towpoint;
	if (_alignment > 182) exitWith  {[localize"STR_NewVehicle_37", "yellow"] call A3PL_Player_Notification;};
	if (_alignment < 178) exitWith  {[localize"STR_NewVehicle_37", "yellow"] call A3PL_Player_Notification;};
	if ((_truck animationSourcePhase "truck_flatbed") < 0.5) exitWith {[localize"STR_NewVehicle_38", "yellow"] call A3PL_Player_Notification;};
	if (_truck == _towing) exitWith {[localize"STR_NewVehicle_37", "yellow"] call A3PL_Player_Notification;};
	if ((!local _truck) OR ((!isNull _towing) && (!local _towing))) exitWith {[player,_truck,_towing] remoteExec ["Server_Vehicle_AtegoHandle", 2];["Setting Local owner"] call A3PL_Player_Notification;};
	{unassignVehicle _x;_x action ["EJECT", vehicle _x];sleep 0.4;} foreach crew _towing;
	_towing engineOn false;
    //[_towing] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	sleep 0.5;
	_distance = -5.7323;
	_height = 0.373707;
	_Eheight = 0.373707;
	_angle = 0;
	_shift = 0;
	_towing setvectorUp [0,_angle,1];
	_towingdir = [_towing, _truck] call BIS_fnc_relativeDirTo;
	if (_towingdir > 170 && _towingdir < 190) then  {_towingdir = 180;} else {_towingdir = 0;};
	_roleon = true;
	_pullup = true;
	_traytilt = true;
	_unload = false;
	_pushdown = true;
	_roleoff = true;
	_Ramp_up = true;
	_Edistance = 0;
	_towingmass = getMass _towing;
	_truckmass = getMass _truck;
	_Fuel_lvl = fuel _truck;
	//_truck setFuel 0;
	_Supported_Vehicles = ["Jonzie_Datsun_Z432"];
	_UnSupported_Vehicles = ["A3PL_Pierce_Rescue","A3PL_Pierce_Pumper","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_P362_TowTruck","A3PL_Box_Trailer","A3PL_Tanker_Trailer","A3PL_Lowloader","A3PL_Boat_Trailer","A3PL_MobileCrane"];
	if ((typeOf _towing) in _UnSupported_Vehicles) exitWith {[localize"STR_NewVehicle_39", "red"] call A3PL_Player_Notification;};
	if !((typeOf _towing) in _Supported_Vehicles) then
	{
		_wheel1 = _towing selectionPosition "wheel_1_1_bound";
		_wheel2 = _towing selectionPosition "wheel_2_2_bound";

		_height = -(_wheel1 select 2) - 1;
		_Edistance = -((_wheel1 select 1)+(_wheel2 select 1))/2;
		_distance = _Edistance - 5.5;
		_shift = -((_wheel1 select 0)+(_wheel2 select 0))/2;
	};
	_type = typeOf _towing;
	switch (_type) do
	{
		case "A3PL_E350": {_height = _height - 0.2;_shift = _shift + 0.1;};
		case "Jonzie_Ambulance": {_height = _height - 0.2;_Edistance = _Edistance - 0.4;};
		case "A3PL_Small_Boat_Trailer": {_height = _height + 0.3;_Edistance = _Edistance - 1;_shift = _shift - 0.5;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Drill_Trailer": {_shift = _shift - 0.4;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_MiniExcavator": {_towingmass = 2500;_height = _height + 0.5;_Edistance = _Edistance - 1.4;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
	};
	while {_roleon} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" == 1};
		_towing attachTo [_truck,[_shift,_distance,_height],"flatbed_middle"];
		_towing setDir _towingdir;
		_towing setvectorUp [0,_angle,1];
		_distance = _distance + 0.01;
		_height = _height + 0.000846;
		_angle = _angle - 0.000846;
		If (_angle <= -0.23) then {_roleon = false;_Eheight = _height;};
		uiSleep 0.01;
	};
	while {_pullup} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" == 1};
		_towing attachTo [_truck,[_shift,_distance,_Eheight],"flatbed_middle"];
		_distance = _distance + 0.01;
		_Eheight = _Eheight + 0.002346;
		if (_distance >= _Edistance) then {_pullup = false;};
		sleep 0.01;
	};
	[_truck,_angle] spawn A3PL_Vehicle_TowTruck_Ramp_up;
	switch (_type) do
	{
		case "A3PL_E350": {_Endheight = _Eheight + 0.2;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "Jonzie_Ambulance": {_Endheight = _Eheight + 0.35;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Ram": {_Endheight = _Eheight - 0.1;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Tahoe": {_Endheight = _Eheight - 0.05;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Tahoe_PD": {_Endheight = _Eheight - 0.05;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Tahoe_PD_Slicktop": {_Endheight = _Eheight - 0.05;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Tahoe_FD": {_Endheight = _Eheight - 0.05;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Camaro": {_Endheight = _Eheight + 0.04;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Gallardo": {_Endheight = _Eheight + 0.04;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_MailTruck": {_Endheight = _Eheight - 0.08;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_VetteZR1": {_Endheight = _Eheight + 0.06;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_CRX": {_Endheight = _Eheight + 0.08;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Small_Boat_Trailer": {_Endheight = _Eheight + 0.08;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Drill_Trailer": {_Endheight = _Eheight + 0.02;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_MiniExcavator": {_Endheight = _Eheight - 0.15;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_P362": {_Endheight = _Eheight + 0.2;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
	};
	_totalmass = _towingmass + _truckmass;
	//_truck setMass [_totalmass,17];
	_towing setPos getPos _towing;
	//_truck setFuel _Fuel_lvl;
	_towing setVariable ["XYZ", [_height,_Edistance,_distance,_Eheight,_towingdir,_truckmass,_angle], true];
	_towing setVariable ["Towed", true, true];
	_truck setVariable ["Towed_Car",_towing,true];
	_truck setVariable ["Towing",true,true];
}] call Server_Setup_Compile;

["A3PL_Vehicle_TowTruck_Ramp_up",
{
	private ["_truck","_angle","_Ramp_up","_towing"];
	_truck = _this select 0;
	_angle = _this select 1;
	_towing = _truck getVariable "Towed_Car";
	_truck animateSource ["truck_flatbed",0];
	_truck animate ["Ramp_Switch",0];
	if (isNil {_towing}) exitWith  {};
	_Ramp_up = true;
	while {_Ramp_up} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" < 1};
		_angle = _angle + 0.00025567911;
		If (_angle >= -0.00153407466) then {_angle = 0;_Ramp_up = false;};
		_towing setvectorUp [0,_angle,1];
		sleep 0.01;
	};
	_towing setPos getPos _towing;
}] call Server_Setup_Compile;

["A3PL_Vehicle_TowTruck_Ramp_down",
{
	private ["_truck","_angle","_Ramp_down","_towing"];
	_truck = _this select 0;
	_angle = _this select 1;
	_towing = _truck getVariable "Towed_Car";
	_truck animateSource ["truck_flatbed",1];
	_truck animate ["Ramp_Switch",1];
	if (isNil {_towing}) exitWith  {};
	_Ramp_down = true;
	while {_Ramp_down} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" > 0.3};
		_angle = _angle - 0.00025567911;
		If (_angle <= -0.2301112) then {_angle = -0.2301112;_Ramp_down = false;};
		_towing setvectorUp [0,_angle,1];
		sleep 0.01;
	};
	_towing setPos getPos _towing;
}] call Server_Setup_Compile;

["A3PL_Vehicle_Despawn",
{
	private _veh = param [0,objNull];
	{deleteVehicle _x;} foreach (attachedObjects _veh);
	deleteVehicle _veh;
}] call Server_Setup_Compile;

['A3PL_Pickup_Ladder',
{
	private _Ladder = _this select 0;
	_Ladder attachTo [player,  [0, 1, 0]];
	sleep 2;
	_Ladder setdir 180;
	Ladderkeydown =
	{
		_Ladder = nearestObject [player, "A3PL_Ladder"];
		_key = _this select 1;
		_return = false;

		switch _key do {
			case 201: {
				_val = _Ladder animationPhase "Ladder";
				_valu = _val + 0.01;
				if (_valu >= 1) then {_valu = 1};
				_Ladder animate ["Ladder",_valu];
				_return = true;

			};
			case 209: {
				_val = _Ladder animationPhase "Ladder";
				_valu = _val - 0.01;
				if (_valu <= 0) then {_valu = 0};
				_Ladder animate ["Ladder",_valu];
				_return = true;
			};
		};
		_return;
	};
	waituntil {!(IsNull (findDisplay 46))};
	_Ladderkeys = (FindDisplay 46) DisplayAddEventHandler ["keydown","_this call Ladderkeydown;"];
	waitUntil {attachedTo _Ladder != player};
	(finddisplay 46) displayremoveeventhandler ["keydown",_Ladderkeys];
}] call Server_Setup_Compile;

['A3PL_Pickup_Stretcher',
{
	private _Stretcher = _this select 0;
	_Stretcher attachTo [player];
	_Stretcher setdir 0;
}] call Server_Setup_Compile;

["A3PL_Vehicle_Mooring",
{
	private ["_veh","_pos","_boat","_towpos","_rope_1","_MooringPos","_boatrope"];
	_veh = player_objintersect;
	_Pos = Player_NameIntersect;
	_boat = vehicle player;
	if (_boat == _veh) exitWith {};
	if (!(_boat isKindOf "Ship")) exitWith {[localize"STR_NewVehicle_40","yellow"] call A3PL_Player_Notification;};
	_towpos = _boat selectionPosition ["Anchor", "Memory"];
	_MooringPos = _veh selectionPosition Player_NameIntersect;
	_boatrope = nearestObject [_boat, "rope"];
	if(_veh == (ropeAttachedTo _boat)) exitwith {{deleteVehicle _x;} forEach (nearestObjects [_boat, ["rope"], 5])};
	_Rope_1 = ropeCreate [_veh,_MooringPos, _boat, _towpos, 15];
}] call Server_Setup_Compile;

['A3PL_Vehicle_Anchor', {
	private ["_veh","_typeOf","_anchor","_anchorX","_sealevel","_Anchorpos","_AnchorWorldpos","_AnchorX_pos","_AnchorX_Height","_Rope_1","_config_offsetY","_relPos","_offsetX","_offsetZ","_offsetY","_length"];
	_veh = _this select 0;
	_typeOf = typeOf _veh;
	_sealevel = abs (getTerrainHeightASL getPos _veh);
	_anchor = _veh getVariable "Boat_Anchor";
	if (isNil "_anchor") then {_anchor = objNull;};
	if ((speed _veh) > 5) exitWith {};
	if (_veh getVariable ["InUse",false]) exitWith {[localize"STR_NewVehicle_41","yellow"] call A3PL_Player_Notification;};
	//if (!local _veh) exitwith {[netID _veh,netID player] remoteExec ["A3PL_Lib_ChangeLocality", 2];["System: The boat is not local to you - request send to change locality - please try again","yellow"] call A3PL_Player_Notification;};
	if (isNull _anchor) then {
		_veh setVariable ["InUse",true,true];
		_Anchorpos = _veh selectionPosition "Anchor_Release";
		_AnchorWorldpos = _veh modelToWorld _Anchorpos;
		_anchorX = "A3PL_Anchor" createvehicle _AnchorWorldpos;
		_anchorX setPos [_AnchorWorldpos select 0,_AnchorWorldpos select 1,_AnchorWorldpos select 2];
		_AnchorX_pos = getPosATL _anchorX;
		_AnchorX_Height = _AnchorX_pos select 2;
		_Rope_1 = ropeCreate [_veh, "Anchor", _anchorX, [0, 0, 0.4], (_AnchorX_Height + 4)];//
		sleep 1;
		_anchor = "Land_HelipadEmpty_F" createvehicle _AnchorWorldpos;
		_anchor setDir getDir _veh;
		_veh setVariable ["Boat_Anchor",_anchor,true];
		sleep 0.5;
		[_veh, _anchor] call BIS_fnc_attachToRelative;
		_veh setVariable ["InUse",false,true];
	} else {
		_veh setVariable ["InUse",true,true];
		if (count ropes _veh < 1) exitwith {_anchorX = nearestObject [_veh, "A3PL_Anchor"];_veh setVariable ["Boat_Anchor",objNull,true];deleteVehicle _anchor;deleteVehicle _anchorX;_veh setVariable ["InUse",false,true];};
		_Rope_1 = (ropes _veh) select 0;
		_length = ropeLength _Rope_1;
		_windspeed = (_length/10);
		if(typeOf _veh == "A3PL_Yacht")then {_Rope_1 = (nearestObjects [(_veh modeltoworld (_veh selectionPosition ["Anchor", "Memory"])), ["rope"], 30])select 0;};
		ropeUnwind [_Rope_1, _windspeed, 0];
		while {_length > 0.6} do {_length = ropeLength _Rope_1;sleep 0.2;};
		waitUntil {_length < 0.6};
		sleep 2;
		_anchorX = nearestObject [_veh, "A3PL_Anchor"];
		if(typeOf _veh == "A3PL_Yacht")then {{deleteVehicle _x;} forEach (nearestObjects [(_veh modeltoworld (_veh selectionPosition ["Anchor", "Memory"])), ["rope"], 30])}else
		{{ropeDestroy _x;} foreach (ropes _veh)};
		detach _veh;
		sleep 0.1;
		_veh setVariable ["Boat_Anchor",objNull,true];
		deleteVehicle _anchor;
		deleteVehicle _anchorX;
		_veh setVariable ["InUse",false,true];
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_DisableSimulation",
{
	private _veh = _this select 0;
	if ((speed _veh) > 3) exitWith {[localize"STR_NewVehicle_42","yellow"] call A3PL_Player_Notification;};
	if ((typeOf _veh) IN ["A3PL_Cutter","A3FL_LCM"]) then {
		if (simulationEnabled _veh) then {
			[_veh] remoteExec ["Server_Vehicle_EnableSimulation", 2];
			[localize"STR_NewVehicle_43","green"] call A3PL_Player_Notification;
		} else {
			[_veh] remoteExec ["Server_Vehicle_EnableSimulation", 2];
			[localize"STR_NewVehicle_44","green"] call A3PL_Player_Notification;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_SecureHelicopter",
{
	private _cutter = param [0,objNull];
	if (typeOf _cutter != "A3PL_Cutter") exitwith {["System: Incorrect type (try again)", "red"] call A3PL_Player_Notification;};
	private _helis = nearestObjects [_cutter, ["A3PL_Jayhawk","C_Heli_Light_01_civil_F","Heli_Medium01_Coastguard_H","Heli_Medium01_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Military_H","Heli_Medium01_Medic_H","Heli_Medium01_Veteran_H"], 50];
	if (count _helis < 1) exitwith {[localize"STR_NewVehicle_45", "red"] call A3PL_Player_Notification;};
	private _heli = _helis select 0;
	switch (typeOf _heli) do {
		case ("A3PL_Jayhawk"): {_heli attachTo [_cutter,[0,-17,-5.5]];};
		case ("C_Heli_Light_01_civil_F"): {_heli attachTo [_cutter,[0,-17,-7.2]];};
		case ("Heli_Medium01_Coastguard_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_Sheriff_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_Luxury_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_Military_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_Medic_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_Veteran_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
	};
	["Attached helicopter to cutter!", "green"] call A3PL_Player_Notification;
	[_heli] remoteExec ["Server_Vehicle_EnableSimulation", 2];
}] call Server_Setup_Compile;

["A3PL_Vehicle_UnsecureHelicopter",
{
	private _cutter = param [0,objNull];
	if (typeOf _cutter != "A3PL_Cutter") exitwith {["Incorrect type (try again)", "red"] call A3PL_Player_Notification;};
	private _helis = nearestObjects [_cutter, ["A3PL_Jayhawk","C_Heli_Light_01_civil_F"], 50];
	if (count _helis < 1) exitwith {[localize"STR_NewVehicle_46", "red"] call A3PL_Player_Notification;};
	private _heli = _helis select 0;
	{detach _x;} foreach (attachedObjects _cutter);
	[localize"STR_NewVehicle_47", "green"] call A3PL_Player_Notification;

	[_heli] remoteExec ["Server_Vehicle_EnableSimulation", 2];
}] call Server_Setup_Compile;

["A3PL_Vehicle_SecureVehicle",
{
	private _vehicle = param [0,objNull];

	private _ships = nearestObjects [_vehicle, ["A3FL_LCM"], 30];
	if (count _ships < 1) exitwith {[localize"STR_NewVehicle_45", "red"] call A3PL_Player_Notification;};
	private _ship = _ships select 0;

	if(_ship IN A3PL_Player_Vehicles) then {
		[_vehicle, _ship, false] call BIS_fnc_attachToRelative;
		["Attached vehicle to ship!", "green"] call A3PL_Player_Notification;
		[_vehicle] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	} else {
		["You do not have keys to this ship","red"] call A3PL_Player_Notification;
	}
}] call Server_Setup_Compile;

["A3PL_Vehicle_UnsecureVehicle",
{
	private _ship = param [0,objNull];

	{
		detach _x;
		[_x] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	} foreach (attachedObjects _ship);
	["All Vehicles Detached!", "green"] call A3PL_Player_Notification;

}] call Server_Setup_Compile;

["A3PL_Vehicle_Jerrycan",
{
	private _veh = param [0,objNull];

	//exits
	if (isNull _veh) exitwith {};
	if (typeOf _veh IN ["A3PL_RBM","Heli_Medium01_H","Heli_Medium01_Luxury_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Medic_H","Heli_Medium01_H","Heli_Medium01_Luxury_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Medic_H","Heli_Medium01_H","Heli_Medium01_Luxury_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Medic_H","A3PL_Motorboat","A3PL_RHIB","A3PL_Yacht"]) exitwith {["System:You can't a Jerry Can with this vehicle, it takes avgas (Kerosene)","red"] call A3PL_Player_Notification;};
	if (player_itemClass != "jerrycan") exitwith {[localize"STR_NewVehicle_48","red"] call A3PL_Player_Notification;};
	if (!local _veh) exitwith {[localize"STR_NewVehicle_49"] call A3PL_Player_Notification;};
	//take jerrycan from the player
	private _jerryCan = Player_Item;
	[player_itemClass,-1] call A3PL_Inventory_Add;
	Player_Item = objNull;
	Player_ItemClass = '';

	//attach jerrycan to vehicle
	detach _jerryCan;
	private _attachpoint = _veh selectionPosition "gasTank";
	_attachpoint set [0,(_attachPoint select 0) - 0.3];
	_attachpoint set [2,(_attachPoint select 2) + 0.2];
	_jerryCan attachTo [_veh,_attachpoint];
	_jerryCan setVectorDirAndUp [[0,1,0],[1,0,0]];
	playSound3D ["A3PL_Common\effects\gasoline.ogg", _jerrycan, false, getPos _jerryCan, 1.36, 1.1, 0];
	uiSleep 4.5;
	_jerryCan setVectorDirAndUp [[0,1,0],[0,0,1]];
	uiSleep 1;
	deleteVehicle _jerryCan;

	_veh setFuel ((fuel _veh) + 0.25);
	[player,"jerrycan_empty",1] remoteExec ["Server_Inventory_Add",2];
}] call Server_Setup_Compile;

["A3PL_Create_RescueBasket",
{
	private _veh = vehicle player;
	private _basket = "A3PL_RescueBasket" createVehicle [0,0,0];
	_basket allowdamage false;
	_basket setVariable ["locked",false,true];
	_basket attachTo [_veh, [0,999999,0] ];
	_veh setVariable ["basket",_basket,true];
	_basket setVariable ["vehicle",_veh,true];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Unflip",
{
	private ["_car"];
	_car = param [0,objNull];
	if (isNull _car) exitwith {};
	if (animationstate player == "Acts_carFixingWheel") exitwith {[localize"STR_NewVehicle_50", "red"] call A3PL_Player_Notification;};
	if (!(vehicle player == player)) exitwith {[localize"STR_NewVehicle_51", "red"] call A3PL_Player_Notification;};
	if (player getVariable ["repairing",false]) exitwith {[localize"STR_NewVehicle_52", "red"] call A3PL_Player_Notification;};

	[localize"STR_NewVehicle_58", "yellow"] call A3PL_Player_Notification;

	Player_ActionCompleted = false;
	_success = true;
	["Unflip vehicle...",20] spawn A3PL_Lib_LoadAction;
	while {sleep 0.5; !Player_ActionCompleted } do
	{
		if ((player distance2D _car) > 10) exitWith {[localize"STR_NewVehicle_53", "red"] call A3PL_Player_Notification; _success = false;};
		if (!(vehicle player == player)) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
		if (!alive player) exitwith {_success = false;};
		player playmove "Acts_carFixingWheel";
	};
	if (Player_ActionInterrupted || !_success) exitWith {Player_ActionDoing = false;};

	[_car] spawn
	{
		private _car = param [0,objNull];
		_normalVec = surfaceNormal getPos _car;
		_car setVectorUp _normalVec;
		_car setPosATL [getPosATL _car select 0, getPosATL _car select 1, 0];
	};
	player switchMove "";
	[localize"STR_NewVehicle_54", "green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Vehicle_InsureOpen",
{
	disableSerialization;
	createDialog "Dialog_Insurance";
	_display = findDisplay 153;

	_nearVeh = nearestObjects [player, ["Car","Tank","Boat","Plane","Air"], 20];
	_cars = [];
	_whiteList = ["A3PL_CVPI_Rusty","A3PL_MiniExcavator","A3PL_Boat_Trailer","A3PL_Box_Trailer","A3PL_Lowloader","A3PL_Tanker_Trailer","A3PL_Drill_Trailer","A3PL_Small_Boat_Trailer","A3PL_Car_Trailer"];
	{
		if(!(_x getVariable["insurance",false]) && !(typeOf _x IN _whiteList) && (((_x getVariable ["owner",["",""]]) select 0) isEqualTo (getPlayerUID player))) then
		{
			_i = lbAdd [1500, format["%1", getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName")]];
			lbSetData [1500, _i, typeOf _x];
			_cars pushBack _x;
		};
	} forEach (_nearVeh);

	if(count _cars == 0) exitWith {[format [localize"STR_NewVehicle_55"]] call A3PL_Player_notification; closeDialog 0;};

	_control = _display displayCtrl 1500;
	_control ctrlAddEventhandler ["LBSelChanged",
	{
		_control = param [0,ctrlNull];
		_display = findDisplay 153;

		_vehClass = _control lbData (lbCurSel _control);
		_veh = nearestObject [player,_vehClass];
		_price = [_veh] call A3PL_Config_GetInsurancePrice;

		_control = _display displayCtrl 1100;
		_control ctrlSetStructuredText parseText format ["$%1",_price];
	}];
}] call Server_Setup_Compile;

["A3PL_Vehicle_Insure",
{
	_display = findDisplay 153;
	_control = _display displayCtrl 1500;

	_vehClass = _control lbData (lbCurSel _control);
	_veh = nearestObject [player,_vehClass];
	_price = [_veh] call A3PL_Config_GetInsurancePrice;

	//Pay
	if (_price > (player getVariable ["Player_Bank",0])) exitwith {[format [localize"STR_NewVehicle_56"]] call A3PL_Player_notification;};
	player setVariable ["Player_Bank",(player getVariable ["Player_Bank",0]) - _price,true];

	[format [localize"STR_NewVehicle_57", getText (configFile >> "CfgVehicles" >> typeOf _veh >> "displayName"), _price], "green"] call A3PL_Player_Notification;
	//Insure
	_veh setVariable["insurance",true,true];
	[_veh] remoteExec ["Server_Vehicle_Insure",2];

	closeDialog 0;
}] call Server_Setup_Compile;

['A3PL_Goose_Platform', {
    private _veh = param [0,objNull];
    while {local _veh} do {
        private _overWater = !(position _veh isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []);
        private _canDamage = _veh getVariable ["canDamage",true];
        if (_overWater && _canDamage) then {
            _veh allowDamage false;
            _veh setVariable ["canDamage",false,false];
        };
        if (!_overWater && !_canDamage) then {
            _veh allowDamage true;
            _veh setVariable ["canDamage",nil,false];
        };
    };
}, false] call Server_Setup_Compile;

["A3PL_Vehicle_DriverSpotlight", {
	forksdokeydown =
	{
		_key = _this select 1;
		_return = false;
		switch _key do
		{
			case 75:
			{
				_val = vehicle player animationSourcePhase "Spotlight_Rotate";
				_valu = _val + 0.02;
				if (_valu >= 1.047) then {_valu = 1.047};
				vehicle player animateSource ["spotlight_rotate",_valu];
				_return = true;
			};
			case 77:
			{
				_val = vehicle player animationSourcePhase "Spotlight_Rotate";
				_valu = _val - 0.02;
				if (_valu <= -1.571) then {_valu = -1.571};
				vehicle player animateSource ["spotlight_rotate",_valu];
				_return = true;
			};
		};
		_return;
	};
	waituntil {!isNull findDisplay 46};
	_forkskeys = (findDisplay 46) DisplayAddEventHandler ["keydown","_this call forksdokeyDown"];
	waitUntil {!((typeOf (vehicle player)) IN ["A3PL_Raptor_PD","A3PL_Raptor_PD_ST","A3PL_Taurus_PD","A3PL_Taurus_PD_ST","A3PL_Taurus_FD","A3PL_Charger15_PD","A3PL_Charger15_PD_ST"])};
	(findDisplay 46) displayremoveeventhandler ["keydown",_forkskeys];
}] call Server_Setup_Compile;

["A3PL_Vehicle_LCMRamp", {
	forksdokeydown =
	{
		_key = _this select 1;
		_return = false;
		switch _key do
		{
			case 75:
			{
				_val = vehicle player animationSourcePhase "trunk";
				_valu = _val + 0.01;
				if (_valu >= 1) then {_valu = 1};
				vehicle player animateSource ["trunk",_valu];
				_return = true;
			};
			case 77:
			{
				_val = vehicle player animationSourcePhase "trunk";
				_valu = _val - 0.01;
				if (_valu <= 0) then {_valu = 0};
				vehicle player animateSource ["trunk",_valu];
				_return = true;
			};
		};
		_return;
	};
	waituntil {!isNull findDisplay 46};
	_forkskeys = (findDisplay 46) DisplayAddEventHandler ["keydown","_this call forksdokeyDown"];
	waitUntil {!((typeOf (vehicle player)) IN ["A3FL_LCM"])};
	(findDisplay 46) displayremoveeventhandler ["keydown",_forkskeys];
}] call Server_Setup_Compile;
