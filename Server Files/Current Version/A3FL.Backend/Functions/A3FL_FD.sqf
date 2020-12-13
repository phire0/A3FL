/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['A3PL_FD_SetLadderNumber',
{
	private _veh = _this select 0;
	private _type_1 = _this select 1;
	private _type_2 = _this select 2;
	private _TruckNumber = {(typeOf _x == _type_1) OR (typeOf _x == _type_2)} count vehicles;
	private _Number1 = 0;
	private _Number2 = 0;
	private _Number3 = _TruckNumber;
	while {_Number3 > 9} do {_Number3 = _Number3 - 10; _Number2 = _Number2 + 1; if (_Number2 > 9) then { _Number1 = _Number1 + 1; _Number2 = 0};};
	if (_Number1 < 1) then {_Number1 = 0;};
	if (_Number2 < 1) then {_Number2 = 0;};
	if (_Number3 < 1) then {_Number3 = 0;};
	private _TruckNumber1 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number1];
	private _TruckNumber2 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number2];
	private _TruckNumber3 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number3];
	_veh setObjectTextureGlobal [8, _TruckNumber2 ];
	_veh setObjectTextureGlobal [9, _TruckNumber3 ];
	_veh setVariable["squadnb", str(_Number2) + str(_Number3),true];
}] call Server_Setup_Compile;

['A3PL_FD_SetPumperNumber',
{
	private _veh = _this select 0;
	private _type_1 = _this select 1;
	private _TruckNumber = {(typeOf _x == _type_1)} count vehicles;
	private _Number1 = 0;
	private _Number2 = 0;
	private _Number3 = _TruckNumber;
	while {_Number3 > 9} do {_Number3 = _Number3 - 10; _Number2 = _Number2 + 1; if (_Number2 > 9) then { _Number1 = _Number1 + 1; _Number2 = 0};};
	if (_Number1 < 1) then {_Number1 = 0;};
	if (_Number2 < 1) then {_Number2 = 0;};
	if (_Number3 < 1) then {_Number3 = 0;};
	private _TruckNumber1 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number1];
	private _TruckNumber2 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number2];
	private _TruckNumber3 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number3];
	_veh setObjectTextureGlobal [8, _TruckNumber2];
	_veh setObjectTextureGlobal [9, _TruckNumber3];
	_veh setVariable["squadnb", str(_Number2) + str(_Number3),true];
}] call Server_Setup_Compile;

['A3PL_FD_SetRescueNumber',
{
	private _veh = _this select 0;
	private _type_1 = _this select 1;
	private _TruckNumber = {(typeOf _x == _type_1)} count vehicles;
	private _Number2 = 0;
	private _Number3 = _TruckNumber;
	while {_Number3 > 9} do {_Number3 = _Number3 - 10; _Number2 = _Number2 + 1;};
	if (_Number2 < 1) then {_Number2 = 0;};
	if (_Number3 < 1) then {_Number3 = 0;};
	private _TruckNumber2 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number2];
	private _TruckNumber3 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number3];
	_veh setObjectTextureGlobal [8, _TruckNumber2];
	_veh setObjectTextureGlobal [9, _TruckNumber3];
	_veh setVariable["squadnb", str(_Number2) + str(_Number3),true];
}] call Server_Setup_Compile;

['A3PL_FD_SetBrushNumber',
{
	private _veh = _this select 0;
	private _type_1 = _this select 1;
	private _TruckNumber = {(typeOf _x isEqualTo _type_1)} count vehicles;
	_TruckNumber = _TruckNumber + 6;
	private _TruckNumber1 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _TruckNumber];
	_veh setObjectTextureGlobal [8, _TruckNumber1 ];
	_veh setVariable["squadnb", _TruckNumber,true];
}] call Server_Setup_Compile;

["A3PL_FD_HandleJaws",
{
	private _pJob = player getVariable["job","unemployed"];
	if((!(_pJob isEqualTo "fifr")) && (!(_pJob isEqualTo "fisd"))) exitWith {};
	private _intersect = missionNameSpace getVariable ["player_objintersect",objNull];
	private _nameIntersect = missionNameSpace getVariable ["player_nameintersect",""];

	if ((player distance (_intersect modelToWorld (_intersect selectionPosition _nameIntersect)) < 2) && (_nameIntersect IN ["glass2","door_lf","door_lf2","door_lf3","door_lf4","door_lf5","door_lf6"])) exitwith
	{
		if ((round random 10) > 6) then {
			[localize"STR_NewFD_PinceSuccess","green"] call A3PL_Player_Notification;
			moveOut (driver _intersect);
			_intersect setVariable ["locked",false,true];
			_intersect setVariable ["trapped",false,true];
		} else {
			[localize"STR_NewFD_PinceError","red"] call A3PL_Player_Notification;
		};
	};
	if ((player distance (_intersect modelToWorld (_intersect selectionPosition _nameIntersect)) < 2) && (_nameIntersect IN ["glass3","glass4","glass5","door_lb","door_rb","door_rf","door_lb2","door_lb3","door_lb4","door_lb5","door_lb6","door_rb2","door_rb3","door_rb4","door_rb5","door_rb6","door_rf2","door_rf3","door_rf4","door_rf5","door_rf6"])) exitwith
	{
		if ((round random 10) > 6) then {
			[localize"STR_NewFD_PinceSuccess2","green"] call A3PL_Player_Notification;
			{
				moveOut _x;
			} foreach (crew _intersect);
			_intersect setVariable ["locked",false,true];
			_intersect setVariable ["trapped",false,true];
		} else {
			[localize"STR_NewFD_PinceError2","red"] call A3PL_Player_Notification;
		};
	};
	if ((player distance (_intersect modelToWorld (_intersect selectionPosition _nameIntersect)) < 10)) exitwith
	{
		if ((round random 10) > 6) then {
			[localize"STR_NewFD_PinceSuccess2","green"] call A3PL_Player_Notification;
			{
				moveOut _x;
			} foreach (crew _intersect);
			_intersect setVariable ["locked",false,true];
			_intersect setVariable ["trapped",false,true];
		} else {
			[localize"STR_NewFD_PinceError2","red"] call A3PL_Player_Notification;
		};
	};
}] call Server_Setup_Compile;

