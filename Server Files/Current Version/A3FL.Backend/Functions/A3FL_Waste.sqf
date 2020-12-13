/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

// Elk City
// Northern Ireland
["A3PL_Waste_StartJob",
{
	_location = param [0,player_objintersect];
	_spawnLoc = [6031.92,7494.859,0];
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	if (player getVariable ["job","unemployed"] == "waste") exitwith {[localize"STR_NewWaste_1","red"]; call A3PL_NPC_LeaveJob};
	player setVariable ["job","waste"];

 	[localize"STR_NewWaste_2","green"] call A3PL_Player_Notification;
	[localize"STR_NewWaste_3","green"] call A3PL_Player_Notification;

	call A3PL_Player_SetMarkers;
	uiSleep 4;

	switch(_location) do {
		case NPC_WasteManagement: {_spawnLoc = [6031.92,7494.859,0];};
		case NPC_WasteManagement_1: {_spawnLoc = [3125.88,11889.6,0.766];};
		default {_spawnLoc = [6031.92,7494.859,0];};
	};

	["A3PL_P362_Garbage_Truck",_spawnLoc,"waste"] spawn A3PL_Lib_JobVehicle_Assign;
}] call Server_Setup_Compile;

["A3PL_Waste_CheckNear",
{
	private ["_nearTrucks","_truck","_bin","_bin1pos","_bin2pos","_bin1dist","_bin2dist"];
	_bin = param [0,objNull];
	_nearTrucks = nearestObjects [_bin, ["A3PL_P362_Garbage_Truck"], 10];
	if (count _nearTrucks == 0) exitwith {false;};
	_truck = _nearTrucks select 0;

	_bin1pos = _truck modelToWorld [-0.731541,-4.48728,-1.12253];
	_bin2pos = _truck modelToWorld [0.298429,-4.48728,-1.12253];
	_bin1dist = _bin1pos distance _bin;
	_bin2dist = _bin2pos distance _bin;

	if ((_bin1dist < 0.85) OR (_bin2dist < 0.85)) then {true;} else	{false;};
}] call Server_Setup_Compile;

["A3PL_Waste_LoadBin",
{
	private ["_bin","_nearTrucks","_truck"];
	_bin = param [0,objNull];
	_nearTrucks = nearestObjects [_bin, ["A3PL_P362_Garbage_Truck"], 10];
	if (count _nearTrucks == 0) exitwith {[localize"STR_NewWaste_4","red"] call A3PL_Player_Notification;};
	_truck = _nearTrucks select 0;

	_bin1pos = _truck modelToWorld [-0.731541,-4.48728,-1.12253];
	_bin2pos = _truck modelToWorld [0.298429,-4.48728,-1.12253];
	_bin1dist = _bin1pos distance _bin;
	_bin2dist = _bin2pos distance _bin;

	if ((_bin1dist < 0.85) OR (_bin2dist < 0.85)) then
	{
		[_bin] remoteExec ['A3PL_Lib_HideObject', 2];

		if (_bin1dist < _bin2dist) then
		{
			_truck animateSource  ["Bin1", 0.1,true];
			_truck setVariable ["bin1",_bin,true];
		} else
		{
			_truck animateSource  ["Bin2", 0.1,true];
			_truck setVariable ["bin2",_bin,true];
		};
	} else {};
}] call Server_Setup_Compile;

["A3PL_Waste_UnloadBin",
{
	private ["_truck","_name","_bin"];
	_truck = param [0,objNull];
	_name = param [1,""];

	switch (_name) do
	{
		case ("bin1"):
		{
			_bin = _truck getVariable ["bin1",objNull];
			[_bin,false] remoteExec ['A3PL_Lib_HideObject', 2];
			_truck animateSource  ["Bin1", 0,true];
		};
		case ("bin2"):
		{
			_bin = _truck getVariable ["bin2",objNull];
			[_bin,false] remoteExec ['A3PL_Lib_HideObject', 2];
			_truck animateSource  ["Bin2", 0,true];
		};
	};

	_truck setVariable [_name,nil,true];
}] call Server_Setup_Compile;

["A3PL_Waste_FlipBin",
{
	private ["_anim","_truck","_binObj"];
	_truck = param [0,objNull];
	_anim = param [1,""];
	_truck animateSource [_anim, 1];

	_binObj = _truck getVariable [_anim,Objnull];
	if (isNull _binObj) exitwith {["System: Error getting _binObj variable","red"] call A3PL_Player_Notification;};

	if (_binObj getVariable ["A3PL_Waste_ReceivedMoney",false]) exitwith {[localize"STR_NewWaste_5","red"] call A3PL_Player_Notification;};
	_binObj setVariable ["A3PL_Waste_ReceivedMoney",true];

	if (player getVariable ["A3PL_Waste_ReceivedMoney",false]) exitwith {[localize"STR_NewWaste_6","red"] call A3PL_Player_Notification;};
	player setVariable ["A3PL_Waste_ReceivedMoney",true];

	[_binObj] spawn
	{
		private ["_binObj"];
		_binObj = param [0,objNull];

		sleep 2;

		[localize"STR_NewWaste_7","green"] call A3PL_Player_Notification;
		player setVariable ["player_cash",(player getVariable ["player_cash",0])+(300 * A3PL_Event_Paycheck),true];
		[player, 5] call A3PL_Level_AddXP;
		player setVariable ["jobVehicleTimer",(player getVariable ["jobVehicleTimer",0]) + 120,true];

		uiSleep 60;

		player setVariable ["A3PL_Waste_ReceivedMoney",false];

		uiSleep 120;
		_binObj setVariable ["A3PL_Waste_ReceivedMoney",false];
	};
}] call Server_Setup_Compile;
