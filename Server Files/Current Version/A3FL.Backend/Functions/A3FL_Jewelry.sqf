#define JEWLRYTIMER 7200

["A3PL_Jewelry_SetDrill",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _store = param [0,objNull];
	private _timer = false;
	if (!isNil {_store getVariable ["timer",nil]}) then {
		if (((serverTime - (_store getVariable ["timer",0]))) < JEWLRYTIMER) then {_timer = true};
	};
	if (_timer) exitwith {[format ["The store has recently been robbed, try again in %1 seconds",JEWLRYTIMER - ((_store getVariable ["timer",0]) - serverTime)],"red"] call A3PL_Player_Notification;};
	if (_store animationSourcePhase "Vault_Door" > 0) exitwith {["The bank vault is already open","red"] call A3PL_Player_Notification;};
	if (backpack player != "A3PL_Backpack_Drill") exitwith {["You are not carrying a drill in your backpack","red"] call A3PL_Player_Notification;};

	private _lockPos = (_store modelToWorld (_store selectionPosition ["Vault_Lock","Memory"]));
	private _drill = "A3PL_Drill_Bank" createvehicle (getpos player);
	_drill setpos [(_lockPos select 0),(_lockPos select 1) - 0.2,(_lockPos select 2) - 0.23]; 
	_drill setdir (getdir _store) - 90;

	removeBackpack player;
}] call Server_Setup_Compile;

["A3PL_Jewelry_PickCash",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _cashPile = param [0,objNull];
	if (Player_ActionDoing) exitwith {["You are already performing an action","red"] call A3PL_Player_Notification;};
	["Picking up money...",10] spawn A3PL_Lib_LoadAction;
	waitUntil {sleep 0.1; Player_ActionCompleted};
	Player_ActionCompleted = false;
	if (isNull _cashPile) exitwith {};
	deleteVehicle _cashPile;
	["dirty_cash",3000 + round(10000)] call A3PL_Inventory_Add;
}] call Server_Setup_Compile;

