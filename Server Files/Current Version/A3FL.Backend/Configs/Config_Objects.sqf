/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

Config_Objects_Bargates = [
	//[POSITION,FACTIONS ARRAY]
	[[6252.59,7698.81],["fisd","fifr","uscg","usms"]],		//ELK TRAINING
	[[2168.32,5059.27],["fisd","fifr","uscg"]],		//CG BASE FRONT GATE
	[[4445.29,7055.45],["fifr","uscg","fisd"]],		//FIFR TRAINING
	[[2252.52,5128.71,0],["uscg"]],					//CG BASE - AIRFIELD SIDE
	[[10662.2,8919.53,0],["uscg","fifr"]],			//NORTHDALE AIRFIELD
	[[2601.23,5435.68,0],["fisd","uscg","fifr"]],	//SILVERTON SD
	[[1836,11365,0],["fifr","fisd","uscg","usms"]], //Northern Island CG base
	[[2049,11709,0],["fifr","fisd","uscg","usms"]], //Northern Island SD


	//DOC GATES
	[[4746.49,6107.14,0],["uscg","fisd","fifr","usms"]],
	[[4746.49,6142.68,0],["uscg","fisd","fifr","usms"]],
	[[4770.91,6140.22,0],["uscg","fisd","fifr","usms"]],
	[[4770.93,6104.82,0],["uscg","fisd","fifr","usms"]]
];
publicVariable "Config_Objects_Bargates";

