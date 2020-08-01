/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['A3PL_Loop_Setup', {
	["itemAdd", ["Loop_LockView", {[] spawn A3PL_Loop_LockView;}, 1, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_RoadSigns", {[] spawn A3PL_Loop_RoadSigns;}, 3, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Paycheck", {[] spawn A3PL_Loop_Paycheck;}, 60, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_HUD", {[] spawn A3PL_HUD_Loop;}, 2, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Hunger", {[] spawn A3PL_Loop_Hunger;}, 310, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Thirst", {[] spawn A3PL_Loop_Thirst;}, 290, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_NameTags", {[] spawn A3PL_Player_NameTags;}, 1, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_BusinessTags", {[] spawn A3PL_Player_BusinessTags;}, 5, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_RoadworkerMarkers", {[] spawn A3PL_JobRoadWorker_MarkerLoop;}, 15, 'seconds'],{ player getVariable ["job","unemployed"] == "Roadside" }, { player getVariable ["job","unemployed"] != "Roadside" }] call BIS_fnc_loop;
	["itemAdd", ["Loop_Medical", {[] spawn A3PL_Medical_Loop;}, 1, 'seconds',{ !((player getVariable ["A3PL_Wounds",[]]) isEqualTo []) || (player getVariable ["bloodOverlay",false]) },{ ((player getVariable ["A3PL_Wounds",[]]) isEqualTo []) && !(player getVariable ["bloodOverlay",false]) }]] call BIS_fnc_loop;
	["itemAdd", ["Loop_GPS", {[] spawn A3PL_Police_GPS;}, 5, 'seconds',{ player getVariable ["job","unemployed"] IN ["fisd","fifr","usms","uscg"] }, { !(player getVariable ["job","unemployed"] IN ["fisd","fifr","usms","uscg"]) && isNil "A3PL_Police_GPSmarkers" }]] call BIS_fnc_loop;
	["itemAdd", ["Loop_Drugs", {[] spawn A3PL_Drugs_Loop;}, 30, 'seconds',{ player getVariable ["drugs",false] },{ !(player getVariable["drugs",false]) }]] call BIS_fnc_loop;
	["itemAdd", ["Loop_Alcohol", {[] spawn A3PL_Alcohol_Loop;}, 30, 'seconds',{ player getVariable ["alcohol",false] },{ !(player getVariable["alcohol",false]) }]] call BIS_fnc_loop;
	["itemAdd", ["Loop_JailMarkers", {[] spawn A3PL_Prison_Markers;}, 30, 'seconds',{ player getVariable ["job","unemployed"] IN ["usms"] },{ !(player getVariable ["job","unemployed"] IN ["usms"]) }]] call BIS_fnc_loop;
	["itemAdd", ["drowningSystem", {[] spawn A3PL_Loop_Drowning;}, 1, "seconds", {(underwater player) && !(isAbleToBreathe player)}, {!(underwater player) || (isAbleToBreathe player)}]] call BIS_fnc_loop;
	["itemAdd", ["Loop_HousingTaxes", {[] call A3PL_Loop_HousingTaxes;}, 1800, 'seconds',{!isNil {player getVariable ["house",nil]}}, {isNil {player getVariable ["house",nil]}}]] call BIS_fnc_loop;
	["itemAdd", ["Loop_WarehouseTaxes", {[] call A3PL_Loop_WarehouseTaxes;}, 1800, 'seconds',{!isNil {player getVariable ["warehouse",nil]}}, {isNil {player getVariable ["warehouse",nil]}}]] call BIS_fnc_loop;

	//Events
	//["itemAdd", ["Hw_angel_loop", {[] spawn A3PL_Halloween_Randomiser;}, 30, 'seconds']] call BIS_fnc_loop;
}] call Server_Setup_Compile;

["A3PL_Loop_LockView",
{
	if(Player_LockView) then {
		if((cameraView == "EXTERNAL") && (vehicle player == player)) then {player switchCamera "INTERNAL";};
		if(Player_LockView_Time <= time) then {Player_LockView = false;};
	};
}] call Server_Setup_Compile;

