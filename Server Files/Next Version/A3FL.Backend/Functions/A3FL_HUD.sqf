/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_HUD_Init",
{
	disableSerialization;
	private ["_display","_control","_name"];
	("A3PL_Hud" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD","PLAIN"];

	("A3PL_Hud_IDCard" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD_IDCard","PLAIN"];

	("A3PL_Hud_FactionCard" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD_FactionCard","PLAIN"];

	("A3PL_Hud_Overlay" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD_Overlay","PLAIN"];

	("A3PL_Hud_LoadAction" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD_LoadAction","PLAIN"];

	_display = uiNamespace getVariable "Dialog_HUD_LoadAction";
	(_display displayCtrl 394) ctrlSetFade 1;
	(_display displayCtrl 350) ctrlSetFade 1;
	(_display displayCtrl 351) ctrlSetFade 1;
	(_display displayCtrl 352) ctrlSetFade 1;
	(_display displayCtrl 394) ctrlCommit 0;
	(_display displayCtrl 350) ctrlCommit 0;
	(_display displayCtrl 351) ctrlCommit 0;
	(_display displayCtrl 352) ctrlCommit 0;

	[] call A3PL_Twitter_Init;

	_display = uiNamespace getVariable "A3PL_HUD_IDCard";
	for "_i" from 999 to 1006 do
	{
		(_display displayCtrl _i) ctrlSetFade 1;
		(_display displayCtrl _i) ctrlCommit 0;
	};
	_display = uiNamespace getVariable "A3PL_HUD_FactionCard";
	for "_i" from 999 to 1004 do
	{
		(_display displayCtrl _i) ctrlSetFade 1;
		(_display displayCtrl _i) ctrlCommit 0;
	};


	_display = uiNamespace getVariable "A3PL_HUDDisplay";
	_control = _display displayCtrl 1100;
	_name = player getVariable ["name",name player];
	_control ctrlSetStructuredText parseText (format ["<t align='center'>%1</t>",_name]);

	_ctrl = _display displayCtrl 9520;
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit 0;

	_ctrl = _display displayCtrl 9521;
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit 0;

	A3PL_HUD_Text = "";
}] call Server_Setup_Compile;

["A3PL_Hud_IDCard",
{
	disableSerialization;
	private ["_target","_display","_fname","_lname","_maxIDC","_rank"];
	_target = param [0,objNull];
	_faction = param [1,"citizen"];
	_fake = param [2,false];

	_maxIDC = 1006;
	_fullName = (_target getVariable ["name","Error"]);
	if(_fake) then {_fullName = _target getVariable["fakeName",""];};
	_lname = (_fullName splitString " ") select 1;
	_fname = (_fullName splitString " ") select 0;


	switch (_faction) do {
		case ("citizen"): {
			_display = uiNamespace getVariable "A3PL_HUD_IDCard";
			_maxIDC = 1006;
			_licenses = "";
			if(count(_target getVariable ["licenses",[]]) > 0) then {
				{
					_licenses = format ["%2<br/>%1",_licenses, [_x,"name"] call A3PL_Config_GetLicense];
				} foreach (_target getVariable ["licenses",[]]);
			} else {
				_licenses = "No Licenses";
			};
			(_display displayCtrl 1000) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", (str(_target getVariable ["db_id","0"]))];
			(_display displayCtrl 1001) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _fname];
			(_display displayCtrl 1002) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _lname];
			(_display displayCtrl 1003) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", (_target getVariable ["dob","unknown"])];
			(_display displayCtrl 1004) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", (_target getVariable ["gender","unknown"])];
			(_display displayCtrl 1005) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", (_target getVariable ["date","unknown"])];
			(_display displayCtrl 1006) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='left' size='1' color='#000'>%1</t>", _licenses];
		};
		case ("fisd"): {
			_display = uiNamespace getVariable "A3PL_HUD_FactionCard";
			_maxIDC = 1004;
			_card = "\A3PL_Common\GUI\Cards\Card_FISD.paa";
			_rank = ["fisd","rank", getPlayerUID _target] call A3PL_Config_GetFactionRankData;
			(_display displayCtrl 999) ctrlSetText _card;
			(_display displayCtrl 1000) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", (str(_target getVariable ["db_id","Error"]))];
			(_display displayCtrl 1001) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _fname];
			(_display displayCtrl 1002) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _lname];
			(_display displayCtrl 1003) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", "Sheriff Department"];
			(_display displayCtrl 1004) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _rank];
		};
		case ("uscg"): {
			_display = uiNamespace getVariable "A3PL_HUD_FactionCard";
			_maxIDC = 1004;
			_card = "\A3PL_Common\GUI\Cards\Card_USCG.paa";
			_rank = ["uscg","rank", getPlayerUID _target] call A3PL_Config_GetFactionRankData;
			(_display displayCtrl 999) ctrlSetText _card;
			(_display displayCtrl 1000) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", (str(_target getVariable ["db_id","Error"]))];
			(_display displayCtrl 1001) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _fname];
			(_display displayCtrl 1002) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _lname];
			(_display displayCtrl 1003) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", "Coast Guard"];
			(_display displayCtrl 1004) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _rank];
		};
		case ("doj"): {
			_display = uiNamespace getVariable "A3PL_HUD_FactionCard";
			_maxIDC = 1004;
			_card = "\A3PL_Common\GUI\Cards\Card_DOJ.paa";
			_rank = ["doj","rank", getPlayerUID _target] call A3PL_Config_GetFactionRankData;
			(_display displayCtrl 999) ctrlSetText _card;
			(_display displayCtrl 1000) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", (str(_target getVariable ["db_id","Error"]))];
			(_display displayCtrl 1001) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _fname];
			(_display displayCtrl 1002) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _lname];
			(_display displayCtrl 1003) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", "DOJ"];
			(_display displayCtrl 1004) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _rank];
		};
		case ("dmv"): {
			_display = uiNamespace getVariable "A3PL_HUD_FactionCard";
			_maxIDC = 1004;
			_card = "\A3PL_Common\GUI\Cards\Card_DMV.paa";
			_rank = ["uscg","rank", getPlayerUID _target] call A3PL_Config_GetFactionRankData;
			(_display displayCtrl 999) ctrlSetText _card;
			(_display displayCtrl 1000) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", (str(_target getVariable ["db_id","Error"]))];
			(_display displayCtrl 1001) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _fname];
			(_display displayCtrl 1002) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _lname];
			(_display displayCtrl 1003) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", "DMV"];
			(_display displayCtrl 1004) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _rank];
		};
		case ("usms"): {
			_display = uiNamespace getVariable "A3PL_HUD_FactionCard";
			_maxIDC = 1004;
			_card = "\A3PL_Common\GUI\Cards\Card_FIMS.paa";
			_rank = ["usms","rank", getPlayerUID _target] call A3PL_Config_GetFactionRankData;
			(_display displayCtrl 999) ctrlSetText _card;
			(_display displayCtrl 1000) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", (str(_target getVariable ["db_id","Error"]))];
			(_display displayCtrl 1001) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _fname];
			(_display displayCtrl 1002) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _lname];
			(_display displayCtrl 1003) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", "Marshal Service"];
			(_display displayCtrl 1004) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _rank];
		};
		case ("fifr"): {
			_display = uiNamespace getVariable "A3PL_HUD_FactionCard";
			_maxIDC = 1004;
			_card = "\A3PL_Common\GUI\Cards\Card_FIFR.paa";
			_rank = ["fifr","rank", getPlayerUID _target] call A3PL_Config_GetFactionRankData;
			(_display displayCtrl 999) ctrlSetText _card;
			(_display displayCtrl 1000) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", (str(_target getVariable ["db_id","Error"]))];
			(_display displayCtrl 1001) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _fname];
			(_display displayCtrl 1002) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _lname];
			(_display displayCtrl 1003) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", "Fire &amp; Rescue"];
			(_display displayCtrl 1004) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _rank];
		};
		case ("company"): {
			_display = uiNamespace getVariable "A3PL_HUD_FactionCard";
			_maxIDC = 1004;
			_card = "\A3PL_Common\GUI\Cards\Card_Company.paa";
			_cid = [getPlayerUID _target] call A3PL_Config_GetCompanyID;
			_cName = [_cid, "name"] call A3PL_Config_GetCompanyData;
			_cdLicenses = [_cid, "licenses"] call A3PL_Config_GetCompanyData;
			_cLicenses = "";
			if(count(_cdLicenses) > 0) then {
				{
					_cLicenses = format ["%2<br/>%1",_cLicenses, [_x,"name"] call A3PL_Config_GetLicense];
				} foreach _cdLicenses;
			} else {
				_cLicenses = "No Licenses";
			};
			(_display displayCtrl 999) ctrlSetText _card;
			(_display displayCtrl 1000) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", (str(_target getVariable ["db_id","Error"]))];
			(_display displayCtrl 1001) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _fname];
			(_display displayCtrl 1002) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _lname];
			(_display displayCtrl 1003) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='right' size='1' color='#000'>%1</t>", _cName];
			(_display displayCtrl 1004) ctrlSetPosition [0.0101562 * safezoneW + safezoneX, 0.456 * safezoneH + safezoneY, 0.175313 * safezoneW, 0.165 * safezoneH];
			(_display displayCtrl 1004) ctrlSetStructuredText parseText format["<t font='PuristaMedium' align='left' size='1' color='#000'>%1</t>", _cLicenses];
		};
	};
	for "_i" from 999 to _maxIDC do
	{
		(_display displayCtrl _i) ctrlSetFade 0;
		(_display displayCtrl _i) ctrlCommit 1.5;
	};
	uiSleep 15;
	for "_i" from 999 to _maxIDC do
	{
		(_display displayCtrl _i) ctrlSetFade 1;
		(_display displayCtrl _i) ctrlCommit 1.5;
	};
}] call Server_Setup_Compile;

