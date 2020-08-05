/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Prison_HandleDoor",
{
	private ["_obj","_name"];
	_obj = param [0,objNull];
	_name = param [1,""];

	_factionReq = ((count(["usms"] call A3PL_Lib_FactionPlayers)) < 3) || (((count(["usms"] call A3PL_Lib_FactionPlayers)) < 1) && ((count(["fisd"] call A3PL_Lib_FactionPlayers)) < 3));
	if(!(player getVariable["job","unemployed"] IN ["usms","fisd","uscg"]) && _factionReq && ["keycard",1] call A3PL_Inventory_Has) exitwith {
		["There needs to be 3 FIMS or 1 FIMS + 3 FISD on-duty to use the key card!","red"] call A3PL_Player_Notification;
	};


	if (_name IN ["door_20","door_21"]) exitwith { [_obj,_name,false] call A3PL_Lib_ToggleAnimation; };
	if (_name IN
	[
		"door_1_button","door_1_button2","door_2_button","door_2_button2","door_3_button","door_3_button2",
		"door_4_button","door_4_button2","door_5_button","door_5_button2","door_6_button","door_6_button2",
		"door_7_button","door_7_button2","door_8_button","door_8_button2","door_9_button","door_9_button2",
		"door_10_button","door_10_button2","door_11_button","door_11_button2","door_12_button","door_12_button2",
		"door_13_button","door_13_button2","door_14_button","door_14_button2","door_15_button","door_15_button2",
		"door_16_button","door_16_button2","door_23_button","door_23_button2","door_24_button","door_25_button","door_26_button"
	]) exitwith { _name = _name select [0,(_name find "_button")]; [_obj,_name,false] call A3PL_Lib_ToggleAnimation; };

	if (_name IN
	[
		"console_cell1","console_cell2","console_cell3","console_cell4","console_cell5","console_cell6","console_cell7","console_cell8","console_cell9","console_cell10","console_cell11","console_cell12","console_cell13","console_cell14",
		"console_maincell1","console_maincell2","console_maincell3",
		"console_garage"
	]) exitwith
	{
		private ["_anim","_hSel"];
		_anim = "";
		_hSel = -1;
		switch (_name) do
		{
			case ("console_cell1"): {_anim = "cell_door_1"; _hSel = 0;};
			case ("console_cell2"): {_anim = "cell_door_2"; _hSel = 1;};
			case ("console_cell3"): {_anim = "cell_door_3"; _hSel = 2;};
			case ("console_cell4"): {_anim = "cell_door_4"; _hSel = 3;};
			case ("console_cell5"): {_anim = "cell_door_5"; _hSel = 4;};
			case ("console_cell6"): {_anim = "cell_door_6"; _hSel = 5;};
			case ("console_cell7"): {_anim = "cell_door_7"; _hSel = 6;};
			case ("console_cell8"): {_anim = "cell_door_8"; _hSel = 7;};
			case ("console_cell9"): {_anim = "cell_door_9"; _hSel = 8;};
			case ("console_cell10"): {_anim = "cell_door_10"; _hSel = 9;};
			case ("console_cell11"): {_anim = "cell_door_11"; _hSel = 10;};
			case ("console_cell12"): {_anim = "cell_door_12"; _hSel = 11;};
			case ("console_cell13"): {_anim = "cell_door_13"; _hSel = 12;};
			case ("console_cell14"): {_anim = "cell_door_14"; _hSel = 13;};
			case ("console_maincell1"): {_anim = "door_19"; _hSel = 15;};
			case ("console_maincell2"): {_anim = "door_18"; _hSel = 16;};
			case ("console_maincell3"): {_anim = "door_17"; _hSel = 17;};
			case ("console_garage"): {_anim = "door_23"; _hSel = 14;};
		};

		if (_obj animationPhase _anim < 0.5) then //check if we are turning on or off
		{
			_obj setObjectTextureGlobal [_hSel,"#(argb,8,8,3)color(0,1,0,1.0,co)"];
			[_obj,_anim,false,1] call A3PL_Lib_ToggleAnimation;
			if (_name == "console_maincell1") then
			{
				[_obj,"door_22",false,1] call A3PL_Lib_ToggleAnimation;
			};
		} else
		{
			_obj setObjectTextureGlobal [_hSel,"#(argb,8,8,3)color(1,0,0,1.0,co)"];
			[_obj,_anim,false,0] call A3PL_Lib_ToggleAnimation;
			if (_name == "console_maincell1") then
			{
				[_obj,"door_22",false,0] call A3PL_Lib_ToggleAnimation;
			};
		};
	};

	//PEOPLE are breaking out, LOCK THE FUCK DOWN
	if (_name == "console_lockdown") exitwith
	{
		{
			if (_x != "#(argb,8,8,3)color(1,0,0,1.0,co)") then
			{
				_obj setObjectTextureGlobal [_forEachIndex,"#(argb,8,8,3)color(1,0,0,1.0,co)"];
			};
		} foreach (getObjectTextures _obj); //set all textures to red

		{
			if (_obj animationPhase _x > 0.1) then { [_obj,_x,false,0] call A3PL_Lib_ToggleAnimation; };
		} foreach
		[
			"cell_door_1","cell_door_2","cell_door_3","cell_door_4","cell_door_5","cell_door_6","cell_door_7","cell_door_8","cell_door_9","cell_door_10",
			"cell_door_11","cell_door_12","cell_door_13","cell_door_14","door_19","door_18","door_17","door_23"
		];
		playSound3D ["A3PL_Common\effects\lockdown.ogg", _obj, false, getPosASL _obj, 3, 1, 1800];
	};
}] call Server_Setup_Compile;

