/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//variables that can be changed from client
['A3PL_Player_VariablesSetup',
{
	Player_payCheckTime = 0;
	Player_MaxWeight = 250;
	Player_Hunger = profileNamespace getVariable ["player_hunger",100];
	if (!(typeName Player_Hunger == "SCALAR")) then {
		Player_Hunger = 100;
		Player_Hunger = profileNamespace setVariable ["player_hunger",100];
	};
	Player_Thirst = profileNamespace getVariable ["player_thirst",100];
	if (!(typeName Player_Thirst == "SCALAR")) then {
		Player_Thirst = 100;
		Player_Thirst = profileNamespace setVariable ["player_thirst",100];
	};
	Player_Alcohol = profileNamespace getVariable ["player_alcohol",0];
	if (!(typeName Player_Alcohol == "SCALAR")) then {
		Player_Alcohol = 0;
		Player_Alcohol = profileNamespace setVariable ["player_alcohol",0];
	};
	// [shrooms,cocaine,weed,coffee]
	Player_Drugs = profileNamespace getVariable ["player_drugs",[0,0,0,0]];
	if (!(typeName Player_Drugs == "ARRAY")) then {
		Player_Drugs = [0,0,0,0];
		Player_Drugs = profileNamespace setVariable ["player_drugs",[0,0,0,0]];
	};
	if (profilenamespace getVariable ["A3PL_ShowGrass",true]) then {
		setTerrainGrid 25;
	} else {
		setTerrainGrid 50;
	};

	Player_illegalItems = ["seed_marijuana","marijuana","cocaine","shrooms","cannabis_bud","cannabis_bud_cured","cannabis_grinded_5g","weed_5g","weed_10g","weed_15g","weed_20g","weed_25g","weed_30g","weed_35g","weed_40g","weed_45g","weed_50g","weed_55g","weed_60g","weed_65g","weed_70g","weed_75g","weed_80g","weed_85g","weed_90g","weed_95g","weed_100g","jug_moonshine","turtle","drill_bit","diamond_ill","diamond_emerald_ill","diamond_ruby_ill","diamond_sapphire_ill","diamond_alex_ill","diamond_aqua_ill","diamond_tourmaline_ill","v_lockpick","zipties","Gunpowder","keycard","coca_paste","cocaine_base","cocaine_hydrochloride","net","jug","jug_green","jug_green_moonshine","ring","ringset","bracelet","crown","necklace","golden_dildo"];
	Player_IllegalPhysicalItems = ["cocaine_brick","distillery","distillery_hose","planter","scale","grinder","cocaine_barrel","fan"];
	Player_ActionCompleted = true;
	Player_ActionDoing = false;
	Player_Item = objNull;
	Player_ItemClass = '';
	Player_Notifications = [];
	A3PL_FishingBuoy_Local = [];
	Player_AntiSpam = false;
	Player_AntiListboxSpam = false;
	Player_Lockview = false;
	Player_Ragdoll = false;

	//Vehicles keys
	A3PL_Player_Vehicles = [];

	//halloween vars
	A3PL_Halloween_AngelModeEnabled = false;
	A3PL_Owns_Guardianscript = false;

	//Start defining twitter
	A3PL_TwitterChatLog = [];
	A3PL_TwitterChatPhone = [];
	A3PL_TwitterMsg_Array = [];
	A3PL_TwitterMsg_Counter = 0;

	A3PL_Uber_JobActive = false;
	A3PL_Uber_ActiveRequest = objNull;

	//iPhoneX
	A3PL_phoneCallOn = false;
	A3PL_phoneInCall = false;
	A3PL_contacts =  [];
	A3PL_SMS = [];

	//Set iPhoneX
	[player] remoteExec ["Server_iPhoneX_GetPhoneNumber",2];
	[player] remoteExec ["Server_iPhoneX_GetContacts",2];
	[player] remoteExec ["Server_iPhoneX_GetConversations",2];

	player setvariable ["A3PL_Call_Status",[player,0,""],true];

	//road workers
	A3PL_Jobroadworker_MarkerList = [];

	//impound retrieval objects
	A3PL_Jobroadworker_Impounds = [Shop_ImpoundRetrieve,Shop_ImpoundRetrieve_1,Shop_ImpoundRetrieve_2,Shop_ImpoundRetrieve_3,Shop_ImpoundRetrieve_5];
	A3PL_Chopshop_Retrivals = [Shop_Chopshop_Retrieve_1];
	A3PL_Air_Impounds = [Shop_ImpoundRetrieve_4];
	A3PL_Jobroadworker_MarkBypass =	["A3PL_EMS_Locker","A3PL_P362_TowTruck","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Pierce_Rescue","A3PL_Box_Trailer"];

	//Check A3PL_Intersect for more info
	//A3PL_ObjIntersect replaces cursortarget and is more reliable (is Nil when there is no intersection or object distance > 20m)
	//A3PL_NameIntersect returns the memory interaction point if
	//1. 2D distance (player-interaction point/memory point) < 3m
	//2. Object distance < 20m
	//Otherwise value returns ""
	Player_NameIntersect = "";
	Player_ObjIntersect = player;
	Player_selectedIntersect = 0;

	Player_ActionInterrupted = false;

	A3PL_Respawn_Time = 60 * 10;
	//a copy of this variable also exist on the server
	A3PL_HitchingVehicles = ["A3PL_Car_Base","A3PL_Truck_Base"];

	//change to imperial system
	setSystemOfUnits 2;

	//increase long range freq range
	TF_MAX_ASIP_FREQ = 130;
}] call Server_Setup_Compile;

["A3PL_Player_AntiSpam",
{
	if(Player_AntiSpam) exitWith {
		[localize "STR_PLAYER_ANTISPAM", "red"] call A3PL_Player_Notification;
		false
	};
	Player_AntiSpam = true;
	[] spawn {
		sleep 0.5;
		Player_AntiSpam = false;
	};
	true
}] call Server_Setup_Compile;

