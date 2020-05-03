/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//distance from center that oil can be found from
#define OILDISTANCE 100
//distance from center where a resource can be found
#define RESDISTANCE 100

["A3PL_JobWildCat_BuyMap",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_mapType","_markers","_oilArray","_resArray","_exactLocation","_pos","_timeLeft"];
	_mapType = param [0,""];
	_markers = [];

	//timer
	_timeLeft = missionNameSpace getVariable ["A3PL_JobWildcat_MapTimer",(diag_ticktime-2)];
	if (_timeLeft > diag_ticktime) exitwith {[format [localize"STR_A3PL_JobWildcat_MapCooldown",round(_timeLeft-diag_ticktime)],"red"] call A3PL_Player_Notification;};

	switch (true) do
	{
		case (_mapType == (localize"STR_Config_Resources_Oil")):
		{
			if ((player getVariable ["Player_cash",0]) < 1000) exitwith {[localize"STR_A3PL_JobWildcat_NotEnoughMoney","red"] call A3PL_Player_Notification;};
			player setVariable ["Player_cash",(player getVariable ["Player_Cash",0]) - 1000,true];

			_oilArray = missionNameSpace getVariable ["Server_JobWildCat_Oil",[]];
			_exactLocation = (_oilArray select (round (random ((count _oilArray) - 1)))) select 0;
			_pos = [((_exactLocation select 0) + (-50 + (random 100))),((_exactLocation select 1) + (-50 + (random 100)))];

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerSizeLocal [100,100];
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerAlphaLocal 0.5;
			_markers pushback _marker;

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerTypeLocal "A3PL_Markers_Oil";
			_marker setMarkerTextLocal format [localize"STR_A3PL_JobWildcat_OilArea"];
			_markers pushback _marker;
		};

		case (_mapType == (localize"STR_Config_Resources_Iron")):
		{
			if ((player getVariable ["player_cash",0]) < 500) exitwith {[localize"STR_A3PL_JobWildcat_NotEnoughMoney","red"] call A3PL_Player_Notification;};
			player setVariable ["player_cash",(player getVariable ["player_cash",0]) - 500,true];

			_resArray = missionNameSpace getVariable ["Server_JobWildCat_Res",[]];
			_newResArray = [];
			{
				if ((_x select 0) == _mapType) then {_newResArray pushback _x};
			} foreach _resArray;

			_exactLocation = (_newResArray select (round (random ((count _newResArray) - 1)))) select 1;
			_pos = [((_exactLocation select 0) + (-50 + random 100)),((_exactLocation select 1) + (-50 + random 100))];

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerSizeLocal [120,120];
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerAlphaLocal 0.5;
			_markers pushback _marker;

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerTypeLocal "A3PL_Markers_Pickaxe";
			_marker setMarkerTextLocal format [localize"STR_A3PL_JobWildcat_InThisArea",toUpper _mapType];
			_markers pushback _marker;
		};

		case (_mapType == (localize"STR_Config_Resources_Coal")):
		{
			if ((player getVariable ["player_cash",0]) < 500) exitwith {[localize"STR_A3PL_JobWildcat_NotEnoughMoney","red"] call A3PL_Player_Notification;};
			player setVariable ["player_cash",(player getVariable ["player_cash",0]) - 500,true];

			_resArray = missionNameSpace getVariable ["Server_JobWildCat_Res",[]];
			_newResArray = [];
			{
				if ((_x select 0) == _mapType) then {_newResArray pushback _x};
			} foreach _resArray;

			_exactLocation = (_newResArray select (round (random ((count _newResArray) - 1)))) select 1;
			_pos = [((_exactLocation select 0) + (-50 + random 100)),((_exactLocation select 1) + (-50 + random 100))];

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerSizeLocal [120,120];
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerAlphaLocal 0.5;
			_markers pushback _marker;

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerTypeLocal "A3PL_Markers_Pickaxe";
			_marker setMarkerTextLocal format [localize"STR_A3PL_JobWildcat_InThisArea",toUpper _mapType];
			_markers pushback _marker;
		};

		case (_mapType == (localize"STR_Config_Resources_Aluminium")):
		{
			if ((player getVariable ["player_cash",0]) < 500) exitwith {[localize"STR_A3PL_JobWildcat_NotEnoughMoney","red"] call A3PL_Player_Notification;};
			player setVariable ["player_cash",(player getVariable ["player_cash",0]) - 500,true];

			_resArray = missionNameSpace getVariable ["Server_JobWildCat_Res",[]];
			_newResArray = [];
			{
				if ((_x select 0) == _mapType) then {_newResArray pushback _x};
			} foreach _resArray;

			_exactLocation = (_newResArray select (round (random ((count _newResArray) - 1)))) select 1;
			_pos = [((_exactLocation select 0) + (-50 + random 100)),((_exactLocation select 1) + (-50 + random 100))];

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerSizeLocal [120,120];
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerAlphaLocal 0.5;
			_markers pushback _marker;

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerTypeLocal "A3PL_Markers_Pickaxe";
			_marker setMarkerTextLocal format [localize"STR_A3PL_JobWildcat_InThisArea",toUpper _mapType];
			_markers pushback _marker;
		};

		case (_mapType == (localize"STR_Config_Resources_Sulphur")):
		{
			if ((player getVariable ["player_cash",0]) < 500) exitwith {[localize"STR_A3PL_JobWildcat_NotEnoughMoney","red"] call A3PL_Player_Notification;};
			player setVariable ["player_cash",(player getVariable ["player_cash",0]) - 500,true];

			_resArray = missionNameSpace getVariable ["Server_JobWildCat_Res",[]];
			_newResArray = [];
			{
				if ((_x select 0) == _mapType) then {_newResArray pushback _x};
			} foreach _resArray;

			_exactLocation = (_newResArray select (round (random ((count _newResArray) - 1)))) select 1;
			_pos = [((_exactLocation select 0) + (-50 + random 100)),((_exactLocation select 1) + (-50 + random 100))];

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerSizeLocal [120,120];
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerAlphaLocal 0.5;
			_markers pushback _marker;

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerTypeLocal "A3PL_Markers_Pickaxe";
			_marker setMarkerTextLocal format [localize"STR_A3PL_JobWildcat_InThisArea",toUpper _mapType];
			_markers pushback _marker;
		};
	};

	if (count _markers == 0) exitwith {};
	missionNameSpace setVariable ["A3PL_JobWildcat_MapTimer",(diag_ticktime + 300)];
	[_markers] spawn
	{
		_markers = param [0,[]];
		uiSleep 900;
		{deleteMarkerLocal _x;} foreach _markers
	};

	[format [localize"STR_A3PL_JobWildcat_MapPurchasedInfo",_maptype],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//opens prospect menu
["A3PL_JobWildCat_ProspectOpen",
{
	disableSerialization;
	private ["_display","_control"];
	createDialog "Dialog_Prospect";
	_display = findDisplay 131;
	_control = _display displayCtrl 2100;

	//fill combo
	{
		_control lbAdd (_x select 0);
	} foreach Config_Resources_Ores;
	_control lbAdd localize"STR_Config_Resources_Oil";

	_prospectSave = profileNamespace getVariable ["A3PL_Mining_Prospect",0];
	_control lbSetCurSel _prospectSave;

	//set buttonaction
	_control = _display displayCtrl 1601;
	_control buttonSetAction
	"
			[(lbText [2100,(lbCurSel 2100)])] call A3PL_JobWildcat_ProspectInit;
			profileNamespace setVariable ['A3PL_Mining_Prospect',(lbCurSel 2100)];
			closeDialog 0;
	";
}] call Server_Setup_Compile;

//prospecting script
["A3PL_JobWildcat_ProspectInit",
{
	private ["_checkOil","_haveOil","_oilLocation","_oilAmount","_prospectFor"];
	_prospectFor = param [0,localize"STR_Config_Resources_Oil"];

	switch (_prospectFor) do
	{
		case (localize"STR_Config_Resources_Oil"):
		{
			//first check if we have an oil well
			_checkOil = [getpos player] call A3PL_JobWildcat_CheckForOil;
			_haveOil = _checkOil select 0;
			_oilLocation = _checkOil select 1;
			if (!_haveOil) exitwith {[0] spawn A3PL_JobWildCat_Prospect};

			_oilAmount = [_oilLocation] call A3PL_JobWildcat_CheckAmountOil;

			//these numbers correspondent with the gallons set up inside the array inside Server_JobWildcat_RandomizeOil
			switch true do
			{
				case (_oilAmount <= 50): {[1,localize"STR_Config_Resources_Oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 100): {[2,localize"STR_Config_Resources_Oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 150): {[3,localize"STR_Config_Resources_Oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 200): {[4,localize"STR_Config_Resources_Oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 600): {[5,localize"STR_Config_Resources_Oil"] spawn A3PL_JobWildCat_Prospect;};
				default {};
			};
		};

		//ores
		default
		{
			_checkOres = [getpos player,_prospectFor] call A3PL_JobWildcat_CheckForRes;
			_haveRes = _checkOres select 0;
			_resLocation = _checkOres select 1;
			if (!_haveRes) exitwith {[0,_prospectFor] spawn A3PL_JobWildCat_Prospect;};
			_resAmount = [_resLocation] call A3PL_JobWildcat_CheckAmountRes;
			switch (true) do
			{
				case (_resAmount <= 3): {[1,_prospectFor] spawn A3PL_JobWildCat_Prospect;};
				case (_resAmount <= 5): {[2,_prospectFor] spawn A3PL_JobWildCat_Prospect;};
				case (_resAmount <= 30): {[3,_prospectFor] spawn A3PL_JobWildCat_Prospect;};
				default {[3,_prospectFor] spawn A3PL_JobWildCat_Prospect;};
			};
		};
	};
}] call Server_Setup_Compile;

["A3PL_JobWildCat_Prospect",
{
	private ["_signs","_prospectArray","_listOres","_prospectFor","_canProspect"];
	_signs = param [0,0];
	_prospectFor = param [1,localize"STR_Config_Resources_Oil"];

	if ((animationState player) == "acts_terminalopen") exitwith {[localize"STR_A3PL_JobWildcat_AlreadyProspecting","red"] call A3PL_Player_Notification;};
	if (!isNil "Player_Prospecting") exitwith {[localize"STR_A3PL_JobWildcat_Expired","red"] call A3PL_Player_Notification;};

	[player,"Acts_TerminalOpen"] remoteExec ["A3PL_Lib_SyncAnim",0];
	[localize"STR_A3PL_JobWildcat_CantMove", "yellow"] call A3PL_Player_Notification;
	Player_Prospecting = true;
	switch (_prospectFor) do
	{
		case (localize"STR_Config_Resources_Oil"):
		{
			switch (_signs) do
			{
				case 0:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_NoOilInArea","red"],
						[localize"STR_A3PL_JobWildcat_OilSample","red"],
						[localize"STR_A3PL_JobWildcat_CantFindOil1","red"],
						[localize"STR_A3PL_JobWildcat_CantFindOil","red"],
						[localize"STR_A3PL_JobWildcat_CantFindOil2","red"]
					];
				};
				case 1:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_NoOilInArea","red"],
						[localize"STR_A3PL_JobWildcat_OilSample","red"],
						[localize"STR_A3PL_JobWildcat_ThereIsOil","green"],
						[localize"STR_A3PL_JobWildcat_CantFindOil","red"],
						[localize"STR_A3PL_JobWildcat_CantFindOil2","red"]
					];
				};

				case 2:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_NoOilInArea","red"],
						[localize"STR_A3PL_JobWildcat_OilSample","red"],
						[localize"STR_A3PL_JobWildcat_ThereIsOil","green"],
						[localize"STR_A3PL_JobWildcat_FoundOil","green"],
						[localize"STR_A3PL_JobWildcat_MagneticStuff","red"]
					];
				};
				case 3:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_NoOilInArea","red"],
						[localize"STR_A3PL_JobWildcat_OilSample","red"],
						[localize"STR_A3PL_JobWildcat_ThereIsOil","green"],
						[localize"STR_A3PL_JobWildcat_FoundOil","green"],
						[localize"STR_A3PL_JobWildcat_NotMagnetic","green"]
					];
				};

				case 4:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_NoOilInArea","red"],
						[localize"STR_A3PL_JobWildcat_FoundOil1","green"],
						[localize"STR_A3PL_JobWildcat_ThereIsOil","green"],
						[localize"STR_A3PL_JobWildcat_FoundOil","green"],
						[localize"STR_A3PL_JobWildcat_MagneticStuff1","green"]
					];
				};

				case 5:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_FoundOil2","green"],
						[localize"STR_A3PL_JobWildcat_FoundOil3","green"],
						[localize"STR_A3PL_JobWildcat_ThereIsOil","green"],
						[localize"STR_A3PL_JobWildcat_FoundOil","green"],
						[localize"STR_A3PL_JobWildcat_NotMagnetic","green"]
					];
				};
			};
		};

		case (localize"STR_Config_Resources_Iron"):
		{
			switch (_signs) do
			{
				case 0:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_CantFindIron","red"],
						[localize"STR_A3PL_JobWildcat_NoMineral","red"],
						[localize"STR_A3PL_JobWildcat_NoOre","red"]
					];
				};
				case 1:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_CantFindIron","red"],
						[localize"STR_A3PL_JobWildcat_NoMineral","red"],
						[localize"STR_A3PL_JobWildcat_MightBeIron","green"]
					];
				};

				case 2:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_CantFindIron","red"],
						[localize"STR_A3PL_JobWildcat_ContainMineral","green"],
						[localize"STR_A3PL_JobWildcat_MightBeIron","green"]
					];
				};
				case 3:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_MightBeIron1","green"],
						[localize"STR_A3PL_JobWildcat_ContainMineral","green"],
						[localize"STR_A3PL_JobWildcat_MightBeIron","green"]
					];
				};
			};
		};

		case (localize"STR_Config_Resources_Coal"):
		{
			switch (_signs) do
			{
				case 0:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_NoCoal","red"],
						[localize"STR_A3PL_JobWildcat_NoCoalAsh","red"],
						[localize"STR_A3PL_JobWildcat_NoCoal1","red"]
					];
				};
				case 1:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_NoCoal","red"],
						[localize"STR_A3PL_JobWildcat_ContainAsh","green"],
						[localize"STR_A3PL_JobWildcat_NoCoal1","red"]
					];
				};

				case 2:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_ThereIsCoalResides","green"],
						[localize"STR_A3PL_JobWildcat_ContainAsh","green"],
						[localize"STR_A3PL_JobWildcat_NoCoal1","red"]
					];
				};
				case 3:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_ThereIsCoalResides","green"],
						[localize"STR_A3PL_JobWildcat_ContainAsh1","green"],
						[localize"STR_A3PL_JobWildcat_ThereIsCoalSound","green"]
					];
				};
			};
		};

		case (localize"STR_Config_Resources_Titanium"):
		{
			switch (_signs) do
			{
				case 0:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_NoTitanium","red"],
						[localize"STR_A3PL_JobWildcat_NoTitaniumSoil","red"],
						[localize"STR_A3PL_JobWildcat_NoTitaniumSound","red"]
					];
				};
				case 1:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_NoTitanium","red"],
						[localize"STR_A3PL_JobWildcat_NoTitaniumSoil","red"],
						[localize"STR_A3PL_JobWildcat_ThereIsTitaniumSound","green"]
					];
				};

				case 2:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_NoTitanium","red"],
						[localize"STR_A3PL_JobWildcat_ThereIsTitaniumSoil","green"],
						[localize"STR_A3PL_JobWildcat_ThereIsTitaniumSound","green"]
					];
				};
				case 3:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_ThereIsTitaniumResude","green"],
						[localize"STR_A3PL_JobWildcat_ThereIsTitaniumSoil","green"],
						[localize"STR_A3PL_JobWildcat_ThereIsTitaniumSound","green"]
					];
				};
			};
		};

		case (localize"STR_Config_Resources_Aluminium"):
		{
			switch (_signs) do
			{
				case 0:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_NoAluminium","red"],
						[localize"STR_A3PL_JobWildcat_ThereIsNoAluminiumSoil","red"],
						[localize"STR_A3PL_JobWildcat_ThereIsNoAluminiumSound","red"]
					];
				};
				case 1:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_ThereIsAluminium","green"],
						[localize"STR_A3PL_JobWildcat_ThereIsNoAluminiumSoil","red"],
						[localize"STR_A3PL_JobWildcat_ThereIsNoAluminiumSound","red"]
					];
				};

				case 2:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_ThereIsAluminium","green"],
						[localize"STR_A3PL_JobWildcat_ThereIsAluminiumMinerals","green"],
						[localize"STR_A3PL_JobWildcat_ThereIsNoAluminiumSound","red"]
					];
				};
				case 3:
				{
					_prospectArray =
					[
						[localize"STR_A3PL_JobWildcat_ThereIsAluminium","green"],
						[localize"STR_A3PL_JobWildcat_ThereIsAluminiumMinerals1","green"],
						[localize"STR_A3PL_JobWildcat_ThereIsAluminiumSound","green"]
					];
				};
			};
		};

        case (localize"STR_Config_Resources_Sulphur"):
        {
            switch (_signs) do
            {
                case 0:
                {
                    _prospectArray =
                    [
                        [localize"STR_A3PL_JobWildcat_NoSulfur","red"],
                        [localize"STR_A3PL_JobWildcat_NoSulfurSoil","red"],
                        [localize"STR_A3PL_JobWildcat_NoSulfurSound","red"]
                    ];
                };
                case 1:
                {
                    _prospectArray =
                    [
                        [localize"STR_A3PL_JobWildcat_NoSulfur","red"],
                        [localize"STR_A3PL_JobWildcat_ThereIsSulfurSoil","green"],
                        [localize"STR_A3PL_JobWildcat_NoSulfurSound","red"]
                    ];
                };

                case 2:
                {
                    _prospectArray =
                    [
                        [localize"STR_A3PL_JobWildcat_ThereIsSulfur","green"],
                        [localize"STR_A3PL_JobWildcat_ThereIsSulfurSoil","green"],
                        [localize"STR_A3PL_JobWildcat_NoSulfurSound","red"]
                    ];
                };
                case 3:
                {
                    _prospectArray =
                    [
                        [localize"STR_A3PL_JobWildcat_ThereIsSulfur","green"],
                        [localize"STR_A3PL_JobWildcat_ThereIsSulfurSoil","green"],
                        [localize"STR_A3PL_JobWildcat_ThereIsSulfurSound","green"]
                    ];
                    [player, 1] call A3PL_Level_AddXP;
                };
            };
        };
	};

	_canProspect = 0;
	for "_i" from 0 to (count _prospectArray) do
	{
		uiSleep 3.7;
		(_prospectArray select _i) call A3PL_Player_Notification;
		if (!(vehicle player == player)) exitwith {_canProspect = (count _prospectArray) - _i;};
	};
	if (_canProspect > 0) exitwith {_timeOut = _canProspect * 3.7; [format [localize"STR_A3PL_JobWildcat_CantProspectInVehicle",_timeOut],"red"] call A3PL_Player_Notification; [_timeOut] spawn {uiSleep (param [0,0]); Player_Prospecting = nil;};};
	Player_Prospecting = nil;
	[localize"STR_A3PL_JobWildcat_ProspectingFinished","green"] call A3PL_Player_Notification;
	[player,""] remoteExec ["A3PL_Lib_SyncAnim",0];

	_listOres = [];
	{
		_listOres pushback (_x select 0);
	} foreach Config_Resources_Ores;

	if ((_signs > 0) && (_prospectFor IN _listOres)) then
	{
		[_prospectFor] call A3PL_JobWildCat_FoundRes;
		[player, 1] call A3PL_Level_AddXP;
	};
}] call Server_Setup_Compile;

