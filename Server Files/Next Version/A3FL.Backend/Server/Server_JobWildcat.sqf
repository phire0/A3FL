/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define OREDMGDISS 0.55

["Server_JobWildcat_RandomizeOil",
{
	Server_JobWildCat_Oil = [[[3488.800,12506.046,0],10000]];
	for "_i" from 0 to 30 do {
		private ["_randPos","_overWater"];
		_randPos = ["FIMiningArea"] call CBA_fnc_randPosArea;
		_overWater = !(_randPos isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []);
		while {_overWater} do {
			_randPos = ["FIMiningArea"] call CBA_fnc_randPosArea;
			_overWater = !(_randPos isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []);
		};
		_oilAmounts = [210,252,294,336,378,420,462,504];
		_r = floor random 8;
		_arr = [_randPos,(_oilAmounts select _r)];
		Server_JobWildCat_Oil pushback _arr;
	};
	publicVariable "Server_JobWildCat_Oil";
},true] call Server_Setup_Compile;

["Server_JobWildcat_RandomizeRes",
{
	Server_JobWildCat_Res = [];
	{
		private _name = _x select 0;
		private _areas = _x select 1;
		private _ores = _x select 2;
		private _maxOres = _x select 3;
		for "_i" from 0 to _areas do {
			private _island = _x select 5;
			if(_island isEqualTo "All") then {
				_island = ["FIMiningArea","NIMiningArea"] call BIS_fnc_selectRandom;
			};
			private _randPos = [_island] call CBA_fnc_randPosArea;
			private _overWater = !(_randPos isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []);
			while {_overWater} do {
				_randPos = [_island] call CBA_fnc_randPosArea;
				_overWater = !(_randPos isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []);
			};
			private _arr = [_name,_randPos,_ores];
			Server_JobWildCat_Res pushback _arr;
		};
	} foreach Config_Resources_Ores;
	publicVariable "Server_JobWildCat_Res";
},true] call Server_Setup_Compile;

["Server_JobWildCat_SpawnRes",
{
	private _player = param [0,objNull];
	private _foundOre = param [1,""];
	private _objClass = "A3PL_Resource_Ore_Coal";
	switch (_foundOre) do {
		case (localize"STR_Config_Resources_Iron"): {_objClass = "A3PL_Resource_Ore_Iron";};
		case (localize"STR_Config_Resources_Coal"): {_objClass = "A3PL_Resource_Ore_Coal";};
		case (localize"STR_Config_Resources_Aluminium"): {_objClass = "A3PL_Resource_Ore_Bauxite";};
		case (localize"STR_Config_Resources_Sulphur"): {_objClass = "A3PL_Resource_Ore_Sulphur";};
		case (localize"STR_Config_Resources_Sapphire"): {_objClass = "A3PL_Resource_Ore_Sapphire";};
		case (localize"STR_Config_Resources_Vivianite"): {_objClass = "A3PL_Resource_Ore_Vivianite";};
		case (localize"STR_Config_Resources_Emerald"): {_objClass = "A3PL_Resource_Ore_Emerald";};
		case (localize"STR_Config_Resources_Gold"): {_objClass = "A3PL_Resource_Ore_Gold";};
		case (localize"STR_Config_Resources_Amethyst"): {_objClass = "A3PL_Resource_Ore_Amethyst";};
	};
	private _obj = createVehicle [_objClass,_player, [], 0, "CAN_COLLIDE"];
	_obj setVariable ["oreClass",_foundOre,false];
	{
		if ((_x select 0) isEqualTo _foundOre) exitwith {
			_obj setVariable ["smallOreItemClass",_x select 3,false];
			_obj setVariable ["smallOreAmount",_x select 4,false];
		};
	} foreach Config_Resources_Ores;

	_obj addEventHandler ["HandleDamage", {
		private _obj = param [0,objNull];
		private _sel = param [1,""];
		private _dmg = param [2,0];
		private _ins = param [6,objNull];
		private _wep = currentWeapon _ins;
		private _newDmg = _dmg;
		private _oldDmg = _obj getVariable ["dmg",0];
		private _giveEach = _obj getVariable ["smallOreAmount",1];
		private _prevDamage = _obj getVariable [format ["%1_dmg",_sel],0];

		if ((typeOf (vehicle _ins)) isEqualTo "A3PL_MiniExcavator") then {_wep = (vehicle _ins) currentWeaponTurret [0];};
		if ((_dmg >= OREDMGDISS) && (_sel == "hitpickaxe")) exitwith {deleteVehicle _obj;};
		if ((_dmg >= (_oldDmg + (OREDMGDISS / _giveEach))) && (_sel == "hitpickaxe") && (_wep IN ["A3PL_Machinery_Pickaxe","A3PL_Pickaxe"])) then
		{
			private _random = random 100;
			if (_random < 5) then {
				private _random = random 100;
				private _itemClass = "diamond_tourmaline";
				switch (true) do {
					case (_random < 1): {_itemClass = "diamond";};
					case (_random < 4): {_itemClass = "diamond_emerald";};
					case (_random < 9): {_itemClass = "diamond_ruby";};
					case (_random < 19): {_itemClass = "diamond_sapphire";};
					case (_random < 30): {_itemClass = "diamond_alex";};
					case (_random < 50): {_itemClass = "diamond_aqua";};
				};
				[_itemClass,1] remoteExec ["A3PL_Inventory_Add", (owner _ins)];
				["You found a rare gem stone!", "green"] remoteExec ["A3PL_Player_Notification", (owner _ins)];
			} else {
				_itemClass = _obj getVariable ["smallOreItemClass","ore_metal"];
				_amount = 1 * A3PL_Event_DblHarvest;
				[_itemClass,_amount] remoteExec ["A3PL_Inventory_Add", (owner _ins)];

				diag_log str (_obj getVariable ["smallOreItemClass","Jamie Sexy"]);
				diag_log str (_obj getVariable ["smallOreAmount","Jamie Sexy"]);
				[format["You succesfully mined %1 ore",_amount], "green"] remoteExec ["A3PL_Player_Notification", (owner _ins)];
			};
			_obj setVariable ["dmg",_dmg,false];
		};
		if ((_sel == "hitshovel") && (!(_wep IN ["A3PL_Machinery_Bucket","A3PL_Shovel"]))) then { _newDmg = _prevDamage;};
		if ((_sel == "hitpickaxe") && (!(_wep IN ["A3PL_Machinery_Pickaxe","A3PL_Pickaxe"]))) then { _newDmg = _prevDamage;};
		_obj setVariable [format ["%1_dmg",_sel],_newdmg,false];
		_newDmg;
	}];

	private _pos = getPos _player;
	private _dir = getDir _player;
	_player setPos [
		(_pos select 0) + (sin _dir * 1.5),
		(_pos select 1) + (cos _dir * 1.5),
		(_pos select 2)
	];
},true] call Server_Setup_Compile;