["A3PL_Prison_LockpickCell",
{
	_cellDoor = param [0,objNull];
	_prison = param [1, objNull];

	if(!(player getVariable["job","unemployed"] IN ["usms","fisd","uscg"]) && ((count(["usms"] call A3PL_Lib_FactionPlayers)) < 3)) exitwith {
		["There needs to be 3 FIMS on-duty to lock pick cell doors!","red"] call A3PL_Player_Notification;
	};

	player playmove "Acts_carFixingWheel";
	["You are attempting to lockpick this cell door", "yellow"] call A3PL_Player_Notification;

	_notifyChance = random 100;
	if(_notifyChance > 90) then {
		playSound3D ["A3PL_Common\effects\lockdown.ogg", objNull, false, getPosASL _prison, 3, 1, 1800];
	};

	[getPlayerUID player,"lockpickCell",[getPos player]] remoteExec ["Server_Log_New",2];

	if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
	["Lockpicking...",45] spawn A3PL_Lib_LoadAction;
	_success = true;
	waitUntil{Player_ActionDoing};
	while {Player_ActionDoing} do {
		if (!(vehicle player isEqualTo player)) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
		if (!(player_itemClass isEqualTo "v_lockpick")) exitwith {_success = false;};
		if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {_success = false;};
		if ((animationState player) != "Acts_carFixingWheel") then {player playmove "Acts_carFixingWheel";}
	};
	player switchMove "";
	if(Player_ActionInterrupted || !_success) exitWith {
		["Failed to lockpick cell door!", "red"] call A3PL_Player_Notification;
		if (vehicle player == player) then {player switchMove "";};
	};

	[player_item] call A3PL_Inventory_Clear;
	[player,"v_lockpick",-1] remoteExec ["Server_Inventory_Add",2];

	_chance = random 10;

	if(_chance > 90) exitWith {
		["Failed to lockpick cell door!", "red"] call A3PL_Player_Notification;
	};

	["Successfully lockpicked cell door!", "green"] call A3PL_Player_Notification;
	_prison animate [_cellDoor,1];
}] call Server_Setup_Compile;

