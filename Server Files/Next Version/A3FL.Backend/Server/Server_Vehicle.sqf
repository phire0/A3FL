/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Vehicle_Buy",
{
	private _player = param [0,objNull];
	if (isNull _player) exitwith {diag_log "Error in Server_Vehicle_Buy: _player is Null"};
	private _uid = getPlayerUID _player;
	private _class = param [1,""];
	private _type = param [2,"vehicle"];
	private _inStorage = param [3,false];
	private _id = [7] call Server_Housing_GenerateID;
	private _query = format ["INSERT INTO objects (id,type,class,uid) VALUES ('%1','%2','%3','%4')",_id,_type,_class,_uid];
	if (_inStorage) then {
		_query = format ["INSERT INTO objects (id,type,class,uid,plystorage) VALUES ('%1','%2','%3','%4','1')",_id,_type,_class,_uid];
	};
	[_query,1] spawn Server_Database_Async;
	_id
},true] call Server_Setup_Compile;

["Server_Vehicle_Sell",
{
	private _vehicle = param [0,objNull];
	private _id = (_vehicle getVariable ["owner",[]]);
	[_vehicle] call Server_Vehicle_Despawn;
	if(count(_id) isEqualTo 0) exitWith {};
	private _query = format ["DELETE FROM objects WHERE id='%1'",_id select 1];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Vehicle_InitLPChange",
{
	private _player = param [0,objNull];
	private _veh = param [1,objNull];
	private _newLP = param [2,""];
	private _currentLP = (_veh getVariable ["owner",["",""]]) select 1;
	private _canChange = _veh getVariable "numPChange";

	if(_canChange == 1) exitWith {[2] remoteExec ["A3PL_Garage_SetLicensePlateResponse", (owner _player), false];};
	private _exist = [_newLP] call Server_Vehicle_CheckLP;
	if (_exist) exitwith {[0] remoteExec ["A3PL_Garage_SetLicensePlateResponse", (owner _player), false];};

	//set new LP texture
	[_newLP,_veh] call Server_Vehicle_Init_SetLicensePlate;

	private _query = format ["UPDATE objects SET id = '%2',numpchange='1',iscustomplate='1' WHERE id = '%1'",_currentLP,_newLP];
	[_query,1] spawn Server_Database_Async;

  	_player setVariable ["player_cash",(_player getVariable ["player_cash",0]) - 20000,true];
  	["Federal Reserve",20000] remoteExec ["Server_Government_AddBalance",2];

	_veh setVariable ["owner",[(getplayerUID _player),_newLP],true];
	_veh setVariable ["numPChange",1,true];
	_veh setVariable ["isCustomPlate",1,true];
	[1] remoteExec ["A3PL_Garage_SetLicensePlateResponse", (owner _player), false];
},true] call Server_Setup_Compile;

["Server_Vehicle_CheckLP",
{
	private _newLP = param [0,""];
	private _return = false;
	private _query = format ["SELECT id FROM objects WHERE id='%1'",_newLP];
	private _idexist = [_query, 2, true] call Server_Database_Async;
	if ((count _idexist) > 0) then {_return = true;};
	_return;
},true] call Server_Setup_Compile;

['Server_Vehicle_Spawn', {
	private ['_class','_pos','_initfunction','_veh','_id',"_owner"];

	_class = param [0,""];
	_pos = param [1,[]];
	_id = param [2,-1];
	_owner = param [3,objNull];
	_initfunction = !isNil ('Server_Vehicle_Init_' + _class);
	_veh = ObjNull;
	diag_log format ["Server_Vehicle_Spawn: Spawning %1 @ %2 for %3",_class,_pos,(_owner getVariable ["name",name _owner])];

	if (typename _pos == 'Object') then {
		_veh = createVehicle [_class, (getPos _pos), [], 0, 'CAN_COLLIDE'];
		_veh setDir (getDir _pos);
		_veh setpos (getPos _pos);
	} else {
		_veh = createVehicle [_class, _pos, [], 0, 'CAN_COLLIDE'];
	};

	if (isNull _veh) exitwith {diag_log "Server_Vehicle_Spawn Error: _veh isNull"};

	_veh setFuelCargo 0;
	_veh setVariable ["owner",[(getplayerUID _owner),_id],true];
	Server_Storage_ListVehicles pushback _veh;
	if (_id IN ["WASTE","MAILMAN","EXTERMINATOR","KARTING","ROADSIDE","LCMRENT"]) then {
		switch (_class) do {
			case ("A3PL_P362_Garbage_Truck"): {_veh setObjectTextureGlobal [0,"\A3PL_Textures\Peterbilt_Garbage_Truck\Waste_Management_Garbage_Truck.paa"];};
			case ("A3PL_Mailtruck"):
			{
				if (_id isEqualTo "EXTERMINATOR") then {
					_veh setObjectTextureGlobal [0,"\A3PL_Textures\MailTruck\Exterminator_Truck.paa"];
				};
				if (_id isEqualTo "MAILMAN") then
				{
					_setDir = 30;
					if(_pos isEqualTo [6056.77,7393.57,0]) then {_setDir = 33.8471;};
					if(_pos isEqualTo [3507.66,7541.57,0]) then {_setDir = 96;};
					if(_pos isEqualTo [10313.1,8556.05,0]) then {_setDir = 271.516;};
					if(_pos isEqualTo [4143.49,6317.9,0]) then {_setDir = 91.5289;};
					if(_pos isEqualTo [2213.505,11845.4,0]) then {_setDir = 271.575;};
					_veh setDir(_setDir);
				};
			};
		};
		_owner setVariable ["jobVehicle",_veh,true];
	};

	[_veh,_id] call Server_Vehicle_Init_General;

	if (_initfunction) then
	{
		_veh call (missionNamespace getVariable ('Server_Vehicle_Init_' + _class));
	};

	if ((typeOf _veh) IN A3PL_HitchingVehicles) then
	{
		_veh call Server_Vehicle_Init_A3PL_F150;
	};
	if(typeOf _veh IN ["A3PL_MiniExcavator","A3PL_Boat_Trailer","A3PL_Box_Trailer","A3PL_Lowloader","A3PL_Tanker_Trailer","A3PL_Drill_Trailer","A3PL_Small_Boat_Trailer","A3PL_Car_Trailer"]) then {
		_veh allowdamage false;
	};

	if(((_owner getVariable["job","unemployed"]) == "uscg") && (_class == "A3PL_RHIB")) then {
		_veh setObjectTextureGlobal [0,"\A3PL_Textures\RHIB\Default\CG_RHIB.paa"];
		_veh setObjectTextureGlobal [1,"\A3PL_Textures\RHIB\Default\CG_RHIB_P2.paa"];
	};
	[_veh] remoteExec ["A3PL_Vehicle_AddKey",_owner];
	_veh;
},true] call Server_Setup_Compile;

["Server_Vehicle_Despawn",
{
	private _veh = param [0,objNull];
	{deleteVehicle _x;} foreach (attachedObjects _veh);
	deleteVehicle _veh;
}] call Server_Setup_Compile;

["Server_Vehicle_Siren_Init",
{
	private _veh = _this;
	private _classname = typeOf _veh;
	private _sirenType = "police";
	switch (true) do {
		case (_classname IN ["A3PL_Pierce_Rescue","A3PL_Pierce_Pumper","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder"]): {_sirenType = "fire";};
		case (_classname IN ["A3PL_Silverado_FD_Brush","A3PL_Charger15_FD","A3PL_Taurus_FD","A3PL_Tahoe_FD"]): {_sirenType = "fire_FR";};
		case (_classname IN ["Jonzie_Ambulance","A3PL_E350"]): {_sirenType = "ems";};
	};
	switch (_sirenType) do {
		case "police": {
			private _SoundSource_1 = createSoundSource ["A3PL_FSUO_Siren", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			private _SoundSource_2 = createSoundSource ["A3PL_FSS_Phaser", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			private _SoundSource_3 = createSoundSource ["A3PL_FSS_Priority", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			private _SoundSource_4 = createSoundSource ["A3PL_FSS_Rumbler", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			private _Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "fire": {
			private _SoundSource_1 = createSoundSource ["A3PL_EQ2B_Wail", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			private _SoundSource_2 = createSoundSource ["A3PL_Whelen_Warble", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			private _SoundSource_3 = createSoundSource ["A3PL_AirHorn_1", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			private _Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "fire_FR": {
			private _SoundSource_1 = createSoundSource ["A3PL_FSUO_Siren", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			private _SoundSource_2 = createSoundSource ["A3PL_Whelen_Priority3", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			private _SoundSource_3 = createSoundSource ["A3PL_FIPA20A_Priority", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			private _SoundSource_4 = createSoundSource ["A3PL_Electric_Horn", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			private _Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "ems": {
			private _SoundSource_1 = createSoundSource ["A3PL_Whelen_Siren", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			private _SoundSource_2 = createSoundSource ["A3PL_Whelen_Priority", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			private _SoundSource_3 = createSoundSource ["A3PL_Whelen_Priority2", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			private _SoundSource_4 = createSoundSource ["A3PL_Electric_Airhorn", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			private _Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
	};
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_Jayhawk', {
	private _basket = "A3PL_RescueBasket" createVehicle [0,0,0];
	_basket allowdamage false;
	_basket setVariable ["locked",false,true];
	_basket attachTo [_this, [0,999999,0] ];
	_this setVariable ["basket",_basket,true];
	_basket setVariable ["vehicle",_this,true];
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_F150',
{
	private _veh = _this;
	_veh addEventHandler ["GetIn",
	{
		private _veh = _this select 0;
		private _pos = _this select 1;
		private _unit = _this select 2;
		if (_pos != "driver") exitwith {};
		private _trailerArray = nearestObjects [(_veh modelToWorld [0,-4,0]), ["A3PL_Trailer_Base"], 6.5];
		if ((count _trailerArray) > 0) then {
			private _trailerArray = _trailerArray select 0;
			if (!((owner _trailerArray) isEqualTo (owner _unit))) then {
				_trailerArray setOwner (owner _unit);
			};
		};
	}];
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_Patrol', {
	private _veh2 = createVehicle ["B_Lifeboat", getpos _this, [], 0, 'CAN_COLLIDE'];
	_veh2 attachto [_this,[0,-11,-6]];
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_Goose_Base",{},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_Pierce_Pumper',
{
	_this call Server_Vehicle_Siren_Init;
	private _light_1 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	private _light_2 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	private _Rotator1 = "A3PL_Red_Rotator" createVehicle [0,0,0];
	private _Rotator2 = "A3PL_White_Rotator" createVehicle [0,0,0];
	private _Rotator3 = "A3PL_Red_Rotator_off" createVehicle [0,0,0];
	private _Rotator4 = "A3PL_White_Rotator_off" createVehicle [0,0,0];
	private _Rotator5 = "A3PL_Red_Rotator" createVehicle [0,0,0];
	private _Rotator6 = "A3PL_White_Rotator" createVehicle [0,0,0];
	private _Rotator7 = "A3PL_Red_Rotator_off" createVehicle [0,0,0];
	private _Rotator8 = "A3PL_White_Rotator_off" createVehicle [0,0,0];
	private _Rotator9 = "A3PL_Red_Rotator" createVehicle [0,0,0];
	private _Rotator10 = "A3PL_White_Rotator" createVehicle [0,0,0];
	private _Rotator11 = "A3PL_Red_Rotator_off" createVehicle [0,0,0];
	private _Flag = "A3PL_Mini_Flag_US" createVehicle [0,0,0];
	_light_1 attachTo [_this, [0, 0, 0.79], "Floodlight_1"];
	_light_2 attachTo [_this, [0, 0, 0.79], "Floodlight_2"];
	_Rotator1 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light1"];
	_Rotator2 attachTo [_this, [0, -0.44, 1.01], "Rotator_Light2"];
	_Rotator3 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light3"];
	_Rotator4 attachTo [_this, [0, -0.44, 1.01], "Rotator_Light4"];
	_Rotator5 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light5"];
	_Rotator6 attachTo [_this, [0, -0.44, 1.01], "Rotator_Light6"];
	_Rotator7 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light7"];
	_Rotator8 attachTo [_this, [0, -0.44, 1.01], "Rotator_Light8"];
	_Rotator9 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light9"];
	_Rotator10 attachTo [_this, [0, -0.44, 1.01], "Rotator_Light10"];
	_Rotator11 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light11"];
	_Flag attachTo [_this, [0.85, -4.59, -2.24]];
	_light_2 setdir 180;
	_Flag setFlagTexture "\A3\Data_F\Flags\Flag_us_CO.paa";
	[_this,"A3PL_Pierce_Pumper"] call A3PL_FD_SetPumperNumber;
	_this setVariable ["water",0,true];
	_this setVariable ["pressure","low",true];
	_this animate ["Water_Gauge1",0];
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_Pierce_Rescue',
{
	_this call Server_Vehicle_Siren_Init;
	private _light_1 = "A3PL_RescueTruck_Light" createVehicle [0,0,0];
	private _light_2 = "A3PL_RescueTruck_Light" createVehicle [0,0,0];
	private _light_3 = "A3PL_RescueTruck_Light" createVehicle [0,0,0];
	private _light_4 = "A3PL_RescueTruck_Light" createVehicle [0,0,0];
	private _light_5 = "A3PL_RescueTruck_Light" createVehicle [0,0,0];
	private _light_6 = "A3PL_RescueTruck_Light" createVehicle [0,0,0];
	private _Rotator1 = "A3PL_Red_Rotator" createVehicle [0,0,0];
	private _Rotator2 = "A3PL_White_Rotator" createVehicle [0,0,0];
	private _Rotator3 = "A3PL_Red_Rotator_off" createVehicle [0,0,0];
	private _Rotator4 = "A3PL_White_Rotator_off" createVehicle [0,0,0];
	private _Rotator5 = "A3PL_Red_Rotator" createVehicle [0,0,0];
	private _Rotator6 = "A3PL_White_Rotator" createVehicle [0,0,0];
	private _Rotator7 = "A3PL_Red_Rotator_off" createVehicle [0,0,0];
	private _Rotator8 = "A3PL_White_Rotator_off" createVehicle [0,0,0];
	private _Rotator9 = "A3PL_Red_Rotator" createVehicle [0,0,0];
	private _Rotator10 = "A3PL_White_Rotator" createVehicle [0,0,0];
	private _Rotator11 = "A3PL_Red_Rotator_off" createVehicle [0,0,0];
	_Rotator1 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light1"];
	_Rotator2 attachTo [_this, [0, -0.44, 1.01], "Rotator_Light2"];
	_Rotator3 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light3"];
	_Rotator4 attachTo [_this, [0, -0.44, 1.01], "Rotator_Light4"];
	_Rotator5 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light5"];
	_Rotator6 attachTo [_this, [0, -0.44, 1.01], "Rotator_Light6"];
	_Rotator7 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light7"];
	_Rotator8 attachTo [_this, [0, -0.44, 1.01], "Rotator_Light8"];
	_Rotator9 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light9"];
	_Rotator10 attachTo [_this, [0, -0.44, 1.01], "Rotator_Light10"];
	_Rotator11 attachTo [_this, [0, 0.44, 1.01], "Rotator_Light11"];
	_light_1 attachTo [_this, [0, 0, 0.79], "top_light_1"];
	_light_2 attachTo [_this, [0, 0, 0.79], "top_light_2"];
	_light_3 attachTo [_this, [0, 0, 0.79], "top_light_3"];
	_light_4 attachTo [_this, [0, 0, 0.79], "top_light_4"];
	_light_5 attachTo [_this, [0, 0, 0.79], "top_light_5"];
	_light_6 attachTo [_this, [0, 0, 0.79], "top_light_6"];
	[_this,"A3PL_Pierce_Rescue"] call A3PL_FD_SetRescueNumber;
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_Pierce_Ladder',
{
	_this call Server_Vehicle_Siren_Init;
	private _light_1 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	private _light_2 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	private _light_3 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	private _light_4 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	private _Ladder = "A3PL_Rear_Ladder" createVehicle [0,0,0];
	private _Flag = "A3PL_Mini_Flag_US" createVehicle [0,0,0];
	_light_1 attachTo [_this, [0, 0, 0], "Floodlight_1"];
	_light_2 attachTo [_this, [0, 0, 0], "Floodlight_2"];
	_light_3 attachTo [_this, [0, 0, 0], "Floodlight_3"];
	_light_4 attachTo [_this, [0, 0, 0], "Floodlight_4"];
	_Ladder attachTo [_this, [0, -1, -16.1]];
	_Flag attachTo [_this, [-0.05, 0.39, -2.3], "Flag_Point"];
	_light_3 setdir 180;
	_light_4 setdir 180;
	_Flag setFlagTexture "\A3\Data_F\Flags\Flag_us_CO.paa";
},true] call Server_Setup_Compile;
['Server_Vehicle_Init_A3PL_Pierce_Heavy_Ladder',{_this call Server_Vehicle_Init_A3PL_Pierce_Ladder;},true] call Server_Setup_Compile;

['Server_Vehicle_Init_Jonzie_Ambulance',
{
	_this call Server_Vehicle_Siren_Init;
	private _light_1 = "A3PL_Floodlight" createVehicle [0,0,0];
	private _light_2 = "A3PL_Floodlight" createVehicle [0,0,0];
	private _light_3 = "A3PL_Floodlight" createVehicle [0,0,0];
	private _light_4 = "A3PL_Floodlight" createVehicle [0,0,0];
	private _light_5 = "A3PL_Floodlight" createVehicle [0,0,0];
	private _light_6 = "A3PL_Floodlight" createVehicle [0,0,0];
	private _light_7 = "A3PL_Interior_light" createVehicle [0,0,0];
	_light_1 attachTo [_this, [0.03, 0, 0.8], "Floodlight_1"];
	_light_2 attachTo [_this, [0.03, 0, 0.8], "Floodlight_2"];
	_light_3 attachTo [_this, [-0.03, 0, 0.8], "Floodlight_3"];
	_light_4 attachTo [_this, [-0.03, 0, 0.8], "Floodlight_4"];
	_light_5 attachTo [_this, [0, 0, 0.8], "Floodlight_5"];
	_light_6 attachTo [_this, [0, 0, 0.8], "Floodlight_6"];
	_light_7 attachTo [_this, [0, 0, 0], "Interior_Lights"];
	_light_3 setdir 180;
	_light_4 setdir 180;
	_light_5 setdir 270;
	_light_6 setdir 270;
},true] call Server_Setup_Compile;
['Server_Vehicle_Init_A3PL_E350',{_this call Server_Vehicle_Init_Jonzie_Ambulance;},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_Tahoe_PD",
{
	_this call Server_Vehicle_Siren_Init;
	private _light_1 = "A3PL_Floodlight_Level" createVehicle [0,0,0];
	private _light_2 = "A3PL_Floodlight_Level" createVehicle [0,0,0];
	_light_1 attachTo [_this, [0.03, 0, 0.8], "Floodlight_1"];
	_light_2 attachTo [_this, [-0.03, 0, 0.8], "Floodlight_2"];
	_light_2 setdir 180;
	_this animate ["Pushbar_Addon",1];
	_this animate ["Spotlight_Addon",1];
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop",{_this call Server_Vehicle_Siren_Init;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_CVPI_PD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_CVPI_PD_Slicktop",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Mustang_PD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Mustang_PD_Slicktop",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Charger_PD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_F150_Marker_PD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Charger_PD_Slicktop",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Silverado_PD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_VetteZR1_PD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Taurus_PD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Charger15_PD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Charger15_FD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Charger15_PD_ST",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Taurus_PD_ST",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Raptor_PD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_M_explorer",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Raptor_PD_ST",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Taurus_PD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Taurus_FD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Silverado_PD_ST",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Silverado_FD",{_this call Server_Vehicle_Init_A3PL_Tahoe_PD;},true] call Server_Setup_Compile;
["Server_Vehicle_Init_A3PL_Silverado_FD_Brush",{
	_this call Server_Vehicle_Siren_Init;
	private _light_1 = "A3PL_Floodlight_Level" createVehicle [0,0,0];
	private _light_2 = "A3PL_Floodlight_Level" createVehicle [0,0,0];
	_light_1 attachTo [_this, [0.03, 0, 0.8], "Floodlight_1"];
	_light_2 attachTo [_this, [-0.03, 0, 0.8], "Floodlight_2"];
	_light_2 setdir 180;
	[_this,"A3PL_Silverado_FD_Brush"] call A3PL_FD_SetBrushNumber;
	_this setVariable ["water",0,true];
	_this setVariable ["pressure","low",true];
	_this animate ["Water_Gauge1",0];
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_C_Van_02_transport_F",
{
	_this setObjectTextureGlobal [1, "\a3\Soft_F_Orange\Van_02\Data\van_wheel_transport_co.paa"];
	_this setObjectTextureGlobal [2, "\a3\Soft_F_Orange\Van_02\Data\van_glass_civservice_ca.paa"];
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_C_Heli_Light_01_civil_F",
{
	private _veh = _this;
	_veh animate ["addDoors",1];
	private _veh = param [0,objNull];
	private _position = param [1,""];
	private _unit = param [2,objNull];
	if (!local _unit) exitwith {};
	if (_position IN ["gunner","driver"]) then {[_veh] spawn A3PL_ATC_GetInAircraft;};
	_this call Server_Vehicle_Init_C_Heli_Light_01_civil_F;
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_SetLicensePlate',
{
    private _plate = _this select 0;
    private _vehicle = _this select 1;
    private _extraVehicles = ["C_Van_02_transport_F"];
    if(typeOf _vehicle IN _extraVehicles) then {_vehicle setPlateNumber toUpper(_plate);};
    for "_i" from 0 to (count _plate) do {
        _vehicle setObjectTextureGlobal [_i+1,(format ["A3PL_Cars\Common\Number_Plates\%1.paa",_plate select [_i,1]])];
    };
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_General', {
	private _veh = param [0,objNull];
	private _id = param [1,"-1"];
	_veh lock 2;
	_veh addMPEventHandler ["MPKilled", {[_this select 0] spawn Server_Fire_VehicleExplode;}]; 
	_veh addEventHandler ["GetOut", {
		private _vehicle = param [0,objNull];
		private _role = param [1,"none"];
		if(_role isEqualTo "driver") then {[_vehicle] spawn Server_Fuel_Vehicle;};
	}];
	if (_veh isKindOf "LandVehicle") then {
		_veh animate ["Camo1",1];
		_veh animate ["Glass0_destruct",1];
		if (_id != "-1") then {[_id,_veh] call Server_Vehicle_Init_SetLicensePlate;};
	};
},true] call Server_Setup_Compile;

['Server_Vehicle_Trailer_Hitch',
{
	private ["_truck","_trailer"];
	_truck = param [0,objNull];
	_trailer = param [1,objNull];

	if ((owner _truck) != (owner _trailer)) then
	{
		_trailer setOwner (owner _truck);
	};
},true] call Server_Setup_Compile;

["Server_Vehicle_TrailerDetach",
{
	private _boat = param [0,objNull];
	private _trailer = attachedTo _boat;
	if ((isNull _trailer) OR (isNull _boat)) exitwith {};
	_boat allowDamage false;
	if ((owner _trailer) != (owner _boat)) then {_boat setOwner (owner _trailer);};
	[_boat] spawn {
		private _boat = param [0,objNull];
		[_boat] remoteExec ["Server_Vehicle_EnableSimulation", 2];
		sleep 1.5;
		detach _boat;
		sleep 10;
		_boat allowDamage true;
	};
},true] call Server_Setup_Compile;

["Server_Vehicle_EnableSimulation",
{
	private _veh = param [0,objNull];
	private _force = param [1,false];
	private _forceEnable = param [2,false];
	if (isNull _veh) exitwith {};
	if (_force) exitwith {_veh enableSimulationGlobal _forceEnable;};
	if (simulationEnabled _veh) then {
		_veh enableSimulationGlobal false;
	} else {
		_veh enableSimulationGlobal true;
	};
},true] call Server_Setup_Compile;

["Server_Vehicle_AtegoHandle",
{
	private _player = param [0,objNull];
	private _truck = param [1,objNull];
	private _car = param [2,objNull];
	private _oTruck = owner _truck;
	private _oPlayer = owner _player;
	private _oCar = owner _car;
	if (_oTruck != _oPlayer) then {
		_truck setOwner _oPlayer;
	};
	if ((!isNull _car) && (_oCar != _oTruck)) then {
		_car setOwner _oPlayer;
	};
	[_truck,_car] remoteExec ["A3PL_Vehicle_AtegoTowResponse", _oPlayer];
},true] call Server_Setup_Compile;

["Server_Vehicle_Insure",
{
	private _veh = param [0,objNull];
	private _id = (_veh getVariable ["owner",[]]) select 1;
	private _query = format ["UPDATE objects SET insurance = '1' WHERE id = '%1'",_id];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Vehicle_SaveKeys",
{
	private _data = param [0,[]];
	private _uid = param [1,""];
	if(_uid isEqualTo "") exitWith {};
	private _data = _data - [objNull];
	missionNamespace setVariable [format ["%1_KEYS",_uid],_data];
},true] call Server_Setup_Compile;

["Server_Vehicle_SetPaint",
{
	private _vehicle = param [0,objNull];
	private _texture = param [1,""];
	private _id = _vehicle getVariable ["owner",[]];
	if(count(_id) isEqualTo 0) exitWith {};
	if((typeName _texture) isEqualTo "ARRAY") then {_texture = [_texture] call Server_Database_Array;};
	_texture = [_texture, "\", "\\"] call CBA_fnc_replace;
	diag_log str _texture;
	private _query = format ["UPDATE objects SET color = '%2' WHERE id = '%1'",_id select 1,_texture];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;