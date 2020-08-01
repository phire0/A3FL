/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_JobFarming_Plant",
{
	private ["_class","_pos","_player","_plant","_plantClass","_plants","_ATLChange"];
	_player = param [0,objNull];
	_class = param [1,""];
	_pos = param [2,[]];

	if ((isNull _player) or (_class == "")) exitwith {};

	if (!([_class,1,_player] call Server_Inventory_Has)) exitwith {};

	[_player,_class,-1] call Server_Inventory_Add;
	_plantClass = "";
	_ATLChange = 0;
	switch (_class) do {
		case "seed_wheat": {_plantClass = "A3PL_Wheat";};
		case "seed_corn": {_plantClass = "A3PL_Corn";};
		case "seed_marijuana": {_plantClass = "A3PL_Cannabis";};
		case "seed_lettuce": {_plantClass = "A3PL_Lettuce"; _ATLChange = -0.15;};
		case "seed_coca": {_plantClass = "A3PL_Coco_Plant";};
		case "seed_sugar": {_plantClass = "A3PL_Sugarcane_Plant";};
	};

	if (_plantClass isEqualTo "") exitwith {};
	_plant = createVehicle [_plantClass,[_pos select 0,_pos select 1, (_pos select 2) + _ATLChange], [], 0, "CAN_COLLIDE"];
	_plant animateSource ["plant_growth",1];
	_plant allowDamage false;

	if((typeOf _plant) isEqualTo "A3PL_Cannabis") then {
		_plant setVariable ["inField",true,true];
	};
	[0] remoteExec ["A3PL_JobFarming_PlantReceive",owner _player];
},true] call Server_Setup_Compile;

["Server_JobFarming_Harvest",
{
	private ["_player","_plant","_growstate","_plants","_itemClass","_amount"];
	_player = param [0,objNull];
	_plant = param [1,objNull];
	if ((isNull _player) or (isNull _plant)) exitwith {};
	_growstate = _plant getVariable ["growState",0];

	if ((_plant animationSourcePhase "plant_growth") < 1) exitwith {[4] remoteExec ["A3PL_JobFarming_PlantReceive",owner _player];};

	if (_plant getVariable ["inuse",false]) exitwith {};
	_plant setVariable ["inuse",true,false];

	_itemClass = "";
	_seedItem = "";
	_amount = 0;
	switch (typeOf _plant) do
	{
		case "A3PL_Wheat": {_amount = 10; _itemClass = "wheat"; _seedItem = "seed_wheat";};
		case "A3PL_Corn": {_amount = 2; _itemClass = "corn"; _seedItem = "seed_corn";};
		case "A3PL_Lettuce": {_amount = 4; _itemClass = "lettuce"; _seedItem = "seed_lettuce";};
		case "A3PL_Coco_Plant": {_amount = 2; _itemClass = "coca"; _seedItem = "seed_coca";};
		case "A3PL_Sugarcane_Plant": {_amount = 2; _itemClass = "sugarcane"; _seedItem = "seed_sugar";};
		case "A3PL_Cannabis":
		{
			private _itemClass = "cannabis_bud";
			private _lightValue = _plant getVariable ["lightValue",0];
			switch (true) do
			{
				case (_plant getVariable ["inField",false]): {_amount = 40;};
				case (_lightValue > 80): {_amount = 30;};
				case (_lightValue > 50): {_amount = 20;};
				case (_lightValue > 20): {_amount = 10;};
				case default {_amount = 2;};
			};
		};
	};

	if (_itemClass isEqualTo "") exitwith {};
	if (([[[_itemClass,_amount]],_player] call Server_Inventory_TotalWeight) > 600) exitWith {[6] remoteExec ["A3PL_JobFarming_PlantReceive",owner _player];_plant setVariable ["inuse",false,false];};

	deleteVehicle _plant;
	_amount = _amount * A3PL_Event_DblHarvest;
	[_itemClass,_amount] remoteExec ["A3PL_Inventory_Add", (owner _player)];
	[5,_itemClass,_amount] remoteExec ["A3PL_JobFarming_PlantReceive",owner _player];

	if((typeOf _plant) IN ["A3PL_Wheat","A3PL_Corn","A3PL_Lettuce","A3PL_Coco_Plant","A3PL_Sugarcane_Plant"]) then {
		_chance = random(100);
		if(_chance < 35) then {
			_seedAmount = 1;
			[_seedItem, _seedAmount] remoteExec ["A3PL_Inventory_Add", (owner _player)];
		};
	};
	[getPlayerUID _player,"PickupItem",["Harvested Crop",_plant,_itemClass,_amount]] call Server_Log_New;
},true] call Server_Setup_Compile;

["Server_JobFarming_DrugDealerPos",
{
	private _object = DrugDealerHouse;
	private _areas = ["Area_DrugDealer","Area_DrugDealer1","Area_DrugDealer2","Area_DrugDealer3","Area_DrugDealer4","Area_DrugDealer5","Area_DrugDealer6","Area_DrugDealer7","Area_DrugDealer8","Area_DrugDealer9","Area_DrugDealer10","Area_DrugDealer11","Area_DrugDealer12","Area_DrugDealer13","Area_DrugDealer14"];
	private _area = _areas select (floor (random (count _areas)));
	private _pos = [_area] call CBA_fnc_randPosArea;
	private _pos = _pos findEmptyPosition [0, 25,(typeOf DrugDealerHouse)];
	if (count _pos == 0) exitwith {call Server_JobFarming_DrugDealerPos};
	if ((count (_pos nearRoads 50)) > 0) exitwith {call Server_JobFarming_DrugDealerPos};
	_object setDir (floor (random 360));
	_object setpos _pos;
	npc_drugsdealer setDir (getDir DrugDealerHouse + 90);
	npc_drugsdealer setpos (DrugDealerHouse modelToWorld [-4,-0.2,-0.4]);
	DrugDealerRelative1 setDir (getDir DrugDealerHouse);
	DrugDealerRelative1 setpos (DrugDealerHouse modelToWorld [-3,-0.2,-0.4]);
},true] call Server_Setup_Compile;
