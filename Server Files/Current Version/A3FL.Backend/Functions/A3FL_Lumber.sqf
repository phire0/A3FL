/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Lumber_FireAxe",
{
	private _tree = cursorObject;
	if (typeOf _tree != "Land_A3PL_Tree3") exitwith {};
	if ((player distance2D _tree) > 6) exitwith {[localize"STR_NewLumber_TooFar"] call A3PL_Player_Notification;};
	private _hp = _tree getVariable ["hp",5];
	_hp = _hp - 5;
	if (_hp <= 0) then {
		private _nearVeh = nearestObjects [_tree,["Car","Tank"],20,true];
		hint str(_nearVeh);
		{_x allowDamage false;} foreach _nearVeh;
		_tree setDammage 1;
		[_tree] spawn
		{
			private _tree = param [0,objNull];
			private _pos = getPos _tree;
			sleep 3;
			for "_i" from 0 to (round random 4) do {
				private _log = createVehicle ["A3PL_WoodenLog", _pos, [], 3, "CAN_COLLIDE"];
				_log setVariable ["class","log",true];
				_log setVariable ["owner",getPlayerUID player,true];
			};
			deleteVehicle _tree;
			{_x allowDamage true;} foreach _nearVeh;
		};		
	} else {
		_tree setVariable ["hp",_hp,true];
	};
}] call Server_Setup_Compile;