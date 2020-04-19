Config_Houses_List = [
	"Land_Home1g_DED_Home1g_01_F",
	"Land_Mansion01",
	"Land_A3PL_Ranch3",
	"Land_A3PL_Ranch2",
	"Land_A3PL_Ranch1",
	"Land_A3PL_ModernHouse1",
	"Land_A3PL_ModernHouse2",
	"Land_A3PL_ModernHouse3",
	"Land_A3PL_BostonHouse",
	"Land_A3PL_Shed3",
	"Land_A3PL_Shed4",
	"Land_A3PL_Shed2",
	"Land_John_House_Grey",
	"Land_John_House_Blue",
	"Land_John_House_Red",
	"Land_John_House_Green",
	"Land_A3PL_ModernHouse"
];
publicVariable "Config_Houses_List";

Config_Houses_Prices = [
	//Moonshien sheds
	["Land_A3PL_Shed2",40000],
	["Land_A3PL_Shed3",35000],
	["Land_A3PL_Shed4",50000],
	["Land_A3PL_BostonHouse",80000],

	//One-story without garage
	["Land_John_House_Grey",110000],
	["Land_John_House_Blue",110000],
	["Land_John_House_Red",110000],
	["Land_John_House_Green",110000],

	//One-story with garage
	["Land_A3PL_Ranch1",135000],
	["Land_A3PL_Ranch2",135000],
	["Land_A3PL_Ranch3",135000],
	
	["Land_Home1g_DED_Home1g_01_F",150000],
	["Land_Home2b_DED_Home2b_01_F",150000],
	["Land_Home4w_DED_Home4w_01_F",150000],
	["Land_Home5y_DED_Home5y_01_F",150000],

	["Land_Home3r_DED_Home3r_01_F",250000],	
	["Land_Home6b_DED_Home6b_01_F",250000],

	["Land_Mansion01",500000],
	
	["Land_A3PL_ModernHouse1",550000],
	["Land_A3PL_ModernHouse2",550000],
	["Land_A3PL_ModernHouse3",550000],

	//One-story with 2 garages
	["Land_A3PL_ModernHouse",550000]
];
publicVariable "Config_Houses_Prices";

/*
	Winston - Use this to check house types:
	tmp = (nearestObjects [getPos player,["Land_A3PL_Ranch3"],20000000]) select 0;
	player setPos (getPos tmp);
*/