/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_fisherman_loop",
{
	private _tempRemove = [];
	{
		private _state = _x getVariable ["fishstate",nil];
		if (!isNil "_state") then {
			if (_state >= 100) then {
				_tempRemove pushback _x;
			} else {
				_x setVariable ["fishstate",_state+10,true];
			};
		};
	} foreach Server_FishingBuoys;
	{
		Server_FishingBuoys = Server_FishingBuoys - [_x];
		ropeDestroy (_x getVariable ["rope",objNull]);
		deleteVehicle (_x getVariable ["net",objNull]);
		deleteVehicle _x;
	} foreach _tempRemove;
}] call Server_Setup_Compile;

["Server_JobFisherman_DeployNet",
{
	params[["_player",objNull,[objNull]],["_buoy",objNull,[objNull]]];
	if (isNull _player) exitwith {};
	if (isNull _buoy) exitwith {};
	if (!(typeOf _buoy isEqualTo "A3PL_FishingBuoy")) exitwith {[2] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];};

	[] remoteExec ["A3PL_JobFisherman_DeployNetSuccess",_player];

	private _pos = getPos _buoy;
	_buoy setVariable ["fishstate",0,true];
	_buoy setVariable ["class",nil,true];
	_buoy setVariable ["owner",getPlayerUID _player,true];
	_buoy setVariable ["used",false,true];

	Server_FishingBuoys pushBack _buoy;

	private _net = createVehicle ["A3PL_Net", [_pos select 0,_pos select 1, (_pos select 2) - 1], [], 0, "CAN_COLLIDE"];
	private _rope = ropeCreate [_buoy,"rope",_net,"rope",2];
	_buoy setVariable ["rope",_rope,false];
	_buoy setVariable ["net",_net,false];

	_buoy setOwner (owner _player);
	_net setOwner (owner _player);
},true] call Server_Setup_Compile;

["Server_JobFisherman_GrabNet",
{
	private _player = param [0,objNull];
	private _buoy = param [1,objNull];
	if (isNull _player) exitwith {diag_log format ["Error: _player isnull in Server_JobFisherman_GrabNet for %1",name _player]};
	if (isNull _buoy) exitwith {
		diag_log format ["Error: _buoy isnull in Server_JobFisherman_GrabNet for %1",name _player];
		[1] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
	};
	if (!(["bucket_empty",1,_player] call Server_Inventory_Has)) exitwith {[0] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];_buoy setVariable ["used",false,true];};
	[_player, "bucket_empty", -1] call Server_Inventory_Add;
	Server_FishingBuoys = Server_FishingBuoys - [_buoy];

	ropeDestroy (_buoy getVariable "rope");
	deleteVehicle (_buoy getVariable "net");
	deleteVehicle _buoy;
	switch (true) do {
		case ((_player inArea "A3PL_Marker_Fish1") OR (_player inArea "A3PL_Marker_Fish2") OR (_player inArea "A3PL_Marker_Fish4")): {
			[_player,"bucket_full",1] call Server_Inventory_Add;
			[_player,"mullet",1] call Server_Inventory_Add;
			[5] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
		};
		case ((_buoy getVariable ["bait","none"]) == "shark"): {
			private _random = random 10;
			if (_random > 7) exitwith {
				[_player,"bucket_full",1] call Server_Inventory_Add;
				[7] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
			};
			private _random = round (random 100);
			switch (true) do {
				case (_random >= 65): {[_player,"shark_2lb",1] call Server_Inventory_Add;};
				case (_random >= 40): {[_player,"shark_4lb",1] call Server_Inventory_Add;};
				case (_random >= 25): {[_player,"shark_5lb",1] call Server_Inventory_Add;};
				case (_random >= 10): {[_player,"shark_7lb",1] call Server_Inventory_Add;};
				case (_random >= 0): {[_player,"shark_10lb",1] call Server_Inventory_Add;};
			};
			[6] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
		};
		case ((_buoy getVariable ["bait","none"]) isEqualTo "turtle"): {
			[_player,"bucket_full",1] call Server_Inventory_Add;
			private _random = random 10;
			//10% - less than 3 CG on
			if ((count(["uscg"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {
				if (_random <= 1) then {
					[9] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
					[_player,"turtle",1] call Server_Inventory_Add;
				} else {
					[8] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
				};
			};
			//40% - less than 4 CG on
			if ((count(["uscg"] call A3PL_Lib_FactionPlayers)) < 4) exitWith {
				if (_random <= 4) then {
					[9] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
					[_player,"turtle",1] call Server_Inventory_Add;
				} else {
					[8] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
				};
			};
			//45% - less than 4 CG on
			if ((count(["uscg"] call A3PL_Lib_FactionPlayers)) < 4) exitWith {
				if (_random <= 4.5) then {
					[9] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
					[_player,"turtle",1] call Server_Inventory_Add;
				} else {
					[8] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
				};
			};
			//50% - 6 or more CG on
			if (_random <= 5) then {
				[9] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
				[_player,"turtle",1] call Server_Inventory_Add;
			} else {
				[8] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
			};
		};
		default {
			[_player,"bucket_full",1] call Server_Inventory_Add;
			[3] remoteExec ["A3PL_JobFisherman_DeployNetResponse",_player];
		};
	};
	[getPlayerUID _player,"PickupItem",["Collected Net","bucket_full",1]] call Server_Log_New;
}] call Server_Setup_Compile;