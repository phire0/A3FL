/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Storage_CarRetrieveButton",
{
	disableSerialization;
	private ["_display","_control","_intersect","_spawnPos","_dir","_exit"];
	_display = findDisplay 145;
	_control = _display displayCtrl 1500;
	_intersect = player_objintersect;

	if(!(call A3PL_Player_AntiSpam)) exitWith {};

	if ((isNil "player_objintersect") || (player_objintersect isEqualTo player)) then {
		_intersect = cursorObject;
	} else {
		_intersect = player_objIntersect;
	};
	if (isNull _intersect) exitwith {closeDialog 0; [localize"STR_NewStorage_1", "red"] call A3PL_Player_Notification;};
	if (_intersect animationPhase "StorageDoor1" > 0.1) exitwith {closeDialog 0; [localize"STR_NewStorage_2", "red"] call A3PL_Player_Notification;};

	if((lbCurSel _control) < 0) exitWith {};
	if(A3PL_Storage_ReturnArray isEqualTo []) exitWith {["Error while loading your vehicle, please try again", "red"] call A3PL_Player_Notification;closeDialog 0;};
	_array = (A3PL_Storage_ReturnArray select (lbCurSel _control));
	_id = _array select 0;
	_class = _array select 1;

	_spawnPos = _intersect getVariable ["positionSpawn",nil];
	_exit = false;
	if ((_intersect isKindOf "Land_Home1g_DED_Home1g_01_F") OR (typeOf _intersect IN ["Land_A3PL_Ranch1","Land_A3PL_Ranch2","Land_A3PL_Ranch3","Land_A3PL_Sheriffpd","Land_A3PL_Firestation","Land_A3PL_Showroom","Land_A3PL_Garage"])) then
	{
		_dir = getDir _intersect;
		switch (typeOf _intersect) do
		{
			case ("Land_Home1g_DED_Home1g_01_F"): {_spawnPos = _intersect modelToWorld [4.2,1.5,-3.2];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_Home2b_DED_Home2b_01_F"): {_spawnPos = _intersect modelToWorld [-4.42236,-1.39868,-3.26778];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_Home3r_DED_Home3r_01_F"): {_spawnPos = _intersect modelToWorld [-3,-1,-4];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_Home4w_DED_Home4w_01_F"): {_spawnPos = _intersect modelToWorld [4.3,-1,-3];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_Home5y_DED_Home5y_01_F"): {_spawnPos = _intersect modelToWorld [4.3,-1,-3];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_Home6b_DED_Home6b_01_F"): {_spawnPos = _intersect modelToWorld [3,-1,-4];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_A3PL_Ranch1"): {_spawnPos = _intersect modelToWorld [1,6.5,-2]; _dir = _dir - 90;_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_A3PL_Ranch2"): {_spawnPos = _intersect modelToWorld [1,6.5,-2]; _dir = _dir - 90;_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_A3PL_Ranch3"): {_spawnPos = _intersect modelToWorld [1,6.5,-2]; _dir = _dir - 90;_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_A3PL_Firestation"): {
				_pJob = player getVariable["job","unemployed"];
				if((["vfd",player] call A3PL_DMV_Check) || (_pJob isEqualTo "fifr")) then {
					_offset = [-11,-12,-7.5];
					if (player_NameIntersect isEqualTo "garagedoor2_button") then {_offset = [-4.8,-12,-7.5];};
					_spawnPos = _intersect modelToWorld _offset;
					_dir = _dir - 180;
					_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];
				} else {
					_exit = true;
				};
			};
			case ("Land_A3PL_Showroom"): {_spawnPos = _intersect modelToWorld [-6,-1,-3]; _dir = _dir - 180;_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_A3PL_Garage"): {_spawnPos = _intersect modelToWorld [0.85,0,-3]; _spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_A3PL_Sheriffpd"):
			{
				if (player_NameIntersect == "sdstoragedoor3") then {
					_spawnPos = _intersect modelToWorld [-2.2,0.1,-5.5];
					_intersect animateSource ["StorageDoor",1];
				};
				if (player_NameIntersect == "sdstoragedoor6") then {
					_spawnPos = _intersect modelToWorld [-2.2,3.8,-5.5];
					_intersect animateSource ["StorageDoor2",1];
				};
				_dir = _dir + 90;
				_spawnPos = [_spawnPos select 0,_spawnPos select 1,((_spawnPos select 2)+0),_dir];
			};
			_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];
		};
	};
	if(_exit) exitWith {["You are not allowed to use this garage","red"] call A3PL_Player_Notification;};
	if (!isNil "_spawnPos") then
	{
		_type = _intersect getVariable ["type","vehicle"];
		if(_type isEqualTo "vehicle") then {[_class,player,_id,_spawnPos] remoteExec ["Server_Storage_RetrieveVehicle", 2];};
		if (_type isEqualTo "plane") then {[_class,player,_id,_spawnPos] remoteExec ["Server_Storage_RetrieveVehicle", 2];};
		if (_type == "impound") then {
			_vehPrice = [_class] call A3PL_Config_GetVehicleMSRP;
			_price = 0;
			if (_VehPrice < 150000) then{
				_price = _vehPrice * 0.05;
			}
			else {
				_price = _vehPrice * 0.02;
			};
			_cash = player getVariable ["player_cash",0];
			_bank = player getVariable ["player_bank",0];
			if (_price > _cash) then {
				if (_price > _bank) exitwith{[format[localize"STR_NewStorage_3",_price-_bank],"red"] call A3PL_Player_Notification;};
				player setVariable ["player_bank",(player getVariable ["player_bank",0])-_price,true];
				[format[localize"STR_NewStorage_4s",_price],"red"] call A3PL_Player_Notification;
				[_class,player,_id,_spawnPos] remoteExec ["Server_Storage_RetrieveVehicle", 2];
			} else {
				player setVariable ["player_cash",(player getVariable ["player_cash",0])-_price,true];
				[format[localize"STR_NewStorage_5",_price],"red"] call A3PL_Player_Notification;
				[_class,player,_id,_spawnPos] remoteExec ["Server_Storage_RetrieveVehicle", 2];
			};
			["Federal Reserve",_Price] remoteExec ["Server_Government_AddBalance",2];
		};
		if(_type == "airimpound") then {
			_vehPrice = [_class] call A3PL_Config_GetVehicleMSRP;
			_price = 0;
			if (_VehPrice < 150000) then{
				_price = _vehPrice * 0.05;
			}
			else {
				_price = _vehPrice * 0.02;
			};
			_cash = player getVariable ["player_cash",0];
			_bank = player getVariable ["player_bank",0];
			if (_price > _cash) then {
				if (_price > _bank) exitwith{[format[localize"STR_NewStorage_3",_price-_bank],"red"] call A3PL_Player_Notification;};
				player setVariable ["player_bank",(player getVariable ["player_bank",0])-_price,true];
				[format[localize"STR_NewStorage_4s",_price],"red"] call A3PL_Player_Notification;
				[_class,player,_id,_spawnPos] remoteExec ["Server_Storage_RetrieveVehicle", 2];
			} else {
				player setVariable ["player_cash",(player getVariable ["player_cash",0])-_price,true];
				[format[localize"STR_NewStorage_5",_price],"red"] call A3PL_Player_Notification;
				[_class,player,_id,_spawnPos] remoteExec ["Server_Storage_RetrieveVehicle", 2];
			};
			["Federal Reserve",_Price] remoteExec ["Server_Government_AddBalance",2];
		};
		if(_type == "chopshop") then {
			_vehPrice = [_class] call A3PL_Config_GetVehicleMSRP;
			_price = 0;
			if (_VehPrice < 150000) then{
				_price = _vehPrice * 0.07;
			}
			else {
				_price = _vehPrice * 0.04;
			};
			_cash = player getVariable ["player_cash",0];
			_bank = player getVariable ["player_bank",0];
			if (_price > _cash) then {
				if (_price > _bank) exitwith{[format[localize"STR_NewStorage_6",_price-_bank],"red"] call A3PL_Player_Notification;};
				player setVariable ["player_bank",(player getVariable ["player_bank",0])-_price,true];
				[format[localize"STR_NewStorage_7",_price],"red"] call A3PL_Player_Notification;
				[_class,player,_id,_spawnPos] remoteExec ["Server_Storage_RetrieveVehicle", 2];
			} else {
				player setVariable ["player_cash",(player getVariable ["player_cash",0])-_price,true];
				[format[localize"STR_NewStorage_8",_price],"red"] call A3PL_Player_Notification;
				[_class,player,_id,_spawnPos] remoteExec ["Server_Storage_RetrieveVehicle", 2];
			};
		};
	} else {
		if((typeOf _intersect) isEqualTo "") then {
			_nearFreePos = [(getpos player), 5, 50, 0, 0] call BIS_fnc_findSafePos;
			[_class,player,_id,_nearFreePos] remoteExec ["Server_Storage_RetrieveVehicle", 2];
		} else {
			[_class,player,_id,_intersect] remoteExec ["Server_Storage_RetrieveVehicle", 2];
		};
	};
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_Storage_CarStoreButton",
{
	private _intersect = player_objIntersect;
	private _toCompany = param [0,0];
	if (isNull _intersect) exitwith {};
	private _types = ["Car","Ship","Tank","Truck","Plane","Helicopter","Air"];
	private _near = _intersect nearEntities [_types,30];

	if(((typeOf _intersect) isEqualTo "Land_A3PL_Firestation") && (!((player getVariable["job","unemployed"]) isEqualTo "fifr") && !(["vfd",player] call A3PL_DMV_Check))) exitWith {["Only FIFR and VFD can use this storage!","red"] call A3PL_Player_Notification;};
	if ((count _near) isEqualTo 0) exitwith {[7] call A3PL_Storage_CarStoreResponse;};
	[8] call A3PL_Storage_CarStoreResponse;

	if (typeOf _intersect IN ["Land_A3PL_storage"]) then {
		[player,_intersect,_toCompany] remoteExec ["Server_Storage_StoreVehicle",2];
	} else {
		private _cars = nearestObjects [player, ["Car","Ship","Air","Tank","Truck"], 30];
		if((count _cars) isEqualTo 0) exitWith {[localize"STR_NewStorage_9", "red"] call A3PL_Player_Notification;};
		private _car = _cars select 0;
		if (((_car getVariable "owner") select 0) != (getPlayerUID player)) exitWith {[localize"STR_NewStorage_10", "red"] call A3PL_Player_Notification;};
		private _atttachedObjects = attachedObjects _car;
		private _countAttached = count(_attachedObjects);
		if ((_countAttached > 0 || (_countAttached == 1 && (count(_attachedObjects select 0) == 0)))) exitWith {["Error: Contant a Director if you see this","red"] call A3PL_Player_Notification;};
		
		[_car,player,_toCompany] remoteExec ["Server_Storage_SaveLargeVehicles",2];
	};
}] call Server_Setup_Compile;

