/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//deals with getting inherance information from configFile for usage in text by Factory_Open
["A3PL_Factory_Inheritance",
{
	private _class = param [0,""];
	private _type = param [1,""];
	private _info = param [2,""];
	private _return = "";
	private _mainClass = "";

	if (_type isEqualTo "item") exitwith {
		_return = switch (_info) do {
			case ("img"): {""};
			case ("name"): {[_class,"name"] call A3PL_Config_GetItem};
		};
		_return;
	};
	_mainClass = switch (_type) do {
		case ("weapon"): {"CfgWeapons"};
		case ("magazine"): {"cfgMagazines"};
		case ("mag"): {"cfgMagazines"};
		case ("uniform"): {"CfgWeapons"};
		case ("vest"): {"CfgWeapons"};
		case ("headgear"): {"CfgWeapons"};
		case ("backpack"): {"CfgWeapons"};
		case ("goggles"): {"CfgGlasses"};
		case ("aitem"): {"CfgWeapons"};
		default {"cfgVehicles"};
	};

	_return = switch (_info) do {
		case ("img"): { getText (configFile >> _mainClass >> _class >> "picture") };
		case ("name"): { getText (configFile >> _mainClass >> _class >> "displayName") };
		case ("mainClass"): { _mainClass };
	};
	_return;
}] call Server_Setup_Compile;

["A3PL_Factory_DialogLoop",
{
	disableSerialization;
	private ["_duration","_secLeft","_id","_timeEnd","_name"];
	private _display = findDisplay 45;
	if (isNull _display) exitwith {};
	private _type = ctrlText (_display displayCtrl 1100);
	private _var = player getVariable ["player_factories",[]];
	private _craftID = nil;
	{
		private _id = _x select 0;
		if (([_id, "type"] call A3PL_Config_GetPlayerFactory) == _type) exitwith {_craftID = _id;};
	} foreach _var;
	if (isNil "_craftID") exitwith {};

	private _id = [_craftID, "id"] call A3PL_Config_GetPlayerFactory;
	private _duration = ([_id,_type,"time"] call A3PL_Config_GetFactory) * ([_craftID, "count"] call A3PL_Config_GetPlayerFactory);
	private _timeEnd = [_craftID, "finish"] call A3PL_Config_GetPlayerFactory;
	private _name = [_id,_type,"name"] call A3PL_Config_GetFactory;
	if (_name isEqualTo "inh") then {_name = [([_id,_type,"class"] call A3PL_Config_GetFactory),([_id,_type,"type"] call A3PL_Config_GetFactory),"name"] call A3PL_Factory_Inheritance;};
	_duration = [_duration] call A3PL_Factory_LevelBoost;
	while {!isNull _display} do {
		if(!isNil "Player_CraftInterrupt") exitWith {
			(_display displayCtrl 1105) progressSetPosition 0;
			(_display displayCtrl 1104) ctrlSetStructuredText parseText "";
		};
		_secLeft = -(diag_ticktime) + _timeEnd;
		(_display displayCtrl 1105) progressSetPosition (1-(_secLeft / _duration));
		if (_secLeft < 0) then {_secLeft = 0};
		if(_secLeft > 60) then {
			_minLeft = ceil (_secLeft/60);
			(_display displayCtrl 1104) ctrlSetStructuredText parseText format ["<t size='0.92'>%1<br/>%2 minute(s) remaining</t>",_name,_minLeft];
			if(_minLeft > 60) then {
				(_display displayCtrl 1104) ctrlSetStructuredText parseText format ["<t size='0.92'>%1<br/>%2 hour(s) remaining</t>",_name,_minLeft/60];
			};
		} else {
			(_display displayCtrl 1104) ctrlSetStructuredText parseText format ["<t size='0.92'>%1<br/>%2 second(s) remaining</t>",_name,ceil _secLeft];
		};
		uiSleep 1;
		if (_secLeft <= 0) exitwith {};
	};
}] call Server_Setup_Compile;

//can check whether we have an item in the factory storage or not. can also be used by the server
["A3PL_Factory_Has",
{
	private ["_item","_amount","_player","_has","_found","_storage","_type"];
	_item = param [0,""];
	_amount = param [1,1];
	_type = param [2,""];
	_player = param [3,player];
	_has = false;
	_found = false;
	_storage = _player getVariable ["player_fstorage",[]];

	{
		if (_x select 0 == _type) then
		{
			{
				private ["_storageItem","_isFactory","_itemType"];
				_storageItem = _x select 0;
				_isFactory = _storageItem splitString "_";
				if ((_isFactory select 0) isEqualTo "f") then {_isFactory = true; _itemType = [_storageItem,_type,"type"] call A3PL_Config_GetFactory;} else {_isFactory = false;};
				if (isNil "_itemType") then {_itemType = ""};
				if (_isFactory && (_itemType == "item")) then {_storageItem = [_storageItem,_type,"class"] call A3PL_Config_GetFactory;};
				if (_storageItem == _item) exitwith
				{
					if ((_x select 1) >= _amount) then
					{
						_has = true
					};
					_found = true;
				};
			} foreach (_x select 1);
			if (_found) exitwith {};
		};
	} foreach _storage;
	_has;
}] call Server_Setup_Compile;

