/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

Config_Vehicles_Admin = [
	["A3PL_Drill",["Trailer"]],
	["A3PL_Tanker",["Trailer"]],
	["A3PL_Small_Boat",["Trailer"]],
	["A3PL_Box",["Trailer"]],
	["Jonzie",["Ambulance"]],
	["A3PL_Pierce",["Ladder","Pumper","Heavy_Ladder","Rescue"]],
	["A3PL_BMW",["X5","M3"]],
	["A3PL",["Silverado","Silverado_PD","Silverado_PD_ST","Silverado_FD","Silverado_FD_Brush","911GT2","Charger15","Charger15_PD","Charger15_PD_ST","Charger15_FD","Charger69","VetteZR1","Mailtruck","Gallardo","Cessna172","Lowloader","Mustang","Mustang_PD","Mustang_PD_Slicktop","F150","F150_Marker","F150_Marker_PD","Ram","Wrangler","Charger","E350","Tahoe_FD","Tahoe_PD","Tahoe_PD_Slicktop","Tahoe","CVPI","CVPI_Taxi","CVPI_PD","CVPI_PD_Slicktop","Charger_PD","Charger_PD_Slicktop","P362","P362_TowTruck","P362_Garbage_Truck","Rover","Camaro","RBM","Motorboat","RHIB","Fuel_Van","MiniExcavator","CRX","Challenger_Hellcat","Car_Trailer","Yacht","Yacht_Pirate","Challenger_Hellcat","Gallardo","Suburban","CLS63","Fatboy","1100R","Knucklehead","Monster","Kx","Urus","Cessna172","Goose_Base","Goose_USCG","Jayhawk","Taurus","Taurus_PD","Taurus_PD_ST","Taurus_FD","Raptor","Raptor_PD","Raptor_PD_ST"]],
	["A3FL",["AS_365","Nissan_GTR","Nissan_GTR_LW","Smart_Car","BMW_M6","Mercedes_Benz_AMG_C63","LCM","T370","T440","T440_Tow_Truck","T440_Cab_Chassis_Truck"]],
	["Heli_Medium01",["H","Luxury_H","Medic_H","Military_H","Veteran_H","Coastguard_H","Sheriff_H"]],
	["C",["Heli_Light_01_civil_F","Van_02_transport_F"]],
	["K",["Scooter_DarkBlue"]]
];
publicVariable "Config_Vehicles_Admin";

Config_Vehicles_Capacity = [
	["A3PL_EMS_Locker",800],

	["A3PL_Fatboy",20],

	["K_Scooter_DarkBlue",25],
	["C_Quadbike_01_F",40],

	["A3PL_VetteZR1",140],
	["A3PL_911GT2",140],
	["A3PL_Gallardo",140],

	["A3PL_Camaro",160],
	["A3PL_Charger69",160],
	["A3PL_Mustang",160],
	["A3PL_Mustang_PD",160],
	["A3PL_Mustang_PD_Slicktop",160],
	["A3PL_BMW_M3",160],
	["A3PL_Challenger_Hellcat",160],
	["A3PL_CLS63",160],

	["A3PL_CRX",180],
	["A3PL_CVPI_Rusty",180],
	["A3PL_CVPI",180],
	["A3PL_CVPI_Taxi",180],
	["A3PL_CVPI_PD",180],
	["A3PL_CVPI_PD_Slicktop",180],
	["A3PL_Charger",180],
	["A3PL_Charger_PD",180],
	["A3PL_Charger_PD_Slicktop",180],
	["A3PL_Charger15",180],
	["A3PL_Charger15_PD",180],
	["A3PL_Charger15_PD_ST",180],
	["A3PL_Charger15_FD",180],
	["A3PL_Monster",180],
	["A3PL_Taurus",180],
	["A3PL_Taurus_PD",180],
	["A3PL_Taurus_PD_ST",180],
	["A3PL_Taurus_FD",180],

	["A3PL_P362",500],
	["A3PL_P362_TowTruck",500],

	["A3PL_Wrangler",240],
	["A3PL_BMW_X5",240],
	["A3PL_Urus",240],
	["A3PL_MailTruck",240],

	["A3PL_Ram",550],
	["A3PL_Rover",550],

	["A3PL_Tahoe",630],
	["A3PL_Tahoe_FD",620],
	["A3PL_Tahoe_PD",620],
	["A3PL_Tahoe_PD_Slicktop",620],
	["A3PL_Raptor",620],
	["A3PL_Raptor_PD",620],
	["A3PL_Raptor_PD_ST",620],
	["A3PL_F150",620],
	["A3PL_F150_Marker",620],

	["A3PL_Suburban",660],
	["C_Van_02_transport_F",660],
	["A3PL_Silverado",660],
	["A3PL_Silverado_PD",660],
	["A3PL_Silverado_PD_ST",660],
	["A3PL_Silverado_FD",660],
	["A3PL_Silverado_FD_Brush",660],
	["A3PL_E350",660],
	["jonzie_ambulance",660],

	["A3PL_MiniExcavator",150],

	["A3PL_Pierce_Ladder",800],
	["A3PL_Pierce_Heavy_Ladder",800],
	["A3PL_Pierce_Pumper",400],
	["A3PL_Pierce_Rescue",800],

	["A3FL_T370",1450],
	["A3FL_T440",2000],
	["A3FL_T440_Tow_Truck",1000],

	["A3PL_Box_Trailer",950],

	["C_Scooter_Transport_01_F",40],
	["A3PL_RHIB",80],
	["A3PL_Motorboat",160],
	["A3PL_Motorboat_Rescue",160],
	["A3PL_RBM",200],
	["A3PL_Patrol",320],
	["A3PL_Yacht",800],

	["Heli_Medium01_H",100],
	["Heli_Medium01_Military_H",100],
	["Heli_Medium01_Veteran_H",100],
	["Heli_Medium01_Luxury_H",100],
	["Heli_Medium01_Medic_H",100],
	["Heli_Medium01_Coastguard_H",100],
	["A3PL_Jayhawk",40],
	["A3FL_AS_365",40],
	["A3PL_Cessna172",60],
	["A3PL_Goose_Base",80],
	["A3PL_Goose_USCG",80],

	["A3FL_Nissan_GTR",220],
	["A3FL_Nissan_GTR_LW",250],
	["A3FL_Smart_Car",150],
	["A3FL_BMW_M6",250],
	["A3FL_Mercedes_Benz_AMG_C63",250]
];
publicVariable "Config_Vehicles_Capacity";