["A3PL_Storage_CarRetrieveResponse",
{
	private _return = param [0,1];
	private _text = "";
	switch (_return) do
	{
		case 1: {_text = [localize"STR_NewStorage_20","red"]};
		case 2: {_text = [localize"STR_NewStorage_21","green"]};
		case 3: {_text = [localize"STR_NewStorage_22","red"]};
		case 4: {_text = [localize"STR_NewStorage_23","green"]};
	};
	_text call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Storage_CarStoreResponse",
{
	private _return = param [0,1];
	private _text = "";
	switch (_return) do
	{
		case 1: {_text = [localize"STR_NewStorage_27","red"]};
		case 2: {_text = [localize"STR_NewStorage_28","green"]};
		case 3: {_text = [localize"STR_NewStorage_29","red"]};
		case 4: {_text = [localize"STR_NewStorage_30","red"]};
		case 5: {_text = [localize"STR_NewStorage_31","red"]};
		case 6: {_text = [localize"STR_NewStorage_32","red"]};
		case 7: {_text = [localize"STR_NewStorage_33","red"]};
		case 8: {_text = [localize"STR_NewStorage_34","green"]};
		case 9: {_text = [localize"STR_NewStorage_35","green"]};
	};
	_text call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Storage_OpenCarStorage", {
	if(player_objintersect getVariable ["inUse",false]) exitWith {[localize"STR_NewStorage_38", "red"] call A3PL_Player_Notification;};

	createDialog "dialog_PlayerGarage";
	private _type = player_objintersect getVariable ["type","vehicle"];
	if (!(player_objintersect IN A3PL_Jobroadworker_Impounds)) then {
		player_objintersect setVariable ["inUse",true,true];
	};

	[] spawn {
		private _garage = player_objintersect;
		waitUntil {uiSleep 0.1; isNull findDisplay 145};
		sleep 2;
		_garage setVariable ["inUse",false,true];
	};

	if (player_objintersect IN A3PL_Jobroadworker_Impounds) exitWith {
		[player,"-1",1] remoteExec ["Server_Storage_ReturnVehicles", 2];
	};
	if (player_objintersect IN A3PL_Air_Impounds) exitWith {
		[player,"-1",1,"plane"] remoteExec ["Server_Storage_ReturnVehicles", 2];
	};
	if (player_objintersect IN A3PL_Chopshop_Retrivals) exitWith {
		[player,"-1",2] remoteExec ["Server_Storage_ReturnVehicles", 2];
	};
	private _company = param[0,false];
	if(_company) exitWith {
		private _cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
		[player,"-1",0,_type,_cid] remoteExec ["Server_Storage_ReturnVehicles", 2];
	};
	[player,"-1",0,_type] remoteExec ["Server_Storage_ReturnVehicles", 2];
}] call Server_Setup_Compile;

["A3PL_Storage_VehicleReceive", {
	disableSerialization;
	private _returnArray = param [0,[]];
	private _display = findDisplay 145;
	private _control = _display displayCtrl 1500;

	{
		_x pushBack (format ["%1",getText (configFile >> "CfgVehicles" >> (_x select 1) >> "displayName")]);

		private _vehicleGas = format ["%1",round((_x select 3)*100)] + "%";
		private _vehiclePlate = toUpper (_x select 0);
		private _vehicleInsurance = _x select 4;
		private _vehicleData = format ["%1_%2_%3_%4",_x select 5,_vehiclePlate,_vehicleGas,_vehicleInsurance];

		if ((_x select 2) isEqualTo "noCustomName") then {
			_i = lbAdd [1500, (format ["%1",getText (configFile >> "CfgVehicles" >> (_x select 1) >> "displayName")])];
			lbSetData [1500,_i,_vehicleData];
		} else {
			_i = _control lbAdd (format ["%1",_x select 2]);
			lbSetData [1500,_i,_vehicleData];
		};
	} foreach _returnArray;
	A3PL_Storage_ReturnArray = _returnArray;
	_control ctrlAddEventHandler ["LBSelChanged","call A3PL_Storage_VehicleInfo;"];
}] call Server_Setup_Compile;

["A3PL_Storage_VehicleInfo", {
	private _display = findDisplay 145;
	private _selectedIndex = lbCurSel 1500;
	private _selectedData = lbData [1500, _selectedIndex];
	private _dataSplit = _selectedData splitString "_";
	private _vehicleType = _dataSplit select 0;
	private _vehiclePlate = _dataSplit select 1;
	private _vehicleGas = _dataSplit select 2;
	private _vehicleInsurance = _dataSplit select 3;
	private _control = _display displayCtrl 1501;
	private _vehicleInsured = "Yes";
	if(_vehicleInsurance isEqualTo "0") then {_vehicleInsured = "No";};

	private _startingText = ["Type :","License :","Gas :","Insurance :"];
	private _followingText = [_vehicleType,_vehiclePlate,_vehicleGas,_vehicleInsured];

	lbClear 1501;
	{
		lbAdd [1501, format ["%1 %2", _startingText select _forEachIndex,_followingText select _forEachIndex]];
	} forEach _followingText;
}] call Server_Setup_Compile;

["A3PL_Storage_ChangeVehicleName", {
	private _display = findDisplay 145;
	private _control = _display displayCtrl 1500;
	private _selectedIndex = lbCurSel 1500;
	private _selectedData = lbData [1500, _selectedIndex];
	private _dataSplit = _selectedData splitString "_";
	private _vehiclePlateUpper = _dataSplit select 1;
	private _vehiclePlateLower = toLower _vehiclePlateUpper;
	private _vehicleNewName = ctrlText 1400;
	private _allowedCharacters = [" ","0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
	private _validCharacters = true;

	if ((count _vehicleNewName) < 1) exitWith {[localize"STR_NewStorage_39","yellow"] call A3PL_Player_Notification;};
	if ((count _vehicleNewName) > 35) exitWith {[localize"STR_NewStorage_40","yellow"] call A3PL_Player_Notification;};

	for "_i" from 0 to ((count _vehicleNewName) - 1) do
	{
		private ["_checking"];
		_checking = _vehicleNewName select [_i,1];
		if (!(_checking IN _allowedCharacters)) exitwith {_validCharacters = false;};
	};

	if (!(_validCharacters)) exitWith {[localize"STR_NewStorage_41","yellow"] call A3PL_Player_Notification;};
	[_vehiclePlateLower,_vehicleNewName] remoteExec ["Server_Storage_ChangeVehicleName",2];

	closeDialog 0;
}] call Server_Setup_Compile;