/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Exterminator_Start",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private ["_mask"];
	if (!(["ccp"] call A3PL_DMV_Check)) exitwith {[localize"STR_EXTERMINATOR_CCP"] call A3PL_Player_Notification;};
	if ((player getVariable ["job","unemployed"]) isEqualTo "exterminator") exitwith {[localize"STR_EXTERMINATOR_WORKSTOP","red"]; call A3PL_NPC_LeaveJob};
	if (handgunWeapon player isEqualTo "") exitwith {[localize"STR_EXTERMINATOR_WEAPON"] call A3PL_Player_Notification;};
	player setVariable ["job","exterminator"];
	[localize"STR_EXTERMINATOR_WORKSTART","green"] call A3PL_Player_Notification;
	[localize"STR_EXTERMINATOR_MAPLOCATION","green"] call A3PL_Player_Notification;
	["A3PL_Mailtruck",[9986.59,7943.14,0],"EXTERMINATOR",1800] spawn A3PL_Lib_JobVehicle_Assign;
	call A3PL_Exterminator_PestStart;
}] call Server_Setup_Compile;

["A3PL_Exterminator_PestStart",
{
	private _animals = missionNameSpace getVariable ["A3PL_Exterminator_PestAnimals",[]];
	if ((count _animals) >= 4) exitwith {[] spawn A3PL_Exterminator_Loop;};
	call A3PL_Exterminator_SpawnPest;
	[] spawn A3PL_Exterminator_Loop;
}] call Server_Setup_Compile;

["A3PL_Exterminator_SpawnPest",
{
	private _animals = missionNameSpace getVariable ["A3PL_Exterminator_PestAnimals",[]];
	{deleteVehicle _x} foreach _animals;
	private _houses = nearestObjects [[7661.16,6609.34,0], ["Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_Mansion01","Land_A3PL_Ranch1","Land_A3PL_Ranch2","Land_A3PL_Ranch3","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_BostonHouse","Land_A3PL_Shed3","Land_A3PL_Shed4","Land_A3PL_Shed2","Land_John_House_Grey","Land_John_House_Blue","Land_John_House_Red","Land_John_House_Green","Land_A3FL_Mansion","Land_A3FL_House1_Cream","Land_A3FL_House1_Green","Land_A3FL_House1_Blue","Land_A3FL_House1_Brown","Land_A3FL_House1_Yellow","Land_A3FL_House2_Cream","Land_A3FL_House2_Green","Land_A3FL_House2_Blue","Land_A3FL_House2_Brown","Land_A3FL_House2_Yellow","Land_A3FL_House3_Cream","Land_A3FL_House3_Green","Land_A3FL_House3_Blue","Land_A3FL_House3_Brown","Land_A3FL_House3_Yellow","Land_A3FL_House4_Cream","Land_A3FL_House4_Green","Land_A3FL_House4_Blue","Land_A3FL_House4_Brown","Land_A3FL_House4_Yellow","Land_A3FL_Anton_Modern_Bungalow"], 6000,true];
	private _pos = getpos (_houses select (floor(random ((count _houses)-1))));
	if (isNil "_pos") exitwith {call A3PL_Exterminator_SpawnPest;};
	A3PL_Exterminator_PestAnimals = [];
	for "_i" from 0 to (8 + (round (random 2))) do {
		_animal = createAgent ["Rabbit_F", _pos, [], 25, "NONE"];
		A3PL_Exterminator_PestAnimals pushback _animal;
	};
	publicVariable "A3PL_Exterminator_PestAnimals";
}] call Server_Setup_Compile;

["A3PL_Exterminator_Loop",
{
	private _animals = missionNameSpace getVariable ["A3PL_Exterminator_PestAnimals",[]];
	[_animals] call A3PL_Exterminator_KillEH;
	while {(player getVariable ["job","unemployed"]) isEqualTo "exterminator"} do {
		private ["_markers","_marker"];
		_animals = missionNameSpace getVariable ["A3PL_Exterminator_PestAnimals",[]];
		_markers = [];
		{
			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],getpos _x];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerTextLocal format[localize"STR_EXTERMINATOR_MARKERMAP"];
			_markers pushback _marker;
		} foreach _animals;
		{ deleteMarkerLocal _x; } foreach (missionNameSpace getVariable ["A3PL_Exterminator_Markers",[]]);
		A3PL_Exterminator_Markers = _markers;
		uiSleep 2;
	};
	{ deleteMarkerLocal _x; } foreach A3PL_Exterminator_Markers;
}] call Server_Setup_Compile;

["A3PL_Exterminator_KillEH",
{
	private _animals = param [0,[]];
	{
		_x removeAllEventHandlers "killed";
		_x addEventHandler ["killed",
		{
			if ((param [2,objNull]) isEqualTo player) then
			{
				private _animal = param [0,objNull];
				[localize"STR_EXTERMINATOR_ANIMALKILLED","green"] call A3PL_Player_Notification;
				player setVariable ["player_cash",(player getVariable ["player_cash",0]) + 300,true];
				[player, 3] call A3PL_Level_AddXP;
				A3PL_Exterminator_PestAnimals = A3PL_Exterminator_PestAnimals - [_animal];
				publicVariable "A3PL_Exterminator_PestAnimals";
				deleteVehicle _animal;
				if (count A3PL_Exterminator_PestAnimals <= 4) then
				{
					call A3PL_Exterminator_PestStart;
					[localize"STR_EXTERMINATOR_AREACONTROL","green"] call A3PL_Player_Notification;
				};
			};
		}];
	} foreach _animals;
}] call Server_Setup_Compile;