Config_Police_Vehs = [
	"A3PL_Engine",
	"A3PL_Ladder",
	"Jonzie_Ambulance",
	"A3PL_CVPI_PD",
	"A3PL_CVPI_PD_Slicktop",
	"A3PL_Pierce_Ladder",
	"A3PL_Pierce_Heavy_Ladder",
	"A3PL_Tahoe_FD",
	"A3PL_Tahoe_PD",
	"A3PL_Tahoe_PD_Slicktop",
	"A3PL_Mustang_PD",
	"A3PL_Mustang_PD_Slicktop",
	"A3PL_Charger_PD",
	"A3PL_Charger_PD_Slicktop",
	"A3PL_Pierce_Pumper",
	"A3PL_P362_TowTruck",
	"A3PL_RBM",
	"A3PL_F150_Marker",
	"A3PL_Silverado_PD",
	"A3PL_VetteZR1_PD",
	"A3PL_E350",
	"A3PL_Pierce_Rescue",
	"A3PL_Raptor_PD",
	"A3PL_Raptor_PD_ST",
	"A3PL_Taurus_PD",
	"A3PL_Taurus_PD_ST",
	"A3PL_Silverado_FD",
	"A3PL_Silverado_FD_Brush",
	"A3PL_Silverado_PD_ST",
	"A3PL_Taurus_FD",
	"A3PL_Charger15_PD",
	"A3PL_Charger15_PD_ST",
	"A3PL_Charger15_FD"
];
publicVariable "Config_Police_Vehs";

Config_Arma_Vehs = [
	"C_Van_02_medevac_F",
	"C_Van_02_service_F",
	"C_Van_02_transport_F",
	"I_C_Van_02_transport_F",
	"C_Van_02_vehicle_F",
	"I_G_Van_02_transport_F",
	"C_IDAP_Van_02_vehicle_F",
	"C_IDAP_Van_02_transport_F",
	"C_Offroad_02_unarmed_white_F",
	"C_Offroad_02_unarmed_red_F",
	"C_Offroad_02_unarmed_orange_F",
	"C_Offroad_02_unarmed_green_F",
	"C_Offroad_02_unarmed_F",
	"C_Offroad_02_unarmed_blue_F",
	"C_Offroad_02_unarmed_black_F"
];
publicVariable "Config_Arma_Vehs";

