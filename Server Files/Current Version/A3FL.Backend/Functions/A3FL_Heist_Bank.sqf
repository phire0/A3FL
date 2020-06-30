/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define MINCOPSREQUIRED 5
#define MONEYCHANCE 50
#define GEMCHANCE 30
#define MONEYPERPILE 180000
#define MAXMONEYPERBAG 540000
#define BANKTIMER 600

["A3PL_CCTV_Open",
{
	private ["_veh"];
	_distance = param [0,10000];

	disableSerialization;
	private ["_display"];

	createDialog "Dialog_CCTV";
	_display = findDisplay 27;

	//Check pip
	if (!isPipEnabled) then {["CCTV does not work if PiP is disabled, change PiP to Ultra in video options to fix it"] call A3PL_Player_Notification;};

	//Get all the cameras we can select
	A3PL_CCTV_ALL = nearestObjects [player, ["A3PL_CCTV"], _distance];
	{
		private ["_control"];
		_control = _display displayCtrl _x;
		{
			private ["_index"];
			_index = _control lbAdd format ["CCTV Camera %1",_forEachIndex+1];
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
	} foreach [2100,2101,2102,2103]; //idd of combo boxes

	//add eventhandler to check buttons
	_control = _display displayCtrl 2500; _control ctrlAddEventHandler ["CheckBoxesSelChanged",{[4,param [0,ctrlNull],param [2,0]] call A3PL_CCTV_SetVision;}];
	_control = _display displayCtrl 2501; _control ctrlAddEventHandler ["CheckBoxesSelChanged",{[1,param [0,ctrlNull],param [2,0]] call A3PL_CCTV_SetVision;}];
	_control = _display displayCtrl 2502; _control ctrlAddEventHandler ["CheckBoxesSelChanged",{[2,param [0,ctrlNull],param [2,0]] call A3PL_CCTV_SetVision;}];

	//create cameras
	A3PL_CCTV_CAMOBJ_1 = "camera" camCreate (getpos player);
	A3PL_CCTV_CAMOBJ_2 = "camera" camCreate (getpos player);
	A3PL_CCTV_CAMOBJ_3 = "camera" camCreate (getpos player);
	A3PL_CCTV_CAMOBJ_4 = "camera" camCreate (getpos player);
	[1,0] call A3PL_CCTV_SetCamera;
	[2,1] call A3PL_CCTV_SetCamera;
	[3,2] call A3PL_CCTV_SetCamera;
	[4,3] call A3PL_CCTV_SetCamera;

	//set render surface references
	{
		private ["_rsRef"]; //render surface reference
		_rsRef = format ["A3PL_CCTV_%1_RT",_forEachIndex+1];
		_x cameraEffect ["INTERNAL", "BACK", _rsRef];
		_rsRef setPiPEffect [4];
		_x camCommit 0;
	} foreach [A3PL_CCTV_CAMOBJ_1,A3PL_CCTV_CAMOBJ_2,A3PL_CCTV_CAMOBJ_3,A3PL_CCTV_CAMOBJ_4];

	//delete vars and cameras once dialog is closed
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
	private ["_camNum","_mapCam","_camera"];
	_camNum = param [0,1];
	_mapCam = A3PL_CCTV_ALL select (param [1,0]); //the actual camera object placed on the map
	_camera = call compile format ["A3PL_CCTV_CAMOBJ_%1",_camNum];

	_camera attachto [_mapCam,(_mapCam selectionPosition "cam_pos")];
	_camera CamSetTarget (_mapCam modelToWorld (_mapCam selectionPosition "cam_dir"));
	_camera camCommit 0;
},false,true] call Server_Setup_Compile;

["A3PL_CCTV_SetVision",
{
	disableSerialization;
	private ["_rsRef","_display","_mode","_control","_checked"];
	_mode = param [0,4];
	_control = param [1,ctrlNull];
	_checked = param [2,0];

	if (_checked == 0) exitwith {};

	{
		_rsRef = format ["A3PL_CCTV_%1_RT",_x];
		_rsRef setPiPEffect [_mode];
	} foreach [1,2,3,4];

	//set uncheked on other buttons
	_display = findDisplay 27;
	{
		_ctrl = _display displayCtrl _x;
		if (_ctrl != _control) then {_ctrl ctrlSetChecked false;};
	} foreach [2500,2501,2502];
}] call Server_Setup_Compile;

["A3PL_BHeist_SetDrill",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_bank","_drill","_timer"];
	_bank = param [0,objNull];
	if (typeOf _bank != "Land_A3PL_Bank") exitwith {["You are not looking at the bank vault","red"] call A3PL_Player_Notification;};
	//bank timer
	_timer = false;
	if (!isNil {_bank getVariable ["timer",nil]}) then
	{
		if (((serverTime - (_bank getVariable ["timer",0]))) < BANKTIMER) then {_timer = true};
	};
	if (_timer) exitwith {[format ["The bank has recently been robbed, try again in %1 seconds",BANKTIMER - ((_bank getVariable ["timer",0]) - serverTime)],"red"] call A3PL_Player_Notification;};
	//other checks
	if (_bank animationSourcePhase "door_bankvault" > 0) exitwith {["The bank vault is already open","red"] call A3PL_Player_Notification;};
	if (backpack player != "A3PL_Backpack_Drill") exitwith {["You are not carrying a drill in your backpack","red"] call A3PL_Player_Notification;};
	//place drill
	_drill = "A3PL_Drill_Bank" createvehicle (getpos player);
	_drill setdir (getdir _bank)-90;
	_drill setpos (_bank modelToWorld [-5.05,4.38,-2.1]);
	//set used
	removeBackpack player;
}] call Server_Setup_Compile;

