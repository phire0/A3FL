/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Warehouses_GetPrice",
{
	private ["_price","_house","_class"];
	_warehouse = param [0,objNull];
	_class = typeOf _warehouse;
	_price = 0;
	{
		if((_x select 0) == _class) exitWith {
			_price = _x select 1;
		};
	} forEach Config_Warehouses_Prices;
	_price;
}] call Server_Setup_Compile;

["A3PL_Warehouses_OpenBuyMenu",
{
	disableSerialization;
	private ["_display","_control","_obj","_houses","_price"];
	_obj = param [0,objNull];
	if (isNull _obj) exitwith {};
	_warehouses = nearestObjects [player, Config_Warehouses_List, 20];
	if (count _warehouses < 1) exitwith {[localize"STR_NewHousing_12","red"] call A3PL_Player_Notification;};
	A3PL_Warehouses_Object = _warehouses select 0;

	_price = [A3PL_Warehouses_Object] call A3PL_Warehouses_GetPrice;
 	createDialog "Dialog_WarehouseBuy";
	_display = findDisplay 75;
	_control = _display displayCtrl 1000;
	_control ctrlSetText format ["%1",[_price, 1, 2, true] call CBA_fnc_formatNumber];
}] call Server_Setup_Compile;

["A3PL_Warehouses_Buy",
{
	private ["_price"];
	_warehouses = nearestObjects [player, Config_Warehouses_List, 20];
	if (count _warehouses < 1) exitwith {[localize"STR_NewHousing_12","red"] call A3PL_Player_Notification;};
	A3PL_Warehouses_Object = _warehouses select 0;
	_price = [A3PL_Warehouses_Object] call A3PL_Warehouses_GetPrice;
	if ((player getVariable ["player_bank",0]) < _price) exitwith {[localize"STR_NewHousing_13","red"] call A3PL_Player_Notification;};
	if (!isNil {A3PL_Warehouses_Object getVariable ["doorid",nil]}) exitwith {["This warehouse is already owned!","red"] call A3PL_Player_Notification;};
	if (!isNil {player getVariable ["warehouse",nil]}) exitwith {["You already own a warehouse!","red"] call A3PL_Player_Notification;};

	[A3PL_Warehouses_Object,player,true,_price] remoteExec ["Server_Warehouses_Assign", 2];
	closeDialog 0;
	_namePos = [getPos A3PL_Warehouses_Object] call A3PL_Housing_PosAddress;
	[format ["You purchased this warehouse for $%1 located at %2",_price,_namePos],"green"] call A3PL_Player_Notification;
	[A3PL_Warehouses_Object] spawn
	{
		private ["_house"];
		_warehouse = param [0,objNull];
		uiSleep 3;
		_marker = createMarkerLocal [format["warehouse_%1",round (random 1000)],visiblePosition _warehouse];
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

["A3PL_Warehouses_LeaveHouse",
{
	private _warehouse = (nearestObjects [player, Config_Warehouses_List, 20,true]) select 0;
	if(count(_near) isEqualTo 0) exitWith {["No warehouse nearby", "red"] call A3PL_Player_Notification;};
	private _owners = (_near select 0) getVariable ["owner",[]];
	if(count _owners isEqualTo 0) exitwith {};
	private _owner = _owners select 0;
	if((getPlayerUID player) isEqualTo _owner) exitWith {["You are the owner, only roommates can leave.", "red"] call A3PL_Player_Notification;};
	[player, _warehouse] remoteExec ["Server_Warehouses_RemoveMember",2];
}] call Server_Setup_Compile;

["A3PL_Warehouses_SetMarker",
{
	private["_warehouse","_pos"];
	_warehouse = param [0,objNull];
	uiSleep 3;
	_marker = createMarkerLocal [format["warehouse_%1",round (random 1000)],visiblePosition _warehouse];
	_marker setMarkerTypeLocal "A3PL_Markers_TownHall";
	_marker setMarkerAlphaLocal 1;
	_marker setMarkerColorLocal "ColorGreen";
	_marker setMarkerTextLocal (format [" Warehouse (%1)",toUpper((_warehouse getVariable ["doorid",["1","Unknown"]]) select 1)]);
}] call Server_Setup_Compile;
