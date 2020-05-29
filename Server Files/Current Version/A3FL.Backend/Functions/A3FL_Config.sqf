/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Config_GetItem", {
	private ["_class", "_Search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	if (_class == "") exitWith {false};

	{
		if((_x select 0) == _class) exitWith {_config = _x;};
	} forEach Config_Items;
	
	if (count _config == 0) exitwith {false;};

	switch (_search) do {
		default { _return = _config; };
		case "name": {			
			_return = _config select 1; 
			if (_return == "inh") then 
			{
				_return = getText (configFile >> "CfgVehicles" >> (_config select 3) >> "displayName");
			};
		};
		case "icon": {
			_return = getText (configFile >> "CfgVehicles" >> (_config select 3) >> "picture");
		};
		case "weight": { _return = _config select 2; };
		case "class": { _return = _config select 3; };
		case "dir": { _return = _config select 4; };
		case "canDrop": { _return = _config select 5; };
		case "canGive": { _return = _config select 6; };
		case "canUse": { _return = _config select 7; };
		case "canPickup": { _return = _config select 8; };
		case "simulation": { _return = _config select 9; };
		case "fnc": { _return = _config select 10; };
		case "attach": { _return = _config select 11; };
		case "desc": { _return = _config select 12; };
	};
	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetLicense",
{
	private ["_class", "_search","_config"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";	
	
	{
		if((_x select 0) == _class) exitWith {_config = _x;};
	} forEach Config_Licenses;

	switch (_search) do {
		default { _return = _config; };
		case "name": { _return = _config select 1; };
		case "type": { _return = _config select 2; };
		case "issuer": { _return = _config select 3; };
	};
	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_GetPaycheckInfo", {
	private ["_class", "_search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	{
		if((_x select 0) isEqualTo _class) exitWith {_config = _x;};
	} forEach Config_Paychecks;

	switch (_search) do {
		case "pay": { _return = _config select 1; };
		case "xp": { _return = _config select 2; };
	};
	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetFood", {
	private ["_class", "_Search", "_config", "_return"];
	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	{
		if((_x select 0) isEqualTo _class) then {_config = _x;};
	} forEach Config_Food;

	switch (_search) do {
		default { _return = _config; };
		case "quality": { _return = _config select 1; };
		case "drug": { _return = _config select 2; };
	};

	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetThirst",
{
	private ["_class", "_Search", "_config", "_return"];
	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	{
		if((_x select 0) isEqualTo _class) exitWith {_config = _x;};
	} forEach Config_Thirst;

	switch (_search) do {
		default { _return = _config; };
		case "quality": { _return = _config select 1; };
		case "alcohol": { _return = _config select 2; };
	};
	_return;
}] call Server_Setup_Compile;

["A3PL_Config_HasStorage", {
	private ["_class", "_return"];
	_class = param [0,""];
	_return = false;
	{
		if((_x select 0) == _class) then {
			_return = true;
		};
	} forEach Config_Vehicles_Capacity;
	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetVehicleCapacity", {
	private ["_class", "_return"];
	_class = param [0,""];
	_return = 0;
	{
		if((_x select 0) == _class) then {
			_return = _x select 1;
		};
	} forEach Config_Vehicles_Capacity;
	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetShop", {
	private ["_class", "_Search","_itemClass", "_config", "_return"];
	_class = param [0,""];
	_itemClass = param [1,""];
	_search = param [2,""];
	_config = [];
	_return = "";

	{
		if(_x select 0 == _class) exitwith {
			if (_itemClass == "pos") then {
				_config = _x select 2;
			} else {
				_config = _x select 1;
			};
		};
	} forEach Config_Shops_Items;
	
	if (_search == "") exitwith {
		_return = _config;
		_return;
	};
}] call Server_Setup_Compile;

["A3PL_Config_GetLevel", {
	private ["_levels","_class", "_search", "_config", "_return"];
	_levels = [[0,20],[1,65],[2,100],[3,140],[4,200],[5,240],[6,320],[7,400],[8,480],[9,530],[10,680],[11,720],[12,810],[13,950],[14,1000],[15,1150],[16,1220],[17,1300],[18,1390],[19,1420],[20,1535],[21,1655],[22,1790],[23,1929],[24,2000],[25,2120],[26,2250],[27,2380],[28,2520],[29,2630],[30,2750],[31,2820],[32,2960],[33,3050],[34,3100],[35,3170],[36,3205],[37,3240],[38,3265],[39,3298],[40,3350],[41,3400],[42,3490],[43,3550],[44,3590],[45,3620],[46,3690],[47,3750],[48,3790],[49,3820],[50,3850],[51,3910],[52,3950],[53,3980],[54,4020],[55,4090],[56,4150],[57,4195],[58,4230],[59,4280],[60,4300],[61,4330],[62,4360],[63,4390],[64,4400],[65,4420],[66,4445],[67,4465],[68,4470],[69,4490],[70,4500],[71,4550],[72,4590],[73,4620],[74,4650],[75,4680],[76,4700],[77,4720],[78,4735],[79,4753],[80,4780],[81,4810],[82,4850],[83,4890],[84,4910],[85,4935],[86,4950],[87,4980],[88,5000],[89,5060],[90,5180],[91,5250],[92,5290],[93,5350],[94,5390],[95,5420],[96,5465],[97,5485],[98,5506],[99,5580],[100,5900]];
	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	{
		if((_x select 0) == _class) exitWith {_config = _x;};
	} forEach _levels;
	switch (_search) do {
		default {_return = false;};
		case "next": {_return = _config select 1;};
	};
	_return;
}] call Server_Setup_Compile;

//Select from Config_Factories
["A3PL_Config_GetFactory",
{
	private ["_class","_factory","_search", "_config", "_return"];

	_class = param [0,""];
	_factory = param [1,""];
	_search = param [2,""];
	_config = [];
	_return = "";
	
	{
		if(_x select 0 == _factory) then 
		{
			_config = [] + _x; //save a copy to prevent deleteAt delete the title from main factory config
		};
	} forEach Config_Factories;
	
	if (_class == "all") exitwith { _return = _config; _return deleteAt 0; _return deleteAt 0; _return;};
	if (_class == "pos") exitwith { _return = _config select 1; _return;};
	
	//we are looking for individual recipe info
	
	_config deleteAt 0; //dont need title, array shifting
	_config deleteAt 0; //dont need pos
	{
		if (_x select 0 == _class) then {_config = _x};
	} foreach _config; //we get the item here
	switch (_search) do { //look for
		case "id": { _return = _config select 0; };
		case "parent": { _return = _config select 1; };
		case "name": { _return = _config select 2; };
		case "img": { _return = _config select 3; };
		case "class": { _return = _config select 4; };
		case "type": { _return = _config select 5; };
		case "craftable": { _return = _config select 6; };
		case "time": { _return = _config select 7; };
		case "required": { _return = _config select 8; };
		case "output": { _return = _config select 9; };
		case "faction": { _return = _config select 10; };
		case "xp": { _return = _config select 11; };
		default { _return = false; };
	};		

	_return;	
}] call Server_Setup_Compile;

//Select from player_factory variable
["A3PL_Config_GetPlayerFactory",
{
	private ["_class", "_Search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";
	
	{
		if ((_x select 0) == _class) exitWith {
			_config = _x;
		};
	} forEach (player getVariable ["player_factories",[]]);

	switch (_search) do {
		default { _return = false; };
		case "craftID": { _return = _config select 0; };
		case "classname": { _return = _config select 1; };
		case "required": { _return = _config select 2; };
		case "type": { _return = _config select 3; };
		case "classtype": { _return = _config select 4; };
		case "id": { _return = _config select 5; };
		case "amount": { _return = _config select 6; };
		case "finish": { _return = _config select 7; };
		case "count": { _return = _config select 8; };
	};
	_return;	
}] call Server_Setup_Compile;

//Select from player_fstorage var
["A3PL_Config_GetPlayerFStorage",
{
	private ["_class", "_Search", "_config", "_return","_player"];

	_class = param [0,""];
	_search = param [1,""];
	_player = param [2,player];
	_config = [];
	_return = "";
	
	{
		if ((_x select 0) == _class) then {
			_config = _x;
		};
	} forEach (_player getVariable ["player_fStorage",[]]);
	
	if (count _config == 0) exitwith {_return = false; _return;};

	switch (_search) do {
		default { _return = false; };
		case "type": { _return = _config select 0; }; //fac type
		case "items": { _return = _config select 1; }; //the array with items in this storage
	};

	_return;	
}] call Server_Setup_Compile;

//Select from Config_Garage_Upgrade
["A3PL_Config_GetGarageUpgrade",
{
	private ["_class","_typeOf","_search", "_config", "_return"];

	_class = param [0,""]; //id to search
	_typeOf = param [1,""]; //classname of veh
	_search = param [2,""]; //info to search
	_config = [];
	_return = "";
	
	{
		if(_x select 0 == _typeOf) then 
		{
			_config = [] + _x; //save a copy to prevent deleteAt delete the title from main factory config
		};
	} forEach Config_Garage_Upgrade;
	
	if (_class == "all") exitwith { _return = _config; _return deleteAt 0; _return;};
	
	_config deleteAt 0; //dont need typeof, array shifting
	{
		if (_x select 0 == _class) then {_config = _x};
	} foreach _config; //we get the item here
	switch (_search) do { //look for
		case "id": { _return = _config select 0; }; //id
		case "type": { _return = _config select 1; }; //upgrade type
		case "class": { _return = _config select 2; }; //upgrade class
		case "title": { _return = _config select 3; }; //upgrade title
		case "desc": { _return = _config select 4; }; //upgrade description
		case "camTarget": { _return = _config select 5; }; //cam target location
		case "camOffset": { _return = _config select 6; }; //cam offset from Target
		case "price": { _return = _config select 7; }; //install price
		case "required": { _return = _config select 8; }; //required items for upgrade
		case "level": { _return = _config select 9; }; //required level
		default { _return = false; };
	};

	_return;	
}] call Server_Setup_Compile;

//Select from config the textures
["A3PL_Config_GetGaragePaint",
{
	private ["_class","_typeOf","_search", "_config", "_return"];

	_class = param [0,""]; //id to search
	_typeOf = format ["%1_Textures",(param [1,""])]; //classname of veh
	_search = param [2,""]; //info to search
	_faction = param [3,""];
	_config = [];
	_return = "";
	{
		_name = (getText (configFile >> "CfgVehicles" >> _typeOf >> "Skins" >> (configName _x) >> "Name"));
		_requiredJob = getText (configFile >> "CfgVehicles" >> _typeOf >> "Skins" >> (configName _x) >> "faction");
		if((_faction isEqualTo _requiredJob) || (_requiredJob isEqualTo "citizen")) then {
				_config = _config + [[(configName _x),(getArray (configFile >> "CfgVehicles" >> _typeOf >> "Skins" >> (configName _x) >> "Texture_Path")),_name]];
		};
	} forEach ("true" configClasses (configFile >> "CfgVehicles" >> _typeOf >> "Skins"));

	if (_class == "all") exitwith { _return = _config; _return;};
	
	{if ((_x select 0) == _class) exitWith {_config = _x};} foreach _config;

	switch (_search) do {
		case "id": { _return = _config select 0; }; //id
		case "file": { _return = _config select 1; }; //texture file
		case "title": { _return = _config select 2; }; //name of skin
		default { _return = false; };
	};
	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_GetGarageRepair",
{
	private ["_class","_search", "_config", "_return"];

	_class = param [0,""]; //id to search
	_search = param [1,""]; //info to search
	_config = [];
	_return = "";
	
	{
		if(_x select 0 == _class) then 
		{
			_config = [] + _x;
		};
	} forEach Config_Garage_Repair;
	
	if (count _config == 0) exitwith {_return = false; _return};

	switch (_search) do { //look for
		case "id": { _return = _config select 0; }; //id
		case "title": { _return = _config select 1; }; //name of repair
		default { _return = false; };
	};
	_return;
}] call Server_Setup_Compile;

//get faction ranks
["A3PL_Config_GetRanks",
{
	private ["_class","_search", "_config", "_return", "_index"];

	_class = param [0,""]; //id to search
	_search = param [1,""]; //info to search
	_config = [];
	_return = "";
	_index = -1;
	
	{
		if(_x select 0 == _class) then 
		{
			_config = [] + _x; //save a copy to prevent deleteAt delete the title from main config
			_index = _forEachIndex;
		};
	} forEach Server_Government_FactionRanks;
	
	if (count _config == 0) exitwith {_return = [[],_index]; _return};
	switch (_search) do { //look for
		case "faction": { _return = _config select 0; };
		case "ranks": { _return = _config select 1; };
		default { _return = false; };
	};		
	_return = [_return,_index]; //this function also returns the index
	_return;	
}] call Server_Setup_Compile;

//get stuff from Config_Medical_Wounds
["A3PL_Config_GetWound",
{
	private ["_class", "_Search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	if (_class == '') exitWith {false};

	{
		if((_x select 0) isEqualTo _class) exitWith {_config = _x;};
	} forEach Config_Medical_Wounds;
	if (count _config == 0) exitwith {false;};

	switch (_search) do {
		default { _return = _config; };
		case "class": { _return = _config select 0; };
		case "name": { _return = _config select 1; };
		case "color": { _return = _config select 2; };
		case "bloodLossInstant": { _return = _config select 3; };
		case "bloodLoss": { _return = _config select 4; };
		case "painLevel": { _return = _config select 5; };
		case "itemTreat": { _return = _config select 6; };
		case "doesTreatHeal": { _return = _config select 7; };
		case "itemHeal": { _return = _config select 8; };
	};
	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetTaxes",
{
	private ["_class","_return"];
	_class = param [0,""];
	_return = "";
	{
		if((_x select 0) == _class) exitWith  {_return = _x select 1;};
	} forEach Config_Government_Taxes;
	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_GetFactionRankData",
{
	private ["_faction", "_config","_rankData","_search","_UID"];

	_faction = param [0,""];
	_search = param [1,""];
	_UID = param [2,""];
	_config = [];
	_rankData = [];
	_return = "";

	if (_faction == "") exitWith {false;};

	{
		if((_x select 0) == _faction) exitWith {
			_config = _x select 1;
		};
	} forEach Server_Government_FactionRanks;

	{
		if(_UID IN (_x select 1)) exitWith {
			_rankData = _x;
		};
	} forEach _config;

	if ((count _rankData) == 0) then {_rankData = ["Reserve",[getPlayerUID player],0];};
	switch (_search) do {
		default { _return = _rankData; };
		case "rank": { _return = _rankData select 0; };
		case "pay": { _return = _rankData select 2; };
	};
	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetBalance",
{
	private ["_job", "_balance"];
	_job = param [0,""];
	_balance = "";
	switch (_job) do {
		case ("fisd"): {_balance = "Sheriff Department"};
		case ("uscg"): {_balance = "US Coast Guard"};
		case ("fifr"): {_balance = "Fire Rescue"};
		case ("usms"): {_balance = "Marshals Service"};
		case ("dmv"): {_balance = "Department of Motor Vehicles"};
		case ("doj"): {_balance = "Department of Justice"};
		case ("cartel"): {_balance = "Cartel"};
	};
	_balance;
}] call Server_Setup_Compile;

["A3PL_Config_InCompany",
{
	private ["_uid","_return"];
	_uid = param [0,""];
	_return = false;
	{
		for "_i" from 0 to count(_x select 3) do {
			if(_uid == ((_x select 3) select _i) select 0) exitWith  {_return = true;};
		}; 
	} forEach Server_Companies;
	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_IsCompanyBoss",
{
	private ["_uid","_return"];
	_uid = param [0,""];
	_return = false;
	{
		if(_uid == (_x select 2)) exitwith {_return = true;};
	} forEach Server_Companies;
	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_GetCompanyPay",
{
	private ["_uid", "_return"];

	_uid = param [0,""];
	_return = 0;

	{
		for "_i" from 0 to count(_x select 3) do {
			if(_uid == ((_x select 3) select _i) select 0) exitWith  {
				_return = ((_x select 3) select _i) select 1;
			};
		};
	} forEach Server_Companies;
	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_GetCompanyID",
{
	private ["_uid", "_return"];

	_uid = param [0,""];
	_return = 0;

	{
		for "_i" from 0 to count(_x select 3) do {
			if(_uid == ((_x select 3) select _i) select 0) exitWith  {
				_return = _x select 0;
			};
		};
	} forEach Server_Companies;
	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_GetCompanyData",
{
	private ["_id", "_return"];
	_id = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	{if(_id == (_x select 0)) exitWith  {_config = _x;};} forEach Server_Companies;
	switch (_search) do {
		default {_return = _config;};
		case "id": { _return = _config select 0; };
		case "name": { _return = _config select 1; };
		case "boss": { _return = _config select 2; };
		case "employees": { _return = _config select 3; };
		case "bank": { _return = _config select 4; };
		case "licenses": { _return = _config select 5; };
	};
	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetInsurancePrice",
{
	private ["_veh", "_class", "_return"];
	_veh = param [0,objNull];
	_class = typeOf _veh;
	_return = 150000;
	{
		if((_x select 0) == _class) exitWith {
			_return = (_x select 1);
		};
	} forEach Config_Vehicles_Insurance;
	_return;
}] call Server_Setup_Compile;

["A3PL_Config_isTaxed",
{
	private ["_class", "_return"];
	_class = param [0,""];
	_return = false;	
	
	{
		if(_x select 0 == _class) exitWith {_return = true;};
	} forEach Config_Shops_TaxSystem;
	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_GetTaxSeting",
{
	private ["_class", "_search","_config"];
	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";	
	
	{
		if(_x select 0 == _class) exitWith {
			_config = _x;
		};
	} forEach Config_Shops_TaxSystem;
	switch (_search) do {
		default { _return = _config; };
		case "budget": {_return = _config select 1;};
		case "tax": {_return = _config select 2;};
	};
	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_CanUseBargate", {
	private ["_class","_return","_pFaction"];
	_pos = param [0,[0,0,0]];
	_return = true;
	_pFaction = player getVariable["faction","unemployed"];
	{
		if(((_x select 0) distance _pos) < 10) then {
			if(!(_pFaction IN (_x select 1))) exitWith {
				_return	= false;
			};
		};
	} forEach Config_Objects_Bargates;
	_return;
}] call Server_Setup_Compile;