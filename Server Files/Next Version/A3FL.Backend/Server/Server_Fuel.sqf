/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Fuel_Save",
{
	{
		private _query = format ["UPDATE fuelstations SET fuel = '%1', bCash = '%3', gallonprice = '%4' WHERE id = '%2'",(_x getVariable ["petrol",0]),_forEachIndex,(_x getVariable ["bCash",0]),(_x getVariable ["gallonprice",6])];
		[_query,1] spawn Server_Database_Async;
		sleep 2;
	} foreach FuelStations;
},true] call Server_Setup_Compile;

["Server_Fuel_Load",
{
	private _querry = ["SELECT id,fuel,bCash,gallonprice FROM fuelstations", 2, true] call Server_Database_Async;
	{
		(FuelStations select (_x select 0)) setVariable ["petrol",(_x select 1),true];
		(FuelStations select (_x select 0)) setVariable ["bCash",(_x select 2),true];
		(FuelStations select (_x select 0)) setVariable ["gallonprice",(_x select 3),true];
	} foreach _querry;
},true] call Server_Setup_Compile;

["Server_Fuel_Pay",
{
	private _player = param [0,objNull];
	private _owner = param [1,objNull];
	private _price = floor(param [2,objNull]);
	private _station = param [3,objNull];
	private _ownerOnline = param [4,false];
	private _pcash = _player getVariable ["player_cash",0];
	private _pbank = _player getVariable ["player_bank",0];
	private _bOwner = _station getVariable ["bOwner","0"];
	private _factionList = ["fifr","uscg","fisd"];
	private _job = _player getVariable["job","unemployed"];
	if(_bOwner == "0") then {
		if(_job IN _factionList) then {
			private _balance = [_job] call A3PL_Config_GetBalance;
			[_balance,-_price,"",format["Fuel %1",_owner getVariable["name","unknown"]]] remoteExec ["Server_Government_AddBalance",2];
			[format[localize "STR_SERVER_FUEL_FACTIONPAIDREFUEL",_price,_balance], "green"] remoteExec ["A3PL_Player_Notification",_player];
		} else {
			if(_pcash >= _price) exitwith {
				[_player,"Player_Cash",(_pcash - _price)] call Server_Core_ChangeVar;
				[format[localize "STR_SERVER_FUEL_PAIDCASHREFUEL",_price], "green"] remoteExec ["A3PL_Player_Notification",_player];
			};
			if(_pbank >= _price) exitwith {
				[_player,"Player_Bank",(_pbank - _price)] call Server_Core_ChangeVar;
				[format[localize "STR_SERVER_FUEL_PAIDBANKREFUEL",_price], "green"] remoteExec ["A3PL_Player_Notification",_player];
			};
			[format[localize "STR_SERVER_FUEL_ENOUGHMONEYREFUEL",_price], "red"] remoteExec ["A3PL_Player_Notification",_player];
		};
	} else {
		private _scash = _station getVariable ["bCash",0];
		if(_pcash >= _price) exitwith {
			[_player,"Player_Cash",(_pcash - _price)] call Server_Core_ChangeVar;
			[_station,"bCash",(_scash + _price)] call Server_Core_ChangeVar;
			if(_ownerOnline) then {[format[localize "STR_SERVER_FUEL_PAIDYOUFORREFUEL",(_player getVariable ["name",name player]),_price,(_scash + _price)], "green"] remoteExec ["A3PL_Player_Notification",_owner];};
			[format[localize "STR_SERVER_FUEL_YOUPAIDFORREFUEL",_price], "green"] remoteExec ["A3PL_Player_Notification",_player];
		};
		if(_pbank >= _price) exitwith {
			[_player,"Player_Bank",(_pbank - _price)] call Server_Core_ChangeVar;
			[_station,"bCash",(_scash + _price)] call Server_Core_ChangeVar;
			if(_ownerOnline) then {[format[localize "STR_SERVER_FUEL_PAIDYOUWITHBANKACCOUNT",(_player getVariable ["name",name player]),_price,(_scash + _price)], "green"] remoteExec ["A3PL_Player_Notification",_owner];};
			[format[localize "STR_SERVER_FUEL_YOUPAIDWITHBANKACCOUNT",_price], "green"] remoteExec ["A3PL_Player_Notification",_player];
		};
		if(_ownerOnline) then {
			[format[localize "STR_SERVER_FUEL_ENOUGNMONEYPROPERTY",(_player getVariable ["name",name player]),_price], "red"] remoteExec ["A3PL_Player_Notification",_owner];
			[format[localize "STR_SERVER_FUEL_ENOUGNMONEYPROPERTYINFORMED",_price], "red"] remoteExec ["A3PL_Player_Notification",_player];
		} else {
			[format[localize "STR_SERVER_FUEL_YOUDONTHAVEMONEYTOPAYFORFUEL",_price], "red"] remoteExec ["A3PL_Player_Notification",_player];
		};
	};
},true] call Server_Setup_Compile;

["Server_Fuel_TakeCash",
{
	private _player = param [0,objNull];
	private _station = param [1,objNull];
	private _pcash = _player getVariable ["player_cash",0];
	private _scash = _station getVariable ["bCash",0];
	[_player,"Player_Cash",(_pcash + _scash)] call Server_Core_ChangeVar;
	[_station,"bCash",0] call Server_Core_ChangeVar;
	[format[localize "STR_SERVER_FUEL_TOOKMONEYCASHREGISTER",_scash], "green"] remoteExec ["A3PL_Player_Notification",_player];
},true] call Server_Setup_Compile;