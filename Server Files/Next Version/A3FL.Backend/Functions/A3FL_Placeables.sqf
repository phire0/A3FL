/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['A3PL_Placeables_Pickup', {
	private _obj = param [0,(call A3PL_Intersect_Cursortarget)];
	private _attachedTo = attachedTo _obj;
	if ((isPlayer _attachedTo) && (!(_attachedTo isKindOf "Car"))) exitwith {[localize"STR_NewPlaceables_1", "red"] call A3PL_Player_Notification;};

	if ((!local _obj) && (!((typeOf _obj) IN ["A3PL_WheelieBin","A3FL_DrugBag"]))) exitwith
	{
		[localize"STR_NewPlaceables_2", "red"] call A3PL_Player_Notification;
		_owner = _obj getVariable ["owner",nil];
		if (!isNil "_owner") then
		{
			if (typeName _owner == "ARRAY") then
			{
				if (getPlayerUID player == (_owner select 0)) then
				{
					[_obj,player] remoteExec ["Server_Core_Locality", 2];
					[localize"STR_NewPlaceables_3", "yellow"] call A3PL_Player_Notification;
				};
			} else {
				if (getPlayerUID player == _owner) then
				{
					[_obj,player] remoteExec ["Server_Core_Locality", 2];
					[localize"STR_NewPlaceables_3", "yellow"] call A3PL_Player_Notification;
				};
			};
		};
		if (typeOf _obj == "A3PL_DeliveryBox") then
		{
			_packageOwner = _obj getVariable ["owner",getPlayerUID player];
			if (_packageOwner == (getPlayerUID player)) then
			{
				[_obj,player] remoteExec ["Server_Core_Locality", 2];
				[localize"STR_NewPlaceables_3", "yellow"] call A3PL_Player_Notification;
			};
		};
	};

	private _type = typeOf _obj;
	if (_type isEqualTo "GroundWeaponHolder") then {
		_obj attachTo [player, [0,0,0.65], "RightHand"];
	} else {
		_dir = getDir _obj;
		_obj attachTo [player];
		_obj setDir (_dir + (360 - (getDir player)));
	};
	[_obj] spawn A3PL_Placeable_AttachedLoop;
}] call Server_Setup_Compile;

["A3PL_Placeable_GetZOffset",
{
	private _item = typeOf (_this select 0);
	private _car = (_this select 1);
	private _offset = 0;
	{
		if ((_x select 0) == _item) exitWith
		{
			if(_car) then {
				_offset = _x select 1;
			} else {
				_offset = _x select 2;
			};
		};
	} foreach Config_Items_ZOffset;
	_offset;
}] call Server_Setup_Compile;

