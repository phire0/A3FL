/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

class DefaultEventhandlers;
class CfgPatches
{
	class A3FLS
	{
		author[]= {"Winston"};
		fileName = "A3FLS.pbo";
		units[] = {};
		weapons[] = {};
		requiredAddons[] = {};
	};
};

class cfgFunctions
{
	class bootstrap
	{
		class main
		{
			file = "\A3FLS";
			class preinit { preinit = 1; };
		};
	};
};

class CfgRemoteExec
{
	class Commands
    {
		mode = 0;
	};
	class Functions
	{
		mode = 1;
		jip = 0;

		//BIS
		class BIS_fnc_effectKilledAirDestruction {};
		class BIS_fnc_effectKilledSecondaries {};
		class BIS_fnc_objectVar {};
		class bis_fnc_setidentity {allowedTargets=0;};
		class BIS_fnc_earthquake {allowedTargets=0;};

		//Storage
		class A3PL_Storage_ObjectsReceive {allowedTargets = 0;};
		class A3PL_Storage_ObjectRetrieveResponse {allowedTargets = 0;};
		class A3PL_Storage_CarRetrieveResponse {allowedTargets = 0;};
		class A3PL_Storage_CarStoreResponse {allowedTargets = 0;};
		class A3PL_Storage_VehicleReceive {allowedTargets = 0;};
		class Server_Storage_StoreObject{allowedTargets=2;};
		class Server_Storage_Vehicle{allowedTargets = 2;};
		class Server_Storage_SaveLargeVehicles {allowedTargets = 2;};
		class Server_Storage_RetrieveVehicle {allowedTargets = 2;};
		class Server_Storage_StoreVehicle {allowedTargets = 2;};
		class Server_Storage_RetrieveObject {allowedTargets = 2;};
		class Server_Storage_ReturnObjects {allowedTargets = 2;};
		class Server_Storage_ReturnVehicles {allowedTargets = 2;};
		class Server_Storage_ChangeVehicleName{allowedTargets=2;};

		//Admin
		class A3PL_Admin_UserInputCheck{allowedTargets=0;};

		//Player
		class A3PL_Player_News{allowedTargets=0;};
		class A3PL_Player_Notification {allowedTargets = 0;};
		class A3PL_Player_NewPlayer{allowedTargets = 0;};
		class A3PL_Player_Whitelist{allowedTargets=0;};
		class A3PL_Player_SetMarkers{allowedTargets=0;};
		class A3PL_Player_CheckWhitelistServer{allowedTargets=0;};
		class A3PL_Player_Restart{allowedTargets=0;};
		class Server_Player_Whitelist{allowedTargets=2;};
		class Server_Player_AdminWatch{allowedTargets=2;};
		class Server_Player_LocalityRequest{allowedTargets=2;};
		class Server_Player_UpdatePaycheck{allowedTargets=2;};
		class Server_Player_Level_Save{allowedTargets = 2;};

		//Criminal
		class A3PL_Criminal_DragReceive{allowedTargets = 0;};

		//Gangs
		class A3PL_Gang_InviteReceived{allowedTargets=0;};
		class A3PL_Gang_SetData{allowedTargets=0;};
		class A3PL_Gang_Kicked{allowedTargets=0;};
		class A3PL_Gang_Created{allowedTargets=0;};
		class Server_Gang_Create{allowedTargets=2;};
		class Server_Gang_SaveMembers{allowedTargets=2;};
		class Server_Gang_SaveBank{allowedTargets=2;};
		class Server_Gang_DeleteGang{allowedTargets=2;};
		class Server_Gang_SetLead{allowedTargets=2;};

		//Locker
		class Server_Locker_Save{allowedTargets=2;};
		class Server_Locker_Insert{allowedTargets=2;};

		//Fuel
		class Server_Fuel_Pay{allowedTargets=2;};
		class Server_Fuel_Load{allowedTargets = 2;};
		class Server_Fuel_Save{allowedTargets = 2;};
		class Server_Fuel_TakeCash{allowedTargets=2;};
		class Server_Fuel_Vehicle{allowedTargets=2;};

		//Uber
		class Server_Uber_AddDriver{allowedTargets=2;};
		class Server_Uber_FlushDrivers{allowedTargets=2;};
		class Server_Uber_RemoveDriver{allowedTargets=2;};
		class Server_Uber_RequestDriver{allowedTargets=2;};

