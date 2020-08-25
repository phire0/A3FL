//setup the loops that will run
['A3PL_Loop_Setup', {
	["itemAdd", ["Loop_LockView", {[] spawn A3PL_Loop_LockView;}, 1, 'seconds']] call BIS_fnc_loop;
	//["itemAdd", ["Loop_RoadSigns", {[] spawn A3PL_Loop_RoadSigns;}, 1, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Paycheck", {[] spawn A3PL_Loop_Paycheck;}, 60, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_PlayTime", {[] spawn A3PL_Loop_PlayTime;}, 1, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_HUD", {[] spawn A3PL_HUD_Loop;}, 1, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Hunger", {[] spawn A3PL_Loop_Hunger;}, 370, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Thirst", {[] spawn A3PL_Loop_Thirst;}, 350, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_NameTags", {[] spawn A3PL_Player_NameTags;}, 1, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_BusinessTags", {[] spawn A3PL_Player_BusinessTags;}, 5, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["A3PL_BowlingAmbient", {{_x say3D "BowlingAmbient"} foreach A3PL_BowlingAlleys}, 120]] call BIS_fnc_loop;
	["itemAdd", ["Loop_RoadworkerMarkers", {[] spawn A3PL_JobRoadWorker_MarkerLoop;}, 5, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Medical", {[] spawn A3PL_Medical_Loop;}, 5, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_GPS", {[] spawn A3PL_Police_GPS;}, 5, 'seconds']] call BIS_fnc_loop;
	//["itemAdd", ["Loop_HousingTaxes", {[] call A3PL_Loop_HousingTaxes;}, 1800, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Drugs", {[] call A3PL_Drugs_Loop;}, 10, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Alcohol", {[] call A3PL_Alcohol_Loop;}, 10, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_TaskForce", {[] spawn A3PL_Loop_TaskForce;}, 30, 'seconds']] call BIS_fnc_loop;

	//Events
	//["itemAdd", ["Hw_angel_loop", {[] spawn A3PL_Halloween_Randomiser;}, 30, 'seconds']] call BIS_fnc_loop;
	//["itemAdd", ["Cm_gift_loop", {[] spawn A3PL_Christmas_Randomiser;}, 900, 'seconds']] call BIS_fnc_loop;
}] call Server_Setup_Compile;

