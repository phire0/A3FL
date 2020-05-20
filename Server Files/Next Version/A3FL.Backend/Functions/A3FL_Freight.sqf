/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Freight_Start",
{
	private _startPoint = param [0,objNull];
	private _hasLicense = [player,"fwcpl"] call A3PL_Company_HasLicense;
	if(!_hasLicense) exitWith {["You need a Commercial Fixed Wing License!","red"] call A3PL_Player_Notification;};
	private _planes = nearestObjects [player, ["A3PL_Cessna172", "A3PL_Goose_Base"], 10];
	if(count (_planes) isEqualTo 0) exitWith {["There is no plane nearby!","red"] call A3PL_Player_Notification;};
	private _plane = _planes select 0;
	if(((_plane getVariable["owner",""]) select 0) != (getPlayerUID player)) exitWith {["This is not your plane!","red"] call A3PL_Player_Notification;};
	if(_plane getVariable["onDelivery",false]) exitWith {["This plane is already used for a delivery!","red"] call A3PL_Player_Notification;};
	player setVariable["job","freight pilot",true];
	[_startPoint,_plane] spawn A3PL_Freight_Load;
}] call Server_Setup_Compile;

["A3PL_Freight_Load",
{
	private _startPoint = param [0,objNull];
	private _plane = param [1,objNull];
	private _destinations = [npc_freight_svt,npc_freight_nd,npc_freight_lubbock];
	_destinations find _startPoint;
	_destinations deleteAt (_destinations find _startPoint);
	private _destination = selectRandom _destinations;
	private _cargoValue = [_plane] call A3PL_Freight_CargoValue;
	["Loading the cargo inside the plane.. please wait 5 minutes..","green"] call A3PL_Player_Notification;
	_error = false;
	for "_i" from 0 to 300 do {
		if((_plane distance _startPoint) > 20) exitWith {_error = true;};
		sleep 1;
	};
	if(_error) exitWith {[] call A3PL_Freight_End;["You moved the plane while it was loading!","green"] call A3PL_Player_Notification;};
	_plane setVariable["onDeliveryCargo",_cargoValue,true];
	["Your cargo is ready!","green"] call A3PL_Player_Notification;
	private _destString = [_destination] call A3PL_Freight_DestString;
	[format["This freight needs to be delivered to %1",_destString],"green"] call A3PL_Player_Notification;
	player setVariable["deliveryPlane",_plane,false];
	_plane setVariable["onDelivery",true,true];
	_plane setVariable["onDeliveryDest",_destination,true];
	_plane addEventHandler ["Killed",{[] call A3PL_Freight_DestroyFees;}];
}] call Server_Setup_Compile;

["A3PL_Freight_Unload",
{
	private _unloadPoint = param[0,objNull];
	private _plane =  player getVariable["deliveryPlane",objNull];
	if(isNull _plane) exitWith {["Cannot find the plane!","red"] call A3PL_Player_Notification;};
	if((player distance _plane) > 20) exitWith {["The plane needs to be closer to unload the cargo!","red"] call A3PL_Player_Notification;};
	private _destination = _plane getVariable["onDeliveryDest",objNull];
	if(_unloadPoint != _destination) exitWith {["This is the wrong destination!","red"] call A3PL_Player_Notification;};
	private _cargoValue = _plane getVariable["onDeliveryCargo",0];
	["Unloading the cargo.. please wait 5 minutes..","green"] call A3PL_Player_Notification;
	_error = false;
	for "_i" from 0 to 300 do {
		if((_plane distance _unloadPoint) > 20) exitWith {_error = true;};
		sleep 1;
	};
	if(_error) exitWith {[] call A3PL_Freight_End;["You moved the plane while it was unloading!","green"] call A3PL_Player_Notification;};
	["Cargo unloaded!","green"] call A3PL_Player_Notification;
	_plane setVariable["onDeliveryCargo",nil,true];
	_plane removeEventHandler ["Killed", 0];
	[_cargoValue] call A3PL_Freight_End;
}] call Server_Setup_Compile;

["A3PL_Freight_DestroyFees",
{
	private _fees = 3000 + round(random 8600);
	private _currentBank = player getVariable["Player_Bank",0];
	if(_fees > _currentBank) then {
		player setVariable["Player_Bank",0,true];
		[format["You destroyed your plane with the freight inside, you paid $%1!",_fees],"red"] call A3PL_Player_Notification;
	} else {
		player setVariable["Player_Bank",_currentBank-_fees,true];
		[format["You destroyed your plane with the freight inside, you paid $%1!",_fees],"red"] call A3PL_Player_Notification;
	};
	player setVariable["deliveryPlane",nil];
	player setVariable["job","unemployed",true];
}] call Server_Setup_Compile;

["A3PL_Freight_End",
{
	private _pay = param[0,0];
	if(_pay > 0) then {
		[format["Delivery successful! Your $%1 paycheck is waiting for you at your bank!",_pay],"green"] call A3PL_Player_Notification;
		if(isNil "Player_Paycheck") then {Player_Paycheck = _pay;} else {Player_Paycheck = Player_Paycheck + _pay;};
		[player, Player_Paycheck] remoteExec ["Server_Player_UpdatePaycheck",2];
	};
	private _plane = player getVariable["deliveryPlane",objNull];
	_plane setVariable["onDelivery",false,true];
	player setVariable["deliveryPlane",nil];
	player setVariable["job","unemployed",true];
}] call Server_Setup_Compile;

["A3PL_Freight_DestString",
{
	private _delPoint = str(param [0,objNull]);
	private _return = "unknown";
	if(_delPoint isEqualTo "npc_freight_svt") then {_return="Silverton Airfield";};
	if(_delPoint isEqualTo "npc_freight_nd") then {_return="Northdale Airfield";};
	if(_delPoint isEqualTo "npc_freight_lubbock") then {_return="Lubbock Airfield";};
	_return;
}] call Server_Setup_Compile;

["A3PL_Freight_CargoValue",
{
	private _plane = typeOf(param [0,objNull]);
	private _return = 3000;
	if(_plane isEqualTo "A3PL_Cessna172") then {_return = _return + 4350};
	if(_plane isEqualTo "A3PL_Goose_Base") then {_return = _return + 5700};
	_return;
}] call Server_Setup_Compile;
