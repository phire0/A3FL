/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_JobMcfisher_combine",
{
	private _player = param [0,objNull];
	private _intersect = param [1,objNull];
	private _classIntersect = _intersect getVariable "class";
	if (typeOf (attachedTo _intersect) == "C_man_1") exitwith {diag_log "Error: _intersect of player type in Server_JobMcfisher_combine?";};
	if ((isNull _player) OR (isNull _intersect)) exitwith {diag_log "Error: _player or _intersect null in Server_JobMcfisher_combine";};
	if (isNil "_classIntersect") exitwith {diag_log "Error: _classIntersect nil in Server_JobMcfisher_combine";};

	if (_classIntersect isEqualTo "tacoshell") then {
		private _burgers = nearestObjects [_intersect, ["A3PL_Fish_Raw","A3PL_Fish_Cooked","A3PL_Fish_Burned"], 1];
		if (count _burgers == 0) exitwith {};
		private _burger = _burgers select 0;
		if (typeOf (attachedTo _burger) == "C_man_1") exitwith {};
		private _burgerClass = _burger getVariable "class";
		if (isNil "_burgerClass") exitwith {};

		private _salads = nearestObjects [_intersect, ["A3PL_Salad"], 1];
		if (count _salads == 0) exitwith {};
		_salad = _salads select 0;

		private _attached = attachedTo _intersect;
		private _pos = getPosATL _intersect;
		switch (_burgerClass) do {
			case "fish_raw": {_newClass = "taco_raw";};
			case "fish_cooked": {_newClass = "taco_cooked";};
			case "fish_burnt": {_newClass = "taco_burned";};
		};
		if (isNil "_newclass") exitwith {};
		deleteVehicle _burger;
		deleteVehicle _intersect;
		deleteVehicle _salad;

		private _veh = createVehicle ["A3PL_Taco", _pos, [], 0, "CAN_COLLIDE"];
		_veh setposATL _pos;
		if (!isNull _attached) then {_veh attachTo [_attached];};
		[_veh,"class", _newClass] call Server_Core_ChangeVar;
	};

	if (_classIntersect isEqualTo "burger_bun") exitwith {
		private _burgers = nearestObjects [_intersect, ["A3PL_Burger_Raw","A3PL_Burger_Cooked","A3PL_Burger_Burnt"], 1];
		if (count _burgers == 0) exitwith {};
		private _burger = _burgers select 0;
		if (typeOf (attachedTo _burger) == "C_man_1") exitwith {};
		private _burgerClass = _burger getVariable "class";
		if (isNil "_burgerClass") exitwith {};

		private _salads = nearestObjects [_intersect, ["A3PL_Salad"], 1];
		if (count _salads == 0) exitwith {};
		_salad = _salads select 0;

		private _attached = attachedTo _intersect;
		private _pos = getPosATL _intersect;

		switch (_burgerClass) do {
			case "burger_raw": {_newClass = "burger_full_raw";};
			case "burger_cooked": {_newClass = "burger_full_cooked";};
			case "burger_burnt": {_newClass = "burger_full_burnt";};
		};

		if (isNil "_newclass") exitwith {};
		deleteVehicle _burger;
		deleteVehicle _intersect;
		deleteVehicle _salad;

		private _veh = createVehicle ["A3PL_Burger_Full", _pos, [], 0, "CAN_COLLIDE"];
		_veh setposATL _pos;
		if (!isNull _attached) then {_veh attachTo [_attached];};
		[_veh,"class", _newClass] call Server_Core_ChangeVar;
	};

	private _burgers = nearestObjects [_intersect, ["A3PL_Burger_Bun"], 1];
	if (count _burgers == 0) exitwith {};
	private _burger = _burgers select 0;
	if (typeOf (attachedTo _burger) == "C_man_1") exitwith {};

	private _salads = nearestObjects [_intersect, ["A3PL_Salad"], 1];
	if (count _salads == 0) exitwith {};
	_salad = _salads select 0;

	private _attached = attachedTo _burger;
	private _pos = getPosATL _burger;

	switch (_classIntersect) do {
		case "burger_raw": {_newClass = "burger_full_raw";};
		case "burger_cooked": {_newClass = "burger_full_cooked";};
		case "burger_burnt": {_newClass = "burger_full_burnt";};
	};
	if (isNil "_newclass") exitwith {};

	deleteVehicle _burger;
	deleteVehicle _intersect;
	deleteVehicle _salad;

	private _veh = createVehicle ["A3PL_Burger_Full", _pos, [], 0, "CAN_COLLIDE"];
	_veh setposATL _pos;
	if (!isNull _attached) then {_veh attachTo [_attached];};
	[_veh,"class",_newclass] call Server_Core_ChangeVar;
},true] call Server_Setup_Compile;

["Server_JobMcfisher_cookthres",
{
	private ["_cookstate","_player","_burger","_class","_newClass","_pos","_veh","_newObjclass","_offset"];
	_player = param [0,objNull];
	_burger = param [1,objNull];
	_grill = attachedTo _burger;
	_class = _burger getVariable "class";
	if (isNull _grill) exitwith {diag_log "Error: _grill is null in Server_JobMcfisher_cookthres"};
	if ((isNull _player) OR (isNull _burger)) exitwith {diag_log "Error: _player or _burger null in Server_JobMcfisher_cookthres"};
	if (isNil "_class") exitwith {diag_log "Error: _class is nil in Server_JobMcfisher_cookthres"};
	_cookstate = _burger getVariable "cookstate";
	if (isNil "_cookstate") exitwith {diag_log "Error: _cookstate is nil in Server_JobMcfisher_cookthres"};
	if (_cookstate > 90) then {
		_newClass = "empty";
		if (_class == "burger_raw") then {
			_newClass = "burger_cooked";
			_newObjclass = "A3PL_Burger_Cooked";
		};
		if (_class == "burger_cooked") then {
			_newClass = "burger_burnt";
			_newObjclass = "A3PL_Burger_Burnt";
		};
		if (_class == "fish_raw") then {
			_newClass = "fish_cooked";
			_newObjclass = "A3PL_Fish_Cooked";
		};
		if (_class == "fish_cooked") then {
			_newClass = "fish_burned";
			_newObjclass = "A3PL_Fish_Burned";
		};
		if (_newClass == "empty") exitwith {diag_log "Error: _newclass has not been changed in Server_JobMcfisher_cookthres"};
		_pos = getPosATL _burger;
		deleteVehicle _burger;
		_veh = createVehicle [_newObjclass, _pos, [], 0, "CAN_COLLIDE"];
		_veh attachTo [_grill];
		[_veh, "class", _newClass] call Server_Core_ChangeVar;
		[_veh] remoteExec ["A3PL_JobMcfisher_CookBurger",_player];
	};
},true] call Server_Setup_Compile;