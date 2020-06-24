/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

[
	"A3PL_Distillery",
	localize"STR_INTSECT_InstallHose",
	{[player_objIntersect] call A3PL_Moonshine_InstallHose;}
],
[
	"A3FL_PlasticBarrel",
	"Add Item",
	{[player_objIntersect] call A3PL_Cocaine_AddItem;}
],
[
	"A3FL_PlasticBarrel",
	"Check Barrel Contents",
	{[player_objIntersect] call A3PL_Cocaine_CheckContents;}
],
[
	"A3FL_PlasticBarrel",
	"Check Barrel Contents",
	{[player_objIntersect] call A3PL_Cocaine_CheckContents;}
],
[
	"A3FL_PlasticBarrel",
	"Produce Coca Paste",
	{[player_objIntersect,1] call A3PL_Cocaine_Produce;}
],
[
	"A3FL_PlasticBarrel",
	"Produce Cocaine Base",
	{[player_objIntersect,2] call A3PL_Cocaine_Produce;}
],
[
	"A3FL_PlasticBarrel",
	"Produce Cocaine Hydrochloride",
	{[player_objIntersect,3] call A3PL_Cocaine_Produce;}
],
[
	"A3FL_PlasticBarrel",
	"Collect Product",
	{[player_objIntersect] call A3PL_Cocaine_Collect;}
],
[
	"A3PL_Distillery",
	"Remove Barrel Contents",
	{[player_objIntersect] call A3PL_Cocaine_Reset;}
],
[
	"A3PL_Scale",
	"Create Cocaine Brick",
	{[player_objintersect] call A3PL_Cocaine_CreateBrick;}
],
[
	"A3PL_Scale",
	"Break Down Cocaine Brick",
	{[player_objintersect] call A3PL_Cocaine_BreakDownBrick;}
],
[
	"",
	localize"STR_INTSECT_FillBottle",
	{call A3PL_Items_FillBottle;}
],
[
	"",
	localize "STR_INTSECT_STVAULTMON",
	{[player_objIntersect] spawn A3PL_BHeist_PickCash;}
],
[
	"",
	localize "STR_INTSECT_TAKEBODY",
	{[player_objIntersect] spawn A3PL_Gang_Capture;}
],
[
	"",
	"Seize Item",
	{[player_objintersect] call A3PL_Police_SeizeVirtualItems;}
],
[
	"",
	"Enter into Evidince",
	{[player_objintersect] call A3PL_Police_SeizePhysicalItems;}
],
[
	"",
	localize "STR_INTSECT_HIDEOUTSHOP",
	{
		_obj = player_objIntersect;
		_group = group player;
		_gang = _group getVariable ["gang_data",nil];
		if(isNil "_gang") exitwith {[localize"STR_QuickActions_Notifications_Objects_GangNo","red"] call A3PL_Player_Notification;};
		_gangID = _gang select 0;
		if((_obj getVariable["captured",-1]) isEqualTo _gangID) then {
			["Shop_Gang"] call A3PL_Shop_Open;
		} else {
			[localize"STR_QuickActions_Notifications_Objects_CaptureNo","red"] call A3PL_Player_Notification;
		};
	}
],
[
	"A3PL_Distillery_Hose",
	localize"STR_INTSECT_ConnectJugToHose",
	{[player_objIntersect] call A3PL_Moonshine_InstallJug;}
],
[
	"A3PL_Distillery",
	localize"STR_INTSECT_StartDistillery",
	{[player_objIntersect] spawn A3PL_Moonshine_Start;}
],
[
	"A3PL_Distillery",
	localize"STR_INTSECT_CheckDistilleryStatus",
	{[player_objIntersect] call A3PL_Moonshine_CheckStatus;}
],
[
	"A3PL_Distillery",
	localize"STR_INTSECT_AddItemToDistillery",
	{[player_objIntersect] call A3PL_Moonshine_addItem;}
],
[
	"",
	localize"STR_INTSECT_UseDistributor",
	{[player_objIntersect] call A3PL_ATM_MenuOpen;}
],
[
	"A3PL_Mixer",
	localize"STR_INTSECT_GrindWheatIntoMalt",
	{["malt",player_objIntersect] call A3PL_Moonshine_Grind;}
],
[
	"A3PL_Mixer",
	localize"STR_INTSECT_GrindWheatIntoYeast",
	{["yeast",player_objIntersect] call A3PL_Moonshine_Grind;}
],
[
	"A3PL_Mixer",
	localize"STR_INTSECT_GrindCornIntoCornmeal",
	{["cornmeal",player_objIntersect] call A3PL_Moonshine_Grind;}
],
[
	"A3PL_Mixer",
	localize"STR_INTSECT_GrindCannabis",
	{[player_objintersect] call A3PL_JobFarming_Grind;}
],
[
	"A3PL_Mixer",
	localize"STR_INTSECT_CollectGrindedCannabis",
	{[player_objintersect] call A3PL_JobFarming_GrindCollect;}
],
[
	"A3PL_Scale",
	localize"STR_INTSECT_BagMarijuana",
	{[player_objintersect] call A3PL_JobFarming_BagOpen;}
],
[
	"A3PL_WorkBench",
	localize"STR_INTSECT_CureBud",
	{
		if ((player_itemClass == "cannabis_bud") && (typeOf Player_Item == "A3PL_Cannabis_Bud")) then
		{
			[Player_Item] call A3PL_JobFarming_CureLoop;
			call A3PL_Placeables_QuickAction;
		} else
		{
			[localize"STR_INTSECT_SystemYouDontSeemToBeHoldingACannabisBudToCure","red"] call A3PL_Player_Notification;
		};
	}
],
[
	"A3FL_Table",
	localize"STR_INTSECT_CureBud",
	{
		if ((player_itemClass isEqualTo "cannabis_bud") && (typeOf Player_Item isEqualTo "A3PL_Cannabis_Bud")) then
		{
			[Player_Item] call A3PL_JobFarming_CureLoop;
			call A3PL_Placeables_QuickAction;
		} else {
			[localize"STR_INTSECT_SystemYouDontSeemToBeHoldingACannabisBudToCure","red"] call A3PL_Player_Notification;
		};
	}
],
[
	"A3PL_Cannabis_Bud",
	localize"STR_INTSECT_CheckCureStatus",
	{[player_objintersect] call A3PL_JobFarming_CheckCured;}
],
[
	"A3FL_Mushroom",
	"Harvest Mushrooms",
	{[player_objintersect] spawn A3PL_Shrooms_Pick;}
],
[
    "Land_MetalCase_01_large_F",
    "",
    {[player_objintersect] call A3PL_Housing_VirtualOpen;}
],
[
    "Box_GEN_Equip_F",
    "",
    {[player_objintersect] call A3PL_Housing_VirtualOpen;}
],
[
	"B_supplyCrate_F",
	"",
	{
		_sotrage = player_objintersect;
		_isLead = ["usms"] call A3PL_Government_isFactionLeader;
		_isLocked = _sotrage getVariable["locked",true];
		if(!_isLead && _isLocked) then {
			["The storage is locked","red"] call A3PL_Player_Notification;
		} else {
			[player_objintersect] call A3PL_Housing_VirtualOpen;
		};
    }
],
[
	"Land_GarbageBin_03_F",
	"",
	{[] spawn A3PL_Prison_SearchTrash;}
],
[
	"Land_ToolTrolley_02_F",
	"",
	{[] spawn A3PL_Criminal_Work;}
],
[
	"A3PL_Roadcone",
	localize"STR_INTSECT_STACKCONE",
	{[player_objintersect] call A3PL_Placeables_StackCone;}
],
[
	"A3PL_RoadCone_x10",
	localize"STR_INTSECT_STACKCONE",
	{[player_objintersect] call A3PL_Placeables_StackCone;}
],
[
	"A3PL_carInfo",
	localize"STR_INTSECT_VEHINFO",
	{[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;}
],
[
	"A3PL_carInfo",
	localize"STR_INTSECT_PAINTAIRC",
	{[player_objintersect] spawn A3PL_Garage_Open;}
],
[
	"",
	localize"STR_INTSECT_BuyFurniture",
	{[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;}
],
[
	"A3PL_Net",
	localize"STR_INTSECT_BUSENET",
	{[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;}
],
[
	"A3PL_Bucket",
	localize"STR_INTSECT_BUSEBUCK",
	{[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;}
],
[
	"A3PL_Crate",
	localize"STR_INTSECT_BUSEITEM",
	{[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;}
],
[
	"A3PL_Seed_Marijuana",
	localize"STR_INTSECT_BuySellMarijuanaSeeds",
	{[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;}
],
[
	"A3PL_Seed_Lettuce",
	localize"STR_INTSECT_BuySellLettuceSeeds",
	{[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;}
],
[
	"A3PL_MarijuanaBag",
	localize"STR_INTSECT_BuySellWeedBag",
	{[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;}
],
[
	"A3PL_Seed_Wheat",
	localize"STR_INTSECT_BuySellWheatSeeds",
	{[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;}
],
[
	"A3PL_Seed_Corn",
	localize"STR_INTSECT_BuySellCornSeeds",
	{[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;}
],
[
	"",
	localize"STR_INTSECT_PLACEBURGER",
	{
		if (isNull player_item) exitwith {[localize"STR_INTSECT_YouHaveNothingInYourHandToPlaceHere", "red"] call A3PL_Player_Notification;};
		private _class = player_itemclass;
		if (!(_class IN ["burger_raw","burger_burnt","burger_cooked","fish_raw","fish_cooked","fish_burned"])) exitwith {[localize"STR_INTSECT_YouCanOnlyPlaceBurgersFishOnTheGrill", "red"] call A3PL_Player_Notification;};
		if (!isNull Player_Item) exitwith
		{
			private _playeritem = Player_Item;
			call A3PL_Placeables_QuickAction;
			if (isNull (attachedTo _playeritem)) exitwith {};
			if ((typeOf(attachedTo _playeritem)) IN ["A3PL_Mcfisher_Grill"]) exitwith {[_playeritem] call A3PL_JobMcfisher_CookBurger;};
		};
	}
],
[
	"RoadCone_F",
	"",
	{
		if (Player_NameIntersect != "") exitwith {};
		call A3PL_Placeables_QuickAction;
	}
],
[
	"PipeFence_01_m_gate_v2_F",
	"",
	{hint "WORK IN PROGRESS";}
],
[
	"",
	localize"STR_INTSECT_GRABFURN",
	{
		if (!isNull player_item) exitwith {[localize"STR_INTSECT_YouCantPickupDropThisItemBecauseYouHaveSomethingInYourHand", "red"] call A3PL_Player_Notification;};
		call A3PL_Placeables_QuickAction;
	}
],
[
	"C_man_1",
	"",
	{
		_attachedObjects = [] call A3PL_Lib_Attached;
		if ((count _attachedObjects) == 0) exitwith {};
		_attachedObject = _attachedObjects select 0;
		if (((typeOf _attachedObject) IN Config_Placeables) OR (_attachedObject isKindOf "A3PL_Furniture_Base")) then
		{
			if(_attachedObject isKindOf "A3PL_Furniture_Base") then {
				if(isOnRoad player) then {
					[localize"STR_INTSECT_YouCantPlaceFurnitureOnTheRoad", "red"] call A3PL_Player_Notification;
				} else {
					call A3PL_Placeables_QuickAction;
				};
			} else {
				call A3PL_Placeables_QuickAction;
			};
		};
	}
],
[
	"",
	localize"STR_INTSECT_PLACEITEM",
	{
		if (!isNull Player_Item) exitwith {call A3PL_Placeables_QuickAction;};
		if(typeOf player_Item isEqualTo "A3PL_Gas_Hose") exitwith {[localize"STR_INTSECT_YouCantPlaceGasHose", "red"] call A3PL_Player_Notification;};
		private _attached = [] call A3PL_Lib_Attached;
		if (count _attached == 0) exitwith {};
		if ((typeOf (_attached select 0)) IN Config_Placeables) then {call A3PL_Placeables_QuickAction;};
	}
],
[
	"GroundWeaponHolder",
	"",
	{
		if (Player_NameIntersect != "") exitwith {};
		call A3PL_Placeables_QuickAction;
	}
],
[
	"A3PL_PileCash",
	localize"STR_INTSECT_STVAULTMON",
	{[player_objintersect] spawn A3PL_BHeist_PickCash;}
],
[
	"A3PL_Drill_Bank",
	localize"STR_INTSECT_INSTDRLBIT",
	{[player_objintersect] call A3PL_BHeist_InstallBit;}
],
[
	"A3PL_Drill_Bank",
	localize"STR_INTSECT_DISSDRILL",
	{[player_objintersect] call A3PL_BHeist_PickupDrill;}
],
[
	"A3PL_Drill_Bank",
	localize"STR_INTSECT_STARTVDRILL",
	{[player_objintersect] spawn A3PL_BHeist_StartDrill;}
],
[
	"",
	localize"STR_INTSECT_OPENMEDICALMEN",
	{[player_objintersect] spawn A3PL_Medical_Open;}
],
[
	"",
	localize"STR_A3PL_Medical_ChestCompressions",
	{[player_objintersect] spawn A3PL_Medical_ChestCompressions;}
],
[
	"",
	localize"STR_INTSECT_PickupDeliveryBox",
	{[player_objintersect] call A3PL_Delivery_Pickup;}
],
[
	"A3PL_DeliveryBox",
	localize"STR_INTSECT_CheckDeliveryLabel",
	{[player_objintersect] call A3PL_Delivery_Label;}
],
[
	"",
	localize"STR_INTSECT_PICKUPITEM",
	{[player_objintersect] call A3PL_Inventory_Pickup;}
],
[
	"",
	localize"STR_INTSECT_CHECKITEM",
	{[player_objintersect] call A3PL_Factory_CrateCheck;}
],
[
	"",
	localize"STR_INTSECT_COLLECTITEM",
	{[player_objintersect] call A3PL_Factory_CrateCollect;}
],
[
	"",
	localize"STR_INTSECT_BUYITEM",
	{[player_objintersect] call A3PL_Business_BuyItem;}
],
[
	"",
	localize"STR_INTSECT_SELLITEM",
	{[player_objintersect] call A3PL_Business_Sell;}
],
[
	"A3PL_OilBarrel",
	localize"STR_INTSECT_LOADPINTOTANK",
	{[player_objintersect] call A3PL_Hydrogen_LoadPetrol;}
],
[
	"A3PL_Kerosene",
	localize"STR_INTSECT_LoadKeroseneIntoTruck",
	{[player_objintersect] call A3PL_Hydrogen_LoadKerosene;}
],
[
	"",
	localize"STR_INTSECT_PICKITEMTOHAND",
	{[player_objintersect,true] call A3PL_Inventory_Pickup;}
],
[
	"Land_A3PL_Cinema",
	localize"STR_INTSECT_GETPOPC",
	{call A3PL_Items_GrabPopcorn;}
],
[
	"",
	localize"STR_INTSECT_HARPLANT",
	{[player_objintersect] call A3PL_JobFarming_Harvest;}
],
[
	"",
	localize"STR_INTSECT_PICKUPKEY",
	{call A3PL_Housing_PickupKey;}
],
[
	"",
	localize"STR_INTSECT_CREATEFISHB",
	{[player_objintersect] call A3PL_JobMcfisher_CombineBurger;}
],
[
	"A3PL_TacoShell",
	localize"STR_INTSECT_CREATEFTACO",
	{[player_objintersect,"taco"] call A3PL_JobMcfisher_CombineBurger;}
],
[
	"A3PL_FishingBuoy",
	localize"STR_INTSECT_COLLNET",
	{[player_objintersect] call A3PL_JobFisherman_RetrieveNet;}
],
[
	"",
	localize"STR_INTSECT_USEATM",
	{call A3PL_ATM_Open;}
],
[
	"A3PL_FishingBuoy",
	localize"STR_INTSECT_DEPLNET",
	{call A3PL_JobFisherman_DeployNet;}
],
[
	"A3PL_FishingBuoy",
	localize"STR_INTSECT_BaitNet",
	{[player_objintersect] call A3PL_JobFisherman_Bait;}
],
[
	"A3PL_Planter2",
	localize"STR_INTSECT_PLANTFARMSEED",
	{[player_objintersect] call A3PL_JobFarming_PlanterPlant;}
],
[
	"Land_A3PL_Greenhouse",
	localize"STR_INTSECT_PLANTFARMSEED",
	{[player_objintersect] call A3PL_JobFarming_GreenHousePlant;}
],
[
	"A3PL_GasHose",
	localize"STR_INTSECT_GRABGASHOSE",
	{[player_objintersect] spawn A3PL_Hydrogen_Grab;}
],
[
	"Land_A3PL_Gasstation",
	localize"STR_INTSECT_RETGASHOSE",
	{[player_objintersect] spawn A3PL_Hydrogen_Connect;}
],
[
	"A3PL_GasHose",
	localize"STR_INTSECT_TOGGLEFUELP",
	{[player_objintersect] spawn A3PL_Hydrogen_SwitchFuel;}
],
[
	"A3PL_Rocket",
	localize"STR_INTSECT_IGNROCKET",
	{[player_objintersect] call A3PL_Items_IgniteRocket;}
],

[
	"A3PL_FD_HoseEnd1_Float",
	localize"STR_INTSECT_CONROLHOSE",
	{[player_objintersect] call A3PL_FD_ConnectHose;}
],
[
	"Land_A3PL_FireHydrant",
	localize"STR_INTSECT_CONHOSEADAP",
	{[player_objintersect] call A3PL_FD_ConnectAdapter;}
],
[
	"Land_A3PL_Gas_Station",
	localize"STR_INTSECT_CONHOSEADAP",
	{[player_objintersect] call A3PL_FD_ConnectAdapter;}
],
[
	"Land_A3PL_Gas_Station",
	localize"STR_INTSECT_SWITCHGASSTORSW",
	{[player_objintersect] call A3PL_Hydrogen_StorageSwitch}
],
[
	"Land_A3PL_FireHydrant",
	localize"STR_INTSECT_CONHYDWRE",
	{[player_objintersect] call A3PL_FD_ConnectWrench;}
],
[
	"",
	localize"STR_INTSECT_HOLDHOSEAD",
	{[player_objintersect] call A3PL_FD_GrabHose;}
],
[
	"",
	localize"STR_INTSECT_CONHOSETAD",
	{[player_objintersect] call A3PL_FD_ConnectHoseAdapter;}
],
[
	"",
	localize"STR_INTSECT_RollupHose",
	{[player_objintersect] call A3PL_FD_RollHose;}
],
[
	"A3PL_FD_yAdapter",
	localize"STR_INTSECT_CONHOSETIN",
	{[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;}
],
[
	"A3PL_FD_yAdapter",
	localize"STR_INTSECT_CONHOSETOUT",
	{[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;}
],
[
	"A3PL_Tanker_Trailer",
	localize"STR_INTSECT_CONHOSETTANK",
	{[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;}
],
[
	"A3PL_FD_HydrantWrench_F",
	localize"STR_INTSECT_OPENHYDR",
	{[player_objintersect] call A3PL_FD_WrenchRotate;}
],
[
	"A3PL_FD_HydrantWrench_F",
	localize"STR_INTSECT_CLOSEHYDR",
	{[player_objintersect] call A3PL_FD_WrenchRotate;}
],
[
	"",
	localize"STR_INTSECT_CUFFUN",
	{
		if(!(call A3PL_Player_AntiSpam)) exitWith {};
		if (player_objintersect getVariable ["Cuffed",true]) exitWith {[player_objintersect] call A3PL_Police_Uncuff;};
		if (Player_ItemClass == "handcuffs") then {
			[player_objintersect] call A3PL_Police_Cuff;
		} else {
			["You need handcuffs to do this!", Color_Red] call A3PL_Player_Notification;
		};
	}
],
[
	"",
	localize"STR_INTSECT_LPCUFF",
	{
		if(!(call A3PL_Player_AntiSpam)) exitWith {};
		[player_objintersect] call A3PL_Criminal_PickHandcuffs;
	}
],
[
	"",
	localize"STR_INTSECT_ZIPUN",
	{
		if(!(call A3PL_Player_AntiSpam)) exitWith {};
		if (player_objintersect getVariable ["Zipped",true]) exitWith {[player_objintersect] call A3PL_Criminal_Unzip;};
		if (Player_ItemClass == "zipties") then {
			[player_objintersect] call A3PL_Criminal_Ziptie;
		} else {
			[localize"STR_INTSECT_YouNeedZiptiesToDoThis", "red"] call A3PL_Player_Notification;
		};
	}
],
[
	"",
	localize"STR_INTSECT_HANDTICKET",
	{[player_objintersect] call A3PL_Police_GiveTicket;}
],
[
	"",
	localize"STR_INTSECT_KICKDOWN",
	{[player_objintersect] call A3PL_Police_CuffKick;}
],
[
	"",
	localize"STR_INTSECT_PATDOWN",
	{[player_objintersect] spawn A3PL_Police_PatDown;}
],
[
	"",
	"Remove Mask",
	{[player_objintersect] call A3PL_Police_RemoveMask;}
],
[
	"",
	localize"STR_INTSECT_DRAG",
	{[player_objintersect] call A3PL_Police_Drag;}
],
[
	"",
	localize"STR_INTSECT_DRAGH",
	{[player_objintersect] call A3PL_Criminal_Drag;}
],
[
	"",
	localize"STR_INTSECT_Grab",
	{[player_objintersect] call A3PL_USCG_Drag;}
],
[
	"",
	localize"STR_INTSECT_EJALLPASS",
	{[player_objintersect] call A3PL_Police_unDetain;}
],
[
	"",
	localize"STR_INTSECT_DETAINSUS",
	{[call A3PL_Intersect_Cursortarget] call A3PL_Police_Detain;}
],
[
    "A3PL_Stinger",
    localize"STR_INTSECT_DEPLSTR",
    {
        _veh = player_objintersect;
        if (_veh animationSourcePhase "Deploy_Stinger" < 0.5) then {
            _veh animateSource ["Deploy_Stinger",1];
        } else {
			[localize"STR_INTSECT_SystemStingerIsAlreadyDeployed","red"] call A3PL_Player_Notification;
		};

    }
],
[
	"A3PL_Stinger",
	localize"STR_INTSECT_RETRACTSTR",
	{
        _veh = player_objintersect;
        if (_veh animationSourcePhase "Deploy_Stinger" > 0.5) then {
            _veh animateSource ["Deploy_Stinger",0];
        } else {
			[localize"STR_INTSECT_SystemStingerIsNotDeployed","red"] call A3PL_Player_Notification;
		};
    }
],
[
	"",
	localize"STR_INTSECT_TagMeat",
	{[player_objintersect] call A3PL_Hunting_Tag;}
]
