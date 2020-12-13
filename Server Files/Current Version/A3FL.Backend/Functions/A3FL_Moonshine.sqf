/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Moonshine_Grind",
{
	private ["_output","_nearby","_input","_pos","_mixer"];
	_output = param [0,""];
	_mixer = param [1,objNull];
	_success = true;
	switch (_output) do
	{
		case ("malt"):
		{			
			_input = objNull;
			_nearby = _mixer nearEntities [["A3PL_Sack"],2];
			{
				if (_x getVariable "class" isEqualTo "wheat") exitwith {_input = _x;};
			} foreach _nearby;
			if (isNull _input) exitwith {["There is no wheat to grind nearby"] call A3PL_Player_Notification;};

			if (Player_ActionDoing) exitwith {[localize"STR_NewVehicle_15","red"] call A3PL_Player_Notification;};
			["Malt grinding...",20] spawn A3PL_Lib_LoadAction;
			waitUntil{Player_ActionDoing};
			while {Player_ActionDoing} do {
				if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
				if ((vehicle player) != player) exitWith {_success = false;};
				if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
				if ((player distance2D _mixer) > 15) exitwith {_success = false};
			};
			if(Player_ActionInterrupted || !_success) exitWith {["Grinding interrupted","red"] call A3PL_Player_Notification;};

			_pos = getposATL _input;
			deleteVehicle _input;
			_malt = createvehicle ["A3PL_Grainsack_Malt", _pos, [], 0, "CAN_COLLIDE"];
			_malt setVariable ["owner",getPlayerUID player,true];
			_malt setVariable ["class","malt",true];
			["You have ground wheat malt","green"] call A3PL_Player_Notification;
		};
		case ("yeast"):
		{
			_input = objNull;
			_nearby = _mixer nearEntities [["A3PL_Sack"],2];
			{
				if (_x getVariable "class" isEqualTo "wheat") exitwith {_input = _x;};
			} foreach _nearby;
			if (isNull _input) exitwith {["There is no wheat to grind nearby"] call A3PL_Player_Notification;};

			if (Player_ActionDoing) exitwith {[localize"STR_NewVehicle_15","red"] call A3PL_Player_Notification;};
			["Yeast grinding...",20] spawn A3PL_Lib_LoadAction;
			waitUntil{Player_ActionDoing};
			while {Player_ActionDoing} do {
				if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
				if ((vehicle player) != player) exitWith {_success = false;};
				if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
				if ((player distance2D _mixer) > 15) exitwith {_success = false};
			};
			if(Player_ActionInterrupted || !_success) exitWith {["Grinding interrupted","red"] call A3PL_Player_Notification;};

			_pos = getposATL _input;
			deleteVehicle _input;
			_yeast = createvehicle ["A3PL_Grainsack_Yeast", _pos, [], 0, "CAN_COLLIDE"];
			_yeast setVariable ["owner",getPlayerUID player,true];
			_yeast setVariable ["class","yeast",true];
			["You have ground wheat yeast","green"] call A3PL_Player_Notification;
		};
		case ("cornmeal"):
		{
			_input = objNull;
			_nearby = _mixer nearEntities [["A3Pl_CornCob"],2];
			{
				if (_x getVariable "class" isEqualTo "corn") exitwith {_input = _x;};
			} foreach _nearby;
			if (isNull _input) exitwith {["There is no corn cob nearby to grind"] call A3PL_Player_Notification;};

			if (Player_ActionDoing) exitwith {[localize"STR_NewVehicle_15","red"] call A3PL_Player_Notification;};
			["Corn grinding...",20] spawn A3PL_Lib_LoadAction;
			waitUntil{Player_ActionDoing};
			while {Player_ActionDoing} do {
				if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
				if ((vehicle player) != player) exitWith {_success = false;};
				if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
				if ((player distance2D _mixer) > 15) exitwith {_success = false};
			};
			if(Player_ActionInterrupted || !_success) exitWith {["Grinding interrupted","red"] call A3PL_Player_Notification;};

			_pos = getposATL _input;
			deleteVehicle _input;
			_cornmeal = createvehicle ["A3PL_Grainsack_CornMeal", _pos, [], 0, "CAN_COLLIDE"];
			_cornmeal setVariable ["owner",getPlayerUID player,true];
			_cornmeal setVariable ["class","cornmeal",true];
			["You have ground corn cornmeal","green"] call A3PL_Player_Notification;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Moonshine_InstallHose",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _dist = param [0,objNull];
	private _hoses = nearestObjects [_dist, ["A3PL_Distillery_Hose"], 2];
	if ((count _hoses) < 1) exitwith {["No distillery pipes nearby","red"] call A3PL_Player_Notification;};
	private _hose = _hoses select 0;
	_hose attachto [_dist,[-0.53,0.48,-0.3]];
}] call Server_Setup_Compile;

["A3PL_Moonshine_InstallJug",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _hose = param [0,objNull];
	private _jugs = nearestObjects [_hose, ["A3PL_Jug","A3PL_Jug_Green"], 2];
	if ((count _jugs) < 1) exitwith {["No pot nearby","red"] call A3PL_Player_Notification;};
	private _jug = _jugs select 0;
	_jug attachto [_hose,[-0.2,-0.17,-0.57]];
}] call Server_Setup_Compile;