Config_Items_ZOffset =
[
	["John_Sofa",0,0],
	["Land_BottlePlastic_V2_F",0.02,0],
	["A3PL_RoadBarrier",0.5,0],
	["A3PL_PlasticBarrier_01",0.3,0],
	["A3PL_PlasticBarrier_02",0.5,0],
	["A3PL_Suitcase",0.25,0],
	["Roadcone_F",0.25,0],
	["A3PL_Handcuffs",0,0],
	["A3PL_Spikes_Closed",0.02,0],
	["A3PL_Burger_Bun",0.045,0],
	["A3PL_Burger_Full",0.045,0],
	["A3PL_BucketFull",0.2,0],
	["A3PL_Bucket",0.2,0],
	["A3PL_FishingBuoy",0.18,0],
	["A3PL_DeliveryBox",0.11,0],
	["A3PL_Salad",0.02,0],
	["A3PL_TacoShell",0.065,0],
	["A3PL_Fish_Raw",0.01,0],
	["A3PL_Fish_Cooked",0.01,0],
	["A3PL_Fish_Burned",0.01,0],
	["GroundWeaponHolder",0.7,0],
	["A3PL_OilBarrel",0.44,0],
	["A3PL_FD_yAdapter",0.04,0],
	["A3PL_FD_HoseEnd_Player",0.07,0],
	["A3PL_FD_HoseRolled",0.35,0],
	["A3PL_FD_Mask_Obj",-0.55,0],
	["A3PL_Bookshelf",1.02,0],
	["A3PL_Bed3",0.5,0],
	["A3PL_DiningChair",0.65,0],
	["A3PL_DiningTableProps",0.52,0],
	["A3PL_Bar_Cabinet",0.76,0],
	["A3PL_Kennel",0.5,0],
	["A3PL_NightStandLamp",0.31,0],
	["A3PL_CabinetDoubleTop",0.34,0],
	["A3PL_CabinetSingleTop",0.34,0],
	["A3PL_CabinetTopCorner",0.34,0],
	["A3PL_CounterCorner",0.5,0],
	["A3PL_CounterDoubleCabinet",0.5,0],
	["A3PL_CounterDrawer",0.16,0],
	["A3PL_CounterSingleCabinet",0.34,0],
	["A3PL_CounterTop1",0.54,0],
	["A3PL_CounterTop2",0.34,0],
	["A3PL_CounterTop3",0.34,0],
	["A3PL_SinkBigCounter",0.65,0],
	["A3PL_SinkSingleCabinet",0.65,0],
	["A3PL_Bed1",0.5,0],
	["A3PL_Bed2",0.5,0],
	["A3PL_Chair1",0.5,0],
	["A3PL_Chair2",0.5,0],
	["A3PL_Chair3",0.5,0],
	["A3PL_Chair4",0.5,0],
	["A3PL_Cabinet1",1,0],
	["A3PL_Cabinet2",1,0],
	["A3PL_Cabinet3",1,0],
	["A3PL_coffeeTable1",0.15,0],
	["A3PL_coffeeTable2",0.15,0],
	["A3PL_coffeeTable3",0.15,0],
	["A3PL_coffeeTable4",0.2,0],
	["A3PL_CornerSova",0.35,0],
	["A3PL_DryingTowel",0.2,0.8],
	["A3PL_Flasket",0.45,0],
	["A3PL_KitchenChair1",0.45,0],
	["A3PL_KitchenChair2",0.45,0],
	["A3PL_KitchenShelf1",0.35,2.1],
	["A3PL_KitchenShelf2",0.35,2.1],
	["A3PL_KitchenShelf3",0.35,2.1],
	["A3PL_KitchenShelfCorner",0.35,2.1],
	["A3PL_KitchenTable1",0.4,0],
	["A3PL_KitchenTable2",0.4,0],
	["A3PL_Lamp1",0.74,0],
	["A3PL_Lamp2",0.74,0],
	["A3PL_ModularKitchen1",0.4,0],
	["A3PL_ModularKitchen2",0.4,0],
	["A3PL_ModularKitchen3",0.4,0],
	["A3PL_ModularKitchen4",0.4,0],
	["A3PL_Rack1",0.75,0],
	["A3PL_Rack2",0.75,0],
	["A3PL_Pouf",0.2,0],
	["A3PL_Sofa1",0.35,0],
	["A3PL_Sofa2",0.35,0],
	["A3PL_Sofa3",0.35,0],
	["A3PL_Sofa4",0.35,0],
	["A3PL_Table1",0.4,0],
	["A3PL_Table2",0.4,0],
	["A3PL_tvtable1",0.3,0],
	["A3PL_tvtable2",0.3,0],
	["A3PL_tvtable3",0.2,0],
	["A3PL_mirror",0.25,1.5],
	["A3PL_Pumpjack",0.75,0],
	["A3PL_RoadCone_x10",0.25,0],
	["A3PL_RoadCone",0.2,0],
	["A3PL_Polyester",0.1,0],
	["A3PL_LPG",0.75,0],
	["A3PL_Kerosene",0.4,0],
	["A3PL_CanisterOil",0.07,0],
	["A3PL_Money",-0.05,0],
	["A3PL_Wrench",-0.01,0],
	["A3PL_Bandage",0.01,0],
	["A3PL_Medical_Icepack",-0.05,0],
	["A3PL_Medical_Splint",-0.05,0],
	["A3PL_Medical_Cast",-0.03,0],
	["A3PL_Medical_Endotracheal",-0.05,0],
	["A3PL_PainKillers",-0.025,0],
	["A3PL_Medical_Kit",-0.05,0],
	["A3PL_Medical_OxygenMask",-0.05,0],
	["A3PL_BloodBag",-0.05,0],
	["A3PL_Planter2",0.23,0],
	["A3PL_WorkBench",0.4,0],
	["A3FL_Table",0.4,0],
	["A3PL_Cannabis_Lamp_200W",0.66,0],
	["A3PL_Cannabis_Lamp_500W",0.66,0],
	["A3PL_Cannabis_Lamp_1000W",0.66,0],
	["A3PL_Fan",0.55,0],
	["A3PL_Mixer",0.3,0],
	["A3PL_Scale",0.04,0],
	["A3PL_Pavilion",1.2,0],
	["A3PL_Cannabis_Bud",0.01,0],
	["A3PL_MarijuanaBag",0.1,0],
	["A3PL_WoodenLog",0.22,0],
	["A3PL_Distillery",1,0],
	["A3PL_Distillery_Hose",0.5,0],
	["A3PL_Jug",0.13,0],
	["A3PL_Jug_Corked",0.13,0],
	["A3PL_Jug_Green",0.13,0],
	["A3PL_Jug_Green_Corked",0.13,0],
	["A3PL_Grainsack_Malt",0.07,0],
	["A3PL_Grainsack_Yeast",0.07,0],
	["A3PL_Grainsack_CornMeal",0.07,0],
	["A3PL_Gamer_BilliardTable",0.5,0],
	["A3PL_Gamer_Dartboard",0.5,2],
	["A3PL_Gamer_Galaga",0.5,0],
	["A3PL_Gamer_LCD",0.5,0],
	["A3PL_Gamer_UnicornFloat",0.5,0],
	["A3PL_Garden_StatueGod",0.5,0],
	["A3PL_Garden_StatueGod2",0.5,0],
	["A3PL_Garden_StatueGod3",0.5,0],
	["A3PL_Garden_StatueGod4",0.5,0],
	["A3PL_Garden_StatueMonk",0.5,0],
	["A3PL_Garden_StatueViking",0.5,0],
	["A3PL_Garden_StatueViking2",0.5,0],
	["A3PL_Garden_StatueWoman",0.5,0],
	["A3PL_Garden_StatueWoman2",0.5,0],
	["A3PL_Garden_StatueWoman3",0.5,0],
	["A3PL_Garden_Campfire",0.5,0],
	["A3PL_Garden_Treebench",0.5,0],
	["A3PL_Garden_VinesLarge",0.5,1.2],
	["A3PL_Garden_VinesMedium",0.5,1.1],
	["A3PL_Garden_VinesSmall",0.5,0.9],
	["A3PL_Mancave_Bearhead",0.5,2],
	["A3PL_Mancave_DeerAntlers",0.5,1.7],
	["A3PL_Mancave_FoxHead",0.5,2],
	["A3PL_Mancave_MooseHead",0.5,2],
	["A3PL_Mancave_Wolfhead",0.5,2],
	["A3PL_Mancave_CocktailSign",0.5,1.6],
	["A3PL_Mancave_CosmeticMoney1",0.5,0],
	["A3PL_Mancave_CosmeticMoney2",0.5,0],
	["A3PL_Mancave_GhostbusterSign",0.5,1.6],
	["A3PL_Mancave_Globe",0.5,0],
	["A3PL_WallDecor_WallPanel1",0.5,2],
	["A3PL_WallDecor_WallPanel2",0.5,2],
	["A3PL_WallDecor_WallPanel3",0.5,2],
	["A3PL_WallDecor_WallPanel4",0.5,2],
	["A3PL_WallDecor_WallPanel5",0.5,2],
	["A3PL_WallDecor_WallPanel6",0.5,2],
	["A3PL_WallDecor_WallPanel7",0.5,2],
	["A3PL_WallDecor_WallPanel8",0.5,2],
	["A3PL_WallDecor_WallPanel9",0.5,2],
	["A3PL_WallDecor_WallPanel10",0.5,2],
	["A3PL_WallDecor_WallPanel11",0.5,2],
	["A3PL_WallDecor_WallPanel12",0.5,2],
	["A3PL_WallDecor_WallPanel13",0.5,2],
	["A3PL_WallDecor_WallPanel14",0.5,2],
	["A3PL_WallDecor_WallPanel15",0.5,1.85],
	["A3PL_Winchester_AntiqueChair",0.5,0],
	["A3PL_Winchester_AntiqueDesk",0.5,0],
	["A3PL_Winchester_ArmChair",0.5,0],
	["A3PL_Winchester_Bed1",0.5,0],
	["A3PL_Winchester_Bed2",0.5,0],
	["A3PL_Winchester_Bedside",0.5,0],
	["A3PL_Winchester_Chair1",0.5,0],
	["A3PL_Winchester_Chair2",0.5,0],
	["A3PL_Winchester_ChestDrawers",0.5,0],
	["A3PL_Winchester_ChestDrawers2",0.5,0],
	["A3PL_Winchester_ChestDrawers3",0.5,0],
	["A3PL_Winchester_ChestDrawers4",0.5,0],
	["A3PL_Winchester_ChestDrawers5",0.5,0],
	["A3PL_Winchester_ChestDrawers6",0.5,0],
	["A3PL_Winchester_ChestDrawers7",0.5,0],
	["A3PL_Winchester_ChestDrawers8",0.5,0],
	["A3PL_Winchester_ChestDrawers9",0.5,0],
	["A3PL_Winchester_Floorlamp",0.5,0],
	["A3PL_Winchester_Floorlamp2",0.5,0],
	["A3PL_Winchester_Floorlamp3",0.5,0],
	["A3PL_Winchester_Wardrobe",0.5,0],
	["A3PL_Winchester_Drawers",0.5,0],
	["A3PL_Winchester_WineBottles",0.5,0]
];
publicVariable "Config_Items_ZOffset";

