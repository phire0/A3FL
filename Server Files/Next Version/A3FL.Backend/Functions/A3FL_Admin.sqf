/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define factionsList [["Citizen of Fishers Island","citizen","unemployed"],["Fishers Island Sheriff Department","fisd","fisd"],["Fishers Island Fire and Rescue","fifr","fifr"],["Department Of Justice","doj","doj"],["Fishers Island Marshals Service","usms","usms"],["United States Coast Guard","uscg","uscg"],["Department Of Motor Vehicles","dmv","dmv"],["Fishers Island Cartel","cartel","cartel"],["Federal Bureau of Investigation","fbi","fbi"]]
#define adminTagsList [["Civilian Tag",["#B5B5B5","#ed7202","\A3PL_Common\icons\citizen.paa"]],["Executive Tag",["#B5B5B5","#8410ff","\A3PL_Common\icons\executive.paa"]],["Executive Supervisor Tag",["#B5B5B5","#5ab2ff","\A3PL_Common\icons\exec_supervisor.paa"]],["Developer Tag",["#B5B5B5","#FFFFFF","\A3PL_Common\icons\creator.paa"]],["Chief Tag",["#B5B5B5","#2f9baa","\A3PL_Common\icons\chief.paa"]],["Sub-Director Tag",["#B5B5B5","#ff6d29","\A3PL_Common\icons\subdirector.paa"]],["Director Tag",["#B5B5B5","#cece08","\A3PL_Common\icons\director.paa"]]]

["A3PL_Admin_Check",
{
	pVar_AdminMenuGranted = false;
	pVar_AdminTwitter = false;

	player setVariable ["pVar_RedNameOn",false,true];
	pVar_MapTeleportReady = false;
	pVar_MapPlayerMarkersOn = false;
	pVar_RessourcesMarkersOn = false;
	pVar_FastAnimationOn = false;
	pVar_FiresFrozen = false;

	pVar_AdminLevel = player getVariable ["dbVar_AdminLevel",0];
	if (pVar_AdminLevel == 0) exitwith {};

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
	private _title = "Admin";
	switch(_player getVariable["dbVar_AdminLevel",0]) do {
		case(0): {_title = "";};
		case(1): {_title = "Executive";};
		case(2): {_title = "Executive Supervisor";};
		case(3): {_title = "Developer";};
		case(5): {_title = "Chief";};
		case(6): {_title = "Sub-Director";};
		case(7): {_title = "Director";};
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
		["Level:", ["Player_Level",0]]
	];
	lbClear 1503;
	{
		_text = _x select 0;
		_data = _x select 1;
		switch(_data select 1) do {
			case 0: {lbAdd [1503, format ["%1 %2", _text, _selectedPlayer getVariable [(_data select 0),"Undefined"]]];};
			case 1: {lbAdd [1503, format ["%1 %2", _text,(_selectedPlayer getVariable [(_data select 0),-1]) call CBA_fnc_formatNumber]];};
			case 2: {lbAdd [1503, format ["%1 %2", _text, str(_selectedPlayer getVariable [(_data select 0),"Undefined"])]];};
			case 3: {lbAdd [1503, format ["%1 %2", _text, _data select 0]];};
		};
	} forEach _playerInfoArray;
}] call Server_Setup_Compile;

["A3PL_Admin_PlayerInventoryFill", {
	_display = findDisplay 98;
	_selectedIndex = lbCurSel 2101;
	_selectedPlayerIndex = lbCurSel 1500;
	_selectedInventory = lbText [2101,lbCurSel 2101];
	_selectedPlayer = (A3PL_Admin_PlayerList select _selectedPlayerIndex);
	_playerInventories = _selectedPlayer getVariable "player_fstorage";
	_index = 999;

	if (_selectedInventory == localize"STR_ADMIN_PLAYER") then {
		lbClear 1502;
		{
			lbAdd [1502,format ["%1 (%2)",_x select 0,str (_x select 1)]];
		} forEach (_selectedPlayer getVariable ["player_inventory",[]]);
	} else {
		{
			_checking = _x select 0;
			if (_checking == _selectedInventory) exitWith {_index = _forEachIndex;};
		} forEach _playerInventories;
		lbClear 1502;
		if (_index == 999) exitWith {lbAdd [1502,localize"STR_ADMIN_NOINVENTORY"]};
		_toLoadInventory = (_playerInventories select _index) select 1;
		{
				lbAdd [1502,format ["%1 (%2)",_x select 0,_x select 1]];
		} forEach _toLoadInventory;
	};
}] call Server_Setup_Compile;

