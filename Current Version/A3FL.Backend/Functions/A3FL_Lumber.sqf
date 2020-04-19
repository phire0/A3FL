["A3PL_Lumber_FireAxe",
{
	private _tree = player_objintersect;
	if (typeOf _tree != "Land_A3PL_Tree3") exitwith {};
	if ((player distance2D _tree) > 6) exitwith {[localize"STR_NewLumber_TooFar"] call A3PL_Player_Notification;};
	private _hp = _tree getVariable ["hp",50];
	_hp = _hp - 5;
	if (_hp <= 0) then {
		_tree setDammage 1;
		[_tree] spawn
		{
			private _tree = param [0,objNull];
			private _pos = getPos _tree;
			uiSleep 3.2;
			for "_i" from 0 to (round random 4) do {
				private _log = createVehicle ["A3PL_WoodenLog", _pos, [], 3, "CAN_COLLIDE"];
				_log setVariable ["class","log",true];
				_log setVariable ["owner",getPlayerUID player,true];
			};
			deleteVehicle _tree;
		};
	} else {
		_tree setVariable ["hp",_hp,true];
	};
}] call Server_Setup_Compile;