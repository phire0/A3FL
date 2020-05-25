/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Markers_SelectFilter", {
	_map = findDisplay 12;
	_filterList = _map displayCtrl 1569;

	if(lbCurSel _filterList == -1) exitWith {};

	_currentFilterMarkers = _filterList lbData (lbCurSel _filterList);
	_mapMarkers = [];
	_disallowedMapMarkers = getArray(missionConfigFile >> "A3PL_mapAreas" >> "exclude");

	{if(markerType _x != "Empty" && !(_x in _disallowedMapMarkers)) then {_mapMarkers pushBack _x;};} forEach allMapMarkers;

	if(_currentFilterMarkers == "ALL") then {
		{_x setMarkerAlphaLocal 1;} forEach _mapMarkers;
		call A3PL_Player_SetMarkers;
	} else {
		_currentFilterMarkers = call compile format["%1",_currentFilterMarkers];
		{if(!(_x in _currentFilterMarkers)) then {_x setMarkerAlphaLocal 0;} else {_x setMarkerAlphaLocal 1;};} forEach _mapMarkers;
		call A3PL_Player_SetMarkers;
	};
}] call Server_Setup_Compile;

["A3PL_Markers_OpenMap",
{
	disableSerialization;
	private ["_map","_listbox"];

	//get the map display
	_map = findDisplay 12;

	//insert the listbox into the map display itself (this way we can interact with it at the same time as controlling the map)
	_findListbox = _map displayCtrl 1569;
	if (isNull _findListbox) then
	{
		_listbox = _map ctrlCreate ["RscListbox", 1569];
		_listbox ctrlSetPosition [0.0307812 * safezoneW + safezoneX,0.467 * safezoneH + safezoneY,0.103125 * safezoneW,0.22 * safezoneH];
		_listbox ctrlSetBackgroundColor [0,0,0,1];
		_listbox ctrlCommit 0;
		_listbox ctrlAddEventHandler ["LBSelChanged",{[(_this select 0)] call A3PL_Markers_SelectFilter;}];
	};

	//create background layer which containers our MapFilter background
	("A3PL_Map_Filter" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
	("A3PL_Map_Filter" call BIS_fnc_rscLayer) cutRsc ["Dialog_MapFilter", "PLAIN"];

	_listbox lbAdd "Display All";
	_listbox lbSetValue[(lbSize _listbox)-1,-1];
	_listbox lbSetData[(lbSize _listbox)-1,"ALL"];
	
	{
		_listbox lbAdd (_x select 0);
		_listbox lbSetValue[(lbSize _listbox)-1,_forEachIndex];
		_listbox lbSetData[(lbSize _listbox)-1,str(_x select 1)];
	} forEach getArray(missionConfigFile >> "A3PL_mapAreas" >> "filters");
}] call Server_Setup_Compile;