["A3PL_FD_HandleFireAxe",
{
	private _whitelist = ["fifr","fisd","uscg","fims"];
	private _pJob = player getVariable["job","unemployed"];
	if(!(_pJob IN _whitelist)) exitWith {};
	private _intersect = missionNameSpace getVariable ["player_objintersect",objNull];
	private _nameIntersect = missionNameSpace getVariable ["player_nameintersect",""];
	if ((player distance (_intersect modelToWorld (_intersect selectionPosition _nameIntersect)) < 2) && (_nameIntersect IN ["door_bankvault","door_1","door_2","door_3","door_4","door_5","door_6","door_7","door_8","door_9","door_10","door_11","door_12","door_13","door_14","door_15","door_16","door_17","door_18","door_19","door_20","door_21","door_22","door_23","door_24","door_25","door_26","door_27","door_28","door_29","door_30","door_31","door_32","door_33","door_34","door_35","door_36","door_37","door_38","door_39","door_40","door_41","door_42","door_43","door_44","door_45","door_46","door_47","door_48","door_49","door_50","storagedoor1","storagedoor2","storagedoor3","sdstoragedoor3","sdstoragedoor6","door_1_button","door_2_button","door_3_button","door_4_button","door_5_button","door_6_button","door_7_button","door_8_button","door_9_button","door_10_button","door_11_button","door_12_button","door_13_button","door_14_button","door_15_button","door_16_button","door_17_button","door_18_button","door_19_button","door_20_button","door_21_button","door_22_button","door_23_button","door_24_button","door_25_button","door_26_button","door_27_button","door_28_button","door_29_button","door_30_button","door_1_button2","door_2_button2","door_3_button2","door_4_button2","door_5_button2","door_6_button2","door_7_button2","door_8_button2","door_9_button2","door_10_button2","door_11_button2","door_12_button2","door_13_button2","door_14_button2","door_15_button2","door_16_button2","door_17_button2","door_18_button2","door_19_button2","door_20_button2","door_21_button2","door_22_button2","door_23_button2","door_24_button2","door_25_button2","door_26_button2","door_27_button2","door_28_button2","door_29_button2","door_30_button2","door_8_button1","door_8_button2"])) then
	{
		if (_nameIntersect IN ["door_1_button","door_2_button","door_3_button","door_4_button","door_5_button","door_6_button","door_7_button","door_8_button","door_9_button","door_10_button","door_11_button","door_12_button","door_13_button","door_14_button","door_15_button","door_16_button","door_17_button","door_18_button","door_19_button","door_20_button","door_21_button","door_22_button","door_23_button","door_24_button","door_25_button","door_26_button","door_27_button","door_28_button","door_29_button","door_30_button","door_1_button2","door_2_button2","door_3_button2","door_4_button2","door_5_button2","door_6_button2","door_7_button2","door_8_button2","door_9_button2","door_10_button2","door_11_button2","door_12_button2","door_13_button2","door_14_button2","door_15_button2","door_16_button2","door_17_button2","door_18_button2","door_19_button2","door_20_button2","door_21_button2","door_22_button2","door_23_button2","door_24_button2","door_25_button2","door_26_button2","door_27_button2","door_28_button2","door_29_button2","door_30_button2","door_8_button1","door_8_button2"]) then {[] call A3PL_Intersect_HandleDoors;};
		private _var = format ["damage_%1",_nameintersect];
		if (((_intersect getVariable [_var,0]) + 0.2) > 1) exitwith
		{
			_intersect animate [_nameIntersect,1];
			_intersect setvariable [_var,0,false];
			if (_nameIntersect in ["storagedoor1","storagedoor2","storagedoor3"]) then {[] spawn {_intersect = cursorobject;_intersect animateSource ["storagedoor",1];sleep 60;_intersect animateSource ["storagedoor",0];};};
			if (_nameIntersect == "door_bankvault") then {[] spawn {_intersect = cursorobject;_intersect animateSource ["door_bankvault",1];sleep 20;_intersect animateSource ["door_bankvault",0];};};
			if (_nameIntersect == "sdstoragedoor3") then {[] spawn {_intersect = cursorobject;_intersect animateSource ["StorageDoor",1];sleep 60;_intersect animateSource ["StorageDoor",0];};};
			if (_nameIntersect == "sdstoragedoor6") then {[] spawn {_intersect = cursorobject;_intersect animateSource ["StorageDoor2",1];sleep 60;_intersect animateSource ["StorageDoor2",0];};};
		};
		_intersect setVariable [_var,(_intersect getVariable [_var,0]) + 0.2,false]; //local variable cause why global it, 5 hits to destroy door
	};
}] call Server_Setup_Compile;

//Connect an adapter to a source such as a fire hydrant
["A3PL_FD_ConnectAdapter",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _hydrant = param [0,objNull];
	private _pos = [];
	private _dir = -180;
	if (!((typeOf _hydrant) IN ["Land_A3PL_FireHydrant","Land_A3PL_Gas_Station"])) exitwith {[localize"STR_NewFD_Hydrant","red"] call A3PL_Player_Notification;};
	if (((count (attachedObjects _hydrant)) > 0) && (typeOf _hydrant == "Land_A3PL_FireHydrant")) exitwith {[localize"STR_NewFD_Adaptator","red"] call A3PL_Player_Notification;};
	if (player_itemClass != "FD_adapter") exitwith {[localize"STR_NewFD_AdapterNo","red"] call A3PL_Player_Notification;};
	switch (typeOf _hydrant) do {
		case ("Land_A3PL_FireHydrant"): {_pos = [-0.005,0.15,-0.076]; _dir = -180; _hydrant animateSource ["cap_hide",1];};
		case ("Land_A3PL_Gas_Station"): {_pos = [-3.72154,3.51953,-2.1]; _dir = -90;};
	};

	private _adapter = createVehicle ["A3PL_FD_HoseEnd1_Float",_hydrant modelToWorld _pos, [], 0, "CAN_COLLIDE"];
	_adapter setDir (getDir _hydrant + _dir);

	[player,_adapter,"FD_adapter"] remoteExec ["Server_Inventory_Drop", 2];
	deleteVehicle Player_Item;
	Player_Item = objNull;
	Player_ItemClass = "";
	call A3PL_FD_ConnectAnimation;
}] call Server_Setup_Compile;

["A3PL_FD_WrenchRotate",
{
	private _wrench = param [0,objNull];
	if (_wrench animationSourcePhase "WrenchRotation" < 0.5) then {
		_wrench animateSource ["WrenchRotation",1];
	} else {
		_wrench animateSource ["WrenchRotation",0];
	};
	call A3PL_FD_ConnectAnimation;
}] call Server_Setup_Compile;

["A3PL_FD_ConnectWrench",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _hydrant = param [0,objNull];
	if (!(_hydrant isKindOf "Land_A3PL_FireHydrant")) exitwith {[localize"STR_NewFD_HydrantNo","red"] call A3PL_Player_Notification;};

	private _newWrench = createVehicle ["A3PL_FD_HydrantWrench_F",_hydrant modelToWorld [0,-0.25,0.445], [], 0, "CAN_COLLIDE"];
	_newWrench setDir (getDir _hydrant);

	[player,_newWrench,"FD_hydrantwrench"] remoteExec ["Server_Inventory_Drop", 2];
	deleteVehicle Player_Item;
	Player_Item = objNull;
	Player_ItemClass = "";
	call A3PL_FD_ConnectAnimation;
}] call Server_Setup_Compile;

//Connects a hose based on holding rolled hose
["A3PL_FD_ConnectHose",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _end = param [0,objNull];
	if (!(_end isKindOf "A3PL_FD_HoseEnd1_Float")) exitwith {[localize"STR_NewFD_AdapterNo2","red"] call A3PL_Player_Notification;};
	if (!((attachedTo _end) isKindOf "Land_A3PL_FireHydrant")) exitwith {[localize"STR_NewFD_HydrantNo2","red"] call A3PL_Player_Notification;};
	if ((count (ropes _end)) > 0) exitwith {[localize"STR_NewFD_HoseNo","red"] call A3PL_Player_Notification;};
}] call Server_Setup_Compile;