Config_Placeables = [
	"GroundWeaponHolder","RoadCone_F","A3PL_Spikes_Closed","A3PL_Spikes_Open","A3PL_Ski_Base","A3PL_RoadBarrier","A3PL_PlasticBarrier_01","A3PL_PlasticBarrier_02","A3PL_WheelieBin"
];
Config_Furniture = [
	"A3PL_WorkBench","A3FL_Table","John_Sofa","A3PL_Chair1","A3PL_Chair2","A3PL_Chair3","A3PL_Chair4","A3PL_Bed1","A3PL_Bed2","A3PL_Cabinet1","A3PL_Cabinet2","A3PL_Cabinet3","A3PL_coffeeTable1","A3PL_coffeeTable2","A3PL_coffeeTable3","A3PL_coffeeTable4","A3PL_CornerSova","A3PL_DryingTowel","A3PL_Flasket","A3PL_KitchenChair1","A3PL_KitchenChair2","A3PL_KitchenShelf1","A3PL_KitchenShelf2","A3PL_KitchenShelf3","A3PL_KitchenShelfCorner","A3PL_KitchenTable1","A3PL_KitchenTable2","A3PL_Lamp1","A3PL_Lamp2","A3PL_Mirror","A3PL_ModularKitchen1","A3PL_ModularKitchen2","A3PL_ModularKitchen3","A3PL_ModularKitchen4","A3PL_Pouf","A3PL_Rack1","A3PL_Rack2","A3PL_Sofa1","A3PL_Sofa2","A3PL_Sofa3","A3PL_Sofa4","A3PL_table1","A3PL_table2","A3PL_TvTable1","A3PL_TvTable2","A3PL_TvTable3","A3PL_Bed3","A3PL_Bar_Cabinet","A3PL_Bookshelf","A3PL_DiningChair","A3PL_DiningTableProps","A3PL_Kennel","A3PL_NightStand","A3PL_NightStandLamp","A3PL_Sofa1New","A3PL_Sofa3New","A3PL_Mcfisher_Grill","A3PL_CabinetDoubleTop","A3PL_CabinetSingleTop","A3PL_CabinetTopCorner","A3PL_CounterCorner","A3PL_CounterDoubleCabinet","A3PL_CounterDrawer","A3PL_CounterSingleCabinet","A3PL_CounterTop1","A3PL_CounterTop2","A3PL_CounterTop3","A3PL_SinkBigCounter","A3PL_SinkSingleCabinet"
];
{
	Config_Placeables pushback _x;
} foreach Config_Furniture;
publicVariable "Config_Placeables";