["A3PL_BHeist_PickupDrill",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_drill"];
	_drill = param [0,objNull];
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
		[format ["Vault drilling progress %2%1","%",round (((_newDrillValue*_timeOut)/_timeOut)*100)],"green"] call A3PL_Player_Notification;
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

//spawn function
["A3PL_BHeist_OpenDeposit",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_bank","_depositNr","_name","_cashOffset","_random","_itemClass","_cash","_class","_dist"];
	_bank = param [0,objNull];
	_name = param [1,""];
	_depositNr = parseNumber ((_name splitString "_") select 1);
	_dist = player distance2D _bank;
	if ((_bank animationSourcePhase "door_bankvault") < 0.95) exitwith {["The bank vault is closed, are you trying to open the deposit box through the walls...?"] call A3PL_Player_Notification;};
	if (Player_ActionDoing) exitwith {["You are already performing an action","red"] call A3PL_Player_Notification;};
	["Lockpicking deposit box...",45] spawn A3PL_Lib_LoadAction;
	Player_ActionCompleted = false;
	//waitUntil {sleep 0.1; Player_ActionCompleted};

	_success = true;
	while {sleep 0.5; !Player_ActionCompleted } do
	{
		if (abs(_dist - (player distance2D _bank)) > 0.5) exitWith {["Action cancelled! - You are too far away from the deposit box!", "red"] call A3PL_Player_Notification; _success = false;};
		if (!(vehicle player == player)) exitwith {_success = false;}; //inside a vehicle
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;}; //is incapacitated
		if (!alive player) exitwith {_success = false;}; //is no longer alive
	};

	Player_ActionCompleted = false;
	if (!_success) exitWith {Player_ActionDoing = false;};

	if (_bank animationPhase _name <= 0.01) then
	{
		//chance to get money
		_random = random 100;
		if (_random < MONEYCHANCE) then
		{
			if (_random < GEMCHANCE) then
			{
				switch (true) do
				{
					case (_random < 1): {_class = "diamond_ill";};
					case (_random < 4): {_class = "diamond_emerald_ill";};
					case (_random < 9): {_class = "diamond_ruby_ill";};
					case (_random < 19): {_class = "diamond_sapphire_ill";};
					case (_random < 30): {_class = "diamond_alex_ill";};
					case (_random < 50): {_class = "diamond_aqua_ill";};
					case (_random <= 100): {_class = "diamond_tourmaline_ill";};
				};
				_cash = createVehicle [(([_class,"class"]) call A3PL_Config_GetItem), position player, [], 0, "CAN_COLLIDE"];
				_cash enableSimulation false;
				_cash setVariable ["class",_class,true];
			} else
			{
				_cash = createVehicle ["A3PL_PileCash", position player, [], 0, "CAN_COLLIDE"];
			};
			_cashOffset = [[-0.6,5.17,-1.4],[-0.6,5.17,-1.73],[-0.6,5.17,-2.05],[-0.6,5.17,-2.4],[-0.6,5.17,-2.7],[-0.6,4.7,-1.4],[-0.6,4.7,-1.73],[-0.6,4.7,-2.05],[-0.6,4.7,-2.4],[-0.6,4.7,-2.7],[-0.6,4.2,-1.4],[-0.6,4.2,-1.73],[-0.6,4.2,-2.05],[-0.6,4.2,-2.4],[-0.6,4.2,-2.7],[-0.6,3.72,-1.4],[-0.6,3.72,-1.73],[-0.6,3.72,-2.05],[-0.6,3.72,-2.4],[-0.6,3.72,-2.7]] select (_depositNr-1);
			_cash setpos (_bank modelToWorld _cashOffset);
		};
		_bank animate [_name,1];
	} else
	{
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
}] call Server_Setup_Compile;

//spawn
["A3PL_BHeist_PickCash",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_cashPile","_container"];
	_cashPile = param [0,objNull];

	if (backpack player != "A3PL_Backpack_Money") exitwith {["You are not carrying a backpack to carry money in!","red"] call A3PL_Player_Notification;};
	_container = backpackContainer player;

	// diag_log str(((_container getVariable ["bankCash",0])));
	// diag_log str(((_container getVariable ["bankCash",0]) + MONEYPERPILE));

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

//Convert stolen money into real cash
["A3PL_BHeist_ConvertCash",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_container"];
	if (backpack player != "A3PL_Backpack_Money") exitwith {["You are not carrying a backpack to carry money in!","red"] call A3PL_Player_Notification;};
	_container = backpackContainer player;
	_cash = _container getVariable ["bankCash",0];
	if (_cash < 1) exitwith {["There is no dirty money in this backpack to convert to real cash","red"] call A3PL_Player_Notification;};
	player setVariable ["player_cash",(player getVariable ["player_cash",0])+_cash * A3PL_Event_CrimePayout,true];
	_container setVariable ["bankCash",nil,true];
	[getPlayerUID player,"moneyLaundering",[str(_cash)]] remoteExec ["Server_Log_New",2];
	[format ["You converted $%1 dirty money into laundered money, the cash is now in your inventory",_cash],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//check how much cash is in the backpack im carrying
["A3PL_BHeist_CheckCash",
{
	 private ["_container"];
	 if (backpack player != "A3PL_Backpack_Money") exitwith {};
	 _container = backpackContainer player;
	 [format ["There is $%1 of dirty money inside this backpack",(_container getVariable ["bankCash",0])],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