["A3PL_HUD_Loop",
{
	disableSerialization;
	private ["_display","_control","_name","_imgnr","_text","_itemName","_isHudEnabled","_bloodLvl","_level","_xp","_nextLevel","_bar","_blindfold"];

	_display = uiNamespace getVariable ["A3PL_HUDDisplay",displayNull];

	_isHudEnabled = profileNameSpace getVariable ["A3PL_HUD_Enabled",true];
	if (isNull _display && _isHudEnabled) then
	{
		private ["_ctrl"];
		("A3PL_Hud" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD","PLAIN"];
		_display = uiNamespace getVariable ["A3PL_HUDDisplay",displayNull];
		_ctrl = _display displayCtrl 9520;
		_ctrl ctrlSetFade 1;
		_ctrl ctrlCommit 0;

		_ctrl = _display displayCtrl 9521;
		_ctrl ctrlSetFade 1;
		_ctrl ctrlCommit 0;
	};
	if (!isNull _display && !_isHudEnabled) then
	{
		("A3PL_Hud" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
		uiNameSpace setVariable ["A3PL_HUDDisplay",nil];
	};
	if (isNull _display) exitwith {};

	if(player getVariable ["jailed",false]) then {
		_control = _display displayCtrl 1000;
		_control ctrlShow true;
		_control ctrlSetText format["%1 Minutes Remaining",(player getVariable ["jailtime",0])];
	} else {
		_control = _display displayCtrl 1000;
		_control ctrlShow false;
	};

	//health
	_control = _display displayCtrl 1201;
	_bloodLvl = (player getVariable ["A3PL_MedicalVars",[5000]]) select 0;
	_imgnr = round (((_bloodLvl/5000))*45);

	if (_imgnr < 1) then
	{
		_control ctrlSetText "";
	} else
	{
		_control ctrlSetText format ["A3PL_Common\HUD\new\MBLoad_%1.paa",_imgnr];
	};

	_control = _display displayCtrl 1204;
	if (!isNil "Player_Hunger") then
	{
		_imgnr = round ((player_hunger*45)/100);
		if (_imgnr < 1) exitwith
		{
			_control ctrlSetText "";
		};
		_control ctrlSetText format ["A3PL_Common\HUD\new\MBLoad_%1.paa",_imgnr];
	} else {
		_control ctrlSetText "A3PL_Common\HUD\new\MBLoad_45.paa";
	};

	_control = _display displayCtrl 1205;
	if (!isNil "player_thirst") then
	{
		_imgnr = round ((player_thirst*45)/100);
		if (_imgnr < 1) exitwith
		{
			_control ctrlSetText "";
		};
		_control ctrlSetText format ["A3PL_Common\HUD\new\MBLoad_%1.paa",_imgnr];
	} else {
		_control ctrlSetText "A3PL_Common\HUD\new\MBLoad_45.paa";
	};

	_control = _display displayCtrl 1600;
	_control ctrlSetStructuredText parseText format ["<t font='PuristaBold' align='right'>%1</t>",toUpper (player getVariable ["name",(name player)])];

	_factionJobs = ["uscg","fifr","fisd","doj","usms","dmv","cartel"];
	_job = player getVariable ["job","unemployed"];
	if(_job IN _factionJobs) then {
		_rankName = [_job,"rank", getPlayerUID player] call A3PL_Config_GetFactionRankData;
		_job = format["%1", _rankName];
	};
	_control = _display displayCtrl 1601;
	_control ctrlSetStructuredText parseText format ["<t font='PuristaMedium' align='right'>%1</t>",toUpper (_job)];

	_level = player getVariable ['Player_Level',0];
    _xp = player getVariable ['Player_XP',0];
    _nextLevel = [_level, 'next'] call A3PL_Config_GetLevel;
    _bar = (_xp / _nextLevel);

	_control = _display displayCtrl 1604;
	_control progressSetPosition _bar;

	//Display amount of cops online
 	_control = _display displayCtrl 1001;
 	_control ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='center' size='0.85'><img image='\A3PL_Common\icons\faction_sheriff.paa' /> %1  <img image='\A3PL_Common\icons\faction_cg.paa' /> %2  <img image='\A3PL_Common\icons\faction_fifr.paa' /> %3</t>", count(["fisd"] call A3PL_Lib_FactionPlayers), count(["uscg"] call A3PL_Lib_FactionPlayers), count(["fifr"] call A3PL_Lib_FactionPlayers)];
}] call Server_Setup_Compile;

["A3PL_HUD_SetOverlay",
{
	disableSerialization;
	private ["_path","_idc","_Opacity"];
	_path = param [0,""];
	_order = param [1,0];
	_opacity = param [2,1];
	_idc = (uiNamespace getVariable "A3PL_Hud_Overlay") displayCtrl (1200+_order);
	_idc ctrlSetText _path;
	_idc ctrlSetFade _opacity;
	_idc ctrlCommit 0;
}] call Server_Setup_Compile;

["A3PL_HUD_GPS", {
	if (isNull (uiNameSpace getVariable ["Dialog_Hud_GPS", displayNull])) then {
		("hudLayer" call BIS_fnc_rscLayer) cutRsc ["Dialog_Hud_GPS", "PLAIN"];
		[] spawn {
			disableSerialization;
			_hud = uiNameSpace getVariable ["Dialog_Hud_GPS", displayNull];

			_ctrl_gps_image = _hud displayCtrl 23540;
			_ctrl_gps_map = _hud displayCtrl 23539;
			_ctrl_gps_azimut = _hud displayCtrl 23542;
			_ctrl_gps_altitude = _hud displayCtrl 23543;
			_ctrl_gps_position = _hud displayCtrl 23544;
			_ctrl_gps_frame = _hud displayCtrl 23540;

			_ctrl_gps_frame ctrlShow false;
			_ctrl_gps_position ctrlShow false;
			_ctrl_gps_altitude ctrlShow false;
			_ctrl_gps_azimut ctrlShow false;
			_ctrl_gps_map ctrlShow false;

			_ctrl_gps_active = false;
			_gps_old_pos = [0,0,0];

			createMarkerLocal ["myGPS", (getPos player)];
			"myGPS" setMarkerShapeLocal "ICON";
			"myGPS" setMarkerTypeLocal "A3PL_GPS";
			"myGPS" setMarkerColorLocal "ColorOrange";
			"myGPS" setMarkerSizeLocal [0.7, 0.7];

			while {!(isNull _hud)} do {
				if (("ItemGPS" in (assignedItems player)) && (profilenamespace getVariable ["A3PL_HUD_Enabled",true])) then {
					_ctrl_gps_image ctrlSetText "A3PL_Common\GUI\player_hud\gps_day.paa";

					if (((vehicle player) distance _gps_old_pos) > 2) then {
						"myGPS" setMarkerPosLocal (getPos (vehicle player));
						_gps_old_pos = getPos (vehicle player);
					};
					"myGPS" setMarkerDirLocal floor((getDir (vehicle player)) - 40);

					_heading = [] call A3PL_Lib_GetHeading;
					_ctrl_gps_azimut ctrlSetStructuredText parseText format [
						"<t size='0.7' font='PuristaLight' color='#ffffff' align='center'>%1</t>",
						_heading
					];

					_ctrl_gps_altitude ctrlSetStructuredText parseText format [
						"<t size='0.7' font='PuristaLight' color='#ffffff' align='center'>%1</t>",
						round((getPosASL (vehicle player)) select 2)
					];

					_ctrl_gps_position ctrlSetStructuredText parseText format [
						"<t size='0.7' font='PuristaLight' color='#ffffff' align='center'>%1</t>",
						(mapGridPosition player)
					];

					if ((vehicle player) isEqualTo player) then {
						_ctrl_gps_map ctrlMapAnimAdd [0, 0.05, player];
					} else {
						_ctrl_gps_map ctrlMapAnimAdd [0, 0.15, (vehicle player)];
					};
					ctrlMapAnimCommit _ctrl_gps_map;

					if (!_ctrl_gps_active) then {
						"myGPS" setMarkerAlphaLocal 1;
						_ctrl_gps_azimut ctrlShow true;
						_ctrl_gps_position ctrlShow true;
						_ctrl_gps_altitude ctrlShow true;
						_ctrl_gps_map ctrlShow true;
						_ctrl_gps_frame ctrlShow true;
						_ctrl_gps_active = true;
					};
				} else {
					if (_ctrl_gps_active) then
					{
						"myGPS" setMarkerAlphaLocal 0;
						_ctrl_gps_azimut ctrlShow false;
						_ctrl_gps_position ctrlShow false;
						_ctrl_gps_altitude ctrlShow false;
						_ctrl_gps_map ctrlShow false;
						_ctrl_gps_frame ctrlShow false;
						_ctrl_gps_active = false;
					};
				};
			};
		};
	};
}] call Server_Setup_Compile;
