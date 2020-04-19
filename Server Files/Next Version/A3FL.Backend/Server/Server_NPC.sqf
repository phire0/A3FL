["Server_NPC_RequestJob", {
	private _player = param [0,ObjNull];
	private _job = param [1,"unemployed"];
	if (isNull _player) exitwith {};
	_player setVariable ["job",_job,true];
	[1,_job] remoteExec ["A3PL_NPC_TakeJobResponse",_player];
	[] remoteExec ["A3PL_Player_SetMarkers", _player];
	if ((backpack _player != "A3PL_LR") && (_job IN ["uscg","fifr","fisd","usms","doj","dmv"])) then {_player addBackpackGlobal "A3PL_LR";};
},true] call Server_Setup_Compile;