["A3PL_Placeable_AttachedLoop",
{
	private _obj = param [0,objNull];
	private _attach = param [1,[0,0,0]];
	private _type = typeOf _obj;
	private _distance = player distance _obj;
	while {(_obj IN (attachedObjects player)) && (!isNull _obj)} do
	{
		_sleep = 0.5;
		if (!alive player) exitwith {detach _obj; [] call A3PL_Inventory_Drop;};
		if (!(vehicle player isEqualTo player) || ((animationState player) == "a3pl_takenhostage")) exitwith
		{
			private _isItem = false;
			{
				if (_x select 3 == (typeOf _obj)) exitwith
				{
					[true] call A3PL_Inventory_PutBack;
					_isItem = true;
				};
			} foreach Config_Items;
			if (!(_isItem)) then {
				detach _obj;
			} else {
				[] call A3PL_Inventory_Drop;
			};
		};
		if (Player_NameIntersect IN ["trunkinside","trunkinside1","trunkinside2","trunkinside3","trunkinside4","trunkinside5","trunkinside6","trunkinside7","trunkinside8","trunkinside9","trunkinside10","trunkinside11","lockerbottom","lockertop","mcfishertable","mcfisherstable1","mcfisherstable2","mcfishergrill"]) then
		{
			private ["_interDist","_dist","_begPosASL","_endPosASL","_posAGL"];
			_interDist = [player_objintersect, "FIRE"] intersect [positionCameraToWorld [0,0,0],positionCameraToWorld [0,0,1000]];
			if (count _interDist < 1) exitwith {};
			_dist = (_interDist select 0) select 1;
			_begPosASL = AGLToASL positionCameraToWorld [0,0,0];
			_endPosASL = AGLToASL positionCameraToWorld [0,0,1000];
			_posAGL = ASLToAGL (_begPosASL vectorAdd ((_begPosASL vectorFromTo _endPosASL) vectorMultiply _dist));

			switch (typeOf _obj) do
			{
				case ("A3PL_Stinger"):
				{
					_obj attachto [player,
					[
						(player worldToModel (getposATL _obj)) select 0,
						(player worldToModel (getposATL _obj)) select 1,
						((player worldToModelVisual _posAGL) select 2) + ([_obj,true] call A3PL_Placeable_GetZOffset)
					]];
				};
				case default {_obj attachto [player,[(player worldToModelVisual _posAGL) select 0,(player worldToModelVisual _posAGL) select 1,((player worldToModelVisual _posAGL) select 2) + ([_obj,true] call A3PL_Placeable_GetZOffset)]];};
			};

			_sleep = 0.1;

			if (_type == "GroundWeaponHolder") exitwith
			{
				detach _obj;
				_obj attachTo [player, [0, 1.5,
				((player WorldToModel (Player_ObjIntersect modelToWorld(Player_ObjIntersect selectionPosition player_nameIntersect))) select 2) + ([_obj,true] call A3PL_Placeable_GetZOffset)] ];
			};
		}
		else
		{
			if (Player_Item == _obj) exitwith
			{
				switch (Player_ItemClass) do
				{
					case ("popcornBucket"):
					{
						if (!isNil "A3PL_EatingPopcorn") exitwith {};
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case ("beer"):
					{
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case ("coke"):
					{
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case ("waterbottle"):
					{
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case ("dildo"):
					{
						Player_Item attachTo [player, [0,0,0.05], 'RightHand']; 
      					Player_Item setVectorUp [1,0,0];
					};
					case ("beer_gold"):
					{
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case ("coffee_cup_large"):
					{
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case ("coffee_cup_medium"):
					{
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case ("coffee_cup_small"):
					{
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case default {Player_Item attachTo [player, _attach, 'RightHand'];};
				};
			};

			if (_type isEqualTo "GroundWeaponHolder") then
			{
				_obj attachTo [player, [0.6,0,0.1], 'RightHand'];
				_obj setVectorUp [1,0,0];
			} else {
				_obj setposATL [getposATL _obj select 0,getposATL _obj select 1,(getposATL _obj select 2) -+ ([_obj] call A3PL_Placeable_ObjectZFix)];
				if([_obj,false] call A3PL_Placeable_GetZOffset != 0) then {
					_obj attachto [player,[0,1,[_obj,false] call A3PL_Placeable_GetZOffset]];
				} else {
					_obj attachTo[player];
				};
				switch (typeOf _obj) do {
					case ("A3PL_DeliveryBox"): { _obj attachTo [player,[-0.2,0,0],"RightHand"]; };
					case ("A3FL_DrugBag"): { _obj attachTo [player,[-0.21,0,0],"RightHand"];};
					case ("A3PL_RoadCone_x10"): { _obj attachTo [player,[0,0,0],"RightHand"]; };
				};
			};
		};
		sleep _sleep;
	};
}] call Server_Setup_Compile;

['A3PL_Placeable_ObjectZFix',
{
	private _obj = _this select 0;
	private _posZ = (boundingboxReal _obj) select 0; // Okay now we have a x,y,z model coordinate relative to model center
	_posZ = _obj modelToWorld _posZ; // lets convert this to world coordinates
	_posZ = (_posZ select 2); //Okay we have world coordinates, lets get rid of X and Y, we will now end up with the difference between terrain and object
	_posZ = _posZ - ((getposATL player) select 2); // Okay now we add the Z of the player on top of that
	_posZ;
}] call Server_Setup_Compile;

['A3PL_Placeable_ObjectZFixTrunk',
{
	private ["_obj","_posZ","_offsetTrunk"];
	_obj = _this select 0;

	_offsetTrunk = (Player_ObjIntersect modelToWorld(Player_ObjIntersect selectionPosition player_nameintersect)) select 2;
	_posZ = _offsetTrunk;
	_posZ;
}] call Server_Setup_Compile;

['A3PL_Placeables_QuickAction', {
	private _attached = [] call A3PL_Lib_Attached;
	if (count _attached > 0) exitwith
	{
		private ["_obj","_dir","_collision","_except"];
		_obj = _attached select 0;
		_collision = [_obj] call A3PL_Lib_checkCollision;
		{
			if ((_x isKindOf "Car") OR (_x isKindOf "Jonzie_Public_Trailer_Base")) exitwith
			{
				_collision = _collision - [_x];
			};
		} foreach _collision;

		//if we are supposedly placing an item in something we will also exclude it
		if (Player_NameIntersect IN ["trunkinside","trunkinside1","trunkinside2","trunkinside3","trunkinside4","trunkinside5","trunkinside6","trunkinside7","trunkinside8","trunkinside9","trunkinside10","trunkinside11","lockerbottom","lockertop","mcfishertable","mcfishergrill"]) then
		{
			_collision = _collision - [player_objintersect];
		};

		//skip collision check for gear
		if (typeOf _obj == "GroundWeaponHolder") then
		{
			_collision = [];
		};

		_except = ["A3PL_EMS_Stretcher","A3PL_Ladder"];
		if ((count _collision > 0) && !((typeOf _obj) IN _except)) exitwith {[localize"STR_NewPlaceables_4", "red"] call A3PL_Player_Notification;};

		//check to see if player is freelooking
		if (freeLook) exitwith
		{
			[localize"STR_NewPlaceables_5", "red"] call A3PL_Player_Notification;
		};

		if (Player_NameIntersect IN ["trunkinside","trunkinside1","trunkinside2","trunkinside3","trunkinside4","trunkinside5","trunkinside6","trunkinside7","trunkinside8","trunkinside9","trunkinside10","trunkinside11","lockerbottom","lockertop","mcfishertable","mcfishergrill"]) exitwith
		{
			if (Player_NameIntersect IN ["lockerbottom","lockertop"]) exitwith
			{
				if (Player_ObjIntersect AnimationPhase "door1" < 0.5) exitwith {};
				detach _obj;
				_obj attachto [(call A3PL_Intersect_Cursortarget)];
				_obj setDir 180;
				_obj setPos getPos _obj;

				if (_obj == Player_Item) then
				{
					[false] call A3PL_Inventory_Drop;
				};
			};

			//mcfisher
			if (Player_NameIntersect IN ["mcfishertable","mcfishergrill"]) exitwith
			{
				detach _obj;
				_obj attachto [player_objintersect];
				if (_obj == Player_Item) then
				{
					[false,1] call A3PL_Inventory_Drop;
				};
			};

			if (Player_NameIntersect IN ["trunkinside","trunkinside1","trunkinside2","trunkinside3","trunkinside4","trunkinside5","trunkinside6","trunkinside7","trunkinside8","trunkinside9","trunkinside10","trunkinside11"]) exitwith
			{
				if ([Player_ObjIntersect,_obj] call A3PL_Placeable_CarBlacklist) exitwith {[localize"STR_NewPlaceables_6", "red"] call A3PL_Player_Notification;};
				_dir = getDir _obj;
				detach _obj;
				_obj setvelocity [0,0,0];
				_obj attachto [(call A3PL_Intersect_Cursortarget)];
				_obj setDir (_dir + (360 - (getDir player_objintersect)));
				_obj setpos (getpos _obj);

				if (_obj == Player_Item) then
				{
					[false] call A3PL_Inventory_Drop;
				};
			};
		};
		if (typeOf _obj == "GroundWeaponHolder") exitwith {detach _obj; _obj setpos [(getpos player select 0),(getpos player select 1),(getposATL player select 2)]};
		detach _obj;
		_obj setvelocity [0,0,0];
		_obj setposATL (getposATL _obj);
	};
	if (!(isNull player_item)) exitwith {[localize"STR_NewPlaceables_7", "red"] call A3PL_Player_Notification};
	call A3PL_Placeables_Pickup;
}] call Server_Setup_Compile;

['A3PL_Placeable_CarBlacklist',
{
	private _car = typeOf (_this select 0);
	private _obj = (getModelInfo (_this select 1)) select 0;
	private _return = false;
	{
		if ((_x select 0) == _car) exitwith
		{
			{
				if ((format ["%1.p3d",_x]) == _obj) then
				{
					_return = true;
				};
			} foreach (_x select 1);
		};
	} foreach Config_CarFurnitureBlacklist;
	_return;
}] call Server_Setup_Compile;

['A3PL_Placeable_CarMaxObj',
{
	private _car = typeOf (_this select 0);
	private _return = 1;
	{
		if ((_x select 0) == _car) exitwith {
			_return = (_x select 2);
		};
	} foreach Config_CarFurnitureBlacklist;
	_return;
}] call Server_Setup_Compile;

["A3PL_Placeables_PlaceCone",
{
	private _cones = ([] call A3PL_Lib_Attached) select 0;
	if (isNil "_cones") then {_cones = objNull;};
	if ((typeOf _cones) != "A3PL_RoadCone_x10") exitwith {[localize"STR_NewPlaceables_8","red"] call A3PL_Player_Notification;};
	private _sourcePhase = _cones animationSourcePhase "cone_hide";
	if (_sourcePhase >= 9) exitwith {detach _cones;};
	_cones animateSource ["cone_hide",_sourcePhase + 1];
	private _cone = createVehicle ["A3PL_RoadCone", (getPosATL _cones), [], 0, "CAN_COLLIDE"];
	_cone setVariable ["class","roadcone",true];
	[localize"STR_NewPlaceables_9","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Placeables_StackCone",
{
	private ["_cone","_nearCone","_pos","_animPhase"];
	_cone = param [0,objNull];

	_nearCone = nearestObjects [_cone,["A3PL_RoadCone","A3PL_RoadCone_x10"],4];
	_nearCone = _nearCone - [_cone];
	if (count _nearCone <= 0) exitwith {[localize"STR_NewPlaceables_10","red"] call A3PL_Player_Notification;};
	_nearCone = _nearCone select 0;

	if ((((_cone animationSourcePhase "cone_hide") <= 0) && (typeOf _cone == "A3PL_RoadCone_x10")) OR (((_nearcone animationSourcePhase "cone_hide") <= 0) && (typeOf _nearcone == "A3PL_RoadCone_x10"))) exitwith {[localize"STR_NewPlaceables_11","red"] call A3PL_Player_Notification;};
	if ((typeOf _nearCone == "A3PL_RoadCone_x10") && (typeOf _cone == "A3PL_RoadCone_x10")) exitwith
	{
		_animPhase = 10 - (_nearCone animationSourcePhase "cone_hide");
		deleteVehicle _nearCone;
		_cone animateSource ["cone_hide",(_cone animationSourcePhase "cone_hide") - _animPhase];
		if(((_cone animationSourcePhase "cone_hide") - _animPhase) isEqualTo 0) then {
			_cone setVariable ["class","roadcones",true];
		};
	};
	if ((typeOf _nearCone == "A3PL_RoadCone_x10") OR (typeOf _cone == "A3PL_RoadCone_x10")) exitwith
	{
		if (typeOf _nearCone == "A3PL_RoadCone_x10") then
		{
			if (typeOf _cone == "A3PL_RoadCone") then {_animPhase = 1;} else {_animPhase = _cone animationSourcePhase "cone_hide";};
			deleteVehicle _cone;
			_nearCone animateSource ["cone_hide",((_nearcone animationSourcePhase "cone_hide") - _animPhase)];
			if(((_cone animationSourcePhase "cone_hide") - _animPhase) isEqualTo 0) then {
				_cone setVariable ["class","roadcones",true];
			};
		} else
		{
			if (typeOf _nearcone == "A3PL_RoadCone") then {_animPhase = 1;} else {_animPhase = _nearcone animationSourcePhase "cone_hide";};
			deleteVehicle _nearcone;
			_cone animateSource ["cone_hide",((_cone animationSourcePhase "cone_hide") - _animPhase)];
			if(((_cone animationSourcePhase "cone_hide") - _animPhase) isEqualTo 0) then {
				_cone setVariable ["class","roadcones",true];
			};
		};
	};

	_pos = getposATL _cone;
	deleteVehicle _cone;
	deleteVehicle _nearCone;
	_cone = createVehicle ["A3PL_RoadCone_x10", _pos, [], 0, "CAN_COLLIDE"];
	_cone animateSource ["cone_hide",8,true];
	_cone setVariable ["class","roadcone",true];
}] call Server_Setup_Compile;