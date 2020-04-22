["A3PL_Resources_StartDigging",
{
	private ["_inMarker","_eBucket","_s","_sBucket","_pos","_digProgress","_t"];
	_inMarker = false;
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if(player getVariable "Digging") exitWith{[localize"STR_NewRessources_Action","red"] call A3PL_Player_Notification;};

	{if ((getpos player) inArea _x) exitwith {_inMarker = true};} foreach ["A3PL_Marker_Sand1","A3PL_Marker_Sand2"];

	if (!_inMarker) exitwith {[localize"STR_NewRessources_SandArea","red"] call A3PL_Player_Notification;};
	if (currentWeapon player != "A3PL_Shovel") exitwith {[localize"STR_NewRessources_NoShovel","red"] call A3PL_Player_Notification;};

	if (Player_ActionDoing) exitwith {[localize"STR_NewRessources_Action","red"] call A3PL_Player_Notification;};
	player setVariable ["Digging",true,true];
	[player,"A3PL_Shovel_Dig"] remoteExec ["A3PL_Lib_SyncAnim", 0];

	["Filling bucket...",10] spawn A3PL_Lib_LoadAction;
	waitUntil{Player_ActionDoing};
	_success = true;
	while {Player_ActionDoing} do {
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if ((vehicle player) != player) exitWith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
	};

	[player,""] remoteExec ["A3PL_Lib_SyncAnim", 0];
	player setVariable ["Digging",false,true];
	if(Player_ActionInterrupted || !_success) exitWith {[localize"STR_NewRessources_DiggingCanceled","red"] call A3PL_Player_Notification;};

	_eBucket = objNull;
	{
		if ((_x getvariable ["class",""]) == "bucket_empty") exitwith {_eBucket = _x;};
	} foreach (nearestObjects [player, ["A3PL_Bucket"], 5]);

	if (isNull _eBucket) exitwith {[localize"STR_NewRessources_NoBucket","red"] call A3PL_Player_Notification;};

	_pos = getPos _eBucket;
	deleteVehicle _eBucket;

	_sBucket = createVehicle ["A3PL_BucketSand",_pos, [], 0, "CAN_COLLIDE"];
	_sBucket setVariable ["class","sand",true];
}] call Server_Setup_Compile;

["A3PL_Resources_DigOre",
{
	private ["_veh","_dmg"];
	_veh = param [0,objNull];
	_dmg = _veh getHitPointDamage "HitShovel";
	if (currentWeapon player != "A3PL_Shovel") exitwith {[localize"STR_NewRessources_NoShovel","red"] call A3PL_Player_Notification;};
	if (_dmg < 1) then
	{
		_veh setHitPointDamage ["HitShovel",_dmg + 0.1];
	};
	[player,1] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_Resources_Picking",
{
	private ["_apple"];
	_apple = param [0,objNull];

	if (!Player_ActionCompleted) exitwith {[localize"STR_NewRessources_Action","red"] call A3PL_Player_Notification;};
	Player_ActionCompleted = false;
	["Picking...",2] spawn A3PL_Lib_LoadAction;
	while {uiSleep 1.5; !Player_ActionCompleted } do
	{
		player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
	};

	if (!isNull _apple) then {
		[player, _apple, 1] remoteExecCall ["Server_Inventory_Pickup", 2];
	};
	[player,1] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;