//does the actual crafting, this function runs when we press the craft button
["A3PL_Factory_Craft",
{
	disableSerialization;
	private _display = findDisplay 45;
	private _type = ctrlText (_display displayCtrl 1100);
	private _toCraft = parseNumber(ctrlText (_display displayCtrl 1406));
	private _alreadyCrafting = false;
	private _var = player getVariable ["player_factories",[]];

	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	{
		if (([(_x select 0), "type"] call A3PL_Config_GetPlayerFactory) isEqualTo _type) exitwith {_alreadyCrafting = true;};
	} foreach _var;

	if (_alreadyCrafting) then {
		{
			if ((_x select 3) isEqualTo _type) exitwith {_var deleteAt _forEachIndex};
		} foreach _var;
		player setVariable ["player_factories",_var,false];
		Player_CraftInterrupt = true;
		["Crafting cancelled","red"] call A3PL_Player_Notification;
	} else {
		private _control = _display displayCtrl 1500;
		if (lbCurSel _control < 0) exitwith {[localize"STR_FACTORY_NOOBJECTSELECTION","red"] call A3PL_Player_Notification;};
		private _id = _control lbData (lbCurSel _control);
		private _required = [_id,_type,"required"] call A3PL_Config_GetFactory;
		private _levelRequired = [_id,_type,"level"] call A3PL_Config_GetFactory;
		if (isNil "_required" OR (count _required < 1)) exitwith {["Unexpected error occured trying to retrieve items for recipe in _Craft","red"] call A3PL_Player_Notification;};

		private _temp = [];
		private _failed = false;
		{
			private _id = _x select 0;
			private _amount = (_x select 1)*_toCraft;
			_temp pushBack [_id,_amount];
			if (!([_id,_amount,_type] call A3PL_Factory_Has)) exitwith {_failed=true};
		} foreach _required;
		_required = _temp;
		if (_failed) exitwith {[format[localize"STR_FACTORY_NECESSARYITEMTOCRAFT",_toCraft],"red"] call A3PL_Player_Notification;};

		private _sec = ([_id,_type,"time"] call A3PL_Config_GetFactory)*_toCraft;
		private _sec = [_sec] call A3PL_Factory_LevelBoost;
		private _classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
		private _classname = [_id,_type,"class"] call A3PL_Config_GetFactory;
		private _craftID = floor (random 10000);
		private _var = player getVariable ["Player_Factories",[]];
		_var pushback [_craftID,_classname,_required,_type,_classType,_id,1,(diag_ticktime + _sec),_toCraft];
		player setVariable ["Player_Factories",_var,false];
		[] spawn A3PL_Factory_DialogLoop;
		[_craftID,_sec,_required,_toCraft] spawn
		{
			private _craftID = param [0,0];
			private _sec = param [1,0];
			private _required = param [2,[]];
			private _toCraft = param [3,1];
			private _type = [_craftID, "type"] call A3PL_Config_GetPlayerFactory;
			private _classtype = [_craftID, "classtype"] call A3PL_Config_GetPlayerFactory;
			private _classname = [_craftID, "classname"] call A3PL_Config_GetPlayerFactory;
			private _id = [_craftID, "id"] call A3PL_Config_GetPlayerFactory;
			private _name = [_id,_type,"name"] call A3PL_Config_GetFactory;
			private _xpToAdd = ([_id,_type,"xp"] call A3PL_Config_GetFactory) * _toCraft;
			private _curSleep = 0;
			if (_name isEqualTo "inh") then {_name = [_classname,_classType,"name"] call A3PL_Factory_Inheritance;};
			while{_curSleep < _sec} do {
				if(!isNil "Player_CraftInterrupt") exitWith {};
				_curSleep = _curSleep + 1;
				sleep 1;
			};
			if(!isNil "Player_CraftInterrupt") exitWith {sleep 3;Player_CraftInterrupt = nil;};
			[format [localize"STR_FACTORY_CRAFTEND",_name,_type,([_id,_type,"output"] call A3PL_Config_GetFactory)*_toCraft],"green"] call A3PL_Player_Notification;
			[player,_xpToAdd] call A3PL_Level_AddXp;
			[player,_type,_id, _required, _toCraft] remoteExec ["Server_Factory_Finalise", 2];

			sleep 1;
			private _var = player getVariable ["player_factories",[]];
			{
				if ((_x select 0) isEqualTo _craftID) exitwith {_var deleteAt _forEachIndex};
			} foreach _var;
		};
	};
}] call Server_Setup_Compile;

