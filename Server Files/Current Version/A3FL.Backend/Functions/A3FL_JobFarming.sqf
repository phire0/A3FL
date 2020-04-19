["A3PL_JobFarming_SearchSeeds",
{
	private ["_random","_found","_timeLeft"];
	if (!(player getVariable ["job","unemployed"] == "farmer")) exitwith {["You are not a farmer so you can't search for seeds", "red"] call a3pl_player_notification;};

	_timeLeft = missionNameSpace getVariable ["A3PL_JobFarming_SeedTimer",(diag_ticktime-5)];
	if (_timeLeft > diag_ticktime) exitwith {[format ["Please wait %1 more seconds before finding another seed",round(_timeLeft-diag_ticktime)],"red"] call A3PL_Player_Notification;};
	missionNameSpace setVariable ["A3PL_JobFarming_SeedTimer",(diag_ticktime + (1 + random 3))];

	player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';

	_random = round (random 100);
	_found = "";
	switch (true) do
	{
		case (_random > 40): {["You didn't find anything","red"] call A3PL_Player_Notification;};
		case (_random >= 0):
		{
			private ["_seeds","_seed"];
			_seeds = ["seed_wheat","seed_corn","seed_lettuce","seed_coca","seed_sugar"];
			_seed = _seeds select (floor (random (count _seeds)));
			[format ["You found a seed! (%1)",([_seed,"name"] call A3PL_Config_GetItem)],"green"] call A3PL_Player_Notification;
			[_seed,1] call A3PL_Inventory_Add;
		};
	};
}] call Server_Setup_Compile;

