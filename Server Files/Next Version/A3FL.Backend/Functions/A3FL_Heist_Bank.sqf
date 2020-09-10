/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define MINCOPSREQUIRED 5
#define MONEYPERPILE 180000
#define MAXMONEYPERBAG 600000
#define BANKTIMER 600

["A3PL_CCTV_Open",
{
	if (!isPipEnabled) then {["CCTV does not work if PiP is disabled, change PiP to Ultra in video options to fix it"] call A3PL_Player_Notification;};
	disableSerialization;
	createDialog "Dialog_CCTV";
	private _distance = param [0,10000];
	private _display = findDisplay 27;
	A3PL_CCTV_ALL = nearestObjects [player, ["A3PL_CCTV"], _distance];
	{
		private _control = _display displayCtrl _x;
		{
			private _index = _control lbAdd format ["CCTV Camera %1",_forEachIndex+1];
			_control lbSetData [_index,format ["%1",_x]];
		} foreach A3PL_CCTV_ALL;
		_control lbSetCurSel _forEachIndex;
		switch (_x) do
		{
			case (2100): {_control ctrlAddEventHandler ["LBSelChanged",{[1,param [1,0]] call A3PL_CCTV_SetCamera}];};
			case (2101): {_control ctrlAddEventHandler ["LBSelChanged",{[2,param [1,0]] call A3PL_CCTV_SetCamera}];};
			case (2102): {_control ctrlAddEventHandler ["LBSelChanged",{[3,param [1,0]] call A3PL_CCTV_SetCamera}];};
			case (2103): {_control ctrlAddEventHandler ["LBSelChanged",{[4,param [1,0]] call A3PL_CCTV_SetCamera}];};
		};
	} foreach [2100,2101,2102,2103];

	_control = _display displayCtrl 2500; _control ctrlAddEventHandler ["CheckBoxesSelChanged",{[4,param [0,ctrlNull],param [2,0]] call A3PL_CCTV_SetVision;}];
	_control = _display displayCtrl 2501; _control ctrlAddEventHandler ["CheckBoxesSelChanged",{[1,param [0,ctrlNull],param [2,0]] call A3PL_CCTV_SetVision;}];
	_control = _display displayCtrl 2502; _control ctrlAddEventHandler ["CheckBoxesSelChanged",{[2,param [0,ctrlNull],param [2,0]] call A3PL_CCTV_SetVision;}];

	A3PL_CCTV_CAMOBJ_1 = "camera" camCreate (getpos player);
	A3PL_CCTV_CAMOBJ_2 = "camera" camCreate (getpos player);
	A3PL_CCTV_CAMOBJ_3 = "camera" camCreate (getpos player);
	A3PL_CCTV_CAMOBJ_4 = "camera" camCreate (getpos player);
	[1,0] call A3PL_CCTV_SetCamera;
	[2,1] call A3PL_CCTV_SetCamera;
	[3,2] call A3PL_CCTV_SetCamera;
	[4,3] call A3PL_CCTV_SetCamera;

	{
		private _rsRef = format ["A3PL_CCTV_%1_RT",_forEachIndex+1];
		_x cameraEffect ["INTERNAL", "BACK", _rsRef];
		_rsRef setPiPEffect [4];
		_x camCommit 0;
	} foreach [A3PL_CCTV_CAMOBJ_1,A3PL_CCTV_CAMOBJ_2,A3PL_CCTV_CAMOBJ_3,A3PL_CCTV_CAMOBJ_4];

	waitUntil {sleep 0.1; isNull _display};
	{
		_x cameraEffect ['TERMINATE', 'BACK'];
		camDestroy _x;
	} foreach [A3PL_CCTV_CAMOBJ_1,A3PL_CCTV_CAMOBJ_2,A3PL_CCTV_CAMOBJ_3,A3PL_CCTV_CAMOBJ_4];
	A3PL_CCTV_ALL = nil;
}] call Server_Setup_Compile;

//COMPILE BLOCK FUNCTION
["A3PL_CCTV_SetCamera",
{
	private _camNum = param [0,1];
	private _mapCam = A3PL_CCTV_ALL select (param [1,0]);
	private _camera = call compile format ["A3PL_CCTV_CAMOBJ_%1",_camNum];
	_camera attachto [_mapCam,(_mapCam selectionPosition "cam_pos")];
	_camera CamSetTarget (_mapCam modelToWorld (_mapCam selectionPosition "cam_dir"));
	_camera camCommit 0;
},false,true] call Server_Setup_Compile;