["A3PL_Moonshine_addItem",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _dist = param [0,objNull];
	private _nearby = nearestObjects [_dist, ["A3PL_Grainsack_Malt","A3PL_Grainsack_Yeast","A3PL_Grainsack_CornMeal"], 2];

	//check for correct items
	if (count _nearby < 1) exitwith {["There is no malt, yeast or cornmeal nearby, move it closer to the distillery","red"] call A3PL_Player_Notification;};
	private _nearby = _nearby select 0;
	private _item = _nearby getVariable "class";
	private _items = _dist getVariable ["items",[]];
	if (_item IN _items) exitwith {["This (closest) item has already been added to the distillery, add a different item closer to the distillery.","red"] call A3PL_Player_Notification;};

	//take item and add it to array
	deleteVehicle _nearby;
	_items pushback _item;
	_dist setVariable ["items",_items,true];
	[format ["You added %1 in the distillery",[_item,"name"] call A3PL_Config_GetItem],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Moonshine_CheckStatus",
{
	private _distillery = param [0,objNull];
	if (!(_distillery getVariable ["running",false])) exitwith {["The distillery is not running","red"] call A3PL_Player_Notification;};
	[format ["It remains %1 seconds at this distillery until completion",(_distillery getVariable ["timeleft",180])],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Moonshine_Start",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_dist","_sound","_items","_timeLeft","_hose","_succes","_posSound"];
	_dist = param [0,objNull];
	if (_dist getVariable ["running",false]) exitwith {["The distillery is already in operation","red"] call A3PL_Player_Notification;};

	_playerLevel = player getVariable["Player_Level",0];
	if ((_playerLevel) < 6) exitWith {["You will unlock this resource at level 6","red"] call A3PL_Player_Notification;};

	//check for required items and attached objects
	_items = _dist getVariable ["items",[]];
	if (!(("malt" IN _items) && ("yeast" IN _items) && ("cornmeal" IN _items))) exitwith {["The items needed to create Moonshine are not in this distillery, malt, yeast and cornmeal are needed to make moonshine.","red"] call A3PL_Player_Notification;};
	if ((count ([_dist] call A3PL_Lib_AttachedAll)) < 1) exitwith {["There is no pipe connected to the distillery","red"] call A3PL_Player_Notification;};
	_hose = ([_dist] call A3PL_Lib_AttachedAll) select 0;
	if ((count ([_hose] call A3PL_Lib_AttachedAll)) < 1) exitwith {["There is no pot connected to the pipe or the pot is already full","red"] call A3PL_Player_Notification;};
	_jug = ([_hose] call A3PL_Lib_AttachedAll) select 0;

	//set running
	_dist setVariable ["running",true];

	//create sound
	_sound = createSoundSource ["A3PL_Boiling", (getpos _dist), [], 0];
	_posSound = getPos _dist;

	//loop
	_timeLeft = 180;
	_dist setVariable ["timeleft",_timeLeft,true];
	_succes = false;
	while {(_timeLeft > 0) && (_dist getVariable ["running",false])} do
	{
		//set sound position
		if (!([_posSound,(getpos _dist)] call BIS_fnc_areEqual)) then
		{
			_sound setPos (getpos _dist);
			_posSound = getpos _dist;
		};

		//check if hose connected
		if ((count ([_dist] call A3PL_Lib_AttachedAll))< 1) exitwith {["The pipe was unplugged, one of your distilleries stopped working","red"] call A3PL_Player_Notification; true;};

		//check if jug still connected
		if ((count ([_hose] call A3PL_Lib_AttachedAll)) < 1) exitwith {["The pot was removed from one of your distilleries, it stopped","red"] call A3PL_Player_Notification; true;};

		//do timeleft
		_timeLeft = _timeLeft - 1;
		_dist setVariable ["timeleft",_timeLeft,true];
		if (_timeLeft < 1) exitwith {_succes = true; true;};
		uiSleep 1;
	};
	_dist setVariable ["running",nil,true];
	deleteVehicle _sound;

	if (_succes) then {
		_dist setVariable ["items",nil,true];
		_position = getPosATL _jug;
		deleteVehicle _jug;
		_jug = createvehicle ["A3PL_Jug_Corked", _position, [], 0, "CAN_COLLIDE"];
		_jug setVariable ["owner",getPlayerUID player,true];
		_jug setVariable ["class","jug_moonshine",true];
		["One of your distilleries has finished creating moonshine","green"] call A3PL_Player_Notification;
		[player,19] call A3PL_Level_AddXP;
	} else {
		["One of your distilleries has not finished","red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;
