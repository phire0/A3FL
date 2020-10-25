/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['A3PL_USCG_Drag',
{
	private _civ = _this select 0;
	private _dragged = _civ getVariable ["dragged",false];
	if (_dragged) exitWith {_civ setVariable ["dragged",Nil,true];};
	private _alreadyDrag = player getVariable["dragging", false];
	if(_alreadyDrag) exitWith {["You are already dragging someone", "red"] call A3PL_Player_Notification;};
	player setVariable["dragging", true, true];
	["You are dragging someone", "green"] call A3PL_Player_Notification;
	[player] remoteExec ["A3PL_USCG_DragReceive",_civ];
}] call Server_Setup_Compile;

['A3PL_USCG_DragReceive',
{
	private _cop = param [0,objNull];
	[localize"STR_NewUSCG_1", "red"] call A3PL_Player_Notification;
	player setVariable ["dragged",true,true];
	[_cop] spawn
	{
		private _cop = param [0,objNull];
		if (isNull _cop) exitwith {};
		while {(player getVariable ["dragged",false]) && (vehicle _cop isKindOf "Civilian_F") && (surfaceIsWater position player)} do
		{
			sleep 2;
			if (isNull _cop) exitwith {};
			if (((player distance _cop) > 3) && (vehicle _cop isKindOf "Civilian_F")) then {
				player setPosASL (getposASL _cop);
			};
		};
		_cop setVariable["dragging", false, true];
		[localize"STR_NewUSCG_2", "red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

['A3PL_USCG_TowBoat',
{
	private _towing = param[0,objNull];
	private _target = param[1,objNull];
	private _towingOffset = switch(typeOf _towing) do {
		default{[0,-6.9,-1.3]};
	};
	private _targetOffset = switch(typeOf _target) do {
		case "A3PL_Motorboat": {[0, 3, 0]};
		case "A3PL_RHIB": {[0, 2.7, 0.2]};
		case "C_Scooter_Transport_01_F": {[0, 1.7, -0.9]};
		case "A3FL_LCM": {[1.05, 9.6, -0.89]};
		case "A3PL_RBM": {[0.2, 6.8, 0]};
		default{[0, 0, 0]};
	};

	if(((typeOf _target) isEqualTo "A3FL_LCM") && {false}) exitWith {["You need to raise the ramp first!", "red"] call A3PL_Player_Notification;};
	if((_towing distance2D _target) >= 30) exitWith {["The target boat is too far away!", "red"] call A3PL_Player_Notification;};
	if(_towing getVariable["towing",false]) exitWith {["You are already towing a boat!", "red"] call A3PL_Player_Notification;};
	private _rope = ropeCreate [_towing, _towingOffset, _target, _targetOffset, 30];
	_towing setVariable["towing",true,true];
	_towing setVariable["towingRope",_rope,true];
}] call Server_Setup_Compile;

['A3PL_USCG_UntowBoat',
{
	private _towing = param[0,objNull];
	private _rope = _towing getVariable["towingRope",nil];
	if(!isNil "_rope") then {ropeDestroy _rope;};
	_towing setVariable["towing",nil,true];
	_towing setVariable["towingRope",nil,true];
}] call Server_Setup_Compile;