['A3PL_Loop_Drowning',{
    private _oxygen = getOxygenRemaining player;
    private _safeLimit = 0.2;
    if(_oxygen < _safeLimit) then {
        player setOxygenRemaining _safeLimit;
        if(player getVariable ["A3PL_Medical_Alive",true]) then {
            [player,"chest","breathing"] call A3PL_Medical_ApplyWound;
            [] spawn A3PL_Medical_Die;
        };
    };
}] call Server_Setup_Compile;

["A3PL_Loop_RoadSigns",
{
	disableSerialization;
	if(isNil "A3PL_Last_Road") then {A3PL_Last_Road = "";};
	if(isNil "A3PL_Last_RoadID") then {A3PL_Last_RoadID = 0;};

	private _roadObject = str(roadAt(vehicle player));
	private _roadID = parseNumber((_roadObject splitString ":") select 0);

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
		} forEach Server_Addresses_Roads;
		if(_title != "") then {
			if(_title != A3PL_Last_Road) then {
				A3PL_Last_Road = _title;
				[] spawn {
					disableSerialization;
					_road = A3PL_Last_Road;

					_display = uiNamespace getVariable ["A3PL_HUDDisplay",nil];
					if(isNil "_display") exitWith {};
					_ctrl = _display displayCtrl 9520;
					_ctrlBack = _display displayCtrl 9521;

					_ctrl ctrlSetStructuredText parseText format ["<t font='PuristaMedium' align='center' size='2' >%1</t>",_road];
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
}] call Server_Setup_Compile;

["A3PL_Loop_HousingTaxes",
{
	if(isNil {player getVariable ["house",nil]}) exitWith {};
	private _house = player getVariable ["house",nil];
	private _taxPrice = [_house,2] call A3PL_Housing_GetData;
	private _bank = player getVariable["Player_Bank",0];
	player setVariable["Player_Bank",_bank-_taxPrice,true];
	["Federal Reserve",_taxPrice] remoteExec ["Server_Government_AddBalance",2];
	[format [localize"STR_NewLoop_1",_taxPrice],"yellow"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Loop_WarehouseTaxes",
{
	if(isNil {player getVariable ["warehouse",nil]}) exitWith {};
	private _warehouse = player getVariable ["warehouse",nil];
	private _taxPrice = [_warehouse,2] call A3PL_Warehouses_GetData;
	private _bank = player getVariable["Player_Bank",0];
	player setVariable["Player_Bank",_bank-_taxPrice,true];
	["Federal Reserve",_taxPrice] remoteExec ["Server_Government_AddBalance",2];
	[format [localize"STR_NewLoop_1_2",_taxPrice],"yellow"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Loop_Paycheck",
{
	if(!(player getVariable["A3PL_Medical_Alive",true])) exitWith {};
	Player_PayCheckTime = Player_PayCheckTime + 1;
	if (Player_PayCheckTime >= 20) then
	{
		private _job = player getVariable ["job","unemployed"];
		private _factionJobs = ["uscg","fifr","fisd","doj","usms"];
		private _payAmount = [_job,"pay"] call A3PL_Config_GetPaycheckInfo;
		private _jobXP = [_job,"xp"] call A3PL_Config_GetPaycheckInfo;
		private _done = false;

		call A3PL_Gang_CapturedPaycheck;

		if(_job IN _factionJobs) then {
			_done = true;
			_payAmount = call A3PL_Government_FactionPay;
		} else {
			private _inCompany = [getPlayerUID player] call A3PL_Config_InCompany;
			if(_inCompany && (_job isEqualTo "unemployed")) then {
				_done = true;
				_payAmount = call A3PL_Company_Paycheck;
			};
		};
		_payAmount = _payAmount * A3PL_Event_Paycheck;
		if(!_done) then {[format[localize"STR_NewLoop_6",_payAmount], "green"] call A3PL_Player_Notification;};

		if(isNil "Player_Paycheck") then {Player_Paycheck = _payAmount;} else {Player_Paycheck = Player_Paycheck + _payAmount;};
		[player,_jobXP] call A3PL_Level_AddXP;
		[player, Player_Paycheck] remoteExec ["Server_Player_UpdatePaycheck",2];
		Player_PayCheckTime = 0;
	};
}] call Server_Setup_Compile;

["A3PL_Loop_Hunger",
{
	private _amount = round(random(3));
	if(player getVariable ["pVar_RedNameOn",false]) exitWith {};
	if(player getVariable ["jailed",false]) exitWith {};

	Player_Hunger = Player_Hunger - _amount;
	if ((Player_Hunger >= 45) && (Player_Hunger <= 50) && (isNil "A3PL_HungerWarning1") && (!(player getVariable ["Incapacitated",false]))) then {
		A3PL_HungerWarning1 = true;
		[localize"STR_NewLoop_7", "yellow"] call A3PL_Player_Notification;
	};

	if ((Player_Hunger >= 15) && (Player_Hunger <= 20) && (isNil "A3PL_HungerWarning2") && (!(player getVariable ["Incapacitated",false]))) then {
		A3PL_HungerWarning2 = true;
		[localize"STR_NewLoop_8", "red"] call A3PL_Player_Notification;
	};

	if ((Player_Hunger >= 5) && (Player_Hunger <= 10) && (isNil "A3PL_HungerWarning3") && (!(player getVariable ["Incapacitated",false]))) then {
		A3PL_HungerWarning3 = true;
		[localize"STR_NewLoop_9", "red"] call A3PL_Player_Notification;
	};

	call A3PL_Lib_VerifyHunger;
	profileNamespace setVariable ["player_hunger",Player_Hunger];

	if (Player_Hunger <= 0) then {
		private ["_effect"];
		profileNamespace setVariable ["player_hunger",Player_Hunger];
		A3PL_HungerWarning3 = Nil;
		A3PL_HungerWarning1 = Nil;

		if (!isNil "A3PL_HungerEmpty") exitwith {};
		[] spawn {
			A3PL_HungerEmpty = true;
			_effect = ["DynamicBlur",[2]] call A3PL_Lib_PPEffect;
			[localize"STR_NewLoop_10", "red"] call A3PL_Player_Notification;
			while {Player_Hunger <= 0} do {
				uiSleep 1;
				player setStamina 0;
			};
			A3PL_HungerEmpty = nil;
			_effect ppEffectEnable false;
			ppEffectDestroy _effect;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Loop_Thirst",
{
	private _amount = round(random(4));
	if(player getVariable ["pVar_RedNameOn",false]) exitWith {};
	if(player getVariable ["jailed",false]) exitWith {};

	Player_Thirst = Player_Thirst - _amount;
	call A3PL_Lib_VerifyThirst;

	if ((Player_Thirst >= 45) && (Player_Thirst <= 50) && (isNil "A3PL_ThirstWarning1") && (!(player getVariable ["Incapacitated",false]))) then {
		A3PL_ThirstWarning1 = true;
		[localize"STR_NewLoop_11", "yellow"] call A3PL_Player_Notification;
	};

	if ((Player_Thirst >= 15) && (Player_Thirst <= 20) && (isNil "A3PL_ThirstWarning2") && (!(player getVariable ["Incapacitated",false]))) then {
		A3PL_ThirstWarning2 = true;
		[localize"STR_NewLoop_12", "red"] call A3PL_Player_Notification;
	};

	if ((Player_Thirst >= 5) && (Player_Thirst <= 10) && (isNil "A3PL_ThirstWarning3") && (!(player getVariable ["Incapacitated",false]))) then {
		A3PL_ThirstWarning3 = true;
		[localize"STR_NewLoop_13", "red"] call A3PL_Player_Notification;
	};

	if (Player_Thirst <= 0) then {
		private ["_effect"];
		profileNamespace setVariable ["player_thirst",Player_Thirst];
		A3PL_ThirstWarning3 = Nil;
		A3PL_ThirstWarning1 = Nil;

		if (!isNil "A3PL_ThirstEmpty") exitwith {};
		[] spawn {
			A3PL_ThirstEmpty = true;
			_effect = ["DynamicBlur",[2]] call A3PL_Lib_PPEffect;
			[localize"STR_NewLoop_14","red"] call A3PL_Player_Notification;
			while {Player_Thirst <= 0} do {
				uiSleep 1;
				player setStamina 0;
			};
			A3PL_ThirstEmpty = nil;
			_effect ppEffectEnable false;
			ppEffectDestroy _effect;
		};
	};
}] call Server_Setup_Compile;
