/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['A3PL_Criminal_Ziptie', {
	private _obj = _this select 0;
	[getPlayerUID player,"zipped"] remoteExec ["Server_Log_New",2];
	if ((animationState _obj) IN ["amovpercmstpsnonwnondnon","amovpercmstpsraswrfldnon","amovpercmstpsraswpstdnon","amovpercmstpsraswlnrdnon"]) exitwith
	{
		[player,_obj,1] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
	if ((animationState _obj) isEqualTo "a3pl_idletohandsup") exitwith
	{
		[player,_obj,2] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
	if ((animationState _obj) isEqualTo "a3pl_handsuptokneel") exitwith
	{
		[player,_obj,3] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
	if (animationState _obj IN ["amovpknlmstpsnonwnondnon","amovpknlmstpsraswpstdnon","amovpknlmstpsraswrfldnon","amovpknlmstpsraswlnrdnon"]) exitwith
	{
		[player,_obj,4] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
	if (animationState _obj IN ["amovppnemstpsnonwnondnon","amovppnemstpsraswrfldnon","amovppnemstpsraswpstdnon"]) exitwith
	{
		[player,_obj,5] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
	if ((animationState _obj) isEqualTo "unconscious") exitwith
	{
		[player,_obj,5] remoteExec ["A3PL_Police_HandleAnim",0];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
}] call Server_Setup_Compile;

['A3PL_Criminal_Unzip', {
	private _obj = _this select 0;
	private _Cuffed = _obj getVariable ["Zipped",true];
	if (_Cuffed) then {
		["zipties",1] call A3PL_Inventory_Add;
		[player,_obj,7] remoteExec ["A3PL_Police_HandleAnim",0];
		_obj setVariable ["Zipped",false,true];
		_obj setVariable ["dragged",nil,true];
		if((vehicle _obj) isEqualTo _obj) then {
			["gesture_stop",_obj] call A3PL_Lib_Gesture;
			[_obj,""] remoteExec ["A3PL_Lib_SyncAnim", -2];
		};
	};
}] call Server_Setup_Compile;

["A3PL_Criminal_RemoveTime",{
	if (10000 > (player getVariable ["player_cash",0])) exitwith {[format ["You don't have $10,000 to remove your electronic bracelet!"]] call A3PL_Player_notification;};

	if(!(player getVariable "jail_mark")) exitwith {[localize"STR_CRIMINAL_YOUDONTPURGEPRISON"] call A3PL_Player_notification;};
	player setVariable ["player_cash",(player getVariable ["player_cash",0]) - 5000,true];

	player setVariable ["jail_mark",false,true];
	player setVariable ["jailed",false,true];
	player setVariable ["jailtime",nil,true];

	[player] remoteExec ["Server_Criminal_RemoveJail", 2];

	[localize"STR_CRIMINAL_SUCCESSFULLREMOVETIMERPRISON"] call A3PL_Player_notification;
	[player, 30] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_Criminal_Work", {
	if(!(player getVariable ["jailed",false])) exitWith {[localize"STR_QuickActionsNPC_OnlyJailed", "red"] call A3PL_Player_Notification;};
	if (animationstate player == "Acts_carFixingWheel") exitwith {[localize"STR_CRIMINAL_YOUALREADYWORK", "red"] call A3PL_Player_Notification;};
	if (!(vehicle player == player)) exitwith {[localize"STR_CRIMINAL_YOUCANTWORKINTOVEHICLE", "red"] call A3PL_Player_Notification;};
	if (Player_ActionDoing) exitwith {["You are already performing an action","red"] call A3PL_Player_Notification;};

	[localize"STR_CRIMINAL_LICENSEFACTORY",50] spawn A3PL_Lib_LoadAction;
	_success = true;
	waitUntil{Player_ActionDoing};
	player playMoveNow 'Acts_carFixingWheel';
	while {Player_ActionDoing} do {
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if ((vehicle player) != player) exitWith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
	};
	if(Player_ActionInterrupted || !_success) exitWith {
		player setVariable ["working",false,true];
		["Action cancelled","red"] call A3PL_Player_Notification;
	};

	_chance = selectRandom[1,2];
	if(_chance == 2) then {
		_time = player getVariable "jailtime";
		_newTime = _time - 1;
		[localize"STR_CRIMINAL_YOURPRISONTIMERASBEENUPDATED", "green"] call A3PL_Player_Notification;
		[_newTime, player] remoteExec ["Server_Police_JailPlayer",2];
	};
	player setVariable ["player_cash",(player getVariable ["player_cash",0]) + 250,true];
	[player, 3] call A3PL_Level_AddXP;
	[localize"STR_CRIMINAL_WORKENDED", "green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Criminal_PickCar", {
	private _car = param [0,objNull];
	if((typeOf _car) IN ["A3PL_EMS_Locker"]) exitWith {["This is not meant to be lockpicked", "red"] call A3PL_Player_Notification;};
	if (animationstate player isEqualTo "Acts_carFixingWheel") exitwith {[localize"STR_CRIMINAL_YOUALREADYTAKEANACTION", "red"] call A3PL_Player_Notification;};
	if (!(vehicle player isEqualTo player)) exitwith {[localize"STR_CRIMINAL_YOUCANTPICKVEHICLEINTOVEHICLE", "red"] call A3PL_Player_Notification;};
	if (Player_ActionDoing) exitwith {[localize"STR_CRIMINAL_YOUALREADYPICKVEHICLE", "red"] call A3PL_Player_Notification;};

	[localize"STR_CRIMINAL_YOUPICKVEHICLEPROGRESS", "yellow"] call A3PL_Player_Notification;
	player setVariable ["picking",true,true];
	["Lockpicking...",45] spawn A3PL_Lib_LoadAction;

	_success = true;
	waitUntil{Player_ActionDoing};
	player playMoveNow 'Acts_carFixingWheel';
	while {Player_ActionDoing} do {
		if ((player distance2D _car) > 5) exitWith {[localize"STR_CRIMINAL_NEEDTOBENEARVEHICLE5M", "red"] call A3PL_Player_Notification; _success = false;};
		if (!(vehicle player == player)) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
		if ((!alive _car)) exitwith {_success = false;};
		if (!(player_itemClass == "v_lockpick")) exitwith {_success = false;};
		if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {_success = false;};
		if ((animationstate player) != "Acts_carFixingWheel") then {player playMoveNow 'Acts_carFixingWheel';};
	};
	player switchMove "";
	if(Player_ActionInterrupted || !_success) exitWith {[localize"STR_CRIMINAL_PICKENDED","red"] call A3PL_Player_Notification;};

	[player_item] call A3PL_Inventory_Clear;
	[player,"v_lockpick",-1] remoteExec ["Server_Inventory_Add",2];

	_chance = random 100;
	if(_chance >= 35) then {
		_car setVariable ["locked",false,true];
		[localize"STR_CRIMINAL_PICKSUCCESSFULL", "green"] call A3PL_Player_Notification;
		[player,20] call A3PL_Level_AddXP;
	} else {
		[localize"STR_CRIMINAL_YOUCANNOTPICKTHISVEHICLE", "red"] call A3PL_Player_Notification;
		_y = 20;
		while {_y > 0} do {
			playSound3D ["A3\Sounds_F\sfx\alarmCar.wss", _car, true, _car, 3, 1, 100];
			uiSleep 2;
			_y = _y - 1;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Criminal_SuicideVest",
{
	private _nearP = player nearEntities ["Man", 15];
	private _suicide = "Bo_Mk82" createVehicle [0,0,9999];
	_suicide setPos (getPos player);
	_suicide setVelocity [100,0,0];
	{
		[_x,[-5000]] call A3PL_Medical_ApplyVar;
		[_x,"chest","wound_major"] call A3PL_Medical_ApplyWound;
	} foreach _nearP;
	removeVest player;
	[] spawn {
		sleep 5;
		call A3PL_Medical_Respawn;
	};
}] call Server_Setup_Compile;

['A3PL_Criminal_Drag',
{
	private _civ = _this select 0;
	private _dragged = _civ getVariable ["dragged",false];
	if (_dragged) exitwith {
		_civ setVariable ["dragged",nil,true];
	};
	if (_civ getVariable["Zipped",false]) then {
		[player] remoteExec ["A3PL_Criminal_DragReceive", _civ];
	} else {
		[localize"STR_NewPolice_8", "red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

['A3PL_Criminal_DragReceive',
{
	private _crim = param [0,objNull];
	[localize"STR_NewPolice_9", "red"] call A3PL_Player_Notification;
	player setVariable ["dragged",true,true];
	["gesture_restrain"] call A3PL_Lib_Gesture;
	[player,""] remoteExec ["A3PL_Lib_SyncAnim", -2];
	player forceWalk true;
	[_crim] spawn
	{
		private _crim = param [0,objNull];
		if (isNull _crim) exitwith {};
		while {player getVariable ["dragged",false] && ((vehicle _crim) isKindOf "Civilian_F")} do
		{
				if (isNull _crim) exitwith {};
				if ((player distance _crim) > 5 && ((vehicle _crim) isKindOf "Civilian_F")) then {
					player setposATL (getposATL _crim);
				};
				if(!(player getVariable["Zipped",true])) then {player setVariable ["dragged",nil,true];};
				["gesture_restrain"] call A3PL_Lib_Gesture;
		};
		player forceWalk false;
		player setVariable ["dragged",nil,true];
		[localize"STR_NewPolice_10", "red"] call A3PL_Player_Notification;
		if((vehicle player) isEqualTo player) then {
			["gesture_stop"] call A3PL_Lib_Gesture;
			[player,"a3pl_handsupkneelcuffed"] remoteExec ["A3PL_Lib_SyncAnim", -2];
		};
	};
}] call Server_Setup_Compile;

["A3PL_Criminal_PickHandcuffs",{
	private _target = param [0,objNull];
	if (animationstate player isEqualTo "Acts_carFixingWheel") exitwith {[localize"STR_CRIMINAL_YOUALREADYTAKEANACTION", "red"] call A3PL_Player_Notification;};
	if (!(vehicle player isEqualTo player)) exitwith {[localize"STR_CRIMINAL_YOUCANTPICKVEHICLEINTOVEHICLE", "red"] call A3PL_Player_Notification;};
	if (Player_ActionDoing) exitwith {[localize"STR_CRIMINAL_YOUALREADYPICKVEHICLE", "red"] call A3PL_Player_Notification;};

	player playmove "Acts_carFixingWheel";
	player setVariable ["picking",true,true];
	[_target] spawn
	{
		private _target = param [0,objNull];
		["Lockpicking handcuffs...",15] spawn A3PL_Lib_LoadAction;
		while {Player_ActionDoing} do {
			if ((player distance2D _target) > 5) exitWith {[localize"STR_CRIMINAL_NEEDTOBENEAR5M", "red"] call A3PL_Player_Notification; Player_ActionInterrupted = false;};
			if (!(vehicle player isEqualTo player)) exitwith {Player_ActionInterrupted = false;};
			if (player getVariable ["Incapacitated",false]) exitwith {Player_ActionInterrupted = false;};
			if (_target getVariable ["Incapacitated",false]) exitwith {Player_ActionInterrupted = false;};
			if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {Player_ActionInterrupted = false;};
		};
		if ((vehicle player) isEqualTo player) then {player switchMove "";};
		if(Player_ActionInterrupted) exitWith {[localize"STR_CRIMINAL_PICKENDED", "red"] call A3PL_Player_Notification;};

		["v_lockpick",-1] call A3PL_Inventory_Add;
		_chance = random 100;
		if(_chance >= 35) then {
			[_target] call A3PL_Police_Uncuff;
			[localize"STR_CRIMINAL_PICKSUCCESSFULLHC", "green"] call A3PL_Player_Notification;
			[player,20] call A3PL_Level_AddXP;
		} else {
			[localize"STR_CRIMINAL_YOUCANNOTPICKTHISVEHICLEHC", "red"] call A3PL_Player_Notification;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Criminal_FindNPC",{
	private _cost = 50000;
	private _playerCash = player getVariable["Player_Cash",0];
	if(_cost > _playerCash) exitWith {["You need to have $50,000 to try and find the Illegal NPC's!","red"] call A3pl_Player_Notification;};
	private _randomNPC = "";
	private _randomNPCName = "";
	private _randomNumber = floor(random 5);
	switch (_randomNumber) do {
		case(0): {
			_randomNPC = npc_ill_trader;
			_randomNPCName = "Illegal Trader";
		};
		case(1): {
			_randomNPC = npc_ill_moonshine;
			_randomNPCName = "Moonshine Dealer";
		};
		case(2): {
			_randomNPC = npc_ill_cocaine;
			_randomNPCName = "Cocaine Dealer";
		};
		case(3): {
			_randomNPC = npc_ill_shrooms;
			_randomNPCName = "Mushroom Dealer";
		};
		case(4): {
			_randomNPC = npc_ill_weed;
			_randomNPCName = "Weed Dealer";
		};
	};
	private _nearestCity = text ((nearestLocations [_randomNPC, ["NameCityCapital","NameCity","NameVillage"], 5000]) select 0);
	player setVariable ["Player_Cash",(_playerCash - _cost),true];
	[format ["You were charged $50,000 for the following information: The %1 was last spotted in %2! Use it wisely.",_randomNPCName,_nearestCity],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;