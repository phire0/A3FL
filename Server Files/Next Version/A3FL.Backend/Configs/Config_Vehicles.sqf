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
	["A3FL",["AS_365","Nissan_GTR","Nissan_GTR_LW","Smart_Car","BMW_M6","Mercedes_Benz_AMG_C63","LCM","T370","T440","T440_Gas_Tanker","T440_Water_Tanker","T440_Tow_Truck","Explorer_Platinum_20","Explorer_Platinum_PD_20"]],
	["Heli_Medium01",["H","Luxury_H","Medic_H","Military_H","Veteran_H","Coastguard_H","Sheriff_H"]],
	["C",["Heli_Light_01_civil_F","Van_02_transport_F"]],
	["K",["Scooter_DarkBlue"]]
];
publicVariable "Config_Vehicles_Admin";

// className, trunkCapacity, vehicleMSRP
Config_Vehicles_Data = [
	["A3PL_EMS_Locker",800,10000],

	["A3PL_Fatboy",20,300000],

	["K_Scooter_DarkBlue",25,12000],
	["C_Quadbike_01_F",40,12000],

	["A3PL_VetteZR1",140,1150000],
	["A3PL_911GT2",140,1250000],
	["A3PL_Gallardo",140,1350000],

	["A3PL_Camaro",160,64000],
	["A3PL_Charger69",160,68000],
	["A3PL_Mustang",160,371000],
	["A3PL_Mustang_PD",160,371000],
	["A3PL_Mustang_PD_Slicktop",160,371000],
	["A3PL_BMW_M3",160,98000],
	["A3PL_Challenger_Hellcat",160,400000],
	["A3PL_CLS63",160,173000],

	["A3PL_CRX",180,45000],
	["A3PL_CVPI_Rusty",180,12000],
	["A3PL_CVPI",180,45000],
	["A3PL_CVPI_Taxi",180,35000],
	["A3PL_CVPI_PD",180,45000],
	["A3PL_CVPI_PD_Slicktop",180,45000],
	["A3PL_Charger",180,270000],
	["A3PL_Charger_PD",180,270000],
	["A3PL_Charger_PD_Slicktop",180,270000],
	["A3PL_Charger15",180,323000],
	["A3PL_Charger15_PD",180,323000],
	["A3PL_Charger15_PD_ST",180,323000],
	["A3PL_Charger15_FD",180,323000],
	["A3PL_Monster",180,637000],
	["A3PL_Taurus",180,66000],
	["A3PL_Taurus_PD",180,66000],
	["A3PL_Taurus_PD_ST",180,66000],
	["A3PL_Taurus_FD",180,66000],

	["A3PL_P362",500,165000],
	["A3PL_P362_TowTruck",500,105000],

	["A3PL_Wrangler",240,50000],
	["A3PL_BMW_X5",240,257000],
	["A3PL_Urus",240,870000],
	["A3PL_MailTruck",240,48000],

	["A3PL_Ram",550,50000],
	["A3PL_Rover",550,310000],

	["A3PL_Tahoe",630,98000],
	["A3PL_Tahoe_FD",620,98000],
	["A3PL_Tahoe_PD",620,98000],
	["A3PL_Tahoe_PD_Slicktop",620,98000],
	["A3PL_Raptor",620,130000],
	["A3PL_Raptor_PD",620,130000],
	["A3PL_Raptor_PD_ST",620,130000],
	["A3PL_F150",620,130000],
	["A3PL_F150_Marker",620,130000],

	["A3PL_Suburban",660,98000],
	["C_Van_02_transport_F",660,105000],
	["A3PL_Silverado",660,170000],
	["A3PL_Silverado_PD",660,170000],
	["A3PL_Silverado_PD_ST",660,170000],
	["A3PL_Silverado_FD",660,170000],
	["A3PL_Silverado_FD_Brush",660,170000],
	["A3PL_E350",660,45000],
	["jonzie_ambulance",660,60000],

	["A3PL_MiniExcavator",150,120000],

	["A3PL_Pierce_Ladder",800,75000],
	["A3PL_Pierce_Heavy_Ladder",800,80000],
	["A3PL_Pierce_Pumper",400,80000],
	["A3PL_Pierce_Rescue",800,80000],

	["A3FL_T370",1450,200000],
	["A3FL_T440",2000,250000],
	["A3FL_T440_Tow_Truck",1000,155000],
	["A3FL_T440_Gas_Tanker",1000,140000],

	["A3PL_Box_Trailer",950,35000],

	["C_Scooter_Transport_01_F",40,6000],
	["A3PL_RHIB",80,37000],
	["A3PL_Motorboat",160,5000],
	["A3PL_Motorboat_Rescue",160,10000],
	["A3PL_RBM",200,35000],
	["A3PL_Patrol",320,50000],
	["A3PL_Yacht",800,1000000],

	["Heli_Medium01_H",100,1400000],
	["Heli_Medium01_Military_H",100,1800000],
	["Heli_Medium01_Veteran_H",100,1800000],
	["Heli_Medium01_Luxury_H",100,1800000],
	["Heli_Medium01_Medic_H",100,1800000],
	["Heli_Medium01_Coastguard_H",100,1800000],
	["A3PL_Jayhawk",40,50000],
	["A3FL_AS_365",40,65000],
	["A3PL_Cessna172",60,380000],
	["A3PL_Goose_Base",80,760000],
	["A3PL_Goose_USCG",80,665000],

	["A3FL_Nissan_GTR",220,310000],
	["A3FL_Nissan_GTR_LW",250,400000],
	["A3FL_Smart_Car",150,45000],
	["A3FL_BMW_M6",250,371000],
	["A3FL_Mercedes_Benz_AMG_C63",250,310000]
];
publicVariable "Config_Vehicles_Data";

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
	"A3PL_Charger15_FD",
	"A3FL_Explorer_Platinum_PD_20"
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