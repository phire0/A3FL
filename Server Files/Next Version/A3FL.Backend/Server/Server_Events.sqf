/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/
//deleteMarker "Server_Events_ShipWreck"; Server_Events_Current = nil; call Server_Events_Random
["Server_Events_Random",
{
	private _allEvents = [
		Server_Events_ShipWreck,
		Server_Events_PlaneCrash
	];
	if(!isNil "Server_Events_Current") exitWith {};

	[] spawn (selectRandom _allEvents);
},true] call Server_Setup_Compile;

["Server_Events_Start",
{
	private _eventName = param[0,""];
	Server_Events_Current = _eventName;
},true] call Server_Setup_Compile;

["Server_Events_End",
{
	Server_Events_Current = nil;
},true] call Server_Setup_Compile;

["Server_Events_ShipWreck",
{
	["Ship Wreck"] call Server_Events_Start;
	["ALERT! ALERT! A shipwreck has been detected in the waters of Fishers Island! Go and try to recover it's content!","yellow"] remoteExec ["A3PL_Player_Notification", -2];
	private _eventDuration = 30*60;
	private _wreckArray = ["Land_Boat_06_wreck_F","Land_Wreck_Traw2_F","Land_Wreck_Traw_F","Land_UWreck_FishingBoat_F"];
	private _propsArray = ["Land_Sack_F","Land_BarrelTrash_F","Land_Sacks_goods_F","Land_CratesWooden_F","Land_Cages_F","Land_GarbagePallet_F","Land_GarbageBarrel_01_F","Land_Pallets_F","Land_Garbage_square5_F","Land_CratesShabby_F","Land_CanisterPlastic_F","Land_Garbage_line_F","Land_WoodenBox_F","Land_Sacks_heap_F","Land_PaperBox_closed_F","Land_GarbageBags_F","Land_Pallets_F","Land_GarbageBags_F"];
	private _lootArray = ["diamond"];
	private _posArray = [[11641.9,11825.5,0],[7551.55,10823.9,0],[506.756,9011.15,0],[1277.59,3179.49,0],[6526.55,4337.69,0],[9980.81,7063.11,0],[10721.6,3939.42,0],[6533.32,7144.09,0]] call BIS_fnc_selectRandom;
	private _eventObjects = [];

	private _marker = createMarker ["Server_Events_ShipWreck", _posArray];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "A3PL_Markers_USCG";
	_marker setMarkerText " SHIP WRECK LOCATED";
	_marker setMarkerColor "ColorWhite";

	private _wreck = (_wreckArray call BIS_fnc_selectRandom) createVehicle _posArray;
	_wreck allowDamage false;
	_wreck setDir (random 359);
	_eventObjects pushBack _wreck;

	private _boxPos = [(_posArray select 0) - random 15,(_posArray select 1) + random 10,_posArray select 2];
	private _itemBox = "B_supplyCrate_F" createVehicle _boxPos;
	_itemBox setVariable["locked",false,true];
	_itemBox allowDamage false;
    _itemBox setDir (90);
    _eventObjects pushBack _itemBox;

	private _object1 = (_propsArray call BIS_fnc_selectRandom) createVehicle ([getPosATL _wreck, 5, 20, 2, 0, 100, 0] call BIS_fnc_findSafePos);
	_object1 setDir (random 359);
	_eventObjects pushBack _object1;

	private _object2 = (_propsArray call BIS_fnc_selectRandom) createVehicle ([getPosATL _wreck, 5, 20, 2, 0, 100, 0] call BIS_fnc_findSafePos);
	_object2 setDir (random 359);
	_eventObjects pushBack _object2;

	private _object3 = (_propsArray call BIS_fnc_selectRandom) createVehicle ([getPosATL _wreck, 5, 20, 2, 0, 100, 0] call BIS_fnc_findSafePos);
	_object3 setDir (random 359);
	_eventObjects pushBack _object3;

	private _object4 = (_propsArray call BIS_fnc_selectRandom) createVehicle ([getPosATL _wreck, 5, 20, 2, 0, 100, 0] call BIS_fnc_findSafePos);
	_object4 setDir (random 359);
	_eventObjects pushBack _object4;

	private _object5 = (_propsArray call BIS_fnc_selectRandom) createVehicle ([getPosATL _wreck, 5, 20, 2, 0, 100, 0] call BIS_fnc_findSafePos);
	_object5 setDir (random 359);
	_eventObjects pushBack _object5;

	clearItemCargoGlobal _itemBox;
	clearMagazineCargoGlobal _itemBox;
	clearWeaponCargoGlobal _itemBox;
	clearBackpackCargoGlobal _itemBox;

	private _physicalItems = [];
   	private _virtualItems = [];

	_commonItems = [];
	_valuableItems = [];
	_rareItems = [];
	_magReward = [];
	_weaponReward = [];
	_rareMagReward = [];
	_rareWeaponReward = [];

	_valueableChance = random 100;
	if(_valueableChance >= 50) then {_virtualItems pushBack selectRandom _valuableItems;};

	_rareChance = random 100;
	if(_rareChance >= 70) then {_virtualItems pushBack selectRandom _rareItems;};

	_magChance = random 100;
	if(_magChance >= 50) then {_physicalItems pushBack selectRandom _magReward;};

	_weaponReward = random 100;
	if(_weaponReward >= 75) then {_physicalItems pushBack selectRandom _weaponReward;};

	_rareMagChance = random 100;
	if(_rareMagChance >= 50) then {_physicalItems pushBack selectRandom _rareMagReward;};

	_rareWeaponReward = random 100;
	if(_rareWeaponReward >= 75) then {_physicalItems pushBack selectRandom _rareWeaponReward;};

	_virtualItems pushBack selectRandom _commonItems;

	_itemBox setVariable["storage",_virtualItems,true];
	{_itemBox addItemCargoGlobal _x} foreach _physicalItems;

    sleep _eventDuration;

	{deleteVehicle _x;} forEach _eventObjects;
	deleteMarker _marker;
	call Server_Events_End;
	["The shipwreck has been recovered!","yellow"] remoteExec ["A3PL_Player_Notification", -2];
},true] call Server_Setup_Compile;

