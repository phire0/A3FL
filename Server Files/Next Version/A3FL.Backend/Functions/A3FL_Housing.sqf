["A3PL_Housing_VirtualOpen",
{
	disableSerialization;
	private ["_box","_display","_control"];
	_box = param [0,player_objintersect];
	if (isNull _box) exitwith {[localize"STR_NewHousing_1)"] call A3PL_Player_Notification;};

	if (player distance _box > 5 ) exitwith {["You are too far away from this box to open it!","red"] call A3PL_Player_Notification;};
	if (_box getVariable ["inuse",false]) exitwith {[localize"STR_NewHousing_2","red"] call A3PL_Player_Notification;};
	_box setVariable ["inuse",true,true];

	createDialog "Dialog_HouseVirtual";
	_display = findDisplay 37;

	A3PL_Housing_StorageBox = _box;
	_control = _display displayCtrl 1600;
	_control ctrlAddeventhandler ["ButtonDown",{[true] call A3PL_Housing_VirtualChange;}];
	_control = _display displayCtrl 1601;
	_control ctrlAddeventhandler ["ButtonDown",{[false] call A3PL_Housing_VirtualChange;}];

	_display displayAddEventHandler ["unload",{A3PL_Housing_StorageBox setVariable ["inuse",nil,true]; A3PL_Housing_StorageBox = nil;}];

	[_display,_box] call A3PL_Housing_VirtualFillLB;
}] call Server_Setup_Compile;

["A3PL_Housing_VirtualFillLB",
{
	private ["_display","_control"];
	_display = param [0,displayNull];
	_box = param [1,objNull];

	_control = _display displayCtrl 1500;
	lbClear _control;
	{
		_item = _x select 0;
		_control lbAdd format ["%1 (x%2)",([_item,"name"] call A3PL_Config_GetItem),_x select 1];
		_control lbSetData [_forEachIndex,_item];
	} foreach (player getVariable ["player_inventory",[]]);

	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		_item = _x select 0;
		_control lbAdd format ["%1 (x%2)",([_item,"name"] call A3PL_Config_GetItem),_x select 1];
		_control lbSetData [_forEachIndex,_item];
	} foreach (_box getVariable ["storage",[]]);
}] call Server_Setup_Compile;

["A3PL_Housing_VirtualChange",
{
	disableSerialization;
	private ["_index","_display","_control","_storage","_inventory","_index","_itemClass","_itemAmount"];
	_add = param [0,true];
	_display = findDisplay 37;
	if (_add) then { _control = _display displayCtrl 1500;} else {_control = _display displayCtrl 1501;};
	if (isNull A3PL_Housing_StorageBox) exitwith {[localize"STR_NewHousing_3"] call A3PL_Player_Notification;};

	_storage = A3PL_Housing_StorageBox getVariable ["storage",[]];
	_inventory = player getVariable ["player_inventory",[]];
	_index = lbCurSel _control;
	if (_control lbText _index == "") exitwith {[localize"STR_NewHousing_4","red"] call A3PL_Player_Notification;};

	if (_add) then
	{
		_itemClass = (_inventory select _index) select 0;

		_itemAmount = parseNumber (ctrlText 1400);
		if (_itemAmount < 1) exitwith {[localize"STR_NewHousing_5","red"] call A3PL_Player_Notification;};
		if (_itemAmount > ((_inventory select _index) select 1)) exitwith {[localize"STR_NewHousing_6","red"] call A3PL_Player_Notification;};

		A3PL_Housing_StorageBox setVariable ["storage",([_storage, _itemClass, _itemAmount,false] call BIS_fnc_addToPairs),true];
		player setVariable ["player_inventory",([_inventory, _itemClass, -(_itemAmount),false] call BIS_fnc_addToPairs),true];
		[] call A3PL_Inventory_Verify;
	} else
	{
		_itemClass = (_storage select _index) select 0;

		_itemAmount = parseNumber (ctrlText 1401);
		if (_itemAmount < 1) exitwith {[localize"STR_NewHousing_7","red"] call A3PL_Player_Notification;};
		if (_itemAmount > ((_storage select _index) select 1)) exitwith {[localize"STR_NewHousing_8","red"] call A3PL_Player_Notification;};
		if (([[_itemClass,_itemAmount]] call A3PL_Inventory_TotalWeight) > Player_MaxWeight) exitwith {[format [localize"STR_NewHousing_9",Player_MaxWeight],"red"] call A3PL_Player_Notification;};

		A3PL_Housing_StorageBox setVariable ["storage",([_storage, _itemClass, -(_itemAmount),false] call BIS_fnc_addToPairs),true];
		player setVariable ["player_inventory",([_inventory, _itemClass, _itemAmount,false] call BIS_fnc_addToPairs),true];
		[A3PL_Housing_StorageBox] call A3PL_Housing_VirtualVerify;
	};

	[_display,A3PL_Housing_StorageBox] call A3PL_Housing_VirtualFillLB;
}] call Server_Setup_Compile;