//set all the items required, colour will display whether we have the item or not
["A3PL_Factory_SetRecipe",
{
	disableSerialization;
	private ["_display","_control","_type","_id","_desc","_classType","_class","_ctrlID","_preview","_lbArray"];
	_display = findDisplay 45;
	_ctrlID = param [0,1500];
	_preview = param [1,true];
	_type = ctrlText (_display displayCtrl 1100);
	_control = _display displayCtrl _ctrlID;
	if ((lbCurSel _control) < 0) exitwith {};
	_id = _control lbData (lbCurSel _control);
	_required = [_id,_type,"required"] call A3PL_Config_GetFactory;
	_classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
	if (_preview) then {
		[_type,_id] spawn A3PL_Factory_ObjectPreviewSpawn;
	};
	_control = _display displayCtrl 1501;

	diag_log _required;
	_lbArray = [];
	{
		private ["_i","_name","_amount","_id"];
		_id = _x select 0;
		_amount = _x select 1;
		_name = format ["%1x %2",_amount,([_id,"name"] call A3PL_Config_GetItem)];
		if ([_id,_amount,_type] call A3PL_Factory_Has) then {
			_lbArray pushback [_name,_id,true];
		} else {
			_lbArray pushback [_name,_id,false];
		};
	} foreach _required;

	lbClear _control;
	{
		_i = _control lbAdd (_x select 0);
		_control lbSetData [_i,(_x select 1)];
		if (_x select 2) then {_control lbSetColor [_i,[0, 1, 0, 1]];} else {_control lbSetColor [_i,[1, 0, 0, 1]];};
	} foreach _lbArray;

	_desc = [_id,_type,"desc"] call A3PL_Config_GetFactory;
	_control = _display displayCtrl 1103;
	_control ctrlSetStructuredText parseText format ["Description : %1",_desc];
}] call Server_Setup_Compile;

["A3PL_Factory_Open",
{
	disableSerialization;
	private _type = param [0,""];
	if (!isNull Player_Item) then {call A3PL_Inventory_PutBack;};
	createDialog "Dialog_Factory";
	[] spawn A3PL_Factory_DialogLoop;
	[_type] spawn A3PL_Factory_ObjectPreview;
	[_type] spawn {
		disableSerialization;
		private _type = param [0,""];
		private _display = findDisplay 45;
		while {!isNull _display} do {
			[_type] call A3PL_Factory_Refresh;
			uiSleep 0.5;
		};
	};

	_display = findDisplay 45;
	_control = _display displayCtrl 1600;
	_control buttonSetAction "call A3PL_Factory_Craft";
	_control = _display displayCtrl 1603;
	_control buttonSetAction "call A3PL_Factory_Collect";
	_control = _display displayCtrl 1601;
	_control buttonSetAction "call A3PL_Factory_Add";
	_control = _display displayCtrl 1100;
	_control CtrlSetText _type;
	_control = _display displayCtrl 1502;
	_control ctrlAddEventHandler ["LBSelChanged",{}];
	_control = _display displayCtrl 1500;
	_control ctrlAddEventHandler ["LBSelChanged",{[1500] call A3PL_Factory_SetRecipe;}];

	_recipes = ["all",_type] call A3PL_Config_GetFactory;
	{
		private _id = _x select 0;
		private _img = [_id,_type,"img"] call A3PL_Config_GetFactory;
		private _class = [_id,_type,"class"] call A3PL_Config_GetFactory;
		private _name = [_id,_type,"name"] call A3PL_Config_GetFactory;
		private _classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
		if (_img isEqualTo "inh") then {_img = [_class,_classType,"img"] call A3PL_Factory_Inheritance;};
		if (_name isEqualTo "inh") then {_name = [_class,_classType,"name"] call A3PL_Factory_Inheritance;};
		_i = _control lbAdd _name;
		_control lbSetPicture [_i,_img];
		_control lbSetData [_i,_id];
	} foreach _recipes;
	_control lbSetCurSel 0;

	[_type] call A3PL_Factory_Refresh;
}] call Server_Setup_Compile;