		//Housing
		class A3PL_Housing_Loaditems {allowedTargets = 0;};
		class A3PL_Housing_AptAssignedMsg {allowedTargets = 0;};
		class A3PL_Housing_SetMarker{allowedTargets=0;};
		class Server_Housing_Sold{allowedTargets=2;};
		class Server_Housing_dropKey {allowedTargets = 2;};
		class Server_Housing_PickupKey {allowedTargets = 2;};
		class Server_Housing_BuyTickets {allowedTargets = 2;};
		class Server_Housing_AssignHouse {allowedTargets = 2;};
		class Server_Housing_LoadBox {allowedTargets = 2;};
		class Server_Housing_SaveBox {allowedTargets = 2;};
		class Server_Housing_CreateKey {allowedTargets = 2;};
		class Server_Housing_LoadItemsSimulation {allowedTargets = 2;};
		class Server_Housing_AddMember{allowedTargets=2;};
		class Server_Housing_RemoveMember{allowedTargets=2;};
		class Server_Housing_Initialize{allowedTargets=2;};

		// Warehouses
		class A3PL_Warehouses_Loaditems {allowedTargets = 0;};
		class A3PL_Housing_SetMarker{allowedTargets=0;};
		class Server_Warehouses_Assign {allowedTargets = 2;};
		class Server_Warehouses_LoadBox {allowedTargets = 2;};
		class Server_Warehouses_SaveBox {allowedTargets = 2;};
		class Server_Warehouses_LoadItemsSimulation {allowedTargets = 2;};
		class Server_Warehouses_Initialize{allowedTargets=2;};
		class Server_Warehouses_RemoveMember{allowedTargets=2;};
		class Server_Warehouses_AddMember{allowedTargets=2;};
		class Server_Warehouses_RemoveMember{allowedTargets=2;};

		//Police
		class A3PL_Police_ReleasePlayer {allowedTargets = 0;};
		class A3PL_Police_PanicMarker{allowedTargets=0;};
		class A3PL_Police_HandleAnim {allowedTargets = 0;};
		class A3PL_Police_SurrenderAnim {allowedTargets = 0;};
		class A3PL_Police_DragReceive {allowedTargets = 0;};
		class A3PL_Police_ReceiveTicket {allowedTargets = 0;};
		class A3PL_Police_GiveTicketResponse {allowedTargets = 0;};
		class A3PL_Police_ImpoundMsg {allowedTargets = 0;};
		class A3PL_Police_DatabaseEnterReceive {allowedTargets = 0;};
		class A3PL_Police_BreathalizerReturn{allowedTargets=0;};
		class Server_Police_JailPlayer {allowedTargets = 2;};
		class Server_Police_Database {allowedTargets = 2;};
		class Server_Police_PayTicket {allowedTargets = 2;};
		class Server_Police_Impound {allowedTargets = 2;};

		//Fire & FD
		class A3PL_FD_DatabaseEnterReceive {allowedTargets=0;};
		class Server_FD_Database{allowedTargets=2;};
		class Server_FD_SwitchClinic{allowedTargets=2;};
		class Server_Fire_VehicleExplode{allowedTargets=2;};
		class Server_Fire_StartFire {allowedTargets = 2;};
		class Server_Fire_RemoveFires {allowedTargets = 2;};
		class Server_Fire_PauseFire{allowedTargets=2;};
		class Server_Fire_PauseCheck{allowedTargets=2;};

		//Garage
		class A3PL_Garage_SetLicensePlateResponse {allowedTargets = 0;};
		class Server_Garage_UpdateAddons{allowedTargets=2;};

		//Vehicle
		class A3PL_Vehicle_SetAllKeys{allowedTargets=0;};
		class A3PL_Vehicle_AddKey{allowedTargets=0;};
		class A3PL_Vehicle_DestroyedMsg {allowedTargets = 0;};
		class A3PL_Vehicle_AtegoTowResponse {allowedTargets = 0;};
		class Server_Vehicle_Sell{allowedTargets=2;};
		class Server_Vehicle_SetPaint{allowedTargets=2;};
		class Server_Vehicle_Trailer_Hitch {allowedTargets = 2;};
		class Server_Vehicle_Spawn {allowedTargets = 2;};
		class Server_Vehicle_EnableSimulation {allowedTargets = 2;};
		class Server_Vehicle_AtegoHandle {allowedTargets = 2;};
		class Server_Vehicle_TrailerDetach {allowedTargets = 2;};
		class Server_Vehicle_InitLPChange {allowedTargets = 2;};
		class Server_Vehicle_Insure{allowedTargets=2;};
		class Server_Vehicle_SaveKeys{allowedTargets=2;};

