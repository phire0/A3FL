[
	"",
	localize"STR_QuickActionsNPC_AccessAcierie",
	{["Steel Mill"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessFoodFactory",
	{["Food Processing Plant"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_FakeID",
	{[] call A3PL_Police_FakeID;}
],
[
	"",
	localize"STR_QuickActionsNPC_OilRefinery",
	{["Oil Refinery"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_VehiclePartsFactory",
	{["Car Parts Factory"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_WeaponIllegalShop",
	{["Shop_IllegalWeapons"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_SFPShop",
	{
		if((player getVariable["job","unemployed"]) != "security") exitWith {[localize"STR_QuickActionsNPC_OnlySecurity","red"] call A3PL_Player_Notification;};
		["Shop_SFP"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_VehiclesFactionFactory",
	{["Vehicles Faction"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_GoodsFactory",
	{["Goods Factory"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_VehiclesFactory",
	{["Vehicle Factory"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_FactoryBoat",
	{["Marine Factory"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AirbuyFactory",
	{["Aircraft Factory"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessChemicalPlant",
	{["Chemical Plant"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessFactoryLegalArms",
	{["Legal Weapon Factory"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_WeaponIllegalFactory",
	{["Illegal Weapon Factory"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_ReadDecrees",
	{[] call A3PL_Government_ReadLaws;}
],
[
	"",
	localize"STR_QuickActionsNPC_OpenBusiness",
	{[] call A3PL_Company_CreateOpen;}
],
[
	"",
	localize"STR_QuickActionsNPC_BusinessManagement",
	{[] call A3PL_Company_ManageOpen;}
],
[
	"",
	localize"STR_QuickActionsNPC_EnterpriseAccountManagment",
	{[] call A3PL_Company_HistoryOpen;}
],
[
	"",
	localize"STR_INTSECT_OPTREASINF",
	{[] call A3PL_Government_OpenTreasury;}
],
[
	"",
	localize"STR_QuickActionsNPC_FISDManagment",
	{["fisd"] call A3PL_Government_FactionSetup;}
],
[
	"",
	localize"STR_QuickActionsNPC_DMVManagment",
	{["dmv"] call A3PL_Government_FactionSetup;}
],
[
	"",
	localize"STR_QuickActionsNPC_DOJManagment",
	{["doj"] call A3PL_Government_FactionSetup;}
],
[
	"",
	localize"STR_QuickActionsNPC_USMSManagment",
	{["usms"] call A3PL_Government_FactionSetup;}
],
[
	"",
	localize"STR_QuickActionsNPC_CartelManagment",
	{["cartel"] call A3PL_Government_FactionSetup;}
],
[
	"",
	localize"STR_QuickActionsNPC_RentATowTruck",
	{[player_objintersect] call A3PL_JobRoadWorker_RentVehicle;}
],
[
	"",
	localize"STR_QuickActionsNPC_FactionAccount",
	{[] call A3PL_Government_Budget;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToInsurer",
	{[] call A3PL_Vehicle_InsureOpen;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToPort",
	{["port_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TakeFuelStationCash",
	{
		_station = (nearestobjects [player,["Land_A3PL_Gas_Station"],20]) select 0;
		[_station,true] spawn A3PL_Store_Robbery_RobStore;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToExterminator",
	{[] call A3PL_Exterminator_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_StationStore",
	{["Shop_Fuel"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_ResellNearVehicle",
	{["vehiclesell_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_FISecurityService",
	{
		if (["ccp",player] call A3PL_DMV_Check) then {
			["sfp_start"] call A3PL_NPC_Start;
		} else {
			[localize"STR_QuickActionsNPC_NoCCPToJOB","red"] call A3PL_Player_Notification;
		};
	}
],
[
	"A3PL_DogCage",
	localize"STR_INTSECT_OPK9MEN",
	{[] call A3PL_Dogs_OpenMenu;}
],
[
	"",
	localize"STR_INTSECT_OPIMEXMENU",
	{[] call A3PL_IE_Open;}
],
[
	"",
	localize"STR_INTSECT_CONVSTOLMONEY",
	{
		_cops = (count(["fisd"] call A3PL_Lib_FactionPlayers));
		if (_cops < 3) exitwith {[localize"STR_QuickActionsNPC_MinimumUSCGToSpeak","red"] call A3PL_Player_Notification;};
		[] call A3PL_BHeist_ConvertCash;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessShopSupply",
	{["Shop_Furniture2"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_PaintBallShop",
	{["Shop_Paintball"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_Store",
	{["Shop_Buckeye"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_BucheronShop",
	{["Shop_Hemlock"] call A3PL_Shop_Open;}
],
[
	"",
	"Chemical Dealer",
	{["Shop_ChemicalSupplies"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_RemoveElectronicBracelet",
	{[] call A3PL_Criminal_RemoveTime;}
],
[
	"",
	localize"STR_QuickActionsNPC_StartCartelWork",
	{[] call A3PL_Criminal_CartelStart;}
],
[
	"",
	localize"STR_QuickActionsNPC_Shop_DrugsDealerCartel",
	{["Shop_DrugsDealerCartel"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_Shop_IllegalWeaponsCartel",
	{["Shop_IllegalWeaponsCartel"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_Shop_BlackMarketCartel",
	{
		_rank = ["cartel","rank", getPlayerUID player] call A3PL_Config_GetFactionRankData;
		if(_rank IN ["Boss","UnderBoss","Consigliere","Caporegime","Reserves"]) then {
			["Shop_BlackMarketCartel"] call A3PL_Shop_Open;
		} else {
			["You current doesn't allow you to access this.","red"] call A3PL_Player_notification;
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessShopWaste",
	{["Shop_WasteManagement"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_ExterminatorShop",
	{["Shop_ExterminatorJob"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_MailManShop",
	{["Shop_DeliveryJob"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_StartStopWaste",
	{[] spawn A3PL_Waste_StartJob;}
],
[
	"",
	localize"STR_QuickActionsNPC_StartStopDelivery",
	{[player_objintersect] spawn A3PL_Delivery_StartJob;}
],
[
	"",
	localize"STR_QuickActionsNPC_KartRent",
	{[] call A3PL_Karts_Rent;}
],
[
	"",
	localize"STR_QuickActionsNPC_BuyMapIron",
	{[localize"STR_Config_Resources_Iron"] call A3PL_JobWildCat_BuyMap;}
],
[
	"",
	localize"STR_QuickActionsNPC_BuyMapCharcoal",
	{[localize"STR_Config_Resources_Coal"] call A3PL_JobWildCat_BuyMap;}
],
[
	"",
	localize"STR_QuickActionsNPC_BuyMapAluminium",
	{[localize"STR_Config_Resources_Aluminium"] call A3PL_JobWildCat_BuyMap;}
],
[
	"",
	localize"STR_QuickActionsNPC_BuyMapSulfur",
	{[localize"STR_Config_Resources_Sulphur"] call A3PL_JobWildCat_BuyMap;}
],
[
	"",
	localize"STR_QuickActionsNPC_BuyMapOil",
	{[localize"STR_Config_Resources_Oil"] call A3PL_JobWildCat_BuyMap;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessMinerShop",
	{["Shop_MiningMike"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessShopSupply2",
	{["Shop_Furniture"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessGeneralShop",
	{["Shop_General_Supplies"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessHardwareShop",
	{["Shop_Hardware"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessSeedShop",
	{["Shop_Seeds"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessShopFIMS",
	{
		if ((player getVariable ["faction","citizen"]) != "fifr") exitwith {[localize"STR_QuickActionsNPC_OnlyFIFR","red"] call A3PL_Player_Notification;};
		["Shop_FIFR_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessShopVFD",
	{
		if ((["vfd",player] call A3PL_DMV_Check) || ((player getVariable ["faction","citizen"]) == "fifr")) then
		{
			["Shop_VFD_Supplies_Vendor"] call A3PL_Shop_Open;
		} else {
			[localize"STR_QuickActionsNPC_OnlyVFD","red"] call A3PL_Player_Notification;
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessShopFIFR",
	{
		if (((player getVariable ["faction","citizen"]) != "fifr")) exitwith {
			[localize"STR_QuickActionsNPC_OnlyFIFR","red"] call A3PL_Player_Notification;
		};
		["Shop_FIFR_Supplies_Vendor2"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessFIFRVEHShop",
	{
		if ((player getVariable ["faction","citizen"]) != "fifr") exitwith {[localize"STR_QuickActionsNPC_OnlyFIFR","red"] call A3PL_Player_Notification;};
		["Shop_FIFR_Vehicle_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_FIFDManagment",
	{["fifr"] call A3PL_Government_FactionSetup;}
],
[
	"",
	localize"STR_QuickActionsNPC_USCGManagment",
	{
		if ((player getVariable ["faction","citizen"]) != "uscg") exitwith {[format [localize"STR_QuickActionsNPC_OnlyLeaderCanAccessManager","United States Coast Guard"],"red"] call A3PL_Player_Notification;};
		["uscg"] call A3PL_Government_FactionSetup;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_CCTVNorthdale",
	{
		if (!((player getVariable ["job","unemployed"]) IN ["uscg","fisd","usms"])) exitwith {[localize"STR_QuickActionsNPC_CCTVPermission","red"] call A3PL_Player_Notification;};
		[3000] spawn A3PL_CCTV_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_CCTVSilverton",
	{
		if (!((player getVariable ["job","unemployed"]) IN ["uscg","fisd","usms"])) exitwith {[localize"STR_QuickActionsNPC_CCTVPermission","red"] call A3PL_Player_Notification;};
		[2500] spawn A3PL_CCTV_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_CCTVElk",
	{
		if (!((player getVariable ["job","unemployed"]) IN ["uscg","fisd","usms"])) exitwith {[localize"STR_QuickActionsNPC_CCTVPermission","red"] call A3PL_Player_Notification;};
		[4000] spawn A3PL_CCTV_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_CCTVCentral",
	{
		if (!((player getVariable ["job","unemployed"]) IN ["uscg","fisd","usms"])) exitwith {[localize"STR_QuickActionsNPC_CCTVPermission","red"] call A3PL_Player_Notification;};
		[40000] spawn A3PL_CCTV_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_ShopDealer",
	{["Shop_Vehicles_Supplies_Vendor"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessPrisonShop",
	{
		if(!(player getVariable ["jailed",false])) exitWith {[localize"STR_QuickActionsNPC_OnlyJailed", "red"] call A3PL_Player_Notification;};
		["Shop_Prison"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessUSCGShop",
	{
		if ((player getVariable ["faction","citizen"]) != "uscg") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","uscg"],"red"] call A3PL_Player_Notification;};
		["Shop_USCG_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessUSCGPilotShop",
	{
		if ((player getVariable ["faction","citizen"]) != "uscg") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","uscg"],"red"] call A3PL_Player_Notification;};
		["Shop_USCG_Pilot_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessUSCGArmory",
	{
		if ((player getVariable ["faction","citizen"]) != "uscg") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","uscg"],"red"] call A3PL_Player_Notification;};
		["Shop_USCG_Weapons_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessUSCGVehShop",
	{
		if ((player getVariable ["faction","citizen"]) != "uscg") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","uscg"],"red"] call A3PL_Player_Notification;};
		["Shop_USCG_Car_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessUSCGBoatShop",
	{
		if ((player getVariable ["faction","citizen"]) != "uscg") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","uscg"],"red"] call A3PL_Player_Notification;};
		["Shop_USCG_Boat_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessWeaponsDOC",
	{
		if ((player getVariable ["faction","citizen"]) != "usms") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","fims"],"red"] call A3PL_Player_Notification;};
		["Shop_DOC_Weapons_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessSDWeaponsFISD",
	{
		if ((player getVariable ["faction","citizen"]) != "fisd") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","fisd"],"red"] call A3PL_Player_Notification;};
		["Shop_SD_Weapons_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessUSMSSuppliesVendor",
	{
		if ((player getVariable ["faction","citizen"]) != "usms") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","usms"],"red"] call A3PL_Player_Notification;};
		["Shop_DOC"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessUSMSCarVendor",
	{
		if ((player getVariable ["faction","citizen"]) != "usms") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","usms"],"red"] call A3PL_Player_Notification;};
		["Shop_DOC_Car_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessDMVCarVendor",
	{
		if ((player getVariable ["faction","citizen"]) != "dmv") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","dmv"],"red"] call A3PL_Player_Notification;};
		["Shop_DMV_Car_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessFISDCarVendor",
	{
		if ((player getVariable ["faction","citizen"]) != "fisd") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","fisd"],"red"] call A3PL_Player_Notification;};
		["Shop_SD_Car_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessFISDSuppliesVendor",
	{
		if ((player getVariable ["faction","citizen"]) != "fisd") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","fisd"],"red"] call A3PL_Player_Notification;};
		["Shop_SD_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessDMVSuppliesVendor",
	{
		if ((player getVariable ["faction","citizen"]) != "dmv") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","dmv"],"red"] call A3PL_Player_Notification;};
		["Shop_DMV_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessDOJSuppliesVendor",
	{
		if ((player getVariable ["faction","citizen"]) != "doj") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","doj"],"red"] call A3PL_Player_Notification;};
		["Shop_DOJ_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessUSCGAirShop",
	{
		if ((player getVariable ["faction","citizen"]) != "uscg") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","uscg"],"red"] call A3PL_Player_Notification;};
		["Shop_USCG_Plane_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessFIFRAirShop",
	{
		if ((player getVariable ["faction","citizen"]) != "fifr") exitwith {[format [localize"STR_QuickActionsNPC_OnlyTHISFactionCanAccess","fifr"],"red"] call A3PL_Player_Notification;};
		["Shop_FIFR_Plane_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_SpeakToTheRealEstateAgent",
	{["estate_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheMcFishersEmpl",
	{["mcfishers_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TakeMcFishersUniform",
	{["mcfisher"] call A3PL_NPC_ReqJobUniform;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheTacoHellEmpl",
	{["tacohell_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TakeTacoHellUniform",
	{["tacohell"] call A3PL_NPC_ReqJobUniform;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheRoadService",
	{["roadworker_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheFisherMan",
	{["fisherman_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToSheriff",
	{
		["police_initial"] call A3PL_NPC_Start;
		if(((["fisd","rank", getPlayerUID player] call A3PL_Config_GetFactionRankData) IN ["Detective","Reserve","Lieutenant","Captain","Undersheriff","Sheriff"])) then {
			player setVariable["FakeIDAccess",true,false];
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_PriseServiceUSMS",
	{["doc_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_PriseServiceDOJ",
	{["doj_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheDoctorWithoutDiploma",
	{["fifr_initialill"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheDoctorGuard",
	{["fifr_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheBankEmployee",
	{["bank_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheFreight",
	{["freight_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToUSCGOfficer",
	{["uscg_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_SpeaktoAdherent",
	{
		if(["motorhead"] call A3PL_Lib_hasPerk) then {
			["Shop_Perk_Motorhead"] call A3PL_Shop_Open;
		} else {
			[localize"STR_QuickActions_Notif_NPC_Motorhead","red"] call A3PL_Player_Notification
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_SpeaktoThingsPerk",
	{
		if(["things"] call A3PL_Lib_hasPerk) then {
			["Shop_Perk_ThingsPerk"] call A3PL_Shop_Open;
		} else {
			[localize"STR_QuickActions_Notif_NPC_Things","red"] call A3PL_Player_Notification
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheFermer",
	{["farmer_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheOilExtractor",
	{["oil_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheOilDealer",
	{["oilbarrel_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheDrugDealer",
	{["Shop_DrugsDealer"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheCriminalPrint",
	{[] spawn A3PL_Criminal_Print;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheBlackMarket",
	{
		//if (((count(["uscg"] call A3PL_Lib_FactionPlayers))) < 2) exitwith {[localize"STR_QuickActionsNPC_MinimumUSCGToSpeak","red"] call A3PL_Player_Notification;};
		["Shop_BlackMarket"] call A3PL_Shop_Open;
	}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheGunsFMLVendor",
	{
		if (["fml",player] call A3PL_DMV_Check) then {
			["Shop_GunsFML_Vendor"] call A3PL_Shop_Open;
		} else {
			[localize"STR_QuickActionsNPC_NoCCP2","red"] call A3PL_Player_Notification;
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheGunsVendor",
	{
		if (["ccp",player] call A3PL_DMV_Check) then {
			["Shop_Guns_Vendor"] call A3PL_Shop_Open;
		} else {
			[localize"STR_QuickActionsNPC_NoCCP3","red"] call A3PL_Player_Notification;
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheSupermarket",
	{["Shop_Supermarket"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheSupermarket2",
	{["Shop_Supermarket"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToThePhoneOperator",
	{["verizon_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheDOJNPC",
	{["doj_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheDMVNPC",
	{["dmv_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheHunter",
	{["Shop_Hunting_Supplies"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_TalkToTheRoadService2",
	{["roadside_service_initial"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessShopGems",
	{["Shop_GemStone"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_BuySellChristmasItems",
	{["Shop_Christmas","gift"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_BuySellHalloweenItems",
	{["Shop_Halloween","candy"] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_OpenRadar",
	{[] spawn A3PL_ATC_RadarStart;}
],
[
	"",
	localize"STR_QuickActionsNPC_ATCManager",
	{["atc"] call A3PL_NPC_Start;}
],
[
	"",
	localize"STR_QuickActionsNPC_ATCExit",
	{[] call A3PL_ATC_LeaveJob;}
],
[
	"",
	localize"STR_QuickActionsNPC_TakeRadio",
	{player addBackpackGlobal "tf_anarc164";}
],
[
	"",
	localize"STR_QuickActionsNPC_SkinAnimal",
	{[player_objintersect] call A3PL_Hunting_Skin;}
],
[
	"",
	localize"STR_QuickActionsNPC_RobShop",
	{[player_objintersect] spawn A3PL_Store_Robbery_RobStore;}
],
[
	"",
	localize"STR_QuickActionsNPC_SecureShop",
	{[player_objintersect] spawn A3PL_SFP_CheckIn;}
],
[
	"",
	localize"STR_QuickActionsNPC_GamerPerkShop",
	{
		if (["gamer"] call A3PL_Lib_hasPerk) then {
			["Shop_Perk_Gamer"] call A3PL_Shop_Open;
		} else {
			[localize"STR_QuickActions_Notif_NPC_Gamer","red"] call A3PL_Player_Notification
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_GardenPerkShop",
	{
		if (["garden"] call A3PL_Lib_hasPerk) then {
			["Shop_Perk_Garden"] call A3PL_Shop_Open;
		} else {
			[localize"STR_QuickActions_Notif_NPC_Garden","red"] call A3PL_Player_Notification
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_MancavePerkShop",
	{
		if (["mancave"] call A3PL_Lib_hasPerk) then {
			["Shop_Perk_Mancave"] call A3PL_Shop_Open;
		} else {
			[localize"STR_QuickActions_Notif_NPC_Mancave","red"] call A3PL_Player_Notification
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_WalldecorPerkShop",
	{
		if (["walldecor"] call A3PL_Lib_hasPerk) then {
			["Shop_Perk_WallDecor"] call A3PL_Shop_Open;
		} else {
			[localize"STR_QuickActions_Notif_NPC_Walldecor","red"] call A3PL_Player_Notification
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_WinchesterPerkShop",
	{
		if (["winchester"] call A3PL_Lib_hasPerk) then {
			["Shop_Perk_Winchester"] call A3PL_Shop_Open;
		} else {
			[localize"STR_QuickActions_Notif_NPC_Winchester","red"] call A3PL_Player_Notification
		};
	}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessVetements",
	{["Clothing Factory"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessVetementsVestes",
	{["Vest Factory"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessVetementsChapeaux",
	{["Headgear Factory"] call A3PL_Factory_Open;}
],
[
	"",
	localize"STR_QuickActionsNPC_AccessVetementsLunettes",
	{["Goggle Factory"] call A3PL_Factory_Open;}
]