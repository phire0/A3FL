/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Government_SetTax",
{
	private _taxChanged = param [0,""];
	private _taxRate = param [1,0];
	private _oldRate = 0;
	private _success = false;
	{
		if ((_x select 0) isEqualTo _taxChanged) exitwith {
			_oldRate = _x select 1;
			Config_Government_Taxes set [_forEachIndex,[(_x select 0),_taxRate]];
			_success = true;
		};
	} foreach (missionNameSpace getVariable ["Config_Government_Taxes",[]]);
	if (!_success) exitwith {};
	publicVariable "Config_Government_Taxes";
	[_taxChanged,_oldRate,_taxRate] remoteExec ["A3PL_Government_NewTax", -2];
	["Config_Government_Taxes",true] call Server_Core_SavePersistentVar;
},true] call Server_Setup_Compile;

["Server_Government_AddBalance",
{
	private _addBalance = param [0,""]; 					//what balance to add
	private _amount = param [1,0]; 							//amount to add
	private _takeBalance = param [2,""];					//if we need to take it from another balance
	private _description = param [3,""];					//description
	{
		if ((_x select 0) isEqualTo _takeBalance) then
		{
			if ((_x select 1) < _amount) exitwith {_fail = true;}; //make sure players cant take more money then there is
			Config_Government_Balances set [_forEachIndex,[_x select 0,(_x select 1) - _amount]];
		};
		if (!isNil "_fail") exitwith {};
		if ((_x select 0) isEqualTo _addBalance) then {
			_newAmount = (_x select 1) + _amount;
			if (_newAmount < 0) then {_newAmount = 0;};
			Config_Government_Balances set [_forEachIndex,[_x select 0,_newAmount]];
		};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);

	publicVariable "Config_Government_Balances";
	["Config_Government_Balances",true] call Server_Core_SavePersistentVar;

	if((_addBalance IN ["Fire Department","United States Coast Guard","Sheriff Department","Department of Justice","Marshals Service"]) && (_description != "")) then {
		private _query = format ["INSERT INTO factions_budget_logs(faction, amount, description, date_log) VALUES('%1','%2','%3', NOW())",_addBalance, _amount, _description];
		[_query,1] spawn Server_Database_Async;
	};
},true] call Server_Setup_Compile;

["Server_Government_ChangeLaw",
{
	private _lawDo = param [0,0];
	private _lawIndex = param [1,0];
	private _newLaw = param [2,""];
	switch (_lawdo) do {
		case (-1):{Config_Government_Laws deleteAt _lawIndex;};
		case (0):{Config_Government_Laws set [_lawIndex,_newLaw];};
		case (1):{_lawIndex = count Config_Government_Laws;Config_Government_Laws pushback _newLaw;};
	};
	publicVariable "Config_Government_Laws";
	["Config_Government_Laws",true] call Server_Core_SavePersistentVar;
	[_lawIndex] remoteExec ["A3PL_Government_NewLaw", -2];
},true] call Server_Setup_Compile;

["Server_Government_FactionSetupInfo",
{
	private _leader = param [0,objNull];
	private _faction = param [1,""];
	private _factionPlayers = [format ["SELECT name,uid FROM players WHERE faction='%1'",_faction], 2,true] call Server_Database_Async;
	private _allRanks = missionNameSpace getVariable ["Server_Government_FactionRanks",[]];
	private _ranks = [];
	{
		if ((_x select 0) isEqualTo _faction) exitwith {_ranks = _x select 1;};
	} foreach _allRanks;
	[_factionPlayers,_ranks] remoteExec ["A3PL_Government_FactionSetupReceive", (owner _leader)];
},true] call Server_Setup_Compile;

["Server_Government_SetRank",
{
	private _faction = param [0,""];
	private _person = param [1,""];
	private _rank = param [2,""];
	private _ranks = [_faction,"ranks"] call A3PL_Config_GetRanks;
	private _index = _ranks select 1;
	private _ranks = _ranks select 0;
	{
		private _rankx = _x select 0;
		private _persons = _x select 1;
		if (_person IN _persons) then {
			_persons = _persons - [_person];
			_ranks set [_forEachIndex,[(_x select 0),_persons,(_x select 2)]];
		};
		if (_rankx isEqualTo _rank) then {_persons pushback _person;};
	} foreach _ranks;
	Server_Government_FactionRanks set [_index,[_faction,_ranks]];
	publicVariable "Server_Government_FactionRanks";
	["Server_Government_FactionRanks",true] call Server_Core_SavePersistentVar;
},true] call Server_Setup_Compile;

["Server_Government_AddRank",
{
	private _faction = param [0,""];
	private _rank = param [1,""];
	private _exist = false;
	private _ranks = [_faction,"ranks"] call A3PL_Config_GetRanks;
	private _index = _ranks select 1;
	private _ranks = _ranks select 0;
	{
		if ((_x select 0) == _rank) exitwith {_exist = true;};
	} foreach _ranks;
	if (_exist) exitwith {};
	_ranks pushback [_rank,[],0];
	Server_Government_FactionRanks set [_index,[_faction,_ranks]];
	publicVariable "Server_Government_FactionRanks";
	["Server_Government_FactionRanks",true] call Server_Core_SavePersistentVar;
},true] call Server_Setup_Compile;

["Server_Government_RemoveRank",
{
	private _faction = param [0,""];
	private _rank = param [1,""];
	private _ranks = [_faction,"ranks"] call A3PL_Config_GetRanks;
	private _index = _ranks select 1;
	private _ranks = _ranks select 0;
	{
		if ((_x select 0) isEqualTo _rank) exitwith {_ranks deleteAt _forEachIndex;};
	} foreach _ranks;
	Server_Government_FactionRanks set [_index,[_faction,_ranks]];
	publicVariable "Server_Government_FactionRanks";
	["Server_Government_FactionRanks",true] call Server_Core_SavePersistentVar;
},true] call Server_Setup_Compile;

["Server_Government_SetPay",
{
	private _faction = param [0,""];
	private _rank = param [1,""];
	private _pay = param [2,0];
	private _ranks = [_faction,"ranks"] call A3PL_Config_GetRanks;
	private _index = _ranks select 1;
	private _ranks = _ranks select 0;
	{
		if ((_x select 0) isEqualTo _rank) then {_ranks set[_forEachIndex,[(_x select 0),(_x select 1),_pay]]};
	} foreach _ranks;
	publicVariable "Server_Government_FactionRanks";
	["Server_Government_FactionRanks",true] call Server_Core_SavePersistentVar;
},true] call Server_Setup_Compile;

["Server_Government_HistorySetup",
{
	private _faction = [param [0,"fisd"]] call A3PL_Config_GetBalance;
	private _player = param [1,objNull];
	private _query = format ["SELECT amount, description, date_log FROM factions_budget_logs WHERE faction='%1'",_faction];
	private _logs = [_query, 2, true] call Server_Database_Async;
	[_logs] remoteExec ["A3PL_Government_HistoryReceive",(owner _player)];
},true] call Server_Setup_Compile;