//Connect a hose adapter to a source when holding adapter with hose attached
["A3PL_FD_ConnectHoseAdapter",
{
	private ["_end","_endName","_myAdapter","_TOEnd","_TOmyAdapter","_dirOffset","_attachOffset","_memOffset","_animate","_otherEnd"];
	_end = param [0,objNull];
	_endName = param [1,""];

	if(!(call A3PL_Player_AntiSpam)) exitWith {};

	_myAdapter = [] call A3PL_Lib_AttachedFirst;
	_otherEnd = [_myAdapter] call A3PL_FD_FindOtherEnd;

	if (_otherEnd isEqualTo _end) exitwith {};

	_TOEnd = typeOf _end;
	_TOmyAdapter = typeOf _myAdapter;

	if (!(_TOEnd IN ["A3PL_FD_HoseEnd1_Float","A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2","A3PL_FD_yAdapter","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Tanker_Trailer","A3PL_Fuel_Van","A3PL_Silverado_FD_Brush","A3FL_T440_Gas_Tanker","A3FL_T440_Water_Tanker"])) exitwith {["You interact with no adapter or hose","red"] call A3PL_Player_Notification;};
	if (!(_TOmyAdapter IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])) exitwith {["Vous ne possédez pas le type d'adaptateur correct (signalez-le s'il s'agit d'un bug)","red"] call A3PL_Player_Notification;};
	if ((_TOmyAdapter isEqualTo "A3PL_FD_HoseEnd1") && _TOEnd isEqualTo "A3PL_FD_HoseEnd1_Float") exitwith {["You connect a male adapter to a male adapter, use the other adapter on the other side","red"] call A3PL_Player_Notification;};
	if ((_TOmyAdapter isEqualTo "A3PL_FD_HoseEnd1") && _TOEnd isEqualTo "A3PL_FD_HoseEnd1") exitwith {["You connect a male adapter to a male adapter, use the other adapter on the other side","red"] call A3PL_Player_Notification;};
	if ((_TOmyAdapter isEqualTo "A3PL_FD_HoseEnd2") && _TOEnd isEqualTo "A3PL_FD_HoseEnd2") exitwith {["You connect a female adapter to a female adapter, use the other adapter on the other side","red"] call A3PL_Player_Notification;};
	if ((_TOmyAdapter isEqualTo "A3PL_FD_HoseEnd2") && _endName isEqualTo "fd_yadapter_in") exitwith {["You connect a female adapter to a Y adapter socket, use the other adapter on the other side of your hose","red"] call A3PL_Player_Notification;};
	if ((_TOmyAdapter isEqualTo "A3PL_FD_HoseEnd1") && _endName isEqualTo "fd_yadapter_out1") exitwith {["You connect a male adapter to a Y plug, use the other adapter on the other side of your pipe","red"] call A3PL_Player_Notification;};
	if ((_TOmyAdapter isEqualTo "A3PL_FD_HoseEnd1") && _endName isEqualTo "fd_yadapter_out2") exitwith {["You connect a male adapter to a Y plug, use the other adapter on the other side of your pipe","red"] call A3PL_Player_Notification;};
	if ((_TOmyAdapter isEqualTo "A3PL_FD_HoseEnd1") && _endName isEqualTo "fd_yadapter_out2") exitwith {["You connect a male adapter to a Y plug, use the other adapter on the other side of your pipe","red"] call A3PL_Player_Notification;};
	if ((_TOmyAdapter isEqualTo "A3PL_FD_HoseEnd2") && _endName IN ["inlet_ds"]) exitwith {["You connect a female adapter to a female input, use the other adapter on the other side of your hose","red"] call A3PL_Player_Notification;};

	switch (_endName) do {
		case ("fd_yadapter_in"): {_dirOffset = -90; _attachOffset = [-0.15,0,0]; _end setVariable ["inlet",_myAdapter,true]};
		case ("fd_yadapter_out1"): {_dirOffset = 115; _attachOffset = [0.07,-0.10,0];};
		case ("fd_yadapter_out2"): {_dirOffset = 60; _attachOffset = [0.07,0.10,0];};
		case ("inlet_r"): {_dirOffset = -180; _attachOffset = [0,0,0]; _memOffset = "inlet_r"; _animate = "Inlet_R_Cap";};
		case ("inlet_ds"): {_dirOffset = -90; _attachOffset = [0,0,0]; _memOffset = "inlet_ds"; _animate = "Inlet_DS_Cap";};
		case ("inlet_bt"): {_dirOffset = 180; _attachOffset = [0,0.03,0]; _memOffset = "inlet_bt"; _animate = "inlet_bt_cap";};
		case ("outlet_ps"): {_dirOffset = 90; _attachOffset = [0.05,0,0]; _memOffset = "outlet_ps"; _animate = "Outlet_PS_Cap";};
		case ("outlet_ds"): {_dirOffset = -90; _attachOffset = [-0.05,0,0]; _memOffset = "outlet_ds"; _animate = "Outlet_DS_Cap";};

		case ("outlet_1"): {_dirOffset = 90; _attachOffset = [0,0,0]; _memOffset = "outlet_1"; _animate = "outlet_1_cap";};
		case ("outlet_2"): {_dirOffset = 90; _attachOffset = [0,0,0]; _memOffset = "outlet_2"; _animate = "outlet_2_cap";};
		case ("outlet_3"): {_dirOffset = 90; _attachOffset = [0,0,0]; _memOffset = "outlet_3"; _animate = "outlet_3_cap";};
		case ("outlet_4"): {_dirOffset = 90; _attachOffset = [0.12,0,0]; _memOffset = "outlet_4"; _animate = "outlet_4_cap";};

		case ("outlet_bt_1"): {_dirOffset = 180; _attachOffset = [0,0,0]; _memOffset = "outlet_bt_1"; _animate = "outlet_bt_1_cap";};
		case ("outlet_bt_2"): {_dirOffset = 180; _attachOffset = [0,0,0]; _memOffset = "outlet_bt_2"; _animate = "outlet_bt_2_cap";};
		case default {_dirOffset = -180; _attachOffset = [0,-0.04,0];};
	};
	switch (_TOEnd) do {
		case ("A3PL_Fuel_Van"): {_dirOffset = 180; _attachOffset = [0,0,0]; _memOffset = "outlet_1"; _animate = "outlet_1_cap";};
	};
	_dir = getDir _end + _dirOffset;

	if (!isNil "_memOffset") then {
		_myAdapter attachTo [_end,_attachOffset,_memOffset];
	} else {
		_myAdapter attachTo [_end,_attachOffset];
	};
	if (!isNil "_animate") then { _end animate [_animate,1]; };

	_myAdapter setDir (_dir + (360 - (getDir _end)));
	call A3PL_FD_ConnectAnimation;
}] call Server_Setup_Compile;

["A3PL_FD_ConnectAnimation",
{
	player playmove "Acts_carFixingWheel";
	[] spawn {
		uiSleep 4;
		player switchmove "";
	};
}] call Server_Setup_Compile;

//This function can find a rope on an object, the first one it finds though
["A3PL_FD_FindHose",
{
	private _obj = param [0,objNull];
	private _hose = objNull;
	private _ropes = ropes _obj;
	if ((count _ropes) isEqualTo 0) then {
		_obj = ropeAttachedTo _obj;
		_ropes = ropes _obj;
		if (count _ropes != 0) then {
			_hose = _ropes select 0;
		};
	} else {
		_hose = _ropes select 0;
	};
	_hose;
}] call Server_Setup_Compile;

//find other end of rope
["A3PL_FD_FindOtherEnd",
{
	private _end = param [0,objNull];
	private _oEnd = objNull;
	private _oEnd = ropeAttachedTo _end;
	if ((isNull _oEnd) OR (_oEnd isEqualTo _end)) then {
		private _ropeAttached = ropeAttachedObjects _end;
		if (count _ropeAttached != 0) then {
			_oEnd = _ropeAttached select 0;
		};
	};
	_oEnd;
}] call Server_Setup_Compile;

