class Dialog_PlayerGarage
{
	idd = 145;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Jon VanderZee, v1.063, #Hebemy)
		////////////////////////////////////////////////////////
		class P_Background: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\dialog_PlayerGarage.paa";
			x = -0.00221875 * safezoneW + safezoneX;
			y = -0.444999 * safezoneH + safezoneY;
			w = 1.00444 * safezoneW;
			h = 1.89145 * safezoneH;
		};
		class L_StoredVehicles: RscListbox
		{
			idc = 1500;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.344 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.312 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class L_VehicleInformation: RscListbox
		{
			idc = 1501;
			x = 0.525 * safezoneW + safezoneX;
			y = 0.344 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.112 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class TE_NewVehicleName: RscEdit
		{
			idc = 1400;
			x = 0.525 * safezoneW + safezoneX;
			y = 0.624 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.032 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class B_RetreiveVehicle: RscButton
		{
			idc = -1;
			x = 0.3475 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			action = "call A3PL_Storage_CarRetrieveButton;";
		};
		class B_RenameVehicle: RscButton
		{
			idc = -1;
			x = 0.5475 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			action = "call A3PL_Storage_ChangeVehicleName;";
		};
	};
};