//get the storage minus what we are using in crafting right now
["A3PL_Factory_GetStorage",
{
	private _type = param [0,""];
	private _player = param[1,player];
	private _storage = [_type,"items",_player] call A3PL_Config_GetPlayerFStorage;
	if (_storage isEqualType true) exitwith {_storage = []; _storage;};
	private _fact = _player getVariable ["player_factories",[]];
	private _subtract = [];

	{
		private ["_class","_amount","_items"];
		{
			_class = _x select 0;
			_amount = _x select 1;
			_subtract = [_subtract, _class, _amount, true] call BIS_fnc_addToPairs;
		} foreach (_x select 2);
	} foreach _fact;

	{
		private ["_class","_amount"];
		_class = _x select 0;
		_amount = _x select 1;
		_storage = [_storage, _class, -(_amount), true] call BIS_fnc_addToPairs;
	} foreach _subtract;

	{
		if ((_x select 1) < 1) then {
			_storage deleteAt _forEachIndex;
		};
	} forEach _storage;
	_storage;
}] call Server_Setup_Compile;

["A3PL_Factory_Refresh",
{
	disableSerialization;
	private _type = param [0,""];
	private _display = findDisplay 45;
	if (isNull _display) exitwith {};
	private _control = _display displayCtrl 1502;
	private _storage = [_type] call A3PL_Factory_GetStorage;
	private _inventory = player getVariable ["player_inventory",[]];
	if (_storage isEqualType true) then {_storage = []};

	_lbArray = [];
	{
		private _id = _x select 0;
		private _amount = _x select 1;
		private _isFactory = _id splitString "_";
		private _name = "";
		private _img = "";
		if ((_isFactory select 0) isEqualTo "f") then {_isFactory = true;} else {_isFactory = false;};
		if (_isFactory) then {
			_img = [_id,_type,"img"] call A3PL_Config_GetFactory;
			_name = [_id,_type,"name"] call A3PL_Config_GetFactory;
			_class = [_id,_type,"class"] call A3PL_Config_GetFactory;
			_classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
			if (_img isEqualTo "inh") then {_img = [_class,_classType,"img"] call A3PL_Factory_Inheritance;};
			if (_name isEqualTo "inh") then {_name = [_class,_classType,"name"] call A3PL_Factory_Inheritance;};
		} else {
			_name = [_id,"name"] call A3PL_Config_GetItem;
			_img = [_id,"icon"] call A3PL_Config_GetItem;
		};
		_lbArray pushback [format ["%1 (%2x)",_name,_amount],_id];
	} foreach _storage;

	lbClear _control;
	{
		_i = _control lbAdd (_x select 0);
		_control lbSetPicture [_i,""];
		_control lbSetData [_i,(_x select 1)];
	} foreach _lbArray;
	_lbArray = [];

	_control = _display displayCtrl 1503;
	{
		private ["_i","_id","_amount"];
		_id = _x select 0;
		_amount = _x select 1;
		_lbArray pushback [format ["%1 (%2x)",([_id,"name"] call A3PL_Config_GetItem),_amount],_id];
	} foreach _inventory;

	lbClear _control;
	{
		_i = _control lbAdd (_x select 0);
		_control lbSetData [_i,(_x select 1)];
	} foreach _lbArray;
	_i = _control lbAdd format ["Cash (%1x)",(player getvariable ["player_cash",0])];
	_control lbSetData [_i,"cash"];

	_near = player nearEntities [["Thing"],20];
	{
		if ((!isNil {_x getVariable ["ainv",nil]}) || (!isNil {_x getVariable ["finv",nil]}) || (isNil {_x getVariable ["class",nil]})) then
		{
			_near deleteAt _forEachIndex;
		};
	} foreach _near;
	{
		if ((_x getVariable ["owner",""]) isEqualTo (getPlayerUID player)) then
		{
			private _id = _x getVariable ["class",""];
			private _amount = 1;
			private _i = _control lbAdd format ["%1 (%2x)",([_id,"name"] call A3PL_Config_GetItem),_amount];
			_control lbSetData [_i,format ["OBJ_%1",_x]];
		};
	} foreach _near;
	[1500,false] call A3PL_Factory_SetRecipe;
}] call Server_Setup_Compile;

