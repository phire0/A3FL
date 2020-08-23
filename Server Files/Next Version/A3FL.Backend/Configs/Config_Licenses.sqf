/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//class,display name, isCompany, canIssue (job)
Config_Licenses =
[
	["driver",localize"STR_ConfigLicenses_DriversLicense",false,[]],
	["cdl",localize"STR_ConfigLicenses_CommercialDriversLicense",false,[]],
	["motorcycle",localize"STR_ConfigLicenses_Motorcycle",false,[]],

	["hunt",localize"STR_ConfigLicenses_HuntingPermit",false,["doj"]],

	["cpr",localize"STR_ConfigLicenses_CPR",false,["fifr"]],
	["vfd",localize"STR_ConfigLicenses_FireVolunteer",false,["fifr"]],
	["atc",localize"STR_ConfigLicenses_ATCVolunteer",false,["uscg"]],

	["boat",localize"STR_ConfigLicenses_BoatLicense",false,["uscg"]],
	["cboat",localize"STR_ConfigLicenses_ComBoatLicense",false,["uscg"]],
	["gboat",localize"STR_ConfigLicenses_GovBoatLicense",false,["uscg"]],

	["rppl",localize"STR_ConfigLicenses_RotaryPrivatePilotLicense",false,["uscg"]],
	["rcpl",localize"STR_ConfigLicenses_RotaryCommercialPilotLicense",true,["uscg"]],
	["fwppl",localize"STR_ConfigLicenses_FixedWingPrivateLicense",false,["uscg"]],
	["fwcpl",localize"STR_ConfigLicenses_FixedWingCommercialLicense",true,["uscg"]],
	["gpl",localize"STR_ConfigLicenses_GovPilotLicense",false,["uscg"]],	

	["pfish",localize"STR_ConfigLicenses_PrivateFishingLicense",false,["uscg"]],
	["sfish",localize"STR_ConfigLicenses_SportFishingLicense",false,["uscg"]],
	["cfish",localize"STR_ConfigLicenses_CommercialFishingLicense",true,["uscg"]],

	["ccp",localize"STR_ConfigLicenses_CCP",false,["doj"]],
	["fiba",localize"STR_ConfigLicenses_FIBA",false,["doj"]],
	["sfp",localize"STR_ConfigLicenses_SFP",false,["doj"]],
	["figl",localize"STR_ConfigLicenses_GameLicense",true,["doj"]]
];
publicVariable "Config_Licenses";