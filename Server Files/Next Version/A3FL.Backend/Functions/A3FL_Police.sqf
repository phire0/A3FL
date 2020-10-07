/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Police_GPS",
{
	private _job = player getVariable ["job","unemployed"];
	private _vehicles = [];
	private _markerColor = "colorBLUFOR";
	if(!(_job IN ["fisd","fifr","fims","uscg"]) && !isNil "A3PL_Police_GPSmarkers") exitWith {
		{deleteMarkerLocal _x} foreach A3PL_Police_GPSmarkers;
		A3PL_Police_GPSmarkers = nil;
	};

	switch (_job) do {
		case ("fifr"): {
			_markerColor = "ColorRed";
			{
				_found = false;
				if((typeOf _x) isEqualTo "A3PL_Silverado_FD_Brush") then {
					_vehicles pushback [_x,"BRUSH #"];
					_found = true;
				};
				if((typeOf _x) isEqualTo "A3PL_Pierce_Pumper") then {
					_vehicles pushback [_x,"ENGINE #"];
					_found = true;
				};
				if((typeOf _x) isEqualTo "A3PL_Pierce_Ladder") then {
					_vehicles pushback [_x,"LADDER #"];
					_found = true;
				};
				if((typeOf _x) isEqualTo "A3PL_Pierce_Rescue") then {
					_vehicles pushback [_x,"RESCUE #"];
					_found = true;
				};
				if((typeOf _x) isEqualTo "A3PL_Pierce_Heavy_Ladder") then {
					_vehicles pushback [_x,"HEAVY LADDER #"];
					_found = true;
				};
				if((typeOf _x) IN ["A3PL_E350","Jonzie_Ambulance"]) then {
					_vehicles pushback [_x,"EMS #"];
					_found = true;
				};
				if(((typeOf _x) IN ["A3PL_CVPI_PD","A3PL_Tahoe_FD","A3PL_Raptor_PD","A3PL_Taurus_FD","A3PL_Charger15_FD"]) && ((_x getVariable["faction",""]) isEqualTo _job)) then {
					_vehicles pushback [_x,"CAR #"];
					_found = true;
				};
				if((typeOf _x) isEqualTo "Heli_Medium01_Medic_H") then {
					_vehicles pushback [_x,"AIR UNIT #"];
					_found = true;
				};
				if(!_found) then {
					if (((typeOf _x) find "_FD") != -1) then {
						_vehicles pushback [_x,"FD #"];
					};
				};
			} foreach vehicles;
		};
		case ("uscg"): {
			{
				private ["_faction","_type"];
				_type = typeOf _x;
				_faction = _x getVariable["faction",""];
				if ((_type isEqualTo "A3PL_Cutter")) then {
					_vehicles pushback [_x,"USCG CUTTER "];
				};
				if ((_type isEqualTo "A3PL_Goose_USCG")) then {
					_vehicles pushback [_x,"WHALE UNIT"];
				};
				if (_type isEqualTo "A3PL_RBM") then	{
					_vehicles pushback [_x,"MARITIME UNIT #"];
				};
				if (_type isEqualTo "A3PL_Jayhawk") then {
					_vehicles pushback [_x,"AIR UNIT #"];
				};
				if (((_type find "_PD") != -1) && (_faction isEqualTo _job)) then {
					_vehicles pushback [_x,"SQUAD #"];
				};
			} foreach vehicles;
		};
		default {
			{
				private ["_faction","_type"];
				_type = typeOf _x;
				_faction = _x getVariable["faction",""];
				if((_type find "_PD") != -1) then {
					if(_faction isEqualTo _job) then {
						_vehicles pushback [_x,"SQUAD #"];
					};
				};
			} foreach vehicles;
		};
	};

	if (!isNil "A3PL_Police_GPSmarkers") then {
		{deleteMarkerLocal _x;} foreach A3PL_Police_GPSmarkers;
	};

	A3PL_Police_GPSmarkers = [];
	{
		private _veh = _x select 0;
		private _title = _x select 1;
		private _netId = ((netId _veh) splitString ":") select 1;
		private _squadnb = _veh getVariable["squadnb",_netId];
		_marker = createMarkerLocal [format["unit_%1",_netId],visiblePosition (_veh)];
		_marker setMarkerTypeLocal "A3PL_GPS";
		_marker setMarkerColorLocal _markerColor;
		_marker setMarkerSizeLocal [0.7, 0.7];
		_marker setMarkerDirLocal floor((getDir _veh) - 40);
		_marker setMarkerTextLocal format["%1%2",_title,_squadnb];
		A3PL_Police_GPSmarkers pushback _marker;
	} foreach _vehicles;
}] call Server_Setup_Compile;

["A3PL_Police_HandleBreach",
{
	private _whitelist = ["fisd","uscg","fims"];
	private _pJob = player getVariable["job","unemployed"];
	if(!(_pJob IN _whitelist)) exitWith {};

	private _intersect = missionNameSpace getVariable ["player_objintersect",objNull];
	private _nameIntersect = missionNameSpace getVariable ["player_nameintersect",""];

	if ((player distance (_intersect modelToWorld (_intersect selectionPosition _nameIntersect)) < 2) && (_nameIntersect IN ["door_1","door_2","door_3","door_4","door_5","door_6","door_7","door_8","door_9","door_10","door_11","door_12","door_13","door_14","door_15","door_16","door_17","door_18","door_19","door_20","door_21","door_22","door_23","door_24","door_25","door_26","door_27","door_28","door_29","door_30","door_31","door_32","door_33","door_34","door_35","door_36","door_37","door_38","door_39","door_40","door_41","door_42","door_43","door_44","door_45","door_46","door_47","door_48","door_49","door_50","storagedoor1","storagedoor2","storagedoor3","sdstoragedoor3","sdstoragedoor6","door_1_button","door_2_button","door_3_button","door_4_button","door_5_button","door_6_button","door_7_button","door_8_button","door_9_button","door_10_button","door_11_button","door_12_button","door_13_button","door_14_button","door_15_button","door_16_button","door_17_button","door_18_button","door_19_button","door_20_button","door_21_button","door_22_button","door_23_button","door_24_button","door_25_button","door_26_button","door_27_button","door_28_button","door_29_button","door_30_button","door_1_button2","door_2_button2","door_3_button2","door_4_button2","door_5_button2","door_6_button2","door_7_button2","door_8_button2","door_9_button2","door_10_button2","door_11_button2","door_12_button2","door_13_button2","door_14_button2","door_15_button2","door_16_button2","door_17_button2","door_18_button2","door_19_button2","door_20_button2","door_21_button2","door_22_button2","door_23_button2","door_24_button2","door_25_button2","door_26_button2","door_27_button2","door_28_button2","door_29_button2","door_30_button2","door_8_button1","door_8_button2"])) then {
		if (_nameIntersect IN ["door_1_button","door_2_button","door_3_button","door_4_button","door_5_button","door_6_button","door_7_button","door_8_button","door_9_button","door_10_button","door_11_button","door_12_button","door_13_button","door_14_button","door_15_button","door_16_button","door_17_button","door_18_button","door_19_button","door_20_button","door_21_button","door_22_button","door_23_button","door_24_button","door_25_button","door_26_button","door_27_button","door_28_button","door_29_button","door_30_button","door_1_button2","door_2_button2","door_3_button2","door_4_button2","door_5_button2","door_6_button2","door_7_button2","door_8_button2","door_9_button2","door_10_button2","door_11_button2","door_12_button2","door_13_button2","door_14_button2","door_15_button2","door_16_button2","door_17_button2","door_18_button2","door_19_button2","door_20_button2","door_21_button2","door_22_button2","door_23_button2","door_24_button2","door_25_button2","door_26_button2","door_27_button2","door_28_button2","door_29_button2","door_30_button2","door_8_button1","door_8_button2"]) then {[] call A3PL_Intersect_HandleDoors;};
		_intersect animate [_nameIntersect,1];
		_intersect setvariable [_var,0,false];
		_intersect setVariable [_var,(_intersect getVariable [_var,0]) + 0.2,false];
	};
}] call Server_Setup_Compile;