["A3PL_Player_AntiListboxSpam",
{
	if(Player_AntiListboxSpam) exitWith {false};
	Player_AntiListboxSpam = true;
	[] spawn {
		uiSleep 0.01;
		Player_AntiListboxSpam = false;
	};
	true
}] call Server_Setup_Compile;

//creates an array which drawText will use to draw player tags on the screen, we dont want to run complicated scripts onEachFrame
["A3PL_Player_NameTags",
{
	private _players = nearestObjects [player, ["C_man_1"], 4];
	private _players = _players - [player];
	private _tags = [];
	private _goggles = ["A3PL_Deadpool_Mask","A3PL_IronMan_Mask","A3PL_Anon_mask","A3PL_Horse_Mask","G_Balaclava_blk","G_Balaclava_combat","G_Balaclava_TI_G_tna_F","G_Balaclava_lowprofile","G_Balaclava_oli","G_Balaclava_TI_tna_F","G_Balaclava_TI_G_blk_F","G_Balaclava_TI_blk_F","A3PL_Skull_Mask","A3PL_Watchdogs_Mask","G_Bandanna_aviator","G_Bandanna_blue_aviator","G_Bandanna_orange_aviator","G_Bandanna_pink_aviator","G_Bandanna_red_aviator","G_Bandanna_maroon_aviator","G_Bandanna_white_aviator","G_Bandanna_yellow_aviator","G_Bandanna_black_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_khk","G_Bandanna_tan","G_Bandanna_sport"];
	private _headgear = ["H_Shemag_olive","H_Shemag_tan","H_Shemag_khk","A3PL_RacingHelmet_1","A3PL_RacingHelmet_2","A3PL_RacingHelmet_3","A3PL_RacingHelmet_4","A3PL_RacingHelmet_5","A3PL_RacingHelmet_6","A3PL_RacingHelmet_7","A3PL_RacingHelmet_8","A3PL_RacingHelmet_9","A3PL_RacingHelmet_10","A3PL_RacingHelmet_11","A3PL_Hoosier_Racing_Helmet","A3PL_SN_Race_Helmet","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_olive_hs"];
	{
		private["_uid","_saved","_savedName","_hasMaskCheck","_cansee","_id","_name"];
		if (simulationEnabled _x) then
		{
			_uid = getPlayerUID _x;
			_saved = profileNamespace getVariable ["A3FL_NameTags",[]];
			_savedName = "";
			{
				if((_x select 0) isEqualTo _uid) exitWith {
					_savedName = (_x select 1);
				}
			} forEach _saved;

			_hasMaskCheck = false;
			if (goggles _x IN _goggles) then {_hasMaskCheck = true;};
			if (headgear _x IN _headgear) then {_hasMaskCheck = true;};
			_cansee = (profilenamespace getVariable ["Player_EnableID",true]) && (([objNull, "VIEW"] checkVisibility [eyePos player, eyePos _x]) > 0) && (!isObjectHidden _x);
			if (_cansee) then
			{
				_id = _x getVariable ["db_id",-1];
				if(!(_savedName isEqualTo "") && !_hasMaskCheck) then {
					_name = format["%1 - %2",_id,_savedName];
					_tags pushback [_x,_name];
				} else {
					_name = format["%1 - Unknown",_id];
					_tags pushback [_x,_name];
				};
			};
		};
	} foreach _players;
	A3PL_Player_TagsArray = _tags;
}] call Server_Setup_Compile;

//gets nearest businesses, and business items
["A3PL_Player_BusinessTags",
{
	private ["_bus","_tags","_iTags","_items"];
	_bus = nearestObjects [player, ["Land_A3PL_Showroom","Land_A3PL_Cinema","Land_A3PL_Gas_Station","Land_A3PL_Garage","land_smallshop_ded_smallshop_01_f","land_smallshop_ded_smallshop_02_f","Land_A3FL_Brick_Shop_1","Land_A3FL_Brick_Shop_2"], 50];
	_items = nearestObjects [player, [], 10];
	_tags = [];
	_iTags = [];
	{
		_bName = _x getVariable ["bName",""];
		if (_bName != "") then
		{
			private ["_pos"];
			switch (typeOf _x) do
			{
				case ("Land_A3PL_Showroom"): {_pos = _x modelToWorld [10,0,0];};
				case ("land_smallshop_ded_smallshop_02_f"): {_pos = _x modelToWorld [8,0,0];};
				case ("land_smallshop_ded_smallshop_01_f"): {_pos = _x modelToWorld [8,0,0];};
				case ("Land_A3PL_Garage"): {_pos = _x modelToWorld [6,2,-1];};
				case ("Land_A3PL_Gas_Station"): {_pos = _x modelToWorld [-3.5,-0.65,-1];};
				case ("Land_A3FL_Brick_Shop_1"): {_pos = _x modelToWorld [8,0,0];};
				case ("Land_A3FL_Brick_Shop_2"): {_pos = _x modelToWorld [8,0,0];};
			};
			_tags pushback [_pos,_bName];
		};
	} foreach _bus;

	{
		_bItem = _x getVariable ["bItem",[]];
		if (count _bItem != 0) then
		{
			private ["_icon","_businessItem"];
			if (_x isKindOf "Car") then {_icon = "\A3\ui_f\data\map\VehicleIcons\iconcar_ca.paa";};
			if (isNil "_icon") then {_icon = "\A3\ui_f\data\map\VehicleIcons\iconcratewpns_ca.paa";};
			_businessItem = _bItem select 2;
			if (_businessItem) then {_businessItem = "business";} else {_businessItem = "particulier";};
			_iTags pushback [_x modelToWorld [0,0,0.75],format ["$%1 - %2 (%3)",_bItem select 0,_bItem select 1,_businessItem],_icon];//pos,display,icon
		};
	} foreach _items;

	A3PL_Player_bTagsArray = _tags;
	A3PL_Player_biTagsArray = _iTags;
}] call Server_Setup_Compile;

