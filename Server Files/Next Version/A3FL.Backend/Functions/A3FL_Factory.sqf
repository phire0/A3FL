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

//a loop in the dialog to set the progress among other things
["A3PL_Factory_DialogLoop",
{
	disableSerialization;
	private _display = findDisplay 45;
	if (isNull _display) exitwith {};
	private _type = ctrlText (_display displayCtrl 1100);
	private _var = player getVariable ["player_factories",[]];
	{
		private _id = _x select 0;
		if (([_id, "type"] call A3PL_Config_GetPlayerFactory) isEqualTo _type) exitwith {
			_craftID = _id;
		};
	} foreach _var;
	if (isNil "_craftID") exitwith {};

	private _id = [_craftID, "id"] call A3PL_Config_GetPlayerFactory;
	private _duration = ([_id,_type,"time"] call A3PL_Config_GetFactory) * ([_craftID, "count"] call A3PL_Config_GetPlayerFactory);
	private _timeEnd = [_craftID, "finish"] call A3PL_Config_GetPlayerFactory;
	private _name = [_id,_type,"name"] call A3PL_Config_GetFactory;
	if (_name isEqualTo "inh") then {_name = [([_id,_type,"class"] call A3PL_Config_GetFactory),([_id,_type,"type"] call A3PL_Config_GetFactory),"name"] call A3PL_Factory_Inheritance;};
	private _timeSleep = 0;
	private _duration = [_duration] call A3PL_Factory_LevelBoost;
	while {!isNull _display} do {
		private _secLeft = -(diag_ticktime) + _timeEnd;
		(_display displayCtrl 1105) progressSetPosition (1-(_secLeft / _duration));
		if (_secLeft < 0) then {_secLeft = 0};
		if(_secLeft > 60) then {
			_minLeft = ceil (_secLeft/60);
			(_display displayCtrl 1104) ctrlSetStructuredText parseText format ["<t size='0.92'>%1<br/>%2 minute(s) remaining</t>",_name,_minLeft];
			_timeSleep = 60;
			if(_minLeft > 60) then {
				(_display displayCtrl 1104) ctrlSetStructuredText parseText format ["<t size='0.92'>%1<br/>%2 hour(s) remaining</t>",_name,_minLeft/60];
				_timeSleep = 3600;
			};
		} else {
			(_display displayCtrl 1104) ctrlSetStructuredText parseText format ["<t size='0.92'>%1<br/>%2 second(s) remaining</t>",_name,ceil _secLeft];
			_timeSleep = 1;
		};
		sleep _timeSleep;
		if (_secLeft <= 0) exitwith {};
	};
}] call Server_Setup_Compile;