//this runs when we press the collect button
["A3PL_Factory_Collect",
{
	private ["_display","_control","_id","_amount","_isCrafting"];
	_display = findDisplay 45;
	_control = _display displayCtrl 1502;
	_type = ctrlText (_display displayCtrl 1100); //factory id from dialog text
	if (lbCurSel _control < 0) exitwith {[localize"STR_FACTORY_NOSELECTION","red"] call A3PL_Player_Notification;};
	if(!(call A3PL_Player_AntiSpam)) exitWith {[localize"STR_FACTORY_ANTISPAM","red"] call A3PL_Player_Notification;}; //anti spam
	_id = _control lbData (lbCurSel _control);

	//anti-dupe for collecting items that are currently being crafted
	_isCrafting = false;
	{
		if ((_x select 3) isEqualTo _type) exitwith {_isCrafting = true;};
	} foreach (player getVariable ["player_factories",[]]);
	if (_isCrafting) exitwith {[localize"STR_FACTORY_EXTRACTITEM"] call A3PL_Player_Notification;};
	//end of anti-dupe

	_control = _display displayCtrl 1400;
	_amount = parseNumber (ctrlText _control);
	if (_amount <= 0) exitwith {[localize"STR_FACTORY_INVALIDAMOUNT","red"] call A3PL_Player_Notification;};
	if (!([_id,_amount,_type] call A3PL_Factory_Has)) exitwith {[localize"STR_FACTORY_COLLECTAMOUNT","red"] call A3PL_Player_Notification;};

	[player,_type,[_id,_amount]] remoteExec ["Server_Factory_Collect",2]; //change to 2
	[_type] spawn
	{
		_type = param [0,""];
		uiSleep 2;
		[_type] call A3PL_Factory_Refresh;
	};
}] call Server_Setup_Compile;

["A3PL_Factory_Add",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {}; //anti spam
	private ["_display","_control","_type","_id","_amount","_typeOf","_fail","_obj","_cashCheck"];
	_display = findDisplay 45;
	_control = _display displayCtrl 1503;
	_type = ctrlText (_display displayCtrl 1100); //factory id from dialog text
	_id = _control lbData (lbCurSel _control);
	_control = _display displayCtrl 1400;
	_amount = parseNumber (ctrlText _control);
	if (_amount <= 0) exitwith {[localize"STR_FACTORY_ADDAMOUNT","red"] call A3PL_Player_Notification;};
	_fail = false;

	//check if this was a near object
	_splitted = _id splitString "_";
	if ((_splitted select 0) isEqualTo "OBJ") then
	{
		_typeOf = "";
		_typeOf = toArray _id;
		_typeOf deleteAt 0;_typeOf deleteAt 0;_typeOf deleteAt 0;_typeOf deleteAt 0;
		_typeOf = toString _typeOf;
	};
	if (_fail) exitwith {["System: Error retrieving object typeOf in _Factory_Add","red"] call A3PL_Player_Notification;};
	if (!isNil "_typeOf") then
	{
		_obj = [_typeOf] call A3PL_Lib_vehStringToObj;
	};
	if (_fail) exitwith {["System: Error retrieving object in _Factory_Add","red"] call A3PL_Player_Notification;};
	if (isNil "_obj") then
	{
		if(_id isEqualTo "cash")	exitwith {[localize"STR_FACTORY_STOCKMONEY","red"] call A3PL_Player_Notification;};
		if(_id IN ["seed_marijuana","marijuana","cocaine","shrooms","cannabis_bud","cannabis_bud_cured","cannabis_grinded_5g","weed_5g","weed_10g","weed_15g","weed_20g","weed_25g","weed_30g","weed_35g","weed_40g","weed_45g","weed_50g","weed_55g","weed_60g","weed_65g","weed_70g","weed_75g","weed_80g","weed_85g","weed_90g","weed_95g","weed_100g","jug_moonshine","turtle","drill_bit","diamond_ill","diamond_emerald_ill","diamond_ruby_ill","diamond_sapphire_ill","diamond_alex_ill","diamond_aqua_ill","diamond_tourmaline_ill","v_lockpick","zipties","keycard"]) exitwith {[localize"STR_FACTORY_ILLEGAL","red"] call A3PL_Player_Notification;};
		[player,_type,[_id,_amount]] remoteExec ["Server_Factory_Add",2];
	}
	else
	{
		if (isNull _obj) exitwith {_fail = true};
		_id = _obj getVariable ["class",nil];
		if(_id IN ["distillery","distillery_hose","jug","jug_moonshine","jug_green","jug_green_moonshine"]) exitwith {[localize"STR_FACTORY_ILLEGAL","red"] call A3PL_Player_Notification;};
		if (isNil "_id") exitwith {_fail = true};
		[player,_type,[_id,1],true,_obj] remoteExec ["Server_Factory_Add",2];
	};
	if (_fail) exitwith {["System: Error retrieving itemClass from object","red"] call A3PL_Player_Notification;};
}] call Server_Setup_Compile;