//["A3PL_DrawText", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
["A3PL_Player_DrawText",
{
	["A3PL_DrawText", "onEachFrame",
	{
		{
			_p = _x select 0;
			_pos = visiblePositionASL _p;
			_pos set [2, ((_p modelToWorld [0,0,0]) select 2) + 2];
			if (_p getVariable ["pVar_RedNameOn",false]) then {
				drawIcon3D ["", [0.98,0,0,1],_pos, 0.2, 0.2, 45,format ["%2 %1 (OOC)",((_x select 0) getvariable["name",name (_x select 0)]), [(_x select 0)] call A3PL_AdminTitle], 1, 0.03, "EtelkaNarrowMediumPro"];
			} else {
				drawIcon3D ["", [1, 1, 1, 1],_pos, 0.2, 0.2, 45, _x select 1, 1, 0.03, "EtelkaNarrowMediumPro"];
			};
		} foreach (missionNameSpace getVariable ["A3PL_Player_TagsArray",[]]);

		{
			drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Actions\open_door_ca.paa", [1, 1, 1, 1],_x select 0, 0.5, 0.5, 45, _x select 1, 1, 0.03, "EtelkaNarrowMediumPro"];
		} foreach (missionNameSpace getVariable ["A3PL_Player_bTagsArray",[]]);

		{
			drawIcon3D [_x select 2, [1, 1, 1, 1],_x select 0, 0.5, 0.5, 45, _x select 1, 1, 0.03, "EtelkaNarrowMediumPro"];
		} foreach (missionNameSpace getVariable ["A3PL_Player_biTagsArray",[]]);
	}] call BIS_fnc_addStackedEventHandler;
}] call Server_Setup_Compile;

//First function that loads when player joins
['A3PL_Player_Initialize', {
	private ["_myVersion"];
	//#include "\x\cba\addons\ui_helper\script_dikCodes.hpp"

	//Whitelist
	//[player] remoteExec ["Server_Core_WhitelistServer",2];


	//do a version check first
	if ((getNumber (configFile >> "CfgPatches" >> "A3PL_Common" >> "requiredVersion")) < (missionNameSpace getVariable ["Server_ModVersion",0])) exitwith
	{
		[] spawn {
			titleText ["Please download the latest addon update.", "BLACK"];
			uiSleep 5;
			player setVariable ["A3PL_Outdated",1,true];
		};
	};

	inGameUISetEventHandler ["PrevAction", "if (Player_selectedIntersect > 0) then {Player_selectedIntersect = Player_selectedIntersect - 1;}; true"];
	inGameUISetEventHandler ["NextAction", "Player_selectedIntersect = Player_selectedIntersect + 1; true"];
	inGameUISetEventHandler ["Action", "true;"]; //block scroll option
	showHUD [true,false,false,false,false,false,false,true,false]; //hide scroll option
	player addAction ["", {}];

	//Setup normal variables
	call A3PL_Player_VariablesSetup;

	//Start loading process
	call A3PL_Loading_Start;

	//Initialise the HUD
	call A3PL_HUD_Init;
	call A3PL_HUD_GPS;


	//Setup loops
	call A3PL_Loop_Setup;

	//Setup Eventhandlers
	call A3PL_EventHandlers_Setup;

	//Setup intersection oneachframe, used for interaction menu
	call A3PL_Intersect_Lines;

	//setup name tags
	call A3PL_Player_DrawText;

	//setup housing
	[] spawn A3PL_Housing_Init;

	//setup warehouses
	[] spawn A3PL_Warehouses_Init;

	//Escape menu edition
	[] spawn A3PL_Player_EscapeControls;

	call A3PL_Player_CheckDebugVariables;
}] call Server_Setup_Compile;

['A3PL_Player_NewPlayer',{
	disableSerialization;
	private ["_display","_control","_sex","_day","_month","_year"];

	waituntil {sleep 0.1; isNull(findDisplay 15)};
	createDialog "Dialog_NewPlayer";
	_display = findDisplay 111;
	noEscape = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then {true}"];
	_sex = _display displayCtrl 1403;
    _day = _display displayCtrl 1404;
    _month = _display displayCtrl 1405;
    _year = _display displayCtrl 1406;
    _control = _display displayCtrl 2100;
	_sex lbAdd "Male";
	_sex lbSetData [(lbSize _sex) - 1, "male"];
	_sex lbAdd "Female";
	_sex lbSetData [(lbSize _sex) - 1, "female"];

	for "_i" from 1 to 31 do {
		_day lbAdd str _i;
		_day lbSetData [(lbSize _day)-1,str(_i)];
	};

	for "_l" from 1 to 12 do {
		_month lbAdd str _l;
		_month lbSetData [(lbSize _month)-1,str(_l)];
	};

	for "_k" from 1920 to 2001 do {
		_value = 2001 - (_k - 1920);
		_year lbAdd str _value;
		_year lbSetData [(lbSize _year)-1,str(_value)];
	};
	//Structured text
	_control = _display displayCtrl 2100;

	//message
	if (isNil "A3PL_NewPlayerRequested") then
	{
		[localize "STR_PLAYER_PLSENTERDET", "green"] call A3PL_Player_Notification; //System: It looks like you are a new player, please enter your details
	} else
	{
		[localize "STR_PLAYER_NAMEINUSE", "red"] call A3PL_Player_Notification; //System: Server was unable to create your character, maybe the name is already in use?
	};
	A3PL_NewPlayerRequested = true;
}] call Server_Setup_Compile;

