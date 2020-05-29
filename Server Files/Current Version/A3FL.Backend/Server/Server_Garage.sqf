/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Garage_UpdateAddons",
{
	private _veh = param [0,objNull];
	private _addons = param [1,[]];
	private _var = _veh getVariable ["owner",[]];
	if((count _var) isEqualTo 0) exitWith {};
	private _id = _var select 1;
	private _addons = [_addons] call Server_Database_Array;
	private _query = format ["UPDATE objects SET tuning = '%2' WHERE id = '%1'",_id,_addons];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;