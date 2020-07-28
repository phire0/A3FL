["A3PL_Jewelry_SetDrill",
{
    if(!(call A3PL_Player_AntiSpam)) exitWith {};
    _store = param [0,objNull];
    if (typeOf _store != "Land_A3FL_Fishers_Jewelry") exitwith {["You are not looking at the vault","red"] call A3PL_Player_Notification;};

    _timer = false;
    if (!isNil {_store getVariable ["timer",nil]}) then
    {
        if (((serverTime - (_store getVariable ["timer",0]))) < JEWLRYTIMER) then {_timer = true};
    };
    if (_timer) exitwith {[format ["The store has recently been robbed, try again in %1 seconds",JEWLRYTIMER - ((_store getVariable ["timer",0]) - serverTime)],"red"] call A3PL_Player_Notification;};
    if (_store animationSourcePhase "jewl_vault" > 0) exitwith {["The bank vault is already open","red"] call A3PL_Player_Notification;};
    if (backpack player != "A3PL_Backpack_Drill") exitwith {["You are not carrying a drill in your backpack","red"] call A3PL_Player_Notification;};

    _drill = "A3PL_Drill_Bank" createvehicle (getpos player);
    _drill attachto [player_objintersect,[-0.35,0,-0.19],"Vault_Lock"]; 
    _drill setdir (getdir player_objintersect) - 90;

    removeBackpack player;
}] call Server_Setup_Compile;


