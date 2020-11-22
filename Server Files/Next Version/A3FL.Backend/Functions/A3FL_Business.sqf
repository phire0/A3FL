/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define RENTMINTIME 1
#define RENTMAXTIME 720
#define RENTCOSTPERMIN 35
#define BUSINESSOBJS ["Land_A3FL_Airport_Hangar","Land_A3PL_Showroom","Land_A3PL_Garage","land_smallshop_ded_smallshop_02_f","land_smallshop_ded_smallshop_01_f","Land_A3PL_Gas_Station","Land_A3FL_Brick_Shop_1","Land_A3FL_Brick_Shop_2","Land_A3FL_Anton_Store"]

["A3PL_Business_Buy",
{
	disableSerialization;
	private _business = param [0,player_objintersect];
	if (typeOf _business isEqualTo "Land_A3PL_BusinessSign") then
	{
		_business = (nearestObjects [_business,BUSINESSOBJS,50]) select 0;
	};
	if (isNull _business) exitwith {["System Error: _business isNull in Business_Buy (Unable to determine business object)"] call A3PL_Player_Notification;};

	createDialog "Dialog_BusinessRent";
	private _display = findDisplay 57;
	private _control = _display displayCtrl 1900;
	_control ctrlAddEventHandler ["KeyUp",{call A3PL_Business_BuyText}];
	call A3PL_Business_BuyText;
}] call Server_Setup_Compile;

