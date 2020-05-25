/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Delivery_StartJob",
{
	_npc = param [0,objNull];
	if(isNull(_npc)) exitWith {};
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	if ((player getVariable ["job","unemployed"]) == "mailman") exitwith {[localize"STR_DELIVERY_WORKSTOP","red"]; call A3PL_NPC_LeaveJob};

	player setVariable ["job","mailman"];
	call A3PL_Player_SetMarkers;
	[localize"STR_DELIVERY_WORKSTART","green"] call A3PL_Player_Notification;
	[localize"STR_DELIVERY_INFO","green"] call A3PL_Player_Notification;

	private _spawnPos = [];
	switch(str(_npc)) do {
		case("npc_mailman"): {_spawnPos = [6056.77,7393.57,0];};
		case("npc_mailman_stoney"): {_spawnPos = [3507.66,7541.57,0];};
		case("npc_mailman_northdale"): {_spawnPos = [10313.1,8556.05,0];};
		case("npc_mailman_beachV"): {_spawnPos = [4143.49,6317.9,0];};
		case("npc_mailman_lubbock"): {_spawnPos = [2213.505,11845.4,0];};
	};

	uiSleep (random 2 + 2);
	["A3PL_Mailtruck",_spawnPos,"MAILMAN",1800] spawn A3PL_Lib_JobVehicle_Assign;

	uiSleep (random 2 + 2);
	call A3PL_Delivery_GenPackage;
}] call Server_Setup_Compile;

