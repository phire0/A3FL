//class,display name, isCompany, canIssue (job)
Config_Licenses =
[
	["cpr",localize"STR_ConfigLicenses_CPR",false,["fifr"]],
	["vfd",localize"STR_ConfigLicenses_FireVolunteer",false,["fifr"]],
	["atc",localize"STR_ConfigLicenses_ATCVolunteer",false,["uscg"]],

	["driver",localize"STR_ConfigLicenses_DriversLicense",false,["dmv"]],
	["cdl",localize"STR_ConfigLicenses_CommercialDriversLicense",false,["dmv"]],
	["motorcycle",localize"STR_ConfigLicenses_Motorcycle",false,["dmv"]],

	["boat",localize"STR_ConfigLicenses_BoatLicense",false,["uscg"]],
	["fwcpl",localize"STR_ConfigLicenses_FixedWingCommercialLicense",true,["uscg"]],
	["fwppl",localize"STR_ConfigLicenses_FixedWingPrivateLicense",false,["uscg"]],
	["rcpl",localize"STR_ConfigLicenses_RotaryCommercialPilotLicense",true,["uscg"]],
	["rppl",localize"STR_ConfigLicenses_RotaryPrivatePilotLicense",false,["uscg"]],
	["pfish",localize"STR_ConfigLicenses_PrivateFishingLicense",false,["uscg"]],
	["cfish",localize"STR_ConfigLicenses_CommercialFishingLicense",true,["uscg"]],

	["ccp",localize"STR_ConfigLicenses_CCP",false,["doj"]],
	["fiba",localize"STR_ConfigLicenses_FIBA",false,["doj"]],
	["sfp",localize"STR_ConfigLicenses_SFP",false,["doj"]],
	["figl",localize"STR_ConfigLicenses_GameLicense",true,["doj"]],
	["fml",localize"STR_ConfigLicenses_FirearmManufacturingLicense",false,["doj"]]
];
publicVariable "Config_Licenses";