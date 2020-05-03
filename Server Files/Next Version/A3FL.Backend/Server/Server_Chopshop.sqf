/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Chopshop_Chop",
{
	private _veh = param [0,objNull];
	private _player = param [1,objNull];
	private _items = 2 + random(4);
	private _itemsArray = ["Engine","Trans","Radiator","BrakeRotors","Diff","4WDDiff","FuelTank","Chassis","DriveShaft","Exhaust","Windows","SteelRims","AlloyRims","Tyres"];
	for "_i" from 0 to _items do {
		[selectRandom _itemsArray,1] remoteExec ["A3PL_Inventory_Add",_player];
	};
	[_veh] call Server_Chopshop_Storecar;
	[getPlayerUID _player,"chopchoped",[typeOf _veh,(_veh getVariable"owner") select 1]] remoteExec ["Server_Log_New",2];
},true] call Server_Setup_Compile;

["Server_Chopshop_Storecar",
{
	private _veh = param [0,objNull];
	if (isNull _veh) exitwith {};
	private _var = _veh getVariable ["owner",nil];
	if (!isNil "_var") then {
		private _id = _var select 1;
		private _query = format ["UPDATE objects SET plystorage = '1',impounded='3',fuel='%2' WHERE id = '%1'",_id,(fuel _veh)];
		[_query,1] spawn Server_Database_Async;
	};
	[_veh] call Server_Vehicle_Despawn;
},true] call Server_Setup_Compile;