//this can find an adapter based on memory point, returns string of memory point (discharge/inlet) it is attached to, or just returns the end if we need
["A3PL_FD_FindAdapterCap",
{
	private ["_end","_selectionNames","_veh","_foundCap","_found"];
	_end = param [0,objNull];
	_veh = param [1,objNull];
	_memToFindEnd = param [2,""];
	_foundCap = "";
	if (isNull _veh) exitwith {_foundcap;};

	if (_memToFindEnd != "") exitwith
	{
		private ["_selectionPosition","_foundEnd"];
		_foundEnd = objNull;
		_selectionPosition = _veh modelToWorld (_veh selectionPosition _memToFindEnd);
		{
			if ((typeOf _x IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && ((_selectionPosition distance _x) < 0.1)) exitwith
			{
				_foundEnd = _x;
			};
		} foreach (attachedObjects _veh);
		_foundEnd;
	};

	_selectionNames = ["inlet_r","inlet_ds","inlet_ps","outlet_ds","outlet_ps","outlet_1","outlet_2","outlet_3","outlet_4","inlet_bt","outlet_bt_1","outlet_bt_2"];
	{
		_selectionPosition = _veh modelToWorld (_veh selectionPosition _x);
		if ((_end distance _selectionPosition) < 0.1) exitwith {
			_found = _x;
		};
	} foreach _selectionNames;

	if (isNil "_found") exitwith {_foundCap;};
	switch (_found) do
	{
		case ("inlet_r"): {_foundCap = "inlet_r_cap"};
		case ("inlet_ds"): {_foundCap = "inlet_ds_cap"};
		case ("inlet_ps"): {_foundCap = "inlet_ps_cap"};
		case ("inlet_bt"): {_foundCap = "inlet_bt_cap"};
		case ("outlet_ds"): {_foundCap = "outlet_ds_cap"};
		case ("outlet_ps"): {_foundCap = "outlet_ps_cap"};
		case ("outlet_1"): {_foundCap = "outlet_1_cap"};
		case ("outlet_2"): {_foundCap = "outlet_2_cap"};
		case ("outlet_3"): {_foundCap = "outlet_3_cap"};
		case ("outlet_4"): {_foundCap = "outlet_4_cap"};
		case ("outlet_bt_1"): {_foundCap = "outlet_bt_1_cap"};
		case ("outlet_bt_2"): {_foundCap = "outlet_bt_2_cap"};
	};
	_foundCap;
}] call Server_Setup_Compile;

//Grab a hose (adapter)
["A3PL_FD_GrabHose",
{
	private ["_end","_hose","_otherEnd","_ropeLength","_attachedTo","_nozzleClass","_connectedMem"];
	_end = param [0,objNull];
	_nozzleClass = "A3PL_High_Pressure";

	if(!(call A3PL_Player_AntiSpam)) exitWith {};


	if (!isNull Player_Item) exitwith { _format = format["You already have an item"]; [_format, "red"] call A3PL_Player_Notification; };
	if (!(typeOf _end IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])) exitwith {["You are not interacting with the correct typeOf adapter (report this)","red"] call A3PL_Player_Notification;};
	if (isPlayer (attachedTo _end)) exitwith {["Another person holds this hose, you can not take it","red"] call A3PL_Player_Notification;};

	_otherEnd = [_end] call A3PL_FD_FindOtherEnd;
	if (!local _end) exitwith
	{
		[netID _end,netID player] remoteExec ["A3PL_Lib_ChangeLocality", 2];
		["Try again","yellow"] call A3PL_Player_Notification;
		if (!local _otherEnd && !isNull _otherend) then {[netID _otherEnd,netID player] remoteExec ["A3PL_Lib_ChangeLocality", 2];};
	};
	if (isPlayer (attachedTo _otherEnd)) exitwith {["Another person holds this hose, you can not take it","red"] call A3PL_Player_Notification;};
	_attachedTo = attachedTo _end;
	if (typeOf _attachedTo == "A3PL_FD_yAdapter") then
	{
		if (_end == _attachedTo getVariable ["inlet",objNull]) then
		{
			_attachedTo setVariable ["inlet",objNull,true];
		};
	};

    _connectedMem = [_end,(attachedTo _end)] call A3PL_FD_FindAdapterCap;
	if (_connectedMem != "") then {(attachedTo _end) animate [_connectedMem,0]};

	_end attachTo [player,[0,0,0],"RightHand"];
	Player_Item = _end;

	_hose = [_end] call A3PL_FD_FindHose;
	_ropeLength = ropeLength _hose - 0.25;
	_ropeLength = _ropeLength - 2;

	missionNamespace setVariable ["A3PL_FD_FiredCount",0];
	A3PL_FD_PlayerFiredIndex = player addEventHandler ["Fired",{[(param [0,objNull])] call A3PL_FD_WaterFiredEH;}];
	while {(attachedTo _end == player) && (!isNull _end)} do
	{
		if (!(vehicle player == player)) exitwith {detach _end};
		if ((_end distance _otherEnd) > _ropeLength) exitwith {detach _end; [format ["The hose was dropped because you can not wear it more than its length!"],"red"] call A3PL_Player_Notification;};
		if (currentWeapon player == "A3PL_High_Pressure") then
		{
			private ["_hasMag","_shouldMag","_bullets","_shouldBullets","_source"];
			_hasMag = (handgunMagazine player) select 0;
			if (isNil "_hasMag") then {_hasMag = ""};


			_source = [_end] call A3PL_FD_FindSource;

			_pressure = "low";
			_shouldMag = "A3PL_Low_Pressure_Water_Mag";
			if (typeOf _source IN ["A3PL_Pierce_Pumper","A3PL_Silverado_FD_Brush"]) then
			{
				_pressure = _source getVariable["pressure","low"];
				switch (_pressure) do
				{
					case ("high"): {_shouldMag = "A3PL_High_Pressure_Water_Mag"};
					case ("medium"): {_shouldMag = "A3PL_Medium_Pressure_Water_Mag"};
					case ("low"): {_shouldMag = "A3PL_Low_Pressure_Water_Mag"};
				};
			};


			if (_hasMag != _shouldMag) then
			{
				player addMagazine _shouldMag;
				player addWeapon _nozzleClass;
			};


			_bullets = player ammo _nozzleClass;
			if (!isNull _source) then
			{
				if (typeOf _source IN ["A3PL_Pierce_Pumper","A3PL_Silverado_FD_Brush"]) then
				{
					_shouldBullets = [_source,[_end,true] call A3PL_FD_FindSource] call A3PL_FD_SourceAmount;
				} else
				{
					_shouldBullets = [_source] call A3PL_FD_SourceAmount;
				};

				if (((_bullets - _shouldBullets > 10) OR (_bullets - _shouldBullets < -10)) OR (_shouldBullets == 0 && _bullets != 0)) then //only perform a setammo in certain cases
				{
					player setAmmo [_nozzleClass,_shouldBullets];
				};
			} else
			{
				if (_bullets != 0) then
				{
					player setAmmo [_nozzleClass,0];
				};
			};
		};
		sleep 0.1;
	};
	player removeEventHandler ["Fired",A3PL_FD_PlayerFiredIndex];
	A3PL_FD_PlayerFiredIndex = nil;
	player setAmmo [_nozzleClass,0];
	player setvariable ["pressure",nil,false];
	Player_Item = objNull;
}] call Server_Setup_Compile;

//Every 5 shots set a variable on the source
["A3PL_FD_WaterFiredEH",
{
	private ["_inlet","_source","_veh","_water"];
	_veh = param [0,objNull];

	if ((_veh isEqualTo player) && (currentWeapon player != "A3PL_High_Pressure")) exitwith {};

	_inlet = [] call A3PL_Lib_AttachedFirst;
	if ((isNull _inlet) OR (!(typeOf _inlet IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]))) exitwith {};

	_source = [_inlet] call A3PL_FD_FindSource;
	if (!(typeOf _source IN ["A3PL_Pierce_Pumper","A3PL_Silverado_FD_Brush"])) exitwith {};

	_firedCount = missionNamespace getVariable ["A3PL_FD_FiredCount",0];
	_firedCount = _firedCount + 1;
	if (_firedCount >= 10) then
	{
		_water = _source getVariable ["water",0];
		_pressure = _source getVariable["pressure","low"];
		_loose = 10;
		switch(_pressure) do {
			case("high"): {
				_loose = 20;
			};
			case("medium"): {
				_loose = 10;
			};
			case("low"): {
				_loose = 5;
			};
		};
		if (_water >= 5) then
		{
			_source setVariable ["water",_water - _loose,true];
			_source animate ["Water_Gauge1",((_water - _loose) / 500)];
		};
		_firedCount = 0;
	};
	missionNamespace setVariable ["A3PL_FD_FiredCount",_firedCount];
}] call Server_Setup_Compile;

["A3PL_FD_LadderHeavyLoop",
{
	private ["_veh","_sourceAmount","_inlet","_ammoWaterGun","_setZero","_otherEnd"];
	_veh = param [0,objNull];
	if (!((typeOf _veh) isEqualTo "A3PL_Pierce_Heavy_Ladder")) exitwith {};


	_filling = _veh getVariable["A3PL_FD_LadderHeavyLoopRunning",false];
	if (_filling) exitwith {};
	_veh setVariable["A3PL_FD_LadderHeavyLoopRunning",true,true];

	_i = 0;
	waitUntil {sleep 0.1; _i = _i + 0.1; if (_i > 3) exitwith {_veh animate ["ft_pump_switch",0,true]}; _veh animationPhase "ft_pump_switch" > 0};
	while {(_veh animationPhase "ft_pump_switch" > 0)} do
	{
		_end = [objNull,_veh,"inlet_r"] call A3PL_FD_FindAdapterCap;
		if (!isNull _end) then
		{
			_source = [_end] call A3PL_FD_FindSource;
			if (!isNull _source) then
			{
				_sourceAmount = [_source] call A3PL_FD_SourceAmount;
				if (_sourceAmount >= 5) then
				{
					if (_veh animationPhase "ft_pump_switch" > 0.9) then
					{
						_water = _veh getVariable ["water",0];
						if (_water < 1200) then
						{
							_veh setVariable ["water",_water + 10,true];
							_veh setAmmo ["A3PL_High_Pressure_Ladder", _water];
						};
						if ((typeOf _source) isEqualTo "A3PL_Pierce_Pumper") then
						{
							_source setVariable ["water",_sourceAmount - 10,true];
							_source animate ["Water_Gauge1",(_sourceAmount - 10) / 1800];
						};
					};
				};
			};
		};
		sleep 1;
	};

	_veh removeAllEventHandlers "Fired";
	_veh setVariable["A3PL_FD_LadderHeavyLoopRunning",nil,true];
}] call Server_Setup_Compile;