Config_Vehicles_MSRP = [
	["A3PL_Fatboy",300000],
	["K_Scooter_DarkBlue",12000],
	["C_Quadbike_01_F",12000],

	["A3PL_VetteZR1",1150000],
	["A3PL_911GT2",1250000],
	["A3PL_Gallardo",1350000],

	["A3PL_Camaro",64000],
	["A3PL_Charger69",68000],
	["A3PL_Mustang",371000],
	["A3PL_Mustang_PD",371000],
	["A3PL_Mustang_PD_Slicktop",371000],
	["A3PL_BMW_M3",98000],
	["A3PL_Challenger_Hellcat",400000],
	["A3PL_CLS63",173000],

	["A3PL_CRX",45000],
	["A3PL_CVPI_Rusty",12000],
	["A3PL_CVPI",45000],
	["A3PL_CVPI_Taxi",35000],
	["A3PL_CVPI_PD",45000],
	["A3PL_CVPI_PD_Slicktop",45000],
	["A3PL_Taurus",66000],
	["A3PL_Taurus_PD",66000],
	["A3PL_Taurus_PD_ST",66000],
	["A3PL_Taurus_FD",66000],
	["A3PL_Charger",270000],
	["A3PL_Charger_PD",270000],
	["A3PL_Charger_PD_Slicktop",270000],
	["A3PL_Charger15",323000],
	["A3PL_Charger15_PD",323000],
	["A3PL_Charger15_PD_ST",323000],
	["A3PL_Monster",637000],

	["A3PL_Fuel_Van",70000],
	["A3PL_Car_Trailer",27000],
	["A3PL_Small_Boat_Trailer",12000],
	["A3PL_Lowloader",35000],
	["A3PL_Drill_Trailer",21000],
	["A3PL_Tanker_Trailer",35000],
	["A3PL_MiniExcavator",120000],
	["A3PL_P362_TowTruck",105000],
	["A3PL_P362",165000],
	["A3PL_1100R",325000],
	["A3PL_Knucklehead",300000],
	["A3PL_Kx",102000],

	["A3PL_Wrangler",50000],
	["A3PL_BMW_X5",257000],
	["A3PL_Urus",870000],
	["A3PL_MailTruck",48000],

	["A3PL_Ram",50000],
	["A3PL_Rover",310000],

	["A3PL_Tahoe",98000],
	["A3PL_Tahoe_FD",98000],
	["A3PL_Tahoe_PD",98000],
	["A3PL_Tahoe_PD_Slicktop",98000],
	["A3PL_F150",130000],
	["A3PL_F150_Marker",130000],
	["A3PL_Raptor",130000],
	["A3PL_Raptor_PD",130000],
	["A3PL_Raptor_PD_ST",130000],

	["A3PL_Suburban",98000],
	["C_Van_02_transport_F",105000],
	["A3PL_Silverado",170000],
	["A3PL_Silverado_PD",170000],
	["A3PL_E350",45000],
	["jonzie_ambulance",60000],

	["A3PL_Pierce_Ladder",75000],
	["A3PL_Pierce_Heavy_Ladder",80000],
	["A3PL_Pierce_Pumper",80000],
	["A3PL_Pierce_Rescue",80000],

	["A3FL_T370",200000],
	["A3FL_T440",250000],
	["A3FL_T440_Tow_Truck",155000],
	["A3PL_Box_Trailer",35000],

	["C_Scooter_Transport_01_F",6000],
	["A3PL_RHIB",37000],
	["A3PL_Motorboat",5000],
	["A3PL_Motorboat_Rescue",10000],
	["A3PL_RBM",35000],
	["A3PL_Patrol",50000],
	["A3FL_LCM",95000],
	["A3PL_Yacht",1000000],

	["Heli_Medium01_H",1400000],
	["Heli_Medium01_Military_H",1800000],
	["Heli_Medium01_Veteran_H",1800000],
	["Heli_Medium01_Luxury_H",1800000],
	["Heli_Medium01_Medic_H",1800000],
	["Heli_Medium01_Coastguard_H",185000],
	["A3PL_Jayhawk",50000],
	["A3FL_AS_365",65000],
	["A3PL_Cessna172",380000],
	["A3PL_Goose_Base",760000],
	["A3PL_Goose_USCG",665000],

	["A3FL_Nissan_GTR",310000],
	["A3FL_Nissan_GTR_LW",400000],
	["A3FL_Smart_Car",45000],
	["A3FL_BMW_M6",371000],
	["A3FL_Mercedes_Benz_AMG_C63",310000]
];
publicVariable "Config_Vehicles_MSRP";