["A3PL_Police_PatDown",
{
	private _target = param [0,objNull];
	if (!Player_ActionCompleted) exitwith {[localize"STR_NewPolice_1","red"] call A3PL_Player_Notification;};
	if (_target getVariable ["patdown",false]) exitwith {[localize"STR_NewPolice_2","red"] call A3PL_Player_Notification;};
	_target setVariable ["patdown",true,true];

	[localize"STR_NewPolice_3", "green"] remoteExec ["A3PL_Player_Notification",_target];
	[player,"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown"] remoteExec ["A3PL_Lib_SyncAnim",0];
	[_target] spawn
	{
		private _target = param [0,objNull];
		if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
		["Pat down in progress...",8] spawn A3PL_Lib_LoadAction;
		private _success = true;
		waitUntil{Player_ActionDoing};
		while {Player_ActionDoing} do {
			if ((player distance2D _target) > 5) exitWith {_success = false;};
			if ((animationState player) isEqualTo "amovpercmstpsnonwnondnon") then {[player,"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown"] remoteExec ["A3PL_Lib_SyncAnim",0];};
		};
		player switchMove "";
		if(Player_ActionInterrupted || !_success) exitWith {
			["Patdown cancelled","red"] call A3PL_Player_Notification;
			["The patdown was cancelled", "green"] remoteExec ["A3PL_Player_Notification",_target];
			_target setVariable ["patdown",nil,true];
		};
		_target setVariable ["patdown",nil,true];

		_items = assignedItems _target + items _target;
		_vitems = [_target] call A3PL_Inventory_Get;
		_weps = weapons _target;
		_mags = magazines _target;
		if (currentMagazine _target != "") then {_mags pushback (currentMagazine _target);};

		createDialog "Dialog_PatDown";
		_display = findDisplay 93;

		_control = _display displayCtrl 1500;
		{
			_index = _control lbAdd format ["%1",getText (configFile >> "CfgWeapons" >> _x >> "displayName")];
			_control lbSetData [_index,_x];
			_control lbSetValue [_index,0];
		} foreach _items;

		_uniform = uniform _target;
		if(!(_uniform isEqualTo "")) then {
			_index = _control lbAdd format ["%1",getText (configFile >> "CfgWeapons" >> _uniform >> "displayName")];
			_control lbSetData [_index,_uniform];
			_control lbSetValue [_index,1];
		};

		_vest = vest _target;
		if(!(_vest isEqualTo "")) then {
			_index = _control lbAdd format ["%1",getText (configFile >> "CfgWeapons" >> _vest >> "displayName")];
			_control lbSetData [_index,_vest];
			_control lbSetValue [_index,2];
		};

		_backpack = backpack _target;
		if(!(_backpack isEqualTo "")) then {
			_index = _control lbAdd format ["%1",getText (configFile >> "CfgVehicles" >> _backpack >> "displayName")];
			_control lbSetData [_index,_backpack];
			_control lbSetValue [_index,3];
		};

		_control lbSetCurSel 0;


		_control = _display displayCtrl 1501;
		{
			_index = _control lbAdd format ["%1",getText (configFile >> "CfgWeapons" >> _x >> "displayName")];
			_control lbSetData [_index,_x];
			_control lbSetValue [_index,0];
		} foreach _weps;
		{
			_index = _control lbAdd format ["%1",getText (configFile >> "CfgMagazines" >> _x >> "displayName")];
			_control lbSetData [_index,_x];
			_control lbSetValue [_index,1];
		} foreach _mags;
		_control lbSetCurSel 0;

		_control = _display displayCtrl 1502;
		{
			_index = _control lbAdd format ["(%2x) %1",[_x select 0, "name"] call A3PL_Config_GetItem, _x select 1];
			_control lbSetData [_index,_x select 0];
			_control lbSetValue [_index,_x select 1];
		} foreach _vitems;

		_index = _control lbAdd format["$%1", [_target getVariable ["Player_Cash",0]] call A3PL_Lib_MoneyFormat];
		_control lbSetData [_index,"cash"];
		_control lbSetValue [_index,_target getVariable ["Player_Cash",0]];
		_control lbSetCurSel 0;

		_control = _display displayCtrl 1600;
		_control ctrlAddEventHandler ["buttonDown",{["item"] call A3PL_Police_PatDownTake}];
		_control = _display displayCtrl 1601;
		_control ctrlAddEventHandler ["buttonDown",{["wep"] call A3PL_Police_PatDownTake}];
		_control = _display displayCtrl 1602;
		_control ctrlAddEventHandler ["buttonDown",{["vitems"] call A3PL_Police_PatDownTake}];

		A3PL_Police_Target = _target;
		_display displayAddEventHandler ["unload",{A3PL_Police_Target setVariable ["patdown",nil,true]; A3PL_Police_Target = nil; A3PL_Police_WeaponHolder = nil;}];
	};
}] call Server_Setup_Compile;

["A3PL_Police_PatDownTake",
{
	disableSerialization;
	private ["_type","_class","_target","_weaponHolder","_display","_control","_itemName"];
	_type = param [0,""];
	_display = findDisplay 93;
	if (isNil "A3PL_Police_Target") exitwith {["System: Error in Police_PatDownTake :: _target is undefined"] call A3PL_Player_Notification;};

	_target = A3PL_Police_Target;
	if (isNil "A3PL_Police_WeaponHolder") then
	{
		A3PL_Police_WeaponHolder = createVehicle ["GroundWeaponHolder", getposATL player, [], 0, "CAN_COLLIDE"];
	} else
	{
		if (isNull A3PL_Police_WeaponHolder) then
		{
			A3PL_Police_WeaponHolder = createVehicle ["GroundWeaponHolder", getposATL player, [], 0, "CAN_COLLIDE"];
		};
	};
	_weaponHolder = A3PL_Police_WeaponHolder;

	_amount = 1;
	switch (_type) do
	{
		case ("item"):
		{
			_control = _display displayCtrl 1500;
			_class = _control lbData (lbCurSel _control);
			_itemtype = _control lbValue (lbCurSel _control);
			switch (_itemtype) do
			{
				case 0:
				{
					_itemName = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
					if (_class IN (assignedItems _target)) then
					{
						_target unAssignItem _class;
					};
					_target removeItem _class;
					_weaponHolder addItemCargoGlobal [_class,1];
				};
				case 1:
				{
					_itemName = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
					removeUniform _target;
					_weaponHolder addItemCargoGlobal [_class,1];
				};
				case 2:
				{
					_itemName = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
					removeVest _target;
					_weaponHolder addItemCargoGlobal [_class,1];
				};
				case 3:
				{
					_itemName = getText (configFile >> "CfgVehicles" >> _class >> "displayName");
					removeBackpackGlobal _target;
					_weaponHolder addBackpackCargoGlobal [_class,1];
				};
			};
		};
		case ("wep"):
		{
			_control = _display displayCtrl 1501;
			_class = _control lbData (lbCurSel _control);
			if(isClass (configFile >> "CfgWeapons" >> _class)) then {
				_itemName = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
				{
					if (_x isEqualTo _class) exitWith {
						_target removeWeaponGlobal _x;
					};
				} forEach weapons _target;
				{
					if (_x isEqualTo _class) exitWith {
						_target removeItemFromUniform _x;
					};
				} forEach uniformItems _target;
				{
					if (_x isEqualTo _class) exitWith {
						_target removeItemFromVest _x;
					};
				} forEach vestItems _target;
				{
					if (_x isEqualTo _class) exitWith {
						_target removeItemFromBackpack _x;
					};
				} forEach backpackItems _target;
				_weaponHolder addWeaponCargoGlobal [_class,1];
			} else {
				_itemName = getText (configFile >> "CfgMagazines" >> _class >> "displayName");
				_target removeMagazineGlobal _class;
				_weaponHolder addMagazineCargoGlobal [_class,1];
			};
		};
		case ("vitems"):
		{
			_control = _display displayCtrl 1502;
			_class = _control lbData (lbCurSel _control);
			_amount = _control lbValue (lbCurSel _control);
			_itemName = [_class, "name"] call A3PL_Config_GetItem;
			if(_class isEqualTo "cash") then {
				[_target, 'Player_Cash', ((_target getVariable 'Player_Cash') - _amount)] remoteExec ["Server_Core_ChangeVar",2];
				[player, 'Player_Cash', ((player getVariable 'Player_Cash') + _amount)] remoteExec ["Server_Core_ChangeVar",2];
			} else {
				[_class,-_amount] remoteExec ["A3PL_Inventory_Add",_target];
				[_class,_amount] call A3PL_Inventory_Add;
			};
		};
	};
	_control lbDelete (lbCurSel _control);
	[player, 5] call A3PL_Level_AddXP;

	[format [localize"STR_NewPolice_6",_itemName,_amount],"green"] call A3PL_Player_Notification;
	[format [localize"STR_NewPolice_7",_itemName,_amount]] remoteExec ["A3PL_Player_Notification",_target];
}] call Server_Setup_Compile;

['A3PL_Police_Cuff', {
	private _obj = _this select 0;
	if ((animationState _obj) IN ["amovpercmstpsnonwnondnon","amovpercmstpsraswrfldnon","amovpercmstpsraswpstdnon","amovpercmstpsraswlnrdnon"]) exitwith
	{
		_obj setVariable ["Cuffed",true,true];
		[player,_obj,1] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
	};
	if ((animationState _obj) isEqualTo "a3pl_idletohandsup") exitwith
	{
		_obj setVariable ["Cuffed",true,true];
		[player,_obj,2] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
	};
	if ((animationState _obj) isEqualTo "a3pl_handsuptokneel") exitwith
	{
		_obj setVariable ["Cuffed",true,true];
		[player,_obj,3] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
	};
	if (animationState _obj IN ["amovpknlmstpsnonwnondnon","amovpknlmstpsraswpstdnon","amovpknlmstpsraswrfldnon","amovpknlmstpsraswlnrdnon"]) exitwith
	{
		_obj setVariable ["Cuffed",true,true];
		[player,_obj,4] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
	};
	if (animationState _obj IN ["amovppnemstpsnonwnondnon","amovppnemstpsraswrfldnon","amovppnemstpsraswpstdnon"]) exitwith
	{
		_obj setVariable ["Cuffed",true,true];
		[player,_obj,5] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
	};
	if ((animationState _obj) isEqualTo "unconscious") exitwith
	{
		_obj setVariable ["Cuffed",true,true];
		[player,_obj,5] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
	};
	_obj setVariable ["Cuffed",true,true];
	[false] call A3PL_Inventory_PutBack;
	["handcuffs", 1] call A3PL_Inventory_Remove;
	waitUntil{(animationState _obj) isEqualTo "amovppnemstpsnonwnondnon"};
	[player,_obj,5] remoteExec ["A3PL_Police_HandleAnim",0];
}] call Server_Setup_Compile;

['A3PL_Police_Uncuff', {
	private _obj = _this select 0;
	private _Cuffed = _obj getVariable ["Cuffed",true];
	if (_Cuffed) then {
		["handcuffs",1] call A3PL_Inventory_Add;
		[player,_obj,7] remoteExec ["A3PL_Police_HandleAnim",0];
		_obj setVariable ["Cuffed",false,true];
		_obj setVariable ["dragged",nil,true];
		if((vehicle _obj) isEqualTo _obj) then {
			["gesture_stop",_obj] call A3PL_Lib_Gesture;
			[_obj,""] remoteExec ["A3PL_Lib_SyncAnim", -2];
		};
	};
}] call Server_Setup_Compile;