//can check whether we have an item in the factory storage or not. can also be used by the server
["A3PL_Factory_Has",
{
	private _item = param [0,""];
	private _amount = param [1,1];
	private _type = param [2,""];
	private _player = param [3,player];
	private _has = false;
	private _found = false;
	private _storage = _player getVariable ["player_fstorage",[]];
	{
		if ((_x select 0) isEqualTo _type) then
		{
			{
				private _storageItem = _x select 0;
				private _isFactory = _storageItem splitString "_";
				if ((_isFactory select 0) isEqualTo "f") then {_isFactory = true; _itemType = [_storageItem,_type,"type"] call A3PL_Config_GetFactory;} else {_isFactory = false;};
				if (isNil "_itemType") then {_itemType = ""};
				if (_isFactory && (_itemType isEqualTo "item")) then {_storageItem = [_storageItem,_type,"class"] call A3PL_Config_GetFactory;};
				if (_storageItem isEqualTo _item) exitwith
				{
					if ((_x select 1) >= _amount) then {
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
	private ["_display","_control","_type","_id","_required","_failed","_sec","_classType","_craftID","_classname","_alreadyCrafting"];
	_display = findDisplay 45;
	_type = ctrlText (_display displayCtrl 1100); //factory id from dialog text
	_toCraft = parseNumber(ctrlText (_display displayCtrl 1400));
	_hasLevel = true;
	_levelRequired = 0

	_var = player getVariable ["player_factories",[]]; //check to see if we are already crafting something here
	{
		private ["_id"];
		_id = _x select 0;
		if (([_id, "type"] call A3PL_Config_GetPlayerFactory) isEqualTo _type) exitwith {_alreadyCrafting = true;};
	} foreach _var;

	if(_type IN ["Vehicle Factory","Aircraft Factory","Marine Factory","Illegal Weapon Factory"]) then {
		_levelRequired = ([_id,_type,"level"] call A3PL_Config_GetFactory);
		if(player getVariable["player_level",0] < _levelRequired) exitWith {_hasLevel = false};
	};
	if (!_hasLevel) exitwith {[format["You need to be level %1 to craft this item!",_level],"red"]"Vehicle Factory","Aircraft Factory","Marine Factory","Illegal Weapon Factory" call A3PL_Player_Notification;};

	if (!isNil "_alreadyCrafting") exitwith {[localize"STR_FACTORY_ACTIONINPROGRESS","red"] call A3PL_Player_Notification;};
	if(!(call A3PL_Player_AntiSpam)) exitWith {}; //anti spam

	_control = _display displayCtrl 1500; //get id
	if (lbCurSel _control < 0) exitwith {[localize"STR_FACTORY_NOOBJECTSELECTION","red"] call A3PL_Player_Notification;};
	_id = _control lbData (lbCurSel _control);
	_required = [_id,_type,"required"] call A3PL_Config_GetFactory;
	if (isNil "_required" OR (count _required < 1)) exitwith {["System: Unexpected error occured trying to retrieve items for recipe in _Craft","red"] call A3PL_Player_Notification;};
	//first check if we have all the items

	if((_id isEqualTo "cash") && (_toCraft > 50000)) exitwith {[localize"STR_FACTORY_DIRTYCASH","red"] call A3PL_Player_Notification;};

	_temp = [];
	{
		private ["_amount","_id"];
		_id = _x select 0;
		_amount = (_x select 1)*_toCraft;
		_temp pushBack ([_id,_amount]);
		if (!([_id,_amount,_type] call A3PL_Factory_Has)) exitwith {_failed=true}; //if dont have this required item exit
	} foreach _required;
	_required = _temp;
	if (!isNil "_failed") exitwith {[format[localize"STR_FACTORY_NECESSARYITEMTOCRAFT",_toCraft],"red"] call A3PL_Player_Notification;};

	//set a variable that we will use later on to make these items UNAVAILABLE, and also to keep track of what we are still crafting
	_sec = ([_id,_type,"time"] call A3PL_Config_GetFactory)*_toCraft;
	_sec = [_sec] call A3PL_Factory_LevelBoost;

	_classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
	_classname = [_id,_type,"class"] call A3PL_Config_GetFactory;
	_craftID = floor (random 10000);
	_var = player getVariable ["Player_Factories",[]];
	_var pushback [_craftID,_classname,_required,_type,_classType,_id,1,(diag_ticktime + _sec),_toCraft]; //defined in A3PL_Config.sqf
	player setVariable ["Player_Factories",_var,false];
	[] spawn A3PL_Factory_DialogLoop; //seperate dialog loop

	[_craftID,_sec,_required,_toCraft] spawn
	{
		private ["_craftID","_sec","_type","_classType","_id","_name","_var"];
		_craftID = param [0,0];
		_sec = param [1,0];
		_required = param [2,[]];
		_toCraft = param [3,1];
		_type = [_craftID, "type"] call A3PL_Config_GetPlayerFactory;
		_classtype = [_craftID, "classtype"] call A3PL_Config_GetPlayerFactory;
		_classname = [_craftID, "classname"] call A3PL_Config_GetPlayerFactory;
		_id = [_craftID, "id"] call A3PL_Config_GetPlayerFactory;
		_name = [_id,_type,"name"] call A3PL_Config_GetFactory;
		if (_name isEqualTo "inh") then {_name = [_classname,_classType,"name"] call A3PL_Factory_Inheritance;};

		uiSleep _sec;
		[format [localize"STR_FACTORY_CRAFTEND",_name,_type,_toCraft],"green"] call A3PL_Player_Notification;
		_xpToAdd = ([_id,_type,"xp"] call A3PL_Config_GetFactory) * _toCraft;
		[player,_xpToAdd] call A3PL_Level_AddXp;

		//have server remove items from player_inventory permanently
		[player,_type,_id, _required, _toCraft] remoteExec ["Server_Factory_Finalise", 2];

		uiSleep 1.5; //account for server lag to prevent duping, during this sleep it 'can make it look' like more items are taken due to the temp factories var, it will be fixed after 1.5 seconds

		//delete from player_factories
		_var = player getVariable ["player_factories",[]];
		{
			if ((_x select 0) isEqualTo _craftID) exitwith {_var deleteAt _forEachIndex};
		} foreach _var;
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
	_type = ctrlText (_display displayCtrl 1100); //factory id from dialog text
	_control = _display displayCtrl _ctrlID; //get id
	if ((lbCurSel _control) < 0) exitwith {};
	_id = _control lbData (lbCurSel _control);
	_required = [_id,_type,"required"] call A3PL_Config_GetFactory;
	_classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
	if (_preview) then
	{
		[_type,_id] spawn A3PL_Factory_ObjectPreviewSpawn; //spawn object in preview
	};
	_control = _display displayCtrl 1501;

	_lbArray = []; //quick refresh
	{
		private ["_i","_name","_amount","_id"];
		_id = _x select 0;
		_amount = _x select 1;
		_name = format ["%1x %2",_amount,([_id,"name"] call A3PL_Config_GetItem)];
		if ([_id,_amount,_type] call A3PL_Factory_Has) then //if we have the required item
		{
			_lbArray pushback [_name,_id,true];
		} else
		{
			_lbArray pushback [_name,_id,false];
		};

	} foreach _required;

	//quick refresh lb
	lbClear _control;
	{
		_i = _control lbAdd (_x select 0); //prepare new lb entry
		_control lbSetData [_i,(_x select 1)];
		if (_x select 2) then {_control lbSetColor [_i,[0, 1, 0, 1]];} else {_control lbSetColor [_i,[1, 0, 0, 1]];};
	} foreach _lbArray;

	//set item information
	_desc = [_id,"desc"] call A3PL_Config_GetItem;
	if (typeName _desc isEqualTo "BOOL") then
	{
		switch (_classType) do
		{
			case ("car"): {_desc = "Vehicle"};
			case ("weapon"): {_desc = "Weapon"};
			case ("mag"): {_desc = "Magazine"};
			case ("magazine"): {_desc = "Magazine"};
			case default {_desc = "Undefined"};
		};
	};
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
	private _storage = [_type,"items"] call A3PL_Config_GetPlayerFStorage;
	if ((typeName _storage) isEqualTo "BOOL") exitwith {_storage = []; _storage;};
	private _fact = player getVariable ["player_factories",[]];
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
	if ((typeName _storage) isEqualTo "BOOL") then {_storage = []};

	_lbArray = [];
	{
		private _id = _x select 0;
		private _amount = _x select 1;
		private _isFactory = _id splitString "_";
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
	_i = _control lbAdd format ["Cash (%1x)",(player getvariable ["player_cash",0])]; //add money
	_control lbSetData [_i,"cash"];

	_near = nearestObjects [player, ["Thing"], 20];
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

	if (isNil "_fInv") then {
		_classtype = _aInv select 0;
		_id = _aInv select 1;
		_amount = _aInv select 2;
		_forFaction = "";
	} else {
		_classtype = _fInv select 0;
		_id = _fInv select 1;
		_amount = _fInv select 2;
		_forFaction = _fInv select 3;
	};
	if (_forFaction isEqualTo "") then {_forFaction = "All"};
	_return = [_classType,_id,_amount,_forFaction];
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

//collect item from a crate/garmant
["A3PL_Factory_CrateCollect",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_crate","_info","_classType","_id","_amount","_forFaction","_name","_mainClass","_fail"];
	_crate = param [0,objNull];
	_info = [_crate] call A3PL_Factory_CrateInfo;
	_classtype = _info select 0;
	_id = _info select 1;
	_amount = _info select 2;
	_forFaction = _info select 3;

	_exit = false;
	if(_forFaction isEqualTo "All") then {
		_owner = _crate getVariable ["owner",""];
		if (_owner != (getPlayerUID player)) exitwith {
			[localize"STR_FACTORY_OWNERSELL","red"] call A3PL_Player_Notification;
			_exit = true;
		};
	} else {
		if (((player getVariable ["faction","citizen"]) != _forFaction)) exitwith {
			_forFaction = [_forFaction] call A3PL_Lib_ParseFaction;
			[format [localize"STR_FACTORY_FACTIONCOLLECT",_forFaction],"red"] call A3PL_Player_Notification;
			_exit = true;
		};
	};
	if(_exit) exitWith {};

	_fail = false;
	_exit = false;
	if(_classType isEqualTo "item") then {
		[_id,_amount] call A3PL_Inventory_Add;
	} else {
		switch (_classtype) do {
			case ("weapon"): {player addWeapon _id;};
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
	};
	if(_exit) exitwith {[format [localize"STR_FACTORY_COLLECTTHISAMOUNT"],"red"] call A3PL_Player_Notification;};
	if (_fail) exitwith {[format ["Error: Undefined _classType in _CrateCollect (ID: %1) > report this bug",_id],"red"] call A3PL_Player_Notification;};
	deleteVehicle _crate;
	_name = [_id,_classType] call A3PL_Factory_CrateName;
	[format [localize"STR_FACTORY_COLLECTOK",_amount,_name],"green"] call A3PL_Player_Notification;
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
		case (_level >= 5): {0.05};
		case (_level >= 10): {0.1};
		case (_level >= 15): {0.15};
		case (_level >= 20): {0.2};
		case (_level >= 25): {0.25};
		case (_level >= 30): {0.3};
		case (_level >= 35): {0.35};
		case (_level >= 40): {0.4};
		case (_level >= 45): {0.45};
		case (_level >= 50): {0.5};
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
			_return = format ["%1 heure(s)",round(_minLeft/60)];
		};
	} else {
		_return = format ["%1 seconde(s)",ceil _time];
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
