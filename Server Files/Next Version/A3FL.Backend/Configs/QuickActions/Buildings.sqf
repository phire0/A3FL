/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

[
	"Land_A3PL_BarGate",
	localize"STR_INTSECT_OPCLBARG",
	{
		private _bargate = player_objintersect;
		private _anim = (player_nameintersect splitstring "_") select 1;
		private _canUse = [getPos _bargate] call A3PL_Config_CanUseBargate;
		if(["keycard"] call A3PL_Inventory_Has) then {_canUse = true;};
		if (!_canUse) exitwith {
			[localize"STR_QuickActionsBuildings_JobDontAllowToUse","red"] call A3PL_Player_Notification;
		};
		if (_bargate animationSourcePhase _anim < 0.5) then {
			_bargate animateSource [_anim,1];
		} else {
			_bargate animateSource [_anim,0];
		};
	}
],
[
	"Land_A3PL_BarGate_Left",
	localize"STR_INTSECT_OPCLBARG",
	{
		private _bargate = player_objintersect;
		private _anim = (player_nameintersect splitstring "_") select 1;
		private _canUse = [getPos _bargate] call A3PL_Config_CanUseBargate;
		if(["keycard"] call A3PL_Inventory_Has) then {_canUse = true;};
		if (!_canUse) exitwith {
			[localize"STR_QuickActionsBuildings_JobDontAllowToUse","red"] call A3PL_Player_Notification;
		};
		if (_bargate animationSourcePhase _anim < 0.5) then {
			_bargate animateSource [_anim,1];
		} else {
			_bargate animateSource [_anim,0];
		};
	}
],
[
	"Land_A3PL_BarGate_Right",
	localize"STR_INTSECT_OPCLBARG",
	{
		private _bargate = player_objintersect;
		private _anim = (player_nameintersect splitstring "_") select 1;
		private _canUse = [getPos _bargate] call A3PL_Config_CanUseBargate;
		if(["keycard"] call A3PL_Inventory_Has) then {_canUse = true;};
		if (!_canUse) exitwith {
			[localize"STR_QuickActionsBuildings_JobDontAllowToUse","red"] call A3PL_Player_Notification;
		};
		if (_bargate animationSourcePhase _anim < 0.5) then {
			_bargate animateSource [_anim,1];
		} else {
			_bargate animateSource [_anim,0];
		};
	}
],
[
	"Land_A3PL_Gas_Station",
	localize"STR_QuickActionsBuildings_CheckMoneyInCash",
	{call A3PL_Hydrogen_CheckCash;}
],
[
	"Land_A3PL_Gas_Station",
	localize"STR_QuickActionsBuildings_TakeFuelStationCash",
	{call A3PL_Hydrogen_TakeCash;}
],
[
	"",
	localize"STR_QuickActionsBuildings_CheckFireAlarm",
	{[player_objintersect] spawn A3PL_FD_CheckFireAlarm;}
],
[
	"",
	localize"STR_QuickActionsBuildings_TriggerFireAlarm",
	{[player_objintersect] spawn A3PL_FD_FireAlarm;}
],
[
	"",
	localize"STR_QuickActionsBuildings_ReEnableFireAlarm",
	{[player_objintersect] spawn A3PL_FD_SetFireAlarm;}
],
[
	"",
	localize"STR_QuickActionsBuildings_RepairFireAlarm",
	{[player_objintersect] spawn A3PL_FD_RepairFireAlarm;}
],
[
	"",
	localize"STR_INTSECT_SPVHINGAR",
	{call A3PL_Storage_OpenCarStorage;}
],
[
	"",
	localize"STR_INTSECT_VEHSTOR",
	{call A3PL_Storage_OpenCarStorage;}
],
[
	"",
	localize"STR_INTSECT_STOREVEH",
	{call A3PL_Storage_CarStoreButton;}
],
[
	"A3PL_carInfo",
	localize"STR_INTSECT_STOREAIRC",
	{["plane"] call A3PL_Storage_CarStoreButton;}
],
[
	"",
	localize"STR_INTSECT_OBJSTOR",
	{call A3PL_Storage_OpenObjectStorage;}
],
[
	"",
	localize"STR_INTSECT_STOREOBJ",
	{call A3PL_Storage_ObjectStoreButton;}
],
[
	"A3PL_carInfo",
	localize"STR_INTSECT_IMPNEARVEH",
	{call A3PL_JobRoadWorker_Impound;}
],
[
	"land_a3pl_sheriffpd",
	localize"STR_INTSECT_OPCLGARDOOR",
	{
		private _intersect = player_objintersect;
		private _nameintersect = player_nameintersect;
		if (_nameintersect IN ["door_1_1","door_1_2","door_1_3"]) exitwith {
			if (_intersect animationSourcePhase "garage1" < 0.1) then {
				_intersect animateSource ["garage1",1];
			} else {
				_intersect animateSource ["garage1",0];
			};
		};
		if (_nameintersect IN ["door_2_1","door_2_2","door_2_3"]) exitwith {
			if (_intersect animationSourcePhase "garage2" < 0.1) then {
				_intersect animateSource ["garage2",1];
			} else {
				_intersect animateSource ["garage2",0];
			};
		};
	}
],
[
	"land_a3fl_sheriffpd",
	localize"STR_QuickActionsBuildings_UseSDButton",
	{
		private _name = player_nameintersect;
		private _inter = player_objintersect;
		switch (_name) do {
			case "door3_button": {_anim = ["door_3","door_4"]};
            case "door3_button2": {_anim = ["door_3","door_4"]};
            case "door5_button": {_anim = ["door_5","door_6"]};
            case "door5_button2": {_anim = ["door_5","door_6"]};
            case "door7_button": {_anim = ["door_7","door_8"]};
            case "door7_button2": {_anim = ["door_7","door_8"]};
            case "door15_button": {_anim = ["door_15"]};
            case "door15_button2": {_anim = ["door_15"]};
            case "door13_button": {_anim = ["door_13","door_14"]};
            case "door13_button2": {_anim = ["door_13","door_14"]};
		};
		if (typeName _anim == "ARRAY") exitwith {
			{
				if (_inter animationPhase _x < 0.1) then {
					_inter animate [_x,1];
				} else {
					_inter animate [_x,0];
				};
			} foreach _anim;
		};
		if (_inter animationPhase _anim < 0.1) then {
			_inter animate [_anim,1];
		} else {
			_inter animate [_anim,0];
		};
	}
],
[
	"land_a3pl_sheriffpd",
	localize"STR_QuickActionsBuildings_UseSDButton",
	{
		private _name = player_nameintersect;
		private _inter = player_objintersect;
		switch (_name) do {
			case "garageDoor_button": {_anim = "garage"};
			case "garageDoor_button2": {_anim = "garage"};
			case "door3_button": {_anim = ["door3","door4"]};
			case "door3_button2": {_anim = ["door3","door4"]};
			case "door5_button": {_anim = ["door5","door6"]};
			case "door5_button2": {_anim = ["door5","door6"]};
			case "door7_button": {_anim = ["door7","door8"]};
			case "door7_button2": {_anim = ["door7","door8"]};
			case "door9_button": {_anim = ["door9","door10"]};
			case "door9_button2": {_anim = ["door9","door10"]};
			case "door11_button": {_anim = "door11"};
			case "door11_button2": {_anim = "door11"};
		};
		if (typeName _anim == "ARRAY") exitwith {
			{
				if (_inter animationPhase _x < 0.1) then {
					_inter animate [_x,1];
				} else {
					_inter animate [_x,0];
				};
			} foreach _anim;
		};
		if (_inter animationPhase _anim < 0.1) then {
			_inter animate [_anim,1];
		} else {
			_inter animate [_anim,0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_OPCLJAILD",
	{
		private _name = player_nameintersect;
		private _inter = player_objintersect;
		if (_inter animationPhase _name < 0.1) then {
			_inter animate [_name,1];
		} else {
			_inter animate [_name,0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_SITDOWN",
	{[player_objintersect,player_nameintersect] call A3PL_Lib_Sit;}
],
[
	"",
	localize"STR_INTSECT_LAYDOWN",
	{[player_objintersect,player_nameintersect] call A3PL_Lib_Sit;}
],
[
	"",
	localize"STR_QuickActionsBuildings_GetUp",
	{
		if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) exitWith {[player,"a3pl_handsupkneelcuffed"] remoteExec ["A3PL_Lib_SyncAnim", -2];};
		[player,"amovppnemstpsnonwnondnon"] remoteExec ["A3PL_Lib_SyncAnim", -2];
	}
],
[
	"Land_A3PL_Bank",
	localize"STR_INTSECT_CONVAULTDRI",
	{[player_objintersect] call A3PL_BHeist_SetDrill;}
],
[
	"Land_A3FL_Fishers_Jewelry",
	localize"STR_INTSECT_CONVAULTDRI",
	{[player_objintersect] call A3PL_Jewelry_SetDrill;}
],
[
	"Land_A3PL_Bank",
	localize"STR_INTSECT_OPDEPBOX",
	{[player_objintersect,player_nameintersect] spawn A3PL_BHeist_OpenDeposit;}
],
[
	"Land_A3PL_Bank",
	localize"STR_INTSECT_SECVAULTD",
	{[player_objintersect,player_nameintersect] call A3PL_BHeist_CloseVault;}
],
[
	"Land_A3FL_Fishers_Jewelry",
	localize"STR_INTSECT_SECVAULTD",
	{[player_objintersect,player_nameintersect] call A3PL_Jewelry_CloseVault;}
],
[
	"Land_A3FL_Fishers_Jewelry",
	"Open/Close Safe",
	{
		_building = player_objIntersect;
		if(_building animationPhase "Vault_Door" > 0.95) then {
			_building animateSource ["Vault_Door",0];
		} else {
			_building animateSource ["Vault_Door",1];
		};
	}
],
[
	"Land_A3FL_Fishers_Jewelry",
	"Break Glass",
	{["Hit the glass with a melee weapon","orange"] call A3PL_Player_Notification;}
],
[
	"Land_A3FL_Fishers_Jewelry",
	"Steal Jewelry",
	{[player_objintersect,player_nameintersect] call A3PL_Jewelry_PickJewelry;}
],
[
	"Land_A3PL_Garage",
	localize"STR_INTSECT_UPGRVEH",
	{[player_objintersect] spawn A3PL_Garage_Open;}
],

[
	"Land_A3PL_Gas_Station",
	localize"STR_INTSECT_OPENGASMENU",
	{call A3PL_Hydrogen_Open;}
],
[
	"Land_A3PL_Gas_Station",
	localize"STR_QuickActionsBuildings_OpCLoseFuel",
	{call A3PL_Hydrogen_LockUnlock;}
],
[
	"Land_A3PL_Gas_Station",
	"Check Rent Time Remaining",
	{[player_objintersect, player] remoteExec ["Server_Business_CheckRentTime",2];}
],
[
	"",
	"Lockpick Door",
	{[player_objintersect] call A3PL_HouseRobbery_Rob;}
],
[
	"",
	"Secure House",
	{[player_objintersect] call A3PL_HouseRobbery_Secure;}
],
[
	"Land_A3PL_Mailbox",
	localize"STR_INTSECT_OPCLMAILB",
	{
		private _obj = player_objintersect;
		if (_obj animationPhase "door_mailbox" < 0.5) then {
			_obj animate ["door_mailbox",1];
		} else {
			_obj animate ["door_mailbox",0];
		};
	}
],
[
    "",
    localize"STR_INTSECT_TURNONLIGHTS",
    {[player_objintersect,player_nameintersect] call A3PL_Lib_SwitchLight;}
],
[
	"Land_A3PL_Impound",
	localize"STR_INTSECT_OPCLIMPGATE",
	{
		_impound = player_objintersect;
		if (_impound animationSourcePhase "GarageDoor" < 0.5) then {
			_impound animateSource ["GarageDoor",1];
		} else {
			_impound animateSource ["GarageDoor",0];
		};
	}
],
[
	"",
	localize"STR_INTSECT_USEDOORB",
	{[player_objintersect,player_nameIntersect] call A3PL_Intersect_HandleDoors;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",1],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",2],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",3],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",4],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",5],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",6],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",7],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",8],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",9],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",10],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",11],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",12],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",13],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",14],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENMCELL",1],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENMCELL",2],
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	localize"STR_INTSECT_OPENKCELL",
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	localize"STR_INTSECT_OPENGARAGE",
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_Prison",
	localize"STR_INTSECT_LOCKDOWN",
	{[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;}
],
[
	"Land_A3PL_CH",
	localize"STR_INTSECT_OPCLDEFROOM",
	{call A3PL_Intersect_HandleDoors;}
],
[
	"Land_A3PL_CH",
	localize"STR_INTSECT_OPCLDEFROOM",
	{call A3PL_Intersect_HandleDoors;}
],
[
	"",
	localize"STR_INTSECT_LOUNDOOR",
	{
		private ["_keyid","_obj","_locked","_format","_keyCheck","_name","_getVarName"];
		_obj = (call A3PL_Intersect_Cursortarget);
		_name = player_nameintersect;
		if (isNil "Player_Item") exitwith {	_format = format[localize"STR_QuickActionsBuildings_DontHaveKeyInHand"]; [_format, "red"] call A3PL_Player_Notification; };
		if (isNull Player_Item) exitwith { _format = format[localize"STR_QuickActionsBuildings_DontHaveKeyInHand"]; [_format, "red"] call A3PL_Player_Notification; };
		_keyID = Player_Item getVariable "keyID";
		if (isNil "_keyID") exitwith {_format = format[localize"STR_QuickActionsBuildings_CantOpenDoorWithThisObject"]; [_format, "red"] call A3PL_Player_Notification;};
		_keyCheck = false;
		if (typeOf _obj == "Land_A3PL_Motel") then {
			_keyCheck = [_obj,_keyID,_name] call A3PL_Housing_CheckOwn;
		} else {
			_keyCheck = [_obj,_keyID] call A3PL_Housing_CheckOwn;
		};
		if (_keyCheck) then {
			_getVarName = "unlocked";
			if (typeOf _obj == "Land_A3PL_Motel") exitwith {
				_getVarName = format ["%1_locked",_name];
				if ((_obj getVariable [_getVarName,true])) then {
					_obj setVariable [_getVarName,false,true];
					player playAction "gesture_key";
					_format = format[localize"STR_QuickActionsBuildings_DoorUnlocked"]; [_format, "green"] call A3PL_Player_Notification;
				}else{
					_obj setVariable [_getVarName,true,true];
					player playAction "gesture_key";
					_format = format[localize"STR_QuickActionsBuildings_DoorLocked"]; [_format, "red"] call A3PL_Player_Notification;
				};
			};
			_locked = _obj getVariable [_getVarName,nil];
			if (isNil "_locked") then {
				_obj setVariable [_getVarName,true,true];
				_format = format[localize"STR_QuickActionsBuildings_DoorUnlocked"]; [_format, "green"] call A3PL_Player_Notification;
			} else {
				_obj setVariable [_getVarName,Nil,true];
				_format = format[localize"STR_QuickActionsBuildings_DoorLocked"]; [_format, "red"] call A3PL_Player_Notification;
			};
			player playAction "gesture_key";
		} else {
			_format = format[localize"STR_QuickActionsBuildings_WrongKey"]; [_format, "red"] call A3PL_Player_Notification;
		};
	}
],
[
	"Land_A3PL_GreenhouseSign",
	localize"STR_INTSECT_RENTGH",
	{
		_playerLevel = player getVariable["Player_Level",0];
		if(_playerLevel < 5) then {
			[format[localize"STR_QuickActions_Notifications_Buildings_ThingsLevel5required"], "red"] call A3PL_Player_Notification;
		} else {
			[player_objIntersect] call A3PL_JobFarming_Rent;
		};
	}
],
[
	"Land_A3PL_BusinessSign",
	localize"STR_INTSECT_RENTBUSI",
	{[player_objIntersect] call A3PL_Business_Buy;}
],
[
	"Land_A3PL_BusinessSign",
	localize"STR_INTSECT_BUYBUSI",
	{call A3PL_Company_OpenBuyShop;}
],
[
	"Land_A3PL_BusinessSign",
	"Purchase Warehouse",
	{[player_objIntersect] call A3PL_Warehouses_OpenBuyMenu;}
],
[
	"Land_A3PL_EstateSign",
	localize"STR_INTSECT_BUYHOUSE",
	{
			[player_objIntersect] call A3PL_Housing_OpenBuyMenu;
	}
],
[
	"Land_A3PL_EstateSign",
	localize"STR_INTSECT_SELLHOUSE",
	{[player_objintersect] call A3PL_RealEstates_Open;}
],
[
	"Land_A3PL_EstateSign",
	localize"STR_INTSECT_LEAVHOUSE",
	{[] call A3PL_Housing_LeaveHouse;}
],
[
	"Land_A3PL_Showroom",
	localize"STR_INTSECT_OPENSHOWDOOR",
	{
		private _obj = player_objintersect;
		private _name = player_nameIntersect;
		if ((isNull _obj) or (_name == "")) exitwith {[localize"STR_QuickActionsBuildings_CantCloseShowRoom", "red"] call A3PL_Player_Notification;};
		if (!(typeOf _obj == "Land_A3PL_Showroom")) exitwith {[localize"STR_QuickActionsBuildings_DontLookAtShowroom", "red"] call A3PL_Player_Notification;};
		if (_name == "garage1_open") then {
			_obj animateSource ["garage2",1];
		} else {
			_obj animateSource ["garage1",1];
		};
	}
],
[
	"Land_A3PL_Showroom",
	localize"STR_INTSECT_CLOSESHOWDOOR",
	{
		private _obj = player_objintersect;
		private _name = player_nameIntersect;
		if ((isNull _obj) or (_name == "")) exitwith {[localize"STR_QuickActionsBuildings_CantCloseShowRoom", "red"] call A3PL_Player_Notification;};
		if (!(typeOf _obj == "Land_A3PL_Showroom")) exitwith {[localize"STR_QuickActionsBuildings_DontLookAtShowroom", "red"] call A3PL_Player_Notification;};
		if (_name == "garage1_close") then {
			_obj animateSource ["garage2",0];
		} else {
			_obj animateSource ["garage1",0];
		};
	}
],
[
	"Land_A3PL_Garage",
	localize"STR_INTSECT_USECARLIFT",
	{[player_objintersect] call A3PL_JobMechanic_UseLift;}
],
[
	"",
	localize"STR_INTSECT_KNOCKONDOOR",
	{playSound3D ["A3PL_Common\effects\knockdoor.ogg", player, true, getPosASL player, 3, 1, 10];}
],
[
	"",
	"Lockpick Cell Door",
	{[player_nameintersect, player_objIntersect] call A3PL_Prison_LockpickCell;}
]
