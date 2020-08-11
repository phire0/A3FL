/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//Initiate a conversation with NPC
["A3PL_NPC_Start",
{
	disableSerialization;
	private ["_idNPC","_npcText","_npcOptions","_npcActions","_display","_ctrl","_xCoor","_yCoor","_wCoor","_hCoor"];
	_idNPC = param [0,""];

	{
		if ((_x select 0) == _idNPC) exitwith
		{
			_npcText = _x select 1;
			_npcOptions = _x select 2;
			_npcActions = _x select 3;
		};
	} foreach Config_NPC_Text;

	//couldn't find _idNPC in Config_NPC_Text
	if (isNil "_npcText") exitwith {};

	createDialog "Dialog_NPC";
	_display = findDisplay 27;

	//create our camera here, we delete this inside the unload script
	A3PL_NPC_Cam = "camera" camCreate (getpos player);
	A3PL_NPC_Cam attachto [player,[0,0.37,1.6]];
	A3PL_NPC_Cam CamSetTarget (ASLToAGL (eyePos player));
	A3PL_NPC_Cam cameraEffect ["INTERNAL", "BACK", "A3PL_NPC_RT"];
	A3PL_NPC_Cam camCommit 0;

	//Set NPC text
	_ctrl = _display displayCtrl 1100;
	_ctrl ctrlSetStructuredText parseText(_npcText);

	_xCoor = 0.453594 * safezoneW + safezoneX;
	_yCoor = 0.566;
	_wCoor = 0.221719 * safezoneW;
	_hCoor = 0.022 * safezoneH;
	{
		_ctrl = _display ctrlCreate ["RscButton",-1];
		_ctrl ctrlSetPosition [_xCoor,(_yCoor * safezoneH + safezoneY),_wCoor,_hCoor];
		_ctrl ctrlSetText _x;
		_ctrl buttonSetAction format ["[] spawn {%1}",("closeDialog 0; sleep 0.01;" + (_npcActions select _forEachIndex))];
		_ctrl ctrlCommit 0;
		_yCoor = _yCoor + 0.022;
	} foreach _npcOptions;

}] call Server_Setup_Compile;

["A3PL_NPC_TakeJob",
{
	//we will request a job change here
	private ["_job"];

	_job = param [0,""];
	if (_job == "") exitwith {[localize"STR_NPC_1", "red"] call A3PL_Player_Notification;}; //no job specified, means im an idiot

	//Send a request to server
	[player,_job] remoteExec ["Server_NPC_RequestJob", 2];
}] call Server_Setup_Compile;

["A3PL_NPC_ReqJobUniform",
{
	_job = player getVariable ["job","unemployed"];
	if ((missionnamespace getvariable ["JobUniformTimer",time]) > time) exitwith {[format [localize"STR_NPC_2",round (JobUniformTimer - time)], "red"] call A3PL_Player_Notification;};
	if ((_this select 0) == _job) then {
		switch (_job) do {
			case "mcfisher": { player adduniform "A3PL_mcFishers_Uniform_uniform"; player addheadgear "A3PL_mcFishers_cap"; };
			case "tacohell": { player adduniform "A3PL_TacoHell_Uniform_Uniform"; player addheadgear "A3PL_TacoHell_cap"; };
			default {};
		};
		JobUniformTimer = time + 300;
	} else {
		[format [localize"STR_NPC_3"], "yellow"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_NPC_LeaveJob",
{
	_job = player getVariable ["job","unemployed"];
	[player,"unemployed"] remoteExec ["Server_NPC_RequestJob", 2];
}] call Server_Setup_Compile;

["A3PL_NPC_TakeJobResponse",
{
	private _response = param [0,-1];
	private _job = param [1,""];
	private _oldJob = player getVariable["job","unemployed"];
	private _text = "";
	if (_response == -1) exitwith {[localize"STR_NPC_4", "red"] call A3PL_Player_Notification;}; 

	switch (_response) do
	{
		case 1: {_text = [format [localize"STR_NPC_5",toUpper(_job)],"green"];};
		default {_text = "Unspecified response in TakeJobResponse, report this error"};
	};

	if (isNil "_text") exitwith {[format [localize"STR_NPC_6"], "red"] call A3PL_Player_Notification;};

	_text call A3PL_Player_Notification;

	switch (_job) do
	{
		case "mcfisher": {["mcfishers_accepted"] call A3PL_NPC_Start;};
		case "fisher": {["fisherman_accepted"] call A3PL_NPC_Start;};
		case "fifr": {["fifr_accepted"] call A3PL_NPC_Start;};
		case "uscg": {["uscg_accepted"] call A3PL_NPC_Start;};
		case "farmer": {["farmer_accepted"] call A3PL_NPC_Start;};
		case "tacohell": {["tacohell_accepted"] call A3PL_NPC_Start;};
		case "oil": {["oil_accepted"] call A3PL_NPC_Start;};
		case "mailman": {["mailman_accepted"] call A3PL_NPC_Start;};
		case "unemployed": {[player] remoteExec ["Server_iPhoneX_getPhoneNumber",2];};
		default {};
	};
	[getPlayerUID player,"ChangeJob",["New Job",_job,"Old Job",_oldJob]] call Server_Log_New;
}] call Server_Setup_Compile;