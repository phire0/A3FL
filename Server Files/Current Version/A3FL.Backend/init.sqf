/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

Server_Setup_Files = [
	//Backend Files
	['Backend', 'Server_Setup'],

	//Functions Files
	['Functions', 'A3FL_Player'],
	['Functions', 'A3FL_ATM'],
	['Functions', 'A3FL_Lib'],
	['Functions', 'A3FL_Interaction'],
	['Functions', 'A3FL_Config'],
	['Functions', 'A3FL_Inventory'],
	['Functions', 'A3FL_Loading'],
	['Functions', 'A3FL_Items'],
	['Functions', 'A3FL_Level'],
	['Functions', 'A3FL_Locker'],
	['Functions', 'A3FL_VehicleInit'],
	['Functions', 'A3FL_Intersect'],
	['Functions', 'A3FL_Shop'],
	['Functions', 'A3FL_Loop'],
	['Functions', 'A3FL_Placeables'],
	['Functions', 'A3FL_EventHandlers'],
	['Functions', 'A3FL_Police'],
	['Functions', 'A3FL_Hydrogen'],
	['Functions', 'A3FL_iPhoneX'],
	['Functions', 'A3FL_Housing'],
	['Functions', 'A3FL_Store_Robbery'],
	['Functions', 'A3FL_Storage'],
	['Functions', 'A3FL_NPC'],
	['Functions', 'A3FL_JobMcfisher'],
	['Functions', 'A3FL_JobFisherman'],
	['Functions', 'A3FL_JobRoadWorker'],
	['Functions', 'A3FL_JobFarming'],
	['Functions', 'A3FL_JobOil'],
	['Functions', 'A3FL_JobWildcat'],
	['Functions', 'A3FL_JobMechanic'],
	['Functions', 'A3FL_JobTaxi'],
	['Functions', 'A3FL_Vehicle'],
	['Functions', 'A3FL_HUD'],
	['Functions', 'A3FL_USCG'],
	['Functions', 'A3FL_Medical'],
	['Functions', 'A3FL_Drugs'],
	['Functions', 'A3FL_Admin'],
	['Functions', 'A3FL_Uber'],
	['Functions', 'A3FL_Gang'],
	['Functions', 'A3FL_Dogs'],
	['Functions', 'A3FL_ATC'],
	['Functions', 'A3FL_Government'],
	['Functions', 'A3FL_FD'],
	['Functions', 'A3FL_Fire'],
	['Functions', 'A3FL_Resources'],
	['Functions', 'A3FL_Robberies'],
	['Functions', 'A3FL_SFP'],
	['Functions', 'A3FL_Twitter'],
	['Functions', 'A3FL_Factory'],
	['Functions', 'A3FL_Business'],
	['Functions', 'A3FL_Garage'],
	['Functions', 'A3FL_Heist_Bank'],
	['Functions', 'A3FL_HouseRobbery'],
	['Functions', 'A3FL_IE'],
	['Functions', 'A3FL_DMV'],
	['Functions', 'A3FL_Waste'],
	['Functions', 'A3FL_Delivery'],
	['Functions', 'A3FL_Criminal'],
	['Functions', 'A3FL_Hunting'],
	['Functions', 'A3FL_Moonshine'],
	['Functions', 'A3FL_Lumber'],
	['Functions', 'A3FL_Combine'],
	['Functions', 'A3FL_Karts'],
	['Functions', 'A3FL_ShopStock'],
	['Functions', 'A3FL_Chopshop'],
	['Functions', 'A3FL_Markers'],
	['Functions', 'A3FL_Company'],
	['Functions', 'A3FL_Calculator'],
	['Functions', 'A3FL_Exterminator'],
	['Functions', 'A3FL_Shrooms'],
	['Functions', 'A3FL_Freight'],
	['Functions', 'A3FL_Cocaine'],
	['Functions', 'A3FL_Warehouses'],
	['Functions', 'A3FL_JobShipCaptain'],
	['Functions', 'A3FL_Prison'],

	//Events Functions
	//['Functions', 'A3FL_Halloween'],

	//Server Files
	['Server', 'Server_Addresses'],
	['Server', 'Server_Police'],
	['Server', 'Server_iPhoneX'],
	['Server', 'Server_Vehicle'],
	['Server', 'Server_Database'],
	['Server', 'Server_Core'],
	['Server', 'Server_Player'],
	['Server', 'Server_Inventory'],
	['Server', 'Server_Gear'],
	['Server', 'Server_Housing'],
	['Server', 'Server_Locker'],
	['Server', 'Server_Storage'],
	['Server', 'Server_NPC'],
	['Server', 'Server_JobMcfisher'],
	['Server', 'Server_JobFisherman'],
	['Server', 'Server_JobFarming'],
	['Server', 'Server_JobOil'],
	['Server', 'Server_JobWildcat'],
	['Server', 'Server_JobRoadworker'],
	['Server', 'Server_JobPicking'],
	['Server', 'Server_Log'],
	['Server', 'Server_Uber'],
	['Server', 'Server_Dogs'],
	['Server', 'Server_Government'],
	['Server', 'Server_Fire'],
	['Server', 'Server_Fuel'],
	['Server', 'Server_Twitter'],
	['Server', 'Server_Factory'],
	['Server', 'Server_Business'],
	['Server', 'Server_Garage'],
	['Server', 'Server_IE'],
	['Server', 'Server_DMV'],
	['Server', 'Server_Shopstock'],
	['Server', 'Server_Hunting'],
	['Server', 'Server_Lumber'],
	['Server', 'Server_Criminal'],
	['Server', 'Server_Chopshop'],
	['Server', 'Server_Company'],
	['Server', 'Server_Gang'],
	['Server', 'Server_Shrooms'],
	['Server', 'Server_Warehouses'],

	//Configs Files
	['Configs', 'Config_Shops'],
	['Configs', 'Config_Jobs'],
	['Configs', 'Config_Items'],
	['Configs', 'Config_Intersect'],
	['Configs', 'Config_NPC'],
	['Configs', 'Config_Medical'],
	['Configs', 'Config_Interactions'],
	['Configs', 'Config_Factories'],
	['Configs', 'Config_Garage'],
	['Configs', 'Config_Licenses'],
	['Configs', 'Config_Houses'],
	['Configs', 'Config_Food'],
	['Configs', 'Config_Objects'],
	['Configs', 'Config_Resources'],
	['Configs', 'Config_Vehicles'],
	['Configs', 'Config_Warehouses']
];