["A3PL_Business_Rent",
{
	disableSerialization;
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _sign = (nearestObjects [player,["Land_A3PL_BusinessSign"],10]) select 0;
	private _business = (nearestObjects [_sign,BUSINESSOBJS,50]) select 0;
	if (isNil "_business") exitwith {["System Error: cannot locate the business, please look at the sign"] call A3PL_Player_Notification;};
	if (isNull _business) exitwith {["System Error: _business isNull in Business_Rent (Unable to determine business object)"] call A3PL_Player_Notification;};
	private _display = findDisplay 57;
	private _control = _display displayCtrl 1400;
	private _name = ctrlText _control;

	if ((count _name) < 5) exitwith {[localize"STR_BUSINESS_ENTERVALIDNAMEMINI5CARACTERE"] call A3PL_Player_Notification;};
	if ((count _name) > 30) exitwith {[localize"STR_BUSINESS_ENTERVALIDNAMEMAX30"] call A3PL_Player_Notification;};

	_display = findDisplay 57;
	_sControl = _display displayCtrl 1900;
	_rentTime = round (parseNumber(ctrlText _sControl));
	if(_rentTime <= 0) exitWith {["Please enter a valid renting time","red"] call A3PL_Player_Notification;};
	if(_rentTime > RENTMAXTIME) exitWith {["You cannot rent a business for more than 720 minutes","red"] call A3PL_Player_Notification;};
	_rentCost = _rentTime * RENTCOSTPERMIN;

	private _pCash = player getVariable ["player_cash",0];
	if (_pCash < _rentcost) exitwith {[format[localize"STR_BUSINESS_DONTHAVEENOUGHMONEY",_rentcost-_pCash],"red"] call A3PL_Player_Notification};
	if (_business getVariable ["bOwner",""] != "") exitwith {[localize"STR_BUSINESS_ALREADYBUYBYPLAYER","red"] call A3PL_Player_Notification;};

	[player,_business,_name,_rentTime,_rentCost,_sign] remoteExec ["Server_Business_Buy", 2];
	closeDialog 0;
	[localize"STR_BUSINESS_BUSINESSBUY","yellow"] call A3PL_Player_Notification;
	[getPlayerUID player,"businessRented",[str(getpos player)]] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_Business_BuyText",
{
	disableSerialization;
	private _display = findDisplay 57;
	private _sControl = _display displayCtrl 1900;
	private _control = _display displayCtrl 1400;
	private _name = ctrlText _control;
	private _rentTime = round (parseNumber(ctrlText _sControl));
	private _rentCost = _rentTime * RENTCOSTPERMIN;
	_control = _display displayCtrl 1100;
	if(_rentTime <= 0) exitWith {_control ctrlSetStructuredText parseText "Please enter a valid renting time";};
	_control ctrlSetStructuredText parseText format ["Rent cost: $%1 for %2 minutes",_rentCost, _rentTime];
}] call Server_Setup_Compile;

["A3PL_Business_Sell",
{
	disableSerialization;
	private ["_display","_control"];
	private _obj = param [0,cursorObject];
	if (isNull _obj) exitwith {["System Error: _business isNull in Business_Buy (Unable to determine business object)"] call A3PL_Player_Notification;};
	private _owner = _obj getVariable ["owner",nil];
	if (isNil "_owner") exitwith {["System: This item isn't owned by anyone (missing owner setVar)","red"] call A3PL_Player_Notification; };
	if (_owner isEqualType []) then {
		_owner = _owner select 0;
	};
	if ((getPlayerUID player) != _owner) exitwith {[localize"STR_BUSINESS_YOUCANTSELLTHISOBJECTYOUARENOTTHEOWNER","red"] call A3PL_Player_Notification;};

	createDialog "Dialog_ItemSale";
	_display = findDisplay 58;
	_control = _display displayCtrl 1600;
	_control buttonSetAction format ["['%1'] call A3PL_Business_SellItem;",_obj];
	_control = _display displayCtrl 1601;
	_control buttonSetAction format ["['%1'] call A3PL_Business_SellItemStop;",_obj];
}] call Server_Setup_Compile;

["A3PL_Business_SellItem",
{
	disableSerialization;
	private _obj = param [0,objNull];
	private _uid = getPlayerUID player;
	if (_obj isEqualType "") then
	{
		{
			_check = format ["%1",_x];
			if (_check == _obj) exitwith
			{
				_obj = _x;
			};
		} foreach (nearestObjects [player, [], 20]);
	};
	if (_obj isEqualType "") exitwith {["System: Error occured in Business_SellItem, could not retrieve object", "red"] call A3PL_Player_Notification;};

	private _display = findDisplay 58;
	private _control = _display displayCtrl 1400;
	private _name = ctrlText _control;
	private _sControl = _display displayCtrl 1900;
	private _price = round (parseNumber(ctrlText _sControl));
	if (count _name < 3) exitwith {[localize"STR_BUSINESS_ENTERDESCRIPTION3MIN","red"] call A3PL_Player_Notification;};
	if (count _name > 30) exitwith {[localize"STR_BUSINESS_ENTERDESCRIPTION30MAX","red"] call A3PL_Player_Notification;};
	if (_price < 1) exitWith {["Please enter a valid price","red"] call A3PL_Player_Notification;};

	private _bfound = objNull;
	{
		if ((_x getVariable ["bOwner",""]) isEqualTo _uid) exitwith {_bfound = _x};
	} foreach (nearestObjects [player,["Land_A3FL_Airport_Hangar","Land_A3PL_Showroom","Land_A3PL_Garage","land_smallshop_ded_smallshop_02_f","land_smallshop_ded_smallshop_01_f","Land_A3PL_Gas_Station","Land_A3FL_Brick_Shop_1","Land_A3FL_Brick_Shop_2","Land_A3FL_Anton_Store"],800]);
	if (isNull _bFound) exitwith {[localize"STR_BUSINESS_NEARBUSINESSNEEDED","red"] call A3PL_Player_Notification;};

	private _bDist = switch (typeOf _bfound) do {
		case ("Land_A3FL_Airport_Hangar"): {(player distance _bfound) < 100};
		case ("Land_A3PL_Showroom"): {(player distance _bfound) < 40};
		case ("land_smallshop_ded_smallshop_02_f"): {(player distance _bfound) < 10.1};
		case ("land_smallshop_ded_smallshop_01_f"): {(player distance _bfound) < 10.1};
		case default {(player distance _bfound) < 30};
	};
	if (!_bDist) exitwith {[localize"STR_BUSINESS_NEARBUSINESSFORSELL","red"] call A3PL_Player_Notification;};

	[player,_obj,_name,_price] remoteExec ["Server_Business_Sellitem", 2];
	closeDialog 0;
	[localize"STR_BUSINESS_YOUSELLTHISOBJECT","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Business_SellItemStop",
{
	disableSerialization;
	private _obj = param [0,objNull];
	if (_obj isEqualType "") then
	{
		{
			_check = format ["%1",_x];
			if (_check == _obj) exitwith
			{
				_obj = _x;
			};
		} foreach (nearestObjects [player, [], 20]);
	};
	if (_obj isEqualType "") exitwith {["System: Error occured in Business_SellItem, could not retrieve object", "red"] call A3PL_Player_Notification;};
	private _bItem = _obj getVariable ["bitem",nil];
	if (isNil "_bItem") exitwith {[localize"STR_BUSINESS_ITEMNOTSELL", "red"] call A3PL_Player_Notification;};
	if ((getPlayerUID player) != (_bItem select 2)) exitwith {[localize"STR_BUSINESS_YOUARENOTTHEPERSONSELLTHISITEM", "red"] call A3PL_Player_Notification;};

	_obj setVariable ["bItem",nil,true];
	closeDialog 0;
	[localize"STR_BUSINESS_YOUDONTSELLTHISITEM","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Business_BuyItemReceive",
{
	private _reply = param [0,-1];
	private _msg = switch (_reply) do {
		case (0): {[format [localize"STR_BUSINESS_YOUSOLDTHISITEM",(param [1,0])],"green"];};
		case (1): {[localize"STR_BUSINESS_YOUBUYTHISITEM","green"];};
		default {["Error: Undefined _reply in _BuyItemReceive","red"]};
	};
	_msg call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Business_BuyItem",
{
	disableSerialization;
	private _obj = param [0,cursorobject];
	if (isNull _obj) exitwith {["System: Object is null in _BuyItem (Couldn't find item)","red"] call A3PL_Player_Notification;};
	private _bItem = _obj getVariable ["bitem",nil];
	if (isNil "_bItem") exitwith {["System: This item isn't being sold (missing setVar)", "red"] call A3PL_Player_Notification;};
	createDialog "Dialog_ItemBuy";
	private _display = findDisplay 59;
	private _price = _bItem select 0;
	private _name = _bItem select 1;

	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='center'>%1</t>",_name];
	_control = _display displayCtrl 1101;
	_control ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='center'>$%1</t>",([_price, 1, 0, true] call CBA_fnc_formatNumber)];

	_control = _display displayCtrl 1601;
	_control ButtonSetAction format ["['%1'] call A3PL_Business_BuyItemBuy",_obj];
	_control = _display displayCtrl 1602;
	_control ButtonSetAction format ["['%1',true] call A3PL_Business_BuyItemBuy",_obj];
}] call Server_Setup_Compile;

["A3PL_Business_BuyItemBuy",
{
	disableSerialization;
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _obj = [(param [0,""])] call A3PL_Lib_vehStringToObj;
	if (_obj isEqualType "") exitwith {["System: Unable to determine object in _BuyItemBuy (report this)","red"] call A3PL_Player_Notification;};
	private _bItem = _obj getVariable ["bitem",nil];
	if (isNil "_bItem") exitwith {["This item isn't up for sale", "red"] call A3PL_Player_Notification;};
	private _price = _bItem select 0;
	private _name = _bItem select 1;
	private _itemOwner = _bItem select 2;
	private _hasMoney = if (_price <= (player getVariable ["player_cash",0])) then {true} else {false};
	if (!_hasMoney) exitwith {[format[localize"STR_BUSINESS_YOUDONTHAVEENOUGHMONEY",_price-(player getVariable ["player_cash",0])], "red"] call A3PL_Player_Notification;};

	_correctLoc = false;
	{
		if (_itemOwner isEqualTo (_x getVariable ["bOwner",""])) exitwith {_correctLoc = true};
	} foreach (nearestObjects [player, BUSINESSOBJS, 100]);
	if (!_correctLoc) exitwith {[localize"STR_BUSINESS_YOUNOTNEARYOURBUSINESS", "red"] call A3PL_Player_Notification;};

	[player,_obj] remoteExec ["Server_Business_BuyItem", 2];
	[getPlayerUID player,"BuyItem",[typeOf(_obj), str(_price)]] remoteExec ["Server_Log_New",2];
	[localize"STR_BUSINESS_YOUBUYTHISOBJECT","yellow"] call A3PL_Player_Notification;
	closeDialog 0;
}] call Server_Setup_Compile;