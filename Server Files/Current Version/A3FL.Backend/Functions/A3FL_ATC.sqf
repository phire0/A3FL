/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_ATC_LeaveJob",
{
	player setPos (npc_faastart modelToWorld [0,2,0]);
	removeBackpack player;
}] call Server_Setup_Compile;

["A3PL_ATC_Tower",
{
	private _faction = player getVariable["faction","citizen"];
	if ((["atc",player] call A3PL_DMV_Check) || (_faction isEqualTo "uscg")) then {
		player setposATL [2527.21,5090.98,0];
	} else {
		[localize"STR_ATC_ONLYVOLUNTEER","red"] call A3PL_Player_Notification;
	};	
}] call Server_Setup_Compile;

["A3PL_ATC_Transponder",
{
	private ["_squawk","_newSquawk","_pic"];
	createDialog "Dialog_Transponder";	
	A3PL_ATC_TransponderSel = 0;
	
	//set squawk to whatever the current one is
	_squawk = format ["%1",(vehicle player) getVariable ["squawk",1200]];
	_newSquawk = toArray _squawk;
	{
		_idc = 1202 + _forEachIndex; 
		ctrlSetText [_idc, format ["\A3PL_Common\GUI\transponder\%1.paa",((toString _newSquawk) select [_forEachIndex,1])]];
	} foreach _newSquawk;	
	
	//set the transponder mode
	_mode = (vehicle player) getVariable ["transponder","STBY"];
	 switch (_mode) do
	 {
		case ("C"): {_pic = "ALT.paa"}; 
		case ("STBY"): {_pic = "STBY.paa"};
		case ("IDENT"): {_pic = "IDENT.paa"};
	 };
	 ctrlSetText [1201,format ["\A3PL_Common\GUI\transponder\%1",_pic]];
}] call Server_Setup_Compile;

["A3PL_ATC_TransponderSquawk",
{
	private ["_idc"];
	_selectedNumber = param [0,0];
	_veh = vehicle player;
	
	//set the new squawk
	_squawk = format ["%1",_veh getVariable ["squawk",1200]];
	_newSquawk = toArray _squawk;
	_newSquawk set [A3PL_ATC_TransponderSel,(48+_selectedNumber)];
	_veh setVariable ["squawk",(toString _newSquawk),true];
	
	//Set the new squawk code on dialog
	{
		_idc = 1202 + _forEachIndex; 
		ctrlSetText [_idc, format ["\A3PL_Common\GUI\transponder\%1.paa",((toString _newSquawk) select [_forEachIndex,1])]];
	} foreach _newSquawk;
	
	//increase selected number
	A3PL_ATC_TransponderSel = A3PL_ATC_TransponderSel + 1;
	if (A3PL_ATC_TransponderSel > 3) then
	{
		A3PL_ATC_TransponderSel = 0;
	};
}] call Server_Setup_Compile;

["A3PL_ATC_TransponderMode",
{
	 private ["_mode","_pic"];
	 _mode = param [0,"STBY"];
	 _veh = vehicle player;
	 
	 _veh setVariable ["transponder",_mode,true];
	 switch (_mode) do
	 {
		case ("C"): {_pic = "ALT.paa"}; 
		case ("STBY"): {_pic = "STBY.paa"};
		case ("IDENT"): {_pic = "IDENT.paa"};
	 };
	 ctrlSetText [1201,format ["\A3PL_Common\GUI\transponder\%1",_pic]];
}] call Server_Setup_Compile;

//Get flight level of an aircraft
["A3PL_ATC_GetFL",
{
	private ["_veh","_feet","_fl"];
	_veh = param [0,objNull];
	
	//convert to feet first
	_feet = ((getposASL _veh select 2) * 3.2808399);
	
	//Convert feet to FL
	_fl = format ["%1",floor (_feet / 100)];
	if (count _fl == 1) then {
		_fl = format ["00%1",_fl];
	} else {	
		if (count _fl == 2) then {
			_fl = format ["0%1",_fl];
		};
	};
	_fl;
}] call Server_Setup_Compile;