["A3PL_CCTV_SetVision",
{
	disableSerialization;
	private _mode = param [0,4];
	private _control = param [1,ctrlNull];
	private _checked = param [2,0];
	if (_checked isEqualTo 0) exitwith {};
	{
		_rsRef = format ["A3PL_CCTV_%1_RT",_x];
		_rsRef setPiPEffect [_mode];
	} foreach [1,2,3,4];
	_display = findDisplay 27;
	{
		_ctrl = _display displayCtrl _x;
		if (_ctrl != _control) then {_ctrl ctrlSetChecked false;};
	} foreach [2500,2501,2502];
}] call Server_Setup_Compile;

["A3PL_BHeist_SetDrill",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _bank = param [0,objNull];
	if (typeOf _bank != "Land_A3PL_Bank") exitwith {["You are not looking at the bank vault","red"] call A3PL_Player_Notification;};
	private _timer = false;
	if (!isNil {_bank getVariable ["timer",nil]}) then {
		if (((serverTime - (_bank getVariable ["timer",0]))) < BANKTIMER) then {_timer = true};
	};
	if (_timer) exitwith {[format ["The bank has recently been robbed, try again in %1 seconds",BANKTIMER - ((_bank getVariable ["timer",0]) - serverTime)],"red"] call A3PL_Player_Notification;};
	if (_bank animationSourcePhase "door_bankvault" > 0) exitwith {["The bank vault is already open","red"] call A3PL_Player_Notification;};
	if (backpack player != "A3PL_Backpack_Drill") exitwith {["You are not carrying a drill in your backpack","red"] call A3PL_Player_Notification;};
	private _drill = "A3PL_Drill_Bank" createvehicle (getpos player);
	_drill setdir (getdir _bank)-90;
	_drill setpos (_bank modelToWorld [-5.05,4.38,-2.1]);
	removeBackpack player;
}] call Server_Setup_Compile;

["A3PL_BHeist_PickupDrill",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _drill = param [0,objNull];
	if (typeOf _drill != "A3PL_Drill_Bank") exitwith {["You are not looking at the drill","red"] call A3PL_Player_Notification;};
	if (backpack player != "") exitwith {["You are wearing a backpack already, you need to drop what you have on your back first!","red"] call A3PL_Player_Notification;};
	deleteVehicle _drill;
	player addBackpack "A3PL_Backpack_Drill";
}] call Server_Setup_Compile;

["A3PL_BHeist_InstallBit",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _drill = param [0,objNull];
	if (typeOf _drill != "A3PL_Drill_Bank") exitwith {["You are not looking at the drill","red"] call A3PL_Player_Notification;};
	if (_drill animationPhase "drill_bit" < 0.5) then {
		if (Player_ItemClass != "drill_bit") exitwith {["You are not carrying a drill bit in your hand","red"] call A3PL_Player_Notification;};
		[] call A3PL_Inventory_Clear;
		["drill_bit", -1] call A3PL_Inventory_Add;
		_drill animate ["drill_bit",1];
	} else {
		["You disconnected the drill bit, it has been placed in your inventory","green"] call A3PL_Player_Notification;
		["drill_bit", 1] call A3PL_Inventory_Add;
		_drill animate ["drill_bit",0];
	};
}] call Server_Setup_Compile;

