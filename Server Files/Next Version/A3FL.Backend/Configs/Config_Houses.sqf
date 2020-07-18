/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

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
	"Land_A3FL_Mansion",
	"Land_A3FL_Office_Building",
	"Land_Home4w_DED_Home4w_01_F",
	"Land_Home3r_DED_Home3r_01_F",
	"Land_Home6b_DED_Home6b_01_F",
	"Land_Home5y_DED_Home5y_01_F",
	"Land_Home1g_DED_Home1g_01_F",
	"Land_Home2b_DED_Home2b_01_F",
	"Land_A3FL_House1_Cream",
	"Land_A3FL_House1_Green",
	"Land_A3FL_House1_Blue",
	"Land_A3FL_House1_Brown",
	"Land_A3FL_House1_Yellow",
	"Land_A3FL_House2_Cream",
	"Land_A3FL_House2_Green",
	"Land_A3FL_House2_Blue",
	"Land_A3FL_House2_Brown",
	"Land_A3FL_House2_Yellow",
	"Land_A3FL_House3_Cream",
	"Land_A3FL_House3_Green",
	"Land_A3FL_House3_Blue",
	"Land_A3FL_House3_Brown",
	"Land_A3FL_House3_Yellow",
	"Land_A3FL_House4_Cream",
	"Land_A3FL_House4_Green",
	"Land_A3FL_House4_Blue",
	"Land_A3FL_House4_Brown",
	"Land_A3FL_House4_Yellow",
	"Land_A3FL_Anton_Modern_Bungalow"
];
publicVariable "Config_Houses_List";

Config_Houses = [
	//Moonshine sheds
	["Land_A3PL_Shed2",40000,50,250,5],
	["Land_A3PL_Shed3",35000,50,250,5],
	["Land_A3PL_Shed4",50000,50,250,5],
	["Land_A3PL_BostonHouse",80000,50,250,6],

	//One-story without garage
	["Land_John_House_Grey",110000,100,600,7],
	["Land_John_House_Blue",110000,100,600,7],
	["Land_John_House_Red",110000,100,600,7],
	["Land_John_House_Green",110000,100,600,7],

	//One-story with garage
	["Land_A3PL_Ranch1",135000,150,800,8],
	["Land_A3PL_Ranch2",135000,150,800,8],
	["Land_A3PL_Ranch3",135000,150,800,8],

	["Land_Home4w_DED_Home4w_01_F",150000,180,1000,8],
	["Land_Home1g_DED_Home1g_01_F",150000,180,1000,8],
	["Land_Home2b_DED_Home2b_01_F",150000,180,1000,8],
	["Land_Home5y_DED_Home5y_01_F",150000,180,1000,8],

	//One-story ranch
	["Land_A3FL_House2_Cream",150000,100,550,9],
	["Land_A3FL_House2_Green",150000,100,550,9],
	["Land_A3FL_House2_Blue",150000,100,550,9],
	["Land_A3FL_House2_Brown",150000,100,550,9],
	["Land_A3FL_House2_Yellow",150000,100,550,9],

	//One-story Small L-Shape
	["Land_A3FL_House4_Cream",160000,110,625,10],
	["Land_A3FL_House4_Green",160000,110,625,10],
	["Land_A3FL_House4_Blue",160000,110,625,10],
	["Land_A3FL_House4_Brown",160000,110,625,10],
	["Land_A3FL_House4_Yellow",160000,110,625,10],

	//One-story Big L-Shape
	["Land_A3FL_House3_Cream",175000,130,700,12],
	["Land_A3FL_House3_Green",175000,130,700,12],
	["Land_A3FL_House3_Blue",175000,130,700,12],
	["Land_A3FL_House3_Brown",175000,130,700,12],
	["Land_A3FL_House3_Yellow",175000,130,700,12],

	//Two-Story with garage
	["Land_Home3r_DED_Home3r_01_F",250000,280,1200,13],
	["Land_Home6b_DED_Home6b_01_F",250000,280,1200,13],

	//Two-story without garage
	["Land_A3FL_House1_Cream",250000,250,1100,15],
	["Land_A3FL_House1_Green",250000,250,1100,15],
	["Land_A3FL_House1_Blue",250000,250,1100,15],
	["Land_A3FL_House1_Brown",250000,250,1100,15],
	["Land_A3FL_House1_Yellow",250000,250,1100,15],

	//One-story without garage
	["Land_A3FL_Anton_Modern_Bungalow",500000,350,900,20],

	//Mansions
	["Land_Mansion01",500000,350,1700,25],
	["Land_A3PL_ModernHouse1",550000,400,1800,25],
	["Land_A3PL_ModernHouse2",550000,400,1800,25],
	["Land_A3PL_ModernHouse3",550000,400,1800,25],

	//BIG Mansions
	["Land_A3FL_Mansion",550000,450,1800,27],
	["Land_A3FL_Office_Building",1000000,500,2000,30]
];
publicVariable "Config_Houses";

/*
	Winston - Use this to check house types:
	tmp = (nearestObjects [getPos player,["Land_A3PL_Ranch3"],20000000]) select 0;
	player setPos (getPos tmp);
*/