		//Gear
		class Server_Gear_Save{allowedTargets = 2;};
		class Server_Gear_NewReceive {allowedTargets = 2;};
		class Server_Gear_Load {allowedTargets = 2;};

		//Inventory
		class A3PL_Inventory_Add{allowedTargets=0;};
		class A3PL_Inventory_Clear{allowedTargets = 0;};
		class Server_Inventory_RemoveAll{allowedTargets = 2;};
		class Server_Inventory_Add{allowedTargets = 2;};
		class Server_Inventory_Drop{allowedTargets = 2;};
		class Server_Inventory_Pickup{allowedTargets = 2;};

		//Core
		class Server_Core_Locality{allowedTargets=2;};
		class Server_Core_ChangeVar {allowedTargets = 2;};
		class Server_Core_KickPlayer{allowedTargets=2;};
		class Server_Core_BanPlayer{allowedTargets=2;};
		class Server_Core_Restart{allowedTargets=2;};
		class Server_Core_RestartTimer{allowedTargets=2;};
		class Server_Core_RestartDev{allowedTargets=2;};
		class Server_Core_DblXP{allowedTargets=2;};
		class Server_Core_DblHarvest{allowedTargets=2;};
		class Server_Core_PaycheckBonus{allowedTargets=2;};
		class Server_Core_WhitelistServer{allowedTargets=2;};

		//NPC
		class A3PL_NPC_TakeJobResponse{allowedTargets = 0;};
		class Server_NPC_RequestJob{allowedTargets = 2;};

		//ChopShop
		class Server_Chopshop_Storecar{allowedTargets = 2;};
		class Server_Chopshop_Chop{allowedTargets = 2;};

		//Job Oil
		class A3PL_JobOil_PumpReceive {allowedTargets = 0;};
		class Server_JobOil_PumpStart {allowedTargets = 2;};
		class A3PL_JobOil_Pump_Animation{allowedTargets = 0;};

		//Job mailman
		class Server_JobMDelivery_SendJobList{allowedTargets = 2;};
		class Server_JobMDelivery_Take{allowedTargets = 2;};
		class Server_JobMDelivery_Collect{allowedTargets = 2;};
		class Server_JobMDelivery_Deliver{allowedTargets = 2;};

		//Job Mcfisher
		class A3PL_JobMcfisher_CookBurger {allowedTargets = 0;};
		class Server_JobMcfisher_combine {allowedTargets = 2;};
		class Server_JobMcfisher_cookthres {allowedTargets = 2;};

		//Job Fisherman
		class A3PL_JobFisherman_DeployNetResponse {allowedTargets = 0;};
		class A3PL_JobFisherman_DeployNetSuccess {allowedTargets = 0;};
		class Server_JobFisherman_DeployNet {allowedTargets = 2;};
		class Server_JobFisherman_GrabNet {allowedTargets = 2;};

		//Job Farming
		class A3PL_JobFarming_PlantReceive {allowedTargets = 0;};
		class Server_JobFarming_Plant {allowedTargets = 2;};
		class Server_JobFarming_Harvest {allowedTargets = 2;};

		//Job Roadworker
		class A3PL_JobRoadWorker_MarkResponse {allowedTargets = 0;};
		class Server_JobRoadWorker_UnMark {allowedTargets = 2;};
		class Server_JobRoadWorker_Mark {allowedTargets = 2;};
		class Server_JobRoadWorker_Impound {allowedTargets = 2;};

		//Job Wildcat
		class Server_JobWildCat_SpawnRes {allowedTargets = 2;};

		//Dogs
		class A3PL_Dogs_BuyReceive {allowedTargets = 0;};
		class Server_Dogs_BuyRequest {allowedTargets = 2;};
		class Server_Dogs_HandleLocality {allowedTargets = 2;};

		//Drugs/Alcohol
		class A3PL_Alcohol_Verify{allowedTargets=0;};
		class A3PL_Alcohol_Add{allowedTargets=0;};
		class A3PL_Drugs_Add{allowedTargets=0;};
		class A3PL_Drugs_DrugTestReturn{allowedTargets=0;};