["A3PL_BHeist_StartDrill",
{
	private ["_drill","_bank","_timeOut","_newDrillValue","_drillValue","_holder","_cops"];
	_drill = param [0,objNull];
	_fail = false;
	_faction = "FISD";
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	_nearCity = text ((nearestLocations [player, ["NameCityCapital","NameCity","NameVillage"], 5000]) select 0);

	if(_nearCity isEqualTo "Lubbock") then {
		if ((count(["uscg"] call A3PL_Lib_FactionPlayers)) < MINCOPSREQUIRED) exitwith {_fail=true;_faction="USCG";};
	} else {
		if ((count(["fisd"] call A3PL_Lib_FactionPlayers)) < MINCOPSREQUIRED) exitwith {_fail=true;_faction="FISD";};
	};

	if(_fail) exitWith {[format ["There needs to be a minimum of %1 %2 online to rob the bank!",MINCOPSREQUIRED,_faction],"red"] call A3PL_Player_Notification;};

	if (typeOf _drill != "A3PL_Drill_Bank") exitwith {["You are not looking at the drill","red"] call A3PL_Player_Notification;};
	if (_drill animationPhase "drill_bit" < 1) exitwith {["Drill bit has not been installed","red"] call A3PL_Player_Notification;};
	if (_drill animationSourcePhase "drill_handle" > 0) exitwith {["Drill has already been started","red"] call A3PL_Player_Notification;};
	_robTime = missionNamespace setVariable ["BankCooldown",0];
	if(_robTime >= (diag_Ticktime-7200)) exitWith {["A bank has already been robbed less than 2 hours ago","red"] call A3PL_Player_Notification;};

	_bank = (nearestObjects [player, ["Land_A3PL_Bank"], 15]) select 0;
	[getPlayerUID player,"bankRobbery",[getPos _bank]] remoteExec ["Server_Log_New",2];

	[format["!!! ALERT !!! A bank is being robbed at %1 !", _nearCity],"green","fisd",3] call A3PL_Lib_JobMessage;
	if(_nearCity isEqualTo "Lubbock") then {
		[format["!!! ALERT !!! A bank is being robbed at %1 !", _nearCity],"green","uscg",3] call A3PL_Lib_JobMessage;
	};

	missionNamespace setVariable ["BankCooldown",diag_Ticktime,true];
	playSound3D ["A3PL_Common\effects\bankalarm.ogg", _bank, true, _bank, 3, 1, 250];

	_drill animateSource ["drill_handle",1];
	playSound3D ["A3PL_Common\effects\bankdrill.ogg", _drill, true, _drill, 3, 1, 100];
	_timeOut = (getNumber (configFile >> "CfgVehicles" >> "A3PL_Drill_Bank" >> "animationSources" >> "drill_handle" >> "animPeriod"));
	_drillValue = 0;
	["Vault drilling started","green"] call A3PL_Player_Notification;
	while {uiSleep 1; ((_drill animationSourcePhase "drill_handle") < 1)} do
	{
		_newDrillValue = _drill animationSourcePhase "drill_handle";
		if (_newDrillValue <= _drillValue) exitwith {};
		if (isNull _drill) exitwith {};
		_drillValue = _newDrillValue;
	};
	if (((_drill animationSourcePhase "drill_handle") < 1) OR (isNull _drill)) exitwith {["Drilling cancelled",code_red] call A3PL_Player_Notification;}; //for some reason drilling failed

	_bank animateSource ["door_bankvault",1];

	_bank setVariable ["timer",serverTime,true];
	uiSleep 1;
	deleteVehicle _drill;
	["Drilling completed. The drill and the drill bit both unfortunatly broke during drilling.","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_BHeist_OpenDeposit",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _bank = param [0,objNull];
	private _name = param [1,""];
	private _depositNr = parseNumber ((_name splitString "_") select 1);
	if ((_bank animationSourcePhase "door_bankvault") < 0.95) exitwith {["The bank vault is closed, are you trying to open the deposit box through the walls...?"] call A3PL_Player_Notification;};
	if (Player_ActionDoing) exitwith {["You are already doing something","red"] call A3PL_Player_Notification;};
	["Lockpicking...",45] spawn A3PL_Lib_LoadAction;
	_success = true;
	waitUntil{Player_ActionDoing};
	player playMoveNow 'Acts_carFixingWheel';
	while {Player_ActionDoing} do {
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if ((vehicle player) != player) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
		if ((animationstate player) != "Acts_carFixingWheel") then {player playMoveNow 'Acts_carFixingWheel';};
	};
	player playMoveNow "";
	if(Player_ActionInterrupted || !_success) exitWith {["Lockpicking failed","red"] call A3PL_Player_Notification;};

	if (_bank animationPhase _name <= (0.01)) then {
		_random = random 100;
		if(_random >= 65) then {
			_cash = createVehicle ["A3PL_PileCash", position player, [], 0, "CAN_COLLIDE"];
			_cashOffset = [[-0.6,5.17,-1.4],[-0.6,5.17,-1.73],[-0.6,5.17,-2.05],[-0.6,5.17,-2.4],[-0.6,5.17,-2.7],[-0.6,4.7,-1.4],[-0.6,4.7,-1.73],[-0.6,4.7,-2.05],[-0.6,4.7,-2.4],[-0.6,4.7,-2.7],[-0.6,4.2,-1.4],[-0.6,4.2,-1.73],[-0.6,4.2,-2.05],[-0.6,4.2,-2.4],[-0.6,4.2,-2.7],[-0.6,3.72,-1.4],[-0.6,3.72,-1.73],[-0.6,3.72,-2.05],[-0.6,3.72,-2.4],[-0.6,3.72,-2.7]] select (_depositNr-1);
			_cash setpos (_bank modelToWorld _cashOffset);
		};
		_bank animate [_name,1];
	} else {
		["This deposit box has already been opened","red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_BHeist_CloseVault",
{
	private _bank = param [0,objNull];
	private _factions = ["fisd","uscg"];
	if (!((player getVariable ["job","unemployed"]) IN _factions)) exitwith {["Only an on-duty sheriff can secure the vault door","red"] call A3PL_Player_Notification;};
	if ((_bank animationSourcePhase "door_bankvault") < 0.95) exitwith {["The bank vault is already closed, you can't secure it"] call A3PL_Player_Notification;};
	_bank animateSource ["door_bankvault",0];
	for "_i" from 0 to 20 do {
		_bank animate [format ["deposit_%1",_i],0];
	};
	{deleteVehicle _x;} foreach (nearestObjects [_bank, ["A3PL_PileCash"], 20]);
	[player, 50] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_BHeist_PickCash",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_cashPile","_container"];
	_cashPile = param [0,objNull];

	if (backpack player != "A3PL_Backpack_Money") exitwith {["You are not carrying a backpack to carry money in!","red"] call A3PL_Player_Notification;};
	_container = backpackContainer player;

	if (((_container getVariable ["bankCash",0]) + MONEYPERPILE) > MAXMONEYPERBAG) exitwith {["My bag is full of cash, I can't fit more money into the bag!","red"] call A3PL_Player_Notification;};

	if (Player_ActionDoing) exitwith {["You are already performing an action","red"] call A3PL_Player_Notification;};
	["Filling bag with money...",10] spawn A3PL_Lib_LoadAction;
	waitUntil {sleep 0.1; Player_ActionCompleted};
	Player_ActionCompleted = false;

	if (backpack player != "A3PL_Backpack_Money") exitwith {["You are not carrying a backpack to carry money in!","red"] call A3PL_Player_Notification;};
	_container = backpackContainer player;
	if (((_container getVariable ["bankCash",0]) + MONEYPERPILE) > MAXMONEYPERBAG) exitwith {["My bag is full of cash, I can't fit more money into the bag!","red"] call A3PL_Player_Notification;};
	if (isNull _cashPile) exitwith {};

	deleteVehicle _cashPile;
	_container setVariable ["bankCash",(_container getVariable ["bankCash",0]) + MONEYPERPILE,true];
}] call Server_Setup_Compile;

["A3PL_BHeist_ConvertCash",
{
	private _NPC = param [0,objNull];
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	if (backpack player != "A3PL_Backpack_Money") exitwith {["You are not carrying a backpack to carry money in!","red"] call A3PL_Player_Notification;};
	private _container = backpackContainer player;
	private _cash = _container getVariable ["bankCash",0];
	if (_cash < 1) exitwith {["There is no dirty money in this backpack to convert to real cash","red"] call A3PL_Player_Notification;};

	["Laundering money...",180] spawn A3PL_Lib_LoadAction;
	waitUntil{Player_ActionDoing};
	_success = true;
	while {Player_ActionDoing} do {
		if (Player_ActionInterrupted) exitWith {_success = false;};
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if (!((vehicle player) isEqualTo player)) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
	};
	if(Player_ActionInterrupted || !_success) exitWith {["Action interupted","red"] call A3PL_Player_Notification;};

	player setVariable ["player_cash",(player getVariable ["player_cash",0])+_cash * A3PL_Event_CrimePayout,true];
	_container setVariable ["bankCash",nil,true];
	[getPlayerUID player,"moneyLaundering",[str(_cash)]] remoteExec ["Server_Log_New",2];
	[format ["You converted $%1 dirty money into laundered money, the cash is now in your inventory",_cash],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_BHeist_CheckCash",
{
	if (backpack player != "A3PL_Backpack_Money") exitwith {};
	private _container = backpackContainer player;
	[format ["There is $%1 of dirty money inside this backpack",(_container getVariable ["bankCash",0])],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
