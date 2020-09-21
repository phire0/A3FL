/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_NPC_RequestJob", {
	private _player = param [0,ObjNull];
	private _job = param [1,"unemployed"];
	if (isNull _player) exitwith {};
	_player setVariable ["job",_job,true];
	[1,_job] remoteExec ["A3PL_NPC_TakeJobResponse",_player];
	[] remoteExec ["A3PL_Player_SetMarkers", _player];
	if ((backpack _player != "A3PL_LR") && (_job IN ["uscg","fifr","fisd","fims","doj"])) then {_player addBackpackGlobal "A3PL_LR";};
},true] call Server_Setup_Compile;