["A3PL_Delivery_Deliver",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_package","_pos","_label"];
	_package = objNull;
	{
		if ((typeOf _x) == "A3PL_DeliveryBox") exitwith {_package = _x; true;};
	} foreach ([player] call A3PL_Lib_AttachedAll);
	if (isNull _package) exitwith {[localize"STR_DELIVERY_NOBOX","red"] call A3PL_Player_Notification;};
	_label = _package getVariable ["label",[]];
	_pos = _label select 0;

	if ((player distance _pos) < 10) then
	{
		deleteVehicle _package;
		[localize"STR_DELIVERY_JOBOK","green"] call A3PL_Player_Notification;
		player setVariable ["player_cash",(player getVariable ["player_cash",0])+200,true];
		player setVariable ["jobVehicleTimer",(player getVariable ["jobVehicleTimer",0]) + 240,true]; //extend job vehicle time by 4 minutes
		[player, 5] call A3PL_Level_AddXP;
	} else {
		[localize"STR_DELIVERY_PROXIMITYLOCATION","red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Delivery_Label",
{
	private ["_package","_address","_item","_label"];
	_package = param [0,objNull];
	_label = _package getVariable ["label",[]];
	_address = _label select 2;
	_item = _label select 1;
	if (count _label == 0) exitwith {[localize"STR_DELIVERY_ERRORDELIVER","red"] call A3PL_Player_Notification;};
	[format [localize"STR_DELIVERY_DELIVERBOX",_item,_address],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Delivery_Pickup",
{
	private ["_package"];
	_package = param [0,objNull];
	player playAction "Gesture_carry_box";
	call A3PL_Placeables_QuickAction;
	[_package] spawn
	{
		_package = param [0,objNull];
		if(typeOf _package == "A3FL_DrugBag") then {
			_package setDir ((getDir player) + 90);
		} else {
			_package setDir (getDir player);
		};
		while {_package IN (attachedObjects player)} do {
			uiSleep 0.5;
			if (isNull _package) exitwith {};
		};
		player playAction "gesture_stop";
	};
}] call Server_Setup_Compile;

["A3PL_Delivery_GenPackage",
{
	private ["_locations","_package","_packages","_jobVeh"];
	_locations =
	[
		[[2185.043,5117.308,0],localize"Functions_DeliveryLocation_Shoes",localize"Functions_DeliveryLocation_USCG"],
		[[2185.043,5117.308,0],localize"Functions_DeliveryLocation_Clothing",localize"Functions_DeliveryLocation_USCG"],
		[[2185.043,5117.308,0],localize"Functions_DeliveryLocation_PS4",localize"Functions_DeliveryLocation_USCG"],
		[[2185.043,5117.308,0],localize"Functions_DeliveryLocation_Shoes2",localize"Functions_DeliveryLocation_USCG"],
		[[2608.592,5470.755,0],localize"Functions_DeliveryLocation_Oxygen",localize"Functions_DeliveryLocation_Clinic"],
		[[2608.592,5470.755,0],localize"Functions_DeliveryLocation_Chair",localize"Functions_DeliveryLocation_Clinic"],
		[[2608.592,5470.755,0],localize"Functions_DeliveryLocation_Desktop",localize"Functions_DeliveryLocation_Clinic"],
		[[2608.592,5470.755,0],localize"Functions_DeliveryLocation_Comp",localize"Functions_DeliveryLocation_Clinic"],
		[[2608.592,5470.755,0],localize"Functions_DeliveryLocation_Fe",localize"Functions_DeliveryLocation_Clinic"],
		[[2608.592,5470.755,0],localize"Functions_DeliveryLocation_Pen",localize"Functions_DeliveryLocation_Clinic"],
		[[2608.592,5470.755,0],localize"Functions_DeliveryLocation_Bloc",localize"Functions_DeliveryLocation_Clinic"],
		[[2608.592,5470.755,0],localize"Functions_DeliveryLocation_Badge",localize"Functions_DeliveryLocation_Clinic"],
		[[2608.592,5470.755,0],localize"Functions_DeliveryLocation_Medical",localize"Functions_DeliveryLocation_Clinic"],
		[[2537.9,5605.41,0],localize"Functions_DeliveryLocation_Paycheck",localize"Functions_DeliveryLocation_Bank"],
		[[2537.9,5605.41,0],localize"Functions_DeliveryLocation_Pen",localize"Functions_DeliveryLocation_Bank"],
		[[2537.9,5605.41,0],localize"Functions_DeliveryLocation_Fe",localize"Functions_DeliveryLocation_Bank"],
		[[2537.9,5605.41,0],localize"Functions_DeliveryLocation_CB",localize"Functions_DeliveryLocation_Bank"],
		[[10218.7,8727.76,0],localize"Functions_DeliveryLocation_Pancarte",localize"Functions_DeliveryLocation_RealEstateJob"],
		[[10218.7,8727.76,0],localize"Functions_DeliveryLocation_ContratLocation",localize"Functions_DeliveryLocation_RealEstateJob"],
		[[10218.7,8727.76,0],localize"Functions_DeliveryLocation_Printer",localize"Functions_DeliveryLocation_RealEstateJob"],
		[[10218.7,8727.76,0],localize"Functions_DeliveryLocation_Computer",localize"Functions_DeliveryLocation_RealEstateJob"],
		[[10183.6,8722.56,0],localize"Functions_DeliveryLocation_ContratVente",localize"Functions_DeliveryLocation_CarDealer"],
		[[10183.6,8722.56,0],localize"Functions_DeliveryLocation_CarKey",localize"Functions_DeliveryLocation_CarDealer"],
		[[10183.6,8722.56,0],localize"Functions_DeliveryLocation_Repair",localize"Functions_DeliveryLocation_CarDealer"],
		[[10234.2,8490.62,0],localize"Functions_DeliveryLocation_Repair",localize"Functions_DeliveryLocation_GasStation"],
		[[10234.2,8490.62,0],localize"Functions_DeliveryLocation_Jerrycan",localize"Functions_DeliveryLocation_GasStation"],
		[[10234.2,8490.62,0],localize"Functions_DeliveryLocation_Etagere",localize"Functions_DeliveryLocation_GasStation"],
		[[10046.1,8466.96,0],localize"Functions_DeliveryLocation_Cellphone",localize"Functions_DeliveryLocation_GeneralStore"],
		[[10046.1,8466.96,0],localize"Functions_DeliveryLocation_Tuyau",localize"Functions_DeliveryLocation_GeneralStore"],
		[[10046.1,8466.96,0],localize"Functions_DeliveryLocation_Adaptateur",localize"Functions_DeliveryLocation_GeneralStore"],
		[[10003.888,7919.284,0],localize"Functions_DeliveryLocation_SIMCard",localize"Functions_DeliveryLocation_PhoneSim"],
		[[10003.888,7919.284,0],localize"Functions_DeliveryLocation_Tournevis",localize"Functions_DeliveryLocation_PhoneSim"],
		[[10003.888,7919.284,0],localize"Functions_DeliveryLocation_Computer",localize"Functions_DeliveryLocation_PhoneSim"],
		[[6472.77,5516.4,0],localize"Functions_DeliveryLocation_Axe",localize"Functions_DeliveryLocation_LumberJack"],
		[[6976.15,6633.17,0],localize"Functions_DeliveryLocation_KartWheels",localize"Functions_DeliveryLocation_Kart"],
		[[6982.53,7128.21,0],localize"Functions_DeliveryLocation_Water",localize"Functions_DeliveryLocation_BoulderTaco"],
		[[7107.94,7197.76,0],localize"Functions_DeliveryLocation_Water",localize"Functions_DeliveryLocation_BoulderMcFishers"],
		[[7119.9,7249.33,0],localize"Functions_DeliveryLocation_Computer",localize"Functions_DeliveryLocation_BoulderGem"],
		[[6064.7,7474.21,0],localize"Functions_DeliveryLocation_WasteUniforms",localize"Functions_DeliveryLocation_Waste"],
		[[11842.1,9252.28,0],localize"Functions_DeliveryLocation_Computer",localize"Functions_DeliveryLocation_WeaponsFactory"],
		[[3469.14,7483.19,0],localize"Functions_DeliveryLocation_Net",localize"Functions_DeliveryLocation_FishingShop"],
		[[2471.12,5640.3,0],localize"Functions_DeliveryLocation_Tournevis",localize"Functions_DeliveryLocation_FurnStore"],
		[[9926.55,7474.74,0],localize"Functions_DeliveryLocation_Computer",localize"Functions_DeliveryLocation_FirearmsDealer"],
		[[3541.34,5157.79,0],localize"Functions_DeliveryLocation_Comp",localize"Functions_DeliveryLocation_PaintBall"]
	];

	_attachPoints = [
		[-0.7,0,-0.87],[-0.3,0,-0.87],[0.15,0,-0.87],[0.6,0,-0.87],
		[-0.7,-1.9,-0.87],[-0.3,-1.9,-0.87],[0.15,-1.9,-0.87],[0.6,-1.9,-0.87]
	];

	_attachpoints = _attachPoints call BIS_fnc_arrayShuffle;
	_locations = _locations call BIS_fnc_arrayShuffle;

	_jobVeh = player getVariable ["jobVehicle",objNull];
	if (isNull _jobVeh) exitwith {[localize"STR_DELIVERY_JOBERRORVEHICLE","red"] call A3PL_Player_Notification;};

	for "_i" from 0 to (3 + (round (random 3))) do {
		_package = createVehicle ["A3PL_DeliveryBox", getpos player, [], 0, "CAN_COLLIDE"];
		_package attachTo [_jobVeh,(_attachPoints select _i)];
		_package setVariable ["class","mail",true];
		_package setVariable ["owner",getPlayerUID player,true];
		_package setVariable ["label",(_locations select (random ((count _locations) - 1)))];
	};
	[localize"STR_DELIVERY_JOBINFO2","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
