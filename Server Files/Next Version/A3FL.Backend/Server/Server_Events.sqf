/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Events_Random",
{
	private _allEvents = [
		[Server_Events_ShipWreck,{true}],
		[Server_Events_PlaneCrash,{true}]
	];
	if(!isNil "Server_Events_Current") exitWith {};

	_selected = selectRandom _allEvents;
	while {!(call (_selected select 1))} do {
		_selected = selectRandom _allEvents;
	};
	[] spawn (_selected select 0);
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
	private _eventDuration = 15*60;
	private _wreckArray = ["Land_Boat_06_wreck_F","Land_Wreck_Traw2_F","Land_Wreck_Traw_F","Land_UWreck_FishingBoat_F"];
	private _propsArray = ["Land_Sack_F","Land_BarrelTrash_F","Land_Sacks_goods_F","Land_CratesWooden_F","Land_Cages_F","Land_GarbagePallet_F","Land_GarbageBarrel_01_F","Land_Pallets_F","Land_Garbage_square5_F","Land_CratesShabby_F","Land_CanisterPlastic_F","Land_Garbage_line_F","Land_WoodenBox_F","Land_Sacks_heap_F","Land_PaperBox_closed_F","Land_GarbageBags_F","Land_Pallets_F","Land_GarbageBags_F"];
	private _lootArray = ["diamond"];
	private _posArray = [[11641.9,11825.5,0],[7551.55,10823.9,0],[506.756,9011.15,0],[1277.59,3179.49,0],[6526.55,4337.69,0],[9980.81,7063.11,0],[10721.6,3939.42,0],[6533.32,7144.09,0]] call BIS_fnc_selectRandom;
	private _eventObjects = [];

	private _marker = createMarker ["Server_Events_ShipWreck", _posArray];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "A3PL_Markers_USCG";
	_marker setMarkerColor "ColorWhite";

	private _wreck = (_wreckArray call BIS_fnc_selectRandom) createVehicle _posArray;
	_wreck allowDamage false;
	_wreck setDir (random 359);
	_eventObjects pushBack _wreck;

	private _boxPos = [(_posArray select 0) - random 15,(_posArray select 1) + random 10,_posArray select 2];
	private _itemBox = "B_supplyCrate_F" createVehicle _boxPos;
	_itemBox setVariable["locked",false,true];
	_itemBox setVariable["capacity",100000,true];
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

	private _commonItems = [];
	private _rareItems = [];
	private _virtualItems = [];
	private _uscgCount = 1 + count(["uscg"] call A3PL_Lib_FactionPlayers);
	private _commonCount = 4 + round(_uscgCount / 2);
	private _rareCount = 2 + round(_uscgCount / 2);
	private _wreckMessage = "Fuckin moron";
	private _wreckType = floor(random 4);
	switch(_wreckType) do {
		case(0): {
			_wreckMessage = "SOS! SOS! A Drug Shipment has crashed and it's wreckage was spotted in the waters of Fishers Island! Go and collect the drugs before LEOs seize them!";
			_marker setMarkerText "Drug Ship Wreck Located";
			_commonItems = [["seed_marijuana",10],["seed_coca",10],["coca",10],["jug",3],["yeast",10],["malt",10],["cornmeal",10],["sulphuric_acid",10],["calcium_carbonate",10],["potassium_permangate",10],["ammonium_hydroxide",10],["acetone",10],["hydrocloric_acid",10],["kerosene_jerrycan",3]];
			_rareItems = [["coca_paste",10],["cocaine_base",10],["cocaine_hydrochloride",10],["jug_moonshine",5],["weed_100g",3],["weed_75g",4],["weed_50g",6]];
		};
		case(1): {
			_wreckMessage = "SOS! SOS! A Stolen Treasures Shipment has crashed and it's wreckage was spotted in the waters of Fishers Island! Go and collect the treasure before LEOs seize them!";
			_marker setMarkerText "Stolen Treasures Ship Wreck Located";
			_commonItems = [["crown",1],["ring",2],["ringset",2],["bracelet",2],["necklace",1],["golden_dildo",1]];
			_rareItems = [["diamond_ill",1],["diamond_emerald_ill",1],["diamond_ruby_ill",1],["diamond_sapphire_ill",1],["diamond_alex_ill",1],["diamond_aqua_ill",1],["diamond_tourmaline_ill",1]];
			_commonCount = 3 + round(_uscgCount / 2);
			_rareCount = 1 + round(_uscgCount / 2);
		};
		case(2): {
			_wreckMessage = "SOS! SOS! A Supplies Shipment has crashed and it's wreckage was spotted in the waters of Fishers Island! Go and collect the supplies before someone else gets there first!";
			_marker setMarkerText "Supplies Ship Wreck Located";
			_commonItems = [["jerrycan_empty",2],["jerrycan",1],["repairwrench",1],["coffee_cup_small",4],["coffee_cup_medium",3],["coffee_cup_large",2],["taco_cooked",3],["burger_full_cooked",3]];
			_rareItems = [["jerrycan",3],["repairwrench",10],["popcornbucket",1],["pizzabites",10],["soupcup",10],["cookies",10],["cereal",10],["meatpie",4],["coke",5]];
			_commonCount = 8 + round(_uscgCount / 2);
			_rareCount = 3 + round(_uscgCount / 2);
		};
		case(3): {
			_wreckMessage = "SOS! SOS! A Resource Shipment has crashed and it's wreckage was spotted in the waters of Fishers Island! Go and collect the resources before someone else gets there first!";
			_marker setMarkerText "Resource Ship Wreck Located";
			_commonItems = [["Aluminium_Ore",20],["Iron_Ore",20],["Coal_Ore",20],["Titanium_Ingot",1],["Aluminium_Ingot",5],["Iron_Ingot",5],["Coal_Ingot",5]];
			_rareItems = [["Aluminium_Ingot",10],["Iron_Ingot",10],["Coal_Ingot",10],["Titanium_Ingot",5],["Steel",15],["Aluminium",15],["Titanium",5]];
			_commonCount = 6 + round(_uscgCount / 2);
			_rareCount = 3 + round(_uscgCount / 2);
		};
	};

	for "_i" from 0 to _commonCount do {
		_item = selectRandom _commonItems;
		_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
	};

	for "_i" from 0 to _rareCount do {
		_item = selectRandom _rareItems;
		_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
	};

	_itemBox setVariable["storage",_virtualItems,true];

	[_wreckMessage,"yellow"] remoteExec ["A3PL_Player_Notification", -2];

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
	private _eventDuration = 15*60;
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

	private _marker = createMarker ["planecrash", position (_plane)];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "A3PL_Markers_Plane";
	_marker setMarkerText "PLANE IN DISTRESS";
	_marker setMarkerColor "ColorWhite";

	while{alive _pilot} do {
		_marker setMarkerPos (position _plane);
		sleep 2;
	};

	deleteVehicle _pilot;
	_crashPos = getPos _plane;
	private _planeWreck = createVehicle ["Land_HistoricalPlaneWreck_01_F", _plane, [], 0, "CAN_COLLIDE"];
	private _onWater = !(_crashPos isFlatEmpty [-1, -1, -1, -1, 2, false] isEqualTo []);
	private _boxPos = [(_crashPos select 0) - random 15,(_crashPos select 1) + random 10,_crashPos select 2];
	private _itemBox = "B_supplyCrate_F" createVehicle _boxPos;
	_itemBox setVariable["locked",false,true];
	_itemBox setVariable["capacity",100000,true];
	_itemBox allowDamage false;
    _itemBox setDir (90);
	deleteVehicle _plane;
	
	private _fifr = ["fifr"] call A3PL_Lib_FactionPlayers;
	if((count _fifr) >= 5) then {
		if(_onWater || ((_position select 3) < 0)) exitWith {};
		_marker setMarkerType "A3PL_Markers_FIFD";
		[localize"STR_SERVER_FIRE_VEHICLEFIREREPORT","red","fifr",3] call A3PL_Lib_JobMessage;
		["A3PL_Common\effects\firecall.ogg",150,2,10] spawn A3PL_FD_FireStationAlarm;
		[getposATL (_planeWreck)] spawn Server_Fire_StartFire;
    };

	private _leoCount = 1 + count(["uscg"] call A3PL_Lib_FactionPlayers) + count(["fisd"] call A3PL_Lib_FactionPlayers);
	private _commonCount = 4 + (floor(_leoCount / 2));
	private _rareCount = 2 + (floor(_leoCount / 2));
	private _weaponCount = 1 + (floor(_leoCount / 3));
	private _rareWeaponCount = 0 + (floor(_leoCount / 5));
	private _wreckMessage = "Fuckin moron";
	private _alertMessage = "Reeee";
	private _virtualItems = [];
	private _physicalItems = [];
	private _weapons = [];
	private _mags = [];
	private _rareWeapons = [];
	private _rareMags = [];
	private _commonItems = [];
	private _rareItems = [];

	if (_onWater) then {
		private _wreckType = floor (random 3);
		switch(_wreckType) do {
			case(0): {
				_alertMessage = "ALERT! ALERT! The plane carrying Drugs has crashed on water! Collect the Drugs before LEOs seize them!";
				_wreckMessage = "DRUGS PLANE CRASH";
				_commonItems = [["seed_marijuana",10],["seed_coca",10],["coca",10],["jug",3],["yeast",10],["malt",10],["cornmeal",10],["sulphuric_acid",10],["calcium_carbonate",10],["potassium_permangate",10],["ammonium_hydroxide",10],["acetone",10],["hydrocloric_acid",10],["kerosene_jerrycan",3]];
				_rareItems = [["coca_paste",10],["cocaine_base",10],["cocaine_hydrochloride",10],["jug_moonshine",5],["weed_100g",3],["weed_75g",4],["weed_50g",6]];

				for "_i" from 0 to _commonCount do {
					_item = selectRandom _commonItems;
					_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
				};

				for "_i" from 0 to _rareCount do {
					_item = selectRandom _rareItems;
					_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
				};
			};
			case(1): {
				_alertMessage = "ALERT! ALERT! The plane carrying Resources has crashed on water! Collect the Resrources before anyone else does!";
				_wreckMessage = "RESOURCES PLANE CRASH";
				_commonItems = [["Aluminium_Ore",20],["Iron_Ore",20],["Coal_Ore",20],["Titanium_Ingot",1],["Aluminium_Ingot",5],["Iron_Ingot",5],["Coal_Ingot",5]];
				_rareItems = [["Aluminium_Ingot",10],["Iron_Ingot",10],["Coal_Ingot",10],["Titanium_Ingot",5],["Steel",15],["Aluminium",15],["Titanium",5]];
				_commonCount = 6 + round(_uscgCount / 2);
				_rareCount = 3 + round(_uscgCount / 2);

				for "_i" from 0 to _commonCount do {
					_item = selectRandom _commonItems;
					_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
				};

				for "_i" from 0 to _rareCount do {
					_item = selectRandom _rareItems;
					_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
				};
			};
			case(2): {
				_alertMessage = "ALERT! ALERT! The plane carrying Treasure has crashed on water! Collect the Treasure before anyone else does!";
				_wreckMessage = "TREASURE PLANE CRASH";
				_commonItems = [["diamond_tourmaline",1],["diamond_aqua",1],["diamond_alex",1],["diamond_sapphire",1],["diamond_ruby",1],["diamond_emerald",1],["diamond",1]];
				_rareItems = [["diamond_tourmaline",4],["diamond_aqua",4],["diamond_alex",4],["diamond_sapphire",4],["diamond_ruby",4],["diamond_emerald",4],["diamond",4],["dildo",1]];

				for "_i" from 0 to _commonCount do {
					_item = selectRandom _commonItems;
					_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
				};

				for "_i" from 0 to _rareCount do {
					_item = selectRandom _rareItems;
					_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
				};
			};
		};
	} else {
		private _wreckType = floor (random 3);
		switch(_wreckType) do {
			case(0): {
				_alertMessage = "ALERT! ALERT! The plane carrying Weapons has crashed on land! Collect the Weapons before LEOs seize them!";
				_wreckMessage = "WEAPONS PLANE CRASH";
				_weapons = [["hgun_P07_blk_F",1],["hgun_Pistol_heavy_01_F",1],["hgun_Pistol_01_F",1],["hgun_Rook40_F",1],["hgun_Pistol_heavy_02_F",1],["A3PL_P226",1],["A3FL_P227",1],["A3FL_Beretta92",1],["A3FL_DesertEagle",1],["A3FL_Glock17",1]];
				_mags = [["16Rnd_9x21_Mag",4],["11Rnd_45ACP_Mag",4],["10Rnd_9x21_Mag",4],["16Rnd_9x21_Mag",4],["6Rnd_45ACP_Cylinder",4],["A3PL_P226_Mag",4],["A3FL_P227_Mag",4],["A3FL_Beretta92_Mag",4],["A3FL_DesertEagle_Mag",4],["A3FL_Glock17_Mag",4]];
				_rareWeapons = [["SMG_01_F",1],["SMG_02_F",1],["SMG_05_F",1],["A3FL_Mossberg_590k",1],["arifle_AKM_F",1],["A3PL_M16",1],["A3FL_Glock18",1]];
				_rareMags = [["30Rnd_45ACP_Mag_SMG_01",2],["30Rnd_9x21_Mag_SMG_02",2],["30Rnd_9x21_Mag_SMG_02",2],["A3FL_Mossberg_590k_8Rnd_buck",2],["30Rnd_762x39_Mag_F",2],["A3PL_M16_Mag",2],["A3FL_Glock18_Mag",2]];

				for "_i" from 0 to _weaponCount do {
					_weaponChance = floor (random 9);
					_gun = _weapons select _weaponChance;
					_physicalItems pushBack _gun;
					_mag = _mags select _weaponChance;
					_physicalItems pushBack _mag;
				};
				for "_i" from 0 to _rareWeaponCount do {
					_rareWeaponChance = floor (random 6);
					_gun = _rareWeapons select _rareWeaponChance;
					_physicalItems pushBack _gun;
					_mag = _rareMags select _rareWeaponChance;
					_physicalItems pushBack _mag;
				};
			};
			case(1): {
				_alertMessage = "ALERT! ALERT! The plane carrying Contraband has crashed on land! Collect the Contraband before LEOs seize them!";
				_wreckMessage = "CONTRABAND PLANE CRASH";
				_physicalItems = [["A3FL_Backpack_Money",2],["A3FL_Backpack_Drill",1]];
				_commonItems = [["zipties",1],["keycard",1],["v_lockpick",1],["cash",1000]];
				_rareItems = [["drill_bit",1],["cash",5000],["dildo",1],["golden_dildo",1]];

				for "_i" from 0 to _commonCount do {
					_item = selectRandom _commonItems;
					_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
				};

				for "_i" from 0 to _rareCount do {
					_item = selectRandom _rareItems;
					_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
				};

			};
			case(2): {
				_alertMessage = "ALERT! ALERT! The plane carrying Resources has crashed on land! Collect the Resrources before anyone else does!";
				_wreckMessage = "RESOURCES PLANE CRASH";
				_commonItems = [["Aluminium_Ore",20],["Iron_Ore",20],["Coal_Ore",20],["Titanium_Ingot",1],["Aluminium_Ingot",5],["Iron_Ingot",5],["Coal_Ingot",5]];
				_rareItems = [["Aluminium_Ingot",10],["Iron_Ingot",10],["Coal_Ingot",10],["Titanium_Ingot",5],["Steel",15],["Aluminium",15],["Titanium",5]];
				_commonCount = 6 + round(_uscgCount / 2);
				_rareCount = 3 + round(_uscgCount / 2);

				for "_i" from 0 to _commonCount do {
					_item = selectRandom _commonItems;
					_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
				};

				for "_i" from 0 to _rareCount do {
					_item = selectRandom _rareItems;
					_virtualItems = [_virtualItems, _item select 0, _item select 1, true] call BIS_fnc_addToPairs;
				};
			};
		};
	};

	_marker setMarkerText _wreckMessage;
	_marker setMarkerPos _crashPos;
	[_alertMessage,"yellow"] remoteExec ["A3PL_Player_Notification", -2];

    clearItemCargoGlobal _itemBox;
	clearMagazineCargoGlobal _itemBox;
	clearWeaponCargoGlobal _itemBox;
	clearBackpackCargoGlobal _itemBox;

	_itemBox setVariable["storage",_virtualItems,true];
	{_itemBox addItemCargoGlobal _x} foreach _physicalItems;

    sleep _eventDuration;
    deleteVehicle _planeWreck;
    deleteVehicle _itemBox;
	deleteMarker _marker;
	call Server_Events_End;
	["The plane wreck has been recovered!","yellow"] remoteExec ["A3PL_Player_Notification", -2];
},true] call Server_Setup_Compile;