["A3PL_AdminFactoryComboList", {
	_display = findDisplay 98;
	_control = _display displayCtrl 2100;

	{lbAdd [2100,_x select 0];} foreach Config_Factories;
	{lbAdd [2100,_x];} foreach ["Objects", "AdminVehicles"];
	_control ctrlAddEventHandler ["lbSelChanged",{call A3PL_AdminFillFactoryList;}];
}] call Server_Setup_Compile;

["A3PL_Admin_InventoryCombo", {
	private _display = findDisplay 98;
	_selectedInventory = _display displayCtrl 2101;
	_inventories = ["Player","Chemical Plant","Steel Mill","Oil Refinery","Goods Factory","Food Processing Plant","Vehicles Faction","Faction Weapons","Legal Weapon Factory","Marine Factory","Aircraft Factory","Car Parts Factory","Vehicle Factory","Clothing Factory","Vest Factory","Headgear Factory","Goggle Factory","Cocaine treatment","Illegal Weapon Factory"];
	{lbAdd [2101,_x];} foreach _inventories;
	_selectedInventory ctrlAddEventHandler ["lbSelChanged","call A3PL_Admin_PlayerInventoryFill;"];
}] call Server_Setup_Compile;

["A3PL_Admin_TwitterTagsCombo", {
	private _display = findDisplay 98;
	{lbAdd [2102, _x select 0];} foreach adminTagsList;
	(_display displayCtrl 2102) ctrlAddEventHandler ["lbSelChanged","call A3PL_Admin_SetTwitterTag;"];
}] call Server_Setup_Compile;

["A3PL_Admin_SetTwitterTag", {
	private _display = findDisplay 98;
	private _selectedTag = lbCurSel 2102;
	player setVariable["twitterTag",(adminTagsList select _selectedTag) select 1, true];
}] call Server_Setup_Compile;

