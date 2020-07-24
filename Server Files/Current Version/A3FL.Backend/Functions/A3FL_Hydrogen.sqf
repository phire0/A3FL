/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define DEFGALLONPRICE 20

["A3PL_Hydrogen_SetPrice",
{
	disableSerialization;
	private ["_display","_newPrice","_station","_gp"];
	_display = findDisplay 69;

	_station = nearestobjects [player,["Land_A3PL_Gas_Station"],30];
	if (count _station < 1) exitwith {[localize"STR_NewHydrogen_1","red"] call A3PL_Player_Notification;};
	_station = _station select 0;

	if ((_station getVariable ["bOwner","0"]) != (getPlayerUID player)) exitwith {[localize"STR_NewHydrogen_2","red"] call A3PL_Player_Notification;};

	_newPrice = parseNumber (ctrlText (_display displayCtrl 1400));

	if (_newPrice < 15) exitwith {[format [localize"STR_NewHydrogen_3"],"red"] call A3PL_Player_Notification};
	if (_newPrice > 90) exitwith {[format [localize"STR_NewHydrogen_4"],"red"] call A3PL_Player_Notification};

	(_display displayCtrl 1400) ctrlSetText format ["%1",_newPrice];
	_station setVariable ["gallonprice",_newPrice,true];
	_gp = parseNumber(format["%1",((str(_newPrice) splitstring "") select 0)])*1000;

	if (_newPrice >= 10) then {
		_gp = parseNumber(format["%2%1",((str(_newPrice) splitstring "") select 0),((str(_newPrice) splitstring "") select 1)])*100;
	};

	if (_newPrice >= 100) then {
		_gp = parseNumber(format["%1%3%2",((str(_newPrice) splitstring "") select 0),((str(_newPrice) splitstring "") select 1),((str(_newPrice) splitstring "") select 2)])*100;
	};

	[_station,4,([_gp,1,2] call CBA_fnc_formatNumber),([_gp,1,2] call CBA_fnc_formatNumber)] call A3PL_Hydrogen_SetNumbers;
	[localize"STR_NewHydrogen_5","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Hydrogen_Open",
{
	disableSerialization;
	private ["_display","_station","_gallons","_price"];
	_station = nearestobjects [player,["Land_A3PL_Gas_Station"],30];
	if (count _station < 1) exitwith {[localize"STR_NewHydrogen_6","red"] call A3PL_Player_Notification;};
	_station = _station select 0;

	createDialog "Dialog_GasStation";

	_display = findDisplay 69;
	(_display displayCtrl 1400) ctrlSetText format ["%1",_station getVariable ["gallonprice",DEFGALLONPRICE]];

	_gallons = (_station getVariable ["pump1",[0,0]]) select 0;
	_price = (_station getVariable ["pump1",[0,0]]) select 1;
	(_display displayCtrl 1401) ctrlSetText format ["%1 Gallons",_gallons];
	(_display displayCtrl 1402) ctrlSetText format ["%1%2","$",_price];

	_gallons = (_station getVariable ["pump2",[0,0]]) select 0;
	_price = (_station getVariable ["pump2",[0,0]]) select 1;
	(_display displayCtrl 1403) ctrlSetText format ["%1 Gallons",_gallons];
	(_display displayCtrl 1404) ctrlSetText format ["%1%2","$",_price];

	_gallons = (_station getVariable ["pump3",[0,0]]) select 0;
	_price = (_station getVariable ["pump3",[0,0]]) select 1;
	(_display displayCtrl 1405) ctrlSetText format ["%1 Gallons",_gallons];
	(_display displayCtrl 1406) ctrlSetText format ["%1%2","$",_price];

	_gallons = (_station getVariable ["pump4",[0,0]]) select 0;
	_price = (_station getVariable ["pump4",[0,0]]) select 1;
	(_display displayCtrl 1407) ctrlSetText format ["%1 Gallons",_gallons];
	(_display displayCtrl 1408) ctrlSetText format ["%1%2","$",_price];

	(_display displayCtrl 1409) ctrlSetText format ["%1 gallons",(_station getVariable ["petrol",0])];

	_playerLevel = player getVariable["Player_Level",0];
}] call Server_Setup_Compile;

["A3PL_Hydrogen_Grab",
{
	private _intersect = param [0,objNull];
	if(typeOf _intersect == "Land_A3PL_Gas_Station") then {_intersect = (nearestObjects [player, ["A3PL_Gas_Hose"], 5] select 0);};
	if (!(typeOf _intersect IN ["A3PL_Gas_Hose","A3PL_GasHose"])) exitwith {[localize"STR_NewHydrogen_7", "red"] call A3PL_Player_Notification;};
	if ((isPlayer attachedTo _intersect) && (!((attachedTo _intersect) isKindOf "Car"))) exitwith {[localize"STR_NewHydrogen_8", "red"] call A3PL_Player_Notification;};

	private _tank = nearestObjects [player, ["A3PL_Gas_Box"], 30];
	if (typeOf _intersect == "A3PL_GasHose") then {_tank = nearestObjects [player, ["A3PL_Fuel_Van"], 30];};
	if (count _tank == 0) exitwith {[localize"STR_NewHydrogen_9", "red"] call A3PL_Player_Notification;};
	_tank = _tank select 0;

	_intersect attachto [player, [0,0,0.2], 'RightHand'];
	if (typeOf _intersect == "A3PL_GasHose") then {_intersect setDir 180};
	uiSleep 1.5;
	[_tank,player] remoteExec ["A3PL_Lib_ChangeLocality", 2];
	[_intersect,player] remoteExec ["A3PL_Lib_ChangeLocality", 2];

	player_Item = _intersect;
	while {attachedTo _intersect == player} do {
		if (((typeOf _tank == "A3PL_Gas_Box") && (_intersect distance _tank > 5))or((typeOf _tank == "A3PL_Fuel_Van") && (_intersect distance _tank > 28))) exitwith {detach _intersect;[localize"STR_NewHydrogen_10", "red"] call A3PL_Player_Notification;};
		if (!(vehicle player == player)) exitwith {detach _intersect; [localize"STR_NewHydrogen_11", "red"] call A3PL_Player_Notification;};
		uisleep 1;
	};
	player_Item = objNull;
}] call Server_Setup_Compile;

["A3PL_Hydrogen_LoadPetrol",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_barrel","_tanker"];
	_barrel = param [0,objNull];
	_tanker = (nearestObjects [player, ["A3PL_Tanker_Trailer","A3PL_Fuel_Van"], 10]) select 0;
	if (isNil "_tanker") exitwith {[localize"STR_NewHydrogen_12","red"] call A3PL_Player_Notification;};

	_exit = false;
	if(typeOf _tanker == "A3PL_Fuel_Van") then {
		_gasType = _tanker getVariable["gas", nil];
		_amount = _tanker getVariable ["petrol",0];
		if(!isNil "_gasType") then {
			if((_gasType == "kerosene") && (_amount > 0)) exitWith {_exit = true;};
		};
	};
	if(_exit) exitWith {[localize"STR_NewHydrogen_52","red"] call A3PL_Player_Notification;};

	deleteVehicle _barrel;
	_tanker setVariable["gas", "petrol", true];
	_tanker setVariable ["petrol",(_tanker getVariable ["petrol",0]) + 42,true];
	[format [localize"STR_NewHydrogen_13",(_tanker getVariable ["petrol",0])],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Hydrogen_LoadKerosene",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_barrel","_tanker"];
	_barrel = param [0,objNull];
	_tanker = (nearestObjects [player, ["A3PL_Fuel_Van"], 10]) select 0;
	if (isNil "_tanker") exitwith {[localize"STR_NewHydrogen_14","red"] call A3PL_Player_Notification;};

	_exit = false;
	if(typeOf _tanker == "A3PL_Fuel_Van") then {
		_gasType = _tanker getVariable["gas", nil];
		_amount = _tanker getVariable ["petrol",0];
		if(!isNil "_gasType") then {
			if((_gasType == "petrol") && (_amount > 0)) exitWith {_exit = true;};
		};
	};
	if(_exit) exitWith {[localize"STR_NewHydrogen_51","red"] call A3PL_Player_Notification;};

	deleteVehicle _barrel;
	_tanker setVariable["gas", "kerosene", true];
	_tanker setVariable ["petrol",(_tanker getVariable ["petrol",0]) + 42,true];
	[format [localize"STR_NewHydrogen_15",(_tanker getVariable ["petrol",0])],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Hydrogen_Connect",
{
	private ["_intersect","_attached","_hose","_tank","_dir","_setdir"];
	_intersect = param [0,objNull];

	_attached = [] call A3PL_Lib_Attached;
	if (count _attached == 0) exitwith {[localize"STR_NewHydrogen_16", "red"] call A3PL_Player_Notification;};
	_hose = _attached select 0;
	if (!(typeOf _hose IN ["A3PL_Gas_Hose","A3PL_GasHose"])) exitwith {[localize"STR_NewHydrogen_17", "red"] call A3PL_Player_Notification;};
	_tank = nearestObjects [player, ["A3PL_Gas_Box"], 30];
	_tank = _tank select 0;

	if ((typeOf _intersect == "Land_A3PL_Gas_Station") && (player_nameintersect IN ["hoseback1","hoseback2","hoseback3","hoseback4"])) exitwith
	{
		detach _hose;
		switch (player_nameintersect) do
		{
			case ("hoseback1"): {_hose attachTo [_tank,[-0.012,-0.09,-1.18]];};
			case ("hoseback2"): {_hose attachTo [_tank,[-0.012,0.10,-1.38]]; _hose setDir 180;};
			case ("hoseback3"): {_hose attachTo [_tank,[-0.006,-0.13,-1.23]];};
			case ("hoseback4"): {_hose attachTo [_tank,[-0.006,-0.13,-1.23]];};
		};
		player_Item = objNull;
	};

	if (!(_intersect isKindOf "All")) exitwith {[localize"STR_NewHydrogen_18", "red"] call A3PL_Player_Notification;};
	_classname = typeOf player_objintersect;
	_vector = [[0.320857,-0.0197785,-0.946921],[0.946907,0.0282805,0.320261]];
	_attachTo = [-0.1,0,0];
	_maxlength = 0;
	_setdir = 270;

	if ((typeOf _hose) isEqualTo "A3PL_Gas_Hose") then
	{
		switch (true) do
		{
			case (_classname IN ["A3PL_P362","A3PL_P362_TowTruck","A3PL_P362_Garbage_Truck"]): {_vector = [[-0.584987,0.000326949,-0.811043],[0.811043,-0.000109344,-0.584987]];_attachTo = [-0.08,0,0.05];};
			case (_classname IN ["A3PL_Rover"]): {_vector = [[-0.213246,-0.0863852,-0.973172],[-0.976888,0.0338489,0.211056]];_attachTo = [-0.1,0,-0.04];};
			case (_classname IN ["A3PL_BMW_M3"]): {_vector = [[-0.213246,-0.0863852,-0.973172],[-0.976888,0.0338489,0.211056]];_attachTo = [-0.04,0,-0.04];};
			case (_classname IN ["A3PL_911GT2"]): {_vector = [[-0.584987,0.000326949,-0.811043],[0.811043,-0.000109344,-0.584987]];_attachTo = [-0.07,0,0.04];};
			case (_classname IN ["A3PL_RBM"]): {_vector = [[-0.213246,-0.0863852,-0.973172],[-0.976888,0.0338489,0.211056]];_attachTo = [0.1,0,0];};
			case (_classname IN ["A3PL_CLS63"]): {_vector = [[-0.213246,-0.0863852,-0.973172],[-0.976888,0.0338489,0.211056]];_attachTo = [0,0,0];};
			case (_classname IN ["A3PL_Urus"]): {_vector = [[-0.213246,-0.0863852,-0.973172],[-0.976888,0.0338489,0.211056]];_attachTo = [0.04,0,0.04];};
			case (_classname isEqualTo "A3PL_JerryCan"): {_vector = [[-0.213246,-0.0863852,-0.973172],[-0.976888,0.0338489,0.211056]];_attachTo = [0.3,0,0.2];};
			case (_classname IN ["A3PL_Taurus","A3PL_Taurus_PD","A3PL_Taurus_PD_ST"]): {_vector = [[-0.213246,-0.0863852,-0.973172],[-0.976888,0.0338489,0.211056]];_attachTo = [0.04,0,0.04];};
			default {_vector = [[0.320857,-0.0197785,-0.946921],[0.946907,0.0282805,0.320261]];_attachTo = [-0.1,0,0];_maxlength = 7;};
		};

		_hose attachTo [_intersect,_attachTo,"gasTank"];
		uiSleep 0.2;
		_hose setVectorDirAndUp _vector;
		_maxlength = 10;
	};
	if (typeOf _hose == "A3PL_GasHose") then
	{
		switch (true) do
		{
			case (_classname IN ["A3PL_RBM"]): {_setdir = 90;_attachTo = [0.1,0,0];_maxlength = 30;};
			case (_classname IN ["Heli_Medium01_H","Heli_Medium01_Luxury_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Medic_H"]): {_setdir = 90;_attachTo = [0.1,0,0];_maxlength = 30;};
			case (_classname IN ["A3PL_Cessna172","A3PL_Goose_Base","A3PL_Goose_Radar","A3PL_Goose_USCG"]): {_setdir = 90;_attachTo = [0,0,-0.07];_maxlength = 30;_vector = [[0.0389273,-0.110648,-0.993097],[0.0389949,-0.992925,0.112158]];};
			case (_classname IN ["A3PL_RHIB","A3PL_Yacht"]): {_setdir = 180;_attachTo = [0,-0.1,0];_maxlength = 30;};
			case (_classname IN ["A3PL_Jayhawk"]): {_setdir = 90;_attachTo = [0.2,0,0];_maxlength = 30;};
			case (_classname IN ["A3PL_Motorboat"]): {_setdir = 90;_attachTo = [0,0,0.07];_maxlength = 30;_vector = [[0,-0.110648,0.993097],[0,-0.992925,-0.112158]];};
			default {_setdir = 270;_attachTo = [-0.1,0,0];_maxlength = 30;};
		};
		_hose attachTo [_intersect,_attachTo,"gasTank"];
		_dir = getDir _hose;
		uiSleep 0.2;
		if (_classname IN ["A3PL_Cessna172","A3PL_Goose_Base","A3PL_Goose_Radar","A3PL_Goose_USCG","A3PL_Motorboat"]) then {_hose setVectorDirAndUp _vector;}else
		{_hose setDir (_dir + (_setdir - (getDir _intersect)));};
		_tank = nearestObject [player, "A3PL_Fuel_Van"];
	};
	while {attachedTo _hose == _intersect} do
	{
		uiSleep 0.1;
		if ((_hose distance _tank) > _maxlength) exitwith
		{
			detach _hose;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Hydrogen_SetNumbers",
{
	private ["_station","_pumpNumber","_gallons","_price","_gallonAD","_gallonBD","_priceAD","_priceBD"];
	_station = param [0,objNull];
	_pumpNumber = param [1,1];
	_gallons = param [2,"0.00"];
	_price = param [3,"0.00"];

	_gallonBD = (_gallons splitstring ".") select 0;
	_gallonAD = (_gallons splitstring ".") select 1;
	_priceBD = (_price splitstring ".") select 0;
	_priceAD = (_price splitstring ".") select 1;

	switch (count _gallonBD) do
	{
		case (1): {_gallonBD = format ["0000%1",_gallonBD]};
		case (2): {_gallonBD = format ["000%1",_gallonBD]};
		case (3): {_gallonBD = format ["00%1",_gallonBD]};
		case (4): {_gallonBD = format ["0%1",_gallonBD]};
		case (5): {_gallonBD = format ["%1",_gallonBD]};
	};

	switch (count _priceBD) do
	{
		case (1): {_priceBD = format ["0000%1",_priceBD]};
		case (2): {_priceBD = format ["000%1",_priceBD]};
		case (3): {_priceBD = format ["00%1",_priceBD]};
		case (4): {_priceBD = format ["0%1",_priceBD]};
		case (5): {_priceBD = format ["%1",_priceBD]};
	};


	_startSel = 2 + ((_pumpNumber - 1) * 16);
	for "_i" from 0 to 7 do
	{
		if (_i == 5) then {_station setObjectTextureGlobal [_startSel,""]};
		if (_i < 5) then { _station setObjectTextureGlobal [_startSel,format ["\A3PL_Common\HydrogenNumbers\%1.paa",_priceBD select [_i,1]]];};
		if (_i > 5) then { _station setObjectTextureGlobal [_startSel,format ["\A3PL_Common\HydrogenNumbers\%1.paa",_priceAD select [(_i-6),1]]];};
		_startSel = _startSel + 1;
	};

	_startSel = 10 + ((_pumpNumber - 1) * 16);
	for "_i" from 0 to 7 do
	{
		if (_i == 5) then {_station setObjectTextureGlobal [_startSel,""]};
		if (_i < 5) then { _station setObjectTextureGlobal [_startSel,format ["\A3PL_Common\HydrogenNumbers\%1.paa",_gallonBD select [_i,1]]] };
		if (_i > 5) then { _station setObjectTextureGlobal [_startSel,format ["\A3PL_Common\HydrogenNumbers\%1.paa",_gallonAD select [(_i-6),1]]] };
		_startSel = _startSel + 1;
	};

}] call Server_Setup_Compile;

["A3PL_Hydrogen_SwitchFuel",
{
	private ["_intersect","_tank","_car","_gallonPrice","_myPrice","_station","_gallons","_pumpNumber","_newgas","_totalGallons","_sOUID","_sOwner","_sValidOwner"];
	_intersect = param [0,objNull];

	if (isNil "CBA_fnc_formatNumber") exitwith {["localizeCSTR_NewHydrogen_19", "red"] call A3PL_Player_Notification;};
	if (!(typeOf _intersect IN ["A3PL_Gas_Hose","A3PL_GasHose"])) exitwith {[localize"STR_NewHydrogen_20", "red"] call A3PL_Player_Notification;};
	if (typeOf _intersect == "A3PL_Gas_Hose") then
	{
		_tank = nearestObjects [player, ["A3PL_Gas_Box"], 30];
		if (count _tank == 0) exitwith {[localize"STR_NewHydrogen_21", "red"] call A3PL_Player_Notification;};
		_tank = _tank select 0;

		if (_intersect animationPhase "gasTurn" > 0) exitwith
		{
			_intersect animate ["gasTurn",0];
			{
				_type = format["%1",typeOf _x];
				if(_type == "#dynamicsound") then {
					deleteVehicle _x;
				};
			} foreach nearestObjects [_tank,[],5];
		};

		_car = attachedTo _intersect;
		if((typeOf _car) isEqualTo "A3PL_JerryCan") exitWith {[_intersect] call A3PL_Hydrogen_FuelJerry;};
		if ((isNull _car) or (!(_car isKindOf "Car"))) exitwith {[localize"STR_NewHydrogen_22", "red"] call A3PL_Player_Notification;};

		if (!local _car) exitwith {[localize"STR_NewHydrogen_23", "red"] call A3PL_Player_Notification;};

		_station = nearestObjects [_tank,["Land_A3PL_Gas_Station"],10];
		if (count _station < 1) exitwith {[localize"STR_NewHydrogen_24", "red"] call A3PL_Player_Notification;};
		_station = _station select 0;
		if (!(_station getVariable ["pumpEnabled",true])) exitwith {
			[localize"STR_NewHydrogen_25","red"] call A3PL_Player_Notification;
		};
		if ((_station getVariable ["petrol",0]) <= 0) exitwith {[localize"STR_NewHydrogen_26","red"] call A3PL_Player_Notification;};
		createSoundSource ["A3PL_GasPump",getpos _tank, [], 0];

		_intersect animate ["gasTurn",1];

		_i = 0;
		waitUntil {sleep 0.1; _i = _i + 0.1; if (_i > 5) exitwith {true}; (_intersect animationPhase "gasTurn" > 0)};

		_gallonPrice = _station getVariable ["gallonprice",DEFGALLONPRICE];
		_myPrice = 0;
		_totalGallons = 0;
		_pumpNumber = 1;
		switch (format ["%1",_tank]) do
		{
			case ("A3PL_GasBox1"): {_pumpNumber = 1;};
			case ("A3PL_GasBox2"): {_pumpNumber = 1;};
			case ("A3PL_GasBox3"): {_pumpNumber = 1;};
			case ("A3PL_GasBox4"): {_pumpNumber = 1;};
			case ("A3PL_GasBox5"): {_pumpNumber = 1;};
			case ("A3PL_GasBox6"): {_pumpNumber = 1;};
			case ("A3PL_GasBox7"): {_pumpNumber = 1;};
		};
		while {(_intersect animationPhase "gasTurn" > 0) && (attachedTo _intersect == _car) && ((_station getVariable ["petrol",0]) > 0)} do
		{
			_gallons = 0.25 + random 0.15;
			_totalgallons = _totalGallons + _gallons;
			_myPrice = round(_gallonPrice * _totalGallons);

			[_station,1,([_totalGallons,1,2] call CBA_fnc_formatNumber),([_myprice,1,2] call CBA_fnc_formatNumber)] call A3PL_Hydrogen_SetNumbers;
			[_station,2,([_totalGallons,1,2] call CBA_fnc_formatNumber),([_myprice,1,2] call CBA_fnc_formatNumber)] call A3PL_Hydrogen_SetNumbers;
			[_station,3,([_totalGallons,1,2] call CBA_fnc_formatNumber),([_myprice,1,2] call CBA_fnc_formatNumber)] call A3PL_Hydrogen_SetNumbers;

			_car setFuel ((fuel _car) + (_totalGallons / 350));
			if ((fuel _car) >= 1) exitwith {};
			_newgas = (_station getVariable ["petrol",0]) - _gallons;
			if (_newGas < 0) then {_newGas = 0;};
			_station setVariable ["petrol",_newGas,true];
			uiSleep 1;
		};
		if ((_station getVariable ["petrol",0]) <= 0) then {[localize"STR_NewHydrogen_27","red"] call A3PL_Player_Notification;};
		[format [localize"STR_NewHydrogen_28",_myprice], "green"] call A3PL_Player_Notification;
		_station setVariable [format ["pump%1",_pumpNumber],[[_totalGallons,1,2] call CBA_fnc_formatNumber,[_myprice,1,2] call CBA_fnc_formatNumber],true];
		_sOUID = _station getVariable ["bOwner","0"];
		_sOwner = nil;
		_sValidOwner = false;

		if(_sOUID != "0") then {
			{
				if((getPlayerUID _x) == _sOUID) exitwith {_sOwner = _x; _sValidOwner = true;};
			} forEach allPlayers;
		};

		if(_sOUID != (getPlayerUID player)) then {
			if(_sValidOwner) then {
				[player,_sOwner,_myprice,_station,true] remoteExec ["Server_Fuel_Pay", 2];
			} else {
				[player,objNull,_myprice,_station,false] remoteExec ["Server_Fuel_Pay", 2];
			};
		} else {
			[localize"STR_NewHydrogen_29", "yellow"] call A3PL_Player_Notification;
		};

		_intersect animate ["gasTurn",0];
		{
			_type = format["%1",typeOf _x];
			if(_type == "#dynamicsound") then {
				deleteVehicle _x;
			};
		} foreach nearestObjects [_tank,[],5];
	};
	if (typeOf _intersect == "A3PL_GasHose") then
	{
		_car = attachedTo _intersect;
		_tank = nearestObjects [player, ["A3PL_Fuel_Van"], 30];
		if (count _tank == 0) exitwith {[localize"STR_NewHydrogen_30", "red"] call A3PL_Player_Notification;};
		_tank = _tank select 0;

		_exit = false;
		if(typeOf _car IN ["A3PL_Cessna172","A3PL_Goose_Base","A3PL_Goose_USCG","A3PL_Jayhawk","Heli_Medium01_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","Heli_Medium01_Coastguard_H"]) then {
			_required = "kerosene";
		} else {
			_required = "petrol";
		};
		_gasType = _tank getVariable["gas", "petrol"];
		if(_gasType != _required) exitWith {_exit = true;};
		if(_exit) exitWith {[localize"STR_NewHydrogen_53", "red"] call A3PL_Player_Notification;};

		if (_intersect animationPhase "gasTurn" > 0) exitwith
		{
			_intersect animate ["gasTurn",0];
			{
				_type = format["%1",typeOf _x];
				if(_type == "#dynamicsound") then {
					deleteVehicle _x;
				};
			} foreach nearestObjects [_tank,[],5];
		};

		_intersect animate ["gasTurn",1];
		_i = 0;
		waitUntil {sleep 0.1; _i = _i + 0.1; if (_i > 5) exitwith {true}; (_intersect animationPhase "gasTurn" > 0)};

		_totalGallons = 0;
		if ((isNull _car) or ((_car isKindOf "Land"))) exitwith {[localize"STR_NewHydrogen_31", "red"] call A3PL_Player_Notification;};

		if (!local _car) exitwith {[localize"STR_NewHydrogen_32", "red"] call A3PL_Player_Notification;};
		createSoundSource ["A3PL_GasPump",getpos _tank, [], 0];
		while {(_intersect animationPhase "gasTurn" > 0) && (attachedTo _intersect == _car) && ((_tank getVariable ["petrol",0]) > 0)&& ({(typeOf _x == "a3pl_fd_hoseend1")} forEach attachedObjects _tank)} do
		{
			_gallons = 1 + random 0.60;
			_totalgallons = _totalGallons + _gallons;
			_car setFuel ((fuel _car) + (_totalGallons / 1400));
			if ((fuel _car) >= 1) exitwith {};
			_newgas = (_tank getVariable ["petrol",0]) - _gallons;
			if (_newGas < 0) then {_newGas = 0;};
			_tank setVariable ["petrol",_newGas,true];
			uiSleep 1;
		};
		_Gas = round (_tank getVariable ["petrol",0]);
		if ((_tank getVariable ["petrol",0]) <= 0) then {[localize"STR_NewHydrogen_33","red"] call A3PL_Player_Notification;};
		[format [localize"STR_NewHydrogen_34",_Gas], "green"] call A3PL_Player_Notification;
		_intersect animate ["gasTurn",0];
		{
			_type = format["%1",typeOf _x];
			if(_type == "#dynamicsound") then {
				deleteVehicle _x;
			};
		} foreach nearestObjects [_tank,[],5];
	};
}] call Server_Setup_Compile;

["A3PL_Hydrogen_FuelJerry",
{
	private _intersect = param [0,objNull];
	if (isNil "CBA_fnc_formatNumber") exitwith {["localizeCSTR_NewHydrogen_19", "red"] call A3PL_Player_Notification;};
	if (!((typeOf _intersect) isEqualTo "A3PL_Gas_Hose")) exitwith {[localize"STR_NewHydrogen_20", "red"] call A3PL_Player_Notification;};

	private _tank = nearestObjects [player, ["A3PL_Gas_Box"], 30];
	if (count _tank == 0) exitwith {[localize"STR_NewHydrogen_21", "red"] call A3PL_Player_Notification;};
	_tank = _tank select 0;

	if (_intersect animationPhase "gasTurn" > 0) exitwith
	{
		_intersect animate ["gasTurn",0];
		{
			_type = format["%1",typeOf _x];
			if(_type isEqualTo "#dynamicsound") then {
				deleteVehicle _x;
			};
		} foreach nearestObjects [_tank,[],5];
	};

	private _jerry = attachedTo _intersect;
	if((_jerry getVariable["class",""]) isEqualTo "jerrycan") exitwith {["This jerrycan is already full", "red"] call A3PL_Player_Notification;};
	private _station = nearestObjects [_tank,["Land_A3PL_Gas_Station"],10];
	if ((count _station) < 1) exitwith {[localize"STR_NewHydrogen_24", "red"] call A3PL_Player_Notification;};
	_station = _station select 0;
	if (!(_station getVariable ["pumpEnabled",true])) exitwith {
		[localize"STR_NewHydrogen_25","red"] call A3PL_Player_Notification;
	};
	if ((_station getVariable ["petrol",0]) <= 0) exitwith {[localize"STR_NewHydrogen_26","red"] call A3PL_Player_Notification;};
	createSoundSource ["A3PL_GasPump",getpos _tank, [], 0];

	_intersect animate ["gasTurn",1];
	private _i = 0;
	waitUntil {sleep 0.1; _i = _i + 0.1; if (_i > 5) exitwith {true}; (_intersect animationPhase "gasTurn" > 0)};

	private _gallonPrice = _station getVariable ["gallonprice",DEFGALLONPRICE];
	private _myPrice = 0;
	private _totalGallons = 0;
	private _full = false;
	while {(_intersect animationPhase "gasTurn" > 0) && ((attachedTo _intersect) isEqualTo _jerry) && ((_station getVariable ["petrol",0]) > 0)} do
	{
		_gallons = 0.25 + random 0.15;
		_totalGallons = _totalGallons + _gallons;
		_myPrice = round(_gallonPrice * _totalGallons);

		[_station,1,([_totalGallons,1,2] call CBA_fnc_formatNumber),([_myPrice,1,2] call CBA_fnc_formatNumber)] call A3PL_Hydrogen_SetNumbers;
		[_station,2,([_totalGallons,1,2] call CBA_fnc_formatNumber),([_myPrice,1,2] call CBA_fnc_formatNumber)] call A3PL_Hydrogen_SetNumbers;
		[_station,3,([_totalGallons,1,2] call CBA_fnc_formatNumber),([_myPrice,1,2] call CBA_fnc_formatNumber)] call A3PL_Hydrogen_SetNumbers;
		if (_totalGallons >= 5) exitwith {_full = true;};
		_newgas = (_station getVariable ["petrol",0]) - _gallons;
		if (_newGas < 0) then {_newGas = 0;};
		_station setVariable ["petrol",_newGas,true];
		sleep 1;
	};
	if(_full) then {_jerry setVariable["class","jerrycan",true];};

	if ((_station getVariable ["petrol",0]) <= 0) then {[localize"STR_NewHydrogen_27","red"] call A3PL_Player_Notification;};
	[format [localize"STR_NewHydrogen_28",_myPrice], "green"] call A3PL_Player_Notification;
	_station setVariable [format ["pump%1",1],[[_totalGallons,1,2] call CBA_fnc_formatNumber,[_myPrice,1,2] call CBA_fnc_formatNumber],true];
	

	_sOUID = _station getVariable ["bOwner","0"];
	_sOwner = nil;
	_sValidOwner = false;

	if(_sOUID != "0") then {
		{
			if((getPlayerUID _x) isEqualTo _sOUID) exitwith {_sOwner = _x; _sValidOwner = true;};
		} forEach allPlayers;
	};

	if(_sOUID != (getPlayerUID player)) then {
		if(_sValidOwner) then {
			[player,_sOwner,_myPrice,_station,true] remoteExec ["Server_Fuel_Pay", 2];
		} else {
			[player,objNull,_myPrice,_station,false] remoteExec ["Server_Fuel_Pay", 2];
		};
	} else {
		[localize"STR_NewHydrogen_29", "yellow"] call A3PL_Player_Notification;
	};

	_intersect animate ["gasTurn",0];
	{
		_type = format["%1",typeOf _x];
		if(_type isEqualTo "#dynamicsound") then {
			deleteVehicle _x;
		};
	} foreach nearestObjects [_tank,[],5];
}] call Server_Setup_Compile;

["A3PL_Hydrogen_StorageSwitch",
{
	private ["_station","_i","_adapter","_end","_source","_newSource","_newStorage","_amount"];
	_station = param [0,objNull];

	if (_station animationSourcePhase "hoseSwitch" > 0) exitwith {_station animateSource ["hoseSwitch",0]};

	_adapter = nearestObjects [(_station modelToWorld [-3.76154,3.51953,-2.05121]), ["A3PL_FD_HoseEnd1_Float"], 1];
	_adapter = _adapter select 0;
	if (isNil "_adapter") exitwith {[localize"STR_NewHydrogen_35","red"] call A3PL_Player_Notification;};
	_end = attachedObjects _adapter;
	_end = _end select 0;
	if (isNil "_end") exitwith {[localize"STR_NewHydrogen_36","red"] call A3PL_Player_Notification;};
	_source = [_end] call A3PL_FD_FindSource;
	if (isNull _source) exitwith {[localize"STR_NewHydrogen_37","red"] call A3PL_Player_Notification;};
	_exit = false;
	if(typeOf _source == "A3PL_Fuel_Van") then {
		_gasType = _source getVariable["gas", nil];
		if(isNil "_gasType") exitWith {_exit = true;};
		if(_gasType == "kerosene") exitWith {_exit = true;};
	};
	if(_exit) exitWith {};
	if ((_source getVariable ["petrol",0]) <= 0) exitwith {[localize"STR_NewHydrogen_38","red"] call A3PL_Player_Notification;};

	_station animateSource ["hoseSwitch",1];
	_i = 0;
	waitUntil {sleep 0.1; _i = _i + 0.1; if (_i > 5) exitwith {true}; (_station animationSourcePhase "hoseSwitch" > 0)};
	while {((_source getVariable ["petrol",0]) > 0) && (!isNull _source) && (_station animationSourcePhase "hoseSwitch" > 0)} do
	{
		_amount = 2;
		if ((_source getVariable ["petrol",0]) < _amount) then {_amount = _source getVariable ["petrol",0]};
		_newSource = (_source getVariable ["petrol",0]) - _amount; if (_newSource < 0) then {_newSource = 0;};
		_newStorage = (_station getVariable ["petrol",0]) + _amount; if (_newStorage < 0) then {_newStorage = 0;};
		_source setVariable ["petrol",_newSource,true];
		_station setVariable ["petrol",_newStorage,true];
		player setVariable["Player_Cash",(player getVariable["Player_Cash",0]) + 10,true];
		uiSleep 2;
		_source = [_end] call A3PL_FD_FindSource;
	};
	[localize"STR_NewHydrogen_40","green"] call A3PL_Player_Notification;
	_station animateSource ["hoseSwitch",0];
}] call Server_Setup_Compile;

["A3PL_Hydrogen_LockUnlock",
{
	_station = nearestobjects [player,["Land_A3PL_Gas_Station"],30];
	if (count _station < 1) exitwith {[localize"STR_NewHydrogen_42","red"] call A3PL_Player_Notification;};
	_station = _station select 0;

	if ((_station getVariable ["bOwner","0"]) != (getPlayerUID player)) exitwith {[localize"STR_NewHydrogen_43","red"] call A3PL_Player_Notification;};

	if (!(_station getVariable ["pumpEnabled",true])) exitwith {
		_station setVariable ["pumpEnabled",true,true];
		[localize"STR_NewHydrogen_44","green"] call A3PL_Player_Notification;
	};
	if (_station getVariable ["pumpEnabled",true]) exitwith {
		_station setVariable ["pumpEnabled",false,true];
		[localize"STR_NewHydrogen_45","green"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Hydrogen_CheckCash",
{
	private ["_station"];
	_station = nearestobjects [player,["Land_A3PL_Gas_Station"],30];
	if (count _station < 1) exitwith {[localize"STR_NewHydrogen_46","red"] call A3PL_Player_Notification;};
	_station = _station select 0;
	if ((_station getVariable ["bOwner","0"]) != (getPlayerUID player)) exitwith {[localize"STR_NewHydrogen_47","red"] call A3PL_Player_Notification;};
	[format [localize"STR_NewHydrogen_48",_station getVariable ["bCash","0"]],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Hydrogen_TakeCash",
{
	private ["_station"];
	_station = nearestobjects [player,["Land_A3PL_Gas_Station"],30];
	if (count _station < 1) exitwith {[localize"STR_NewHydrogen_49","red"] call A3PL_Player_Notification;};
	_station = _station select 0;
	if ((_station getVariable ["bOwner","0"]) != (getPlayerUID player)) exitwith {[localize"STR_NewHydrogen_50","red"] call A3PL_Player_Notification;};
	player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
	[player,_station] remoteExec ["Server_Fuel_TakeCash", 2];
}] call Server_Setup_Compile;