["A3PL_Jewelry_CloseVault",
{
	private _store = param [0,objNull];
	private _factions = ["fisd","uscg"];
	if (!((player getVariable ["job","unemployed"]) IN _factions)) exitwith {["Only an on-duty LEO can secure the vault","red"] call A3PL_Player_Notification;};
	if ((_store animationSourcePhase "Vault_Door") < 0.95) exitwith {["Close the vault before securing it!"] call A3PL_Player_Notification;};

	[_store,"Vualt_Handle",false] call A3PL_Lib_ToggleAnimation;
	_store setVariable ["CanOpenSafe",false,true];

	{deleteVehicle _x;} foreach (_store nearEntities [["A3PL_PileCash"],20]);
	[player, 50] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_Jewelry_StartDrill",
{
	private _drill = param [0,player_objintersect];
	private _copsRequired = 6;
	private _nearCity = text ((nearestLocations [player, ["NameCityCapital","NameCity","NameVillage"], 5000]) select 0);
	
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	if ((count(["fisd"] call A3PL_Lib_FactionPlayers)) < _copsRequired) exitwith {[format ["There needs to be a minimum of %1 SD officers online to rob the Jewelry Store!",_copsRequired],"red"] call A3PL_Player_Notification;};
	if (typeOf _drill != "A3PL_Drill_Bank") exitwith {["You are not looking at the drill","red"] call A3PL_Player_Notification;};
	if (_drill animationPhase "drill_bit" < 1) exitwith {["Drill bit has not been installed","red"] call A3PL_Player_Notification;};
	if (_drill animationSourcePhase "drill_handle" > 0) exitwith {["Drill has already been started","red"] call A3PL_Player_Notification;};
	_robTime = missionNamespace setVariable ["BankCooldown",0];
	if(_robTime >= (diag_Ticktime-7200)) exitWith {["A bank has already been robbed less than 2 hours ago","red"] call A3PL_Player_Notification;};


	private _store = (nearestObjects [player, ["Land_A3FL_Fishers_Jewelry"], 15]) select 0;
	[getPlayerUID player,"jewelryRobbery",[getPos _store]] remoteExec ["Server_Log_New",2];
	[format["!!! ALERT !!! A jewelry store is being robbed at %1 !", _nearCity],"green","fisd",3] call A3PL_Lib_JobMessage;

	missionNamespace setVariable ["JewelryCooldown",diag_Ticktime,true];
	playSound3D ["A3PL_Common\effects\bankalarm.ogg", _store, true, _store, 3, 1, 250];

	_drill animateSource ["drill_handle",1];
	playSound3D ["A3PL_Common\effects\bankdrill.ogg", _drill, true, _drill, 3, 1, 100];
	_timeOut = (getNumber (configFile >> "CfgVehicles" >> "A3PL_Drill_Bank" >> "animationSources" >> "drill_handle" >> "animPeriod"));
	_drillValue = 0;
	["Safe drilling started","green"] call A3PL_Player_Notification;
	while {uiSleep 1; ((_drill animationSourcePhase "drill_handle") < 1)} do
	{
		_newDrillValue = _drill animationSourcePhase "drill_handle";
		if (_newDrillValue <= _drillValue) exitwith {};
		if (isNull _drill) exitwith {};
		_drillValue = _newDrillValue;
	};
	if (((_drill animationSourcePhase "drill_handle") < 1) OR (isNull _drill)) exitwith {["Drilling cancelled",code_red] call A3PL_Player_Notification;};

	_store setVariable ["CanOpenSafe",true,true];
	_store setVariable ["timer",serverTime,true];
	sleep 1;
	deleteVehicle _drill;
	["Drilling completed. The drill and the drill bit both unfortunatly broke during drilling.","green"] call A3PL_Player_Notification;
	[_store] call A3PL_Jewelry_LoadSafe;
}] call Server_Setup_Compile;

["A3PL_Jewelry_LoadSafe",
{
	private _store = param [0,objNull];
	private _itemList = ["diamond_ill","diamond_emerald_ill","diamond_ruby_ill","diamond_sapphire_ill","diamond_alex_ill","diamond_aqua_ill","diamond_tourmaline_ill"];
	for "_i" from 1 to 16 do {
		_point = format["safe_item_%1",_i];
		_class = selectRandom _itemList;
		_item = createVehicle [(([_class,"class"]) call A3PL_Config_GetItem), position player, [], 0, "CAN_COLLIDE"];
		_item setpos (_store modelToWorld (_store selectionPosition _point));
		_item enableSimulation false;
		_item setVariable ["class",_class,true];
	};
}] call Server_Setup_Compile;

["A3PL_Jewelry_GlassDamage",
{
	private _intersect = missionNameSpace getVariable ["player_objintersect",objNull];
	private _nameIntersect = missionNameSpace getVariable ["player_nameintersect",""];
	private _cops = ["fisd"] call A3PL_Lib_FactionPlayers;
	if(count(_cops) < 3) exitWith {["There is not enough Sheriffs on duty at this time to break the glass","red"] call A3PL_Player_Notification;};
	if (player distance (_intersect modelToWorld (_intersect selectionPosition _nameIntersect)) < 2) then
	{
		private _var = format ["damage_%1",_nameintersect];
		private _damage = (_intersect getVariable [_var,0]);
		_intersect setVariable [_var,_damage + 0.35,false];
		if (_damage >= 1) exitwith {
			[_intersect,_nameIntersect] spawn A3PL_Jewelry_BreakGlass;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Jewelry_BreakGlass",
{
	private _object = param [0,player_objIntersect];
	private _name = param [1,player_nameIntersect];
	private _cops = ["fisd"] call A3PL_Lib_FactionPlayers;
	_object animate [_name,1];
	playSound3D ["A3\Sounds_F\arsenal\sfx\bullet_hits\glass_07.wss", player, true, getPosASL player, 4, 1, 20];
	sleep 1;
	playSound3D ["A3PL_Common\effects\burglaralarm.ogg", _object, false, _object modelToWorldVisual (_object selectionPosition [_name,"Memory"]), 1, 1, 300];
	[_object] remoteExec ["A3PL_Store_Robbery_Alert", _cops];
	[getPlayerUID player,"jewelryGlassBroke",[_name]] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_Jewelry_PickJewelry",
{
	private _object = param [0,player_objIntersect];
	private _name = param [1,player_nameIntersect];
	private _time = 10;
	private _items = [];

	if (Player_ActionDoing) exitwith {["You are already doing an action","red"] call A3PL_Player_Notification;};
	if (_object getVariable[_name,false]) exitWith {["Someone is already collecting this","red"] call A3PL_Player_Notification;};
	_object setVariable[_name,true,true];
	switch(_name) do {
		case("jewlery_case_1"): {
			_time = 45;
			_items = [
				["ringset",4],
				["ring",2],
				["bracelet",2]
			];
		};
		case("jewlery_case_2"): {
			_time = 45;
			_items = [
				["ringset",4],
				["ring",2],
				["bracelet",2]
			];
		};
		case("jewlery_case_3"): {
			_time = 45;
			_items = [
				["ringset",4],
				["ring",2],
				["bracelet",2]
			];
		};
		case("jewlery_case_4"): {
			_time = 30;
			_items = [
				["crown",1]
			];
		};
		case("jewlery_case_5"): {
			_time = 30;
			_items = [
				["necklace",1]
			];
		};
		case("jewlery_case_6"): {
			_time = 30;
			_items = [
				["golden_dildo",1]
			];
		};
		case("jewlery_case_7"): {
			_time = 60;
			_items = [
				["ringset",9],
				["ring",6],
				["bracelet",4]
			];
		};
		case("jewlery_case_8"): {
			_time = 60;
			_items = [
				["ringset",9],
				["ring",6],
				["bracelet",4]
			];
		};
		case("jewlery_case_9"): {
			_time = 60;
			_items = [
				["ringset",9],
				["ring",6],
				["bracelet",4]
			];
		};
	};

	if (currentWeapon player != "") then {
		A3PL_Holster = currentWeapon player;
		player action ["SwitchWeapon", player, player, 100];
		player switchCamera cameraView;
	};

	["Stealing Jewelry...",_time] spawn A3PL_Lib_LoadAction;
	waitUntil{Player_ActionDoing};
	while {Player_ActionDoing} do {
		if ((player distance2D (_object modelToWorldVisual (_object selectionPosition [_name,"Memory"]))) > 3) exitwith {Player_ActionInterrupted = true};
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {Player_ActionInterrupted = true;};
		if (player getVariable ["Incapacitated",false]) exitwith {Player_ActionInterrupted = true;};
		if ((animationState player) isEqualTo "amovpercmstpsnonwnondnon") then {[player,"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown"] remoteExec ["A3PL_Lib_SyncAnim",0];};
	};
	player playMoveNow "";
	if(Player_ActionInterrupted) exitWith {["Action cancelled","red"] call A3PL_Player_Notification;_object setVariable[_name,nil,true];};

	{
		private _class = _x select 0;
		private _amount = _x select 1;
		[_class,_amount] call A3PL_Inventory_Add;
	} foreach _items;
	_object animate [_name,1];
	_object setVariable[_name,nil,true];
	["You stole the jewelry!","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Jewelry_HandleDoor",
{
	private _store = param [0,objNull];
	private _name = param [1,""];
	if (_name IN ["door_1","door_2"]) exitwith {[_store,_name,false] call A3PL_Lib_ToggleAnimation;};
	if (!(player getVariable["job","unemployed"] IN ["fims","fisd","uscg"]) && !(["keycard",1] call A3PL_Inventory_Has)) exitwith {["You cannot use this button!","red"] call A3PL_Player_Notification;};
	if (_name IN ["jewelry_3_button","jewelry_3_button2","jewelry_4_button","jewelry_4_button2","jewelry_5_button","jewelry_5_button2"]) exitwith {
		private _anim = switch (_name) do
		{
			case "jewelry_3_button": {[_store,"door_3",false] call A3PL_Lib_ToggleAnimation;};
			case "jewelry_3_button2": {[_store,"door_3",false] call A3PL_Lib_ToggleAnimation;};
			case "jewelry_4_button": {[_store,"door_4",false] call A3PL_Lib_ToggleAnimation;};
			case "jewelry_4_button2": {[_store,"door_4",false] call A3PL_Lib_ToggleAnimation;};
			case "jewelry_5_button": {
				[_store,"door_5",false] call A3PL_Lib_ToggleAnimation;
				[_store,"door_6",false] call A3PL_Lib_ToggleAnimation;
			};
			case "jewelry_5_button2": {
				[_store,"door_5",false] call A3PL_Lib_ToggleAnimation;
				[_store,"door_6",false] call A3PL_Lib_ToggleAnimation;
			};
		};
	};
}] call Server_Setup_Compile;