//COMPILE BLOCK FUNCTIONS WARNING, COPY OF THIS NEEDS TO BE IN fn_PreInit.sqf
["A3PL_ATC_GetInAircraft",
{
	private ["_veh","_atcText","_status","_active"];		
	_veh = param [0,objNull];
	A3PL_ATC_IsListeningATC = false;
	while {player IN _veh} do
	{
		_active = call TFAR_fnc_activeLRRadio;
		if (!isNil "_active" && (_active select 1 IN ["driver_radio_settings","gunner_radio_settings"])) then
		{
			//Sync gunner seat to driver seat LR frequency
			if (player != driver _veh) then
			{
				if (([_veh,"gunner_radio_settings"] call TFAR_fnc_getLrFrequency) != ([_veh,"driver_radio_settings"] call TFAR_fnc_getLrFrequency)) then
				{
					[[_veh, "driver_radio_settings"],[_veh, "gunner_radio_settings"]] call TFAR_fnc_CopySettings;
				};
			};
			
			_frequency = (parseNumber ((call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrFrequency)) == 127; //check if we are on ATIS
						
			//if we are on ATIS then do the following
			if (_frequency) then
			{						
				//Get ATC text
				if (isNil "A3PL_ATC_ATISTEXT") then
				{
					_atcText = "Lubbock International Airport. Currently no ATIS information is available. No takeoff clearances until tower is occupied";
				} else
				{
					_atcText = A3PL_ATC_ATISTEXT;
				};				
				[format ["ATC ATIS: %1",_atcText],"green"] call A3PL_Player_Notification;
			};
		};
		uiSleep 5;
	};
}] call Server_Setup_Compile;

["A3PL_ATC_GetType",
{
	private ["_veh","_type"];
	_veh = param [0,objNull];
	_type = "Unknown";
	
	switch (true) do {
		case (_veh isKindOf "A3PL_Goose_Base"): {_type = "G21";};
		case (_veh isKindOf "A3PL_Jayhawk"): {_type = "H60";};
		case (_veh isKindOf "A3FL_AS_365"): {_type = "MH65";};
	};
	_type;
}] call Server_Setup_Compile;

["A3PL_ATC_ATISPreview",
{
	private ["_atcText"];
	_atcText = ctrlText 1407;
	//"Arma2Net.Unmanaged" callExtension format ["ATIS ['ATIS_Start',%1]",_atcText];
	[format ["ATC ATIS: %1",_atcText],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_ATC_SetAircraftInfo",
{
	disableSerialization;
	private ["_veh","_control","_display"];
	_veh = param [0,""];
	
	if (typeName _veh == "STRING") then
	{
		{
			_check = format ["%1",_x];
			
			if (_check == _veh) exitwith
			{
				_veh = _x;
			};
		} foreach vehicles;
	};
	
	if (typeName _veh == "STRING") exitwith {["ATC System: Error occured trying to retrieve object name", "red"] call A3PL_Player_Notification;};
	
	A3PL_ATC_VAR_Selected = _veh;
	
	_transponder = _veh getVariable ["transponder","STBY"];
	
	switch (_transponder) do
	{
		case "STBY": 
		{
			ctrlSetText [1400, [_veh] call A3PL_ATC_GetType]; //type
			ctrlSetText [1401, _veh getVariable ["callsign","UNDEF"]]; //callsign
			ctrlSetText [1402, format ["%1",(_veh getVariable ["squawk",1200])]]; //squawk
			ctrlSetText [1403, _transponder]; //transponder
			ctrlSetText [1404, ""]; //heading
			ctrlSetText [1405, ""]; //ias		
			ctrlSetText [1406, ""]; //alt		
		};
		case default
		{
			ctrlSetText [1400, [_veh] call A3PL_ATC_GetType]; //type
			ctrlSetText [1401, _veh getVariable ["callsign","UNDEF"]]; //callsign
			ctrlSetText [1402, format ["%1",(_veh getVariable ["squawk",1200])]]; //squawk
			ctrlSetText [1403, _transponder]; //transponder
			ctrlSetText [1404, format ["%1 True Heading",floor (getDir _veh)]]; //heading
			ctrlSetText [1405, format ["%1 Knots",floor (speed _veh * 0.539956803)]]; //ias		
			ctrlSetText [1406, format ["Flight Level %1",[_veh] call A3PL_ATC_GetFL]]; //alt	
		};
	};
	
	//Set the Clearance
	_display = findDisplay 91;
	_control = _display displayCtrl 2500;
	
	if (_veh getVariable ["clearance",false]) then
	{
		_control ctrlSetChecked true;
	} else
	{
		_control ctrlSetChecked false;
	};
	
}] call Server_Setup_Compile;

["A3PL_ATC_RadarRange",
{
	private ["_increase"];
	_increase = param [0,true];
	
	if (_increase) then
	{
		A3PL_ATC_VAR_Radius = A3PL_ATC_VAR_Radius + 100;
	} else
	{
		A3PL_ATC_VAR_Radius = A3PL_ATC_VAR_Radius - 100;
	};
	
	if (A3PL_ATC_VAR_Radius < 100) then
	{
		A3PL_ATC_VAR_Radius = 0;
	};
	
	if (A3PL_ATC_VAR_Radius > 20000) then
	{
		A3PL_ATC_VAR_Radius = 20000;
	};	
	
	ctrlSetText [1011, format ["RADAR RADIUS: %1m / %2nm",A3PL_ATC_VAR_Radius,[(A3PL_ATC_VAR_Radius*0.000539957),1] call BIS_fnc_cutDecimals]];
}] call Server_Setup_Compile;

["A3PL_ATC_Transfer",
{
	disableSerialization;
	if (isNull A3PL_ATC_VAR_Selected) exitwith {["ATC System: It doesn't look like you have an aircraft selected to apply CS and Clearance", "red"] call A3PL_Player_Notification;};
	
	_display = findDisplay 91;
	_control = _display displayCtrl 2500;	
	
	A3PL_ATC_VAR_Selected setVariable ["callsign",ctrlText 1401,true];
	A3PL_ATC_VAR_Selected setVariable ["clearance",(ctrlChecked _control),true];
}] call Server_Setup_Compile;

["A3PL_ATC_RadarStart",
{
	private ["_display","_control","_planes"];
	
	disableSerialization;
	
	createDialog "Dialog_ATC";
	buttonSetAction [1601, "[true] call A3PL_ATC_RadarRange;"];
	buttonSetAction [1600, "[false] call A3PL_ATC_RadarRange;"];
	buttonSetAction [1603, "call A3PL_ATC_ATISPreview;"];
	buttonSetAction [1604, "A3PL_ATC_ATISTEXT = ctrlText 1407; publicVariable 'A3PL_ATC_ATISTEXT';"];
	buttonSetAction [1602, "call A3PL_ATC_Transfer"];
	
	if (!isNil "A3PL_ATC_ATISTEXT") then
	{
		ctrlSetText [1407,A3PL_ATC_ATISTEXT];
	} else
	{
		ctrlSetText [1407,"Fishers Island Elisabeth Field. Currently no ATIS information is available. No takeoff clearances until tower is occupied"];
	};
	
	_display = findDisplay 91;
	_control = _display displayCtrl 1100;
	
	//airport description
	_control ctrlSetStructuredText parseText 
	format
	[
		"<t color='#FFFFFF' shadow='2'>Elizabeth Field Airport Info:<br/>
		CFI LID: 0B8<br/>
		RWY 12/30 LGT: 2328ft<br/>
		RWY 7/25 LGT: 1792ft<br/>
		<br/>
		RWY 12: TRUE HDG 103<br/>
		RWY 30: TRUE HDG 283<br/>
		RWY 25: TRUE HDG 243<br/>
		RWY 7: TRUE HDG 63<br/>
		<br/>
		Elizabeth Field FREQ:<br/>
		ATIS: 127<br/>
		GRD/CLEAR: 121.9<br/>
		TWR: 118.2<br/>
		APP/DEP: 125.75<br/>
		CTAF: 122.8<br/>
		<br/>
		Elizabeth Field Weather Report:<br/>
		Wind Azimuth: %1<br/>
		Wind Strength: %10<br/>
		Gust Strength (0-1): %2<br/>
		Lightnings(0-1): %9<br/>
		Cloud Cover (0-1): %3<br/>
		Cloud Cover Forecast (0-1): %4<br/>
		Rain Density (0-1): %5<br/>
		Fog Density (0-1): %6<br/>
		Forecasted Fog (0-1): %7<br/>
		EST Weather Change: ~%8 min<br/>
		QNH: 1006</t>
		<img size='6' image='\A3PL_Common\GUI\ATC\airport_map.paa' />
		",
		windDir,
		gusts,
		overcast,
		overcastForecast,
		rain,
		fog,
		fogForecast,
		(nextWeatherChange / 60),
		lightnings,
		windStr
	];
	
	//Define outer radius
	A3PL_ATC_VAR_Radius = 200;
	//define selected aircraft
	A3PL_ATC_VAR_Selected = objNull;
	//Defines controls that we will manage later on
	A3PL_ATC_Var_Controls = [];
	
	
	_tPassed = 1.1; //variable we will use to get a list of aircraft at time intervals, nearestobjects can be intensive at higher radar radius
	
	//define the blips we will remove
	_prevPlanes = nearestObjects [player,["Plane","Helicopter"],A3PL_ATC_Var_Radius];
	{
		_altitude = ((getPosASL (_x)) select 2);
		_mode = _x getVariable ["transponder","STBY"];
		if((_altitude < 50) && !(_mode isEqualTo "IDENT")) then {
			_prevPlanes deleteAt _forEachIndex;
		};
	} foreach _prevPlanes;
	while {!isNull _display} do
	{
		//get aircraft list from player origin based on set Radius
		if (_tPassed > 1) then
		{
			_planes = nearestObjects [player,["Plane","Helicopter"],A3PL_ATC_Var_Radius];
			{
				_altitude = ((getPosASL (_x)) select 2);
				_mode = _x getVariable ["transponder","STBY"];
				if((_altitude < 50) && !(_mode isEqualTo "IDENT")) then {
					_planes deleteAt _forEachIndex;
				};
			} foreach _planes;
			_tPassed = 0;
		};
		
		//Move our radar thingy
		_control = _display displayCtrl 1201;
		_aControl = ((ctrlAngle _control) select 0) + 2;
		if (_aControl >= 360) then {_aControl = 0};
		_control ctrlSetAngle [_aControl,0.5,0.5];		
		
		{
			if ((!(_x IN _planes)) OR ((_x getVariable ["transponder","STBY"]) == "OFF")) then
			{
				{
					ctrlDelete _x;
				} foreach (_x getVariable ["controls",[]]);				
			};
		} foreach _prevPlanes;
		
		_prevPlanes = _planes;
			
		{			
		
			_plane = _x;
			//check if our radar thingy is near a plane and the transponder isn't off
			_aCheck = ((_plane getDir player) - (getDir player)) + 180;
			if (_aCheck >= 360) then {_aCheck = _acheck - 360; };
			if (_aCheck < 0) then {_aCheck = _acheck + 360;};
			if ((_aControl > (_aCheck - 1)) && (_aControl < (_aCheck + 1)) && ((_plane getVariable ["transponder","STBY"]) != "OFF")) then
			{
				player say "Beep_Target";
			
				//delete our prev controls for this plane	
				{
					private ["_x"];
					if (_x IN (_plane getVariable ["controls",[]])) then
					{
						ctrlDelete _x;
					};
				} foreach A3PL_ATC_Var_Controls;	
				
				//refresh stats if select
				if (_plane == A3PL_ATC_VAR_Selected) then
				{
					[_plane] call A3PL_ATC_SetAircraftInfo;
				};

				//reset _v
				_v = [];
				
				/*
					X = xcircle + (r * cosine(angle))
					Y = ycircle + (r * sine(angle))
				*/
				
				_dirBlip = ((_plane getDir player) - (getDir player)) + 90;		
				
				_control = _display ctrlCreate ["RscPicture", -1];
				_v pushback _control;
				
				A3PL_ATC_Var_Controls pushback _control;
				
				if (_plane isKindOf "helicopter") then {
					_control ctrlSetText "\A3PL_Common\GUI\ATC\atc_triangle.paa";
				} else {
					_control ctrlSetText "\A3PL_Common\GUI\ATC\atc_square.paa";
				};
				
				//No fucking clue what I did but it works
				_xC = ((((player distance2D _plane) * cos(_dirBlip))) / (A3PL_ATC_VAR_Radius * 2.8)) / 2;
				_yC = ((((player distance2D _plane) * sin(_dirBlip))) / (A3PL_ATC_VAR_Radius * 2.8));
				
				
				_control ctrlSetPosition [((_xC + 0.495365) * safezoneW + safezoneX),((_yC + 0.501741) * safezoneH + safezoneY),(0.01 * safezoneW),(0.0177778 * safezoneH)];
				_control ctrlCommit 0;
				
				//direction
				_control = _display ctrlCreate ["RscPicture", -1];
				_v pushback _control;				
				A3PL_ATC_Var_Controls pushback _control;
				_control ctrlSetText "\A3PL_Common\GUI\ATC\atc_direction.paa";
				_control ctrlSetPosition [((_xC + 0.470104) * safezoneW + safezoneX),((_yC + 0.460104) * safezoneH + safezoneY),(0.06 * safezoneW),(0.106667 * safezoneH)];
				_control ctrlCommit 0;	
				_control ctrlSetAngle [(getDir _plane - getDir player),0.5,0.5];
				
				//Lets take care of what happends when you press the aircraft *blip*
				_control = _display ctrlCreate ["RscButton", -1];
				_v pushback _control;				
				A3PL_ATC_Var_Controls pushback _control;				
				_control ctrlSetPosition [((_xC + 0.495365) * safezoneW + safezoneX),((_yC + 0.501741) * safezoneH + safezoneY),(0.01 * safezoneW),(0.0177778 * safezoneH)];
				_control ctrlSetFade 1;				
				_control ctrlCommit 0;
				_control buttonSetAction format ["['%1'] call A3PL_ATC_SetAircraftInfo;",_plane];	
				
				//now lets take care of the structured info :)
				_control = _display ctrlCreate ["RscStructuredText", -1];
				_v pushback _control;		
				A3PL_ATC_Var_Controls pushback _control;
				_control ctrlSetPosition [((_xC + 0.410104) * safezoneW + safezoneX),((_yC + 0.520104) * safezoneH + safezoneY),(0.2 * safezoneW),(0.1 * safezoneH)];
				
				_mode = _plane getVariable ["transponder","STBY"];
				_atcStruc = "";
				
				switch (_mode) do
				{
					case "STBY": 
					{
						_atcStruc = 
						format 
						[
							"<t size='0.6' color='#FFFFFF' align='center'>TYPE: %1<br/>CS: %2<br/>SQ: %3</t>",
							[_plane] call A3PL_ATC_GetType,
							_plane getVariable ["callsign","UNDEF"],
							_plane getVariable ["Squawk",1200]
						];						
					};
					case "IDENT": 
					{
						_atcStruc = 
						format 
						[
							"<t size='0.6' color='#FF0000' align='center'>TYPE: %1<br/>CS: %2<br/>SQ: %3<br/>HDG: %4<br/>FL: %5<br/>IAS: %6</t>",
							[_plane] call A3PL_ATC_GetType,
							_plane getVariable ["callsign","UNDEF"],
							_plane getVariable ["Squawk",1200],
							floor (getDir _plane),
							[_plane] call A3PL_ATC_GetFL,
							floor (speed _plane * 0.539956803)
						];						
					};
					case "C": 
					{
						_atcStruc = 
						format 
						[
							"<t size='0.6' color='#CECEBD' align='center'>TYPE: %1<br/>CS: %2<br/>SQ: %3<br/>HDG: %4<br/>FL: %5<br/>IAS: %6</t>",
							[_plane] call A3PL_ATC_GetType,
							_plane getVariable ["callsign","UNDEF"],
							_plane getVariable ["Squawk",1200],
							floor (getDir _plane),
							[_plane] call A3PL_ATC_GetFL,
							floor (speed _plane * 0.539956803)
						];						
					};					
				};
				_control ctrlSetStructuredText parseText _atcStruc;
				_control ctrlCommit 0;
				
				_plane setVariable ["controls",_v,false];
			};
		} foreach _planes;
		_tPassed = _tPassed + 0.01;
		uiSleep 0.01;
	};
}] call Server_Setup_Compile;