		//Factory
		class Server_Factory_Create{allowedTargets = 2;};
		class Server_Factory_Finalise{allowedTargets = 2;};
		class Server_Factory_Collect{allowedTargets = 2;};
		class Server_Factory_Add{allowedTargets = 2;};

		//Government
		class A3PL_Government_HistoryReceive{allowedTargets = 0;};
		class A3PL_Government_NewTax {allowedTargets = 0;};
		class A3PL_Government_NewLaw {allowedTargets = 0;};
		class A3PL_Government_NewVote {allowedTargets = 0;};
		class A3PL_Government_NewMayor {allowedTargets = 0;};
		class A3PL_Government_FactionSetupReceive {allowedTargets = 0;};
		class Server_Government_AddBalance {allowedTargets = 2;};
		class Server_Government_HistorySetup{allowedTargets = 2;};
		class Server_Government_SetTax {allowedTargets = 2;};
		class Server_Government_ChangeLaw {allowedTargets = 2;};
		class Server_Government_AddVote {allowedTargets = 2;};
		class Server_Government_AddCandidate {allowedTargets = 2;};
		class Server_Government_FactionSetupInfo {allowedTargets = 2;};
		class Server_Government_SetRank {allowedTargets = 2;};
		class Server_Government_AddRank {allowedTargets = 2;};
		class Server_Government_RemoveRank {allowedTargets = 2;};
		class Server_Government_SetPay {allowedTargets = 2;};
		class Server_Government_StartVote {allowedTargets = 2;};
		class Server_Government_Alarm{allowedTargets=2;};

		//Log
		class Server_Log_New {allowedTargets = 2;};
		class Server_AdminLoginsert {allowedTargets = 2;};

		//Company
		class A3PL_Company_BillDataReceive{allowedTargets=0;};
		class A3PL_Company_HiringConfirmation{allowedTargets=0;};
		class A3PL_Company_HistoryReceive{allowedTargets=0;};
		class A3PL_Company_RegisterReceive{allowedTargets=0;};
		class A3PL_Company_ManageReceive{allowedTargets=0;};
		class A3PL_Company_ReceiveBill{allowedTargets=0;};
		class Server_Company_HistorySetup{allowedTargets=2;};
		class Server_Company_LoadBills{allowedTargets=2;};
		class Server_Company_LoadBillData{allowedTargets=2;};
		class Server_Company_SetPay{allowedTargets=2;};
		class Server_Company_ManageSetup{allowedTargets=2;};
		class Server_Company_SetDesc{allowedTargets=2;};
		class Server_Company_Fire{allowedTargets=2;};
		class Server_Company_Recruit{allowedTargets=2;};
		class Server_Company_SetBank{allowedTargets=2;};
		class Server_Company_SetLicenses{allowedTargets=2;};
		class Server_Company_Create{allowedTargets=2;};
		class Server_Company_RegisterSetup{allowedTargets=2;};
		class Server_Company_SendBill{allowedTargets=2;};
		class Server_Company_LoadCBillPhone{allowedTargets=2;};
		class Server_Company_PayBill{allowedTargets=2;};

		class Server_Company_SaveStorage{allowedTargets=2;};
		class Server_Company_GetStorageData{allowedTargets=2;};

		//Twitter
		class A3PL_Twitter_NewMsg {allowedTargets = 0;};
		class Server_Twitter_HandleMsg {allowedTargets = 2;};

		//Business
		class A3PL_Business_BuyItemReceive {allowedTargets = 0;};
		class Server_Business_Buy {allowedTargets = 2;};
		class Server_Business_Sellitem {allowedTargets = 2;};
		class Server_Business_Sellitemstop {allowedTargets = 2;};
		class Server_Business_BuyItem {allowedTargets = 2;};
		class Server_Business_CheckRentTime {allowedTargets=2;};

		//DMV
		class Server_DMV_Add {allowedTargets = 2;};

		//Import Export
		class A3PL_IE_ShipLost {allowedTargets = 0;};
		class A3PL_IE_ShipArrived {allowedTargets = 0;};
		class A3PL_IE_ShipLeft {allowedTargets = 0;};
		class Server_IE_ShipImport {allowedTargets = 2;};

		//Criminal
		class Server_Criminal_RemoveJail{allowedTargets=2;};

		//Debug
		class A3PL_Debug_ExecuteCompiled{allowedTargets=2;};