Config_Furniturep3d = [
	"John_Sofa","a3pl_box","a3pl_oilbarrel","pump","a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3"
];
publicVariable "Config_Furniturep3d";

Config_CarFurnitureBlacklist =
[
	["A3PL_WorkBench",[]],
	["A3PL_Small_Boat_Trailer",[]],
	["A3PL_Boat_Trailer",[]],
	["A3PL_Car_Trailer",[]],
	["A3PL_Lowloader",[]],
	["A3PL_Box_Trailer",[]],
	["A3PL_EMS_Locker",[]],
	["A3PL_BMW_X5",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_Camaro",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_CVPI",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_CVPI_Taxi",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_F150",[
		"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3"
		]
	],
	["A3PL_F150_Marker",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3"
		]
	],
	["A3PL_Gallardo",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_Ram",[
		"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3"
		],
	15],
	["A3PL_Rover",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_VetteZR1",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_Wrangler",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_Charger",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_Charger_PD_Slicktop",[

			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_Tahoe",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_BMW_M3",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_Mustang",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_Mustang_PD",[
		"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_Mustang_PD_Slicktop",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_911GT2",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_Charger69",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_CRX",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_Silverado",[
			"a3pl_bed1","a3pl_bed2"
		]
	],
	["A3PL_Challenger_Hellcat",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump","a3pl_mcfisher_grill"
		]
	],
	["A3PL_MailTruck",[
			"a3pl_bed1","a3pl_bed2","a3pl_brush","a3pl_cabinet1","a3pl_cabinet2","a3pl_cabinet3","a3pl_chair1","a3pl_chair2","a3pl_chair3","a3pl_chair4","a3pl_coffeetable1","a3pl_coffeetable2","a3pl_coffeetable3","a3pl_coffeetable4","a3pl_cornersova","a3pl_dryingtowel","a3pl_flasket","a3pl_kitchenchair1","a3pl_kitchenchair2","a3pl_kitchenshelf1","a3pl_kitchenshelf2","a3pl_kitchenshelf3","a3pl_kitchenshelfcorner","a3pl_kitchentable1","a3pl_kitchentable2","a3pl_lamp1","a3pl_lamp2","a3pl_mirror","a3pl_modularkitchen1","a3pl_modularkitchen2","a3pl_modularkitchen3","a3pl_modularkitchen4","a3pl_pouf","a3pl_rack1","a3pl_rack2","a3pl_sofa1","a3pl_sofa2","a3pl_sofa3","a3pl_sofa4","a3pl_table1","a3pl_table2","a3pl_tvtable1","a3pl_tvtable2","a3pl_tvtable3","a3pl_steel_pellet","a3pl_aluminium_pellet","a3pl_titanium_pellet","a3pl_coal_ingot_pellet","a3pl_iron_ingot_pellet","a3pl_titanium_ingot_pellet","a3pl_oilbarrel","pump"
		]
	]
];
publicVariable "Config_CarFurnitureBlacklist";
