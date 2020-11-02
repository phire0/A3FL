/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define factionsList [["Citizen of Fishers Island","citizen","unemployed"],["Fishers Island Sheriff Department","fisd","fisd"],["Fishers Island Fire and Rescue","fifr","fifr"],["Department Of Justice","doj","doj"],["Fishers Island Marshals Service","fims","fims"],["United States Coast Guard","uscg","uscg"],["Federal Bureau of Investigation","fbi","fbi"]]
#define adminTagsList [["Civilian Tag",["#B5B5B5","#ed7202","\A3PL_Common\icons\citizen.paa"]],["Executive Tag",["#B5B5B5","#8410ff","\A3PL_Common\icons\executive.paa"]],["Executive Supervisor Tag",["#B5B5B5","#5ab2ff","\A3PL_Common\icons\exec_supervisor.paa"]],["Developer Tag",["#B5B5B5","#FFFFFF","\A3PL_Common\icons\creator.paa"]],["Lead Dev Tag",["#B5B5B5","#2c82c9","\A3PL_Common\icons\leaddev.paa"]],["Chief Tag",["#B5B5B5","#2f9baa","\A3PL_Common\icons\chief.paa"]],["Sub-Director Tag",["#B5B5B5","#ff6d29","\A3PL_Common\icons\subdirector.paa"]],["Director Tag",["#B5B5B5","#cece08","\A3PL_Common\icons\director.paa"]]]
#define ADMIN_OBJECTS [["Business Sign","Land_A3PL_BusinessSign"],["Estate Sign","Land_A3PL_EstateSign"],["Estate Sign (Rented)","Land_A3PL_EstateSignRented"],["Fire Hydrant","Land_A3PL_FireHydrant"],["Portable Light","Land_PortableLight_double_F"],["Pipes","Land_Pipes_large_F"],["Tribune","Land_Tribune_F"],["Ramp","Land_RampConcrete_F"],["Crash Barrier","Land_Crash_barrier_F"],["Stairs","Land_GH_Stairs_F"],["Road Cone","RoadCone_L_F"],["Road Barrier","RoadBarrier_F"],["Crane","Land_Crane_F"],["Bunker","Land_BagBunker_Small_F"],["Finish Gate","Land_FinishGate_01_wide_F"],["Podium","Land_WinnersPodium_01_F"],["Concrete Block","BlockConcrete_F"],["Dirt Hump","Dirthump_3_F"],["Target","TargetBootcampHuman_F"],["Amphitheater","Land_Amphitheater_F"],["Garbage","Land_GarbageBags_F"],["Tyre Barrier","TyreBarrier_01_black_F"],["Tyre Barrier 6x","Land_TyreBarrier_01_line_x6_F"],["White Flag","Flag_White_F"],["Green Flag","Flag_Green_F"],["Red Flag","Flag_Red_F"],["Blue Flag","Flag_Blue_F"],["Party Tent","Land_PartyTent_01_F"],["Body Bag","Land_Bodybag_01_white_F"],["Dueling Target","Land_Target_Dueling_01_F"],["Large Carport","Land_Shed_Big_F"],["Small StartFinish Gate","Land_FinishGate_01_narrow_F"],["Large StartFinish Gate","Land_FinishGate_01_wide_F"]]

["A3PL_Admin_Check",
{
	pVar_AdminMenuGranted = false;
	pVar_AdminTwitter = false;

	player setVariable ["pVar_RedNameOn",false,true];
	pVar_MapTeleportReady = false;
	pVar_MapPlayerMarkersOn = false;
	pVar_MapVehicleMarkersOn = false;
	pVar_RessourcesMarkersOn = false;
	pVar_FastAnimationOn = false;
	pVar_FiresFrozen = false;

	pVar_AdminLevel = player getVariable ["dbVar_AdminLevel",0];
	if (pVar_AdminLevel isEqualTo 0) exitwith {};

	pVar_AdminPerms = player getVariable ["dbVar_AdminPerms",[]];
	pVar_CursorTargetEnabled = false;
	pVar_AdminTwitter = true;
	pVar_AdminMenuGranted = true;
	showChat false;
}] call Server_Setup_Compile;

["A3PL_AdminOpen", {
	disableSerialization;
	if(isNull (findDisplay 98)) exitWith {
		createDialog "Dialog_ExecutiveMenu";
		[] remoteExec ["Server_Fire_PauseCheck",2];
		call A3PL_AdminPlayerList;
		call A3PL_AdminPlayerInfoList;
		call A3PL_AdminFactoryComboList;
		call A3PL_Admin_InventoryCombo;
		call A3PL_AdminToolsList;
		call A3PL_Admin_TwitterTagsCombo;
		call A3PL_Admin_FactionCombo;
		ctrlSetText [1000, format ["Staff Menu | %2 %1",player getVariable "name",[player] call A3PL_AdminTitle]];
	};
	if (!IsNull (findDisplay 98)) exitWith {(findDisplay 98) closeDisplay 1;};
}] call Server_Setup_Compile;

["A3PL_AdminTitle", {
	params[["_player",objNull,[objNull]]];
	private _title = switch(_player getVariable["dbVar_AdminLevel",0]) do {
		case(0): {""};
		case(1): {"Executive"};
		case(2): {"Exec. Supervisor";};
		case(3): {"Developer"};
		case(5): {"Chief"};
		case(6): {"Sub-Director"};
		case(7): {"Director"};
	};
	_title;
}] call Server_Setup_Compile;

["A3PL_AdminPlayerList", {
	_display = findDisplay 98;
	_control = _display displayCtrl 1500;
	_id = lbCurSel 1500;
	A3PL_Admin_PlayerList = [];
	{
		lbAdd [1500, format ["%1",_x getVariable["name",name _x]]];
		if ((_x getVariable ["adminWatch",0]) isEqualTo 1) then {lbSetColor [1500,_forEachIndex,[1,0,0,1]];};
		if ((_x getVariable ["dbVar_AdminLevel",0]) isEqualTo 1) then {lbSetColor [1500,_forEachIndex,[0.612,0.153,0.69,1]];};
		if ((_x getVariable ["dbVar_AdminLevel",0]) isEqualTo 2) then {lbSetColor [1500,_forEachIndex,[0.38039215686,0.70980392156,1,1]];};
		if ((_x getVariable ["dbVar_AdminLevel",0]) isEqualTo 3) then {};
		if ((_x getVariable ["dbVar_AdminLevel",0]) isEqualTo 4) then {lbSetColor [1500,_forEachIndex,[0.11764705882,0.56470588235,1,1]];};
		if ((_x getVariable ["dbVar_AdminLevel",0]) isEqualTo 5) then {lbSetColor [1500,_forEachIndex,[0.012,0.663,0.957,1]];};
		if ((_x getVariable ["dbVar_AdminLevel",0]) isEqualTo 6) then {lbSetColor [1500,_forEachIndex,[0.90588235294,0.49411764705,0.14901960784,1]];};
		if ((_x getVariable ["dbVar_AdminLevel",0]) isEqualTo 7) then {lbSetColor [1500,_forEachIndex,[1,1,0,1]];};
		A3PL_Admin_PlayerList pushBack _x;
	} foreach allPlayers;
	_control ctrlAddEventHandler ["LBSelChanged","call A3PL_AdminPlayerInfoList;"];
	_control ctrlAddEventHandler ["LBDblClick","call A3PL_AdminWatch;"];
	_control lbSetCurSel count(A3PL_Admin_PlayerList)-1;
}] call Server_Setup_Compile;