["A3PL_JobWildCat_FoundRes",
{
	disableSerialization;
	private ["_display","_control","_foundOre"];
	_foundOre = param [0,""];
	createDialog "Dialog_ProspectFound";
	_display = findDisplay 132;
	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format [localize"STR_A3PL_JobWildcat_FoundMarkQuestion",_foundOre];

	_control = _display displayCtrl 1601;
	_control buttonSetAction format ["closeDialog 0; [player,'%1'] remoteExec ['Server_JobWildCat_SpawnRes', 2];",_foundOre];
}] call Server_Setup_Compile;

//this checks if we have oil in the area and returns the location of the middle pointer
["A3PL_JobWildcat_CheckForOil",
{
	private ["_pos","_oil","_oilLocation"];
	_pos = param [0,[0,0,0]];

	_oil = false;
	//change 50 into lower/higher distance if needed
	{
		 if ((_pos distance (_x select 0)) < OILDISTANCE) exitwith
		 {
			 _oil = true;
			 _oilLocation = _x select 0;
		 };
	} foreach Server_JobWildCat_Oil;

	_return = [false,[0,0,0]];
	if (_oil) then
	{
		_return = [true,_oilLocation];
	};

	_return;
}] call Server_Setup_Compile;

["A3PL_JobWildcat_CheckForRes",
{
	private ["_pos","_res","_return","_resType","_resLocation"];
	_pos = param [0,[0,0,0]];
	_resType = param [1,""];

	_res = false;
	//change 50 into lower/higher distance if needed
	{
		 if (((_pos distance (_x select 1)) < RESDISTANCE) && ((_x select 0) == _resType)) exitwith
		 {
			 _res = true;
			 _resLocation = _x select 1;
		 };
	} foreach Server_JobWildCat_Res;

	_return = [false,[0,0,0]];
	if (_res) then
	{
		_return = [true,_resLocation];
	};

	_return;
}] call Server_Setup_Compile;