["Server_Events_CreateZombies",
{
	if(isNil "A3FL_Events_Zombies") then {A3FL_Events_Zombies = [];};
	private _zombieAmount = param[0,1];
	private _position = param[1,[]];
	private _zombieLoadout = [["A3PL_Scypthe","","","",["A3PL_FireaxeMag",999998],[],""],[],[],["A3PL_Zombie_Uniform",[["A3PL_FireaxeMag",3,999999]]],[],["A3PL_LR",[]],"","",[],["ItemMap","ItemGPS","A3PL_Cellphone_2","ItemCompass","TFAR_microdagr",""]];
	for "_i" from 0 to _zombieAmount do {
		private _grp = createGroup [civilian, true];
		private _unit = _grp createUnit ["B_RangeMaster_F", _position, [], 0, "FORM"];
		_unit setUnitLoadout _zombieLoadout;
		_unit addEventHandler ["killed", {[(param [7,objNull]),4] remoteExec["A3PL_Level_AddXP",(param [7,objNull])];}];
		_unit setAnimSpeedCoef 1.8;
		_grp setBehaviour "COMBAT";
		[_unit] spawn Server_Events_ZombieLoop;
		A3FL_Events_Zombies pushback _unit;
	};
}] call Server_Setup_Compile;

["Server_Events_ZombieLoop",
{
	private _unit = param [0,objNull];
	private _target = objNull;
	private _medArray = ["left lower leg","right upper leg","left lower leg","pelvis","left upper leg","right upper leg","left upper leg","right lower leg","left lower leg","left upper leg","head","right upper leg","right lower leg","head","head","right lower leg"];
	while{alive _unit} do {
		if((isNull _target) || {!(_target getVariable["A3PL_Medical_Alive",true])} || {((_target distance2D _unit) > 80)}) then {
			{
				if(((_x distance2D _unit) < 30) && {(_x getVariable["A3PL_Medical_Alive",true])}) exitWith {
					_target = _x;
				};
			} foreach allPlayers;
			if(!isNull _target) then {
				_unit doMove (position _target);
				sleep 1;
			} else {
				sleep 10;
			};
		} else {
			_unit doMove (position _target);
			if((_target distance2D _unit) < 3) then {
				_unit playAction "GestureSwing";
				[_target,_medArray call A3PL_Lib_ArrayRandom,"cut"] call A3PL_Medical_ApplyWound;
			};
			sleep 2;
		};
	};
}] call Server_Setup_Compile;