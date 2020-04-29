/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define COMBINE_ITEMS [["burger_full_cooked",["burger_cooked","burger_bun","Salad"],1],["burger_full_raw",["burger_cooked","burger_bun","Salad"],1],["burger_full_burnt",["burger_cooked","burger_bun","Salad"],1],["taco_cooked",["fish_cooked","tacoshell","Salad"],1],["taco_raw",["fish_raw","tacoshell","Salad"],1],["taco_burned",["fish_raw","tacoshell","Salad"],1],["salad",["Lettuce"],5],["tacoshell",["Corn"],20],["fish_raw",["bucket_full"],10],["burger_raw",["bucket_full"],10],["burger_bun",["wheat"],10]]

["A3PL_Combine_Open",
{
	disableSerialization;
	createDialog "Dialog_CombineItems";
	private _display = findDisplay 9;
	private _control = _display displayCtrl 1500;
	private _items = param [0,["burger_full_cooked","taco_cooked"]];
	{
		private _name = [_x,"name"] call A3PL_Config_GetItem;
		private _index = _control lbAdd _name;
		_control lbSetData [_index,_x];
	} foreach _items;

	_control ctrlAddEventHandler ["LBSelChanged",
	{
		private _selectedIndex = param [1,-1];
		private _control = param [0,ctrlNull];
		if (_selectedIndex < 0) exitwith {}; //no index selected
		private _class = _control lbData (lbCurSel _control);
		private _required = [];
		{
			if ((_x select 0) == _class) exitwith {_required = _x select 1; _output = _x select 2;};
		} foreach COMBINE_ITEMS;
		if (count _required < 1) exitwith {};

		A3PL_Combine_ItemSelected = _class;
		A3PL_Combine_ItemRequired = _required;

		_control = (findDisplay 9) displayCtrl 1501;
		lbClear _control;
		{
			private _index = _control lbAdd ([_x,"name"] call A3PL_Config_GetItem);
			private _control lbSetData [_index,_x];
			if ([_x] call A3PL_Inventory_Has) then {
				_control lbSetColor [_index,[0, 1, 0, 1]];
			} else {
				_control lbSetColor [_index,[1, 0, 0, 1]];
			};
		} foreach _required;
	}];

	private _control = _display displayCtrl 1600;
	_control ctrlAddEventHandler ["ButtonDown", {[] call A3PL_Combine_Create;}];
}] call Server_Setup_Compile;

["A3PL_Combine_Create",
{
	disableSerialization;
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private _creating = A3PL_Combine_ItemSelected;
	private _required = A3PL_Combine_ItemRequired;

	private _control = ctrlText ((findDisplay 9) displayCtrl 1400);
	private _amount = parseNumber _control;
	if (_amount < 1) exitwith {[localize"STR_COMBINE_PLEASEENTERVALIDAMOUNT","red"] call A3PL_Player_Notification;};

	private _haveItems = true;
	{
		if (!([_x,_amount] call A3PL_Inventory_Has)) exitwith {_haveItems = false};
	} foreach _required;
	if (!_haveItems) exitwith {[localize"STR_COMBINE_YOUDONTHAVEOBJECTSFORCRAFTTHISITEM","red"] call A3PL_Player_Notification;};

	if (([[_creating,_amount]] call A3PL_Inventory_TotalWeight) > Player_MaxWeight) exitwith {["You don't have enough space in your inventory to craft this","red"] call A3PL_Player_Notification;};

	{
		[_x,-(_amount)] call A3PL_Inventory_Add;
	} foreach _required;

	private _output = 0;
	{
		if ((_x select 0) == _creating) exitwith {_output = _x select 2};
	} foreach COMBINE_ITEMS;
	if (_output < 1) exitwith {["System Error: Unable to set _output in A3PL_Combine_Create"] call A3PL_Player_Notification;};

	[_creating,_amount] call A3PL_Inventory_Add;
	[format [localize"STR_COMBINE_YOUHAVECRAFTEDTHISITEM",([_creating,"name"] call A3PL_Config_GetItem),_amount],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;