['A3PL_Police_CuffKick', {
	private _obj = _this select 0;
	if ((animationState _obj) isEqualTo "a3pl_handsupkneelcuffed") then {
		[player,_obj,6] remoteExec ["A3PL_Police_HandleAnim", -2];
	};
}] call Server_Setup_Compile;

['A3PL_Police_HandleAnim', {
	private _cop = _this select 0;
	private _civ = _this select 1;
	private _number = _this select 2;
	switch (_number) do
	{
		case 1:
		{
			if (local _civ) then
			{
				if (!isPlayer _civ) exitwith {
					_civ setdir ((getDir _civ) + 50);
				};
				player setdir ((getDir player) + 50);
			};
			[_cop,_civ] spawn
			{
				private _cop = _this select 0;
				private _civ = _this select 1;
				_civ switchmove "A3PL_HandsupToKneel";
				sleep 5;
				_civ switchmove "A3PL_HandsupKneelGetCuffed";
				_cop switchmove "A3PL_Cuff";
				if (local _cop) then {
					_cop attachTo [_civ,[0,0,0]];
				};
				sleep 4;
				if (local _cop) then {
					detach _cop;
				};
				_civ switchmove "A3PL_HandsupKneelCuffed";
				_cop switchmove "";
			};
		};
		case 2:
		{
			[_cop,_civ] spawn
			{
				private _cop = _this select 0;
				private _civ = _this select 1;
				_civ switchmove "A3PL_HandsupToKneel";
				sleep 5;
				_civ switchmove "A3PL_HandsupKneelGetCuffed";
				_cop switchmove "A3PL_Cuff";
				if (local _cop) then {
					_cop attachTo [_civ,[0,0,0]];
				};
				sleep 4;
				if (local _cop) then {
					detach _cop;
				};
				_civ switchmove "A3PL_HandsupKneelCuffed";
				_cop switchmove "";
			};
		};
		case 3:
		{
			[_cop,_civ] spawn
			{
				private _cop = _this select 0;
				private _civ = _this select 1;
				_civ switchmove "A3PL_HandsupKneelGetCuffed";
				_cop switchmove "A3PL_Cuff";
				if (local _cop) then {
					_cop attachTo [_civ,[0,0,0]];
				};
				sleep 4;
				if (local _cop) then {
					detach _cop;
				};
				_civ switchmove "A3PL_HandsupKneelCuffed";
				_cop switchmove "";
			};
		};
		case 4:
		{
			if (local _civ) then {
				if (!isPlayer _civ) exitwith {
					_civ setdir ((getDir _civ) + 50);
				};
				player setdir ((getDir player) + 50);
			};
			[_cop,_civ] spawn
			{
				private _cop = _this select 0;
				private _civ = _this select 1;
				_civ switchmove "A3PL_HandsupKneelGetCuffed";
				_cop switchmove "A3PL_Cuff";
				if (local _cop) then {
					_cop attachTo [_civ,[0,0,0]];
				};
				sleep 4;
				if (local _cop) then {
					detach _cop;
				};
				_civ switchmove "A3PL_HandsupKneelCuffed";
				_cop switchmove "";
			};
		};
		case 5:
		{
			if (local _civ) then
			{
				if (!isPlayer _civ) exitwith
				{
					_civ setdir ((getDir _civ) + 50);
				};
				player setdir ((getDir player) + 50);
			};
			_civ switchmove "A3PL_HandsupKneelKicked";
		};
		case 6:
		{
			[_cop,_civ] spawn
			{
				private _cop = _this select 0;
				private _civ = _this select 1;
				_cop switchmove "A3PL_CuffKickDown";
				if (local _cop) then {
					_cop attachTo [_civ,[0,0,0]];
				};
				sleep 1;
				_civ switchmove "A3PL_HandsupKneelKicked";
				sleep 3;
				_cop switchmove "";
				if (local _cop) then {
					detach _cop;
				};
				if (local _civ) then {
					if (!isPlayer _civ) exitwith {
						_civ setdir ((getDir _civ) - 50);
					};
					player setdir ((getDir player) - 50);
				};
			};
		};
		case 7:
		{
			_civ spawn {
				if (local _this) then {
					_this setdir ((getDir _this) - 50);
				};
				if ((animationState _this) isEqualTo "a3pl_handsupkneelcuffed") then {
					_this switchmove "amovpknlmstpsnonwnondnon";
				} else {
					_this switchmove "amovppnemstpsnonwnondnon";
				};
			};
		};

	};
}] call Server_Setup_Compile;

['A3PL_Police_Surrender', {
	private _obj = _this select 0;
	private _upDown = _this select 1;

	//1 No hands up -> Hands up
	//2 Hands up -> Normal
	//3 Hands up -> kneeled hands up
	//4 Kneeled hands up -> hands up
	//5 Kneeled -> Kneeled hands up
	//6 Prone -> Kneeled hands up

	/*if ((animationState _obj) isEqualTo "amovpercmstpsnonwnondnon") exitwith
	{
		[player,1] remoteExec ["A3PL_Police_SurrenderAnim",true];
	};*/
	if (((animationState _obj) IN ["a3pl_idletohandsup","a3pl_kneeltohandsup"]) && (_upDown)) exitwith
	{
		[player,2] remoteExec ["A3PL_Police_SurrenderAnim", -2];
	};
	if (((animationState _obj) IN ["a3pl_idletohandsup","a3pl_kneeltohandsup"]) && (!_upDown)) exitwith
	{
		[player,3] remoteExec ["A3PL_Police_SurrenderAnim", -2];
	};
	if (((animationState _obj) isEqualTo "a3pl_handsuptokneel") && (_upDown)) exitwith
	{
		[player,4] remoteExec ["A3PL_Police_SurrenderAnim", -2];
	};
	if ((animationState _obj) isEqualTo "amovpknlmstpsnonwnondnon") exitwith
	{
		[player,5] remoteExec ["A3PL_Police_SurrenderAnim", -2];
	};
	if ((animationState _obj) isEqualTo "amovppnemstpsnonwnondnon") exitwith
	{
		[player,6] remoteExec ["A3PL_Police_SurrenderAnim", -2];
	};
	[player,1] remoteExec ["A3PL_Police_SurrenderAnim", -2];
}] call Server_Setup_Compile;

['A3PL_Police_SurrenderAnim', {
	private _civ = _this select 0;
	private _number = _this select 1;
	switch (_number) do
	{
		case 1:
		{
			if (local _civ) then {
				if (!isPlayer _civ) exitwith {
					_civ setdir ((getDir _civ) + 50);
				};
				player setdir ((getDir player) + 50);
			};
			_civ switchmove "A3PL_IdleToHandsup";
		};
		case 2:
		{
			if (local _civ) then {
				if (!isPlayer _civ) exitwith {
					_civ setdir ((getDir _civ) - 50);
				};
				player setdir ((getDir player) - 50);
			};
			_civ switchmove "";
		};
		case 3:
		{
			_civ switchmove "A3PL_HandsupToKneel";
		};
		case 4:
		{
			_civ switchmove "A3PL_KneelToHandsup";
		};
		case 5:
		{
			if (local _civ) then {
				if (!isPlayer _civ) exitwith {
					_civ setdir ((getDir _civ) - 50);
				};
				player setdir ((getDir player) - 50);
			};
			_civ switchmove "A3PL_HandsupKneel";
		};
		case 6:
		{
			if (local _civ) then {
				if (!isPlayer _civ) exitwith {
					_civ setdir ((getDir _civ) - 50);
				};
				player setdir ((getDir player) - 50);
			};
			_civ switchmove "A3PL_HandsupKneel";
		};
	};
}] call Server_Setup_Compile;

['A3PL_Police_DeploySpikes', {
	private _obj = _this select 0;
	if ((typeOf _obj) isEqualTo "A3PL_Spikes_Closed") exitwith {
		private _pos = getpos _obj;
		private _dir = getDir _obj;
		deletevehicle _obj;
		private _veh = createVehicle ["A3PL_Spikes_Open", _pos, [], 0, "CAN_COLLIDE"];
		_veh setDir _dir;
		private _pos = _veh modelToWorld [1.27,0,0.5];
		_veh setposATL _pos;
	};
	if ((typeOf _obj) isEqualTo "A3PL_Spikes_Open") exitwith {
		private _pos = getpos _obj;
		private _dir = getDir _obj;
		deletevehicle _obj;
		private _veh = createVehicle ["A3PL_Spikes_Closed", _pos, [], 0, "CAN_COLLIDE"];
		_veh setDir _dir;
		private _pos = _veh modelToWorld [-1.27,0,0.5];
		_veh setposATL _pos;
	};
}] call Server_Setup_Compile;

['A3PL_Police_SpikeHit', {
	private _veh = vehicle player;
	private _wheel = _this;
	[_veh,_wheel] spawn {
		private _veh = _this select 0;
		private _wheel = _this select 1;
		while {(_veh getHit _wheel) < 1} do
		{
			waitUntil {(speed (vehicle player)) > 1};
			_speed = (speed (vehicle player));
			If (_speed < 30) then {_speed = _speed/5;};
			_multiplier = _speed/5000;
			_veh setHit [_wheel,((_veh getHit _wheel) + _multiplier)];
			sleep 0.2;
		};
	};
}] call Server_Setup_Compile;