["A3PL_Jewelry_PickCash",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_cashPile","_container"];
	_cashPile = param [0,objNull];

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
	if (!((player getVariable ["job","unemployed"]) IN _factions)) exitwith {["Only an on-duty sheriff can secure the vault","red"] call A3PL_Player_Notification;};
	if ((_store animationSourcePhase "jewl_vault") < 0.95) exitwith {["Close the vault before securing it!"] call A3PL_Player_Notification;};

	[_store,"Vualt_Handle",false] call A3PL_Lib_ToggleAnimation;
	_store setVariable ["CanOpenSafe",false,true];

	{deleteVehicle _x;} foreach (nearestObjects [_store, ["A3PL_PileCash"], 20]);
	[player, 50] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_Jewlery_StartDrill",
{
	_drill = param [0,objNull];
	_fail = false;
	_faction = "FISD";
	_copsRequired = 7;
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	_nearCity = text ((nearestLocations [player, ["NameCityCapital","NameCity","NameVillage"], 5000]) select 0);

	if(_nearCity isEqualTo "Lubbock") then {
		if ((count(["uscg"] call A3PL_Lib_FactionPlayers)) < _copsRequired) exitwith {_fail=true;_faction="USCG";};
	} else {
		if ((count(["fisd"] call A3PL_Lib_FactionPlayers)) < _copsRequired) exitwith {_fail=true;_faction="FISD";};
	};

	if(_fail) exitWith {[format ["There needs to be a minimum of %1 %2 online to rob the Jewelry Store!",_copsRequired,_faction],"red"] call A3PL_Player_Notification;};

	if (typeOf _drill != "A3PL_Drill_Bank") exitwith {["You are not looking at the drill","red"] call A3PL_Player_Notification;};
	if (_drill animationPhase "drill_bit" < 1) exitwith {["Drill bit has not been installed","red"] call A3PL_Player_Notification;};
	if (_drill animationSourcePhase "drill_handle" > 0) exitwith {["Drill has already been started","red"] call A3PL_Player_Notification;};
	_robTime = missionNamespace setVariable ["BankCooldown",0];
	if(_robTime >= (diag_Ticktime-7200)) exitWith {["A bank has already been robbed less than 2 hours ago","red"] call A3PL_Player_Notification;};


	_store = (nearestObjects [player, ["Land_A3FL_Fishers_Jewelry"], 15]) select 0;
	[getPlayerUID player,"jewelryRobbery",[getPos _bank]] remoteExec ["Server_Log_New",2];

	[format["!!! ALERT !!! A jewelry store is being robbed at %1 !", _nearCity],"green","fisd",3] call A3PL_Lib_JobMessage;

	if(_nearCity isEqualTo "Lubbock") then {
	[format["!!! ALERT !!! A jewelry store is being robbed at %1 !", _nearCity],"green","uscg",3] call A3PL_Lib_JobMessage;
	};

	missionNamespace setVariable ["JewleryCooldown",diag_Ticktime,true];

	playSound3D ["A3PL_Common\effects\bankalarm.ogg", _bank, true, _bank, 3, 1, 250];

	_drill animateSource ["drill_handle",1];
	playSound3D ["A3PL_Common\effects\bankdrill.ogg", _drill, true, _drill, 3, 1, 100];
	_timeOut = (getNumber (configFile >> "CfgVehicles" >> "A3PL_Drill_Bank" >> "animationSources" >> "drill_handle" >> "animPeriod"));
	_drillValue = 0;
	["Safe drilling started","green"] call A3PL_Player_Notification;
	while {uiSleep 1; ((_drill animationSourcePhase "drill_handle") < 1)} do
	{
		_newDrillValue = _drill animationSourcePhase "drill_handle";
		[format ["Safe drilling progress %2%1","%",round (((_newDrillValue*_timeOut)/_timeOut)*100)],"green"] call A3PL_Player_Notification;
		if (_newDrillValue <= _drillValue) exitwith {};
		if (isNull _drill) exitwith {};
		_drillValue = _newDrillValue;
	};
	if (((_drill animationSourcePhase "drill_handle") < 1) OR (isNull _drill)) exitwith {["Drilling cancelled",code_red] call A3PL_Player_Notification;};

	_store setVariable ["CanOpenSafe",true,true];

	_store setVariable ["timer",serverTime,true];
	uiSleep 1;
	deleteVehicle _drill;
	["Drilling completed. The drill and the drill bit both unfortunatly broke during drilling.","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Jewelry_BreakGlass",
{
	private _object = param [0,player_objIntersect];
	private _name = param [1,player_nameIntersect];
	_object animate [_name,1];
	playSound3D ["A3\Sounds_F\arsenal\sfx\bullet_hits\glass_07.wss", player, true, getPosASL player, 4, 50];
	sleep 3;
	_alarm = _object getVariable["triggered",false];
	if(!_alarm) then {
		_object setVariable["triggered",true,true];
		playSound3D ["A3PL_Common\effects\burglaralarm.ogg", _object, false, getPosASL _object, 1, 1, 300];
		_cops = ["fisd"] call A3PL_Lib_FactionPlayers;
		[_object] remoteExec ["A3PL_Store_Robbery_Alert", _cops];
	};
}] call Server_Setup_Compile;

["A3PL_Jewelry_PickJewlery",
{
	private _object = param [0,player_objIntersect];
	private _name = param [1,player_nameIntersect];
	private _time = 10;
	private _items = [];
	switch(_name) do {
		case("jewlery_case_1"): {
			_time = 30;
			_items = [
				["diamond",1]
			];
		};
		case("jewlery_case_2"): {
			_time = 30;
			_items = [
				["diamond",1]
			];
		};
		case("jewlery_case_3"): {
			_time = 30;
			_items = [
				["diamond",1]
			];
		};
		case("jewlery_case_4"): {
			_time = 15;
			_items = [
				["diamond",1]
			];
		};
		case("jewlery_case_5"): {
			_time = 15;
			_items = [
				["diamond",1]
			];
		};
		case("jewlery_case_6"): {
			_time = 15;
			_items = [
				["diamond",1]
			];
		};
		case("jewlery_case_7"): {
			_time = 45;
			_items = [
				["diamond",1]
			];
		};
		case("jewlery_case_8"): {
			_time = 45;
			_items = [
				["diamond",1]
			];
		};
		case("jewlery_case_9"): {
			_time = 45;
			_items = [
				["diamond",1]
			];
		};
	};

	if (Player_ActionDoing) exitwith {["You are already doing an action","red"] call A3PL_Player_Notification;};
	["Stealing Jewlery...",_time] spawn A3PL_Lib_LoadAction;
	_success = true;
	waitUntil{Player_ActionDoing};
	while {Player_ActionDoing} do {
		if ((player distance2D (_object modelToWorldVisual (_object selectionPosition [_name,"Memory"]))) > 3) exitwith {_success = false};
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
		if ((animationState player) isEqualTo "amovpercmstpsnonwnondnon") then {[player,"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown"] remoteExec ["A3PL_Lib_SyncAnim",0];};
	};
	player playMoveNow "";
	if(Player_ActionInterrupted || !_success) exitWith {["Action cancelled","red"] call A3PL_Player_Notification;};

	{
		private _class = _x select 0;
		private _amount = _x select 1;
		[_class,_amount] call A3PL_Inventory_Add;
	} foreach _items;
	_object animate [_name,1];
	["You stole the jewlery!","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;