['A3PL_Player_NewPlayerSubmit',{
	private ["_display","_control","_firstname","_lastname","_checkname","_forbiddenChars","_acceptedChars","_c","_sex","_dob","_day","_month","_year"];
	_display = findDisplay 111;
	//Structured text
	_control = _display displayCtrl 1400;
	_firstname = ctrlText _control;
	_control = _display displayCtrl 1401;
	_lastname = ctrlText _control;
	_sex = lbData [1403,(lbCurSel 1403)];
	_day = lbData [1404,(lbCurSel 1404)];
	_day = parseNumber _day;
    _month = lbData [1405,(lbCurSel 1405)];
	_month = parseNumber _month;
    _year = lbData [1406,(lbCurSel 1406)];
	_year = parseNumber _year;

	if (count _firstname < 2) exitwith
	{
		[localize "STR_PLAYER_FIRSTN2CHAR", "red"] call A3PL_Player_Notification; //System: Please enter a firstname that's longer than 2 characters
	};

	if (count _lastname < 2) exitwith
	{
		[localize "STR_PLAYER_LASTN2CHAR", "red"] call A3PL_Player_Notification; //System: Please enter a lastname that's longer than 2 characters
	};

	if (_sex isEqualTo "") exitWith {
		[localize"STR_NewPlayer_FillGender","red"] call A3PL_Player_Notification;
	};

	if (_day isEqualTo 0 || _month isEqualTo 0 || _year isEqualTo 0) exitWith {
		[localize"STR_NewPlayer_FillDOB","red"] call A3PL_Player_Notification;
	};

    _dob = format ["%1/%2/%3",_day, _month, _year];

	//check the player name for invalid characters
	_checkname = _firstname + _lastname;
	_checkname = toArray _checkname;
	_acceptedChars = toArray "abcdefghijklmnopqrstuvwxyz";
	_forbiddenUsed = false;
	{
		if (!(_x IN _acceptedChars)) exitwith
		{
			_forbiddenUsed = true;
		};
	} foreach _checkname;

	if (_forbiddenUsed) exitwith
	{
		[localize "STR_PLAYER_FORBCHAR", "red"] call A3PL_Player_Notification; //System: You used forbidden characters in your name, please resolve this
		[localize "STR_PLAYER_CAPITALLETT", "red"] call A3PL_Player_Notification; //System: Do not use capital letters, this will be done automatically
	};

	//fix capital letters
	_c = toArray "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	_firstname = toArray _firstname;
	_firstname set [0,_c select (_acceptedChars find (_firstname select 0))];
	_firstname = toString _firstname;

	_lastname = toArray _lastname;
	_lastname set [0,_c select (_acceptedChars find (_lastname select 0))];
	_lastname = toString _lastname;

	[player,(_firstname + " " + _lastname), (ctrlText 1402), _sex, _dob] remoteExec ["Server_Gear_NewReceive", 2];

	if(_sex isEqualTo "female") then {
		player addUniform (["woman1","woman2","woman3"] select (round (random 2)));
	};

	[localize"STR_NewPlayer_Welcome1", "green"] call A3PL_Player_Notification;
	[localize"STR_NewPlayer_Welcome2","green"] call A3PL_Player_Notification;
	closeDialog 0;
}] call Server_Setup_Compile;

//check if has enough money
['A3PL_Player_HasCash', {
	private ['_amount', '_cash'];

	_amount = [_this, 0, 0, [0]] call BIS_fnc_param;
	_cash = player getVariable 'Player_Cash';

	//Check if player has _amount in cash
	if (_cash >= _amount) exitWith {true};
	false
}] call Server_Setup_Compile;

//check if has enough money
['A3PL_Player_HasBank', {
	private ['_amount', '_bank'];

	_amount = [_this, 0, 0, [0]] call BIS_fnc_param;
	_bank = player getVariable 'Player_Bank';

	//Check if player has _amount in bank
	if (_bank >= _amount) exitWith {true};

	false
}] call Server_Setup_Compile;

