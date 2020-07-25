["A3PL_Jewelry_SetDrill",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	_store = param [0,objNull];
	if (typeOf _store != "Land_Land_A3FL_Fishers_Jewelry") exitwith {["You are not looking at the vault","red"] call A3PL_Player_Notification;};

	_timer = false;
	if (!isNil {_store getVariable ["timer",nil]}) then
	{
		if (((serverTime - (_store getVariable ["timer",0]))) < JEWLRYTIMER) then {_timer = true};
	};
	if (_timer) exitwith {[format ["The store has recently been robbed, try again in %1 seconds",JEWLRYTIMER - ((_store getVariable ["timer",0]) - serverTime)],"red"] call A3PL_Player_Notification;};
	if (_store animationSourcePhase "jewl_vault" > 0) exitwith {["The bank vault is already open","red"] call A3PL_Player_Notification;};
	if (backpack player != "A3PL_Backpack_Drill") exitwith {["You are not carrying a drill in your backpack","red"] call A3PL_Player_Notification;};

	_drill = "A3PL_Drill_Bank" createvehicle (getpos player);
	_drill setdir (getdir _store)-90;
	_drill attachto [_store,[],"Vault_Lock"];

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
	if (((_drill animationSourcePhase "drill_handle") < 1) OR (isNull _drill)) exitwith {["Drilling cancelled",code_red] call A3PL_Player_Notification;}; //for some reason drilling failed

	_store setVariable ["CanOpenSafe",true,true];

	_store setVariable ["timer",serverTime,true];
	uiSleep 1;
	deleteVehicle _drill;
	["Drilling completed. The drill and the drill bit both unfortunatly broke during drilling.","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