["A3PL_Prison_SearchTrash",
{
	if(!(player getVariable ["jailed",false])) exitWith {["You need to be in jail to search the trash!", "red"] call A3PL_Player_Notification;};
	["You are now searching the trash!", "yellow"] call A3PL_Player_Notification;

	if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
	[player,"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown"] remoteExec ["A3PL_Lib_SyncAnim",0];
	["Searching Trash...",30] spawn A3PL_Lib_LoadAction;
	_success = true;
	waitUntil{Player_ActionDoing};
	while {Player_ActionDoing} do {
		if (!(vehicle player isEqualTo player)) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
		if ((animationState player) isEqualTo "amovpercmstpsnonwnondnon") then {[player,"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown"] remoteExec ["A3PL_Lib_SyncAnim",0];};
	};
	player switchMove "";
	if(Player_ActionInterrupted || !_success) exitWith {
		["Action cancelled!", "red"] call A3PL_Player_Notification;
		if ((vehicle player) isEqualTo player) then {player switchMove "";};
	};

	_rareItems = ["v_lockpick","keycard","ziptie"];
	_pItems = ["A3PL_Pickaxe","A3PL_Shovel","A3PL_Cellphone"];

	_foundRare = false;
	_chance = random 100;
	if(_chance > 85) then {
		[(selectRandom _rareItems),1] call A3PL_Inventory_Add;
		["You found a rare item!", "green"] call A3PL_Player_Notification;
		_foundRare = true;
	};

	_foundItem = false;
	_chance = random 100;
	if(_chance >= 75) then {
		player addItem (selectRandom _pItems);
		["You found a rare item!", "green"] call A3PL_Player_Notification;
		_foundItem = true;
	};

	if(!_foundRare && !_foundItem) then {
		["You didn't found anything!", "red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Prison_DigOut",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};

	if(!(player getVariable["job","unemployed"] IN ["usms","fisd","uscg"]) && ((count(["usms"] call A3PL_Lib_FactionPlayers)) < 3)) exitwith {
		["There needs to be 3 FIMS on-duty to lock pick cell doors!","red"] call A3PL_Player_Notification;
	};

	if(player getVariable "Digging") exitWith{[localize"STR_NewRessources_Action","red"] call A3PL_Player_Notification;};

	if (currentWeapon player != "A3PL_Shovel") exitwith {[localize"STR_NewRessources_NoShovel","red"] call A3PL_Player_Notification;};

	if (Player_ActionDoing) exitwith {[localize"STR_NewRessources_Action","red"] call A3PL_Player_Notification;};
	player setVariable ["Digging",true,true];
	[player,"A3PL_Shovel_Dig"] remoteExec ["A3PL_Lib_SyncAnim", 0];

	["Digging out of jail...",45] spawn A3PL_Lib_LoadAction;
	waitUntil{Player_ActionDoing};
	_success = true;
	while {Player_ActionDoing} do {
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if ((vehicle player) != player) exitWith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
		if (player getVariable ["Cuffed",false]) exitwith {_success = false;};
	};

	[player,""] remoteExec ["A3PL_Lib_SyncAnim", 0];
	player setVariable ["Digging",false,true];
	if(Player_ActionInterrupted || !_success) exitWith {[localize"STR_NewRessources_DiggingCanceled","red"] call A3PL_Player_Notification;};

	_suceedChance = random 100;
	if(_suceedChance > 70) then {
		["Successfully dug out of jail!","green"] call A3PL_Player_Notification;
		_positions = [[5001,6310,0],[4234,6212,0]];
		player setPosATL (selectRandom _positions);
	} else {
		["Failed to dig out of jail!","red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Prison_Markers",
{
	{deleteMarkerLocal _x} foreach A3PL_Inmates_Markers;
	A3PL_Inmates_Markers = nil;
	if(!((player getVariable["job","unemployed"]) isEqualTo "usms")) exitWith {};
	A3PL_Inmates_Markers = [];
	{
		if ((_x getVariable ["jail_mark",false])) then {
			_marker = createMarkerLocal [format["Prisoner_%1",round (random 1000)],visiblePosition _x];
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerColorLocal "ColorYellow";
			_marker setMarkerTypeLocal "mil_dot";
			_marker setMarkerAlphaLocal 0.8;
			if ((_x getVariable ["jailed",false])) then {
				_marker setMarkerTextLocal format["Prisoner %1 (%2min)",(_x getVariable ["name","UNKNOWN"]), (_x getVariable ["jailtime",0])];
			} else {
				_marker setMarkerTextLocal format["Prisoner %1",(_x getVariable ["name","UNKNOWN"])];
			};
			A3PL_Inmates_Markers pushback _marker;
		};
	} foreach allPlayers;
}] call Server_Setup_Compile;