["A3PL_Factory_ObjectPreview",
{
	disableSerialization;
	private _factory = param [0,""];
	private _display = findDisplay 45;
	private _logic = "logic" createvehicleLocal [0,0,0];
	_logic setposATL (["pos",_factory] call A3PL_Config_GetFactory);
	private _cam = "camera" camCreate [0,0,0];
	FACTORYCAMERA = _cam;
	FACTORYLOGIC = _logic;
	_cam camSetTarget _logic;
	_cam camCommit 0;
	_cam cameraEffect ["internal", "BACK"];
	_cam attachto [_logic, [0,5,2]];
	private _dir = random 359;
	private _interval = 0.1;
	while {!isNull _display} do {
		_dir = _dir + _interval;
		_logic setDir _dir;
		uiSleep 0.01;
	};

	{
		deleteVehicle _x;
	} foreach (attachedObjects (missionNameSpace getVariable ["A3PL_FACTORY_OBJPRV",objNull]));
	deleteVehicle (missionNameSpace getVariable ["A3PL_FACTORY_OBJPRV",objNull]); //clear the object from preview
	FACTORYCAMERA = nil;
	FACTORYLOGIC = nil;
	camDestroy _cam;
	deleteVehicle _logic;
	player cameraEffect ["terminate", "BACK"];
}] call Server_Setup_Compile;

["A3PL_Factory_ObjectPreviewSpawn",
{
	disableSerialization;
	private _factory = param [0,""];
	private _id = param [1,""];
	private _class = [_id,_factory,"class"] call A3PL_Config_GetFactory;
	private _itemType = [_id,_factory,"type"] call A3PL_Config_GetFactory;
	private _pos = ["pos",_factory] call A3PL_Config_GetFactory;
	private _display = findDisplay 45;
	private _camera = missionNameSpace getVariable ["FACTORYCAMERA",objNull];
	private _logic = missionNameSpace getVariable ["FACTORYLOGIC",objNull];
	if (isNull _display) exitwith {};
	{
		deleteVehicle _x;
	} foreach (attachedObjects (missionNameSpace getVariable ["A3PL_FACTORY_OBJPRV",objNull]));
	deleteVehicle (missionNameSpace getVariable ["A3PL_FACTORY_OBJPRV",objNull]);
	uiSleep 0.01;
	if (!(call A3PL_Player_AntiListboxSpam)) exitwith {};

	switch (true) do
	{
		case (_itemType isEqualTo "item"):
		{
			_class = [_class,"class"] call A3PL_Config_GetItem;
			A3PL_FACTORY_OBJPRV = _class createvehicleLocal [0,0,0];
			A3PL_FACTORY_OBJPRV allowDamage false;
			A3PL_FACTORY_OBJPRV setPosATL _pos;
			A3PL_FACTORY_OBJPRV setDir (random 359);
			A3PL_FACTORY_OBJPRV enableSimulation false;
			_camera attachto [_logic, [0,2,2]];
		};

		case (_itemType IN ["weapon","magazine","aitem","weaponitem","secweaponitem"]):
		{
			A3PL_FACTORY_OBJPRV = "groundWeaponHolder" createvehicleLocal [0,0,0];
			switch (_itemType) do
			{
				case ("weapon"): {A3PL_FACTORY_OBJPRV addWeaponCargo [_class,1];};
				case ("magazine"): {A3PL_FACTORY_OBJPRV addMagazineCargo [_class,1];};
				case ("aitem"): {A3PL_FACTORY_OBJPRV addItemCargo [_class,1];};
				case ("weaponitem"): {A3PL_FACTORY_OBJPRV addItemCargo [_class,1];};
				case ("secweaponitem"): {A3PL_FACTORY_OBJPRV addItemCargo [_class,1];};
			};

			A3PL_FACTORY_OBJPRV setPosATL _pos;
			A3PL_FACTORY_OBJPRV setDir (random 359);
			_camera attachto [_logic, [0,0.1,1]];
		};

		case (_itemType IN ["car","plane","heli"]):
		{
			A3PL_FACTORY_OBJPRV = _class createvehicleLocal [0,0,0];
			A3PL_FACTORY_OBJPRV allowDamage false;
			A3PL_FACTORY_OBJPRV setPosATL _pos;
			A3PL_FACTORY_OBJPRV setDir (random 359);
			_camera attachto [_logic, [0,5,2]];
		};

		case (_itemType IN ["vest","uniform","goggles","headgear","backpack"]):
		{
			A3PL_FACTORY_OBJPRV = "C_man_p_beggar_F" createvehicleLocal [0,0,0];
			A3PL_FACTORY_OBJPRV allowDamage false;
			A3PL_FACTORY_OBJPRV setPosATL [_pos select 0,_pos select 1,((_pos select 2) - 1)];
			A3PL_FACTORY_OBJPRV setDir (random 359);
			A3PL_FACTORY_OBJPRV enableSimulation false;
			switch (_itemType) do
			{
				case ("uniform"): {removeUniform A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addUniform _class; };
				case ("vest"): {removeVest A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addVest _class; };
				case ("headgear"): {removeHeadGear A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addHeadGear _class; };
				case ("backpack"): {removeBackPack A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addBackPack _class; };
				case ("goggles"): {removeGoggles A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addGoggles _class; };
				case ("weapon"): {removeAllWeapons A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addWeapon _class; };
			};
			_camera attachto [_logic, [0,2,2]];
		};
	};
}] call Server_Setup_Compile;