["A3PL_FD_LadderHeavyFired",
{
	private _veh = param [0,objNull];
	private _waterLevel = _veh getVariable["water",0];
	private _ammoWaterGun = player ammo "A3PL_High_Pressure";
	private _newWaterLevel = (_waterLevel-10);
	if(_newWaterLevel < 0) then {_newWaterLevel = 0;};
	_veh setVariable["water",_newWaterLevel,true];
	if(_newWaterLevel isEqualTo 0) exitWith {_veh setAmmo ["A3PL_High_Pressure_Ladder", 0];};
}] call Server_Setup_Compile;

["A3PL_FD_DropHose",
{
	detach (param [0,objNull]);
}] call Server_Setup_Compile;

//Roll a hose back up so it can be stored
["A3PL_FD_RollHose",
{
	private ["_end","_hose","_ropes"];
	_end = param [0,objNull];

	if(!(call A3PL_Player_AntiSpam)) exitWith {};

	if (!(typeOf _end IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2","A3PL_GasHose"])) exitwith {["Vous n'interagissez pas avec l'adaptateur","red"] call A3PL_Player_Notification;};

	//get all the ropes attached to this object
	_ropes = ropes _end;

	//get the hose object
	_hose = [_end] call A3PL_FD_FindHose;

	//delete all the objects attached to the rope
	deleteVehicle (ropeAttachedTo _end);
	{
		deleteVehicle _x;
	} foreach (ropeAttachedObjects _end);

	deleteVehicle _end;

	//add the hose to the player
	["fd_hose",1] call A3PL_Inventory_Add;
	["You have rolled up the hose, this one has been added to your inventory","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//Deploy hose on ground, creates two extenders to connect between
["A3PL_FD_DeployHose",
{
	private ["_adapter1","_adapter2","_rope"];
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	if (Player_ItemClass != "FD_Hose") exitwith {["You do not hold a hose","red"] call A3PL_Player_Notification;};
	_lengths = param [0,objNull];
	[player,objNull,Player_ItemClass] remoteExec ["Server_Inventory_Drop", 2];

	deleteVehicle Player_Item;
	Player_Item = objNull;
	Player_ItemClass = "";

	//create adapters
	_adapter2 = createVehicle ["A3PL_FD_HoseEnd1",(player modelToWorld [0,8,0.5]), [], 0, "CAN_COLLIDE"];
	_adapter1 = createVehicle ["A3PL_FD_HoseEnd2",(player modelToWorld [0,0,0.5]), [], 0, "CAN_COLLIDE"];
	_adapter2 allowDamage false;_adapter1 allowDamage false;

	//create rope between them
	_rope = ropeCreate [_adapter1, [0,0.03,0.00], _adapter2, [0,0.03,0.00], _lengths];
}] call Server_Setup_Compile;

["A3PL_FD_GasDeployHose",
{
	private ["_adapter1","_adapter2","_rope"];
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	if (Player_ItemClass != "FD_Hose") exitwith {["You do not hold a hose","red"] call A3PL_Player_Notification;};
	_lengths = param [0,objNull];
	[player,objNull,Player_ItemClass] remoteExec ["Server_Inventory_Drop", 2];

	deleteVehicle Player_Item;
	Player_Item = objNull;
	Player_ItemClass = "";

	//create adapters
	_adapter2 = createVehicle ["A3PL_GasHose",(player modelToWorld [0,5,0.5]), [], 0, "CAN_COLLIDE"];
	_adapter1 = createVehicle ["A3PL_FD_HoseEnd1",(player modelToWorld [0,0,0.5]), [], 0, "CAN_COLLIDE"];
	_adapter2 allowDamage false;_adapter1 allowDamage false;

	//create rope between them
	_rope = ropeCreate [_adapter1, [0,0.03,0.00], _adapter2, [0,0.14,0.00], 30];
}] call Server_Setup_Compile;

//This function can loop through all ropes and its attached objects until it finds the other end (we then check if it's a valid water source once found)
["A3PL_FD_FindSource",
{
	private ["_end","_latestObject","_source","_otherEnd","_adapter","_hydrants","_hydrant","_m"];
	_end = param [0,objNull];
	_getAdapter = param [1,false];
	_latestObject = _end;
	_source = objNull;

	while {!isNull _latestObject} do
	{
		_m = true;

		_otherEnd = [_latestObject] call A3PL_FD_FindOtherEnd;

		if (isNull _otherEnd) exitwith {};

		_attachedTo = [_otherEnd] call A3PL_Lib_FindAttached;

		if ((typeOf _attachedTo) == "A3PL_FD_HoseEnd1_Float") exitwith
		{

			private ["_hydrants","_adapter","_hydrant"];
			_latestObject = objNull;
			_adapter = _attachedTo;
			if (isNull _adapter) exitwith {};
			_hydrants = nearestObjects [_adapter, ["Land_A3PL_FireHydrant"], 1];
			if (count _hydrants < 1) exitwith {};
			_hydrant = _hydrants select 0;

			if (typeOf _hydrant == "Land_A3PL_FireHydrant") then
			{
				_latestObject = _hydrant;
			};
		};

		if ((typeOf _attachedTo) IN ["A3PL_Pierce_Pumper","A3PL_Tanker_Trailer","A3PL_Fuel_Van","A3PL_Silverado_FD_Brush","A3FL_T440_Gas_Tanker"]) exitwith
		{
			_latestObject = _attachedTo;
		};

		if ((typeOf _attachedTo) == "A3PL_FD_yAdapter") then
		{
			_otherEnd = (attachedTo _otherEnd) getVariable ["inlet",objNull];
			_m = false;
		};

		if ((typeOf _attachedTo) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) then
		{
			_otherEnd = _attachedTo;
		} else
		{
			if (_m) then
			{
				_otherEnd = objNull;
			};
		};
		_latestObject = _otherEnd;
	};

	if (_getAdapter) exitwith {
		_source = _otherEnd; _source;
	};
	if (typeOf _latestObject in ["Land_A3PL_FireHydrant","A3PL_Pierce_Pumper","A3PL_Tanker_Trailer","A3PL_Silverado_FD_Brush","A3FL_T440_Gas_Tanker"]) then {
		_source = _latestObject;
	} else {
		_source = objNull;
	};
	_source;
}] call Server_Setup_Compile;

//check the validity of a water source
["A3PL_FD_SourceAmount",
{
	private _source = param [0,objNull];
	private _end = param [1,objNull];
	private _amount = 0;
	if (isNull _source) exitwith {_amount;};
	switch (typeOf _source) do
	{
		case ("Land_A3PL_FireHydrant") do
		{
			private ["_wrench"];

			_wrench = (nearestObjects [_source, ["A3PL_FD_HydrantWrench_F"], 1]) select 0;
			if (!isNil "_wrench") then
			{
				if (_wrench animationSourcePhase "WrenchRotation" > 0.5) then
				{
					_amount = 1000;
				};
			};
		};
		case ("A3PL_Pierce_Pumper") do
		{
			if (_source animationPhase "ft_lever_7" < 0.5) exitwith {};
			_line = [_end,_source] call A3PL_FD_FindAdapterCap;

			if (_line == "outlet_ds_cap" && (_source animationPhase "ft_lever_10" > 0.5)) then
			{
				_amount = _source getVariable ["water",0];
			};
			if (_line == "outlet_ps_cap" && (_source animationPhase "ft_lever_1" > 0.5)) then
			{
				_amount = _source getVariable ["water",0];
			};
		};
		case ("A3PL_Silverado_FD_Brush") do
		{
			if (_source animationPhase "ft_pump_switch" < 0.5) exitwith {};
			_line = [_end,_source] call A3PL_FD_FindAdapterCap;

			if (_line == "outlet_bt_1_cap" && (_source animationPhase "bt_lever_3" > 0.5)) then
			{
				_amount = _source getVariable ["water",0];
			};
			if (_line == "outlet_bt_2_cap" && (_source animationPhase "bt_lever_2" > 0.5)) then
			{
				_amount = _source getVariable ["water",0];
			};
		};
	};
	_amount;
}] call Server_Setup_Compile;

["A3PL_FD_ChangeTruckPressure",
{
	private _engine = _this select 0;
	private _currentPressure = _engine getvariable ["pressure","high"];
	private _newPressure = "low";
	switch (_currentPressure) do {
		case ("high"): {_newPressure = "medium";};
		case ("medium"): {_newPressure = "low";};
		case ("low"): {_newPressure = "high";};
	};
	[format["The pressure is now : %1",_newPressure],"red"] call A3PL_Player_Notification;
	_engine setvariable ["pressure",_newPressure,false];
}] call Server_Setup_Compile;

["A3PL_FD_EngineLoop",
{
	private ["_veh","_end","_water","_source","_sourceAmount","_i"];
	_veh = param [0,objNull];

	_filling = _veh getVariable["A3PL_FD_EngineLoopRunning",false];
	if (_filling) exitwith {};
	_veh setVariable["A3PL_FD_EngineLoopRunning",true,true];

	_i = 0;
	waitUntil {sleep 0.1; _i = _i + 0.1; if (_i > 3) exitwith {_veh animate ["ft_lever_8",0,true]}; _veh animationPhase "ft_lever_8" > 0};
	while {(_veh animationPhase "ft_lever_8" > 0)} do
	{
		_end = [objNull,_veh,"inlet_ds"] call A3PL_FD_FindAdapterCap;
		if (!isNull _end) then
		{
			_source = [_end] call A3PL_FD_FindSource;
			if (!isNull _source) then
			{
				_sourceAmount = [_source] call A3PL_FD_SourceAmount;
				if (_sourceAmount >= 5) then
				{
					if (_veh animationPhase "ft_lever_8" > 0.9 && _veh animationPhase "ft_lever_11" > 0.9 && _veh animationPhase "FT_Pump_Switch" > 0.9) then //make sure the driver side aux intake/hydrant to tank is open, intake valve, and pump shift
					{
						_water = _veh getVariable ["water",0];
						if (_water < 1800) then
						{
							_veh setVariable ["water",_water + 10,true];
							_veh animate ["Water_Gauge1",(_water + 10) / 1800];
						};
						if (typeOf _source == "A3PL_Pierce_Pumper") then
						{
							_source setVariable ["water",_water - 10,true];
							_source animate ["Water_Gauge1",(_water - 10) / 1800];
						};
					};
				};
			};
		};
		sleep 1;
	};
	_veh setVariable["A3PL_FD_EngineLoopRunning",nil,true];
}] call Server_Setup_Compile;

["A3PL_FD_BrushLoop",
{
	private ["_veh","_end","_water","_source","_sourceAmount","_i"];
	_veh = param [0,objNull];

	_filling = _veh getVariable["A3PL_FD_BrushLoopRunning",false];
	if (_filling) exitwith {};
	_veh setVariable["A3PL_FD_BrushLoopRunning",true,true];

	_i = 0;
	waitUntil {sleep 0.1; _i = _i + 0.1; if (_i > 3) exitwith {_veh animate ["bt_lever_1",0,true]}; _veh animationPhase "bt_lever_1" > 0;};
	while {(_veh animationPhase "bt_lever_1" > 0)} do
	{
		_end = [objNull,_veh,"inlet_bt"] call A3PL_FD_FindAdapterCap;
		if (!isNull _end) then
		{
			_source = [_end] call A3PL_FD_FindSource;
			if (!isNull _source) then
			{
				_sourceAmount = [_source] call A3PL_FD_SourceAmount;
				if (_sourceAmount >= 5) then
				{
					if (_veh animationPhase "bt_lever_1" > 0.9 && _veh animationPhase "ft_pump_switch" > 0.9) then {
						_water = _veh getVariable ["water",0];
						if (_water < 800) then
						{
							_veh setVariable ["water",_water + 10,true];
							_veh animate ["Water_Gauge1",(_water + 10) / 800];
						};
						if (typeOf _source == "A3PL_Silverado_FD_Brush") then
						{
							_source setVariable ["water",_water - 10,true];
							_source animate ["Water_Gauge1",(_water - 10) / 800];
						};
					};
				};
			};
		};
		sleep 1;
	};
	_veh setVariable["A3PL_FD_BrushLoopRunning",nil,true];
}] call Server_Setup_Compile;

["A3PL_FD_MaskOff",
{
	if (goggles player != "A3PL_FD_Mask") exitwith {["You do not wear the oxygen mask","red"] call A3PL_Player_Notification;};
	removegoggles player;

	["fd_mask",1] call A3PL_Inventory_Add;
	["You have removed your oxygen mask, it is now in your inventory","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_FD_MaskOn",
{
	private ["_mask"];
	_mask = missionNameSpace getVariable ["player_item",objNull];
	if (isNull _mask OR player_itemClass != "fd_mask") exitwith {["You do not wear a mask","red"] call A3PL_Player_Notification;};

	["fd_mask",-1] call A3PL_Inventory_Add;

	removegoggles player;
	_mask attachto [player,[-0.12,-0.15,-0.73],"RightHand"];
	player playaction "gesture_maskon";
	[_mask] spawn
	{
		disableSerialization;
		private ["_mask","_overlay","_currentOverlay"];
		_mask = param [0,objNull];

		uiSleep 2.5;
		deleteVehicle _mask;
		player_item = objNull;
		player_itemClass = "";
		player addgoggles "A3PL_FD_Mask";
		["\A3PL_Common\HUD\mask\mask_normal.paa",0,0] call A3PL_HUD_SetOverlay;

		player setvariable ["Overlay_Dirt",0,false];
		_overlay = "\A3PL_Common\HUD\mask\mask_normal.paa";
		_currentOverlay = "\A3PL_Common\HUD\mask\mask_normal.paa";
		while {goggles player == "A3PL_FD_Mask"} do
		{
			uiSleep 1;
			_dirtLevel = player getVariable ["Overlay_Dirt",0];
			if (_dirtLevel < 50) then {_overlay = "\A3PL_Common\HUD\mask\mask_normal.paa";};
			if (_dirtLevel >= 50) then { _overlay = "\A3PL_Common\HUD\mask\mask_dirt1.paa"; };
			if (_dirtLevel >= 100) then { _overlay = "\A3PL_Common\HUD\mask\mask_dirt2.paa"; };
			player setvariable ["Overlay_Dirt",_dirtLevel + 1,false];
			if (_currentOverlay != _overlay) then
			{
				_currentOverlay = _overlay;
				[_overlay,0,0] call A3PL_HUD_SetOverlay;
			};
		};
		["",0,0] call A3PL_HUD_SetOverlay;
	};
}] call Server_Setup_Compile;

["A3PL_FD_SwipeMask",
{
	player playaction "gesture_headswipe";
	player setvariable ["Overlay_Dirt",0,false];
}] call Server_Setup_Compile;

["A3PL_FD_FireAlarm",
{
	private _building = param [0,objNull];
	_building setVariable["FireAlarm",true,true];

	_fifr = ["fifr"] call A3PL_Lib_FactionPlayers;
	if(count(_fifr) < 3) exitwith {};

	if (((round random 100) > 85) && (_building getVariable["FireAlarmCanBroke",true])) then {
		_building setVariable["FireAlarmBroke",true,true];
		["The fire alarm is broken!","red"] call A3PL_Player_Notification;
	} else {
		[_building,"A3PL_Common\effects\fireAlarm.ogg",60] spawn A3PL_FD_AlarmLoop;
		["You have triggered the fire alarm!","yellow"] call A3PL_Player_Notification;
		if ((count(["fifr"] call A3PL_Lib_FactionPlayers)) >= 1) exitwith {
			_marker = createMarker [format ["firealarm_%1",random 4000], position _building];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "A3PL_Markers_FIFD";
			_marker setMarkerText " Fire Alarm!";
			_marker setMarkerColor "ColorWhite";

			["!!! FIRE ALARM !!! A fire alarm has been triggered!","yellow","fifr",3] call A3PL_Lib_JobMessage;

			["A3PL_Common\effects\firecall.ogg",150,2,10] spawn A3PL_FD_FireStationAlarm;
			uiSleep 300;
			deleteMarker _marker;
		};
	};
}] call Server_Setup_Compile;

["A3PL_FD_AlarmLoop",
{
	_building = param [0,objNull];
	_alarm = param [1,""];
	_loop = param [2,30];
	_dist = param [3,200];
	_sound = param [4,5];
	_sleep = 0;
	switch(_alarm) do {
		case "A3PL_Common\effects\firealarm.ogg": {_sleep = 3.4;};
		case "A3PL_Common\effects\airalarm.ogg": {_sleep = 0;};
		case "A3PL_Common\effects\firecall.ogg": {_sleep = 4.17;};
	};
	for "_i" from 0 to _loop do {
		playSound3D [_alarm, _building, false, getPosASL _building, 5, 1, _dist];
		sleep _sleep;
	};
}] call Server_Setup_Compile;

["A3PL_FD_SetFireAlarm",
{
	_building = param [0,objNull];
	if(_building getVariable ["FireAlarmBroke",false]) exitWith {["This alarm is broken, impossible to reactivate","red"] call A3PL_Player_Notification;};
	if(_building getVariable ["FireAlarm",false]) then {
		_building setVariable["FireAlarm",false,true];
		playSound3D ["A3PL_Common\effects\firealarm.ogg", _building, false, getPosASL _building, 5, 1, 200];
	} else {
		["This alarm is already active.","red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_FD_CheckFireAlarm",
{
	_building = param [0,objNull];
	if (((round random 100) > 85) && (_building getVariable["FireAlarmCanBroke",true])) then {
		_building setVariable["FireAlarmBroke",true,true];
		["The fire alarm is broken!","red"] call A3PL_Player_Notification;
	} else {
		playSound3D ["A3PL_Common\effects\firealarm.ogg", _building, false, getPosASL _building, 2, 1, 100];
		_building setVariable["FireAlarmCanBroke",false,true];
		["This alarm is working properly.","green"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_FD_RepairFireAlarm",
{
	_building = param [0,objNull];
	if(_building getVariable ["FireAlarmBroke",false]) then {
		if (Player_ActionDoing) exitwith {["You are already doing an action","red"] call A3PL_Player_Notification;};
		["Alarm repair...",50] spawn A3PL_Lib_LoadAction;
		_success = true;
		while {uiSleep 1.5; Player_ActionDoing } do {
			player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
			if(Player_ActionInterrupted) exitWith {_success = false;};
			if(!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
			if (!(vehicle player == player)) exitwith {_success = false;};
			if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
		};
		if(!_success) exitWith {["Action cancelled","red"] call A3PL_Player_Notification;};

		_building setVariable["FireAlarmBroke",false,true];
		_building setVariable["FireAlarmCanBroke",false,true];
		["You have repaired this alarm, you can now re-activate it.","green"] call A3PL_Player_Notification;
	} else {
		["This alarm is broken","red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_FD_FireStationAlarm",
{
	private _alarm = param [0,"A3PL_Common\effects\firecall.ogg"];
	private _distance = param [1,100];
	private _loop = param [2,0];
	private _sound = param [3,5];
	private _FireHousesPos = [[6031.07,7348.9,0.120704],[4470.77,7033.89,0.0245123],[10168.3,8548.8,0.0136862],[2651.5,5481.73,0.0356779]];
	{[nearestObject [_x,"Land_A3PL_Firestation"],_alarm,_loop,_distance,_sound] spawn A3PL_FD_AlarmLoop;} foreach _FireHousesPos;
}] call Server_Setup_Compile;

// FIFD COMPUTER
['A3PL_FD_ShowHydrant',{
	private _FireHydrants = player nearEntities [["Land_A3PL_FireHydrant"],800];
	private _markersList = [];

	{
		_var = ((str(_x)splitString " :") select 1) splitString "";
		_hydrantID = format["%1%2%3",_var select 0, _var select 1, _var select 2];

		_marker = createMarkerLocal [format ["firehydrant_%1",_hydrantID], (getpos _x)];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "A3PL_Markers_FIFD";
		_marker setMarkerTextLocal format[" Hydrant #%1",_hydrantID];
		_marker setMarkerColorLocal "ColorWhite";
		_marker setMarkerAlphaLocal 0.8;

		_markersList pushBack (_marker);
	} forEach _FireHydrants;
	uiSleep 120;
	{deleteMarkerLocal _x;} forEach _markersList;
}] call Server_Setup_Compile;

['A3PL_FD_DatabaseArgu',{
	params[["_edit","",[""]],["_index",0,[0]]];
	private _allowedChars = toArray "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,";
	private _checkEdit = toArray _edit;
	private _forbiddenUsed = false;

	{
		if (!(_x in _allowedChars)) exitWith {
			_forbiddenUsed = true;
		};
	} forEach _checkEdit;
	if (_forbiddenUsed) exitWith {"SpecialCharacterError";};

	_array = _edit splitString " ";
	_return = _array select _index;
	_return
}] call Server_Setup_Compile;

['A3PL_FD_DatabaseEnterReceive',
{
	disableSerialization;
	params["_name","_command",["_return",""]];
	private _veh = vehicle player;
	private _output = switch (_command) do {
		case "lookpatient": {
			if ((count _return) > 0) then {
				format ["<t align='center'>Name: %1</t><br /><t align='center'>Sex: %2</t><br /><t align='center'>DOB: %3</t><br /><t align='center'>Passport: %4</t><br />",
				_name,
				(_return select 0),
				(_return select 1),
				(_return select 2)
				];
			} else {
				format ["Can not find %1 in the database",_name];
			};
		};
		case "lookhistory": {
			if ((count _return) > 0) then {
				{
					_output = _output + (format ["<t align='center'>%1 - %2 at %3 - EMS : %4</t><br />",_x select 5,_x select 3,_x select 2,_x select 4]);
				} foreach _return;
				_output;
			} else {
				format ["No data in the name of %1 in the database.",_name];
			};
		};
		case "addhistory": {_return;};
		default {"Error - Contact FIFR dev"};
	};
	private _newstruct = format["%1<br />%2",(_veh getVariable "FDDatabaseStruc"),_output];
	_veh setVariable ["FDDatabaseStruc",_newstruct,false];
	[_newstruct] call A3PL_FD_UpdateComputer;
}] call Server_Setup_Compile;

['A3PL_FD_UpdateComputer',
{
	params[["_input","",[""]]];
	private _display = findDisplay 211;
	private _control = _display displayCtrl 1100;
	private _controlPos = ctrlPosition _control;
	private _veh = vehicle player;
	private _array = [_input, "<br />"] call CBA_fnc_split;
	if(count _array > 50) then {
		private _remove = (count _array) - 50;
		for "_i" from 0 to _remove-1 do {
			_array deleteAt 0;
		};
	};
	private _text = [_array, "<br />"] call CBA_fnc_join;
	_veh setVariable ["FDDatabaseStruc",_text,true];
	_control ctrlSetStructuredText parseText _text;

	_newH = ctrlTextHeight _control;
	_control ctrlSetPosition [_controlPos select 0, _controlPos select 1, _controlPos select 2, _newH];
	_control ctrlCommit 0;

	private _ctrlGrp = _display displayCtrl 1001;
	_ctrlGrp ctrlSetAutoScrollSpeed 0.000001;
	_ctrlGrp ctrlSetAutoScrollDelay 0.000001;
}] call Server_Setup_Compile;

['A3PL_FD_DatabaseEnter',
{
	private ["_display","_control","_edit","_edit0","_newstruct"];
	disableSerialization;
	private _display = findDisplay 211;
	private _control = _display displayCtrl 1401;
	private _edit = ctrlText _control;
	private _veh = vehicle player;
	private _newstruct = format["%1<br/>%2",(_veh getVariable "FDDatabaseStruc"),"> "+_edit];
	_veh setVariable ["FDDatabaseStruc",_newstruct,false];

	[_newstruct] call A3PL_FD_UpdateComputer;

	private _control = _display displayCtrl 1401;
	_control ctrlSetText "";
	private _edit0 = [_edit,0] call A3PL_FD_DatabaseArgu;
	if (!(_veh getVariable ["FDDatabaseLogin",false]) && {!(_edit0 isEqualTo "login")}) exitwith {
		_newstruct = format["%1<br />%2",(_veh getVariable "FDDatabaseStruc"),"Error: You do not have the permission to use that command"];
		_veh setVariable ["FDDatabaseStruc",_newstruct,false];
		[_newstruct] call A3PL_FD_UpdateComputer;
	};
	private _output = switch (_edit0) do {
		case "help": {
			"
			<t align='center'>help - Display commands list</t><br />
			<t align='center'>clear - Clear the screen</t><br />
			<t align='center'>login [password] - Login to use the commands</t><br />
			<t align='center'>lookpatient [firstname] [lastname] - View patient information</t><br />
			<t align='center'>addhistory [firstname] [lastname] [position] [infos] - Add a line to a patient's medical record</t><br />
			<t align='center'>lookhistory [firstname] [lastname] - View a patient's medical record</t><br />
			<t align='center'>sendcall - Triggering fire station alarms</t><br />
			<t align='center'>showhydrant - Display nearest fire hydrant on map</t><br />
			<t align='center'>clinic - Open / Close clinics</t><br />
			<t align='center'>wind - Display current wind direction</t><br />
			<t align='center'>callvfd [message] - Activate VFD Beepers</t><br />
			<t align='center'>clearfires - Clear Current Fires (High Command Only)</t><br />
			<t align='center'>pausefires - Pause Current Fires (High Command Only)</t><br />
			";
		};
		case "clear": {"<t align='center'>FISHERS ISLAND FIRE &amp; RESCUE</t><br /><t align='center'>Type 'help' to see all the available commands</t><br />";};
		case "login": {
			private _pass = [_edit,1] call A3PL_FD_DatabaseArgu;
			if (_pass isEqualTo "fifrftw") then {
				_veh setVariable ["FDDatabaseLogin",true,false];
				"You are connected";
			} else {
				"Error: Wrong password";
			};
		};
		case "lookpatient": {
			private _name = ([_edit,1] call A3PL_FD_DatabaseArgu) + " " + ([_edit,2] call A3PL_FD_DatabaseArgu);
			[player,_name,_edit0] remoteExec ["Server_FD_Database", 2];
			format ["Finding a patient in FIFR Database...",_name];
		};
		case "sendcall": {
			["A3PL_Common\effects\firecall.ogg",150,2,10] spawn A3PL_FD_FireStationAlarm;
		};
		case "wind": {
			format ["Wind direction: %1",call A3PL_Lib_GetHeading];
		};
		case "showhydrant": {
			[] spawn A3PL_FD_ShowHydrant;
			format ["Display of the nearest fire hydrants on your map..."];
		};
		case "clinic": {
			[] remoteExec ["Server_FD_SwitchClinic",2];
			if(A3PL_FD_Clinic) then {
				"Clincics are now closed...";
			} else {
				"Clincics are now open...";
			};			
		};
		case "callvfd": {
			[_edit] call A3PL_FD_CallVFD;
			format ["VFD Beepers activated..."];
		};
		case "lookhistory": {
			private _name = ([_edit,1] call A3PL_FD_DatabaseArgu) + " " + ([_edit,2] call A3PL_FD_DatabaseArgu);
			[player,_name,_edit0] remoteExec ["Server_FD_Database", 2];
			format ["Search of the medical file in progress...",_name];
		};
		case "addhistory":
		{
			private _name = ([_edit,1] call A3PL_FD_DatabaseArgu) + " " + ([_edit,2] call A3PL_FD_DatabaseArgu);
			private _place = ([_edit,3] call A3PL_FD_DatabaseArgu);
			private _array = _edit splitString " ";
			for "_i" from 1 to 4 do {_array deleteAt 0;};
			private _info = [_array," "] call CBA_fnc_join;
			private _issuedBy = player getVariable ["name",name player];
			[player,[_name,_place,_info,_issuedBy],_edit0] remoteExec ["Server_FD_Database", 2];
			format ["Information added to the patient's file...",_name];
		};
		case "clearfires":
		{
			private _isCommand = ["fifr"] call A3PL_Government_isFactionLeader;
			if (_isCommand) then {
				call A3PL_Admin_RemoveFire;
				"Fires have been cleared";
			} else {
				"Error: You are not high command";
			};
		};
		case "pausefires":
		{
			private _isCommand = ["fifr"] call A3PL_Government_isFactionLeader;
			[] remoteExec ["Server_Fire_PauseCheck",2];
			if (_isCommand) then {
				[] remoteExec ["Server_Fire_PauseFire", 2];
				if (!pVar_FiresFrozen) then {
					"Fires are no longer paused";
				} else {
					"Fires are now paused";
				};
			} else {
				"Error: You are not high command";
			};
		};
		case "SpecialCharacterError": {
			"You cannot enter special characters into the MDT!";
		};
		default {"Error: Unknown command"};
	};
	_control = _display displayCtrl 1100;
	private _newstruct = if (_edit0 isEqualTo "clear") then {
		_output;
	} else {
		format["%1<br/>%2",(_veh getVariable "FDDatabaseStruc"),_output];
	};
	_veh setVariable ["FDDatabaseStruc",_newstruct,false];
	[_newstruct] call A3PL_FD_UpdateComputer;
}] call Server_Setup_Compile;

["A3PL_FD_DatabaseOpen",
{
	private _defText = "<t align='center'>FISHERS ISLAND FIRE &amp; RESCUE</t><br /><t align='center'>Type 'help' to see all the available commands</t><br />> Please login";
	private _veh = vehicle player;
	private _text = _veh getVariable ["FDDatabaseStruc",nil];
	if(isNil "_text") then {_veh setVariable ["FDDatabaseStruc",_defText,true];_text=_defText;};
	disableSerialization;
	createDialog "Dialog_PoliceDatabase";
	private _display = findDisplay 211;
	_display displayAddEventHandler ["KeyDown", "if ((_this select 1) isEqualTo 28) then {call A3PL_FD_DatabaseEnter;}"];
	[_text] call A3PL_FD_UpdateComputer;
}] call Server_Setup_Compile;

["A3PL_FD_ThrowHose", {
	[] spawn {
		private _obj = Player_Item;
		private _itemClass = Player_ItemClass;
		if (isNull _obj) exitwith {["It does not look like you have something to throw","red"] call A3PL_Player_Notification;};
		if (!isNil "Player_isEating") exitwith {["You eat something and can not perform this action","red"] call A3PL_Player_Notification;};
		player playaction "Gesture_throw";
		uiSleep 0.5;

		detach _obj;
		private _playerVelocity = velocity player;
		private _playerDir = direction player;

		_obj setVelocity [((_playerVelocity select 0) + (sin _playerDir * 7)), ((_playerVelocity select 1) + (cos _playerDir * 7)), ((_playerVelocity select 2) + 7)];
		[player,_obj,_itemClass] remoteExec ["Server_Inventory_Drop", 2];

		Player_Item = objNull;
		Player_ItemClass = '';
	};
}] call Server_Setup_Compile;

["A3PL_FD_CallVFD", {
	private _message = _this select 0;
	{
		if(["vfd",_x] call A3PL_DMV_Check) then {
			[format["VFD PAGER : %1",_message],"red"] remoteExec ["A3PL_Player_Notification",_x];
			[format["VFD PAGER : %1",_message],"red"] remoteExec ["A3PL_Player_Notification",_x];
			[format["VFD PAGER : %1",_message],"red"] remoteExec ["A3PL_Player_Notification",_x];
			playSound3D ["A3PL_Common\GUI\phone\sounds\emergency_sound.ogg", _x, false, getPosASL _x, 5, 1, 5];
		};
	} forEach allPlayers;
}] call Server_Setup_Compile;
