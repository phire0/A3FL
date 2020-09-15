/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//ore type, nb of areas, resource per area, item class to spawn, amount of ores to spawn, island
Config_Resources_Ores =
[
    [localize"STR_Config_Resources_Iron",15,20,"Iron_Ore",20,"FIMiningArea"],
    [localize"STR_Config_Resources_Coal",15,20,"Coal_Ore",20,"FIMiningArea"],
    [localize"STR_Config_Resources_Aluminium",15,20,"Aluminium_Ore",20,"FIMiningArea"],
    [localize"STR_Config_Resources_Sulphur",5,20,"Sulphur_Ore",20,"FIMiningArea"],

    [localize"STR_Config_Resources_Sapphire",3,20,"Sapphire_Ore",20,"All"],
    [localize"STR_Config_Resources_Vivianite",3,20,"Vivianite_Ore",20,"All"],
    [localize"STR_Config_Resources_Emerald",3,20,"Emerald_Ore",20,"NIMiningArea"],
    [localize"STR_Config_Resources_Gold",3,20,"Gold_Ore",20,"NIMiningArea"],
    [localize"STR_Config_Resources_Amethyst",3,20,"Amethyst_Ore",20,"NIMiningArea"]
];
publicVariable "Config_Resources_Ores";