["A3PL_AdminPlayerInfoList", {
	private _display = findDisplay 98;
	private _selectedIndex = lbCurSel 1500;
	private _control = _display displayCtrl 1503;
	private _selectedPlayer = (A3PL_Admin_PlayerList select _selectedIndex);
	private _playerInfoArray = [
		["ID:", [_selectedPlayer getVariable["db_id",-1],3]],
		["TS:", ["A3PL_TeamspeakID",0]],
		["Name:", ["name",0]],
		["A3:", [name _selectedPlayer,3]],
		["Cash: $", ["Player_Cash",1]],
		["Bank: $", ["Player_Bank",1]],
		["Faction:", ["faction",0]],
		["Job:", ["job",0]],
		["Alive:", ["A3PL_Medical_Alive",2]],
		["Blood:", ["A3PL_Medical_Blood",0]],
		["Wounded:", ["A3PL_Wounds",4]],
		["Cuffed:", ["Cuffed",2]],
		["Zipped:", ["Zipped",2]]
	];
	lbClear 1503;
	{
		_text = _x select 0;
		_data = _x select 1;
		switch(_data select 1) do {
			case 0: {lbAdd [1503, format ["%1 %2", _text, _selectedPlayer getVariable [(_data select 0),"Undefined"]]];};
			case 1: {lbAdd [1503, format ["%1 %2", _text,(_selectedPlayer getVariable [(_data select 0),-1]) call CBA_fnc_formatNumber]];};
			case 2: {
				if((_selectedPlayer getVariable [(_data select 0),true])) then {
					lbAdd [1503, format ["%1 %2", _text, "Yes"]];
				} else {
					lbAdd [1503, format ["%1 %2", _text, "No"]];
				};
			};
			case 3: {lbAdd [1503, format ["%1 %2", _text, _data select 0]];};
			case 4: {
				if((_selectedPlayer getVariable [(_data select 0),[]]) isEqualTo []) then {
					lbAdd [1503, format ["%1 %2", _text, "No"]];
				} else {
					lbAdd [1503, format ["%1 %2", _text, "Yes"]];
				};
			};
		};
	} forEach _playerInfoArray;
}] call Server_Setup_Compile;

["A3PL_Admin_PlayerInventoryFill", {
	_display = findDisplay 98;
	_selectedIndex = lbCurSel 2101;
	_selectedPlayerIndex = lbCurSel 1500;
	_selectedInventory = lbText [2101,lbCurSel 2101];
	_selectedPlayer = (A3PL_Admin_PlayerList select _selectedPlayerIndex);
	_index = 999;
	if (_selectedInventory isEqualTo localize"STR_ADMIN_PLAYER") then {
		lbClear 1502;
		{
			_i = lbAdd [1502,format ["%1 (%2)",[_x select 0,"name"] call A3PL_Config_GetItem,(_x select 1)]];
			lbSetData [1502, _i, (_x select 0)];
			lbSetValue [1502, _i, (_x select 1)];
		} forEach (_selectedPlayer getVariable ["player_inventory",[]]);
	} else {
		_toLoadInventory = [_selectedInventory,_selectedPlayer] call A3PL_Factory_GetStorage;
		{
			_i = lbAdd [1502,format ["%1 (%2)",_x select 0,_x select 1]];
			lbSetData [1502, _i, (_x select 0)];
			lbSetValue [1502, _i, (_x select 1)];
		} forEach _toLoadInventory;
	};
}] call Server_Setup_Compile;

["A3PL_AdminFactoryComboList", {
	private _display = findDisplay 98;
	private _control = _display displayCtrl 2100;
	{lbAdd [2100,_x select 0];} foreach Config_Factories;
	{lbAdd [2100,_x];} foreach ["Objects", "AdminVehicles"];
	_control ctrlAddEventHandler ["lbSelChanged",{call A3PL_AdminFillFactoryList;}];
}] call Server_Setup_Compile;

["A3PL_Admin_InventoryCombo", {
	private _display = findDisplay 98;
	private _selectedInventory = _display displayCtrl 2101;
	private _inventories = ["Player","Chemical Plant","Steel Mill","Oil Refinery","Goods Factory","Food Processing Plant","Vehicle Factory","Marine Factory","Aircraft Factory","Clothing Factory","Vest Factory","Headgear Factory","Goggle Factory","Illegal Weapon Factory"];
	{lbAdd [2101,_x];} foreach _inventories;
	_selectedInventory ctrlAddEventHandler ["lbSelChanged","call A3PL_Admin_PlayerInventoryFill;"];
}] call Server_Setup_Compile;

["A3PL_Admin_TwitterTagsCombo", {
	private _display = findDisplay 98;
	{
		if(_forEachIndex <= pVar_AdminLevel) then {
			lbAdd [2102, _x select 0];
		};
	} foreach adminTagsList;
	(_display displayCtrl 2102) ctrlAddEventHandler ["lbSelChanged","call A3PL_Admin_SetTwitterTag;"];
}] call Server_Setup_Compile;

["A3PL_Admin_SetTwitterTag", {
	private _display = findDisplay 98;
	private _selectedTag = lbCurSel 2102;
	player setVariable["twitterTag",(adminTagsList select _selectedTag) select 1, true];
}] call Server_Setup_Compile;

["A3PL_Admin_FactionCombo", {
	private _display = findDisplay 98;
	if!("Faction" IN (player getVariable ["dbVar_AdminPerms",[]])) exitWith {};
	{lbAdd [2103, _x select 0];} foreach factionsList;
	(_display displayCtrl 2103) ctrlAddEventHandler ["lbSelChanged","call A3PL_Admin_SetFaction;"];
}] call Server_Setup_Compile;

