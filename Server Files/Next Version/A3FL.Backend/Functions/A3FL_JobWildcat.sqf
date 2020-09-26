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
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_mapType","_markers","_oilArray","_resArray","_exactLocation","_pos","_timeLeft"];
	_mapType = param [0,""];
	_markers = [];

	_timeLeft = missionNameSpace getVariable ["A3PL_JobWildcat_MapTimer",(diag_ticktime-2)];
	if (_timeLeft > diag_ticktime) exitwith {[format [localize"STR_A3PL_JobWildcat_MapCooldown",round(_timeLeft-diag_ticktime)],"red"] call A3PL_Player_Notification;};

	switch (_mapType) do
	{
		case (localize"STR_Config_Resources_Oil"):
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
		default {
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

	if ((count _markers) isEqualTo 0) exitwith {};
	missionNameSpace setVariable ["A3PL_JobWildcat_MapTimer",(diag_ticktime + 300)];
	[_markers] spawn {
		private _markers = param [0,[]];
		sleep 900;
		{deleteMarkerLocal _x;} foreach _markers
	};
	[format [localize"STR_A3PL_JobWildcat_MapPurchasedInfo",_maptype],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_JobWildCat_ProspectOpen",
{
	disableSerialization;
	createDialog "Dialog_Prospect";
	private _display = findDisplay 131;
	private _control = _display displayCtrl 2100;

	{
		_control lbAdd (_x select 0);
	} foreach Config_Resources_Ores;
	_control lbAdd localize"STR_Config_Resources_Oil";

	private _prospectSave = profileNamespace getVariable ["A3PL_Mining_Prospect",0];
	_control lbSetCurSel _prospectSave;

	_control = _display displayCtrl 1601;
	_control buttonSetAction
	"
		[(lbText [2100,(lbCurSel 2100)])] call A3PL_JobWildcat_ProspectInit;
		profileNamespace setVariable ['A3PL_Mining_Prospect',(lbCurSel 2100)];
		closeDialog 0;
	";
}] call Server_Setup_Compile;

["A3PL_JobWildcat_ProspectInit",
{
	private ["_checkOil","_haveOil","_oilLocation","_oilAmount","_prospectFor"];
	_prospectFor = param [0,localize"STR_Config_Resources_Oil"];

	switch (_prospectFor) do {
		case (localize"STR_Config_Resources_Oil"):
		{
			_checkOil = [getpos player] call A3PL_JobWildcat_CheckForOil;
			_haveOil = _checkOil select 0;
			_oilLocation = _checkOil select 1;
			if (!_haveOil) exitwith {[0] spawn A3PL_JobWildCat_Prospect};
			_oilAmount = [_oilLocation] call A3PL_JobWildcat_CheckAmountOil;
			switch true do {
				case (_oilAmount <= 50): {[1,localize"STR_Config_Resources_Oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 100): {[2,localize"STR_Config_Resources_Oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 150): {[3,localize"STR_Config_Resources_Oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 200): {[4,localize"STR_Config_Resources_Oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 600): {[5,localize"STR_Config_Resources_Oil"] spawn A3PL_JobWildCat_Prospect;};
				default {[5,localize"STR_Config_Resources_Oil"] spawn A3PL_JobWildCat_Prospect;};
			};
		};
		default {
			_checkOres = [getpos player,_prospectFor] call A3PL_JobWildcat_CheckForRes;
			_haveRes = _checkOres select 0;
			_resLocation = _checkOres select 1;
			if (!_haveRes) exitwith {[0,_prospectFor] spawn A3PL_JobWildCat_Prospect;};
			_resAmount = [_resLocation] call A3PL_JobWildcat_CheckAmountRes;
			switch (true) do {
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
	private _signs = param [0,0];
	private _prospectFor = param [1,localize"STR_Config_Resources_Oil"];

	if (Player_ActionDoing) exitwith {[localize"STR_A3PL_JobWildcat_AlreadyProspecting","red"] call A3PL_Player_Notification;};

	["Prospecting...",5] spawn A3PL_Lib_LoadAction;
	_success = true;
	waitUntil{Player_ActionDoing};
	[player,"Acts_TerminalOpen"] remoteExec ["A3PL_Lib_SyncAnim",0];
	while {Player_ActionDoing} do {
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if ((vehicle player) != player) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
	};
	if(Player_ActionInterrupted || !_success) exitWith {["Action cancelled.","red"] call A3PL_Player_Notification;};

	[player,""] remoteExec ["A3PL_Lib_SyncAnim",0];

	_listOres = [];
	{
		_listOres pushback (_x select 0);
	} foreach Config_Resources_Ores;

	if ((_signs > 0) && (_prospectFor IN _listOres)) then {
		[player,_prospectFor] remoteExec ['Server_JobWildCat_SpawnRes', 2];
	} else {
		[format["There is no %1 in this area",_prospectFor],"red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

//this checks if we have oil in the area and returns the location of the middle pointer
["A3PL_JobWildcat_CheckForOil",
{
	private ["_pos","_oil","_oilLocation"];
	_pos = param [0,[0,0,0]];
	_oil = false;
	{
		if ((_pos distance (_x select 0)) < OILDISTANCE) exitwith {
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
	{
		 if (((_pos distance (_x select 1)) < RESDISTANCE) && ((_x select 0) == _resType)) exitwith
		 {
			 _res = true;
			 _resLocation = _x select 1;
		 };
	} foreach Server_JobWildCat_Res;

	_return = [false,[0,0,0]];
	if (_res) then {
		_return = [true,_resLocation];
	};
	_return;
}] call Server_Setup_Compile;

["A3PL_JobWildcat_CheckAmountOil",
{
	private ["_pos","_return"];
	_pos = param [0,[0,0,0]];
	_return = 0;
	{
		if (((_x select 0) distance2D _pos) < 1) exitwith {
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
		 if (((_x select 1) distance2D _pos) < 1) exitwith {
			 _return = _x select 2;
		 };
	} foreach Server_JobWildCat_Res;
	_return;
}] call Server_Setup_Compile;

["A3PL_JobWildcat_Drill",
{
	private ["_s","_pump","_drilling","_a"];
	_pump = param [0,objNull];

	//check the pin position
	if ((_pump animationPhase "Pin") > 0) exitwith {[localize"STR_A3PL_JobWildcat_CantDrillVehHitched","red"] call A3PL_Player_Notification;};

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
	_s = false;
	_pos = getpos _pump;
	while {_drilling} do {
		if ((_pos distance (getpos _pump)) > 1) exitwith {_pump animateSource ["drill",0,true]; [localize"STR_A3PL_JobWildcat_Returning","red"] call A3PL_Player_Notification;};
		if (_pump animationSourcePhase "drill" == 1) exitwith {_s = true};
		if (isNull _pump) exitwith {};
		uiSleep 1;
	};
	if (_s) then {
		[localize"STR_A3PL_JobWildcat_JackCanBeInstalled","green"] call A3PL_Player_Notification;
		_hole = createVehicle ["A3PL_Drillhole",_pump modelToWorld [0,-1.8,-1.1], [], 0, "CAN_COLLIDE"]; //[0,-1.1,0]
	} else {
		[localize"STR_A3PL_JobWildcat_Canceled","red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;
