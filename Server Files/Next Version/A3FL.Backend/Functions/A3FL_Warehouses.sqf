/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Warehouses_OpenBuyMenu",
{
	disableSerialization;
	private _obj = param [0,objNull];
	if (isNull _obj) exitwith {};
	private _warehouses = nearestObjects [player, Config_Warehouses_List, 20];
	if (count _warehouses < 1) exitwith {[localize"STR_NewHousing_12","red"] call A3PL_Player_Notification;};
	A3PL_Warehouses_Object = _warehouses select 0;
	private _price = [A3PL_Warehouses_Object,1] call A3PL_Warehouses_GetData;
 	createDialog "Dialog_WarehouseBuy";
	private _display = findDisplay 75;
	private _control = _display displayCtrl 1000;
	_control ctrlSetText format ["%1",[_price, 1, 2, true] call CBA_fnc_formatNumber];
}] call Server_Setup_Compile;

["A3PL_Warehouses_Buy",
{
	private _warehouses = nearestObjects [player, Config_Warehouses_List, 20];
	if (count _warehouses < 1) exitwith {[localize"STR_NewHousing_12","red"] call A3PL_Player_Notification;};
	A3PL_Warehouses_Object = _warehouses select 0;
	private _price = [A3PL_Warehouses_Object,1] call A3PL_Warehouses_GetData;
	private _level = [A3PL_Warehouses_Object,3] call A3PL_Warehouses_GetData;
	if ((player getVariable ["player_bank",0]) < _price) exitwith {[localize"STR_NewHousing_13","red"] call A3PL_Player_Notification;};
	if ((player getVariable ["player_level",0]) < _level) exitwith {[format["You need to be level %1 to purchase this warehouse!",_level],"red"] call A3PL_Player_Notification;};
	if (!isNil {A3PL_Warehouses_Object getVariable ["doorid",nil]}) exitwith {["This warehouse is already owned!","red"] call A3PL_Player_Notification;};
	if (!isNil {player getVariable ["warehouse",nil]}) exitwith {["You already own a warehouse!","red"] call A3PL_Player_Notification;};

	[A3PL_Warehouses_Object,player,true,_price] remoteExec ["Server_Warehouses_Assign", 2];
	closeDialog 0;
	_namePos = [getPos A3PL_Warehouses_Object] call A3PL_Housing_PosAddress;
	[format ["You purchased this warehouse for $%1 located at %2",_price,_namePos],"green"] call A3PL_Player_Notification;
	[A3PL_Warehouses_Object] spawn
	{
		private _warehouse = param [0,objNull];
		private _marker = createMarkerLocal [format["warehouse_%1",round (random 1000)],visiblePosition _warehouse];
		_marker setMarkerTypeLocal "A3PL_Markers_TownHall";
		_marker setMarkerAlphaLocal 1;
		_marker setMarkerColorLocal "ColorGreen";
		_marker setMarkerTextLocal (format [" Warehouse (%1)",toUpper((_warehouse getVariable ["doorid",["1","Unknown"]]) select 1)]);
	};
	A3PL_Warehouses_Object = nil;
	["Federal Reserve",_price] remoteExec ["Server_Government_AddBalance",2];
	[player, 50] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_Warehouses_Loaditems",
{
	private ["_warehouse","_pItems","_objects","_uid"];
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
			[_obj] remoteExec ["Server_Warehouses_LoadItemsSimulation", 2];
		};
		_obj setDir _dir;
		_obj setPosATL _pos;
		_obj setVariable ["owner",_uid,true];
		_obj setVariable ["class",_class,true];
	} foreach _pItems;
}] call Server_Setup_Compile;

["A3PL_Warehouses_Init",
{
	private ["_keys","_doorID","_keyID","_buildings","_marker","_text","_apt","_aptNumber"];
	waituntil {sleep 1; _keys = player getVariable "keys"; !isNil "_keys"};
	_keys = ["warehouse"] call A3PL_Housing_keyFilter;
	_buildings = nearestObjects [[5000,5000,0], Config_Warehouses_List, 5000];
	{
		_doorID = _x getVariable "doorID";
		if (!isNil "_doorID") then
		{
			if ((_doorID select 1) IN _keys) then
			{
				_marker = createMarkerLocal [format["warehouse_%1",round (random 1000)],visiblePosition _x];
				_marker setMarkerTypeLocal "A3PL_Markers_TownHall";
				_marker setMarkerAlphaLocal 0.6;
				_marker setMarkerColorLocal "ColorGreen";
				_marker setMarkerTextLocal (format [" Warehouse (%1)",toUpper(_doorID select 1)]);
			};
		};
	} foreach _buildings;
}] call Server_Setup_Compile;

["A3PL_Warehouses_SetMarker",
{
	private _warehouse = param [0,objNull];
	private _marker = createMarkerLocal [format["warehouse_%1",round (random 1000)],visiblePosition _warehouse];
	_marker setMarkerTypeLocal "A3PL_Markers_TownHall";
	_marker setMarkerAlphaLocal 1;
	_marker setMarkerColorLocal "ColorGreen";
	_marker setMarkerTextLocal (format [" Warehouse (%1)",toUpper((_warehouse getVariable ["doorid",["1","Unknown"]]) select 1)]);
}] call Server_Setup_Compile;

["A3PL_Warehouses_GetData",
{
	private _warehouse = param [0,objNull];
	private _search = param [1,1];
	private _class = typeOf _warehouse;
	private _data = "";
	{
		if((_x select 0) == _class) exitWith {
			_data = _x select _search;
		};
	} forEach Config_Warehouses_Prices;
	_data;
}] call Server_Setup_Compile;

["A3PL_Warehouses_SellOpen",
{
	disableSerialization;
	private _sign = param[0,objNull];
	if(isNull _sign) exitWith {};
	private _near = nearestObjects [player, Config_Warehouses_List, 30,true];
	if(count(_near) isEqualTo 0) exitWith {["No warehouse nearby", "red"] call A3PL_Player_Notification;};
	private _warehouse = _near select 0;
	private _owners = _warehouse getVariable ["owner",[]];
	if(count _owners isEqualTo 0) exitwith {};
	private _owner = _owners select 0;
	if((getPlayerUID player) isEqualTo _owner) then {
		createDialog "Dialog_EstateSell";
		private _display = findDisplay 67;
		private _price = ([_warehouse] call A3PL_Warehouses_GetData) * 0.75;
		private _control = _display displayCtrl 1100;
		_control ctrlSetStructuredText parseText format ["<t align='left'>$ %1</t>",[_price, 1, 0, true] call CBA_fnc_formatNumber];
		buttonSetAction [100, "call A3PL_Warehouses_Sell;"];		
	} else {
		[localize"STR_NewHousing_23", "red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Warehouses_Sell",
{
	closeDialog 0;
	private _sign = (nearestObjects [player, ["Land_A3PL_BusinessSign"], 10,true]) select 0;
	private _warehouse = (nearestObjects [player, Config_Warehouses_List, 30,true]) select 0;
	private _whPrice = ([_warehouse,1] call A3PL_Warehouses_GetData) * 0.7;
	[player,50] call A3PL_Level_AddXP;
	[getPos player,_whPrice, _sign, _warehouse] remoteExec ["Server_Warehouses_Sold",2];
	[getPlayerUID player,"warehouseSold",["Price",_whPrice]] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;