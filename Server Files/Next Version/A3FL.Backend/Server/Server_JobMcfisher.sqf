/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_JobMcfisher_cookthres",
{
	private _player = param [0,objNull];
	private _burger = param [1,objNull];
	private _amount = param [2,1];
	private _grill = attachedTo _burger;
	private _class = _burger getVariable "class";
	private _newClass = "empty";
	private _newObjclass = "";

	if (isNull _grill) exitwith {diag_log "Error: _grill is null in Server_JobMcfisher_cookthres"};
	if ((isNull _player) OR (isNull _burger)) exitwith {diag_log "Error: _player or _burger null in Server_JobMcfisher_cookthres"};
	if (isNil "_class") exitwith {diag_log "Error: _class is nil in Server_JobMcfisher_cookthres"};
	private _cookstate = _burger getVariable "cookstate";
	if (isNil "_cookstate") exitwith {diag_log "Error: _cookstate is nil in Server_JobMcfisher_cookthres"};
	if (_cookstate > 90) then {
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
		if (_newClass isEqualTo "empty") exitwith {diag_log "Error: _newclass has not been changed in Server_JobMcfisher_cookthres"};
		private _pos = getPosATL _burger;
		deleteVehicle _burger;
		private _veh = createVehicle [_newObjclass, _pos, [], 0, "CAN_COLLIDE"];
		_veh attachTo [_grill];
		[_veh, "class", _newClass] call Server_Core_ChangeVar;
		[_veh, "amount", _amount] call Server_Core_ChangeVar;
		[_veh] remoteExec ["A3PL_JobMcfisher_CookBurger",_player];
	};
},true] call Server_Setup_Compile;