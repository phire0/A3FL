/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_JobPicking_Init",
{
	Server_PickingAreas = [];
	{
		if (((_x splitstring "_") select 0) isEqualTo "Picking") then {Server_PickingAreas pushback _x;};
	} foreach allMapMarkers;
}] call Server_Setup_Compile;

["Server_JobPicking_Loop",
{
	{
		private _type = (_x splitstring "_") select 1;
		private _radius = ((getMarkerSize _x) select 0);
		private _pos = getMarkerPos _x;
		private _players = count (_pos nearEntities ["Man", _radius]);
		private _class = "";
		private _itemClass = "";
		private _attachPoints = [];
		switch (_type) do {
			case ("Apple"): {
				_class = "A3PL_Apple";
				_itemClass = "apple";
				_attachPoints = ["apple1","apple2","apple3","apple4","apple5","apple6","apple7","apple8","apple9","apple10","apple11","apple12","apple13","apple14","apple15","apple16","apple17","apple18","apple19","apple20","apple21","apple22","apple23","apple24","apple25","apple26","apple27","apple28","apple29","apple30","apple31","apple32","apple33","apple34","apple35","apple36","apple37","apple38","apple39","apple40","apple41","apple42","apple43","apple44","apple45","apple46","apple47","apple48","apple49","apple50","apple51","apple52","apple53","apple54"];
			};
		};

		private _objects = nearestObjects [_pos, [_class], _radius];
		private _countObjects = count _objects;
		if (_players < 1 && _countObjects > 0) then {
			{
				deleteVehicle _x;
			} foreach _objects;
		} else {
			if (_players > 0 && _countObjects < 10) then {
				private _trees = nearestTerrainObjects [_pos, ["tree"], _radius];
				{
					private _amountApples = 3 + (round random 3);
					private _attachpoints = _attachpoints call BIS_fnc_arrayShuffle;
					for "_i" from 1 to _amountApples do {
						private _applePos = _x selectionPosition (_attachpoints select _i);
						_applePos set [2,(_applePos select 2) - 0.1];
						private _obj = createvehicle [_class,_x modelToWorld _applePos, [], 0, "CAN_COLLIDE"];
						_obj enableSimulationGlobal false;
						_obj setVariable ["class",_itemClass,true];
					};
				} foreach _trees;
			};
		};
	} foreach Server_PickingAreas;
}] call Server_Setup_Compile;