Server_Setup_Compile = {
	private ["_name", "_code", "_forServer", "_compile", "_compileBlock"];

	_name = param [0,""];
	_code = param [1,{}];
	_forServer = param [2,false];
	_compileBlock = param [3,false];
	_compile = formatText ["%1 = %2;", _name, _code];

	if (isServer) then
	{
		call compile str(_compile);
	}
	else
	{
		call compileFinal str _compile;
	};

	//no need to go further, this is for singleplayer purpose
	if (_compileBlock) exitwith {};

	if(_forServer isEqualTo false) then {
		publicVariable _name;
	}
	else
	{
		publicVariableServer _name;
		if (!isServer) then
		{
			missionNameSpace setVariable [_name,nil];
		};
	};
};

Server_Setup_SetupFiles = {
	private ["_folder", "_name","_maindir"];
	_maindir = param [0,"A3FL.Backend"];

	{
		_folder = _x select 0;
		_name = _x select 1;
		call compile preprocessFile format ["\%3\%1\%2.sqf", _folder, _name,_maindir ];
	} forEach Server_Setup_Files;
	A3PL_FilesSetup = true;
};

private ["_folder"];
_folder = param [0,""];
[_folder] call Server_Setup_SetupFiles;
A3PL_FilesSetup = true;
publicVariableServer "A3PL_FilesSetup";
if (!isServer) then
{
	Server_Setup_Files = nil;
	Server_Setup_SetupFiles = nil;
	A3PL_FilesSetup = nil;
};