["A3PL_Housing_VirtualVerify", {
	private ["_box", "_index", "_forEachIndex","_change"];

	_box = param [0,objNull];
	_change = false;

	{
		if ((_x select 1) < 1) then {
			_index = _forEachIndex;
			(_box getVariable "storage") set [_index, "REMOVE"];
			_change = true;
		};
	} forEach (_box getVariable "storage");

	if (_change) then
	{
		_box setVariable ["storage", ((_box getVariable "storage") - ["REMOVE"]), true];
	};
}] call Server_Setup_Compile;

["A3PL_Housing_CheckOwn",
{
	private ["_obj","_keyID","_doorID"];

	_obj = param [0,objNull];
	_keyID = param [1,""];
	_return = false;
	_doorID = _obj getVariable "doorID";

	if (typeOf _obj == "Land_A3PL_Motel") then
	{
		_name  = _this select 2;
		_doorID = _obj getVariable "doorID";
		{
			if ((_x select 2) == _name) exitwith
			{
				if (_x select 1 == _keyid) then
				{
					_return = true;
				};
			};
		} foreach _doorID;
	} else
	{
		if (_keyID == (_doorID select 1)) then
		{
			_return = true;
		};
	};
	_return;
}] call Server_Setup_Compile;

["A3PL_Housing_keyFilter",
{
	private ["_keys","_filter","_filteredKeys","_nr"];
	_keys = player getVariable "keys";
	_filteredKeys = [];
	_nr = 6;
	_filter = _this select 0;
	switch (_filter) do
	{
		case "house": {_nr = 5;};
		case "apt": {_nr = 4;};
		case "cars": {_nr = 6;};
		case "warehouse": {_nr = 8};
		default {_nr = 7;};
	};

	{
		if ((count _x) == _nr) then
		{
			_filteredKeys pushback _x;
		};
	} foreach _keys;

	_filteredKeys;

}] call Server_Setup_Compile;

