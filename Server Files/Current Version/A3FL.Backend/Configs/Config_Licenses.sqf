/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//class,display name, isCompany, canIssue (job), canRevoke (job)
Config_Licenses =
[
	["driver",localize"STR_ConfigLicenses_DriversLicense",false,[],["doj"]],
	["cdl",localize"STR_ConfigLicenses_CommercialDriversLicense",false,[],["doj"]],
	["motorcycle",localize"STR_ConfigLicenses_Motorcycle",false,[],["doj"]],

	["hunt",localize"STR_ConfigLicenses_HuntingPermit",false,["doj"],["doj"]],

	["cpr",localize"STR_ConfigLicenses_CPR",false,["fifr"],["fifr"]],
	["vfd",localize"STR_ConfigLicenses_FireVolunteer",false,["fifr"],["fifr"]],
	["atc",localize"STR_ConfigLicenses_ATCVolunteer",false,["uscg"],["uscg"]],

	["boat",localize"STR_ConfigLicenses_BoatLicense",false,["uscg"],["uscg"]],
	["cboat",localize"STR_ConfigLicenses_ComBoatLicense",false,["uscg"],["uscg"]],
	["gboat",localize"STR_ConfigLicenses_GovBoatLicense",false,["uscg"],["uscg"]],

	["rppl",localize"STR_ConfigLicenses_RotaryPrivatePilotLicense",false,["uscg"],["uscg"]],
	["rcpl",localize"STR_ConfigLicenses_RotaryCommercialPilotLicense",true,["uscg"],["uscg"]],
	["fwppl",localize"STR_ConfigLicenses_FixedWingPrivateLicense",false,["uscg"],["uscg"]],
	["fwcpl",localize"STR_ConfigLicenses_FixedWingCommercialLicense",true,["uscg"],["uscg"]],
	["gpl",localize"STR_ConfigLicenses_GovPilotLicense",false,["uscg"],["uscg"]],

	["pfish",localize"STR_ConfigLicenses_PrivateFishingLicense",false,["uscg"],["uscg"]],
	["sfish",localize"STR_ConfigLicenses_SportFishingLicense",false,["uscg"],["uscg"]],
	["cfish",localize"STR_ConfigLicenses_CommercialFishingLicense",true,["uscg"],["uscg"]],

	["ccp",localize"STR_ConfigLicenses_CCP",false,["doj"],["doj"]],
	["fiba",localize"STR_ConfigLicenses_FIBA",false,["doj"],["doj"]],
	["sfp",localize"STR_ConfigLicenses_SFP",false,["doj"],["doj"]],
	["figl",localize"STR_ConfigLicenses_GameLicense",true,["doj"],["doj"]]
];
publicVariable "Config_Licenses";