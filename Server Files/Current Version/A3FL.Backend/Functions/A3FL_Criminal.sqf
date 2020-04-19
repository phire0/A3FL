['A3PL_Criminal_Ziptie', {
	private ['_obj'];
	_obj = _this select 0;
	_Cuffed = _obj getVariable ["Zipped",true];
	if (animationState _obj IN ["amovpercmstpsnonwnondnon","amovpercmstpsraswrfldnon","amovpercmstpsraswpstdnon","amovpercmstpsraswlnrdnon"]) exitwith
	{
		[player,_obj,1] remoteExec ["A3PL_Police_HandleAnim",-2];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
	if (animationState _obj == "a3pl_idletohandsup") exitwith
	{
		[player,_obj,2] remoteExec ["A3PL_Police_HandleAnim",-2];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
	if (animationState _obj == "a3pl_handsuptokneel") exitwith
	{
		[player,_obj,3] remoteExec ["A3PL_Police_HandleAnim",-2];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
	if (animationState _obj IN ["amovpknlmstpsnonwnondnon","amovpknlmstpsraswpstdnon","amovpknlmstpsraswrfldnon","amovpknlmstpsraswlnrdnon"]) exitwith
	{
		[player,_obj,4] remoteExec ["A3PL_Police_HandleAnim",-2];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
	if (animationState _obj IN ["amovppnemstpsnonwnondnon","amovppnemstpsraswrfldnon","amovppnemstpsraswpstdnon"]) exitwith
	{
		[player,_obj,5] remoteExec ["A3PL_Police_HandleAnim",-2];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
	if (animationState _obj == "unconscious") exitwith
	{
		[player,_obj,5] remoteExec ["A3PL_Police_HandleAnim",-2];
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",true,true];
	};
}] call Server_Setup_Compile;

['A3PL_Criminal_Unzip', {
	private ['_obj'];
	_obj = _this select 0;

	//7 Uncuff
	_Zipped = _obj getVariable ["Zipped",true];
	if ((animationState _obj IN ["a3pl_handsuptokneel"])&&(_Zipped)) exitwith
	{
		["zipties",1] call A3PL_Inventory_Add;
		[player,_obj,7] remoteExec ["A3PL_Police_HandleAnim",-2];
		_obj setVariable ["Zipped",false,true];
	};

	if ((animationState _obj == "a3pl_handsupkneelkicked")&&(_Zipped)) exitwith
	{
		["zipties",1] call A3PL_Inventory_Add;
		[player,_obj,7] remoteExec ["A3PL_Police_HandleAnim",-2];
		_obj setVariable ["Zipped",false,true];
	};

	if ((animationState _obj == "a3pl_handsupkneelcuffed")&&(_Zipped)) exitwith
	{
		["zipties",1] call A3PL_Inventory_Add;
		[player,_obj,7] remoteExec ["A3PL_Police_HandleAnim",-2];
		_obj setVariable ["Zipped",false,true];
	};
}] call Server_Setup_Compile;

["A3PL_Criminal_RemoveTime",{
	if (5000 > (player getVariable ["player_cash",0])) exitwith {[format ["You don't have $5,000 to remove your electronic bracelet!"]] call A3PL_Player_notification;};

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

	[localize"STR_CRIMINAL_LICENSEFACTORY",8] spawn A3PL_Lib_LoadAction;
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
	[localize"STR_CRIMINAL_WORKENDED", "green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Criminal_PickCar", {
	private ["_car"];
	_car = param [0,objNull];

	if (animationstate player == "Acts_carFixingWheel") exitwith {[localize"STR_CRIMINAL_YOUALREADYTAKEANACTION", "red"] call A3PL_Player_Notification;};
	if (!(vehicle player == player)) exitwith {[localize"STR_CRIMINAL_YOUCANTPICKVEHICLEINTOVEHICLE", "red"] call A3PL_Player_Notification;};
	if (Player_ActionDoing) exitwith {[localize"STR_CRIMINAL_YOUALREADYPICKVEHICLE", "red"] call A3PL_Player_Notification;};

	player playmove "Acts_carFixingWheel";
	[localize"STR_CRIMINAL_YOUPICKVEHICLEPROGRESS", "yellow"] call A3PL_Player_Notification;
	player setVariable ["picking",true,true];

	[_car] spawn
	{
		private ["_car"];
		_car = param [0,objNull];
		if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
		["Lockpicking...",6] spawn A3PL_Lib_LoadAction;
		_success = true;
		while {uiSleep 0.5; Player_ActionDoing } do {
			if ((player distance2D _car) > 5) exitWith {[localize"STR_CRIMINAL_NEEDTOBENEARVEHICLE5M", "red"] call A3PL_Player_Notification; _success = false;};
			if (!(vehicle player == player)) exitwith {_success = false;};
			if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
			if ((!alive _car)) exitwith {_success = false;};
			if (!(player_itemClass == "v_lockpick")) exitwith {_success = false;};
			if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {_success = false;};
		};
		player switchMove "";
		if(Player_ActionInterrupted || !_success) exitWith {
			Player_ActionInterrupted = true;
			[localize"STR_CRIMINAL_PICKENDED", "red"] call A3PL_Player_Notification;
			if (vehicle player == player) then {player switchMove "";};
		};

		[player_item] call A3PL_Inventory_Clear;
		[player,"v_lockpick",-1] remoteExec ["Server_Inventory_Add",2];

		// 65% chance to unlock
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
	};
}] call Server_Setup_Compile;

['A3PL_Criminal_Print', {
    private['_chance','_blueprints','_var'];
    _blueprints = ["Blueprint_cvpi_PD","Blueprint_cvpi_PDST","Blueprint_tahoe_PD","Blueprint_tahoe_PDST","Blueprint_mustang_PD","Blueprint_mustang_PDST","Blueprint_charger_PD","Blueprint_charger_PDST","Blueprint_silverado_PD","Blueprint_vettrz1_PD","Blueprint_BoatTrailerUSCG","Blueprint_Boat_Civil_01_rescue","Blueprint_RBM","Blueprint_Jayhawk","Blueprint_CessnaUSCG","Blueprint_MediumUSCG","Blueprint_Rangemaster_belt","Blueprint_Rangefinder","Blueprint_oshemag_HeadGear","Blueprint_tanshemag_HeadGear","Blueprint_khkshemag_HeadGear","Blueprint_balaclava_goggles","Blueprint_balaclavacom_goggles","Blueprint_balaclavatna_goggles","Blueprint_balaclavalopro_goggles","Blueprint_balaclavaoli_goggles","Blueprint_Bandanna_aviator","Blueprint_Bandanna_beast","Blueprint_Bandanna_blk","Blueprint_G_Bandanna_oli","Blueprint_G_Bandanna_shades","Blueprint_G_Bandanna_khk","Blueprint_Anon_mask","Blueprint_H_ShemagOpen_khk","Blueprint_H_ShemagOpen_tan","Blueprint_H_Shemag_olive_hs","Blueprint_P07","Blueprint_P07_khk","Blueprint_Pistol_heavy_01","Blueprint_ACPC2","Blueprint_Pistol_01","Blueprint_Rook40","Blueprint_Pistol_heavy_02","Blueprint_hgun_Glock17","Blueprint_16Rnd_9x21_Mag","Blueprint_11Rnd_45ACP_Mag","Blueprint_6Rnd_45ACP_Mag","Blueprint_9Rnd_45ACP_Mag","Blueprint_10Rnd_9x21_Mag","Blueprint_16Rnd_9x21_green_Mag","Blueprint_16Rnd_9x21_yellow_Mag","Blueprint_30Rnd_9x21_Mag","Blueprint_30Rnd_9x21_Mag_SMG_02","Blueprint_30Rnd_9x21_Green_Mag","Blueprint_30Rnd_9x21_Yellow_Mag","Blueprint_SMG","Blueprint_AKS","Blueprint_30Rnd_545x39_Mag"];

  	_pCash = player getVariable ["player_cash",0];
  	_ccPrice = 30000;
    if (_ccPrice > _pCash) exitwith {[format [localize"STR_CRIMINAL_YOUNEEDMONEYFORPHOTOCOPY",_ccPrice-_pCash]] call A3PL_Player_notification;};

    if !(player_itemClass in _blueprints) exitWith {[localize"STR_CRIMINAL_YOUDONTHAVEBLUEPRINTINYOURHAND"] call A3PL_Player_notification;};
    if (!Player_ActionCompleted) exitWith {[localize"STR_CRIMINAL_YOUALREADYPERFORMANACTION","red"] call A3PL_Player_Notification;};

    player setVariable ["player_cash",(player getVariable ["player_cash",0]) - 30000,true];

    Player_ActionCompleted = false;
    [localize"STR_CRIMINAL_PHOTOCOPYINPROGRESS",10+random 2] spawn A3PL_Lib_LoadAction;
    waitUntil { !Player_ActionCompleted };

    _var = player_itemClass;
    _chance = random(100);
    if(_chance > 25) then {
        [player_item] call A3PL_Inventory_Clear;
        [player, _var, +1] remoteExec ["Server_Inventory_Add", 2];
        [format[localize"STR_CRIMINAL_YOUMAKEPHOTOCOPYOFTHISBLUEPRINT",_var],"green"] call A3PL_Player_Notification;
        [player, 13] call A3PL_Level_AddXP;
    } else {
        [player_item] call A3PL_Inventory_Clear;
        [player, _var, -1] remoteExec ["Server_Inventory_Add", 2];
        [format[localize"STR_CRIMINAL_YOUDONTPHOTOCOPYTHISBLUEPRINT",_var]] call A3PL_Player_notification;
    };
}] call Server_Setup_Compile;

["A3PL_Criminal_SuicideVest",
{
	private _nearP = player nearEntities ["Man", 10];
	private _suicide = "Bo_Mk82" createVehicle [0,0,9999];
	_suicide setPos (getPos player);
	_suicide setVelocity [100,0,0];
	{
		[_x,[-5000]] call A3PL_Medical_ApplyVar;
	} foreach _nearP;
	removeVest player;
}] call Server_Setup_Compile;

['A3PL_Criminal_Drag',
{
	private ['_civ',"_dragged"];
	_civ = _this select 0;

	_dragged = _civ getVariable ["dragged",false];
	//stop dragging here
	if (_dragged) exitwith
	{
		_civ setVariable ["dragged",Nil,true];
	};

	if ((animationState _civ IN ["a3pl_handsupkneelcuffed","a3pl_handsupkneelkicked"]) || (surfaceIsWater position player)) then
	{
		[player] remoteExec ["A3PL_Criminal_DragReceive", _civ];
	} else {
		[localize"STR_NewPolice_8", "red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

['A3PL_Criminal_DragReceive',
{
	private ["_dragState","_crim"];
	_crim = param [0,objNull];

	[localize"STR_NewPolice_9", "red"] call A3PL_Player_Notification;
	player setVariable ["dragged",true,true];
	[player,""] remoteExec ["A3PL_Lib_SyncAnim", -2];
	["gesture_restrain"] call A3PL_Lib_Gesture;
	player forceWalk true;
	[_crim] spawn
	{
		private ["_var","_crim"];
		_crim = param [0,objNull];
		if (isNull _crim) exitwith {};
		while {(player getVariable ["dragged",false]) && (vehicle _crim isKindOf "Civilian_F")} do
		{
				uiSleep 2;
				if (isNull _crim) exitwith {};
				if (((player distance _crim) > 4) && (vehicle _crim isKindOf "Civilian_F")) then
				{
					player setposATL (getposATL _crim);
				};
		};
		[localize"STR_NewPolice_10", "red"] call A3PL_Player_Notification;
		player forceWalk false;
		["gesture_stop"] call A3PL_Lib_Gesture;
		[player,"a3pl_handsupkneelcuffed"] remoteExec ["A3PL_Lib_SyncAnim", -2];
	};
}] call Server_Setup_Compile;

["A3PL_Criminal_PickHandcuffs",{
	private ["_target"];
	_target = param [0,objNull];

	if (animationstate player == "Acts_carFixingWheel") exitwith {[localize"STR_CRIMINAL_YOUALREADYTAKEANACTION", "red"] call A3PL_Player_Notification;};
	if (!(vehicle player == player)) exitwith {[localize"STR_CRIMINAL_YOUCANTPICKVEHICLEINTOVEHICLE", "red"] call A3PL_Player_Notification;};
	if (Player_ActionDoing) exitwith {[localize"STR_CRIMINAL_YOUALREADYPICKVEHICLE", "red"] call A3PL_Player_Notification;};

	player playmove "Acts_carFixingWheel";
	player setVariable ["picking",true,true];
	[_target] spawn
	{
		private ["_target"];
		_target = param [0,objNull];
		if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
		["Lockpicking handcuffs...",3] spawn A3PL_Lib_LoadAction;
		_success = true;
		while {uiSleep 0.5; Player_ActionDoing } do {
			if ((player distance2D _target) > 5) exitWith {[localize"STR_CRIMINAL_NEEDTOBENEAR5M", "red"] call A3PL_Player_Notification; _success = false;};
			if (!(vehicle player == player)) exitwith {_success = false;};
			if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
			if (_target getVariable ["Incapacitated",false]) exitwith {_success = false;};
			if (!(player_itemClass == "v_lockpick")) exitwith {_success = false;};
			if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {_success = false;};
		};
		player switchMove "";
		if(Player_ActionInterrupted || !_success) exitWith {
			Player_ActionInterrupted = true;
			[localize"STR_CRIMINAL_PICKENDED", "red"] call A3PL_Player_Notification;
			if (vehicle player == player) then {player switchMove "";};
		};

		[player_item] call A3PL_Inventory_Clear;
		[player,"v_lockpick",-1] remoteExec ["Server_Inventory_Add",2];

		// 60% chance to unlock
		_chance = random 100;
		if(_chance >= 40) then {
			[_target] call A3PL_Police_Uncuff;
			[localize"STR_CRIMINAL_PICKSUCCESSFULLHC", "green"] call A3PL_Player_Notification;
			[player,20] call A3PL_Level_AddXP;
		} else {
			[localize"STR_CRIMINAL_YOUCANNOTPICKTHISVEHICLEHC", "red"] call A3PL_Player_Notification;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Criminal_CartelStart",
{
	private["_faction","_job"];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	_faction = player getVariable ["faction","citizen"];
	_job = player getVariable ["job","unemployed"];
	if(_faction != "cartel") exitWith {[localize "STR_A3PL_CRIMINAL_NOTCARTEL","Red"];};
 	if (_job == "cartel") exitwith {[localize "STR_A3PL_CRIMINAL_CARTELSTOP","Red"]; [] call A3PL_NPC_LeaveJob};
	player setVariable ["job","cartel"];
	[localize "STR_A3PL_CRIMINAL_CARTELSTART","Green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;