//this will return the amount of oil in the specified oil position
["A3PL_JobWildcat_CheckAmountOil",
{
	private ["_pos","_return"];
	_pos = param [0,[0,0,0]];
	_return = 0;

	{
		 if (((_x select 0) distance2D _pos) < 1) exitwith
		 {
			 _return = _x select 1;
		 };
	} foreach Server_JobWildCat_Oil;

	_return;
}] call Server_Setup_Compile;

["A3PL_JobWildcat_CheckAmountRes",
{
	private ["_pos","_return"];
	_pos = param [0,[0,0,0]];
	_return = 0;

	{
		 if (((_x select 1) distance2D _pos) < 1) exitwith
		 {
			 _return = _x select 2;
		 };
	} foreach Server_JobWildCat_Res;

	_return;
}] call Server_Setup_Compile;

//drilling script
["A3PL_JobWildcat_Drill",
{
	private ["_s","_pump","_drilling","_a"];
	_pump = param [0,objNull];

	//check the pin position
	if ((_pump animationPhase "Pin") > 0) exitwith
	{
		[localize"STR_A3PL_JobWildcat_CantDrillVehHitched","red"] call A3PL_Player_Notification;
	};

	//first check the drill_arm_position
	if ((_pump animationSourcePhase "drill_arm_position") != 1) exitwith {[localize"STR_A3PL_JobWildcat_DrillArmNotExtended","red"] call A3PL_Player_Notification;};

	//check if the drill is already extending
	_a = _pump animationSourcePhase "drill";
	uisleep 0.2;
	if (_a != _pump animationSourcePhase "drill") exitwith {[localize"STR_A3PL_JobWildcat_DrillIsMoving","red"] call A3PL_Player_Notification;};

	//Secondly lets check if the drill is already extended
	if (_pump animationSourcePhase "drill" > 0) exitwith {_pump animateSource ["drill",0]; [localize"STR_A3PL_JobWildcat_Retracting","red"] call A3PL_Player_Notification;};

	//lets start drilling
	[localize"STR_A3PL_JobWildcat_DrillingStarted","green"] call A3PL_Player_Notification;
	_drilling = true;
	_pump animateSource ["drill",1];
	_s = false; //succeed
	_pos = getpos _pump;
	while {_drilling} do
	{
		if ((_pos distance (getpos _pump)) > 1) exitwith {_pump animateSource ["drill",0,true]; [localize"STR_A3PL_JobWildcat_Returning","red"] call A3PL_Player_Notification;};
		if (_pump animationSourcePhase "drill" == 1) exitwith {_s = true};
		if (isNull _pump) exitwith {};
		uiSleep 1;
	};

	if (_s) then
	{
		[localize"STR_A3PL_JobWildcat_JackCanBeInstalled","green"] call A3PL_Player_Notification;
		//spawn a drilling hole at specified modelToWorld position
		_hole = createVehicle ["A3PL_Drillhole",_pump modelToWorld [0,-1.8,-1.1], [], 0, "CAN_COLLIDE"]; //[0,-1.1,0]
	} else
	{
		[localize"STR_A3PL_JobWildcat_Canceled","red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;