//add paycheck money - players have to pick it up from the bank - very simple right now
['A3PL_Player_PickupPaycheck', {
	private ['_paycheckAmount', '_format'];

	_paycheckAmount = Player_Paycheck;

	//make sure they have a paycheck to pickup
	if (Player_Paycheck < 1) exitWith
	{
		[localize "STR_PLAYER_NOPAYCHCOL", "red"] call A3PL_Player_Notification; //System: There doesn't seem to be a paycheck to collect
	};

	//reset variables
	Player_Paycheck = 0;

	//Change bank variable
	[player, 'Player_Bank', ((player getVariable 'Player_Bank') + _paycheckAmount)] remoteExec ['Server_Core_ChangeVar', 2];
	[player, Player_Paycheck] remoteExec ["Server_Player_UpdatePaycheck",2];

	//display notification
	_format = format[localize "STR_PLAYER_SIGNEDREC", [_paycheckAmount] call A3PL_Lib_FormatNumber]; //I signed my paycheck and received $%1 into my bank account
	[_format, "green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//retrieve a player tag
["A3PL_Player_GetNameTag",
{
	private _player = param [0,objNull];
	private _uid = getPlayerUID _player;
	private _saved = profileNamespace getVariable ["A3FL_NameTags",[]];
	private _name = "Unknown";
	{
		if((_x select 0) isEqualTo _uid) exitWith {
			_name = (_x select 1);
		};
	} forEach _saved;
	_name;
}] call Server_Setup_Compile;

["A3PL_Player_OpenNametag", {
	private ["_player","_uid","_name","_saved"];
	_player = param [0,objNull];
	_uid = getPlayerUID _player;

	A3PL_Nametag_Uid = _uid;
	_saved = profileNamespace getVariable ["A3FL_NameTags",[]];
	_name = "";

	{
		_sUID = _x select 0;
		_sName = _x select 1;
		if(_sUID == _uid) exitWith {
			_name = _sName;
		};
	} forEach _saved;

	createDialog "Dialog_Nametag";
	ctrlSetText [1400, _name];
}] call Server_Setup_Compile;

["A3PL_Player_SaveNametag", {
	_saved = profileNamespace getVariable ["A3FL_NameTags",[]];
	_name = ctrlText 1400;

	_id = -1;
	{
		_sUID = _x select 0;
		if(_sUID == A3PL_Nametag_Uid) exitWith {
			_id = _forEachIndex;
		};
	} forEach _saved;

	if(_id > -1) then {
		_saved set [_id,[A3PL_Nametag_Uid,_name]];
	} else {
		_saved pushBack [A3PL_Nametag_Uid,_name];
	};
	profileNamespace setVariable ["A3FL_NameTags",_saved];
	closeDialog 0;
}] call Server_Setup_Compile;

//hostage, spawn this
["A3PL_Player_TakeHostage",
{
	private _target = param [0,objNull];

	if (!(_target IN allPlayers)) exitwith {[localize "STR_PLAYER_NOTLOOKINGVALPL","red"] call A3PL_Player_Notification;};
	if ((handgunWeapon player isEqualTo "") OR ((handgunWeapon player) IN ["A3FL_PepperSpray","hgun_Pistol_Signal_F","A3PL_Jaws","A3PL_Taser2","A3PL_Pickaxe","A3PL_Shovel","A3PL_High_Pressure","A3PL_FireExtinguisher","A3PL_Predator"])) exitwith {["You need a handgun","red"] call A3PL_Player_Notification;};
	if (!isNil "A3PL_EnableHostage") exitwith {[localize "STR_PLAYER_TAKESOMEONEHOST","red"] call A3PL_Player_Notification;};

	if ((_target distance2D player) > 3) exitwith {["Too far away to take this person hostage!","red"] call A3PL_Player_Notification;};

	player selectWeapon handgunWeapon player;

	A3PL_EnableHostage = true;
	A3PL_HostageMode = "hostage";
	A3PL_HostageTarget = _target;
	A3PL_HostageReloading = false;
	player setVariable["takingHostage",true,true];
	_target setVariable["takenHostage",true,true];
	player forceWalk true;

	{detach _x;} foreach (attachedObjects _target);

	_ehFired = player addEventHandler ["Fired",
	{
		if ((A3PL_HostageMode isEqualTo "hostage")) exitwith {
			if ((!isNull A3PL_HostageTarget) && ((handgunWeapon player) != "A3PL_Taser")) then {detach A3PL_HostageTarget; A3PL_HostageTarget setDamage 1;};
			A3PL_EnableHostage = false;
		};
	}];
	_ehReload = (findDisplay 46) displayAddEventHandler ["KeyDown",
	{
		if ((_this select 1) in actionKeys "ReloadMagazine") then {
			[] spawn {
				A3PL_HostageReloading = true;
				sleep 3.5;
				if (!isNil "A3PL_HostageReloading") then {A3PL_HostageReloading = false};
			};
			false;
		};
	}];

	player playAction "gesture_takehostage";
	[_target,"A3PL_TakenHostage"] remoteExec ["A3PL_Lib_SyncAnim",-2];
	_target attachto [player,[-0.05,0.2,-0.02]];

	_target setVariable ["tf_unable_to_use_radio", true];
	while {A3PL_EnableHostage} do
	{
		if ((A3PL_HostageMode isEqualTo "hostage") && !A3PL_HostageReloading) then { player playAction "gesture_takehostageloop"; };
		if ((A3PL_HostageMode isEqualTo "shoot") && !A3PL_HostageReloading) then { player playAction "gesture_takehostageshootloop"; };
		if(!(player getVariable["A3PL_Medical_Alive",true])) exitWith {};
		if(!(A3PL_HostageTarget getVariable["A3PL_Medical_Alive",true])) exitWith {};
		if(isNull A3PL_HostageTarget) exitWith {};
		sleep 0.5;
	};
	_target setVariable ["tf_unable_to_use_radio", false];
	player forceWalk false;
	player playAction "gesture_stop";
	player removeEventHandler ["Fired",_ehFired];
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_ehReload];
	A3PL_EnableHostage = nil; A3PL_HostageMode = nil; A3PL_HostageTarget = nil; A3PL_HostageReloading = nil;

	if((_target getVariable["A3PL_Medical_Alive",true]) && (player getVariable["A3PL_Medical_Alive",true])) then
	{
		[_target,"A3PL_ReleasedHostage"] remoteExec ["A3PL_Lib_SyncAnim",-2];
		[player,"A3PL_ReleaseHostage"] remoteExec ["A3PL_Lib_SyncAnim",-2];
		sleep 3;
		detach _target;
		[_target,""] remoteExec ["A3PL_Lib_SyncAnim",-2];
		[player,""] remoteExec ["A3PL_Lib_SyncAnim",-2];
	} else {
		if(player getVariable["A3PL_Medical_Alive",true]) then {[player,""] remoteExec ["A3PL_Lib_SyncAnim",-2];};
		if(_target getVariable["A3PL_Medical_Alive",true]) then {[_target,""] remoteExec ["A3PL_Lib_SyncAnim",-2];};
		detach _target;
	};
	player setVariable["takingHostage",nil,true];
}] call Server_Setup_Compile;

["A3PL_Player_SetMarkers",
{
	_job = player getVariable ["job","unemployed"];
	_faction = player getVariable ["faction","citizen"];
	if(_job != "waste") then {
		{_x setMarkerAlphaLocal 0;} forEach ["trash_bin_1","trash_bin_2","trash_bin_3","trash_bin_4","trash_bin_5","trash_bin_6","trash_bin_7","trash_bin_8","trash_bin_9","trash_bin_10","trash_bin_11","trash_bin_12","trash_bin_13","trash_bin_14","trash_bin_15","trash_bin_16","trash_bin_17","trash_bin_18","trash_bin_19","trash_bin_20","trash_bin_21","trash_bin_22","trash_bin_23","trash_bin_24","trash_bin_25","trash_bin_26","trash_bin_27","trash_bin_28","trash_bin_29","trash_bin_30","trash_bin_31","trash_bin_32","trash_bin_33","trash_bin_34","trash_bin_35","trash_bin_36","trash_bin_37","trash_bin_38","trash_bin_39","trash_bin_40","trash_bin_41","trash_bin_42","trash_bin_43","trash_bin_44","trash_bin_45","trash_bin_46","trash_bin_47","trash_bin_48","trash_bin_49","trash_bin_50","trash_bin_51","trash_bin_52","trash_bin_53","trash_bin_54","trash_bin_55","trash_bin_56","trash_bin_57","trash_bin_58","trash_bin_59","trash_bin_60","trash_bin_61","trash_bin_62","trash_bin_63","trash_bin_64","trash_bin_65","trash_bin_66","trash_bin_67","trash_bin_68","trash_bin_69","trash_bin_70","trash_bin_71"];
	} else {
		{_x setMarkerAlphaLocal 1;} forEach ["trash_bin_1","trash_bin_2","trash_bin_3","trash_bin_4","trash_bin_5","trash_bin_6","trash_bin_7","trash_bin_8","trash_bin_9","trash_bin_10","trash_bin_11","trash_bin_12","trash_bin_13","trash_bin_14","trash_bin_15","trash_bin_16","trash_bin_17","trash_bin_18","trash_bin_19","trash_bin_20","trash_bin_21","trash_bin_22","trash_bin_23","trash_bin_24","trash_bin_25","trash_bin_26","trash_bin_27","trash_bin_28","trash_bin_29","trash_bin_30","trash_bin_31","trash_bin_32","trash_bin_33","trash_bin_34","trash_bin_35","trash_bin_36","trash_bin_37","trash_bin_38","trash_bin_39","trash_bin_40","trash_bin_41","trash_bin_42","trash_bin_43","trash_bin_44","trash_bin_45","trash_bin_46","trash_bin_47","trash_bin_48","trash_bin_49","trash_bin_50","trash_bin_51","trash_bin_52","trash_bin_53","trash_bin_54","trash_bin_55","trash_bin_56","trash_bin_57","trash_bin_58","trash_bin_59","trash_bin_60","trash_bin_61","trash_bin_62","trash_bin_63","trash_bin_64","trash_bin_65","trash_bin_66","trash_bin_67","trash_bin_68","trash_bin_69","trash_bin_70","trash_bin_71"];
	};
	if(_faction IN ["fifr","uscg","fisd","fims","doj"]) then {
		{_x setMarkerAlphaLocal 0;} forEach ["chemical_dealer","Shroom_Picking","Crime_Base","Shrooms_Field","Moonshine_Shop","Moonshine_Shop_1"];
	} else {
		{_x setMarkerAlphaLocal 1;} forEach ["chemical_dealer","Shroom_Picking","Crime_Base","Shrooms_Field","Moonshine_Shop","Moonshine_Shop_1"];
	};
	if(_faction != "fbi") then {
		{_x setMarkerAlphaLocal 0;} forEach ["Area_PirateYacht_1","Area_PirateYacht_2","A3PL_Marker_Hunting_1","A3PL_Marker_Hunting","A3PL_Marker_Hunting_3","A3PL_Marker_Hunting_2","A3PL_Marker_Fish4","A3PL_Marker_Fish3","A3PL_Marker_SallySpeedway","FIMiningArea","NIMiningArea","CemeteryArea","Area_DrugDealer9","Area_DrugDealer8","Area_DrugDealer7","Area_DrugDealer6","Area_DrugDealer5","Area_DrugDealer4","Area_DrugDealer3","Area_DrugDealer2","Area_DrugDealer1","Area_DrugDealer","Area_DrugDealer10","Area_DrugDealer11","Area_DrugDealer12","Area_DrugDealer13","Area_DrugDealer14","A3PL_Markers_Fish6","A3PL_Markers_Fish1","LumberJack_Rectangle","A3PL_Marker_Sand1","A3PL_Marker_Sand2","A3PL_Marker_Fish1","A3PL_Marker_Fish2","A3PL_Marker_Fish8","A3PL_Marker_Fish7","A3PL_Marker_Fish5","A3PL_Marker_Fish6","Picking_Apple_1"];
	} else {
		{_x setMarkerAlphaLocal 1;} forEach ["Area_PirateYacht_1","Area_PirateYacht_2","A3PL_Marker_Hunting_1","A3PL_Marker_Hunting","A3PL_Marker_Hunting_3","A3PL_Marker_Hunting_2","A3PL_Marker_Fish4","A3PL_Marker_Fish3","A3PL_Marker_SallySpeedway","FIMiningArea","NIMiningArea","CemeteryArea","Area_DrugDealer9","Area_DrugDealer8","Area_DrugDealer7","Area_DrugDealer6","Area_DrugDealer5","Area_DrugDealer4","Area_DrugDealer3","Area_DrugDealer2","Area_DrugDealer1","Area_DrugDealer","Area_DrugDealer10","Area_DrugDealer11","Area_DrugDealer12","Area_DrugDealer13","Area_DrugDealer14","A3PL_Markers_Fish6","A3PL_Markers_Fish1","LumberJack_Rectangle","A3PL_Marker_Sand1","A3PL_Marker_Sand2","A3PL_Marker_Fish1","A3PL_Marker_Fish2","A3PL_Marker_Fish8","A3PL_Marker_Fish7","A3PL_Marker_Fish6","A3PL_Marker_Fish5","Picking_Apple_1"];
	};
}] call Server_Setup_Compile;

["A3PL_Player_SetPaycheck",
{
	_paycheckSaved = param [0,0];
	Player_Paycheck = _paycheckSaved;
}] call Server_Setup_Compile;

["A3PL_Player_EscapeControls",
{
	for "_i" from 0 to 1 step 0 do {
		waitUntil {!isNull (findDisplay 49)};
		private _admin = player getVariable ["dbVar_AdminLevel",0];
		if(_admin >= 4) exitWith {};
		private["_abortButton", "_respawnButton", "_manuelButton", "_display"];
		disableSerialization;
		_display = (findDisplay 49);
		_abortButton = _display displayCtrl 104;
		_abortButton ctrlEnable false;
		_manuelButton = _display displayCtrl 122;
		_manuelButton ctrlEnable false;
		_manuelButton ctrlShow false;
		_respawnButton = _display displayCtrl 1010;
		_respawnButton ctrlEnable false;
		_respawnButton ctrlShow false;
		if((player getVariable["Zipped",false]) || (player getVariable["Cuffed",false])) then {
			_abortButton ctrlSetText "YOU CANNOT DISCONNECT";
		} else {
			[_abortButton, _display] spawn {
				_timeStamp = time + 10;
				waitUntil {
					(_this select 0) ctrlSetText format["WAIT %1 SECONDS...", ([(_timeStamp - time), "SS.MS"] call BIS_fnc_secondsToString)];
					(_this select 0) ctrlCommit 0;
					round(_timeStamp - time) <= 0 || isNull (_this select 1)
				};
				if (!(isNull (_this select 1))) then {
					if (alive player) then	{
						(_this select 0) ctrlSetText "YOU CAN NOW DISCONNECT";
						(_this select 0) ctrlCommit 0;
						(_this select 0) ctrlEnable true;
					} else {
						(_this select 0) ctrlSetText "IMPOSSIBLE NOW";
						(_this select 0) ctrlCommit 0;
					};
				};
			};
		};
		[player,getPlayerUID player,false] remoteExec ["Server_Gear_Save", 2];
		waitUntil {isNull (findDisplay 49) || {!alive player}};
		if (!isNull (findDisplay 49) && {!alive player}) then {
			(findDisplay 49) closeDisplay 2;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Player_Whitelist", {
	private _uid = param [0,""];
	private _faction = param [1,""];
	if(_faction != "citizen") then {
		_fname = "";
		switch(_faction) do {
			case ("fifr"): {_fname = "Fire Department"};
			case ("uscg"): {_fname = "United States Coast Guard"};
			case ("fisd"): {_fname = "Sheriff Department"};
			case ("doj"): {_fname = "Department of Justice"};
			case ("fims"): {_fname = "Fishers Island Marshals Service"};
		};
		[format["You've been hired by %1",_fname],"green"] spawn A3PL_Player_Notification;
	} else {
		[format["You've been fired"],"green"] spawn A3PL_Player_Notification;
		player setVariable["job","unemployed",true];
	};
	player setVariable["faction",_faction,true];
	[_uid, _faction] remoteExec ["Server_Player_Whitelist",2];
}] call Server_Setup_Compile;

["A3PL_Player_TeamspeakID",
{
	private ["_allAlphabets","_allNumbers","_TFR_Id","_nickname"];
	_allAlphabets = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
	_allNumbers = ["0","1","2","3","4","5","6","7","8","9"];
	_TFR_Id = player getVariable ["A3PL_TeamspeakID",nil];
	_nickname = format ["A3FL - %1%2%3%4%5%6%7%8",selectRandom _allNumbers,selectRandom _allAlphabets,selectRandom _allNumbers,selectRandom _allAlphabets,selectRandom _allNumbers,selectRandom _allAlphabets,selectRandom _allNumbers,selectRandom _allAlphabets];
	if (isNil '_TFR_Id') then {
	    player setVariable ["A3PL_TeamspeakID", _nickname, true];
	};
	_nickname;
}] call Server_Setup_Compile;

['A3PL_Player_Notification',
{
	params [
		["_text","",[""]],
		["_color",[""]],
		["_speed",10,[10]]
	];

	if (!(profilenamespace getVariable ["A3PL_Notifications_Enabled",true])) exitWith {};

	if(isNil "A3PL_Player_Notifications") then {
		A3PL_Player_Notifications = [];
	};
	disableSerialization;
	_display = findDisplay 46;

	_alpha = 0.6;
	switch (_color) do {
		case "red": {_color = [0.957,0.263,0.212,_alpha];};
		case "pink": {_color = [0.914,0.118,0.388,_alpha];};
		case "purple": {_color = [0.612,0.153,0.69,_alpha];};
		case "blue": {_color = [0.129,0.588,0.953,_alpha];};
		case "light-blue": {_color = [0.012,0.663,0.957,_alpha];};
		case "green": {_color = [0.298,0.686,0.314,_alpha];};
		case "light-green": {_color = [0.545,0.765,0.29,_alpha];};
		case "yellow": {_color = [1,0.922,0.231,_alpha];};
		case "amber": {_color = [1,0.757,0.027,_alpha];};
		case "orange": {_color = [1,0.596,0,_alpha];};
		case "brown": {_color = [0.475,0.333,0.282,_alpha];};
		default {_color = [1,0.596,0,_alpha];};
	};

	/*if (_text isEqualType "") then {
		_text = parseText _text;
	};*/
	playSound "HintExpand";

	_margin = 0.01;
	_width = safeZoneW * 0.15;
 	_borderWidth = safeZoneW * 0.005;
	_textWidth = _width - _borderWidth;
	_height = 0;
	_posX = 0;
	_posY = 0;

	_displaySide = "left";
	if(_displaySide == "left") then {
		_posX = _margin + safeZoneX;
	} else {
		_posX = safeZoneW + safeZoneX - _margin - _width;
	};

	private _BorderCtrl = _display ctrlCreate ["RscText", -1];
	_BorderCtrl ctrlSetPosition [_posX, _posY, _borderWidth, _height];
	_BorderCtrl ctrlSetBackgroundColor _color;
	_BorderCtrl ctrlSetFade 1;
	_BorderCtrl ctrlCommit 0;
	_BorderCtrl ctrlSetFade 0;
	_BorderCtrl ctrlCommit 0.4;

	private _TextCtrl = _display ctrlCreate ["RscStructuredText", -1];
	_TextCtrl ctrlSetPosition [(_posX + _borderWidth), _posY, _width, _height];
	_TextCtrl ctrlSetStructuredText parseText format ["<t size='1' font='RobotoCondensed' color='#ffffff'>%1</t>", _text];
	_TextCtrl ctrlCommit 0;

	_adjustedHeight = (ctrlTextHeight _TextCtrl);
	_TextCtrl ctrlSetPosition [(_posX + _borderWidth), _posY, _width, _adjustedHeight];
	_BorderCtrl ctrlSetPosition [_posX, _posY, _borderWidth, _adjustedHeight];
	_BorderCtrl ctrlCommit 0;
	_TextCtrl ctrlSetBackgroundColor [0.129,0.129,0.129,_alpha];
	_TextCtrl ctrlSetFade 1;
	_TextCtrl ctrlCommit 0;
	_TextCtrl ctrlSetFade 0;
	_TextCtrl ctrlCommit 0.4;

	[_TextCtrl,_BorderCtrl,_speed] spawn {
		disableSerialization;
		uiSleep (_this select 2);
		private _TextCtrl = _this select 0;
		private _BorderCtrl = _this select 1;
		_TextCtrl ctrlSetFade 1;
		_TextCtrl ctrlCommit 0.3;
		_BorderCtrl ctrlSetFade 1;
		_BorderCtrl ctrlCommit 0.3;
		uiSleep 0.3;
		ctrlDelete _BorderCtrl;
		ctrlDelete _TextCtrl;
	};

	_offsetY = 0;
	A3PL_Player_Notifications = ([[_BorderCtrl,_TextCtrl]] + A3PL_Player_Notifications) select {!isNull (_x select 0) && !isNull (_x select 1)};
	private _activeNotifications = 0;
	{
		private _ctrlBorder = _x select 0;
		private _ctrlText = _x select 1;
		if (!isNull _ctrlBorder && !isNull _ctrlText) then {
			_ctrlBorder ctrlSetPosition [_posX, (_posY + _offsetY)];
			_ctrlText ctrlSetPosition [(_posX + _borderWidth), (_posY + _offsetY)];
			_ctrlBorder ctrlCommit 0.25;
			_ctrlText ctrlCommit 0.25;
			_offsetY = _offsetY + _margin + ((ctrlPosition _ctrlText) select 3);
			if (_activeNotifications > 4) then {
				_ctrlText ctrlSetFade 1;
				_ctrlText ctrlCommit 0.2;
				_ctrlBorder ctrlSetFade 1;
				_ctrlBorder ctrlCommit 0.2;
			};
		};
		_activeNotifications = _activeNotifications + 1;
	} forEach A3PL_Player_Notifications;
}] call Server_Setup_Compile;

["A3PL_Player_News",
{
	params [
		["_header","",[""]],
		["_line",[""]],
		["_sender","",[""]]
	];

	30 cutRsc ["FishersNews","plain"];
	_display = uiNamespace getVariable "FishersNews";
	_textHeader = _display displayCtrl 3001;
	_textHeader ctrlSetStructuredText parseText format ["<t size='2'>%1</t><br/>Broadcasted by: %2",_header,_sender];
	_textHeader ctrlCommit 0;

	_textLine = _display displayCtrl 3002;
	_textLine ctrlSetStructuredText parseText format ["                         %1                         %1                         %1                         %1                         %1                         %1                         %1",_line];
	_textLine ctrlCommit 0;
	_textLinePos = ctrlPosition _textLine;
	_textLinePos set [0,-100];
	_textLine ctrlSetPosition _textLinePos;
	_textLine ctrlCommit 1500;

	_textClock = _display displayctrl 3003;
	_textClock ctrlSetText ([daytime,"HH:MM"] call bis_fnc_timetostring);
	_textClock ctrlCommit 0;

	uiSleep 30;
	30 cutText ["","plain"];
}] call Server_Setup_Compile;

["A3PL_Player_CheckDebugVariables",{
	private _var = profileNamespace getVariable ["rscdebugconsole_expression",""];
	if(_var == "") exitWith {};
	profileNamespace setVariable ["rscdebugconsole_expression",""];
	[getPlayerUID player,"DebugVariablesSet",[str(_var)]] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_Player_SpawnMenu",{
	disableSerialization;
	private _spawnList = [];
	private _houseObj = player getVariable["house",objNull];
	private _warehouseObj = player getVariable["warehouse",objNull];
	private _isCG = (player getVariable["faction","citizen"]) isEqualTo "uscg";
	if(_isCG) then {_spawnList pushback ["CG Base",[2188.62,4991.78,0],0];};
	if(!isNull _houseObj) then {_spawnList pushback ["House",getPosATL _houseObj,1];};
	if(!isNull _warehouseObj) then {_spawnList pushback ["Warehouse",getPosATL _warehouseObj,2];};
	
	_spawnList pushback ["Silverton",[2445.83,5467.15,0],0];
	_spawnList pushback ["Lubbock",[2286.87,12015.3,0],0];
	_spawnList pushback ["Elk City",[6180.74,7365.69,0],0];
	_spawnList pushback	["Palm Beach",[3552.460,6664.702,0],0];

	createDialog "Dialog_SpawnMenu";

	private _display = findDisplay 130;
	noEscape = _display displayAddEventHandler ["KeyDown", "true;"];
	private _control = _display displayCtrl 1500;
	{
		_i = _control lbAdd (_x select 0);
		_control lbSetData[_i,str(_x select 1)];
		_control lbSetValue[_i,_x select 2];
	} forEach _spawnList;
	_control ctrlAddEventHandler ["LBSelChanged","call A3PL_Player_SelectSpawnMap;"];
	_control lbSetCurSel 0;
}] call Server_Setup_Compile;

["A3PL_Player_SelectSpawn",{
	disableSerialization;
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _display = findDisplay 130;
	private _control = _display displayCtrl 1500;
	if((lbCurSel 1500) isEqualTo -1) exitWith {};
	private _spawnPos = call compile (_control lbData (lbCurSel 1500));
	private _spawnType = _control lbValue (lbCurSel 1500);
	switch(_spawnType) do {
		case 0: {
			[player,_spawnPos] remoteExecCall ["Server_Housing_AssignApt",2];
			[player] remoteExecCall ["Server_Housing_SetPosApt",2];
		};
		case 1: {
			player setPosATL _spawnPos;
		};
		case 2: {
			player setPosATL _spawnPos;
		};
	};
	_display displayRemoveEventHandler ["KeyDown", noEscape];
	closeDialog 0;
	cutText["","BLACK IN"];
	player enableSimulation true;
}] call Server_Setup_Compile;

["A3PL_Player_SelectSpawnMap",{
	disableSerialization;
	private _display = findDisplay 130;
	private _listControl = _display displayCtrl 1500;
	private _spawnPos = call compile (_listControl lbData (lbCurSel 1500));
	private _mapControl = _display displayCtrl 1700;
	_mapControl ctrlMapAnimAdd [1, 0.03, _spawnPos];
	ctrlMapAnimCommit _mapControl;
}] call Server_Setup_Compile;