['A3PL_Police_Drag',
{
	private _civ = _this select 0;
	private _dragged = _civ getVariable ["dragged",false];
	if (_dragged) exitwith {
		_civ setVariable ["dragged",nil,true];
	};
	if (_civ getVariable["Cuffed",false]) then {
		[player] remoteExec ["A3PL_Police_DragReceive", _civ];
	} else {
		[localize"STR_NewPolice_8", "red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

['A3PL_Police_DragReceive',
{
	private _cop = param [0,objNull];
	[localize"STR_NewPolice_9", "red"] call A3PL_Player_Notification;
	player setVariable ["dragged",true,true];
	["gesture_restrain"] call A3PL_Lib_Gesture;
	[player,""] remoteExec ["A3PL_Lib_SyncAnim", -2];
	player forceWalk true;
	[_cop] spawn
	{
		private _cop = param [0,objNull];
		if (isNull _cop) exitwith {};
		while {player getVariable ["dragged",false] && ((vehicle _cop) isKindOf "Civilian_F")} do
		{
				if (isNull _cop) exitwith {};
				if ((player distance _cop) > 5 && ((vehicle _cop) isKindOf "Civilian_F")) then {
					player setposATL (getposATL _cop);
				};
				if(!(player getVariable["Cuffed",true])) then {player setVariable ["dragged",nil,true];};
				["gesture_restrain"] call A3PL_Lib_Gesture;
		};
		player forceWalk false;
		player setVariable ["dragged",nil,true];
		[localize"STR_NewPolice_10", "red"] call A3PL_Player_Notification;
		if((vehicle player) isEqualTo player) then {
			["gesture_stop"] call A3PL_Lib_Gesture;
			[player,"a3pl_handsupkneelcuffed"] remoteExec ["A3PL_Lib_SyncAnim", -2];
		};
	};
}] call Server_Setup_Compile;

["A3PL_Police_Detain",
{
	private ["_car","_near"];
	_car = param [0,objNull];
	_near = nearestObjects [player,["C_man_1"],5];
	_near = _near - [player];
	if (count _near < 1) exitwith {[localize"STR_NewPolice_11", "red"] call A3PL_Player_Notification;};
	_near = _near select 0;
	if((_near getVariable["Cuffed",false]) || _near getVariable["Zipped",false]) exitwith {
		_near setVariable["dragged",nil,true];
		[_near,""] remoteExec ["A3PL_Lib_SyncAnim", -2];
		[_car] remoteExec ["A3PL_Lib_MoveInPass",_near];
	};
	[localize"STR_NewPolice_12", "red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_Impound",
{
	private _veh = player_objIntersect;
	if (isnull _veh) then {_veh = cursorObject};
	if (isNull _veh) exitwith {[localize"STR_NewPolice_13", "red"] call A3PL_Player_Notification;};
	if(_veh distance player > 7) exitWith {[localize"STR_NewPolice_14", "red"] call A3PL_Player_Notification;};
	if ((_veh isKindOf "Car") && (!((typeOf _veh) IN A3PL_Jobroadworker_MarkBypass))) exitwith {[_veh] call A3PL_JobRoadWorker_ToggleMark;};
	[_veh] remoteExec ["Server_Police_Impound", 2];
	[localize"STR_NewPolice_15", "red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_ImpoundMsg",
{
	[localize"STR_NewPolice_16", "red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_unDetain",
{
	private _car = _this select 0;
	private _pass = crew _car;
	if((speed _car) >= 4) exitWith {};
	{
		_x action ["getOut", _car];
		[_x,_car]spawn {_pass = _this select 0;_car = _this select 1;if (_pass getVariable ["Cuffed",true]) then {sleep 1.5;_pass setVelocityModelSpace [0,3,1];[_pass,"a3pl_handsupkneelcuffed"] remoteExec ["A3PL_Lib_SyncAnim", -2];};};
	} foreach _pass;
	[localize"STR_NewPolice_17", "red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

['A3PL_Police_DatabaseArgu',{
	params[["_edit","",[""]],["_index",0,[0]]];

	private _allowedChars = toArray "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,";
	private _checkEdit = toArray _edit;
	private _forbiddenUsed = false;

	{
		if (!(_x in _allowedChars)) exitWith {
			_forbiddenUsed = true;
		};
	} forEach _checkEdit;

	if (_forbiddenUsed) exitWith {
		"SpecialCharacterError";
	};

	_array = _edit splitString " ";
	_return = _array select _index;
	_return
}] call Server_Setup_Compile;

['A3PL_Police_DatabaseEnterReceive',
{
	disableSerialization;
	private ["_newstruct","_display","_control"];
	params["_name","_command",["_return",""]];
	_output = "";
	switch (_command) do {
		case "lookup":
		{
			if (count _return > 0) then
			{
				_warrantCount = "No";
				if ((_return select 2) > 0) then
				{
					_warrantCount = "<t color='#ff0000'>Yes</t>";
				};

				_cautionStr = "None";
				if ((count(_return select 10)) >= 3) then {
					_cautionStr = format["<t color='#ff0000'>%1</t>", _return select 10];
				};

				_output = format ["<t align='center'>Name: %1</t><br /><t align='center'>Sex: %2</t><br /><t align='center'>DOB: %3</t><br /><t align='center'>Passport Date: %9</t><br /><t align='center'>Active warrant: %4</t><br /><t align='center'>Cautions: %13</t><br /><t align='center'>Warning History: %5</t><br /><t align='center'>Ticket History: %6</t><br /><t align='center'>Arrest History: %7</t><br /><t align='center'>Report History: %8</t><br /><t align='center'>Bank Account: $%11</t><br /><t align='center'>Licenses: %10</t><br/><t align='center'>Company: %12</t>",
				_name,
				(_return select 0),
				(_return select 1),
				_warrantCount,
				(_return select 5),
				(_return select 4),
				(_return select 3),
				(_return select 6),
				(_return select 7),
				(_return select 8),
				[(_return select 9), 1, 0, true] call CBA_fnc_formatNumber,
				(_return select 11),
				_cautionStr
				];
			} else
			{
				_output = format ["Can not find %1 in the criminals database.",_name];
			};
		};

		case "lookupvehicles":
		{
			if (count _return > 0) then
			{
				{
					_vehName = getText(configFile >>  "CfgVehicles" >>  _x select 1 >> "displayName");
					_stolen = "No";
					if ((_x select 2) == 1) then
					{
						_stolen = "<t color='#ff0000'>Yes</t>";
					};

					_output = _output + (format ["<t align='center'>%1. License: %2 - Model: %3 - Stolen: %4</t><br />",_forEachIndex+1,_x select 0,_vehName,_stolen]);
				} foreach _return;
				_output = (_output + "<t align='center'>End of the list of vehicles</t>");
			} else
			{
				_output = format ["<t align='center'>No vehicles found!</t>"];
			};
		};

		case "lookuplicense":
		{
			if(count _return > 1) then {
				_name = _return select 0;
				_class = _return select 2;
				_insured = _return select 3;
				_plate = _return select 5;

				_vehName = getText(configFile >>  "CfgVehicles" >>  _class >> "displayName");

				_stolen = "No";
				if ((_return select 1) > 0) then
				{
					_stolen = "<t color='#ff0000'>Yes</t>";
				};

				if(_insured isEqualTo 0) then {
					_insured = "Yes";
				} else {
					_insured = "No";
				};

				_output = format["
				<t align='center'>License: %1</t><br />
				<t align='center'>Type: %3</t><br />
				<t align='center'>Owner: %2</t><br />
				<t align='center'>Reported stolen: %4</t><br />
				<t align='center'>Insurance: %5</t>",_plate,_name,_vehName,_stolen,_insured];

				if(count(_return) isEqualTo 7) then {
					_output = _output + format["<br /><t align='center'>Company: %1</t>",_return select 6];
				};
			} else {
				_output = format ["No information available for registration %1",_plate];
			};
		};

		case "lookupcompany":
		{
			if(count _return > 1) then {
				_name = _return select 0;
				_desc = _return select 1;
				_boss = _return select 2;
				_bank = _return select 3;
				_licenses = _return select 4;

				_output = format["
				<t align='center'>Company: %1</t><br />
				<t align='center'>Description: %2</t><br />
				<t align='center'>Owner: %3</t><br />
				<t align='center'>Bank Account: %4</t><br />
				<t align='center'>Licenses: %5</t>",_name,_desc,_boss,[_bank, 1, 0, true] call CBA_fnc_formatNumber,_licenses];
			} else {
				_output = format ["No information available for company : %1",_name];
			};
		};

		case "lookupaddress":
		{
			_house = _return select 0;
			_name = _return select 1;
			if(!isNil "_house") then {
				[_house, _name] spawn A3PL_Police_MarkHouse;
				_output = format["%2 resides at %1",[parseSimpleArray(_house)] call A3PL_Housing_PosAddress, _name];
			} else {
				_output = "No address found for this citizen!";
			};
		};
		case "lookupwarehouse":
		{
			_warehouse = _return select 0;
			_name = _return select 1;
			if(!isNil "_warehouse") then {
				[_warehouse, _name,true] spawn A3PL_Police_MarkHouse;
				_output = format["%2 resides at %1",[parseSimpleArray(_warehouse)] call A3PL_Housing_PosAddress, _name];
			} else {
				_output = "No registered warehouses found for this citizen!";
			};
		};

		case "markstolen":
		{
			_output = _return;
		};

		case "markfound":
		{
			_output = _return;
		};

		case "warrantlist":
		{

			if (count _return > 0) then
			{
				{
					_output = _output + (format ["<t align='center'>%1. %2 - Issued: %3 - Issued by: %4</t><br />",_forEachIndex+1,_x select 0,_x select 1,_x select 2]);
				} foreach _return;
				_output = (_output + "Use warrantinfo for detailed warrant information<br />");
			} else
			{
				_output = format ["Can not find active mandates for %1",_name];
			};
		};

		case "warrantinfo":
		{
			if (count _return > 0) then
			{
				_output = format ["<t align='center'>Warrant: %1</t><br /><t align='center'>Date: %2</t><br /><t align='center'>Issued by: %3</t><br /><t align='center'>Info:</t><br /><t align='center'>%4</t><br />",_name,_return select 0,_return select 1,_return select 2];
			} else
			{
				_output = format ["No warrant exists",_name];
			};
		};

		case "removewarrant":
		{
			_output = _return;
		};

		case "ticketlist":
		{
			if (count _return > 0) then
			{
				{
					_output = _output + (format ["<t align='center'>%1 - $%4 - %2 - Issued by: %3</t><br />",_x select 0,_x select 1,_x select 2,_x select 3]);
				} foreach _return;
				_output = _output;
			} else
			{
				_output = format ["No history of fines is available for %1",_name];
			};
		};

		case "arrestlist":
		{
			if (count _return > 0) then
			{
				{
					_output = _output + (format ["<t align='center'>%1 - %4 Month(s) - %2 - Issued by: %3</t><br />",_x select 0,_x select 1,_x select 2,_x select 3]);
				} foreach _return;
				_output = _output;
			} else
			{
				_output = format ["No arrest available for %1",_name];
			};
		};

		case "warninglist":
		{
			if (count _return > 0) then
			{
				{
					_output = _output + (format ["<t align='center'>%1 - %2 - Issued by: %3</t><br />",_x select 0,_x select 1,_x select 2]);
				} foreach _return;
				_output = _output;
			} else
			{
				_output = format ["No warning history is available for %1",_name];
			};
		};

		case "insertwarrant":
		{
			_output = _return;
		};

		case "insertticket":
		{
			_output = _return;
		};

		case "insertwarning":
		{
			_output = _return;
		};

		case "insertreport":
		{
			_output = _return;
		};

		case "insertarrest":
		{
			_output = _return;
		};

		case "lookupvehicles":
		{

			if (count _return > 0) then
			{
				{

					_output = _output + (format ["<t align='center'>%1. License: %2 - Model: %3 - Stolen: %4</t><br />",_forEachIndex+1,_x select 0,_vehName,_stolen]);
				} foreach _return;
				_output = (_output + "<t align='center'>End of the list of vehicles</t>");
			} else
			{
				_output = format ["<t align='center'>No vehicles found!</t>"];
			};
		};

		case "darknet":
		{
			if (count _return > 0) then
			{
				{
					_output = _output + (format ["<t align='center'>User: %1 - Message: %2</t><br />",_x select 0,_x select 1]);
				} foreach _return;
			} else
			{
				_output = "No Dark Net messages found!";
			};
		};

		case "setcaution":
		{
			_output = _return;
		};

		case "clearcautions":
		{
			_output = _return;
		};

		case "bololist":
		{
			if (count _return > 0) then
			{
				{
					_output = _output + (format ["<t align='center'>%1 - %2 - %3 - Inserted by: %4</t><br />", _x select 0, _x select 2, _x select 1, _x select 3]);
				} foreach _return;
				_output = _output;
			} else
			{
				_output = format ["No BOLO notices found."];
			};
		};

		case "insertbolo":
		{
			_output = _return;
		};

		case "removebolo":
		{
			_output = _return;
		};

		case "stolenvehicles":
		{
			if (count _return > 0) then
			{
				{
					_vehName = getText(configFile >>  "CfgVehicles" >>  _x select 2 >> "displayName");
					_output = _output + (format ["<t align='center'>%1. License: %2 - Model: %3 - Owner: %4</t><br />", _forEachIndex+1, _x select 1, _vehName, _x select 3]);
				} foreach _return;
				_output = (_output + "<t align='center'>End of the list of vehicles</t>");
			} else
			{
				_output = format ["<t align='center'>No vehicles are currently marked as stolen!</t>"];
			};
		};

		default {_output = "Unknown error - Contact the developer"};
	};

	_newstruct = format["%1<br />%2",(player getVariable "PoliceDatabaseStruc"),_output];
	player setVariable ["PoliceDatabaseStruc",_newstruct,false];
	[_newstruct] call A3PL_Police_UpdateComputer;
}] call Server_Setup_Compile;

['A3PL_Police_UpdateComputer',
{
	params[["_input","",[""]],["_new",false,[false]]];

	_display = findDisplay 211;
	_control = _display displayCtrl 1100;
	_array = [_input, "<br />"] call CBA_fnc_split;

	if(count _array > 21) then {
		_remove = (count _array) - 21;

		for "_i" from 0 to _remove-1 do {
			_array deleteAt 0;
		};
	};

	_text = [_array, "<br />"] call CBA_fnc_join;

	player setVariable ["PoliceDatabaseStruc",_text,false];

	_control ctrlSetStructuredText parseText _text;
}] call Server_Setup_Compile;

['A3PL_Police_IsStringNumber',
{
	params[["_str","0"]];

	{
		if (!(_x isEqualTo "0") && (parseNumber _x isEqualTo 0)) exitWith {true};
	} count (_str splitString "") isEqualTo 0;

}] call Server_Setup_Compile;

['A3PL_Police_DatabaseEnter',
{
	private ["_display","_control","_edit","_edit0","_newstruct"];
	disableSerialization;
	_display = findDisplay 211;

	_control = _display displayCtrl 1401;
	_edit = ctrlText _control;

	_newstruct = format["%1<br />%2",(player Getvariable "PoliceDatabaseStruc"),"> "+_edit];
	player setVariable ["PoliceDatabaseStruc",_newstruct,false];

	[_newstruct] call A3PL_Police_UpdateComputer;

	_control = _display displayCtrl 1401;
	_control ctrlSetText "";

	_edit0 = [_edit,0] call A3PL_Police_DatabaseArgu;
	if ((!(player getVariable "PoliceDatabaseLogin")) && (!(_edit0 isEqualTo "login"))) exitwith
	{
		_newstruct = format["%1<br />%2",(player Getvariable "PoliceDatabaseStruc"),"Error: You do not have permission to use this command"];
		player setVariable ["PoliceDatabaseStruc",_newstruct,false];

		[_newstruct] call A3PL_Police_UpdateComputer;
	};

	_output = "";
	
	switch (_edit0) do {
		case "help":
		{
			_output = "
			<t align='center'>help - View all commands</t><br />
			<t align='center'>clear - Clear screen</t><br />
			<t align='center'>login [password] - Login to use the commands</t><br />
			<t align='center'>lookup [firstname] [lastname] - View information about a person</t><br />
			<t align='center'>lookupvehicles [firstname] [lastname] - List all registered vehicles to a person</t><br />
			<t align='center'>lookuplicense [license plate] - View license plate information</t><br />
			<t align='center'>lookupcompany [company name] - View company information</t><br />
			<t align='center'>markstolen [license plate] - Mark a vehicle as stolen</t><br />
			<t align='center'>markfound [license plate] - Mark a vehicle as found</t><br />
			<t align='center'>warrantlist [firstname] [lastname] - List of mandates for a person</t><br />
			<t align='center'>warrantinfo [firstname] [lastname] [number] - Mandates Information</t><br />
			<t align='center'>removewarrant [firstname] [lastname] [number] - Remove the warrant</t><br />
			<t align='center'>ticketlist [firstname] [lastname] - View the history of tickets</t><br />
			<t align='center'>warninglist [firstname] [lastname] - View warning history</t><br />
			<t align='center'>arrestlist [firstname] [lastname] - View the arrest history</t><br />
			<t align='center'>insertwarrant [firstname] [lastname] [title] [description] - Insert a warrant</t><br />
			<t align='center'>insertticket [firstname] [lastname] [amount] [description] - Insert a ticket</t><br />
			<t align='center'>insertwarning [firstname] [lastname] [title] [description] - Insert a warning</t><br />
			<t align='center'>insertarrest [firstname] [lastname] [time] [description] - Insert an arrest</t><br />
			<t align='center'>lookupaddress [firstname] [lastname] - View house address</t><br />
			<t align='center'>lookupwarehouse [firstname] [lastname] - View warehouse address</t><br />
			<t align='center'>setcaution [firstname] [lastname] - Set a caution on a citizen</t><br />
			<t align='center'>clearcautions [firstname] [lastname] - Clear the cautions for a citizen</t><br />
			<t align='center'>insertbolo [BOLO description] - Insert a new BOLO notice</t><br />
			<t align='center'>removebolo [BOLO ID] - Remove a BOLO notice</t><br />
			<t align='center'>bololist - View a list of active BOLO notices</t><br />
			<t align='center'>stolenvehicles - View a list of stolen vehicles</t><br />
			<t align='center'>darknet - View the last 10 messages on the encrypted Dark Net</t><br />
			";
		};

		case "clear": {_output = "<t align='center'>Computer Database - F.I.S.D.</t><br /><t align='center'>Enter 'help' for the list of available commands</t>";};
		
		case "login":
		{
			private ["_pass"];
			_pass = [_edit,1] call A3PL_Police_DatabaseArgu;
			if (_pass == "fisdftw") then
			{
				player setVariable ["PoliceDatabaseLogin",true,false];
				_output = "You are connected";
			} else
			{
				_output = "Error: Incorrect password";
			};
		};

		case "lookup":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			[player,_name,_edit0] remoteExec ["Server_Police_Database", 2];

			_output = format ["Searching for a citizen in the database ...",_name];
		};

		case "lookupvehicles":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			[player,_name,_edit0] remoteExec ["Server_Police_Database", 2];

			_output = format ["Searching for a citizen's vehicles in the database ...",_name];
		};

		case "lookuplicense":
		{
			private ["_license"];
			_license = [_edit,1] call A3PL_Police_DatabaseArgu;

			[player,_license,_edit0] remoteExec ["Server_Police_Database", 2];
			_ouput = format["Search for the license plate %1...",_edit];
		};

		case "lookupcompany":
		{
			[player,_edit,_edit0] remoteExec ["Server_Police_Database", 2];
			_ouput = format["Seaching %1 into the companies database...",_edit];
		};

		case "lookupaddress":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			[player,_name,_edit0] remoteExec ["Server_Police_Database",2];

			_output = format ["Searching for Addresses in F.I.S.D Database...",_name];
		};

		case "lookupwarehouse":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			[player,_name,_edit0] remoteExec ["Server_Police_Database",2];

			_output = format ["Searching for Addresses in F.I.S.D Database...",_name];
		};

		case "markstolen":
		{
			private ["_license"];
			_license = [_edit,1] call A3PL_Police_DatabaseArgu;

			[player,_license,_edit0] remoteExec ["Server_Police_Database", 2];
			_ouput = format["Marking the vehicle as stolen: %1...",_edit];
		};

		case "markfound":
		{
			private ["_license"];
			_license = [_edit,1] call A3PL_Police_DatabaseArgu;

			[player,_license,_edit0] remoteExec ["Server_Police_Database", 2];
			_ouput = format["Marking the vehicle as found: %1...",_edit];
		};

		case "warrantlist":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			[player,_name,_edit0] remoteExec ["Server_Police_Database", 2];

			_output = format ["Search the database for active mandates ..",_name];
		};

		case "warrantinfo":
		{
			private ["_name","_offset"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_offset = (parseNumber ([_edit,3] call A3PL_Police_DatabaseArgu)) - 1;

			if (_offset < 0) exitwith {
				_output = format ["Incorrect Syntax, refer to F.I.S.D operation manual",_name];
			};

			[player,_name,_edit0,_offset] remoteExec ["Server_Police_Database", 2];
			_output = format ["Search the database for this mandate number ...",_name];
		};

		case "removewarrant":
		{
			private ["_name","_offset"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_offset = (parseNumber ([_edit,3] call A3PL_Police_DatabaseArgu)) - 1;

			if (_offset < 0) exitwith
			{
				_output = format ["Incorrect Syntax, refer to F.I.S.D operation manual",_name];
			};

			[player,_name,_edit0,_offset] remoteExec ["Server_Police_Database", 2];
			_output = format ["Search the database for this mandate number ...",_name];
		};

		case "ticketlist":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			[player,_name,_edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Search the database for the history of fines ...",_name];
		};

		case "arrestlist":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			[player,_name,_edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Search in the database for the history of arrests ...",_name];
		};

		case "warninglist":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			[player,_name,_edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Search the database for warning history ...",_name];
		};

		case "insertwarrant":
		{
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_title = ([_edit,3] call A3PL_Police_DatabaseArgu);

			_array = _edit splitString " ";
			for "_i" from 1 to 4 do {
				_array deleteAt 0;
			};

			_info = [_array," "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name",name player];

			[player,[_name,_title,_info,_issuedBy],_edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Inserting a mandate into the database ..."];
		};

		case "insertticket":
		{

			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_amount = [_edit,3] call A3PL_Police_DatabaseArgu;
			_amountNum = parseNumber _amount;
			
			if (!([_amount] call A3PL_Police_IsStringNumber)) exitWith {_output = format ["Error: You must follow the correct syntax..."];};

			_array = _edit splitString " ";
			for "_i" from 1 to 4 do {
				_array deleteAt 0;
			};

			_info = [_array," "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name",name player];

			diag_log str(_info);

			[player,[_name,_amountNum,_info,_issuedBy],_edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Inserting a fine into the database ..."];
		};

		case "insertwarning":
		{

			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_title = ([_edit,3] call A3PL_Police_DatabaseArgu);

			_array = _edit splitString " ";
			for "_i" from 1 to 4 do {
				_array deleteAt 0;
			};

			_info = [_array," "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name",name player];

			[player,[_name,_title,_info,_issuedBy],_edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Inserting a warning into the database ..."];
		};

		case "insertreport":
		{

			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_title = ([_edit,3] call A3PL_Police_DatabaseArgu);

			_array = _edit splitString " ";
			for "_i" from 1 to 4 do {
				_array deleteAt 0;
			};

			_info = [_array," "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name",name player];

			[player,[_name,_title,_info,_issuedBy],_edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Adding a report to the database ..."];
		};

		case "insertarrest":
		{

			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_time = ([_edit,3] call A3PL_Police_DatabaseArgu);

			if (!([_time] call A3PL_Police_IsStringNumber)) exitWith {
				_output = format ["Error: You must follow the correct syntax..."];
			};

			_array = _edit splitString " ";
			for "_i" from 1 to 4 do {
				_array deleteAt 0;
			};

			_info = [_array," "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name",name player];

			[player,[_name,_time,_info,_issuedBy],_edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Inserting an arrest in the database ..."];
		};

		case "revokelicense":
		{
			private ["_license, _name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_license = [_edit,3] call A3PL_Police_DatabaseArgu;

			[player,[_name,_license,_info],_edit0] remoteExec ["Server_Police_Database", 2];

			[player,_name,_license,_edit0] remoteExec ["Server_Police_Database", 2];
			_ouput = format["License revoked ..."];
		};

		case "darknet":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			[player,_name,_edit0] remoteExec ["Server_Police_Database", 2];

			_output = format ["Searching the darknet for hidden messages ...",_name];
		};

		case "setcaution":
		{
			private _name = ([_edit, 1] call A3PL_Police_DatabaseArgu) + " " + ([_edit, 2] call A3PL_Police_DatabaseArgu);

			_array = _edit splitString " ";
			for "_i" from 1 to 3 do {
				_array deleteAt 0;
			};

			_cautionDesc = [_array, " "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name", name player];

			if (count(_cautionDesc) <= 3) exitWith {_output = "You must enter a valid caution description.";};

			[player, [_issuedBy, _name, _cautionDesc], _edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Attempting to update cautions for %1 ...", _name];
			
		};

		case "clearcautions":
		{
			private _name = ([_edit, 1] call A3PL_Police_DatabaseArgu) + " " + ([_edit, 2] call A3PL_Police_DatabaseArgu);

			[player, [_name], _edit0] remoteExec ["Server_Police_Database", 2];

			_output = format ["Attempting to clear cautions for %1 ...", _name];
		};

		case "bololist":
		{
			[player, [_name], _edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Loading BOLO List ..."];
		};

		case "insertbolo":
		{
			_array = _edit splitString " ";
			_array deleteAt 0;
			_boloDesc = [_array, " "] call CBA_fnc_join;
			
			if (count(_boloDesc) <= 8) exitWith {_output = "Please enter a descriptive BOLO notice.";};

			_issuedBy = player getVariable ["name", name player];

			[player, [_issuedBy, _boloDesc], _edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Attempting to insert BOLO notice ..."];
		};

		case "removebolo":
		{
			private _boloID = [_edit, 1] call A3PL_Police_DatabaseArgu;
			private _boloIDNum = parseNumber _boloID;

			if (!([_boloID] call A3PL_Police_IsStringNumber)) exitWith {
				_output = format ["Error: Please insert a valid BOLO ID..."];
			};

			[player, [_boloIDNum], _edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Attempting to remove BOLO notice '%1' ...", _boloID];
		};

		case "stolenvehicles":
		{
			[player, [""], _edit0] remoteExec ["Server_Police_Database", 2];
			_output = format ["Retrieving list of stolen vehicles ..."];
		};

		case "SpecialCharacterError":
		{
			_output = "You cannot enter special characters into the MDT!";
		};

		default {_output = "Error: Unknown Command"};
	};

	_control = _display displayCtrl 1100;
	if (_edit0 == "clear") then {
		_newstruct = _output;
	} else {
		_newstruct = format["%1<br />%2",(player getVariable "PoliceDatabaseStruc"),_output];
	};
	player setVariable ["PoliceDatabaseStruc",_newstruct,false];

	[_newstruct] call A3PL_Police_UpdateComputer;
}] call Server_Setup_Compile;

["A3PL_Police_DatabaseOpen",
{
	private ["_display","_text"];

	_text = "<t align='center'>FISD Database</t><br /><t align='center'>Enter 'help' to see all the available commands</t><br />> please login";
	player setVariable ["PoliceDatabaseStruc",_text,false];
	player setVariable ["PoliceDatabaseLogin",false,false];
	disableSerialization;
	createDialog "Dialog_PoliceDatabase";
	_display = findDisplay 211;
	_display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 28) then {call A3PL_Police_DatabaseEnter;}"];

	[_text] call A3PL_Police_UpdateComputer;
}] call Server_Setup_Compile;

["A3PL_Police_OpenTicketMenu",
{
	disableSerialization;
	Player_TicketAmount = Nil;
	createDialog "Dialog_CreateTicket";
}] call Server_Setup_Compile;

["A3PL_Police_CreateTicket",
{
	private ["_display","_control","_ticketAmount"];
	disableSerialization;
	_display = findDisplay 38;
	_control = _display displayCtrl 1400;
	_ticketAmount = parseNumber (ctrlText _control);
	closeDialog 0;
	if (_ticketAmount < 1) exitwith
	{
		["Please enter a valid amount", "red"] call A3PL_Player_Notification;
	};

	Player_Item = "A3PL_Ticket" createVehicle (getPos player);
	Player_Item attachTo [player, [0,0,0], "RightHand"];
	Player_ItemClass = "ticket";
	Player_TicketAmount = _ticketAmount;
	["You have just written a ticket, please give it to the player", "green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_GiveTicket",
{
	_player = param [0,objNull];
	if (!isPlayer _player) exitwith {["You do not look at any player", "red"] call A3PL_Player_Notification;};
	if (isNil "Player_TicketAmount") exitwith {["Impossible to give this ticket, the amount is not registered", "red"] call A3PL_Player_Notification;};
	[Player_Item] call A3PL_Inventory_Clear;
	[format ["You have given a ticket to %1",(_player getVariable ["name",name _player])], "green"] call A3PL_Player_Notification;
	[Player_TicketAmount,player] remoteExec ["A3PL_Police_ReceiveTicket",_player];
	player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
	Player_TicketAmount = Nil;
}] call Server_Setup_Compile;

["A3PL_Police_GiveTicketResponse",
{
	_r = param [0,1];
	_amount = param [1,0];

	_text = ["Error while answering the ticket","red"];
	switch (_r) do
	{
		case 1: {_text = ["The citizen refused to pay this ticket","red"];};
		case 2: {_text = ["The citizen agreed to pay this ticket","green"];[player,5] call A3PL_Level_AddXP;};
		case 3: {_text = ["The citizen does not have enough money to pay this ticket","red"];};
	};

	_text call A3PL_Player_Notification;

	if((_r isEqualTo 2) && (_amount != 0)) then {[_amount] spawn A3PL_Police_SendTicketMoney;};
}] call Server_Setup_Compile;

["A3PL_Police_SendTicketMoney",
{
	_amount = param [0,0];
}] call Server_Setup_Compile;

["A3PL_Police_ReceiveTicket",
{
	disableSerialization;
	private ["_ticketAmount"];
	Player_TicketCop = Nil;
	Player_TicketAmount = Nil;
	closeDialog 0;

	Player_TicketAmount = param [0,1];
	Player_TicketCop = param [1,objNull];
	createDialog "Dialog_ReceiveTicket";
	(findDisplay 37) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
	ctrlSetText [1000,format ["Ticket Amount $%1",Player_TicketAmount]];
}] call Server_Setup_Compile;

["A3PL_Police_RefuseTicket",
{
	closeDialog 0;
	[[1]] remoteExec ["A3PL_Police_GiveTicketResponse",Player_TicketCop];
	Player_TicketCop = Nil;
	Player_TicketAmount = Nil;
	["You refused to pay the ticket",Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_PayTicket",
{
	closeDialog 0;

	if (isNil "Player_TicketAmount") exitwith
	{
		[localize"STR_NewPolice_19","red"] call A3PL_Player_Notification;
	};

	_cash = player getVariable ["player_cash",0];
	_bank = player getVariable ["player_bank",0];
	if ((Player_TicketAmount > _cash) && (Player_TicketAmount > _bank)) exitwith
	{
		[3] remoteExec ["A3PL_Police_GiveTicketResponse",Player_TicketCop];
		[localize"STR_NewPolice_20","red"] call A3PL_Player_Notification;
	};

	[Player_TicketAmount,player,Player_TicketCop] remoteExec ["Server_Police_PayTicket", 2];
	[2, Player_TicketAmount] remoteExec ["A3PL_Police_GiveTicketResponse",Player_TicketCop];

	[format[localize"STR_NewPolice_21",Player_TicketAmount],"green"] call A3PL_Player_Notification;

	Player_TicketAmount = Nil;
	Player_TicketCop = Nil;
}] call Server_Setup_Compile;

["A3PL_Police_SeizeVirtualItems",
{
	_target = param [0,player_objintersect];
	_class = _target getVariable["class",""];
	_amount = _target getVariable["amount",1];

	[2, [_class, _amount]] call A3PL_Police_SeizeItems;
	deleteVehicle _target;


	_name = [_class, 'name'] call A3PL_Config_GetItem;
	[format["You have seized %1 %2",_amount,_name],"red"] call A3PL_Player_Notification;
	[player, 5] call A3PL_Level_AddXP;

}] call Server_Setup_Compile;

["A3PL_Police_SeizePhysicalItems",
{
	_target = param [0,player_objintersect];
	_class = _target getVariable["class",""];
	_amount = _target getVariable["amount",1];

	if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
	["Seizing item...",15] spawn A3PL_Lib_LoadAction;
	_success = true;
	waitUntil{Player_ActionDoing};
	[player,"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown"] remoteExec ["A3PL_Lib_SyncAnim",0];
	while {Player_ActionDoing} do {
		if ((player distance2D _target) > 5) exitWith {_success = false;};
		if ((animationState player) isEqualTo "amovpercmstpsnonwnondnon") then {[player,"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown"] remoteExec ["A3PL_Lib_SyncAnim",0];};
	};
	player switchMove "";
	if(Player_ActionInterrupted || !_success) exitWith {
		["Item seizure cancelled!","red"] call A3PL_Player_Notification;
		if ((vehicle player) isEqualTo player) then {player switchMove "";};
	};

	deleteVehicle _target;
	_name = [_class, 'name'] call A3PL_Config_GetItem;
	[player, 5] call A3PL_Level_AddXP;
	[format["You have seized %1 %2",_amount,_name],"red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_StartJailPlayer",
{
	params[["_target",objNull,[objNull]]];

	_pd = nearestObjects [player, ["Land_A3PL_Prison", "Land_A3PL_Sheriffpd", "Land_A3FL_SheriffPD"], 50];

	if(count _pd < 1) exitWith {[format[localize"STR_NewPolice_23"],"red"] call A3PL_Player_Notification;};

	createDialog "Dialog_JailPlayer";
	A3PL_JailPlayer_Target = _target;
}] call Server_Setup_Compile;

["A3PL_Police_JailPlayer",
{
	private	_time = parseNumber (ctrlText 1400);
	if((pVar_AdminLevel isEqualTo 0) && (_time > 90)) exitWith {[format["You cannot jail this person for more than 90 minutes"],"red"] call A3PL_Player_Notification;};

	closeDialog 0;
	if((isNull cursorTarget) || (!isPlayer cursorTarget)) exitWith {[format[localize"STR_NewPolice_24"],"red"] call A3PL_Player_Notification;};
	if(typeName _time != "SCALAR") exitWith {[format[localize"STR_NewPolice_25"],"red"] call A3PL_Player_Notification;};
	if(_time <= 0) exitWith {[format[localize"STR_NewPolice_26"],"red"] call A3PL_Player_Notification;};

	[_time, A3PL_JailPlayer_Target] remoteExec ["Server_Police_JailPlayer",2];
	[player,5] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_Police_ReleasePlayer",
{
	player setVariable ["jailed",false,true];
	player setVariable ["jail_mark",false,true];
	private _atSD = nearestObjects [player, ["Land_A3PL_Sheriffpd","Land_A3FL_SheriffPD"], 50];
	private _atDOC = count(nearestObjects [player, ["Land_A3PL_Prison"], 50]) > 0;
	private _FIMS = ["fims"] call A3PL_Lib_FactionPlayers;

	if(_atDOC) then {
		if(count(_FIMS) > 0) then {
			["You have served your jail sentence, the Marshal Services will escort you out of jail soon.","green"] call A3PL_Player_Notification;
			[format["DOC: %1 has served his time and needs to be released.",player getVariable["name","unknown"]],"blue","fims",3] call A3PL_Lib_JobMessage;
		} else {
			player setPosATL [4744.56,6023.57,0];
			player setDir 178.9;
			removeUniform player;
			[format[localize"STR_NewPolice_28"],"green"] call A3PL_Player_Notification;
		};
	};
	if(count(_atSD) > 0) then {
		private _SD = _atSD select 0;
		player setPosATL (_SD modelToWorld [-4.5,8,0]);
		player setDir (getDir _SD);
		removeUniform player;
		[format[localize"STR_NewPolice_28"],"green"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Police_RadarLoop",
{
	private ["_Beam","_Beam2","_radardir","_veh"];
	_veh = param [0,objNull];
	[_veh] spawn A3PL_Police_RadarLoopSync; //seperate loop to handle sync
	_Beam = "Land_HelipadEmpty_F" createVehicleLocal getpos _veh;
	_Beam attachTo [ _veh, [ 0.0, 50.0, 0.75 ] ];
	_Beam2 = "Land_HelipadEmpty_F" createVehicleLocal getpos _veh;
	_Beam2 attachTo [ _veh, [ 0.0, 150.0, 0.75 ] ];
	_radardir = "Front";
	while {player IN _veh} do
	{
		if (_veh animationPhase "Radar_Master" > 0.5) then
		{
			//set target speed
			private ["_inter","_target","_speed","_forward","_dist"];
			_forward = _veh getVariable ["forward",true]; //defaults to true
			//if (_forward) then {_dist = 200} else {_dist = -200}; //-200 backwards, 200 forwards
			//_inter = lineIntersectsObjs [AGLtoASL(_veh modelToWorldVisual [0,0,-0.5]), AGLtoASL(_veh modelToWorldVisual [0,_dist,-0.5]), objNull, _veh, true, 16]; //16 means first contact
			if (_veh animationPhase "Radar_Front" >= 0.5) then
			{
				_Beam attachTo [ _veh, [ 0.0, 50.0, 0.75 ] ];
				_Beam2 attachTo [ _veh, [ 0.0, 150.0, 0.75 ] ];
				_radardir = "Front";
			}else
			{
				_Beam attachTo [ _veh, [ 0.0, -60.0, 0.75 ] ];
				_Beam2 attachTo [ _veh, [ 0.0, -150.0, 0.75 ] ];
				_radardir = "Rear";
			};
			_tag2 = nearestObject [_Beam2, "LandVehicle"];
			_tag = nearestObject [_Beam, "LandVehicle"];
			if(isNull _tag) then {_tag = _tag2};
			if(isNull _tag2) then {_tag2 = _tag};
			if (!(isNull _tag)) then
			{
				private ["_target","_speed"];
				_target = _tag;
				//if (!(_target isKindOf "Car")) exitwith {};
				_speed = (speed _target) * 0.621371; //get mph
				[_veh,"target",_speed] call A3PL_Police_RadarSet; //set target speed
				if ((_speed > (_veh getVariable ["lockfast",-1000])) && (_veh getVariable ["locktarget",_target] == _target)) then //set new lockfast if higher than previous
				{
					[_veh,"lockfast",_speed] call A3PL_Police_RadarSet;
					_veh setvariable ["lockfast",_speed,false];
					_veh setvariable ["locktarget",_target,false];
				};
			};
			_speed = (speed _veh) * 0.621371;
			[_veh,"patrol",_speed] call A3PL_Police_RadarSet;
		};
		uiSleep 0.1;
	};
	deleteVehicle _Beam;
	deleteVehicle _Beam2;
}] call Server_Setup_Compile;

//seperate loop to handle MP sync of variables
["A3PL_Police_RadarLoopSync",
{
	private ["_veh","_tempVar"];
	_veh = param [0,objNull];
	_tempVar = _veh getVariable ["radar_prev",["","","","","","","","",""]];
	if (!isNil "RadarLoopSyncRunning") exitwith {["Debug: RadarLoopSync not started, already running","red"] call A3PL_Player_Notification;};
	RadarLoopSyncRunning = true;
	while {player IN _veh} do
	{
		if (_veh animationPhase "Radar_Master" > 0.5) then
		{
			private ["_tex"];
			_tex = getObjectTextures _veh;
			for "_i" from 8 to 16 do
			{
				private ["_newTex"];
				_newTex = _tex select _i;
				if ((_tempVar select (_i-8)) != _newTex) then //if the texture is different from the one we synced last time
				{
					_veh setObjectTextureGlobal [_i,_newTex]; //sync the texture globally
					_tempVar set [_i,_newTex];
				};
			};
			_veh setVariable ["radar_prev",_tempVar,false];
		};
		uiSleep 1.5; //sync every 1.5sec, change this to quicker/slower
	};
	RadarLoopSyncRunning = nil;
}] call Server_Setup_Compile;

//set a number to radar
["A3PL_Police_RadarSet",
{
	private ["_selStart"];
	_veh = param [0,objNull];
	_type = param [1,"target"];
	_number = param [2,0];
	_global = param [3,false];

	switch (_type) do
	{
		case ("target"): {_selStart = 8};
		case ("lockfast"): {_selStart = 11};
		case ("patrol"): {_selStart = 14};
		case default {_selStart = 8};
	};

	_number = [_number, 3] call CBA_fnc_formatNumber; //format number to string of 3 chars
	if (count _number > 3) then //remove minus from negative numbers
	{
		_number = toArray _number;
		_number deleteAt 0;
		_number = toString _number;
	};

	for "_i" from _selStart to (_selStart + 2) do //set texture
	{
		if (_global) then
		{
			_veh setObjectTextureGlobal [_i,format ["\a3pl_cars\common\textures\numbers\%1.paa",(_number select [(_i - _selStart),1])]];
		} else
		{
			_veh setObjectTexture [_i,format ["\a3pl_cars\common\textures\numbers\%1.paa",(_number select [(_i - _selStart),1])]];
		};
	};

}] call Server_Setup_Compile;

["A3PL_Police_MarkHouse",
{
	private _house = parseSimpleArray (param [0,""]);
	private _name = param [1,"unknown"];
	private _warehouse = param [2,false];
	private _marker = createMarkerLocal [format ["Marked_House_%1",random 4000], _house];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "mil_warning";
	if(_warehouse) then {
		_marker setMarkerTextLocal format["%1 Warehouse", _name];
	} else {
		_marker setMarkerTextLocal format["%1 House", _name];
	};
	_marker setMarkerColorLocal "ColorRed";
	uiSleep 120;
	deleteMarkerLocal _marker;
}] call Server_Setup_Compile;

["A3PL_Police_Panic",
{
	private _faction = player getVariable ["faction",""];
	private _panicCooldown = player getVariable ["panicCooldown",false];
	private _factionMembers = [_faction] call A3PL_Lib_FactionPlayers;
	if (_panicCooldown) exitWith {[localize"STR_NewPolice_29", "red"] call A3PL_Player_Notification;};

	[player] remoteExec ["A3PL_Police_PanicMarker", _factionMembers];
	player setVariable ["panicCooldown",true,false];

	player playActionNow "A3FL_RadioAnim_02";
	sleep 0.8;
	player playActionNow "GestureNod";

	sleep 180;
	player setVariable ["panicCooldown",false,false];
}] call Server_Setup_Compile;

["A3PL_Police_PanicMarker",
{
	private _player = param [0,objNull];
	playSound3D ["A3PL_Common\effects\panic-button.ogg", player, false, getPosASL player, 5, 1, 8];
	[localize"STR_NewPolice_31","red"] call A3PL_Player_Notification;
	[_player,"Panic Button","ColorRed","mil_warning",60] spawn A3PL_Lib_CreateMarker;
}] call Server_Setup_Compile;

["A3PL_Police_SeizeItems",
{
	private ["_typeOfSeize"];
	_typeOfSeize = param [0,0];
	_data = param [1,[]];
	_addToStorage = [];
	if(_typeOfSeize isEqualTo 0) exitWith {};

	switch(_typeOfSeize) do {
		case 1: {
			_holders = nearestObjects [player,["groundWeaponHolder"],3];
			{
				{_addToStorage pushback ["weapon", _x, 1];} forEach (weaponCargo _x);
				{_addToStorage pushback ["magazine", _x, 1];} forEach (magazineCargo _x);
				{_addToStorage pushback ["aitem", _x, 1];} forEach (itemCargo _x);
				deleteVehicle _x;
			} forEach _holders;
		};
		case 2: {
			_addToStorage pushback ["item", _data select 0, _data select 1];
		};
	};

	{
		private["_type","_class","_amount"];
		_type = _x select 0;
		_class = _x select 1;
		_amount = _x select 2;
		switch(_type) do {
			case("weapon"): {
				A3FL_Seize_Storage addWeaponCargoGlobal [_class, _amount];
			};
			case("magazine"): {
				A3FL_Seize_Storage addMagazineCargoGlobal [_class, _amount];
			};
			case("aitem"): {
				A3FL_Seize_Storage addItemCargoGlobal [_class, _amount];
			};
			case("item"): {
				_virtuals = A3FL_Seize_Storage getVariable ['storage',[]];
				_newArray = [_virtuals, _class, _amount] call BIS_fnc_addToPairs;
				A3FL_Seize_Storage setVariable ['storage', _newArray, true];
			};
		};
	} foreach _addToStorage;
}] call Server_Setup_Compile;

["A3PL_Police_Breathalizer",
{
	private["_target"];
	_target = param [0,objNull];
	[player] remoteExec ["A3PL_Police_BreathalizerReturn",_target];
	[player_item] call A3PL_Inventory_Clear;
	[player,"breathalizer",-1] remoteExec ["Server_Inventory_Add",2];
}] call Server_Setup_Compile;

["A3PL_Police_BreathalizerReturn",
{
	private["_cop"];
	_cop = param [0,objNull];
	[format[localize "STR_NewPolice_32",Player_Alcohol,"%"], "blue"] remoteExec ["A3PL_Player_Notification",_cop];
}] call Server_Setup_Compile;

["A3PL_Police_RemoveMask",
{
	_player = param [0,objNull];

	_mask = goggles _player;
	removeGoggles _player;

	_weaponHolder = createVehicle ["GroundWeaponHolder", getposATL player, [], 0, "CAN_COLLIDE"];
	_weaponHolder addItemCargoGlobal [_mask,1];

  ["Your mask has been removed", "blue"] remoteExec ["A3PL_Player_Notification",_player];
}] call Server_Setup_Compile;

["A3PL_Police_FakeID",{
	createDialog "Dialog_FakeID";
}] call Server_Setup_Compile;

["A3PL_Police_FakeIDSave", {
	private _name = ctrlText 1401;
	player setVariable["fakeName",_name,true];
	closeDialog 0;
	[format["You now have a fake ID and are known as %1",_name],"green"] call A3PL_Player_Notification;
	[getPlayerUID player,"FakeIdSelected",[_name]] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_Police_MirandaCard",
{
	disableSerialization;
	("Hud_MirandaCard" call BIS_fnc_rscLayer) cutRsc ["Dialog_Miranda", "PLAIN", 2];
	sleep 10;
	("Hud_MirandaCard" call BIS_fnc_rscLayer) cutFadeOut 1;
}] call Server_Setup_Compile;

["A3PL_Police_OpenSquadNb", {
	private _veh = param [0,objNull];
	createDialog "Dialog_SquadNb";
	ctrlSetText [1400, _veh getVariable["squadnb",((netId _veh) splitString ":") select 1]];
	A3PL_SquadNb_Veh = _veh;
}] call Server_Setup_Compile;

["A3PL_Police_SaveSquadNb", {
	private _number = ctrlText 1400;
	private _faction = player getVariable["job","unemployed"];

	if((count _number) > 8) exitWith {["You cannot enter more than 8 characters","red"] call A3PL_Player_Notification;};

	if((typeOf A3PL_SquadNb_Veh) IN ["A3PL_Pierce_Rescue","A3PL_Pierce_Pumper","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder"]) then {
		private _numberArray = _number splitString "";
		private _TruckNumber2 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _numberArray select 0];
		private _TruckNumber3 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _numberArray select 1];
		A3PL_SquadNb_Veh setObjectTextureGlobal [8, _TruckNumber2];
		A3PL_SquadNb_Veh setObjectTextureGlobal [9, _TruckNumber3];
		A3PL_SquadNb_Veh setVariable ["squadnb",_number,true];
	} else {
		if((typeOf A3PL_SquadNb_Veh) isEqualTo "A3PL_Silverado_FD_Brush") then {
			private _numberArray = _number splitString "";
			private _TruckNumber = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _numberArray select 0];
			A3PL_SquadNb_Veh setObjectTextureGlobal [8, _TruckNumber];
			A3PL_SquadNb_Veh setVariable ["squadnb",_number,true];
		} else {
			A3PL_SquadNb_Veh setVariable ["squadnb",_number,true];
		};
	};
	A3PL_SquadNb_Veh setVariable["faction",_faction,true];
	A3PL_SquadNb_Veh = nil;
	closeDialog 0;
}] call Server_Setup_Compile;