["A3PL_Factory_CrateInfo",
{
	private _crate = param [0,objNull];
	private _aInv = _crate getVariable ["ainv",nil];
	if (isNil "_aInv") then {
		_finv = _crate getVariable ["finv",nil];
	};
	if ((isNil "_aInv") && (isNil "_finv")) exitwith {
		["System: Missing inv variables on this object in _CrateCheck -> report this bug","red"] call A3PL_Player_Notification;
	};
	_classtype = _aInv select 0;
	_id = _aInv select 1;
	_amount = _aInv select 2;
	_return = [_classType,_id,_amount];
	_return;
}] call Server_Setup_Compile;

["A3PL_Factory_CrateName",
{
	private _id = param [0,""];
	private _classType = param [1,""];
	private _name = "ERROR";
	switch (true) do {
		case (_classType isEqualTo "item"): {
			_name = [_id,"name"] call A3PL_Config_GetItem;
		};
		case default {
			private _mainClass = switch (_classtype) do {
				case ("car"): {"cfgVehicles"};
				case ("weapon"): {"CfgWeapons"};
				case ("magazine"): {"cfgMagazines"};
				case ("mag"): {"cfgMagazines"};
				case ("uniform"): {"CfgWeapons"};
				case ("vest"): {"CfgWeapons"};
				case ("headgear"): {"CfgWeapons"};
				case ("backpack"): {"CfgWeapons"};
				case ("goggles"): {"CfgGlasses"};
				case ("aitem"): {"CfgWeapons"};
				default {"cfgVehicles"};
			};
			_name = getText (configFile >> _mainClass >> _id >> "displayName");
		};
	};
	_name;
}] call Server_Setup_Compile;

