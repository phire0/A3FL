/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_NPC_Start",
{
	disableSerialization;
	private _idNPC = param [0,""];
	private _npcText = nil;
	private _npcOptions = [];
	private _npcActions = [];
	{
		if ((_x select 0) == _idNPC) exitwith
		{
			_npcText = _x select 1;
			_npcOptions = _x select 2;
			_npcActions = _x select 3;
		};
	} foreach Config_NPC_Text;

	if (isNil "_npcText") exitwith {};

	createDialog "Dialog_NPC";
	private _display = findDisplay 27;

	A3PL_NPC_Cam = "camera" camCreate (getpos player);
	A3PL_NPC_Cam attachto [player,[0,0.37,1.6]];
	A3PL_NPC_Cam CamSetTarget (ASLToAGL (eyePos player));
	A3PL_NPC_Cam cameraEffect ["INTERNAL", "BACK", "A3PL_NPC_RT"];
	A3PL_NPC_Cam camCommit 0;

	private _ctrl = _display displayCtrl 1100;
	_ctrl ctrlSetStructuredText parseText(_npcText);

	private _yCoor = 0.566;
	{
		_ctrl = _display ctrlCreate ["RscButton",-1];
		_ctrl ctrlSetPosition [0.453594 * safezoneW + safezoneX,(_yCoor * safezoneH + safezoneY),0.221719 * safezoneW,0.022 * safezoneH];
		_ctrl ctrlSetText _x;
		_ctrl buttonSetAction format ["[] spawn {%1};",("closeDialog 0; sleep 0.01;" + (_npcActions select _forEachIndex))];
		_ctrl ctrlCommit 0;
		_yCoor = _yCoor + 0.022;
	} foreach _npcOptions;
}] call Server_Setup_Compile;

["A3PL_NPC_TakeJob",
{
	private _job = param [0,""];
	if (_job isEqualTo "") exitwith {[localize"STR_NPC_1", "red"] call A3PL_Player_Notification;};
	[player,_job] remoteExec ["Server_NPC_RequestJob", 2];
}] call Server_Setup_Compile;

["A3PL_NPC_ReqJobUniform",
{
	private _req = param[0,"unemployed"];
	private _job = player getVariable ["job","unemployed"];
	if (_req isEqualTo _job) then {
		switch (_job) do {
			case "mcfisher": { player adduniform "A3PL_mcFishers_Uniform_uniform"; player addheadgear "A3PL_mcFishers_cap"; };
			case "tacohell": { player adduniform "A3PL_TacoHell_Uniform_Uniform"; player addheadgear "A3PL_TacoHell_cap"; };
		};
	} else {
		[format [localize"STR_NPC_3"], "yellow"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_NPC_LeaveJob",
{
	private _job = player getVariable ["job","unemployed"];
	[player,"unemployed"] remoteExec ["Server_NPC_RequestJob", 2];
}] call Server_Setup_Compile;

["A3PL_NPC_TakeJobResponse",
{
	private _response = param [0,-1];
	private _job = param [1,""];
	private _oldJob = player getVariable["job","unemployed"];
	private _text = nil;
	if (_response isEqualTo -1) exitwith {[localize"STR_NPC_4", "red"] call A3PL_Player_Notification;}; 

	switch (_response) do {
		case 1: {_text = format [localize"STR_NPC_5",toUpper(_job)]};
	};

	switch (_job) do
	{
		case "mcfisher": {["mcfishers_accepted"] call A3PL_NPC_Start;};
		case "fisher": {["fisherman_accepted"] call A3PL_NPC_Start;};
		case "farmer": {["farmer_accepted"] call A3PL_NPC_Start;};
		case "tacohell": {["tacohell_accepted"] call A3PL_NPC_Start;};
		case "oil": {["oil_accepted"] call A3PL_NPC_Start;};
		case "mailman": {["mailman_accepted"] call A3PL_NPC_Start;};
		case "fisd": {
			private _name = player getVariable["name",""];
			private _rank = ["fisd","rank", getPlayerUID player] call A3PL_Config_GetFactionRankData;
			_text = format["You are now on duty %2 %1",_name,_rank];
		};
		case "fifr": {
			private _name = player getVariable["name",""];
			private _rank = ["fifr","rank", getPlayerUID player] call A3PL_Config_GetFactionRankData;
			_text = format["You are now on duty %2 %1",_name,_rank];
		};
		case "uscg": {
			private _name = player getVariable["name",""];
			private _rank = ["uscg","rank", getPlayerUID player] call A3PL_Config_GetFactionRankData;
			_text = format["You are now on duty %2 %1",_name,_rank];
		};
	};
	if (!isNil "_text") exitwith {[_text,"green"] call A3PL_Player_Notification;};
	[getPlayerUID player,"ChangeJob",["New Job",_job,"Old Job",_oldJob]] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;