["A3PL_Housing_PickupKey",
{
	_obj = player_objintersect;
	if (typeOf _obj != "A3PL_HouseKey") exitwith {};
	[_obj, player] remoteExec ["Server_Housing_PickupKey", 2];
	[localize"STR_NewHousing_10", "yellow"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Housing_Grabkey",
{
	private ["_keyID","_format"];
	_keyID = lbdata [1900,(lbCurSel 1900)];

	if (!(isNull Player_Item)) then {
		[false] call A3PL_Inventory_PutBack;
	};

	Player_Item = "A3PL_HouseKey" createVehicle (getPos player);

	Player_Item attachTo [player, [0,0,1], 'RightHand'];

	Player_ItemClass = "doorkey";
	Player_Item setVariable ["keyID",_keyID,true];

	[Player_Item] spawn A3PL_Placeable_AttachedLoop;

	player setVariable ["inventory_opened", nil, true];
	closeDialog 0;
	_format = format[localize'STR_NewHousing_11',_keyID];
	[_format, "yellow"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Housing_RetrieveAddress",
{
	private ["_dist","_distMarker","_marker"];
	_dist = 15;
	{
		_distMarker = _this distance (getMarkerPos _x);
		if (_distMarker < _dist) then
		{
			_marker = _x;
		};
	} foreach allMapMarkers;
	if (isNil "_marker") exitwith {"House undefined"};
	_markerName = markerText _marker;
	_markerName;
}] call Server_Setup_Compile;

["A3PL_Housing_GetPrice",
{
	private ["_price","_house","_class"];
	_house = param [0,objNull];
	_class = typeOf _house;
	_price = 0;
	{
		if((_x select 0) == _class) exitWith {
			_price = _x select 1;
		};
	} forEach Config_Houses_Prices;
	_price;
}] call Server_Setup_Compile;

["A3PL_Housing_OpenBuyMenu",
{
	disableSerialization;
	private ["_display","_control","_obj","_houses","_price"];
	_obj = param [0,objNull];
	if (isNull _obj) exitwith {};
	_houses = nearestObjects [player, Config_Houses_List, 20];
	if (count _houses < 1) exitwith {[localize"STR_NewHousing_12","red"] call A3PL_Player_Notification;};
	A3PL_Housing_Object = _houses select 0;

	_price = [A3PL_Housing_Object] call A3PL_Housing_GetPrice;
 	createDialog "Dialog_HouseBuy";
	_display = findDisplay 72;
	_control = _display displayCtrl 1000;
	_control ctrlSetText format ["$%1",[_price, 1, 2, true] call CBA_fnc_formatNumber];
}] call Server_Setup_Compile;

["A3PL_Housing_Buy",
{
	private ["_price"];
	_price = [A3PL_Housing_Object] call A3PL_Housing_GetPrice;
	if ((player getVariable ["player_bank",0]) < _price) exitwith {[localize"STR_NewHousing_13","red"] call A3PL_Player_Notification;};
	if (!isNil {A3PL_Housing_Object getVariable ["doorid",nil]}) exitwith {[localize"STR_NewHousing_14","red"] call A3PL_Player_Notification;};
	if (!isNil {player getVariable ["house",nil]}) exitwith {[localize"STR_NewHousing_15","red"] call A3PL_Player_Notification;};

	[A3PL_Housing_Object,player,true,_price] remoteExec ["Server_Housing_AssignHouse", 2];
	closeDialog 0;
	_namePos = [getPos A3PL_Housing_Object] call A3PL_Housing_PosAddress;
	[format [localize"STR_NewHousing_16",_price,_namePos],"green"] call A3PL_Player_Notification;
	[A3PL_Housing_Object] spawn
	{
		private ["_house"];
		_house = param [0,objNull];
		uiSleep 3;
		_marker = createMarkerLocal [format["house_%1",round (random 1000)],visiblePosition _house];
		_marker setMarkerTypeLocal "A3PL_Markers_TownHall";
		_marker setMarkerAlphaLocal 1;
		_marker setMarkerColorLocal "ColorGreen";
		_marker setMarkerTextLocal (format [" House (%1)",toUpper((_house getVariable ["doorid",["1","Unknown"]]) select 1)]);
	};
	A3PL_Housing_Object = nil;
	["Federal Reserve",_price] remoteExec ["Server_Government_AddBalance",2];
	[player, 50] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_Housing_Init",
{
	private ["_keys","_doorID","_keyID","_buildings","_marker","_text","_apt","_aptNumber"];

	waituntil {sleep 1; _keys = player getVariable "keys"; !isNil "_keys"};
	_keys = ["house"] call A3PL_Housing_keyFilter;
	_buildings = nearestObjects [[5000,5000,0], Config_Houses_List, 5000];
	{
		_doorID = _x getVariable "doorID";
		if (!isNil "_doorID") then
		{
			if ((_doorID select 1) IN _keys) then
			{
				_marker = createMarkerLocal [format["house_%1",round (random 1000)],visiblePosition _x];
				_marker setMarkerTypeLocal "A3PL_Markers_TownHall";
				_marker setMarkerAlphaLocal 0.6;
				_marker setMarkerColorLocal "ColorGreen";
				_marker setMarkerTextLocal (format [" House (%1)",toUpper(_doorID select 1)]);
			};
		};
	} foreach _buildings;

	_apt = param [0,objNull];
	_aptNumber = param [1,-1];
	if ((isNull _apt) OR (_aptNumber == -1)) exitwith {};

	_marker = [_apt] call A3PL_Lib_NearestMarker;
	_marker setMarkerColorLocal "ColorGreen";
	_text = markerText _marker;
	_marker setMarkerTextLocal (format ["%1 (Room: %2)",_text,_aptNumber]);
	_marker setMarkerAlphaLocal 1;
}] call Server_Setup_Compile;

["A3PL_Housing_AptAssignedMsg",
{
	private ["_objAssigned","_aptAssigned","_marker"];
	_objAssigned = param [0,objNull];
	_aptAssigned = param [1,"0"];

	_marker = [_objAssigned] call A3PL_Lib_NearestMarker;
	_text = markerText _marker;
	[format [localize"STR_NewHousing_17",_aptAssigned,_text], "green"] call A3PL_Player_Notification;
	[_objAssigned,_aptAssigned] call A3PL_Housing_Init;
}] call Server_Setup_Compile;

["A3PL_Housing_Loaditems",
{
	private ["_house","_pItems","_objects","_uid"];
	_house = param [0,objNull];
	_pItems = param [1,[]];
	_uid = getPlayerUID player;
	_objects = [];
	{
		private ["_classname","_class","_pos","_dir","_obj"];
		_classname = _x select 0;
		_class = _x select 1;
		_pos = _house modelToWorld (_x select 2);
		_dir = _x select 3;
		_obj = createVehicle [_classname, _pos, [], 0, "CAN_COLLIDE"];
		if (!([_class,"simulation"] call A3PL_Config_GetItem)) then
		{
			[_obj] remoteExec ["Server_Housing_LoadItemsSimulation", 2];
		};
		_obj setDir _dir;
		_obj setPosATL _pos;
		_obj setVariable ["owner",_uid,true];
		_obj setVariable ["class",_class,true];
	} foreach _pitems;
}] call Server_Setup_Compile;

["A3PL_RealEstates_Open",
{
	disableSerialization;

	_near = (nearestObjects [player, Config_Houses_List, 10,true]) select 0;
	_owners = _near getVariable ["owner",[]];
	if((getPlayerUID player) IN _owners) exitwith {
		[localize"STR_NewHousing_18", "red"] call A3PL_Player_Notification;
	};
	_sign = _this select 0;
	if(!(_sign getVariable["houseSelling",false])) exitwith {[localize"STR_NewHousing_19", "red"] call A3PL_Player_Notification;};

	createDialog "Dialog_EstateSell";
	_display = findDisplay 67;
	_control = _display displayCtrl 1900;
	_control sliderSetRange [1,40];
	_control ctrlAddEventHandler ["SliderPosChanged",{_this call A3PL_RealEstates_MenuSlider}];
	_control sliderSetPosition 1;

	_houses = nearestObjects [player, Config_Houses_List, 10,true];
	if(count(_houses) isEqualTo 0) exitWith {};
	_price = [_houses select 0] call A3PL_Housing_GetPrice;
	_control = _display displayCtrl 1400;
	_control ctrlSetStructuredText parseText format ["<t align='left'>Market price: $%1</t>",_price];
}] call Server_Setup_Compile;

["A3PL_RealEstates_MenuSlider",
{
	disableSerialization;
	private ["_display","_control","_sControl"];
	_display = findDisplay 67;

	_percentage = _this select 1;
	_house = (nearestObjects [player, Config_Houses_List, 10,true]) select 0;
	_housePrice = [_house] call A3PL_Housing_GetPrice;
	_value = round((_percentage / 100) * _housePrice);

	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format ["<t align='center'>Percentage: %1%3<br/>Value: $%2</t>",_percentage,_value,"%"];
}] call Server_Setup_Compile;

["A3PL_RealEstates_Sell",
{
	_sign = (nearestObjects [player, ["Land_A3PL_EstateSign"], 5,true]) select 0;
	_house = (nearestObjects [player, Config_Houses_List, 10,true]) select 0;

	_display = findDisplay 67;
	_slider = _display displayCtrl 1900;

	_housePrice = [_house] call A3PL_Housing_GetPrice;
	_percentage = round(sliderPosition _slider);
	_com = round(_percentage / 100 * (_housePrice));
	_clientPart = _housePrice - _com;

	closeDialog 0;
	[format[localize"STR_NewHousing_20",_com],"green"] call A3PL_Player_Notification;
	player setVariable["Player_Bank", ((player getVariable["Player_Bank",0]) + _com),true];
	[player,60] call A3PL_Level_AddXP;
	[getPos player,_clientPart, _sign, _house] remoteExec ["Server_Housing_Sold",2];
	[getPlayerUID player,"houseSold",[(_house getVariable ["doorid",["1","Unknown"]]) select 1]] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_RealEstates_SetSell",
{
	disableSerialization;
	_value = _this select 0;
	_sign = _this select 1;
	_near = nearestObjects [player, Config_Houses_List, 10,true];
	if(count(_near) isEqualTo 0) exitWith {["No house nearby", "red"] call A3PL_Player_Notification;};
	_owners = (_near select 0) getVariable ["owner",[]];
	if(count _owners isEqualTo 0) exitwith {};
	_owner = _owners select 0;
	if((getPlayerUID player) == _owner) then {
		_sign setVariable["houseSelling",_value,true];
		if(_value) then {
			[localize"STR_NewHousing_21", "green"] call A3PL_Player_Notification;
		} else {
			[localize"STR_NewHousing_22", "green"] call A3PL_Player_Notification;
		};
	} else {
		[localize"STR_NewHousing_23", "red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Housing_SetSell",
{
	private["_house","_pos"];
	_house = param [0,objNull];

	if((player distance _house) > 10) exitWith {};

	_obj = createvehicle ["Land_A3PL_EstateSign",getPos player, [], 0, "CAN_COLLIDE"];
	[localize"STR_NewHousing_24", "green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Housing_SetMarker",
{
	private["_house","_pos"];
	_house = param [0,objNull];
	uiSleep 3;
	_marker = createMarkerLocal [format["house_%1",round (random 1000)],visiblePosition _house];
	_marker setMarkerTypeLocal "A3PL_Markers_TownHall";
	_marker setMarkerAlphaLocal 1;
	_marker setMarkerColorLocal "ColorGreen";
	_marker setMarkerTextLocal (format ["House - Key : %1",((_house getVariable ["doorid",["1","Unknown"]]) select 1)]);
}] call Server_Setup_Compile;

["A3PL_Housing_PosAddress",
{
	private["_position","_buidlingsArray","_building","_address"];
	_position = param [0,[0,0,0]];
	_buidlingsArray = ["Land_A3PL_Bank","Land_A3PL_Capital","Land_A3PL_Sheriffpd","Land_Shop_DED_Shop_01_F","land_smallshop_ded_smallshop_01_f","land_market_ded_market_01_f","Land_Taco_DED_Taco_01_F","Land_A3PL_Gas_Station","Land_A3PL_Garage","Land_John_Hangar","Land_A3PL_CG_Station","land_a3pl_ch","Land_A3PL_Clinic","Land_A3PL_Firestation","Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_Mansion01","Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_BostonHouse","Land_A3PL_Shed3","Land_A3PL_Shed4","Land_A3PL_Shed2","Land_John_House_Grey","Land_John_House_Blue","Land_John_House_Red","Land_John_House_Green"];
	_building = (nearestObjects [_position, _buidlingsArray, 100]) select 0;
	_address = _building getVariable["Building_Address","Unknown Address"];
	_address;
}] call Server_Setup_Compile;