["A3PL_Admin_FactionCombo", {
	private _display = findDisplay 98;
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
	_display = findDisplay 98;
	_control = _display displayCtrl 1504;
	_fullList = [
		["Teleport",pVar_MapTeleportReady,A3PL_AdminMapTeleport],
		["Toggle Twitter",false,A3PL_AdminTwitterToggle],
		["Fix Garage",false,A3PL_Admin_FixGarage],
		["Admin Mode",player getVariable ["pVar_RedNameOn",false],A3PL_AdminRedName],
		["Create Fire",false,A3PL_Admin_CreateFire],
		["Pause Fire",pVar_FiresFrozen,A3PL_Admin_PauseFire],
		["Remove Fire",false,A3PL_Admin_RemoveFire],
		["Fast Animation",pVar_FastAnimationOn,A3PL_AdminFastAnimation],
		["Self Heal",false,A3PL_AdminSelfHeal],
		["Self Feed",false,A3PL_AdminSelfFeed],
		["Freeze",false,A3PL_Admin_Freeze],
		["Player Markers",pVar_MapPlayerMarkersOn,A3PL_AdminMapMarkers],
		["Double EXP",false,A3PL_AdminEXP],
		["Double Harvest",false,A3PL_AdminHarvest],
		["1.5 Paychecks",false,A3PL_AdminPaychecks],
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
		case "Self Heal": {call A3PL_AdminSelfHeal};
		case "Self Feed": {call A3PL_AdminSelfFeed};
		case "Freeze": {call A3PL_Admin_Freeze};

		case "Player Markers": {call A3PL_AdminMapMarkers;};
		case "Double EXP": {[] remoteExec ["Server_Core_DblXP",2];};
		case "Double Harvest": {[] remoteExec ["Server_Core_DblHarvest",2];};
		case "1.5 Paychecks": {[] remoteExec ["Server_Core_PaycheckBonus",2];};

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

/*["A3PL_AdminRestartServer", {
	if ("Restart" IN (player getVariable ["dbVar_AdminPerms",[]])) then {
		_playerText = format["%1 players",count allPlayers];
		if((count allPlayers) < 2) then {
			_playerText = format["%1 player",count allPlayers];
		};
		_action = [format["Are you sure you want <t color='#FF4000'>restart</t> the <t color='#FF4000'>official server</t> with <t color='#FF4000'>%1</t> connected ?<br/>",_playerText],
			"Restart","Yes","No"
		] call BIS_fnc_guiMessage;
		if (!isNil "_action" && (_action)) then {
			[] remoteExec ["Server_Core_Restart",2];
			[player,"admin_restart",[format ["Restart"]]] remoteExec ["Server_AdminLoginsert", 2];
		};
	} else {
		[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_AdminBanPlayer", {
	if ("Ban" IN (player getVariable ["dbVar_AdminPerms",[]])) then {
		_selectedIndex = lbCurSel 1500;
		_selectedPlayer = (A3PL_Admin_PlayerList select _selectedIndex);
		_uid = getPlayerUID _selectedPlayer;
		_action = [format["Are you sure you want to ban <t color='#FF4000'>permanantly</t> <t color='#FF4000'>%1</t> from the server ?<br/>",name _selectedPlayer],
			"Ban (Perm)","Yes","No"
		] call BIS_fnc_guiMessage;
		if (!isNil "_action" && (_action)) then {
			[_uid] remoteExec ["Server_Core_BanPlayer",2];
			[player,"admin_ban",[format ["Ban %1",name _selectedPlayer]]] remoteExec ["Server_AdminLoginsert", 2];
		};
	} else {
		[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_AdminKickPlayer", {
	if ("Kick" IN (player getVariable ["dbVar_AdminPerms",[]])) then {
		_selectedIndex = lbCurSel 1500;
		_selectedPlayer = (A3PL_Admin_PlayerList select _selectedIndex);
		_uid = getPlayerUID _selectedPlayer;
		closeDialog 0;
		_action = [
	        format["Are you sure you want to kick <t color='#FF4000'>%1</t> from the server ?<br/>",name _selectedPlayer],
	        "Kick","Yes","No"
	    ] call BIS_fnc_guiMessage;
		if (!isNil "_action" && (_action)) then {
			[_uid] remoteExec ["Server_Core_KickPlayer",2];
			[player,"admin_kick",[format ["Kick %1",name _selectedPlayer]]] remoteExec ["Server_AdminLoginsert", 2];
		};
	} else {
		[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;*/

["A3PL_Admin_FixGarage", {
	if (player_objIntersect getVariable ["inUse",false]) then {player_objIntersect setVariable ["inUse",false,true];};
}] call Server_Setup_Compile;

["A3PL_Admin_Camera", {
	closeDialog 0;
	["Init"] call BIS_fnc_camera;
}] call Server_Setup_Compile;

["A3PL_Admin_Mayor",{[] remoteExec ['Server_Government_StartVote', 2];}] call Server_Setup_Compile;

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
	if (_selectedFactory == "Objects" || _selectedFactory == "AdminVehicles") then {
		if (_selectedFactory == "AdminVehicles") exitWith {
			{
				_first_X = _x;
				{
					_class = format ["%1_%2",(_first_X select 0),_x];
					_i = lbAdd [1501,_class];
					lbSetData [1501,_i,_class];
				} foreach (_x select 1);
			} forEach Config_Vehicles_Admin;
		};

		if (_selectedFactory == "Objects") exitWith {
			{
				_class = _x;
				_i = lbAdd [1501,_class];
				lbSetData [1501,_i,_class];
			} forEach ["Land_A3PL_BusinessSign","Land_A3PL_EstateSign","Land_A3PL_EstateSignRented","Land_A3PL_FireHydrant","Land_PortableLight_double_F","Land_Device_slingloadable_F","PortableHelipadLight_01_yellow_F","Land_Pipes_large_F","Land_Tribune_F","Land_RampConcrete_F","Land_Crash_barrier_F","Land_GH_Stairs_F","RoadCone_L_F","RoadBarrier_F","RoadBarrier_small_F","Land_Razorwire_F"];
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
	((uiNamespace getVariable "Dialog_HUD_AdminCursor") displayCtrl 2414) ctrlSetStructuredText (parseText format["<t font='PuristaSemiBold' align='left' size='0.85'>Numpad 0: Driver<br/>Numpad 1: Attach<br/>Numpad 2: Detach<br/>Numpad 3: Impound<br/>Numpad 4: Delete<br/>Numpad 5: Move<br/>Numpad 6: Eject passangers<br/>Numpad 7: Heal<br/>Numpad 8: Repair</t>"]);

	while {pVar_CursorTargetEnabled} do {
		((uiNamespace getVariable "Dialog_HUD_AdminCursor") displayCtrl 1000) ctrlSetStructuredText (parseText format["<t font='PuristaSemiBold' align='center' size='1'>Cursor: %1</t>",(name cursorObject)]);
	};
	("Dialog_HUD_AdminCursor" call BIS_fnc_rscLayer) cutFadeOut 1;
}] call Server_Setup_Compile;

["A3PL_Admin_AttachTo", {
	params[["_veh",objNull,[objNull]]];
	_dir = getDir _veh;
	_veh attachTo [player];
	_veh setDir (_dir + (360 - (getDir player)));
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
					_class = _x;
					_i = lbAdd [1501,_class];
					lbSetData [1501,_i,_class];
				} foreach ["Land_A3PL_BusinessSign","Land_A3PL_EstateSign","Land_A3PL_EstateSignRented","Land_A3PL_FireHydrant","Land_PortableLight_double_F","Land_Device_slingloadable_F","PortableHelipadLight_01_yellow_F","Land_Pipes_large_F","Land_Tribune_F","Land_RampConcrete_F","Land_Crash_barrier_F","Land_GH_Stairs_F","RoadCone_L_F","RoadBarrier_F","RoadBarrier_small_F","Land_Razorwire_F"];
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

		if (_selectedFactory == "Objects" || _selectedFactory == "AdminVehicles") then {
			if (_selectedFactory == "Objects") exitWith {
				{
					_name = _x;
					if ((_name find _text) != -1) then {
						_class = _x;
						_i = lbAdd [1501,_class];
						lbSetData [1501,_i,_class];
					};
				} foreach ["Land_A3PL_BusinessSign","Land_A3PL_EstateSign","Land_A3PL_EstateSignRented","Land_A3PL_FireHydrant","Land_PortableLight_double_F","Land_Device_slingloadable_F","PortableHelipadLight_01_yellow_F","Land_Pipes_large_F","Land_Tribune_F","Land_RampConcrete_F","Land_Crash_barrier_F","Land_GH_Stairs_F","RoadCone_L_F","RoadBarrier_F","RoadBarrier_small_F","Land_Razorwire_F"];
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

["A3PL_AdminCreateOnPlayer", {
	if ((player getVariable "dbVar_AdminLevel") >= 1) then {
		_selectedList = lbCurSel 2100;
		_selectedListText = lbText [2100,_selectedList];

		if (_selectedListText isEqualTo "Objects") exitWith {
			_selectedIndex = lbCurSel 1500;
			_selectedPlayer = (A3PL_Admin_PlayerList select _selectedIndex);
			_selectedObject = lbCurSel 1501;
			_objectClass = lbData [1501, _selectedObject];
			_playerPos = getPos _selectedPlayer;

			if(_objectClass isEqualTo "Land_A3PL_EstateSignRented") then {
				_obj = createvehicle ["Land_A3PL_EstateSign",_playerPos, [], 0, "CAN_COLLIDE"];
				_obj setObjectTextureGlobal [0,"\A3PL_Objects\Street\estate_sign\house_rented_co.paa"];
			} else {
				_obj = createvehicle [_objectClass,_playerPos, [], 0, "CAN_COLLIDE"];
			};
			[player,"objects",[format ["Object Spawn: %1 AT %2",_objectClass,_playerPos]]] remoteExec ["Server_AdminLoginsert", 2];
		};

		if (_selectedListText == "AdminVehicles") exitWith {
			_selectedIndex = lbCurSel 1500;
			_selectedPlayer = (A3PL_Admin_PlayerList select _selectedIndex);
			_selectedObject = lbCurSel 1501;
			_objectClass = lbData [1501, _selectedObject];
			_playerPos = getPos _selectedPlayer;

			[_objectClass,_playerPos,"ADMIN",player] remoteExec ["Server_Vehicle_Spawn",2];
			[player,"vehicles",[format ["VehicleSpawn: %1 AT %2",_objectClass,_playerPos]]] remoteExec ["Server_AdminLoginsert", 2];
		};
	} else {
		[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_AdminAddToFactory", {
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
		_itemName = [_selectedAsset,"name"] call A3PL_Config_GetItem;
		[format[localize"STR_ADMIN_ADDEDTOFACTORY",_amount,_itemName,_selectedFactory,_selectedPlayer getVariable ["name","inconnu"]],"green"] call A3PL_Player_Notification;

		[player,"factories",[format ["AddFactory: %5 %1(s) ADDED TO %2(%3) (%4)",_selectedAsset,_selectedPlayer getVariable ["name","Undefined"],(getPlayerUID _selectedPlayer),_selectedFactory,_amount]]] remoteExec ["Server_AdminLoginsert", 2];
	} else {
		[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_AdminAddToPlayer", {
	if ((player getVariable "dbVar_AdminLevel") >= 1) then {
		private ["_display","_control","_type","_player","_recipe"];
		_display = findDisplay 98;

		_selectedFactory = lbText [2100,(lbCurSel 2100)];
		if (_selectedFactory == "") exitwith {[localize"STR_ADMIN_NOFACTORYSELECTED","red"] call A3PL_Player_Notification;};
		_selectedAsset = lbData [1501,(lbCurSel 1501)];

		if ((lbCurSel 1501) < 0) exitwith {[localize"STR_ADMIN_NOTHINGSELECTED","red"] call A3PL_Player_Notification;};
		_selectedPlayer = A3PL_Admin_PlayerList select (lbCurSel 1500);

		_control = _display displayCtrl 1403;
		_amount = parseNumber (ctrlText _control);
		if (_amount < 1) exitwith {[localize"STR_Various_INVALIDAMOUNT","red"] call A3PL_Player_Notification;};

		[_selectedPlayer,[_selectedAsset,_amount],_selectedFactory] remoteExec ["Server_Factory_Create", 2];
		_itemName = [_selectedAsset,"name"] call A3PL_Config_GetItem;
		[format[localize"STR_ADMIN_CREATEONPLAYER",_amount,_itemName,_selectedFactory,_selectedPlayer getVariable ["name","inconnu"]],"green"] call A3PL_Player_Notification;
		[player,"factories",[format ["RecipeCreated: %1 CREATED FOR %2(%3) (%4)",_selectedAsset,_selectedPlayer getVariable ["name","Undefined"],(getPlayerUID _selectedPlayer),_selectedFactory]]] remoteExec ["Server_AdminLoginsert", 2];
	} else {
		[localize"STR_ADMIN_YOUDONTHAVEPERMISSIONTOEXECUTETHISCOMMAND"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_AdminHealPlayer", {
	if ((player getVariable "dbVar_AdminLevel") >= 1) then {
		_target = (A3PL_Admin_PlayerList select (lbCurSel 1500));
		_target setVariable ["A3PL_Medical_Alive",true,true];
		_target setVariable ["A3PL_Wounds",[],true];
		_target setVariable ["A3PL_MedicalVars",[5000,"120/80",37],true];
		[player,"admin_heal",[format ["Soins %1",name _target]]] remoteExec ["Server_AdminLoginsert", 2];
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
	} else {
		player setVariable ["pVar_RedNameOn",true,true];
		player setVariable ["A3PL_Wounds",[],true];
		player setVariable ["A3PL_MedicalVars",[5000,"120/80",37],true];
		Player_Hunger = 100;
		Player_Thirst = 100;
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

["A3PL_AdminSelfHeal", {
	player setVariable ["A3PL_Medical_Alive",true,true];
	player setVariable ["A3PL_Wounds",[],true];
	player setVariable ["A3PL_MedicalVars",[5000,"120/80",37],true];
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
	_display = findDisplay 69;
	_message = ctrlText 1402;
	_thisAdmin = player getVariable ["name",""];
	if(_message == "") exitWith {[localize"STR_ADMIN_ENTERMESSAGE", "red"] call A3PL_Player_Notification;};

	[format[localize"STR_ADMIN_GLOBALMESSAGE",_thisAdmin,_message],"yellow"] remoteExec ["A3PL_Player_Notification", -2];
	[player,"globalmessage",[format ["GlobalMessage: %1",_message]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminAdminMessage", {
	_display = findDisplay 69;
	_message = ctrlText 1402;
	_sendTo = [];
	_thisAdmin = player getVariable ["name",""];

	{
		if ((_x getVariable ["dbVar_AdminLevel",0]) > 0) then {_sendTo pushBack _x;};
	} forEach A3PL_Admin_PlayerList;
	if(_message == "") exitWith {[localize"STR_ADMIN_ENTERMESSAGE", "red"] call A3PL_Player_Notification;};
	[format[localize"STR_ADMIN_ADMINMESSAGE",_thisAdmin,_message],"yellow"] remoteExec ["A3PL_Player_Notification", _sendTo];
	[player,"adminmessage",[format ["AdminMessage: %1",_message]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminDirectMessage", {
	_display = findDisplay 69;
	_message = ctrlText 1402;
	_selectedIndex = lbCurSel 1500;
	_target = (A3PL_Admin_PlayerList select _selectedIndex);
	_thisAdmin = player getVariable ["name",""];

	if(_message == "") exitWith {[localize"STR_ADMIN_ENTERMESSAGE", "red"] call A3PL_Player_Notification;};

	[format[localize"STR_ADMIN_DIRECTMESSAGE",_thisAdmin,_message],"yellow"] remoteExec ["A3PL_Player_Notification", _target];

	[player,"directmessage",[format ["DirectMessage: %1",_message]]] remoteExec ["Server_AdminLoginsert", 2];
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
			_markers = [];
			_playerMarkers = [];
			while {A3PL_Admin_MapMarkersEnabled} do
			{
				sleep 0.5;
				if(visibleMap) then
				{
					{
						_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
						_marker setMarkerColorLocal "ColorYellow";
						_marker setMarkerTypeLocal "Mil_dot";
						_marker setMarkerSizeLocal [0.5, 0.5];
						_marker setMarkerAlphaLocal 1;
						_marker setMarkerTextLocal format[" (%1) %2", _x getVariable["name","ERROR"], name _x];
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
	if(pVar_RessourcesMarkersOn) then
	{
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
	_message = _message + format["<br/>%1 %2", count(["usms"] call A3PL_Lib_FactionPlayers), "FIMS"];
	_message = _message + format["<br/>%1 %2", count(["doj"] call A3PL_Lib_FactionPlayers), "DOJ"];
	_message = _message + format["<br/>%1 %2", count(["dmv"] call A3PL_Lib_FactionPlayers), "DMV"];
	_message = _message + format["<br/>%1 %2", count(["cartel"] call A3PL_Lib_FactionPlayers), "CARTEL"];
	[_message,"pink"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Admin_PauseCheckReturn", {
	params [["_looping", false]];
	if (!_looping) then {
		lbSetColor [1504, 8, [1,.8,0,1]];
	} else {
		lbSetColor [1504, 8, [1,1,1,1]];
	};
	pVar_FiresFrozen = _looping;
}] call Server_Setup_Compile;

["A3PL_Admin_CreateFire", {
	[getPosATL player] call A3PL_Fire_StartFire;
	[player,"admin_fire",[format ["CreateFire @ %1",getpos player]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_Admin_PauseFire", {
	if (pVar_FiresFrozen) then {
		lbSetColor [1504, 8, [1,.8,0,1]];
		pVar_FiresFrozen = false;
	} else {
		lbSetColor [1504, 8, [1,1,1,1]];
		pVar_FiresFrozen = true;
	};
	[] remoteExec ["Server_Fire_PauseFire", 2];
	[player,"admin_fire",["Pause Fire"]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_Admin_RemoveFire", {
	[] remoteExec ["Server_Fire_RemoveFires", 2];
	[player,"admin_fire",["Remove Fire"]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_Admin_Debug", {
	disableSerialization;
	private ["_display","_control"];
	createDialog "Dialog_AdminDebug";
	_display = findDisplay 82;
	_control = _display displayCtrl 1600;

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
	private ['_car','_pass'];
	_car = _this select 0;
	_pass = crew _car;
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
	private ["_display","_dropDownList"];
	_display = findDisplay 155;
	_dropDownList = ["Server","Global","All Clients","Local"];
	{lbAdd [2100,_x];} forEach _dropDownList;
}] call Server_Setup_Compile;

["A3PL_Debug_OnLoadVarCheck", {
	private ["_display","_activeNamespaces","_control"];
	_display = findDisplay 155;
	_activeNamespaces = [[1400,"A3PL_Debug_Main"]];

	{
		ctrlSetText [_x select 0,profileNamespace getVariable [_x select 1,localize"STR_ADMIN_NOTHINGFORTHEMOMENT"]];
	} forEach _activeNamespaces;
}] call Server_Setup_Compile;

["A3PL_Debug_OnUnloadVarCheck", {
	private ["_display","_activeNamespaces","_varCheck"];
	_display = findDisplay 155;
	_activeNamespaces = [[1400,"A3PL_Debug_Main"]];
	{
		_varCheck = ctrlText (_x select 0);
		profileNamespace setVariable [_x select 1,_varCheck];
	} forEach _activeNamespaces;
}] call Server_Setup_Compile;

//Compile BLOCK warning
["A3PL_Debug_Execute", {

	private ["_display","_debugText","_chosenExecType","_remoteExecType","_compileRdy"];
	_bannedText = ["profileNamespace","saveProfileNamespace","fuckedS","files"];
	_display = findDisplay 155;
	_debugText = ctrlText 1400;
	_chosenExecType = lbText [2100,lbCurSel 2100];
	_remoteExecType = clientOwner;
	_forbidden = false;

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
	[player,"DebugExecuted",[format ["Debug: %1 Type: %2",_debugText]]] remoteExec ["Server_AdminLoginsert", 2];
},false,true] call Server_Setup_Compile;

["A3PL_Debug_ExecuteCompiled", {
	private ["_debugText"];
	_debugText = param [0,"Nothing"];
	if (_debugText == "Nothing") exitWith {};
	call compile _debugText;
},false,true] call Server_Setup_Compile;

["A3PL_Admin_PerformanceTestIntersects",{
	{
		_name = (_x select 1);
		_limit = 0.01;
		_timeTaken = ((diag_codePerformance [(_x select 3), 0, 10000]) select 0);
		if(_timeTaken > _limit) then {
			diag_log format ["name: %1 - time: %2",_name,_timeTaken];
		}
	} forEach Config_IntersectArray;

}] call Server_Setup_Compile;

["A3PL_Admin_PerformanceTestIntersectsTotalTime",{
	_totalTime = 0;
	{
		_timeTaken = ((diag_codePerformance [(_x select 3), 0, 10000]) select 0);

		_totalTime = _timeTaken + _totalTime;
	} forEach Config_IntersectArray;

	diag_log format ["Time taken: %1",_totalTime];

}] call Server_Setup_Compile;
