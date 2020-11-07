/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

A3PL_Interaction_Options =
[
	[
		localize "STR_INTER_SUICIDEVEST",
		{call A3PL_Criminal_SuicideVest;},
		{(vest player) isEqualTo "A3PL_SuicideVest"}
	],
	[
		localize "STR_INTER_SWITCHPRESSURE",
		{[cursorObject] call A3PL_FD_ChangeTruckPressure;},
		{(typeOf cursorObject) IN ["A3PL_Pierce_Pumper","A3PL_Silverado_FD_Brush"]}
	],
	[
		localize "STR_INTER_DELIVERY",
		{call A3PL_Delivery_Deliver;},
		{private _found = false; {if ((typeOf _x) isEqualTo "A3PL_DeliveryBox") exitwith {_found = true; true;}} foreach ([player] call A3PL_Lib_AttachedAll); _found;}
	],
	[
		localize "STR_INTER_FACTIONHIRE",
		{
			[(getPlayerUID cursorObject), (player getVariable["faction","citizen"])] remoteExec ["A3PL_Player_Whitelist",cursorObject];
			[format[localize"STR_Inter_Notifications_Recruit", name cursorObject],"green"] call A3PL_Player_Notification;
		},
		{(isPlayer cursorObject) && {(cursorObject getVariable["faction","citizen"] isEqualTo "citizen")} && {((player getVariable["faction","citizen"]) IN ["fifr","uscg","fisd","fims","doj"])} && {([(player getVariable["faction","citizen"])] call A3PL_Government_isFactionLeader)}}
	],
	[
		localize "STR_INTER_SETNAMET",
		{[cursorObject] call A3PL_Player_OpenNametag;},
		{((vehicle player) isEqualTo player) && {(isPlayer cursorObject)} && {(player distance cursorObject < 5)} && {(profilenamespace getVariable ["Player_EnableID",true])}}
	],
	[
		"Set Squad Number",
		{[player_objintersect] call A3PL_Police_OpenSquadNb;},
		{((typeOf player_objintersect) IN ["Jonzie_Ambulance","A3PL_CVPI_PD","A3PL_CVPI_PD_Slicktop","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Tahoe_FD","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Pierce_Pumper","A3PL_P362_TowTruck","A3PL_RBM","A3PL_F150_Marker","A3PL_Silverado_PD","A3PL_VetteZR1_PD","A3PL_E350","A3PL_Pierce_Rescue","A3PL_Raptor_PD","A3PL_Raptor_PD_ST","A3PL_Taurus_PD","A3PL_Taurus_PD_ST","A3PL_Silverado_FD","A3PL_Silverado_FD_Brush","A3PL_Silverado_PD_ST","A3PL_Taurus_FD","A3PL_Charger15_PD","A3PL_Charger15_PD_ST","A3PL_Charger15_FD","A3PL_Jayhawk"]) && (player distance cursorObject < 5) && ((player getVariable["faction","citizen"]) IN ["fifr","uscg","fisd","fims"])}
	],
	[
		localize"STR_INTER_COMPHIRE",
		{
			private _target = cursorobject;
			private _cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
			[_cid, player] remoteExec ["A3PL_Company_HiringConfirmation",_target];
			[format[localize"STR_Inter_Notifications_Comphire", name cursorObject],"green"] call A3PL_Player_Notification;
		},
		{(isPlayer cursorObject) && {([getPlayerUID player] call A3PL_Config_IsCompanyBoss)} && {!([getPlayerUID cursorobject] call A3PL_Config_InCompany)}}
	],
	[
		localize"STR_INTER_SETRHIBLIGHT",
		{
			_lightObj = (vehicle player) getVariable["rhib_light",objNull];
			if(isNull(_lightObj)) then {
				_lightObj = createVehicle ["A3PL_Camping_Light", [0,0,0], [], 0, 'CAN_COLLIDE'];
				_lightObj attachTo [(vehicle player), [0.08,-0.65,0.7]];
				(vehicle player) setVariable["rhib_light",_lightObj,true];
				["Camper_Light",-1] call A3PL_Inventory_Add;
			} else {
				["Camper_Light",1] call A3PL_Inventory_Add;
				deleteVehicle(_lightObj);
			};
		},
		{(typeOf (vehicle player) isEqualTo "A3PL_RHIB") && {((["Camper_Light",1] call A3PL_Inventory_Has) || {!isNull((vehicle player) getVariable["rhib_light",objNull])})}}
	],
	[
		localize"STR_INTER_SETCOLLOC",
		{
			private _playerLevel = player getVariable["Player_Level",0];
			if(_playerLevel < 10) then {
				[format[localize"STR_Inter_Notifications_Level10ThingsPerks"], "red"] call A3PL_Player_Notification;
			} else {
				private _house = (nearestObjects [getPos player, Config_Houses_List, 10,true]) select 0;
				private _uids = _house getVariable ["owner",[]];
				if(count _uids isEqualTo 0) exitwith {[localize"STR_Inter_Notifications_HouseNotRent", "red"] call A3PL_Player_Notification;};
				_uid = _uids select 0;
				if((getPlayerUID player) isEqualTo _uid) then {
					[player, cursorobject, _house] remoteExec ["Server_Housing_AddMember",2];
					private _namePos = [getPos _house] call A3PL_Housing_PosAddress;
					[format[localize"STR_Inter_Notifications_NewColloc",_namePos], "green"] call A3PL_Player_Notification;
				} else {
					[localize"STR_Inter_Notifications_FirstOwner", "red"] call A3PL_Player_Notification;
				};
			};
		},
		{private _house = nearestObjects [getPos player, Config_Houses_List, 10,true];private _var = cursorObject getVariable "house";if(((count _house) > 0) && (isPlayer cursorObject) && (isNil "_var")) then {true;} else {false;};}
	],
	[
		localize"STR_INTER_SETCOLLOC",
		{
			private _playerLevel = player getVariable["Player_Level",0];
			if(_playerLevel < 10) then {
				[format[localize"STR_Inter_Notifications_Level10ThingsPerks"], "red"] call A3PL_Player_Notification;
			} else {
				private _warehouse = (nearestObjects [getPos player, Config_Warehouses_List, 10,true]) select 0;
				private _uids = _warehouse getVariable ["owner",[]];
				if(count _uids isEqualTo 0) exitwith {[localize"STR_Inter_Notifications_HouseNotRent", "red"] call A3PL_Player_Notification;};
				_uid = _uids select 0;
				if((getPlayerUID player) isEqualTo _uid) then {
					[player, cursorObject, _warehouse] remoteExec ["Server_Warehouses_AddMember",2];
					private _namePos = [getPos _warehouse] call A3PL_Housing_PosAddress;
					[format[localize"STR_Inter_Notifications_NewColloc",_namePos], "green"] call A3PL_Player_Notification;
				} else {
					[localize"STR_Inter_Notifications_FirstOwner", "red"] call A3PL_Player_Notification;
				};
			};
		},
		{
			private _warehouse = nearestObjects [getPos player, Config_Warehouses_List, 10,true];
			private _var = cursorObject getVariable "warehouse";
			if(((count _warehouse) > 0) && (isPlayer cursorObject) && (isNil "_var")) then {
				true;
			} else {
				false;
			};
		}
	],
	[
		localize"STR_INTER_UNSETCOLLOC",
		{
			private _playerLevel = player getVariable["Player_Level",0];
			if(_playerLevel < 10) then {
				[format[localize"STR_Inter_Notifications_Level10ThingsPerks"], "red"] call A3PL_Player_Notification;
			} else {
				private _house = (nearestObjects [getPos player, Config_Houses_List, 10,true]) select 0;
				private _uids = _house getVariable ["owner",[]];
				if(count _uids isEqualTo 0) exitwith {[localize"STR_Inter_Notifications_HouseNotRent", "red"] call A3PL_Player_Notification;};
				_uid = _uids select 0;
				if((getPlayerUID player) isEqualTo _uid) then {
					private _namePos = [getPos _house] call A3PL_Housing_PosAddress;
					[cursorObject, _house] remoteExec ["Server_Housing_RemoveMember",2];
					[format[localize"STR_Inter_Notifications_FireColloc",_namePos], "green"] call A3PL_Player_Notification;
				} else {
					[localize"STR_Inter_Notifications_FirstOwnerFire", "red"] call A3PL_Player_Notification;
				};
			};
		},
		{private _house = nearestObjects [getPos player, Config_Houses_List, 10,true]; if(((count _house) > 0) && (isPlayer cursorObject)) exitWith {true;};}
	],
	[
		localize"STR_INTER_UNSETCOLLOC",
		{
			private _playerLevel = player getVariable["Player_Level",0];
			if(_playerLevel < 10) then {
				[format[localize"STR_Inter_Notifications_Level10ThingsPerks"], "red"] call A3PL_Player_Notification;
			} else {
				private _warehouse = (nearestObjects [getPos player, Config_Warehouses_List, 10,true]) select 0;
				private _uids = _warehouse getVariable ["owner",[]];
				if(count _uids isEqualTo 0) exitwith {[localize"STR_Inter_Notifications_HouseNotRent", "red"] call A3PL_Player_Notification;};
				_uid = _uids select 0;
				if((getPlayerUID player) isEqualTo _uid) then {
					private _namePos = [getPos _warehouse] call A3PL_Housing_PosAddress;
					[cursorObject, _warehouse] remoteExec ["Server_Warehouses_RemoveMember",2];
					[format[localize"STR_Inter_Notifications_FireColloc",_namePos], "green"] call A3PL_Player_Notification;
				} else {
					[localize"STR_Inter_Notifications_FirstOwnerFire", "red"] call A3PL_Player_Notification;
				};
			};
		},
		{private _warehouse = nearestObjects [getPos player, Config_Warehouses_List, 10,true]; if(((count _warehouse) > 0) && (isPlayer cursorObject)) exitWith {true;};}
	],
	[
		localize"STR_INTER_CHECKID",
		{[cursorObject] remoteExec ["A3PL_Hud_IDCard",player];},
		{(cursorobject isKindOf "Man") && {!(cursorobject getVariable["A3PL_Medical_Alive", true])}}
	],
	[
		localize"STR_INTER_GETUPRESCUE",
		{
			_veh = cursorobject;
			player setPos(_veh modelToWorld [0,-5,1]);
			player setDir(getDir _veh);
		},
		{((typeOf cursorobject) isEqualTo "A3PL_Pierce_Rescue") && {((player distance (cursorObject modeltoworld [0,-5.5,-1])) < 3)} && {(cursorObject animationPhase "Ladder_Rotate" == 1)}}
	],
	[
		localize"STR_INTER_FLIPVEH",
		{[cursorObject] spawn A3PL_Vehicle_Unflip;},
		{(player distance cursorObject < 5) && ((cursorObject isKindOf "Car") || (cursorObject isKindOf "Tank")) && {((vehicle player) isEqualTo player)} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}
	],
	[
		localize "STR_INTER_CHECKVIN",
		{
			private _id = (cursorObject getVariable ["owner",[]]) select 1;
			[format [localize"STR_Inter_Notifications_LicenseUSCGBoat",_id],"green"] call A3PL_Player_Notification;
		},
		{((cursorObject isKindOf "Ship") || (cursorObject isKindOf "Plane") || (cursorObject isKindOf "Air")) && {((cursorObject distance player) < 6)} && {((player getVariable ["job","unemployed"]) isEqualTo "uscg")}}
	],
	[
		localize "STR_INTER_PANIC",
		{[] spawn A3PL_Police_Panic;},
		{(!isPlayer cursorObject) && ((player getVariable ["job","unemployed"]) IN ["uscg","fisd","fims"]) && {!(player getVariable ["panicActive",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}
	],
	[
		localize "STR_INTER_CROCHETER",
		{
			private _intersect = player_objintersect;
			if (isNull _intersect) exitwith {};
			if ((typeOf _intersect) IN ["A3PL_Jayhawk","A3PL_Cutter","B_supplyCrate_F","C_IDAP_supplyCrate_F"]) exitWith {["You cannot lockpick this vehicle", "red"] call A3PL_Player_Notification;};
			[_intersect] spawn A3PL_Criminal_PickCar;
		},
		{((vehicle player) isEqualTo player) && {(player distance player_objintersect < 7)} && {(player_ItemClass isEqualTo "v_lockpick")}}
	],
	[
		localize "STR_INTER_OPENLICMENU",
		{call A3PL_DMV_Open;},
		{(vehicle player isEqualTo player) && {(isPlayer cursorObject)} && {((player getVariable ["job","unemployed"]) IN ["uscg","fifr","doj"])}}
	],
	[
		localize "STR_INTER_GETINC",
		{player moveInDriver cursorobject;},
		{((typeOf cursorobject) isEqualTo "A3PL_MobileCrane") && (player distance cursorobject < 30) && ((count (crew cursorobject)) == 0)}
	],
	[
		localize "STR_INTER_EXITC",
		{player action ["eject",vehicle player];},
		{((typeOf (vehicle player)) isEqualTo "A3PL_MobileCrane")}
	],
	[
		localize "STR_INTER_RESETC",
		{call A3PL_IE_CraneReset;},
		{((typeOf (vehicle player)) isEqualTo "A3PL_MobileCrane")}
	],
	[
		localize "STR_INTER_SHOWCCONT",
		{
			[localize "STR_INTER_SHOWCONT1","yellow"] call A3PL_Player_Notification;
			[localize "STR_INTER_SHOWCONT2","yellow"] call A3PL_Player_Notification;
			[localize "STR_INTER_SHOWCONT3","yellow"] call A3PL_Player_Notification;
			[localize "STR_INTER_SHOWCONT4","yellow"] call A3PL_Player_Notification;
			[localize "STR_INTER_SHOWCONT5","yellow"] call A3PL_Player_Notification;
			[localize "STR_INTER_SHOWCONT6","yellow"] call A3PL_Player_Notification;
		},
		{(typeOf vehicle player) isEqualTo "A3PL_MobileCrane"}
	],
	[
		localize "STR_INTER_PLACERC",
		{call A3PL_Placeables_PlaceCone;},
		{(typeOf (([] call A3PL_Lib_Attached) select 0)) isEqualTo "A3PL_RoadCone_x10"}
	],
	[
		localize "STR_INTER_SETUPTAXIFEE",
		{call A3PL_JobTaxi_SetupFare;},
		{typeOf (vehicle player) isEqualTo "A3PL_CVPI_Taxi"}
	],
	[
		localize "STR_INTER_OPENMED",
		{[player] spawn A3PL_Medical_Open;},
		{(!isPlayer cursorObject) && (Player_ItemClass isEqualTo "") && !(underwater(vehicle player))}
	],
	[
		localize "STR_INTER_TAKEPHOST",
		{[cursorobject] spawn A3PL_Player_TakeHostage;},
		{(cursorobject getVariable ["A3PL_Medical_Alive",true]) && (!(player getVariable ["Cuffed",false])) && (!(player getVariable ["Zipped",false])) && (isNil "A3PL_EnableHostage") && (isPlayer cursorObject) && (player distance cursorobject < 2) && (([cursorobject, player] call BIS_fnc_relativeDirTo) < 220) && (([cursorobject, player] call BIS_fnc_relativeDirTo) > 130) && !(cursorObject getVariable["takingHostage",false])}
	],
	[
		localize "STR_INTER_RELHOST",
		{A3PL_EnableHostage = false;},
		{!isNil "A3PL_EnableHostage"}
	],
	[
		localize "STR_INTER_POINTGFOR",
		{A3PL_HostageMode = "shoot"},
		{(!isNil "A3PL_EnableHostage") && (A3PL_HostageMode isEqualTo "hostage")}
	],
	[
		localize "STR_INTER_POINTGHOST",
		{A3PL_HostageMode = "hostage"},
		{(!isNil "A3PL_EnableHostage") && (A3PL_HostageMode isEqualTo "shoot")}
	],
	[
		localize "STR_INTER_SELLVEH",
		{[player_objintersect] call A3PL_Business_Sell;},
		{(player_objintersect isKindOf "All") && {(player_objintersect IN A3PL_Player_Vehicles)} && ((player getVariable "job") == "business")}
	],
	[
		localize "STR_INTER_BUYVEH",
		{[player_objintersect] call A3PL_Business_BuyItem;},
		{(player_objintersect isKindOf "All") && (!isNil {player_objintersect getVariable ["bitem",nil]})}
	],
	[
		localize "STR_INTER_PLANTSEED",
		{call A3PL_JobFarming_Plant;},
		{(player_itemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca","seed_sugar"]) && ((surfaceType getpos player) == "#cype_plowedfield")}
	],
	[
		localize "STR_INTER_SEARCHSEED",
		{call A3PL_JobFarming_SearchSeeds;},
		{((surfaceType getpos player) == "#cype_plowedfield") && (Player_ItemClass isEqualTo "") && (!(player getVariable ["Cuffed",false])) && (!(player getVariable ["Zipped",false])) && ((vehicle player) isEqualTo player)}
	],
	[
		localize "STR_INTER_PROSPECTG",
		{call A3PL_JobWildCat_ProspectOpen},
		{!(isPlayer cursorObject) && (Player_ItemClass isEqualTo "") && ((vehicle player) isEqualTo player) && ((surfaceType getpos player) IN ["#cype_grass","#cype_forest","#cype_soil","#cype_beach","#GtdMud","#GtdDirt","#cype_beach"])&& (!(isOnRoad player)) && (!(player getVariable ["Cuffed",false])) && (!(player getVariable ["Zipped",false]))}
	],
	[
		localize "STR_INTER_CHECKTANKC",
		{[format [localize"STR_Inter_Notifications_CheckGas",(cursorObject getVariable ["petrol",0])], "green"] call A3PL_Player_Notification;},
		{(typeOf cursorObject isEqualTo "A3PL_Tanker_Trailer")}
	],
	[
		localize"STR_INTER_CHECKTANKK",
		{
			_tanker = cursorObject;
			_gasType = _tanker getVariable["gas", nil];
			if(isNil "_gasType") exitWith {[localize"STR_Inter_Notifications_EmptyTank", "yellow"] call A3PL_Player_Notification;};
			if(_gasType == "kerosene") then {
				[format [localize"STR_Inter_Notifications_CheckKero",(cursorObject getVariable ["petrol",0])], "green"] call A3PL_Player_Notification;
			} else {
				[format [localize"STR_Inter_Notifications_CheckGas",(cursorObject getVariable ["petrol",0])], "green"] call A3PL_Player_Notification;
			};
		},
		{((typeOf cursorObject) isEqualTo "A3PL_Fuel_Van")}
	],
	[
		localize "STR_INTER_SHOWID",
		{if(!(call A3PL_Player_AntiSpam)) exitWith {}; [player] remoteExec ["A3PL_Hud_IDCard",cursorObject];},
		{(cursorobject getVariable ["A3PL_Medical_Alive",true]) && (isPlayer cursorObject) && (player distance cursorObject < 3)}
	],
	[
		"Show Fake ID",
		{if(!(call A3PL_Player_AntiSpam)) exitWith {}; [player,"citizen",true] remoteExec ["A3PL_Hud_IDCard",cursorObject];},
		{(cursorobject getVariable ["A3PL_Medical_Alive",true]) && (isPlayer cursorObject) && (player distance cursorObject < 3) && (player getVariable["fakeName",""] != "")}
	],
	[
		localize "STR_INTER_SHOWID_FISD",
		{if(!(call A3PL_Player_AntiSpam)) exitWith {}; [player,"fisd"] remoteExec ["A3PL_Hud_IDCard",cursorObject];},
		{(cursorobject getVariable ["A3PL_Medical_Alive",true]) && ((player getVariable["faction","citizen"]) isEqualTo "fisd") && (isPlayer cursorObject) && (player distance cursorObject < 3)}
	],
	[
		localize "STR_INTER_SHOWID_USCG",
		{if(!(call A3PL_Player_AntiSpam)) exitWith {}; [player,"uscg"] remoteExec ["A3PL_Hud_IDCard",cursorObject];},
		{(cursorobject getVariable ["A3PL_Medical_Alive",true]) && ((player getVariable["faction","citizen"]) isEqualTo "uscg") && (isPlayer cursorObject) && (player distance cursorObject < 3)}
	],
	[
		localize "STR_INTER_SHOWID_FIMS",
		{if(!(call A3PL_Player_AntiSpam)) exitWith {}; [player,"fims"] remoteExec ["A3PL_Hud_IDCard",cursorObject];},
		{(cursorobject getVariable ["A3PL_Medical_Alive",true]) && ((player getVariable["faction","citizen"]) isEqualTo "fims") && (isPlayer cursorObject) && (player distance cursorObject < 3)}
	],
	[
		localize "STR_INTER_SHOWID_FIFR",
		{if(!(call A3PL_Player_AntiSpam)) exitWith {}; [player,"fifr"] remoteExec ["A3PL_Hud_IDCard",cursorObject];},
		{(cursorobject getVariable ["A3PL_Medical_Alive",true]) && ((player getVariable["faction","citizen"]) isEqualTo "fifr") && (isPlayer cursorObject) && (player distance cursorObject < 3)}
	],
	[
		localize "STR_INTER_SHOWID_DOJ",
		{if(!(call A3PL_Player_AntiSpam)) exitWith {}; [player,"doj"] remoteExec ["A3PL_Hud_IDCard",cursorObject];},
		{(cursorobject getVariable ["A3PL_Medical_Alive",true]) && ((player getVariable["faction","citizen"]) isEqualTo "doj") && (isPlayer cursorObject) && (player distance cursorObject < 3)}
	],
	[
		localize "STR_INTER_SHOWID_COMPANY",
		{if(!(call A3PL_Player_AntiSpam)) exitWith {}; [player,"company"] remoteExec ["A3PL_Hud_IDCard",cursorObject];},
		{(cursorobject getVariable ["A3PL_Medical_Alive",true]) && ([getPlayerUID player] call A3PL_Config_InCompany) && (isPlayer cursorObject) && (player distance cursorObject < 3)}
	],
	[
		localize "STR_INTER_SHOWMIRANDA",
		{if(!(call A3PL_Player_AntiSpam)) exitWith {}; [] remoteExec ["A3PL_Police_MirandaCard",cursorObject];},
		{(cursorobject getVariable ["A3PL_Medical_Alive",true]) && ((player getVariable["job","unemployed"]) IN ["fisd","uscg","fims","doj"]) && (isPlayer cursorObject) && (player distance cursorObject < 3)}
	],
	[
		localize "STR_INTER_GRABID",
		{[cursorObject] spawn A3PL_Hud_IDCard;},
		{(isPlayer cursorObject) && (player distance cursorObject < 3) && ((player getVariable ["job","unemployed"]) IN ["uscg","fisd","fims"]) && animationState cursorObject IN ["a3pl_handsuptokneel","a3pl_handsupkneelgetcuffed","a3pl_cuff","a3pl_handsupkneelcuffed","a3pl_handsupkneelkicked","a3pl_cuffkickdown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","a3pl_handsupkneel"]}
	],
	[
		localize "STR_INTER_JAILP",
		{[cursorObject] call A3PL_Police_StartJailPlayer},
		{(vehicle player isEqualTo player) && (isPlayer cursorObject) && ((player getVariable ["job","unemployed"]) IN ["uscg","fisd","fims"]) && (count(nearestObjects [player, ["Land_A3PL_Prison", "Land_A3PL_Sheriffpd", "Land_A3FL_SheriffPD"], 50]) > 0)}
	],
	[
		localize "STR_INTER_JAILP",
		{[cursorObject] call A3PL_Police_StartJailPlayer},
		{(vehicle player isEqualTo player) && (isPlayer cursorObject) && ((player getVariable ["job","unemployed"]) IN ["uscg","fisd","fims"]) && (count(nearestObjects [player, ["Land_A3PL_Prison", "Land_A3PL_Sheriffpd", "Land_A3FL_SheriffPD"], 50]) > 1)}
	],
	[
		localize"STR_INTER_StartFire",
		{[] spawn A3PL_Fire_Matches;},
		{((player_itemclass isEqualTo "matches") && (vehicle player isEqualTo player))}
	],
	[
		localize "STR_INTER_SEIZEITEMS",
		{[1] call A3PL_Police_SeizeItems;},
		{((player getVariable ["job","unemployed"]) IN ["uscg","fisd","fims"]) && (count (nearestObjects [player,["weaponholder"],3] + nearestObjects [player,["groundWeaponHolder"],3]) > 0)}
	],
	[
		localize "STR_INTER_REPAIRTEROB",
		{call A3PL_JobRoadworker_RepairTerrain;},
		{((player getVariable ["job","unemployed"]) isEqualTo "Roadside") && {(vehicle player) isEqualTo player}}
	],
	[
		localize "STR_INTER_MARKIMPPOL",
		{call A3PL_Police_Impound;},
		{(vehicle player isEqualTo player) && (player_objintersect isKindOf "Car") && ((player getVariable ["job","unemployed"]) IN ["fifr","uscg","fisd","fims"])}
	],
	[
		localize "STR_INTER_IMPUSC",
		{call A3PL_Police_Impound;},
		{(vehicle player isEqualTo player) && ((cursorObject isKindOf "Ship") || (cursorObject isKindOf "Plane") || (cursorObject isKindOf "Air")) && ((player getvariable ["job","unemployed"]) isEqualTo "uscg") && !(typeOf cursorObject isEqualTo "A3PL_Yacht_Pirate")}
	],
	[
		localize "STR_INTER_LOCKV",
		{
			(vehicle player) setVariable ["locked",true,true];
			[localize "STR_INTER_LOCKVD", "red"] call A3PL_Player_Notification;
			playSound3D ["A3PL_Cars\Common\Sounds\A3PL_Car_Lock.ogg", (vehicle player), true, (vehicle player), 3, 1, 30];
		},
		{(vehicle player != player) && {(vehicle player) IN A3PL_Player_Vehicles} && {!(vehicle player getVariable ["locked",true])}}
	],
	[
		localize "STR_INTER_LOCKV",
		{
			player_objintersect setVariable ["locked",true,true];
			[localize "STR_INTER_LOCKVD", "red"] call A3PL_Player_Notification;
			playSound3D ["A3PL_Cars\Common\Sounds\A3PL_Car_Lock.ogg", player_objintersect, true, player_objintersect, 3, 1, 30];
		},
		{(vehicle player isEqualTo player) && (player distance player_objintersect < 15) && {(simulationEnabled player_objintersect)} && {!isNil "player_objintersect"} && {player_objintersect IN A3PL_Player_Vehicles} && {!(player_objintersect getVariable ["locked",true])}}
	],
	[
		localize "STR_INTER_UNLOCKV",
		{
			(vehicle player) setVariable ["locked",false,true];
			[localize "STR_INTER_UNLOCKVD", "green"] call A3PL_Player_Notification;
			playSound3D ["A3PL_Common\effects\carunlock.ogg", (vehicle player), true, (vehicle player), 3, 1, 30];
		},
		{(vehicle player != player) && {(vehicle player getVariable ["locked",true])}  && (!(player getVariable ["Cuffed",true]) && !(player getVariable ["Zipped",true]))}
	],
	[
		localize "STR_INTER_UNLOCKV",
		{
			player_objintersect setVariable ["locked",false,true];
			[localize "STR_INTER_UNLOCKVD", "green"] call A3PL_Player_Notification;
			playSound3D ["A3PL_Common\effects\carunlock.ogg", player_objintersect, true, player_objintersect, 3, 1, 30];
		},
		{(vehicle player isEqualTo player) && (simulationEnabled player_objintersect) && ((player distance player_objintersect) < 15) && (player_objintersect IN A3PL_Player_Vehicles) && (player_objintersect getVariable ["locked",true])}
	],
	[
		localize "STR_INTER_ATTACHNB",
		{[cursorObject] call A3PL_Vehicle_TrailerAttach;},
		{(((vehicle player) isEqualTo player) && (cursorObject distance player < 5)) && {(simulationEnabled cursorObject)} && {(typeOf cursorObject == "A3PL_Small_Boat_Trailer")}}
	],
	[
		localize "STR_INTER_DETACHBOAT",
		{
			_Boat = ((attachedObjects cursorObject) select 0);
			_Trailer = cursorObject;
			[_Boat] remoteExec ["Server_Vehicle_TrailerDetach", 2];
		},
		{(((vehicle player) isEqualTo player) && (cursorObject distance player < 5))&& (!(((attachedObjects cursorObject) select 0) getVariable ["locked",true]))}
	],
	[
		localize "STR_INTER_DETACHBOAT",
		{
			if (!(cursorObject isKindOf "Ship")) exitwith {};
			[cursorObject] remoteExec ["Server_Vehicle_TrailerDetach", 2];
		},
		{(((vehicle player) isEqualTo player) && (cursorObject distance player < 5)) && ({(typeOf (attachedTo cursorObject)) IN ["A3PL_Boat_Trailer","A3PL_Small_Boat_Trailer"]})&& (!(cursorObject getVariable ["locked",true]))}
	],
	[
		localize "STR_INTER_CLIMBINYACHT",
		{
			private _veh = player_objintersect;
			if (!(_veh isKindOf "A3PL_Yacht")) exitwith {};
			player setpos (_veh modeltoworld [-1,-25,-5]);
		},
		{((vehicle player) isEqualTo player) && (player_objintersect isKindOf "A3PL_Yacht") && ((player distance (player_objintersect modeltoworld [-1,-25,-5])) < 10)}
	],
	[
		localize"STR_INTER_GETINRBM",
		{
			private _veh = cursorObject;
			if (!(_veh isKindOf "A3PL_RBM")) exitwith {};
			player setpos (_veh modeltoworld [0,-4.16406,0]);
		},
		{((vehicle player) isEqualTo player) && (cursorObject isKindOf "A3PL_RBM") && ((cursorObject distance player) < 10)}
	],
	[
		localize"STR_INTER_CLIMBCUTTER",
		{
			private _veh = cursorObject;
			if (!(_veh isKindOf "A3PL_Cutter")) exitwith {};
			player setpos (_veh modeltoworld [0,-32,-11]);
		},
		{((vehicle player) isEqualTo player) && (cursorObject isKindOf "A3PL_Cutter") && (((cursorObject modeltoworld [4,-40,-10]) distance player) < 10)}
	],
	[
		"Climb on LCM",
		{
			private _veh = cursorObject;
			if (!(_veh isKindOf "A3FL_LCM")) exitwith {};
			player setpos (_veh modeltoworld [0,0,0]);
		},
		{((vehicle player) isEqualTo player) && (cursorObject isKindOf "A3FL_LCM") && ((cursorObject distance player) < 10)}
	],
	[
		localize"STR_INTER_GETINCAPT",
		{
			private _veh = cursorObject;
			if (!(_veh isKindOf "A3PL_Cutter") || !(simulationEnabled _veh)) exitwith {};
			player moveInDriver _veh;
		},
		{((vehicle player) isEqualTo player) && (cursorObject isKindOf "A3PL_Cutter") && (player getVariable["job","unemployed"] isEqualTo "uscg") && ((player distance (cursorObject modelToWorld [0,20,-3])) < 4)}
	],

	[
		localize"STR_INTER_GETINPASS",
		{
			private _veh = cursorObject;
			if (!(_veh isKindOf "A3PL_Cutter") || !(simulationEnabled _veh)) exitwith {};
			player moveInCargo _veh;
		},
		{((vehicle player) isEqualTo player) && (cursorObject isKindOf "A3PL_Cutter") && (player getVariable["job","unemployed"] isEqualTo "uscg")  && ((player distance (cursorObject modelToWorld [0,20,-3])) < 4)}
	],
	[
		localize"STR_INTER_GETINGUN",
		{
			private _veh = cursorObject;
			if (!(_veh isKindOf "A3PL_Cutter") || !(simulationEnabled _veh)) exitwith {};
			player moveInCommander _veh;
		},
		{((vehicle player) isEqualTo player) && (cursorObject isKindOf "A3PL_Cutter") && (player getVariable["job","unemployed"] isEqualTo "uscg")  && ((player distance (cursorObject modelToWorld [0,20,-3])) < 4)}
	],
	[
		localize "STR_INTER_INVENTORY",
		{call A3PL_Inventory_Open;},
		{(!isPlayer cursorObject) && (Player_ItemClass isEqualTo "") && ((vehicle player) isEqualTo player) && (!(player getVariable ["Cuffed",true]) && !(player getVariable ["Zipped",true])) && ((animationState player) != "a3pl_takenhostage") && !(underwater(vehicle player))}
	],
	[
		localize "STR_INTER_INVENTORY",
		{
			private _veh = vehicle player;
			if([typeOf(_veh)] call A3PL_Config_HasStorage) then {[_veh] call A3PL_Vehicle_OpenStorage;};
		},
		{((vehicle player) != player) && ([typeOf(vehicle player)] call A3PL_Config_HasStorage) && (!(player getVariable ["Cuffed",true]) && !(player getVariable ["Zipped",true]))}
	],
	[
		localize "STR_NewInventory_24",
		{
			private _veh = player_objintersect;
			if([typeOf(_veh)] call A3PL_Config_HasStorage) then {[_veh] call A3PL_Vehicle_OpenStorage;};
		},
		{((vehicle player) isEqualTo player) && (player distance cursorObject < 5) && {!isNil "player_objintersect"} && {player_objintersect IN A3PL_Player_Vehicles} && {!(player_objintersect getVariable ["locked",false]) && ([typeOf(player_objintersect)] call A3PL_Config_HasStorage)}}
	],
	[
		localize "STR_INTER_CUFFP",
		{
			private _obj = call A3PL_Intersect_cursorObject;
			if (Player_ItemClass isEqualTo "handcuffs") then {
				[_obj] call A3PL_Police_Cuff;
			} else {
				[localize "STR_INTER_CUFFPD", "red"] call A3PL_Player_Notification;
			};
		},
		{((typeOf (call A3PL_Intersect_cursorObject) == "C_man_1") && ((player getVariable "job") IN ["uscg","fisd","fims"]))}
	],
	[
		localize "STR_INTER_UNCUFFP",
		{
			private _obj = call A3PL_Intersect_cursorObject;
			if (Player_ItemClass != "") then {
				[localize "STR_INTER_UNCUFFPD", "red"] call A3PL_Player_Notification;
			} else {
				[_obj] call A3PL_Police_Uncuff;
			};
		},
		{((typeOf (call A3PL_Intersect_cursorObject) == "C_man_1") && ((animationState (call A3PL_Intersect_cursorObject)) IN ["a3pl_handsupkneelcuffed","a3pl_handsupkickeddown"]) && ((player getVariable "job") IN ["uscg","fisd","fims"]))}
	],
	[
		localize "STR_INTER_SURRENDER",
		{[player,true] call A3PL_Police_Surrender;},
		{(!isPlayer cursorObject) && (((animationState player) IN ["amovpercmstpsnonwnondnon","amovpercmrunsnonwnondf","amovpercmrunsnonwnondb"]) && ((vehicle player) isEqualTo player)) && (!(player getVariable ["Cuffed",true]) && !(player getVariable ["Zipped",true]))}
	],
	[
		localize "STR_INTER_ENDSURRENDER",
		{[player,true] call A3PL_Police_Surrender;},
		{((animationState player IN ["a3pl_idletohandsup","a3pl_kneeltohandsup"]) && (vehicle player isEqualTo player))}
	],
	[
		localize "STR_INTER_KNEELDOWN",
		{[player,false] call A3PL_Police_Surrender;},
		{((animationState player IN ["a3pl_idletohandsup","a3pl_kneeltohandsup"]) && (vehicle player isEqualTo player))}
	],
	[
		localize "STR_INTER_STANDUP",
		{[player,true] call A3PL_Police_Surrender;},
		{((animationState player IN ["a3pl_handsuptokneel"]) && (vehicle player isEqualTo player))}
	],
	[
		localize "STR_INTER_STOPDRGING",
		{[cursorObject] call A3PL_Police_Drag;},
		{(cursorObject getVariable["dragged",false]) && ((vehicle player) isEqualTo player) && (isPlayer cursorObject)}
	],
	[
		localize "STR_INTER_DETAINSUSINVEH",
		{
			if (!(player_objintersect isKindOf "Car")) exitwith {};
			[player_objintersect] call A3PL_Police_Detain;
		},
		{((vehicle player) isEqualTo player) && (((player getVariable ["job","unemployed"]) IN ["uscg","fisd","fims"]) && (player_objintersect isKindOf "Car") && (((player distance player_objintersect) < 6)))}
	],
	[
		localize "STR_INTER_EJECTALLP",
		{[player_objintersect] call A3PL_Police_unDetain;},
		{((player getVariable ["job","unemployed"]) IN ["uscg","fisd","fims"]) && ((player_objintersect) isKindOf "Car") && (((player distance player_objintersect) < 6)) && ((vehicle player) isEqualTo player)}
	],
	[
		localize "STR_INTER_EATITEM",
		{call A3PL_Items_Food;},
		{(([Player_ItemClass, 'fnc'] call A3PL_Config_GetItem) isEqualTo 'A3PL_Items_Food') && !(underwater(vehicle player))}
	],
	[
		localize "STR_INTER_DRINKITEM",
		{[] spawn A3PL_Items_Thirst;},
		{(([Player_ItemClass, 'fnc'] call A3PL_Config_GetItem) isEqualTo 'A3PL_Items_Thirst') && !(underwater(vehicle player))}
	],
	[
		localize "STR_INTER_USEDRUGS",
		{[Player_ItemClass,1] call A3PL_Drugs_Use; },
		{(([Player_ItemClass, 'fnc'] call A3PL_Config_GetItem) isEqualTo 'A3PL_Drugs_Use')}
	],
	[
		localize "STR_INTER_PUTITEMB",
		{call A3PL_Inventory_PutBack;},
		{((isNull Player_Item) isEqualTo false) && (!(player_itemClass isEqualTo "ticket"))}
	],
	[
		localize "STR_INTER_DESTROYT",
		{[player_item] call A3PL_Inventory_Clear;},
		{((isNull Player_Item) isEqualTo false) && (player_itemClass isEqualTo "ticket")}
	],
	[
		localize "STR_INTER_WRITET",
		{call A3PL_Police_OpenTicketMenu;},
		{(vehicle player == player) && (isPlayer cursorObject) && ((player getVariable ["job","unemployed"]) IN ["uscg","fisd","fims"]) && (player_itemclass isEqualTo "")}
	],
	[
		localize "STR_INTER_THROWIT",
		{[] spawn A3PL_Inventory_Throw;},
		{((isNull Player_Item) isEqualTo false) && ([Player_ItemClass, 'canDrop'] call A3PL_Config_GetItem)}
	],
	[
		localize "STR_INTER_DROPITEM",
		{[] call A3PL_Inventory_Drop;},
		{([Player_ItemClass, 'canDrop'] call A3PL_Config_GetItem)}
	],
	[
		localize "STR_INTER_EXITMOTORB",
		{
			private _veh = vehicle player;
			_veh lock 1;
			player action ["getOut",_veh];
			_veh lock 2;
		},
		{((vehicle player) isKindOf "Ship")}
	],
	[
		localize "STR_INTER_PASSENGERMB",
		{
			private _veh = cursorObject;
			if (_veh getVariable ["locked",true]) exitwith {[localize "STR_INTER_UNABLEENT","red"] call A3PL_Player_Notification;};
			_veh lock 1;
			player moveInCargo _veh;
			_veh lock 2;
		},
		{(cursorobject isKindOf "Ship") && (player distance cursorObject < 5)}
	],
	[
		localize "STR_INTER_ENTERMB",
		{
			private _veh = cursorObject;
			if (_veh getVariable ["locked",true]) exitwith {[localize "STR_INTER_UNABLEENT","red"] call A3PL_Player_Notification;};
			_veh lock 1;
			player action ["getInDriver", _veh];
			_veh lock 2;
		},
		{(cursorobject isKindOf "Ship") && (player distance cursorObject < 5)}
	],
	[
		localize "STR_INTER_TOGGLESL",
		{
			private _veh = vehicle player;
			if (_veh animationSourcePhase "Spotlight" < 0.5) then {
				_veh animateSource ["Spotlight",1];
				if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOn",_veh];};
			} else {
				_veh animateSource ["Spotlight",0];
				if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOff",_veh];};
			};
		},
		{(typeOf (vehicle player) isEqualTo "A3PL_Jayhawk") && (player isEqualTo ((vehicle player) turretUnit [0]))}
	],
	[
		localize "STR_INTER_TOGGLERB",
		{
			private _veh = vehicle player;
			private _basket = _veh getVariable "basket";
			if (((count (crew _basket)) > 0) && (_veh animationPhase "Basket" > 0.5)) exitwith {[localize "STR_INTER_TOGGLERBD","red"] call A3PL_Player_Notification;};
			if (_basket isEqualTo objNull) then {call A3PL_Create_RescueBasket;};
			if (count ropes _veh > 0) exitwith
			{
				{ropeDestroy _x;} foreach (ropes _veh);
				_basket attachTo [_veh, [0, 999999, 0]];
				_veh animate ["Basket",0];
			};
			[(driver _veh),_veh,_basket] remoteExec ["Server_Vehicle_AtegoHandle", 2];
			detach _basket;
			_veh animate ["Basket",1];
			_basket setpos (_veh modelToWorld [4,2,-1]);
			_rope = ropeCreate [_veh, "rope", _basket, [-0.3, 0.2, 0.25], 3];
		},
		{((typeOf (vehicle player) isEqualTo "A3PL_Jayhawk") && ((player isEqualTo ((vehicle player) turretUnit [0])) OR (player isEqualTo ((vehicle player) turretUnit [1])) OR (player == (driver vehicle player))) && ((speed vehicle player) < 30))}
	],
	[
		localize "STR_INTER_EXITINTOHEIL",
		{
			[] spawn {
				private _veh = vehicle player;
				private _heli = (vehicle player) getVariable ["vehicle",objNull];
				private _crew = crew _heli;
				private _available = true;
				if (isNull _heli) exitwith {["Cannot find the helicopter","red"] call A3PL_Player_Notification;};
				{if ((_heli getCargoIndex _x) isEqualTo 6) exitwith {_available = false;};} foreach (crew _heli);
				if (!_available) exitwith {[localize "STR_INTER_EXITINTOHEILD","red"] call A3PL_Player_Notification;};
				_veh lock 0;
				player action ["GetOut", _veh];
				sleep 1.5;
				_veh lock 0;
				player moveInCargo [_heli, 6];
			};
		},
		{(("A3PL_RescueBasket" isEqualTo (typeOf (vehicle player))))}
	],
	[
		localize "STR_INTER_INCREASERL",
		{
			private _veh = vehicle player;
			if ((typeOf _veh) != "A3PL_Jayhawk") exitwith {};
			if ((count (ropes _veh)) < 1) exitwith {};
			ropeUnwind [(ropes _veh) select 0,2,(ropeLength ((ropes _veh) select 0)) + 15];
		},
		{((typeOf (vehicle player) isEqualTo "A3PL_Jayhawk") && (local vehicle player) && ((player isEqualTo ((vehicle player) turretUnit [0])) OR (player isEqualTo ((vehicle player) turretUnit [1])) OR (player == (driver vehicle player)))) && (vehicle player animationPhase "Basket" > 0.5)}
	],
	[
		localize "STR_INTER_DECREASERL",
		{
			private _veh = vehicle player;
			if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
			if ((count (ropes _veh)) < 1) exitwith {};
			ropeUnwind [(ropes _veh) select 0,2,(ropeLength ((ropes _veh) select 0)) - 15];
		},
		{((typeOf (vehicle player) isEqualTo "A3PL_Jayhawk") && (local vehicle player) && ((player isEqualTo ((vehicle player) turretUnit [0])) OR (player isEqualTo ((vehicle player) turretUnit [1])) OR (player == (driver vehicle player)))) && (vehicle player animationPhase "Basket" > 0.5)}
	],
	[
		localize "STR_INTER_TOGGLEAH",
		{
			private _veh = vehicle player;
			if (isAutoHoverOn _veh) then {
				player action ["autoHoverCancel", _veh];
			} else {
				player action ["autoHover", _veh];
			};
		},
		{(((vehicle player) isKindOf "Helicopter")) && (((player isEqualTo (vehicle player turretUnit [0]))) OR (player isEqualTo (driver vehicle player)))}
	],
	[
		localize "STR_INTER_USETRANS",
		{call A3PL_ATC_Transponder;},
		{(((vehicle player) isKindOf "Air")) && (((player isEqualTo (vehicle player turretUnit [0]))) OR (player isEqualTo (driver vehicle player)))}
	],
	[
		localize "STR_INTER_TOGGLEC",
		{
			private _veh = vehicle player;
			if (!isCopilotEnabled _veh) then {
				_veh enableCopilot true;
				player action ["UnlockVehicleControl", _veh];
			} else {
				_veh enableCopilot false;
				player action ["SuspendVehicleControl", _veh];
				player action ["LockVehicleControl", _veh];
			};
		},
		{(((vehicle player) isKindOf "Air") && (player == (driver (vehicle player))))}
	],
	[
		localize "STR_INTER_TAKEC",
		{player action ["TakeVehicleControl", (vehicle player)];},
		{(((vehicle player) isKindOf "Air") && (player == (vehicle player turretUnit [0]))&& (isCopilotEnabled vehicle player))}
	],
	[
		localize "STR_INTER_RELEASEC",
		{player action ["SuspendVehicleControl", (vehicle player)];},
		{(((vehicle player) isKindOf "Air") && (player == (vehicle player turretUnit [0]))&& (isCopilotEnabled vehicle player))}
	],
	[
		localize "STR_INTER_RESETPLANEV",
		{(vehicle player) setVelocity [0,0,0];},
		{(local (vehicle player)) && ((vehicle player) isKindOf "Plane") && ((speed vehicle player) < 10)}
	],
	[
		localize "STR_INTER_EXITVEH",
		{
			if (((speed vehicle player) < 1) && (vehicle player getVariable ["EngineOn",0] isEqualTo 0)) then {
				player action ["GetOut", (vehicle player)];
				[] spawn {if ((player getVariable ["Cuffed",true]) || {player getVariable ["Zipped",true]}) then {sleep 1.5;player setVelocityModelSpace [0,3,1];[player,"a3pl_handsupkneelcuffed"] remoteExec ["A3PL_Lib_SyncAnim",-2];};};
			} else {
				player action ["eject", (vehicle player)];
				[] spawn {if ((player getVariable ["Cuffed",true]) || {player getVariable ["Zipped",true]}) then {sleep 1.5;player setVelocityModelSpace [0,3,1];[player,"a3pl_handsupkneelcuffed"] remoteExec ["A3PL_Lib_SyncAnim",-2];};};
			};
		},
		{((vehicle player) != player) && (!(vehicle player getVariable ["locked",true])) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])}}
	],
	[
		localize "STR_INTER_PPFOR",
		{
			private _veh = vehicle player;
			private _vel = velocity _veh;
			private _dir = direction _veh;
			private _speed = 5;
			if((_veh getHit "hitengine") == 1) exitWith {["You cannot push an aircraft if the engine is damaged!","red"] call A3PL_Player_Notification;};
			_veh setVelocity [
				(_vel select 0) + (sin _dir * _speed),
				(_vel select 1) + (cos _dir * _speed),
				(_vel select 2)
			];
		},
		{((vehicle player) isKindOf "Plane") && (local (vehicle player))}
	],
	[
		localize "STR_INTER_PBPLANE",
		{
			private _veh = vehicle player;
			private _vel = velocity _veh;
			private _dir = direction _veh;
			private _speed = -5;
			if(_veh getHit "hitengine" == 1) exitWith {["You cannot push an aircraft if the engine is damaged!","red"] call A3PL_Player_Notification;};
			_veh setVelocity [
				(_vel select 0) + (sin _dir * _speed),
				(_vel select 1) + (cos _dir * _speed),
				(_vel select 2)
			];
		},
		{((vehicle player) isKindOf "Plane") && (local (vehicle player))}
	],
	[
		localize "STR_INTER_DEPLOYPAR",
		{player action ["openParachute"];},
		{((backpack player) isKindOf "B_Parachute") && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}
	],
	[
		localize "STR_INTER_SWITCHCON",
		{
			private _veh = vehicle player;
			private _turretPos = call A3PL_Lib_ReturnTurret;
			private _newTurretPos = 0;
			if (_turretPos isEqualTo -1) exitwith {};
			if (_turretPos isEqualTo 0) then { _newTurretPos = 1; };
			_veh lock 0;
			player action ["moveToTurret", _veh, [_newTurretPos]];
			_veh lock 2;
		},
		{(call A3PL_Lib_ReturnTurret IN [0,1]) && (typeOf vehicle player IN ["A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Ladder"]) && !((vehicle player) getVariable ["locked",true])}
	],
	[
		localize "STR_INTER_DEPLOYFH",
		{[35] call A3PL_FD_DeployHose;},
		{player_ItemClass == "FD_Hose"}
	],
	[
		localize "STR_INTER_DROPHOSEA",
		{[([] call A3PL_Lib_AttachedFirst)] call A3PL_FD_DropHose;},
		{(typeof ([] call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2","A3PL_GasHose"]}
	],
	[
		localize "STR_INTER_TRHOWHOSEA",
		{[([] call A3PL_Lib_AttachedFirst)] call A3PL_FD_ThrowHose;},
		{(typeof ([] call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2","A3PL_GasHose"]}
	],
	[
		localize "STR_INTER_PUTMASKON",
		{call A3PL_FD_MaskOn;},
		{(player_itemClass) == "FD_Mask"}
	],
	[
		localize "STR_INTER_PUTMASKOFF",
		{call A3PL_FD_MaskOff;},
		{(goggles player) isEqualTo "A3PL_FD_Mask"}
	],
	[
		localize "STR_INTER_CLEANMASK",
		{call A3PL_FD_SwipeMask;},
		{(goggles player) isEqualTo "A3PL_FD_Mask"}
	],
	[
		localize"STR_INTER_DEPLOYGASHOSE",
		{[50] call A3PL_FD_GasDeployHose;},
		{(player_ItemClass == "FD_Hose") && (player getVariable ["job","unemployed"] isEqualTo "oil")}
	],
	[
		"Dig Sand",
		{[] spawn A3PL_Resources_StartDigging;},
		{currentWeapon player isEqualTo "A3PL_Shovel" && ((vehicle player) isEqualTo player)&& ((surfaceType getpos player) isEqualTo "#cype_beach")}
	],
	[
		localize "STR_INTER_DIGGROUND",
		{[] spawn A3PL_Prison_DigOut;},
		{currentWeapon player isEqualTo "A3PL_Shovel" && ((vehicle player) isEqualTo player) && ((getpos player) inArea "A3PL_Marker_DOC_Escape")}
	],
	[
		localize "STR_INTER_HIGHBEAM",
		{
			private _veh = vehicle player;
			if (_veh animationSourcePhase "High_Beam" < 0.5) then {
				_veh animateSource ["High_Beam",1];
			} else {
				_veh animateSource ["High_Beam",0];
			};
		},
		{(vehicle player) isKindOf "Car" && (driver (vehicle player)) isEqualTo player}
	],
	[
		localize "STR_INTER_CHECKBPMONEY",
		{call A3PL_BHeist_CheckCash;},
		{((backpack player) isEqualTo "A3PL_Backpack_Money") && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}
	],
	[
		localize "STR_INTER_SPAWNSTORAGEB",
		{
			if(!(call A3PL_Player_AntiSpam)) exitWith {};
			private _house = (player getVariable ["house",objNull]);
			[player,_house] remoteExec ["Server_Housing_LoadBox", 2];
		},
		{(player distance (player getVariable ["house",objNull]) < 8) && !(player distance (nearestObject [player, "Box_GEN_Equip_F"]) < 8)}
	],
	[
		localize "STR_INTER_STORESTORAGEB",
		{
			if(!(call A3PL_Player_AntiSpam)) exitWith {};
			private _house = (player getVariable ["house",objNull]);
			private _box = nearestObjects [player, ["Box_GEN_Equip_F"], 10];
			if (count _box < 1) exitwith {[localize "STR_INTER_FINDSTORAGEN","red"] call A3PL_Player_Notification;};
			_box = _box select 0;
			if (_box getVariable ["inuse",false]) exitwith {[localize"STR_NewHousing_2","red"] call A3PL_Player_Notification;};
			[_house,_box] remoteExec ["Server_Housing_SaveBox", 2];
		},
		{(player distance (nearestObject [player, "Box_GEN_Equip_F"]) < 10) && (player distance (player getVariable ["house",objNull]) < 10) }
	],
	[
		localize"STR_INTER_STORAGEWAREHOUSESPAWN",
		{
			if(!(call A3PL_Player_AntiSpam)) exitWith {};
			private _warehouse = (player getVariable ["warehouse",objNull]);
			[player,_warehouse] remoteExec ["Server_Warehouses_LoadBox", 2];
		},
		{(player distance (player getVariable ["warehouse",objNull]) < 10) && !(player distance (nearestObject [player, "Box_GEN_Equip_F"]) < 20)}
	],
	[
		localize"STR_INTER_STORAGEWAREHOUSESTORE",
		{
			if(!(call A3PL_Player_AntiSpam)) exitWith {};
			private _warehouse = (player getVariable ["warehouse",objNull]);
			private _box = nearestObjects [player, ["Box_GEN_Equip_F"], 20];
			if (count _box < 1) exitwith {[localize "STR_INTER_FINDSTORAGEN","red"] call A3PL_Player_Notification;};
			_box = _box select 0;
			if (_box getVariable ["inuse",false]) exitwith {[localize"STR_NewHousing_2","red"] call A3PL_Player_Notification;};
			[_warehouse,_box] remoteExec ["Server_Warehouses_SaveBox", 2];
		},
		{(player distance (player getVariable ["warehouse",objNull]) < 10) && (player distance (nearestObject [player, "Box_GEN_Equip_F"]) < 20)}
	],
	[
		localize "STR_INTER_RENTGH",
		{[cursorObject] call A3PL_JobFarming_BuyGreenhouse;},
		{(typeOf cursorObject == "Land_A3PL_GreenHouse") && {(player distance cursorObject) < 4.3}}
	],
	[
		localize"STR_INTER_ANCHOR",
		{[cursorObject] spawn A3PL_Vehicle_Anchor;},
		{((typeOf cursorObject) IN ["A3PL_Motorboat","A3PL_Motorboat_Rescue","A3PL_Motorboat_Police","A3PL_RHIB","A3PL_Yacht","A3PL_Yacht_Pirate","A3PL_RBM","A3PL_Container_Ship","A3PL_Patrol"]) && ((player distance cursorObject) < 15) && (!(cursorObject getVariable ["locked",true]))&& ((speed cursorObject) < 5)}
	],
	[
		localize"STR_INTER_ANCHOR",
		{[(vehicle player)] spawn A3PL_Vehicle_Anchor;},
		{((typeOf vehicle player) IN ["A3PL_Motorboat","A3PL_Motorboat_Rescue","A3PL_Motorboat_Police","A3PL_RHIB","A3PL_Yacht","A3PL_Yacht_Pirate","A3PL_RBM","A3PL_Container_Ship","A3PL_Patrol"]) && (!(vehicle player getVariable ["locked",true]))&& ((speed vehicle player) < 5)}
	],
	[
		localize"STR_INTER_ATTACHHELI",
		{[cursorObject] call A3PL_Vehicle_SecureHelicopter;},
		{((typeOf cursorObject) isEqualTo "A3PL_Cutter") && {((vehicle player) isEqualTo player) && ((speed vehicle player) < 1) && ((player distance cursorObject) < 15)}}
	],
	[
		"Secure Vehicle",
		{[cursorObject] call A3PL_Vehicle_SecureVehicle;},
		{(vehicle player isEqualTo player) && {((player distance cursorObject) < 10)} && {(count(nearestObjects [player, ["A3FL_LCM"], 20]) > 0)} && {(typeOf cursorObject != "A3FL_LCM")}}
	],
	[
		"Unsecure Vehicle",
		{[cursorObject] call A3PL_Vehicle_UnsecureVehicle;},
		{(vehicle player isEqualTo player) && {((speed vehicle player) < 1)} && {((player distance cursorObject) < 7)} && {(typeOf cursorObject isEqualTo "A3FL_LCM")}}
	],
	[
		localize"STR_INTER_DETACHHELI",
		{[cursorObject] call A3PL_Vehicle_UnsecureHelicopter;},
		{((typeOf cursorObject) IN ["A3PL_Cutter"]) && (vehicle player isEqualTo player) && ((speed vehicle player) < 1) && ((player distance cursorObject) < 15)}
	],
	[
		localize"STR_INTER_ANCHOR",
		{[cursorObject] call A3PL_Vehicle_DisableSimulation;},
		{((typeOf cursorObject) IN ["A3PL_Cutter","A3FL_LCM"]) && ((player distance cursorObject) < 30) && ((speed cursorObject) < 4)}
	],
	[
		localize"STR_INTER_WRIST_ADD",
		{
			cursorObject setVariable ["jail_mark",true,true];
			["Someone put a bracelet on you", "red"] remoteExec ["A3PL_Player_Notification",cursorObject];
			[format["You put a bracelet on %1",cursorObject getVariable["name","unknown"]], "green"] call A3PL_Player_Notification;
		},
		{((vehicle player) isEqualTo player) && (player getVariable["job","unemployed"] isEqualTo "fims") && (isPlayer cursorObject) && !(cursorObject getVariable ["jail_mark",false])}
	],
	[
		localize"STR_INTER_WRIST_REMOVE",
		{
			cursorObject setVariable ["jail_mark",false,true];
			["Someone removed your bracelet on you", "red"] remoteExec ["A3PL_Player_Notification",cursorObject];
			[format["You removed the bracelet from %1",cursorObject getVariable["name","unknown"]], "green"] call A3PL_Player_Notification;
		},
		{((vehicle player) isEqualTo player) && (player getVariable["job","unemployed"] isEqualTo "fims") && (isPlayer cursorObject) && (cursorObject getVariable ["jail_mark",false])}
	],
	[
		localize "STR_INTER_OPCOMPUTER",
		{
			if (isNull (findDisplay 211) && (((vehicle player) animationPhase "Laptop_Top") > 0.5)) then {
				if ((player getVariable ["job","unemployed"]) isEqualTo "fifr") then {
					call A3PL_FD_DatabaseOpen;
				} else {
					call A3PL_Police_DatabaseOpen;
				};
			};
		},
		{((player getVariable["job","unemployed"]) IN ["fisd","uscg","fims","doj","fifr"]) && (typeOf(vehicle player) IN (Config_Police_Vehs - ["A3PL_P362_TowTruck","A3PL_F150_Marker"]))}
	],
	[
		localize "STR_INTER_RESETLOCKF",
		{
			private _veh = vehicle player;
			if (player isEqualTo (driver _veh)) then {
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
		},
		{(typeOf (vehicle player) IN ["A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_CVPI_PD_Slicktop","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_CVPI_PD","A3PL_Raptor_PD","A3PL_Raptor_PD_ST","A3PL_Taurus_PD","A3PL_Taurus_PD_ST","A3PL_Charger15_PD","A3PL_Charger15_PD_ST","A3PL_Silverado_PD","A3PL_Silverado_PD_ST"])}
	],
	[
		localize "STR_INTER_CHECKALCOHOL",
		{[cursorObject] call A3PL_Police_Breathalizer;},
		{(player_ItemClass isEqualTo "breathalizer") && {isPlayer cursorObject}}
	],
	[
		localize "STR_INTER_CHECKDRUGS",
		{[cursorObject] call A3PL_Drugs_DrugTest;},
		{(player_ItemClass isEqualTo "drug_kit") && {isPlayer cursorObject}}
	],
	[
		localize"STR_INTER_LCPSEIZURE",
		{[cursorObject] spawn A3PL_Robberies_PickSeizure;},
		{(player_ItemClass isEqualTo "v_lockpick") && (cursorObject isEqualTo A3FL_Seize_Storage)}
	],
	[
		localize"STR_INTER_STORAGESECURE",
		{
			cursorObject setVariable["locked",true,true];
			_name = player getVariable["name","unknown"];
			_fims= ["fims"] call A3PL_Lib_FactionPlayers;
			[format["%1 has secured the seizure storage",_name],"blue"] remoteExec ["A3PL_Player_Notification",_fims];
		},
		{!(cursorObject getVariable["locked",true]) && (cursorObject isEqualTo A3FL_Seize_Storage) && ((player getVariable["faction","citizen"]) isEqualTo "fims")}
	],
	[
		localize"STR_INTER_DOGSDEBUG",
		{
			private _dog = player getVariable["Player_Dog",objNull];
			if(isNull _dog) exitWith {};
			_dog setPos (getPos player);
		},
		{!(isNull(player getVariable["Player_Dog",objNull]))}
	],
	[
		localize"STR_INTER_DOGFOLLOW",
		{
			private _dog = player getVariable["Player_Dog",objNull];
			if(isNull _dog) exitWith {};
			_dog setVariable["Dog_Moving",true,true];
		},
		{!(isNull(player getVariable["Player_Dog",objNull]))}
	],
	[
		localize"STR_INTER_DOGSTOPFOLLOW",
		{
			private _dog = player getVariable["Player_Dog",objNull];
			if(isNull _dog) exitWith {};
			_dog setVariable["Dog_Moving",false,true];
		},
		{!(isNull(player getVariable["Player_Dog",objNull]))}
	],

	[
		"Open Company Shop",
		{call A3PL_Company_OpenShop;},
		{((typeOf cursorObject) isKindOf "House") && {!isNil {cursorObject getVariable["cid",nil]}}}
	],
	[
		"Shop Management",
		{call A3PL_Company_OpenShopStock;},
		{((typeOf cursorObject) isKindOf "House") && {([getPlayerUID player] call A3PL_Config_GetCompanyID) isEqualTo (cursorObject getVariable["cid",-1])}}
	],

	[
		"Open Door",
		{(vehicle player) animateDoor["Door_LB2",1];},
		{((typeOf (vehicle player)) isEqualTo "A3FL_AS_365") && {(player isEqualTo ((vehicle player) turretUnit [2]))}  && {((vehicle player) animationSourcePhase "Door_LB2") isEqualTo 0}}
	],
	[
		"Close Door",
		{(vehicle player) animateDoor["Door_LB2",0];},
		{((typeOf (vehicle player)) isEqualTo "A3FL_AS_365") && {(player isEqualTo ((vehicle player) turretUnit [2]))}  && {((vehicle player) animationSourcePhase "Door_LB2") isEqualTo 1}}
	],
	[
		"Open Door",
		{(vehicle player) animateDoor["Door_RB2",1];},
		{((typeOf (vehicle player)) isEqualTo "A3FL_AS_365") && {(player isEqualTo ((vehicle player) turretUnit [1]))} && {((vehicle player) animationSourcePhase "Door_RB2") isEqualTo 0}}
	],
	[
		"Close Door",
		{(vehicle player) animateDoor["Door_RB2",0];},
		{((typeOf (vehicle player)) isEqualTo "A3FL_AS_365") && {(player isEqualTo ((vehicle player) turretUnit [1]))} && {((vehicle player) animationSourcePhase "Door_RB2") isEqualTo 1}}
	],

	[
		"Stop Towing",
		{[player_objintersect] call A3PL_USCG_UntowBoat;},
		{((typeOf player_objintersect) isEqualTo "A3PL_RBM") && {(player getVariable["job","unemployed"]) isEqualTo "uscg"} && {(player_objintersect getVariable ["towing",false])}}
	],
	[
		"Prepare Towing",
		{
			player_objintersect spawn {
				A3FL_BoatTow = _this;
				["RBM is ready for towing!","green"] call A3PL_Player_Notification;
				sleep 300;
				A3FL_BoatTow = nil;
				["Boat towing cancelled.","red"] call A3PL_Player_Notification;
			};
		},
		{((typeOf player_objintersect) isEqualTo "A3PL_RBM") && {(player getVariable["job","unemployed"]) isEqualTo "uscg"} && {!(player_objintersect getVariable ["towing",false])}}
	],
	[
		"Tow Boat",
		{[A3FL_BoatTow,player_objintersect] call A3PL_USCG_TowBoat;},
		{((typeOf player_objintersect) IN ["A3PL_RBM"]) && {(player getVariable["job","unemployed"]) isEqualTo "uscg"} && {!isNil {A3FL_BoatTow}}}
	],

	[
		"Toggle Garage",
		{
			private _cursorObject = cursorObject;

			switch (typeOf _cursorObject) do {
				case "Land_A3FL_Warehouse": {
					private _distanceLeft = player distance2D (_cursorObject modelToWorldVisual (_cursorObject selectionPosition ["door_1", "Memory"]));
					private _distanceRight = player distance2D (_cursorObject modelToWorldVisual (_cursorObject selectionPosition ["door_5", "Memory"]));
					
					if (_distanceRight > _distanceLeft) then {
						[_cursorObject, "door_1", false] call A3PL_Lib_ToggleAnimation;
						[_cursorObject, "door_2", false] call A3PL_Lib_ToggleAnimation;
					} else {
						[_cursorObject, "door_5", false] call A3PL_Lib_ToggleAnimation;
						[_cursorObject, "door_6", false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case "Land_John_Hangar": {
					[_cursorObject, "hangardoor"] call A3PL_Lib_ToggleAnimation;
				};

				default {
					[_cursorObject, "garagedoor"] call A3PL_Lib_ToggleAnimation;
				};
			};
		},
		{((typeOf cursorObject) isKindOf "House") && ((cursorObject getVariable ["unlocked", false]) || ((getPlayerUID player) in (cursorObject getVariable ["owner", []]))) && ((player distance cursorObject) < 20) && ((typeof (call A3PL_Intersect_cursorTarget)) in ["Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_Home4w_DED_Home4w_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home6b_DED_Home6b_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_John_Hangar","Land_A3FL_Warehouse"])}
	]
];
publicVariable "A3PL_Interaction_Options";