["A3PL_Loop_LockView",
{
	if(Player_LockView) then {
		if((cameraView == "EXTERNAL") && (vehicle player == player)) then {
			player switchCamera "INTERNAL";
		};
		if(Player_LockView_Time <= time) then {
			Player_LockView = false;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Loop_RoadSigns",
{
	disableSerialization;
	if(vehicle player != player) then {
		if(isNil "A3PL_Last_Road") then {A3PL_Last_Road = "";};
		if(isNil "A3PL_Last_RoadID") then {A3PL_Last_RoadID = 0;};

		_roadObject = str (roadAt (vehicle player));
		_roadID = parseNumber (( _roadObject splitString ":" ) select 0);

		if(A3PL_Last_RoadID != _roadID) then {
			A3PL_Last_RoadID = _roadID;
			_title = "";

			{
				_a = _x select 0;
				_b = _x select 1;

				if(_a < _b) then {
					if(_roadID >= _a && _roadID <= _b) exitWith {
						_title = _x select 2;
					};
				} else {
					if(_roadID >= _b && _roadID <= _a) exitWith {
						_title = _x select 2;
					};
				};
			} forEach roadDB;

			if(_title != "") then {
				if(_title != A3PL_Last_Road) then {
					A3PL_Last_Road = _title;
					[] spawn {
						disableSerialization;
						_road = A3PL_Last_Road;

						_display = uiNamespace getVariable "A3PL_HUDDisplay";
						_ctrl = _display displayCtrl 9520;
						_ctrlBack = _display displayCtrl 9521;

						_ctrl ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='center' size='3' >%1</t>",_road];
						_ctrl ctrlSetFade 0;
						_ctrl ctrlCommit 0.5;

						_ctrlBack ctrlSetFade 0;
						_ctrlBack ctrlCommit 0.5;

						uiSleep 3.5;

						if(_road != A3PL_Last_Road) exitWith {};

						_ctrl ctrlSetFade 1;
						_ctrl ctrlCommit 0.5;
						_ctrlBack ctrlSetFade 1;
						_ctrlBack ctrlCommit 0.5;
					};
				};
			};
		};
	};
}] call Server_Setup_Compile;

["A3PL_Loop_HousingTaxes",
{
	private ["_tAmount","_taxes","_bank","_house","_housePrice"];
	if(!isNil {player getVariable ["house",nil]}) then {
		_house = player getVariable ["house",objNull];
		_houseOwners = (_house getVariable ["owner",[]]) select 0;
		_housePrice = [_house] call A3PL_Housing_GetPrice;
		_tAmount = ["House Tax"] call A3PL_Config_GetTaxes;
		_taxes = floor(_housePrice*_tAmount);

		_taxes = floor(_taxes / (count _houseOwners));

		//Notify
		[format [localize"STR_NewLoop_1",_taxes,_tAmount*100,"%"],"yellow"] call A3PL_Player_Notification;
		//Withdraw money and send to gov
		_bank = player getVariable["Player_Bank",0];
		player setVariable["Player_Bank",_bank-_taxes,true];
		["House Tax",_taxes,"",format["House Tax %1",player getVariable["name","unknown"]]] remoteExec ["Server_Government_AddBalance",2];
	};
}] call Server_Setup_Compile;

//add paycheck money - players have to pick it up from the bank
["A3PL_Loop_Paycheck",
{
	private["_payAmount","_jobXP","_job","_factionJobs","_done","_inCompany"];
	Player_PayCheckTime = Player_PayCheckTime + 1;
	if (Player_PayCheckTime >= 20) then
	{
		_job = player getVariable ["job","unemployed"];
		_factionJobs = ["gov","uscg","fifr","fisd","doj","usms","dmv"];
		_payAmount = [_job,"pay"] call A3PL_Config_GetPaycheckInfo;
		_jobXP = [_job,"xp"] call A3PL_Config_GetPaycheckInfo;
		_done = false;

		// Factions
		if(_job IN _factionJobs) then {
			_done = true;
			_payAmount = [] call A3PL_Government_FactionPay;
		} else {
			_inCompany = [getPlayerUID player] call A3PL_Config_InCompany;
			if(_inCompany) then {
				_done = true;
				_payAmount = [] call A3PL_Company_Paycheck;
			};
		};		
		if(!_done) then {[format[localize"STR_NewLoop_6",_payAmount], "green"] call A3PL_Player_Notification;};			

		if(isNil "Player_Paycheck") then {Player_Paycheck = _payAmount;} else {Player_Paycheck = Player_Paycheck + _payAmount;};
		[player,_jobXP] call A3PL_Level_AddXP;
		[player, Player_Paycheck] remoteExec ["Server_Player_UpdatePaycheck",2];
		Player_PayCheckTime = 0;
		profileNameSpace setVariable ["Player_PayCheckTime",Player_PayCheckTime];
	};
}] call Server_Setup_Compile;

//add second to player's playtime every 1 second
["A3PL_Loop_PlayTime",
{
	Player_PlayTime = Player_PlayTime + 1;
}] call Server_Setup_Compile;

//reduce hunger every loop
["A3PL_Loop_Hunger",
{
	private ["_amount"];

	_amount = round(random(3));

	//Don't continue hunger if we're jailed.
	if(player getVariable ["jailed",false]) exitWith {};

	//popcorn eating
	if (player_ItemClass == "popcornbucket") exitwith
	{
		A3PL_EatingPopcorn = true;
		Player_Item attachTo [player,[0,0,0],"RightHand"];
		player playActionNow "gesture_eat";
		[] spawn
		{
			uisleep 4;
			A3PL_EatingPopcorn = Nil;
		};
	};

	Player_Hunger = Player_Hunger - _amount;

	if ((Player_Hunger >= 45) && (Player_Hunger <= 50) && (isNil "A3PL_HungerWarning1") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_HungerWarning1 = true;
		[localize"STR_NewLoop_7", "yellow"] call A3PL_Player_Notification;
	};

	if ((Player_Hunger >= 15) && (Player_Hunger <= 20) && (isNil "A3PL_HungerWarning2") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_HungerWarning2 = true;
		[localize"STR_NewLoop_8", "red"] call A3PL_Player_Notification;
	};

	if ((Player_Hunger >= 5) && (Player_Hunger <= 10) && (isNil "A3PL_HungerWarning3") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_HungerWarning3 = true;
		[localize"STR_NewLoop_9", "red"] call A3PL_Player_Notification;
	};

	[] call A3PL_Lib_VerifyHunger;
	profileNamespace setVariable ["player_hunger",Player_Hunger];

	if (Player_Hunger <= 0) then
	{
		private ["_effect"];
		profileNamespace setVariable ["player_hunger",Player_Hunger];
		A3PL_HungerWarning3 = Nil;
		A3PL_HungerWarning1 = Nil;

		if (!isNil "A3PL_HungerEmpty") exitwith {};
		[] spawn
		{
			A3PL_HungerEmpty = true;
			_effect = ["DynamicBlur",[2]] call A3PL_Lib_PPEffect;
			[localize"STR_NewLoop_10", "red"] call A3PL_Player_Notification;
			while {Player_Hunger <= 0} do
			{
				uiSleep 1;
				player setStamina 0;
			};
			A3PL_HungerEmpty = nil;
			_effect ppEffectEnable false;
			ppEffectDestroy _effect;
		};
	};
}] call Server_Setup_Compile;

//reduce thirst every loop
["A3PL_Loop_Thirst",
{
	private ["_amount"];
	_amount = round(random(4));

	if(player getVariable ["jailed",false]) exitWith {}; //if jailed don't continue

	Player_Thirst = Player_Thirst - _amount;
	[] call A3PL_Lib_VerifyThirst;

	if ((Player_Thirst >= 45) && (Player_Thirst <= 50) && (isNil "A3PL_ThirstWarning1") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_ThirstWarning1 = true;
		[localize"STR_NewLoop_11", "yellow"] call A3PL_Player_Notification;
	};

	if ((Player_Thirst >= 15) && (Player_Thirst <= 20) && (isNil "A3PL_ThirstWarning2") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_ThirstWarning2 = true;
		[localize"STR_NewLoop_12", "red"] call A3PL_Player_Notification;
	};

	if ((Player_Thirst >= 5) && (Player_Thirst <= 10) && (isNil "A3PL_ThirstWarning3") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_ThirstWarning3 = true;
		[localize"STR_NewLoop_13", "red"] call A3PL_Player_Notification;
	};

	if (Player_Thirst <= 0) then
	{
		private ["_effect"];
		profileNamespace setVariable ["player_thirst",Player_Thirst];
		A3PL_ThirstWarning3 = Nil;
		A3PL_ThirstWarning1 = Nil;

		if (!isNil "A3PL_ThirstEmpty") exitwith {};
		[] spawn
		{
			A3PL_ThirstEmpty = true;
			_effect = ["DynamicBlur",[2]] call A3PL_Lib_PPEffect;
			[localize"STR_NewLoop_14","red"] call A3PL_Player_Notification;
			while {Player_Thirst <= 0} do
			{
				uiSleep 1;
				player setStamina 0;
			};
			A3PL_ThirstEmpty = nil;
			_effect ppEffectEnable false;
			ppEffectDestroy _effect;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Loop_TaskForce",
{
	private ["_tsServer","_tsChannel"];
	_tsServer = [] call TFAR_fnc_getTeamSpeakServerName;
	_tsChannel = [] call TFAR_fnc_getTeamSpeakChannelName;

	if(_tsServer != "ArmA 3 Fishers Life - Official Teamspeak") then {
		a3pl_tf_wrongServer = true;
	} else {
		a3pl_tf_wrongServer = false;
		if(_tsChannel != "TaskForceRadio") then {
			a3pl_tf_wrongChannel = true;
		} else {
			a3pl_tf_wrongChannel = false;
		};
	};
}] call Server_Setup_Compile;