["A3PL_Admin_SetFaction", {
	private ["_display","_selectedTag"];
	if !("Faction" IN (player getVariable ["dbVar_AdminPerms",[]])) exitWith {[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;};

	_display = findDisplay 98;
	_selectedTag = lbCurSel 2103;
	_target = lbCurSel 1500;
	if(_target < 0) exitWith {};
	_target = (A3PL_Admin_PlayerList select _target);
	_target setVariable["faction",(factionsList select _selectedTag) select 1,true];
	_target setVariable["job",(factionsList select _selectedTag) select 2,true];
	call A3PL_Player_SetMarkers;
}] call Server_Setup_Compile;

["A3PL_AdminToolsList", {
	private _display = findDisplay 98;
	private _control = _display displayCtrl 1504;
	private _fullList = [
		["Teleport",pVar_MapTeleportReady,A3PL_AdminMapTeleport],
		["Toggle Twitter",false,A3PL_AdminTwitterToggle],
		["Fix Garage",false,A3PL_Admin_FixGarage],
		["Admin Mode",player getVariable ["pVar_RedNameOn",false],A3PL_AdminRedName],
		["Create Fire",false,A3PL_Admin_CreateFire],
		["Pause Fire",pVar_FiresFrozen,A3PL_Admin_PauseFire],
		["Remove Fire",false,A3PL_Admin_RemoveFire],
		["Fast Animation",pVar_FastAnimationOn,A3PL_AdminFastAnimation],
		["Self Feed",false,A3PL_AdminSelfFeed],
		["Freeze",false,A3PL_Admin_Freeze],
		["Vehicle Markers",pVar_MapVehicleMarkersOn,A3PL_AdminVehicleMarkers],
		["Player Markers",pVar_MapPlayerMarkersOn,A3PL_AdminMapMarkers],
		["Double EXP",false,A3PL_AdminEXP],
		["Double Harvest",false,A3PL_AdminHarvest],
		["1.5 Paychecks",false,A3PL_AdminPaychecks],
		["1.5 Crime Payout",false,A3PL_AdminCrime],
		["Players Stats",false,A3PL_Admin_ViewStats],
		["Ressources Makers", pVar_RessourcesMarkersOn, A3PL_AdminRessourcesMarkers],
		["Camera",false,A3PL_Admin_Camera],
		["Invisible",false,A3PL_Admin_Invisible],
		["Virtual Arsenal",false,A3PL_Admin_VirtualArsenal]
	];

	dVar_AdminToolsList = [];
	{
		_toolName = _x select 0;
		_toolColor = _x select 1;
		_skip = ["Pause Fire"];
		if(_toolName IN pVar_AdminPerms) then {
			dVar_AdminToolsList pushBack(_x);
			lbAdd [1504,_toolName];
			if ((_skip find _toolName) == -1) then {
				if (_toolColor) then {
					lbSetColor [1504, _forEachIndex, [1,.8,0,1]];
				};
			};
		};
	} foreach _fullList;
	_control ctrlAddEventHandler ["LBDblClick","call A3PL_SelectedAdminTool;"];
}] call Server_Setup_Compile;

["A3PL_SelectedAdminTool", {
	_selectedIndex = lbCurSel 1504;
	_selectedTool = ((dVar_AdminToolsList select _selectedIndex) select 0);
	switch (_selectedTool) do {
		case "Teleport": {call A3PL_AdminMapTeleport};
		case "Toggle Twitter": {call A3PL_AdminTwitterToggle};
		case "Fix Garage": {call A3PL_Admin_FixGarage};
		case "Admin Mode": {call A3PL_AdminRedName};
		case "Create Fire": {call A3PL_Admin_CreateFire};
		case "Pause Fire": {call A3PL_Admin_PauseFire};
		case "Remove Fire": {call A3PL_Admin_RemoveFire};
		case "Fast Animation": {call A3PL_AdminFastAnimation};
		case "Self Feed": {call A3PL_AdminSelfFeed};
		case "Freeze": {call A3PL_Admin_Freeze};
		case "Vehicle Markers": {call A3PL_AdminVehicleMarkers;};

		case "Player Markers": {call A3PL_AdminMapMarkers;};
		case "Double EXP": {[] remoteExec ["Server_Core_DblXP",2];};
		case "Double Harvest": {[] remoteExec ["Server_Core_DblHarvest",2];};
		case "1.5 Paychecks": {[] remoteExec ["Server_Core_PaycheckBonus",2];};
		case "1.5 Crime Payout": {[] remoteExec ["Server_Core_CrimeBonus",2];};

		case "Players Stats": {call A3PL_Admin_ViewStats;};
		case "Ressources Makers": {call A3PL_AdminRessourcesMarkers;};
		case "Camera": {call A3PL_Admin_Camera};
		case "Invisible": {call A3PL_Admin_Invisible};
		case "Virtual Arsenal": {call A3PL_Admin_VirtualArsenal};
	};
}] call Server_Setup_Compile;

["A3PL_Admin_VirtualArsenal", {
	closeDialog 0;
	["Open",true] spawn BIS_fnc_arsenal;
}] call Server_Setup_Compile;

["A3PL_Admin_FixGarage", {
	private _target = player_objIntersect;
	_target setVariable ["inUse",false,true];
	if((typeOf _target) isEqualTo "Land_A3PL_storage") then {
		_target animateSource ["storagedoor",0];
	};
}] call Server_Setup_Compile;

["A3PL_Admin_Camera", {
	closeDialog 0;
	["Init"] call BIS_fnc_camera;
}] call Server_Setup_Compile;

["A3PL_AdminWatch", {
	_display = findDisplay 98;
	_selectedIndex = lbCurSel 1500;
	_selectedPlayer = (A3PL_Admin_PlayerList select _selectedIndex);
	_uid = getPlayerUID _selectedPlayer;
	_name = _selectedPlayer getVariable "name";
	_adminWatch = _selectedPlayer getVariable ["adminWatch",0];

	if (_adminWatch == 0) then {
		_selectedPlayer setVariable ["adminWatch",1,true];
		lbSetColor [1500,_selectedIndex,[1,0,0,1]];
		[1,_uid] remoteExec ["Server_Player_AdminWatch",2];
	} else {
		_selectedPlayer setVariable ["adminWatch",0,true];
		lbSetColor [1500,_selectedIndex,[1,1,1,1]];
		[0,_uid] remoteExec ["Server_Player_AdminWatch",2];
	};
}] call Server_Setup_Compile;

["A3PL_AdminFillFactoryList", {
	_display = findDisplay 98;
	_control = _display displayCtrl 2100;
	_selectedFactory = _control lbText (lbCurSel _control);

	_control = _display displayCtrl 1501;
	lbClear _control;
	if (_selectedFactory isEqualTo "Objects" || _selectedFactory isEqualTo "AdminVehicles") then {
		if (_selectedFactory isEqualTo "AdminVehicles") exitWith {
			{
				_first_X = _x;
				{
					_class = format ["%1_%2",(_first_X select 0),_x];
					_i = lbAdd [1501,_class];
					lbSetData [1501,_i,_class];
				} foreach (_x select 1);
			} forEach Config_Vehicles_Admin;
		};

		if (_selectedFactory isEqualTo "Objects") exitWith {
			{
				_i = lbAdd [1501,(_x select 0)];
				lbSetData [1501,_i,(_x select 1)];
			} forEach ADMIN_OBJECTS;
		};
	} else {
		_recipes = ["all",_selectedFactory] call A3PL_Config_GetFactory;
		{
			_id = _x select 0;
			_name = _x select 2;
			_itemClass = _x select 4;
			_itemType = _x select 5;
			if (_name == "inh") then {_name = [_itemClass,_itemType,"name"] call A3PL_Factory_Inheritance;};
			_i = lbAdd [1501,_name];
			lbSetData [1501,_i,_id];
		} forEach _recipes;
	};
	_control ctrlAddEventHandler ["lbSelChanged",{_selectedAsset = lbData [1501,(lbCurSel 1501)];}];
}] call Server_Setup_Compile;

["A3PL_AdminCursorTarget", {
	("Dialog_HUD_AdminCursor" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD_AdminCursor", "PLAIN"];
	pVar_CursorTargetEnabled = true;
	((uiNamespace getVariable "Dialog_HUD_AdminCursor") displayCtrl 2414) ctrlSetStructuredText (parseText format["<t font='PuristaSemiBold' align='left' size='0.85'>Numpad 0: Driver<br/>Numpad 1: Attach<br/>Numpad 2: Detach<br/>Numpad 3: Impound<br/>Numpad 4: Delete<br/>Numpad 5: Passenger<br/>Numpad 6: Eject passangers<br/>Numpad 7: Heal<br/>Numpad 8: Repair<br/>Numpad 9: Refuel</t>"]);

	while {pVar_CursorTargetEnabled} do {
		((uiNamespace getVariable "Dialog_HUD_AdminCursor") displayCtrl 1000) ctrlSetStructuredText (parseText format["<t font='PuristaSemiBold' align='center' size='1'>Cursor: %1</t>",(name cursorObject)]);
	};
	("Dialog_HUD_AdminCursor" call BIS_fnc_rscLayer) cutFadeOut 1;
}] call Server_Setup_Compile;

["A3PL_Admin_AttachTo", {
	params[["_veh",objNull,[objNull]]];
	if(isNull _veh) exitWith {};
	_veh attachTo [player];
	attachKeyDown =
	{
		_key = (_this select 0) select 1;
		_veh = [_this select 1] call A3PL_Lib_vehStringToObj;
		_return = false;
		switch _key do
		{
			case 201: {
				_return = true;
			};
			case 209: {
				_return = true;
			};
			case 199: {
				_return = true;
			};
			case 207: {
				_return = true;
			};
		};
		_return;
	};
	waituntil {!isNull findDisplay 46};
	_attachKeyDown = (findDisplay 46) DisplayAddEventHandler ["keydown",format["[_this,'%1'] call attachKeyDown",_veh]];
	waitUntil {!(_veh IN (attachedObjects player)) || (isNull _veh)};
	(findDisplay 46) displayremoveeventhandler ["keydown",_attachKeyDown];
}] call Server_Setup_Compile;

["A3PL_Admin_DetachAll", {
	{detach _x;} forEach attachedObjects player;
}] call Server_Setup_Compile;

["A3PL_AdminSearchPlayerList", {
	_display = findDisplay 98;
	_text = ctrlText 1400;

	if (_text == "") then {
		lbClear 1500;
		A3PL_Admin_PlayerList = [];
		{
			lbAdd [1500, format ["%1",_x getVariable["name",name _x]]];
			if ((_x getVariable ["adminWatch",0]) == 1) then {lbSetColor [1500,_forEachIndex,[1,0,0,1]];};
			if ((_x getVariable ["dbVar_AdminLevel",0]) == 1) then {lbSetColor [1500,_forEachIndex,[0.612,0.153,0.69,1]];};
			if ((_x getVariable ["dbVar_AdminLevel",0]) == 2) then {lbSetColor [1500,_forEachIndex,[0.38039215686,0.70980392156,1,1]];};
			if ((_x getVariable ["dbVar_AdminLevel",0]) == 3) then {};
			if ((_x getVariable ["dbVar_AdminLevel",0]) == 4) then {lbSetColor [1500,_forEachIndex,[0.11764705882,0.56470588235,1,1]];};
			if ((_x getVariable ["dbVar_AdminLevel",0]) == 5) then {lbSetColor [1500,_forEachIndex,[0.012,0.663,0.957,1]];};
			if ((_x getVariable ["dbVar_AdminLevel",0]) == 6) then {lbSetColor [1500,_forEachIndex,[0.90588235294,0.49411764705,0.14901960784,1]];};
			if ((_x getVariable ["dbVar_AdminLevel",0]) == 7) then {lbSetColor [1500,_forEachIndex,[1,1,0,1]];};
			A3PL_Admin_PlayerList pushBack _x;
		} foreach allPlayers;
	} else {
		lbClear 1500;
		A3PL_Admin_PlayerList = [];
		{
			_name = format ["%1 (%2)",_x getVariable ["name","Undefined"],name _x];
			if ((_name find _text) != -1) then {
				lbAdd [1500, format ["%1",_x getVariable["name",name _x]]];
				if ((_x getVariable ["adminWatch",0]) == 1) then {lbSetColor [1500,_forEachIndex,[1,0,0,1]];};
				if ((_x getVariable ["dbVar_AdminLevel",0]) == 1) then {lbSetColor [1500,_forEachIndex,[0.612,0.153,0.69,1]];};
				if ((_x getVariable ["dbVar_AdminLevel",0]) == 2) then {lbSetColor [1500,_forEachIndex,[0.38039215686,0.70980392156,1,1]];};
				if ((_x getVariable ["dbVar_AdminLevel",0]) == 3) then {};
				if ((_x getVariable ["dbVar_AdminLevel",0]) == 4) then {lbSetColor [1500,_forEachIndex,[0.11764705882,0.56470588235,1,1]];};
				if ((_x getVariable ["dbVar_AdminLevel",0]) == 5) then {lbSetColor [1500,_forEachIndex,[0.012,0.663,0.957,1]];};
				if ((_x getVariable ["dbVar_AdminLevel",0]) == 6) then {lbSetColor [1500,_forEachIndex,[0.90588235294,0.49411764705,0.14901960784,1]];};
				if ((_x getVariable ["dbVar_AdminLevel",0]) == 7) then {lbSetColor [1500,_forEachIndex,[1,1,0,1]];};
				A3PL_Admin_PlayerList pushBack _x;
			};
		} foreach allPlayers;
	};
}] call Server_Setup_Compile;

["A3PL_AdminSearchFactoryList", {
	_display = findDisplay 98;
	_text = ctrlText 1401;
	_control = _display displayCtrl 2100;
	_selectedFactory = _control lbText (lbCurSel _control);

	if (_text == "") then {
		_control = _display displayCtrl 1501;
		lbClear _control;

		if (_selectedFactory == "Objects" || _selectedFactory == "AdminVehicles") then {
			if (_selectedFactory == "Objects") exitWith {
				{
					_i = lbAdd [1501,(_x select 0)];
					lbSetData [1501,_i,(_x select 1)];
				} foreach ADMIN_OBJECTS;
			};

			if (_selectedFactory == "AdminVehicles") exitWith {
				{
					_first_X = _x;
					{
						_class = format ["%1_%2",(_first_X select 0),_x];
						_i = lbAdd [1501,_class];
						lbSetData [1501,_i,_class];
					} foreach (_x select 1);
				} foreach Config_Vehicles_Admin;
			};
		} else {
			_recipes = ["all",_selectedFactory] call A3PL_Config_GetFactory;
			{
				_id = _x select 0;
				_name = _x select 2;
				_itemClass = _x select 4;
				_itemType = _x select 5;
				if (_name == "inh") then {_name = [_itemClass,_itemType,"name"] call A3PL_Factory_Inheritance;};
				_index = _control lbAdd _name;
				_control lbSetData [_index,_id];
			} foreach _recipes;
		};
	} else {
		_control = _display displayCtrl 1501;
		lbClear _control;

		if (_selectedFactory isEqualTo "Objects" || _selectedFactory isEqualTo "AdminVehicles") then {
			if (_selectedFactory isEqualTo "Objects") exitWith {
				{
					_name = _x select 0;
					if ((_name find _text) != -1) then {
						_i = lbAdd [1501,(_x select 0)];
						lbSetData [1501,_i,(_x select 1)];
					};
				} foreach ADMIN_OBJECTS;
			};

			if (_selectedFactory == "AdminVehicles") exitWith {
				{
					_first_X = _x;
					{
						_name = _x;
						if ((_name find _text) != -1) then {
							_class = format ["%1_%2",(_first_X select 0),_x];
							_i = lbAdd [1501,_class];
							lbSetData [1501,_i,_class];
						};
					} foreach (_x select 1);
				} foreach Config_Vehicles_Admin;
			};
		} else {
			_recipes = ["all",_selectedFactory] call A3PL_Config_GetFactory;
			{
				private ["_name","_itemType","_itemClass","_index"];
				_id = _x select 0;
				_name = _x select 2;
				_itemClass = _x select 4;
				_itemType = _x select 5;
				if (_name == "inh") then {_name = [_itemClass,_itemType,"name"] call A3PL_Factory_Inheritance;};
				if ((_name find _text) != -1) then {
					_index = _control lbAdd _name;
					_control lbSetData [_index,_id];
				};
			} foreach _recipes;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Admin_AddToFactory", {
	if ((player getVariable "dbVar_AdminLevel") >= 1) then {
		private ["_isFactory","_itemType"];

		_display = findDisplay 98;

		_selectedFactory = lbText [2100,(lbCurSel 2100)];
		if (_selectedFactory == "") exitwith {[localize"STR_ADMIN_NOFACTORYSELECTED","red"] call A3PL_Player_Notification;};
		_selectedAsset = lbData [1501,(lbCurSel 1501)];

		if ((lbCurSel 1501) < 0) exitwith {[localize"STR_ADMIN_NOTHINGSELECTED","red"] call A3PL_Player_Notification;};
		_selectedPlayer = A3PL_Admin_PlayerList select (lbCurSel 1500);

		_control = _display displayCtrl 1403;
		_amount = parseNumber (ctrlText _control);
		if (_amount < 1) exitwith {[localize"STR_Various_INVALIDAMOUNT","red"] call A3PL_Player_Notification;};

		_isFactory = _selectedAsset splitString "_";
		if ((_isFactory select 0) == "f") then {_isFactory = true; _itemType = [_selectedAsset,_selectedFactory,"type"] call A3PL_Config_GetFactory;} else {_isFactory = false;};
		if (isNil "_itemType") then {_itemType = ""};
		if (_isFactory && (_itemType == "item")) then {_selectedAsset = [_selectedAsset,_selectedFactory,"class"] call A3PL_Config_GetFactory;};

		[_selectedPlayer,_selectedFactory,[_selectedAsset,_amount],false] remoteExec ["Server_Factory_Add", 2];
		_itemName = lbText [1501,(lbCurSel 1501)];
		[format[localize"STR_ADMIN_ADDEDTOFACTORY",_amount,_itemName,_selectedFactory,_selectedPlayer getVariable ["name","inconnu"]],"green"] call A3PL_Player_Notification;

		[player,"factories",[format ["AddFactory: %5 %1(s) ADDED TO %2(%3) (%4)",_selectedAsset,_selectedPlayer getVariable ["name","Undefined"],(getPlayerUID _selectedPlayer),_selectedFactory,_amount]]] remoteExec ["Server_AdminLoginsert", 2];
	} else {
		[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Admin_AddToPlayer", {
	if ((player getVariable "dbVar_AdminLevel") >= 1) then {
		private ["_display","_control","_type","_player","_recipe"];
		_display = findDisplay 98;

		_selectedFactory = lbText [2100,(lbCurSel 2100)];
		if (_selectedFactory isEqualTo "") exitwith {[localize"STR_ADMIN_NOFACTORYSELECTED","red"] call A3PL_Player_Notification;};
		_selectedAsset = lbData [1501,(lbCurSel 1501)];

		if ((lbCurSel 1501) < 0) exitwith {[localize"STR_ADMIN_NOTHINGSELECTED","red"] call A3PL_Player_Notification;};
		_selectedPlayer = A3PL_Admin_PlayerList select (lbCurSel 1500);

		if (_selectedFactory isEqualTo "Objects") exitWith {
			_obj = objNull;
			_playerPos = getPos _selectedPlayer;
			if(_selectedAsset isEqualTo "Land_A3PL_EstateSignRented") then {
				_obj = createvehicle ["Land_A3PL_EstateSign",_playerPos, [], 0, "CAN_COLLIDE"];
				_obj setObjectTextureGlobal [0,"\A3PL_Objects\Street\estate_sign\house_rented_co.paa"];
			} else {
				_obj = createvehicle [_selectedAsset,_playerPos, [], 0, "CAN_COLLIDE"];
			};
			_obj setVariable["owner","ADMIN",true];
			[player,"objects",[format ["Object Spawn: %1 AT %2",_selectedAsset,_playerPos]]] remoteExec ["Server_AdminLoginsert", 2];
		};

		if (_selectedFactory isEqualTo "AdminVehicles") exitWith {
			_playerPos = getPos _selectedPlayer;
			[_selectedAsset,_playerPos,"ADMIN",player] remoteExec ["Server_Vehicle_Spawn",2];
			[player,"vehicles",[format ["VehicleSpawn: %1 AT %2",_selectedAsset,_playerPos]]] remoteExec ["Server_AdminLoginsert", 2];
		};

		_control = _display displayCtrl 1403;
		_amount = parseNumber (ctrlText _control);
		if (_amount < 1) exitwith {[localize"STR_Various_INVALIDAMOUNT","red"] call A3PL_Player_Notification;};

		[_selectedPlayer,[_selectedAsset,_amount],_selectedFactory] remoteExec ["Server_Factory_Create", 2];
		_itemName = lbText [1501,(lbCurSel 1501)];
		[format[localize"STR_ADMIN_CREATEONPLAYER",_amount,_itemName,_selectedFactory,_selectedPlayer getVariable ["name","inconnu"]],"green"] call A3PL_Player_Notification;
		[player,"factories",[format ["RecipeCreated: %1 CREATED FOR %2(%3) (%4)",_selectedAsset,_selectedPlayer getVariable ["name","Undefined"],(getPlayerUID _selectedPlayer),_selectedFactory]]] remoteExec ["Server_AdminLoginsert", 2];
	} else {
		[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Admin_RemoveItem", {
	if ((player getVariable "dbVar_AdminLevel") >= 1) then {
		_display = findDisplay 98;
		_selectedPlayerIndex = lbCurSel 1500;
		_selectedInventory = lbText [2101,lbCurSel 2101];
		if(_selectedInventory isEqualTo "") exitWith {};
		_selectedPlayer = (A3PL_Admin_PlayerList select _selectedPlayerIndex);
		_playerInventories = _selectedPlayer getVariable ["player_fstorage",[]];

		_selectedItem = lbData [1502,lbCurSel 1502];
		if(_selectedItem isEqualTo "") exitWith {};
		_selectedItemAmount = lbValue [1502,lbCurSel 1502];

		_control = _display displayCtrl 1403;
		_amount = parseNumber (ctrlText _control);
		if (_amount < 1) exitwith {[localize"STR_Various_INVALIDAMOUNT","red"] call A3PL_Player_Notification;};
		if (_amount > _selectedItemAmount) exitWith{["There is not that amount to remove","red"] call A3PL_Player_Notification;};

		if (_selectedInventory isEqualTo localize"STR_ADMIN_PLAYER") then {
			[_selectedItem,-(_amount)] remoteExec ["A3PL_Inventory_Add",_selectedPlayer];
			[format["You removed %1x %2 from %3's inventory",_amount,[_selectedItem,"name"] call A3PL_Config_GetItem,_selectedPlayer getVariable["name","unknown"]]] call A3PL_Player_Notification;
		} else {
			[_selectedPlayer,_selectedInventory,[_selectedItem,-(_amount)],false] remoteExec ["Server_Factory_Add", 2];
			[format["You removed %1x %2 from %3's %4",_amount,[_selectedItem,"name"] call A3PL_Config_GetItem,_selectedPlayer getVariable["name","unknown"],_selectedInventory]] call A3PL_Player_Notification;
		};
		closeDialog 0;
	} else {
		[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_AdminHealPlayer", {
	if ((player getVariable "dbVar_AdminLevel") >= 1) then {
		_target = (A3PL_Admin_PlayerList select (lbCurSel 1500));
		if(!(_target getVariable["A3PL_Medical_Alive",true])) then {closeDialog 0;};
		_target setVariable ["A3PL_Medical_Alive",true,true];
		_target setVariable ["A3PL_Wounds",[],true];
		_target setVariable ["A3PL_Medical_Blood",5000,true];
		_target setDamage 0;
		[player,"admin_heal",[format ["Healing %1",name _target]]] remoteExec ["Server_AdminLoginsert", 2];
	} else {
		[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Admin_Freeze", {
	private _selectedPlayer = (A3PL_Admin_PlayerList select (lbCurSel 1500));
	[] remoteExec ["A3PL_Admin_UserInputCheck",_selectedPlayer];
	[player,"admin_freeze",[format ["Freeze %1",name _selectedPlayer]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_Admin_UserInputCheck", {
	if(getPlayerUID player IN ["76561198111737316","76561198343727655"]) exitWith {};
	if (!userInputDisabled) then {disableUserInput true;} else {disableUserInput false;};
}] call Server_Setup_Compile;

["A3PL_AdminRedName", {
	if (player getVariable ["pVar_RedNameOn",false]) then {
		player setVariable ["pVar_RedNameOn",false,true];
		player enableStamina true;
	} else {
		player setDamage 0;
		player setVariable ["pVar_RedNameOn",true,true];
		player setVariable ["A3PL_Wounds",[],true];
		player setVariable ["A3PL_Medical_Blood",5000,true];
		player enableStamina false;
	};
	[player,"admin_mode",[player getVariable ["pVar_RedNameOn",false]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminFastAnimation", {
	if (pVar_FastAnimationOn) then {
		player setAnimSpeedCoef 1;
		pVar_FastAnimationOn = false;
		lbSetColor [1504, 7, [1,1,1,1]];
	} else {
		player setAnimSpeedCoef 2.5;
		pVar_FastAnimationOn = true;
		lbSetColor [1504, 7, [1,.8,0,1]];
	};
}] call Server_Setup_Compile;

["A3PL_AdminSelfFeed", {
	Player_Hunger = 100;
	Player_Thirst = 100;
	Player_Alcohol = 0;
	profileNamespace setVariable ["player_hunger",Player_Hunger];
	profileNamespace setVariable ["player_thirst",Player_Thirst];
	profileNamespace setVariable ["player_alcohol",Player_Alcohol];
}] call Server_Setup_Compile;

["A3PL_AdminTwitterToggle", {
	if(pVar_AdminTwitter) then {
		pVar_AdminTwitter = false;
		[localize "STR_ADMIN_TWITTEROFF","green"] call A3PL_Player_Notification;
	} else {
		pVar_AdminTwitter = true;
		[localize "STR_ADMIN_TWITTERON","green"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_AdminTeleportTo", {
	if !("Teleport" IN (player getVariable ["dbVar_AdminPerms",[]])) exitWith {[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;};

	_display = findDisplay 98; if(isNull _display) exitWith {};
	_id = lbCurSel 1500;

	if(_id < 0) exitWith {};
	_target = (A3PL_Admin_PlayerList select _id);
	player setPos (getPos _target);

	[player,"players",[format ["TeleTo: %1(%2) FROM %3 TO %4",_target getVariable ["name","Undefined"],(getPlayerUID _target),(getPos player),(getPos _target)]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminTeleportToMe", {
	if !("Teleport" IN (player getVariable ["dbVar_AdminPerms",[]])) exitWith {[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;};

	_display = findDisplay 98; if(isNull _display) exitWith {};
	_id = lbCurSel 1500;

	if(_id < 0) exitWith {};
	_target = (A3PL_Admin_PlayerList select _id);
	_target setPos (getPos player);

	[player,"players",[format ["TeleToMe: %1(%2) FROM %3 TO %4",_target getVariable ["name","Undefined"],(getPlayerUID _target),(getPos _target),(getPos player)]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminMapTeleport", {
	if ("Teleport" IN (player getVariable ["dbVar_AdminPerms",[]])) then {
		closeDialog 0;
		lbSetColor [1504, 1, [1,.8,0,1]];
		pVar_MapTeleportReady = true;
		onMapSingleClick "_currentPos = getPos player;
		(vehicle player) setpos _pos;
		[player,""mapteleporting"",[format [""MapTeleport: FROM %1 TO %2"",_currentPos,_pos]]] remoteExec [""Server_AdminLoginsert"", 2];
		onMapSingleClick """";
		openMap false;
		pVar_MapTeleportReady = false;";
		openMap true;

	} else {
		[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_AdminGlobalMessage", {
	private _display = findDisplay 69;
	private _message = ctrlText 1402;
	private _thisAdmin = player getVariable ["name",""];
	if(_message isEqualTo "") exitWith {[localize"STR_ADMIN_ENTERMESSAGE", "red"] call A3PL_Player_Notification;};
	[format[localize"STR_ADMIN_GLOBALMESSAGE",_thisAdmin,_message],"yellow"] remoteExec ["A3PL_Player_Notification", -2];
	[player,"globalmessage",[format ["GlobalMessage: %1",_message]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminAdminMessage", {
	private _display = findDisplay 69;
	private _message = ctrlText 1402;
	private _sendTo = [];
	private _thisAdmin = player getVariable ["name",""];
	{
		if ((_x getVariable ["dbVar_AdminLevel",0]) > 0) then {_sendTo pushBack _x;};
	} forEach A3PL_Admin_PlayerList;
	if(_message isEqualTo "") exitWith {[localize"STR_ADMIN_ENTERMESSAGE", "red"] call A3PL_Player_Notification;};
	[format[localize"STR_ADMIN_ADMINMESSAGE",_thisAdmin,_message],"yellow"] remoteExec ["A3PL_Player_Notification", _sendTo];
	[player,"adminmessage",[format ["AdminMessage: %1",_message]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminDirectMessage", {
	private _display = findDisplay 69;
	private _message = ctrlText 1402;
	private _selectedIndex = lbCurSel 1500;
	private _target = (A3PL_Admin_PlayerList select _selectedIndex);
	private _thisAdmin = player getVariable ["name",""];
	if(_message isEqualTo "") exitWith {[localize"STR_ADMIN_ENTERMESSAGE", "red"] call A3PL_Player_Notification;};
	[format[localize"STR_ADMIN_DIRECTMESSAGE",_thisAdmin,_message],"yellow"] remoteExec ["A3PL_Player_Notification", _target];
	[player,"directmessage",[format ["DirectMessage: %1",_message]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminVehicleMarkers", {
	if(pVar_MapVehicleMarkersOn) then {
		pVar_MapVehicleMarkersOn = false;
		A3PL_Admin_VehMarkersEnabled = false;
		lbSetColor [1504, 11, [1,1,1,1]];
	} else {
		pVar_MapVehicleMarkersOn = true;
		lbSetColor [1504, 11, [1,.8,0,1]];
		A3PL_Admin_VehMarkersEnabled = true;
		[] spawn
		{
			_vehMarkers = [];
			_blacklist = ["A3PL_EMS_Locker","A3PL_WheelieBin","A3PL_DogCage","A3PL_Gas_Hose","A3PL_Gas_Box","Land_CampingTable_small_f","A3PL_MobileCrane","Box_NATO_Equip_F","B_supplyCrate_F","Land_ToolTrolley_02_F"];
			while {A3PL_Admin_VehMarkersEnabled} do
			{
				sleep 0.5;
				if(visibleMap) then
				{
					_vehicles = player nearEntities [["Car", "Ship", "Tank", "Air", "Plane", "Thing"], 50000];
					{
						if(!((typeOf _x) IN _blacklist)) then {
							_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
							_marker setMarkerColorLocal "ColorBlue";
							_marker setMarkerTypeLocal "Mil_dot";
							_marker setMarkerSizeLocal [0.5, 0.5];
							_marker setMarkerAlphaLocal 1;
							_marker setMarkerTextLocal format[" %1", getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName")];
							_vehMarkers pushBack [_marker,_x];
						};
					} foreach _vehicles;
					while {visibleMap} do
					{
						{
							private _marker = _x select 0;
							private _veh = _x select 1;
							if(!isNil "_veh") then
							{
								if(!isNull _veh) then
								{
								    _marker setMarkerPosLocal (visiblePosition _veh);
								};
							};
						} foreach _vehMarkers;
						if(!visibleMap) exitWith {};
						sleep 0.02;
					};
					{deleteMarkerLocal (_x select 0);} foreach _vehMarkers;
					_vehMarkers = [];
				};
			};
		};
	};
	[player,"AdminVehicleMarkers",[A3PL_Admin_VehMarkersEnabled]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminMapMarkers", {
	if(pVar_MapPlayerMarkersOn) then
	{
		pVar_MapPlayerMarkersOn = false;
		A3PL_Admin_MapMarkersEnabled = false;
		lbSetColor [1504, 11, [1,1,1,1]];
	} else {
		pVar_MapPlayerMarkersOn = true;
		lbSetColor [1504, 11, [1,.8,0,1]];
		A3PL_Admin_MapMarkersEnabled = true;
		[] spawn
		{
			_playerMarkers = [];
			while {A3PL_Admin_MapMarkersEnabled} do
			{
				sleep 0.5;
				if(visibleMap) then
				{
					{
						private _pos = visiblePosition _x;
						private _text = format[" (%1) %2", _x getVariable["name","ERROR"], name _x];
						_marker = createMarkerLocal [format["%1_marker",_x],_pos];
						_marker setMarkerColorLocal "ColorYellow";
						_marker setMarkerTypeLocal "Mil_dot";
						_marker setMarkerSizeLocal [0.5, 0.5];
						_marker setMarkerAlphaLocal 1;
						_marker setMarkerTextLocal _text;
						_playerMarkers pushBack [_marker,_x];
					} foreach (allPlayers - [player]);
					while {visibleMap} do
					{
						{
							private["_marker","_unit"];
							_marker = _x select 0;
							_unit = _x select 1;
							if(!isNil "_unit") then
							{
								if(!isNull _unit) then
								{
								    _marker setMarkerPosLocal (visiblePosition _unit);
								};
							};
						} foreach _playerMarkers;
						if(!visibleMap) exitWith {};
						sleep 0.02;
					};
					{deleteMarkerLocal (_x select 0);} foreach _playerMarkers;
					_playerMarkers = [];
				};
			};
		};
	};
	[player,"mapmarkers",[A3PL_Admin_MapMarkersEnabled]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminRessourcesMarkers", {
	if(pVar_RessourcesMarkersOn) then {
		pVar_RessourcesMarkersOn = false;
		A3PL_Admin_RessourcesMarkersEnabled = false;
		lbSetColor [1504, 13, [1,1,1,1]];
	} else {
		pVar_RessourcesMarkersOn = true;
		lbSetColor [1504, 13, [1,.8,0,1]];
		A3PL_Admin_RessourcesMarkersEnabled = true;
		[] spawn
		{
			_markers = [];
			while {A3PL_Admin_RessourcesMarkersEnabled} do
			{
				uiSleep 0.5;
				if(visibleMap) then
				{
					{
						private ["_pos","_amount","_id"];
						_pos = _x select 0;
						_amount = _x select 1;
						_id = floor (random 5000);
						_marker = createMarkerLocal [format["%1_marker",_id],_pos];
						_marker setMarkerShapeLocal "ELLIPSE";
						_marker setMarkerSizeLocal [100,100];
						_marker setMarkerColorLocal "ColorBlue";
						_marker setMarkerTypeLocal "Mil_dot";
						_marker setMarkerAlphaLocal 0.5;
						_markers pushBack _marker;

						_id = floor (random 5000);
						_marker = createMarkerLocal [format["%1_marker",_id],_pos];
						_marker setMarkerShapeLocal "ICON";
						_marker setMarkerColorLocal "ColorBlue";
						_marker setMarkerTypeLocal "Mil_dot";
						_marker setMarkerTextLocal format ["OIL: %1 gallons",([_pos] call A3PL_JobWildcat_CheckAmountOil)];
						_markers pushBack _marker;
					} foreach (missionNameSpace getVariable ["Server_JobWildCat_Oil",[]]);

					{
						private ["_pos","_amount","_id","_name"];
						_pos = _x select 1;
						_name = _x select 0;
						_amount = _x select 2;
						_id = floor (random 5000);
						_marker = createMarkerLocal [format["%1_marker",_id],_pos];
						_marker setMarkerShapeLocal "ELLIPSE";
						_marker setMarkerSizeLocal [100,100];
						_marker setMarkerColorLocal "ColorYellow";
						_marker setMarkerTypeLocal "Mil_dot";
						_marker setMarkerAlphaLocal 0.85;
						_markers pushBack _marker;

						_id = floor (random 5000);
						_marker = createMarkerLocal [format["%1_marker",_id],_pos];
						_marker setMarkerShapeLocal "ICON";
						_marker setMarkerColorLocal "ColorYellow";
						_marker setMarkerTypeLocal "Mil_dot";
						_marker setMarkerTextLocal format ["Resource: %1 (%2 left)",_name,_amount];
						_markers pushBack _marker;
					} foreach (missionNameSpace getVariable ["Server_JobWildCat_Res",[]]);
					waitUntil{!visibleMap};
					{deleteMarkerLocal (_x);} foreach _markers;
					_markers = [];
				};
			};
		};
	};
}] call Server_Setup_Compile;

["A3PL_Admin_ViewStats", {
	_message = "There is :";
	_message = _message + format["<br/>%1 players", count(AllPlayers)];
	_message = _message + format["<br/>%1 %2", count(["fisd"] call A3PL_Lib_FactionPlayers), "FISD"];
	_message = _message + format["<br/>%1 %2", count(["fifr"] call A3PL_Lib_FactionPlayers), "FIFR"];
	_message = _message + format["<br/>%1 %2", count(["uscg"] call A3PL_Lib_FactionPlayers), "USCG"];
	_message = _message + format["<br/>%1 %2", count(["fims"] call A3PL_Lib_FactionPlayers), "FIMS"];
	_message = _message + format["<br/>%1 %2", count(["doj"] call A3PL_Lib_FactionPlayers), "DOJ"];
	[_message,"pink"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Admin_PauseCheckReturn", {
	params [["_looping", false]];
	if (!_looping) then {
		lbSetColor [1504, 5, [1,.8,0,1]];
	} else {
		lbSetColor [1504, 5, [1,1,1,1]];
	};
	pVar_FiresFrozen = _looping;
}] call Server_Setup_Compile;

["A3PL_Admin_CreateFire", {
	[getPosATL player] call A3PL_Fire_StartFire;
	[player,"admin_fire",[format ["CreateFire @ %1",getpos player]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_Admin_PauseFire", {
	if (pVar_FiresFrozen) then {
		lbSetColor [1504, 5, [1,.8,0,1]];
		pVar_FiresFrozen = false;
	} else {
		lbSetColor [1504, 5, [1,1,1,1]];
		pVar_FiresFrozen = true;
	};
	[] remoteExec ["Server_Fire_PauseFire", 2];
	[player,"admin_pausefire",["Pause Fire"]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_Admin_RemoveFire", {
	[] remoteExec ["Server_Fire_RemoveFires", 2];
	[player,"admin_reemovefire",["Remove Fire"]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_Admin_Debug", {
	disableSerialization;
	createDialog "Dialog_AdminDebug";
	private _display = findDisplay 82;
	private _control = _display displayCtrl 1600;
	_control ctrlAddEventHandler ["buttonDown",
	{
		call compile (ctrlText 1400);
	}];
},false,true] call Server_Setup_Compile;

["A3PL_Admin_Invisible", {
	if(player getVariable ["admin_invisible",false]) then {
		[player,false] remoteExec ["A3PL_Lib_HideObject", 2];
		player setVariable ["admin_invisible",false,true];
	} else {
		[player,true] remoteExec ["A3PL_Lib_HideObject", 2];
		player setVariable ["admin_invisible",true,true];
	};
}] call Server_Setup_Compile;

["A3PL_Admin_EjectAll",
{
	private _car = _this select 0;
	private _pass = crew _car;
	{_x action ["getOut", _car];} foreach _pass;
}] call Server_Setup_Compile;

["A3PL_Debug_Open", {
	disableSerialization;
	createDialog "Dialog_DeveloperDebug";

	call A3PL_Debug_DropDownList;
	call A3PL_Debug_OnLoadVarCheck;
	call A3PL_Debug_VarCheckLoop;

	(findDisplay 155) displayAddEventHandler ["Unload","call A3PL_Debug_OnUnloadVarCheck"];
}] call Server_Setup_Compile;

["A3PL_Debug_DropDownList", {
	private _display = findDisplay 155;
	private _dropDownList = ["Server","Global","All Clients","Local"];
	{lbAdd [2100,_x];} forEach _dropDownList;
}] call Server_Setup_Compile;

["A3PL_Debug_OnLoadVarCheck", {
	private _display = findDisplay 155;
	private _activeNamespaces = [[1400,"A3PL_Debug_Main"]];
	{
		ctrlSetText [_x select 0,profileNamespace getVariable [_x select 1,localize"STR_ADMIN_NOTHINGFORTHEMOMENT"]];
	} forEach _activeNamespaces;
}] call Server_Setup_Compile;

["A3PL_Debug_OnUnloadVarCheck", {
	private _display = findDisplay 155;
	private _activeNamespaces = [[1400,"A3PL_Debug_Main"]];
	{
		_varCheck = ctrlText (_x select 0);
		profileNamespace setVariable [_x select 1,_varCheck];
	} forEach _activeNamespaces;
}] call Server_Setup_Compile;

//Compile BLOCK warning
["A3PL_Debug_Execute", {

	private _bannedText = ["profileNamespace","saveProfileNamespace","fuckedS","files"];
	private _display = findDisplay 155;
	private _debugText = ctrlText 1400;
	private _chosenExecType = lbText [2100,lbCurSel 2100];
	private _remoteExecType = clientOwner;
	private _forbidden = false;

	switch (_chosenExecType) do {
		case "Server": {_remoteExecType = 2};
		case "Global": {_remoteExecType = 0};
		case "All Clients": {_remoteExecType = -2};
		case "Local": {_remoteExecType = clientOwner};
		default {_remoteExecType = clientOwner};
	};

	{
		if((_debugText find _x) != -1) exitWith {_forbidden = true;};
	} forEach _bannedText;

	if(_forbidden) exitWith {};

	[_debugText] remoteExec ["A3PL_Debug_ExecuteCompiled",_remoteExecType];
	[player,"DebugExecuted",[format ["Debug: %1 Type: %2",_debugText, _chosenExecType]]] remoteExec ["Server_AdminLoginsert", 2];
},false,true] call Server_Setup_Compile;

["A3PL_Debug_ExecuteCompiled", {
	private ["_debugText"];
	_debugText = param [0,"Nothing"];
	if (_debugText == "Nothing") exitWith {};
	call compile _debugText;
},false,true] call Server_Setup_Compile;

["A3PL_Admin_TakeGear", {
	private _mode = param [0,false];
	private _fedGear = [[],[],[],["A3PL_FBI_Agent_Blue_Uniform",[]],["A3PL_FBI_Blue_Lite",[]],["A3PL_LR",[]],"A3PL_FBI_Ballcap","",[],["ItemMap","ItemGPS","A3PL_Cellphone_2","ItemCompass","ItemWatch",""]];
	private _prevGear = profileNamespace getVariable ["A3FL_PrevGear",nil];
	if(_mode) then {
		_prevGear = getUnitLoadout player;
		profileNamespace setVariable ["A3FL_PrevGear",_prevGear];
		player setUnitLoadout _fedGear;
	} else {
		if(!isNil "_prevGear") then {
			player setUnitLoadout _prevGear;
		} else {
			["Error: No previous gear saved.","pink"] call A3PL_Player_Notification;
		};
	};
}] call Server_Setup_Compile;