		//Medical
		class A3PL_Medical_Die{allowedTargets=0;};
		class A3PL_Medical_DeadMarker{allowedTargets=0;};

		//Lib
		class A3PL_Lib_SyncAnim {allowedTargets = 0;};
		class A3PL_Lib_Gesture {allowedTargets = 0;};
		class A3PL_Lib_MoveInPass {allowedTargets = 0;};
		class A3PL_Lib_ChangeLocality {allowedTargets = 2;};
		class A3PL_Lib_HideObject {allowedTargets = 0;};
		class A3PL_Lib_CreateMarker {allowedTargets=0;};

		//HUD
		class A3PL_Hud_IDCard {allowedTargets = 0;};

		//Items
		class A3PL_Items_RemoteRocket {allowedTargets = 0;};

		//Store Robbery
		class A3PL_Store_Robbery_Marker{allowedTargets=0;};
		class A3PL_Store_Robbery_Alert{allowedTargets=0;};
		class A3PL_Robberies_PortAlert{allowedTargets=0;};
		class A3PL_Robberies_SeizureAlert{allowedTargets=0;};

		//iPhoneX
		class A3PL_iPhoneX_SetJobNumber{allowedTargets=0;};
		class A3PL_iPhoneX_Contacts{allowedTargets=0;};
		class A3PL_iPhoneX_Conversations{allowedTargets=0;};
		class A3PL_iPhoneX_setPhoneNumber{allowedTargets=0;};
		class A3PL_iPhoneX_SMS{allowedTargets=0;};
		class A3PL_iPhoneX_ReceiveSMS{allowedTargets=0;};
		class A3PL_iPhoneX_GetPhoneNumberSubscription{allowedTargets=0;};
		class A3PL_iPhoneX_NumberIsUsed{allowedTargets=0;};
		class A3PL_iPhoneX_EndCall{allowedTargets=0;};
		class A3PL_iPhoneX_StartCall{allowedTargets=0;};
		class A3PL_iPhoneX_ReceiveCall{allowedTargets=0;};
		class A3PL_iPhoneX_Switchboard{allowedTargets=0;};
		class A3PL_iPhoneX_SwitchboardSend{allowedTargets=0;};
		class A3PL_iPhoneX_SwitchboardReceive{allowedTargets=0;};
		class A3PL_iPhoneX_EndCallSwitchboard{allowedTargets=0;};
		class A3PL_iPhoneX_SMSEnterprise{allowedTargets=0;};
		class A3PL_iPhoneX_SetSettings{allowedTargets=0;};
		class A3PL_iPhoneX_SendSMS{allowedTargets=0;};
		class A3PL_iPhoneX_appBills{allowedTargets=0;};
		class A3PL_iPhoneX_appCompaniesBills{allowedTargets=0;};
		class Server_iPhoneX_DeleteContact{allowedTargets=2;};
		class Server_iPhoneX_AddPhoneNumber{allowedTargets=2;};
		class Server_iPhoneX_NumberIsUsed{allowedTargets=2;};
		class Server_iPhoneX_GetContacts{allowedTargets=2;};
		class Server_iPhoneX_GetConversations{allowedTargets=2;};
		class Server_iPhoneX_GetPhoneNumberActive{allowedTargets=2;};
		class Server_iPhoneX_GetPhoneNumberEnterprise{allowedTargets=2;};
		class Server_iPhoneX_GetSMS{allowedTargets=2;};
		class Server_iPhoneX_GetSwitchboard{allowedTargets=2;};
		class Server_iPhoneX_SetSwitchboard{allowedTargets=2;};
		class Server_iPhoneX_GetPhoneNumber{allowedTargets=2;};
		class Server_iPhoneX_SaveContact{allowedTargets=2;};
		class Server_iPhoneX_UpdatePhoneNumberActive{allowedTargets=2;};
		class Server_iPhoneX_SaveConversation{allowedTargets=2;};
		class Server_iPhoneX_SavePhoneNumberActive{allowedTargets=2;};
		class Server_iPhoneX_SendSMS{allowedTargets=2;};
		class Server_iPhoneX_SaveLastSMS{allowedTargets=2;};
		class Server_iPhoneX_GetListNumber{allowedTargets=2;};
		class Server_iPhoneX_GetSMSEnterprise{allowedTargets=2;};
		class Server_iPhoneX_CallSwitchboard{allowedTargets=2;};

		class A3PL_USCG_DragReceive{allowedTargets=0;};
	};
};