["A3PL_JobFarming_Plant",
{
	private ["_class","_posATL"];
	_class = player_itemClass;

	if (!(_class IN  ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca","seed_sugar"])) exitwith {["You do not have a seed inside your hand to plant", "red"] call a3pl_player_notification;};

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	_posATL = getPosATL player;
	if ((surfaceType _posATL) != "#cype_plowedfield") exitwith {["You are not standing on a farm field", "red"] call a3pl_player_notification;};

	_nearPlants = nearestObjects [player, ["A3PL_Wheat", "A3PL_Corn","A3PL_Cannabis", "A3PL_Lettuce","A3PL_Coco_Plant", "A3PL_Sugarcane_Plant"], 0.85];
	if(count(_nearPlants) > 0) exitWith {["You cannot plant seeds on top of each other.", "red"] call a3pl_player_notification;};

	_nearByPlants = nearestObjects [player, ["A3PL_Wheat", "A3PL_Corn","A3PL_Cannabis", "A3PL_Lettuce","A3PL_Coco_Plant", "A3PL_Sugarcane_Plant"], 100];
	if(count(_nearByPlants) > 30) exitWith {["There is too many plants in this area, please harvest some before planting more!", "red"] call a3pl_player_notification;};

	player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';

	[player,_class,_posATL] remoteExec ["Server_JobFarming_Plant",2];
}] call Server_Setup_Compile;

["A3PL_JobFarming_Harvest",
{
	private ["_plant","_growState"];
	_plant = param [0,objNull];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	[player,_plant] remoteExec ["Server_JobFarming_Harvest",2];
}] call Server_Setup_Compile;

["A3PL_JobFarming_PlantReceive",
{
	private ["_r","_msg"];
	_r = param [0,-1];

	switch (_r) do
	{
		case -1: {_msg = ["Unknown error occured while trying to plant a seed","red"];};
		case 0: {_msg = ["You succesfully planted a seed in this field","green"];};
		case 1: {_msg = ["This greenhouse is already owned","red"];};
		case 2: {_msg = ["You already own a greenhouse","red"];};
		case 3: {_msg = [format ["You succesfully rented a greenhouse for 35 minutes for $250 (keyID: %1)",param [1,"Error"]],"green"];};
		case 4: {_msg = ["Denied harvesting, this plant doesn't seem to be grown","red"];};
		case 5: {_msg = [format ["You succesfully harvested a plant, and you harvested %1 %2(s)",param [2,1],([param [1,""], 'name'] call A3PL_Config_GetItem)],"green"];};
		case 6: {_msg = ["Unable to add items to your inventory, please make sure you have enough space to fit the harvested item(s)","red"];};
	};

	//additional code for succefully planting a seed
	if (_r == 0) then
	{
		[] call A3PL_Inventory_Clear; //deletes the item in hand and resets itemClass etc
	};

	_msg call a3pl_player_notification;
}] call Server_Setup_Compile;

["A3PL_JobFarming_BuyGreenhouse",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_greenHouse","_interDist","_dist","_begPosASL","_endPosASL","_posATL"];
	_greenHouse = param [0,objNull];
	if (isNull _greenHouse) exitwith {["Couldn't determine greenhouse","red"] call A3PL_Player_Notification;};
	_timeLeft = serverTime - (_greenHouse getVariable ["buyTime",serverTime]);
	if ((_timeLeft < 1800) && (_timeLeft != 0)) exitwith { [format ["This greenhouse is already owned by somebody, please wait %1 more minutes",(1800 - _timeLeft)/60],"red"] call A3PL_Player_Notification;};
	if ((player getVariable ["player_cash",0]) < 350) exitwith {["You don't have enough money to rent this greenhouse","red"] call A3PL_Player_Notification;};

	//send request to create a key for this greenhouse
	player setVariable ["player_cash",((player getVariable ["player_cash",0]) - 350),true];
	_greenHouse setVariable ["buyTime",serverTime,true];
	[player,_greenHouse,"",false] remoteExec ["Server_Housing_CreateKey", 2];
	["You bought this greenhouse for $350, you now own this greenhouse for 30 minutes.","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_JobFarming_GreenHousePlant",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_greenHouse","_interDist","_dist","_begPosASL","_endPosASL","_posATL","_class","_amountPlants"];
	_greenHouse = param [0,objNull];
	if (isNull _greenHouse) exitwith {["Couldn't determine greenhouse","red"] call A3PL_Player_Notification;};
	_class = player_itemClass;


	_timeLeft = serverTime - (_greenHouse getVariable ["buyTime",serverTime]);
	if (_timeLeft > 1800) exitwith {["The rent on this greenhouse has expired, please extend it"] call A3PL_Player_Notification;};


	_amountPlants = count (nearestObjects [player,["A3PL_Wheat","A3PL_Corn","A3PL_Cannabis","A3PL_Lettuce","A3PL_Coco_Plant","A3PL_Sugarcane_Plant"],5]);
	if (_amountPlants >= 10) exitwith {["You can only plant 10 plants in a greenhouse","red"] call A3PL_Player_Notification};


	_interDist = [_greenHouse, "FIRE"] intersect [positionCameraToWorld [0,0,0],positionCameraToWorld [0,0,1000]];
	if (count _interDist < 1) exitwith {["Unable to determine where to place the seed", "red"] call a3pl_player_notification;};
	_dist = (_interDist select 0) select 1; //get the distance so we can use it in the vectormultiply below
	_begPosASL = AGLToASL positionCameraToWorld [0,0,0];
	_endPosASL = AGLToASL positionCameraToWorld [0,0,1000];
	_posATL = ASLToATL (_begPosASL vectorAdd ((_begPosASL vectorFromTo _endPosASL) vectorMultiply _dist));

	[player,_class,_posATL] remoteExec ["Server_JobFarming_Plant",2];
	["You planted a seed in this greenhouse","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_JobFarming_PlanterPlant",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_planter","_interDist","_dist","_begPosASL","_endPosASL","_posATL","_class","_amountPlants"];
	_planter = param [0,objNull];
	if (isNull _planter) exitwith {["Couldn't determine planter","red"] call A3PL_Player_Notification;};
	_class = player_itemClass;

	_amountPlants = count ([_planter] call A3PL_Lib_AttachedAll);
	if (_amountPlants >= 2) exitwith {["You can only plant 2 plants in one planter","red"] call A3PL_Player_Notification};

	_interDist = [_planter, "FIRE"] intersect [positionCameraToWorld [0,0,0],positionCameraToWorld [0,0,1000]];
	if (count _interDist < 1) exitwith {["Unable to determine where to place the seed", "red"] call a3pl_player_notification;};
	_dist = (_interDist select 0) select 1;
	_begPosASL = AGLToASL positionCameraToWorld [0,0,0];
	_endPosASL = AGLToASL positionCameraToWorld [0,0,1000];
	_posATL = ASLToATL (_begPosASL vectorAdd ((_begPosASL vectorFromTo _endPosASL) vectorMultiply _dist));

	if (_class == "seed_marijuana") then
	{

		_plant = createVehicle ["A3PL_Cannabis",[_posATL select 0,_posATL select 1,((_posATL select 2) - 0.05)], [], 0, "CAN_COLLIDE"];
		_plant setDir (random 360);
		[_plant, _planter] call BIS_fnc_attachToRelative;
		_plant animateSource ["plant_growth",1];
		A3PL_Cannabis_Plants = missionNameSpace getVariable ["A3PL_Cannabis_Plants",[]];
		A3PL_Cannabis_Plants pushback _plant;


		if ((random 10) >= 5) then { _plant setVariable ["female",true,true]; };


		["seed_marijuana",-1] call A3PL_Inventory_Add;
		[] call A3PL_Inventory_Clear;
		["You planted a seed in this planter","green"] call A3PL_Player_Notification;


		if (!isNil "A3PL_Cannabis_Loop") exitwith {};
		A3PL_Cannabis_Loop = true;
		[] spawn
		{
			while {(count A3PL_Cannabis_Plants) > 0} do
			{
				private ["_plantsToDelete"];
				_plantsToDelete = [objNull];
				{

					if ((isNull _x) OR ((_x animationSourcePhase "plant_growth") > 0.99)) then
					{
						_plantsToDelete = _plantsToDelete + [_x];
					};

					private ["_near","_lightValue","_plantsToDelete"];

					_lightValue = 0;
					_near = nearestObjects [_x, ["A3PL_Cannabis_Lamp_200W","A3PL_Cannabis_Lamp_500W","A3PL_Cannabis_Lamp_1000W"], 2,true];
					if (count _near < 1) then {_near = objNull;} else
					{
						_near = _near select 0;
					};
					switch (typeOf _near) do
					{
						case ("A3PL_Cannabis_Lamp_200W"): {_lightValue = 2;};
						case ("A3PL_Cannabis_Lamp_500W"): {_lightValue = 4;};
						case ("A3PL_Cannabis_Lamp_1000W"): {_lightValue = 6;};
					};
					_x setVariable ["lightValue",(_x getVariable ["lightValue",0]) + _lightValue,true];
				} foreach (missionNameSpace getVariable ["A3PL_Cannabis_Plants",[]]);


				{
					A3PL_Cannabis_Plants = A3PL_Cannabis_Plants - [_x];
				} foreach _plantsToDelete;

				uiSleep 60;
			};
			A3PL_Cannabis_Loop = nil;
		};
	} else
	{
		[player,_class,_posATL] remoteExec ["Server_JobFarming_Plant",2];

		["You planted a seed in this planter","green"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_JobFarming_CheckCured",
{
	private ["_cured","_bud","_near"];
	_bud = param [0,objNull];
	_cured = _bud getVariable ["cured",0];
	if ((_bud getVariable ["class",""]) == "cannabis_bud_cured") exitwith {["This bud is 100% cured! You can now use this bud in the grinder!","green"] call A3PL_Player_Notification;};
	if ((_bud getVariable ["class",""]) == "cannabis_grinded_5g") exitwith {["This marijuana is grinded and ready to be bagged!","green"] call A3PL_Player_Notification;};
	_near = nearestObjects [_bud, ["A3PL_Fan"], 2,true];
	if ((_bud IN (missionNameSpace getVariable ["A3PL_Cannabis_Buds",[]])) && (count _near > 0)) then
	{
		[format ["This bud is currently curing, right now it is %1%2 cured",_cured,"%"],"green"] call A3PL_Player_Notification;
	} else
	{
		[format ["This bud is currently NOT CURING (has this item been placed on a workbench?, and is a fan pointed at the buds?), right now it is %1%2 cured",_cured,"%"],"green"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_JobFarming_CureLoop",
{
	private ["_bud"];
	_bud = param [0,objNull];

	A3PL_Cannabis_Buds = missionNameSpace getVariable ["A3PL_Cannabis_Buds",[]];
	A3PL_Cannabis_Buds pushback _bud;

	//notify
	["You put a bud on the table to cure, this process will take about 10 minutes and requires a fan to be pointed at the bud. After curing the buds you can use them in the grinder!"] call A3PL_Player_Notification;

	if (!isNil "A3PL_Cannabis_CureLoop") exitwith {};
	A3PL_Cannabis_CureLoop = true;

	[] spawn
	{
		while {(count A3PL_Cannabis_Buds) > 0} do
		{
			uiSleep 60; //change to 60

			private ["_toDelete","_near"];
			_toDelete = [ObjNull];

			{
				//this script removes buds
				if ((isNull (attachedTo _x)) OR (isNull _x)) then {_toDelete pushback _x;};

				//the script to check for a nearby fan
				_near = nearestObjects [_x, ["A3PL_Fan"], 2,true];
				if (count _near > 0) then
				{
					_x setVariable ["cured",(_x getVariable ["cured",0]) + 10,true];
				};

				if ((_x getVariable ["cured",0]) >= 100) then
				{
					_x setVariable ["class","cannabis_bud_cured",true];
					_toDelete pushback _x;
				};
			} foreach (missionNameSpace getVariable ["A3PL_Cannabis_Buds",[]]);
			{A3PL_Cannabis_Buds = A3PL_Cannabis_Buds - [_x];} foreach _toDelete;
		};
		A3PL_Cannabis_CureLoop = nil;
	};
}] call Server_Setup_Compile;

["A3PL_JobFarming_Grind",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_near","_bud","_grinder"];
	_grinder = param [0,objNull];
	_near = nearestObjects [_grinder, ["A3PL_Cannabis_Bud"], 2,true];
	_bud = objNull;
	{
		if ((_x getVariable "class") == "cannabis_bud_cured") exitwith {_bud = _x;};
	} foreach _near;
	if (isNull _bud) exitwith {["Unable to find a cured bud nearby","green"] call A3PL_Player_Notification;};

	deleteVehicle _bud;
	["a cured but was placed into the grinder, it will take about 30 seconds before grinding is completed!"] call A3PL_Player_Notification;
	[_grinder] spawn
	{
		_grinder = param [0,objNull];
		uiSleep 30;
		["a cured bud finished grinding (5 grams), you can collect if from the grinder.","green"] call A3PL_Player_Notification;
		_grinder setVariable ["grindedweed",(_grinder getVariable ["grindedweed",0]) + 5,true];
	};
}] call Server_Setup_Compile;

["A3PL_JobFarming_GrindCollect",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_grinder","_value","_amount"];
	_grinder = param [0,objNull];
	_value = _grinder getVariable ["grindedweed",0];
	if (_value < 5) exitwith
	{
		["There is no grinded weed in this grinder to be collected","red"] call A3PL_Player_Notification;
	};
	_amount = _value / 5;
	_grinder setVariable ["grindedweed",nil,true];
	[format ["You collected %1 grinded marijuana (%2 grams)",_amount,_value],"green"] call A3PL_Player_Notification;
	["cannabis_grinded_5g",_amount] call A3PL_Inventory_Add;
}] call Server_Setup_Compile;

//function to bag the weed
["A3PL_JobFarming_BagOpen",
{
	disableSerialization;
	private ["_scale","_near","_allGrinded","_display","_ctrl"];
	_allGrinded = [];
	_scale = param [0,objNull];
	_near = nearestObjects [_scale, ["A3PL_Cannabis_Bud"],2,true];

	//check for nearby grinded weed
	{
		if ((_x getVariable ["class",""]) == "cannabis_grinded_5g") then {_allGrinded pushback _x;};
	} foreach _near;
	if (count _allGrinded < 1) exitwith {["No grinded cannabis nearby, place grinded cannabis near the scale to bag weed!","red"] call A3PL_Player_Notification;};

	//open menu
	createDialog "Dialog_BagWeed";
	_display = findDisplay 74;
	_ctrl = _display displayCtrl 1000;
	_ctrl ctrlSetText (format ["Enter a number between 5 and %1 grams and click bag to bag the marijuana!",(count _allGrinded) * 5]);

	//set eventhandler
	_ctrl = _display displayCtrl 1600;
	_ctrl buttonSetAction "[] call A3PL_JobFarming_Bag";
	A3PL_JobFarming_Scale = _scale;
}] call Server_Setup_Compile;

["A3PL_JobFarming_Bag",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	disableSerialization;
	private ["_scale","_near","_allGrinded","_display","_ctrl","_grams"];
	_scale = missionNameSpace getVariable ["A3PL_JobFarming_Scale",objNull];
	if (isNull _scale) exitwith { ["Unable to determine scale (report this bug)","red"] call A3PL_Player_Notification; };
	_near = nearestObjects [_scale, ["A3PL_Cannabis_Bud"], 2,true];
	_allGrinded = [];

	//check inputted grams
	_display = findDisplay 74;
	_ctrl = _display displayCtrl 1400;
	_grams = parseNumber (ctrlText _ctrl);
	if (!(_grams IN [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100])) exitwith {["You entered an invalid number, the number must be in steps of 5 (e.g. 5,10,15,20,25 etc.) with a maximum of 100 grams"] call A3PL_Player_Notification;};

	//check for nearby grinded weed
	{
		if ((_x getVariable ["class",""]) == "cannabis_grinded_5g") then {_allGrinded pushback _x;};
	} foreach _near;
	if ((count _allGrinded) < (_grams / 5)) exitwith {["Not enough grinded cannabis nearby to bag that amount! Remember: Every grinded piece of marijuana is 5 grams!","red"] call A3PL_Player_Notification;};

	for "_i" from 0 to (_grams / 5) do
	{
		deleteVehicle (_allGrinded select _i);
	};

	[format ["You bagged %1 grams into a marijuana bag, it's now in your inventory!",_grams],"green"] call A3PL_Player_Notification;
	[format ["weed_%1g",_grams],1] call A3PL_Inventory_Add;
	closeDialog 0;
}] call Server_Setup_Compile;