["A3PL_Factory_CrateCollect",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _crate = param [0,objNull];
	private _info = [_crate] call A3PL_Factory_CrateInfo;
	private _classtype = _info select 0;
	private _id = _info select 1;
	private _amount = _info select 2;
	private _owner = _crate getVariable ["owner",""];

	if (_owner != (getPlayerUID player)) exitwith {[localize"STR_FACTORY_OWNERSELL","red"] call A3PL_Player_Notification;};

	private _fail = false;
	private _exit = false;
	switch (_classtype) do {
		case ("item"): {
			[_id,_amount] call A3PL_Inventory_Add;
		};
		case ("weapon"): {
			if(player canAdd [_id, _amount]) then {
				player addItem _id;
			} else {
				player addWeapon _id;
			};
		};
		case ("magazine"): {
			if(player canAdd [_id, _amount]) then {
				player addMagazines [_id,_amount];
			} else {
				_exit = true;
			};
		};
		case ("aitem"): {
			if(player canAdd [_id, _amount]) then {
				for [{_i = 0}, {_i < _amount},{_i = _i + 1}] do {
					player addItem _id;
				};
			} else {
				_exit = true;
			};
		};
		case ("uniform"): {player addUniform _id; };
		case ("vest"): {player addVest _id;};
		case ("headgear"): {player addHeadGear _id;};
		case ("backpack"): {player addBackPack _id;};
		case ("goggles"): {player addGoggles _id;};
		default {_fail = true;};
	};
	if (_exit) exitwith {[format [localize"STR_FACTORY_COLLECTTHISAMOUNT"],"red"] call A3PL_Player_Notification;};
	if (_fail) exitwith {[format ["Error: Undefined _classType in _CrateCollect (ID: %1) > report this bug",_id],"red"] call A3PL_Player_Notification;};
	deleteVehicle _crate;
	[format [localize"STR_FACTORY_COLLECTOK",_amount,[_id,_classType] call A3PL_Factory_CrateName],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Factory_CrateCheck",
{
	private _crate = param [0,objNull];
	if ((isNil {_crate getVariable ["aInv",nil]}) && (isNil {_crate getVariable ["fInv",nil]})) exitwith {
		private _id = _crate getVariable ["class",""];
		private _amount = _crate getVariable ["amount",1];
		private _name = [_id,"name"] call A3PL_Config_GetItem;
		[format [localize"STR_FACTORY_GETITEM",_amount,_name],"green"] call A3PL_Player_Notification;
	};
	private _info = [_crate] call A3PL_Factory_CrateInfo;
	private _amount = _info select 2;
	[format [localize"STR_FACTORY_GETITEMFACTION",_amount,_name],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Factory_LevelBoost",
{
	private _timeEnd = param [0,0];
	private _level = player getVariable["Player_Level",0];
	private _coeff = switch(true) do {
		case ((_level >= 5) && (_level <= 9)): {0.05};
		case ((_level >= 10) && (_level <= 14)): {0.1};
		case ((_level >= 15) && (_level <= 19)): {0.15};
		case ((_level >= 20) && (_level <= 24)): {0.2};
		case ((_level >= 25) && (_level <= 29)): {0.25};
		case ((_level >= 30) && (_level <= 34)): {0.3};
		case ((_level >= 35) && (_level <= 39)): {0.35};
		case ((_level >= 40) && (_level <= 44)): {0.4};
		case ((_level >= 45) && (_level <= 49)): {0.45};
		case ((_level >= 50) && (_level <= 54)): {0.5};
		case ((_level >= 55) && (_level <= 59)): {0.55};
		case ((_level >= 60) && (_level <= 64)): {0.6};
		case ((_level >= 65) && (_level <= 69)): {0.65};
		case ((_level >= 70) && (_level <= 74)): {0.7};
		case (_level >= 75): {0.75};
		default {0};
	};
	_timeEnd = _timeEnd - (_timeEnd*_coeff);
	_timeEnd;
}] call Server_Setup_Compile;

["A3PL_Factory_GetRemaining",
{
	private _factory = param [0,"Undefined"];
	if(_factory isEqualTo "Undefined") exitWith {};
	private _time = "";
	private _craftID = -1;
	private _var = player getVariable ["player_factories",[]];
	private _time = "";
	{
		if (([(_x select 0), "type"] call A3PL_Config_GetPlayerFactory) isEqualTo _factory) exitWith {_craftID = (_x select 0);};
	} foreach _var;

	if(_craftID < 0) then {
		_time = "Available";
	} else {
		_timeEnd = [_craftID, "finish"] call A3PL_Config_GetPlayerFactory;
		_time = str(-(diag_ticktime) + _timeEnd);
	};
	_time;
}] call Server_Setup_Compile;

["A3PL_Factory_GetRemainingName",
{
	private _factory = param [0,"Undefined"];
	if(_factory isEqualTo "Undefined") exitWith {};
	private _return = "";
	private _craftID = -1;
	private _var = player getVariable ["player_factories",[]];
	{
		if (([(_x select 0), "type"] call A3PL_Config_GetPlayerFactory) isEqualTo _factory) exitWith {_craftID = (_x select 0);};
	} foreach _var;
	if(_craftID < 0) exitWith {""};

	private _id = [_craftID, "id"] call A3PL_Config_GetPlayerFactory;
	private _return = [_id,_factory,"name"] call A3PL_Config_GetFactory;
	if (_return isEqualTo "inh") then {_return = [([_id,_factory,"class"] call A3PL_Config_GetFactory),([_id,_factory,"type"] call A3PL_Config_GetFactory),"name"] call A3PL_Factory_Inheritance;};
	_return;
}] call Server_Setup_Compile;

["A3PL_Factory_AdjustRemaining",
{
	private _time = param [0,"0"];
	private _time = round(parseNumber(_time));
	private _return = "";
	if (_time < 0) then {_time = 0};
	if(_time > 60) then {
		_minLeft = ceil (_time/60);
		_return = format ["%1 minute(s)",round(_minLeft)];
		if(_minLeft > 60) then {
			_return = format ["%1 hours(s)",round(_minLeft/60)];
		};
	} else {
		_return = format ["%1 second(s)",ceil _time];
	};
	_return;
}] call Server_Setup_Compile;

["A3PL_Factory_Search",
{
	disableSerialization;
	private _display = findDisplay 45;
	if (isNull _display) exitwith {};
	private _search = ctrlText (_display displayCtrl 1405);
	private _type = ctrlText (_display displayCtrl 1100);
	private _control = _display displayCtrl 1500;
	lbClear _control;
	private _recipes = ["all",_type] call A3PL_Config_GetFactory;
	{
		private _id = _x select 0;
		private _name = [_id,_type,"name"] call A3PL_Config_GetFactory;
		private _class = [_id,_type,"class"] call A3PL_Config_GetFactory;
		private _classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
		if (_name isEqualTo "inh") then {_name = [_class,_classType,"name"] call A3PL_Factory_Inheritance;};
		if([_search, _name] call BIS_fnc_inString) then {
			private _img = [_id,_type,"img"] call A3PL_Config_GetFactory;
			if (_img isEqualTo "inh") then {_img = [_class,_classType,"img"] call A3PL_Factory_Inheritance;};
			_i = _control lbAdd _name;
			_control lbSetPicture [_i,_img];
			_control lbSetData [_i,_id];
		};
	} foreach _recipes;
	_control lbSetCurSel 0;
}] call Server_Setup_Compile;