["Server_Events_PlaneCrash",
{
	["Plane Crash"] call Server_Events_Start;
	["ALERT! ALERT! A plane is having engines issues !","yellow"] remoteExec ["A3PL_Player_Notification", -2];
	private _eventDuration = 30*60;
	private _posArray = [[8130.25,6353.81,130]];

	private _plane = createVehicle ["C_Plane_Civil_01_F", (_posArray call BIS_fnc_selectRandom), [], 0, "CAN_COLLIDE"];
	_plane setDir (260);
	private _vel = velocity _plane;
	private _dir = direction _plane;
	private _speed = 100;
	_plane setVelocity [(_vel select 0) + (sin _dir * _speed),(_vel select 1) + (cos _dir * _speed),(_vel select 2)];

	private _group = createGroup [civilian, true];
	private _pilot = _group createUnit ["C_Nikos_aged", [0,0,0], [], 0, "CAN_COLLIDE"];
	_pilot setskill 1;
	_pilot moveInDriver _plane;

	sleep 5;
	_plane setDamage 0.85;
	_plane setHitPointDamage["hitEngine", 1];
	private _source2 = createVehicle ["#particleSource",getposATL _plane, [], 0, "CAN_COLLIDE"];
	_source2 setparticleclass "BigDestructionSmoke";
	_source2 attachTo [_plane,[0,0,0]];

	waitUntil{!alive _pilot};

	private _crashPos = getPosATL _plane;
	deleteVehicle _pilot;
	deleteVehicle _plane;
	deleteVehicle _source2;

	private _planeWreck = createVehicle ["Land_HistoricalPlaneWreck_01_F", _crashPos, [], 0, "CAN_COLLIDE"];
	private _boxPos = [(_crashPos select 0) - random 15,(_crashPos select 1) + random 10,_crashPos select 2];
	private _itemBox = "B_supplyCrate_F" createVehicle _boxPos;
	_itemBox setVariable["locked",false,true];
	_itemBox allowDamage false;
    _itemBox setDir (90);

    private _fifr = ["fifr"] call A3PL_Lib_FactionPlayers;
    if((count _fifr) >= 5) then {
    	private _onWater = !(_position isFlatEmpty [-1, -1, -1, -1, 2, false] isEqualTo []);
		if(_onWater || ((_position select 3) < 0)) exitWith {};
		private _marker = createMarker [format ["vehiclefire_%1",random 4000], position (_planeWreck)];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "A3PL_Markers_FIFD";
		_marker setMarkerText " PLANE CRASH FIRE";
		_marker setMarkerColor "ColorWhite";
		[localize"STR_SERVER_FIRE_VEHICLEFIREREPORT","red","fifr",3] call A3PL_Lib_JobMessage;
		["A3PL_Common\effects\firecall.ogg",150,2,10] spawn A3PL_FD_FireStationAlarm;
		[getposATL (_planeWreck)] spawn Server_Fire_StartFire;
    };

    clearItemCargoGlobal _itemBox;
	clearMagazineCargoGlobal _itemBox;
	clearWeaponCargoGlobal _itemBox;
	clearBackpackCargoGlobal _itemBox;
   
	private _physicalItems = [];
   	private _virtualItems = [];

	_commonItems = [["weed_100g",3],["shrooms",10],["cocaine",3]];
	_valuableItems = [["zipties",3],["v_lockpick",4],["keycard",1]];
	_rareItems = [["golden_dildo",1]];
	_magReward = [["10Rnd_9x21_Mag",3],["A3PL_Red_Glock_Mag",3],["A3PL_P226_Mag",3],["16Rnd_9x21_green_Mag",3],["16Rnd_9x21_yellow_Mag",3],["6Rnd_45ACP_Cylinder",3],["11Rnd_45ACP_Mag",3]];
	_weaponReward = [["hgun_Pistol_01_F",1],["hgun_Pistol_heavy_02_F",1],["hgun_Pistol_01_F",1],["hgun_Rook40_F",1],["hgun_P07_F",1],["A3PL_Red_Glock",1],["A3PL_P226",1]];
	_rareMagReward = [["A3PL_M16_Mag",2],["30Rnd_762x39_Mag_F",2],["30Rnd_9x21_Mag_SMG_02",2],["30Rnd_45ACP_Mag_SMG_01",2]];
	_rareWeaponReward = [["SMG_05_F",1],["SMG_02_F",1],["SMG_01_F",1],["A3PL_M16",1],["arifle_AKM_F",1]];

	_valueableChance = random 100;
	if(_valueableChance >= 25) then {_virtualItems pushBack selectRandom _valuableItems;};

	_rareChance = random 100;
	if(_rareChance >= 70) then {_virtualItems pushBack selectRandom _rareItems;};

	_magChance = random 100;
	if(_magChance >= 25) then {_physicalItems pushBack selectRandom _magReward;};

	_weaponReward = random 100;
	if(_weaponReward >= 45) then {_physicalItems pushBack selectRandom _weaponReward;};

	_rareMagChance = random 100;
	if(_rareMagChance >= 50) then {_physicalItems pushBack selectRandom _rareMagReward;};

	_rareWeaponReward = random 100;
	if(_rareWeaponReward >= 75) then {_physicalItems pushBack selectRandom _rareWeaponReward;};

	_virtualItems pushback selectRandom _commonItems;

	_itemBox setVariable["storage",_virtualItems,true];
	{_itemBox addItemCargoGlobal _x} foreach _physicalItems;

    sleep _eventDuration;
    deleteVehicle _planeWreck;
    deleteVehicle _itemBox;
	deleteMarker _marker;
	call Server_Events_End;
	["The plane wreck has been recovered!","yellow"] remoteExec ["A3PL_Player_Notification", -2];
},true] call Server_Setup_Compile;