class Dialog_WarehouseBuy
{
	idd = 75;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by David White, v1.063, #Surihy)
		////////////////////////////////////////////////////////

		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3FL_Warehouse.paa";
			x = -0.000156274 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class button_yes: RscButton
		{
			idc = 1600;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0980208 * safezoneW;
			h = 0.0367037 * safezoneH;
		};
		class button_no: RscButton
		{
			idc = 1601;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0994268 * safezoneW;
			h = 0.0384444 * safezoneH;
		};
		class static_currentPrice: RscText
		{
			idc = 1000;
			text = "31000$"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			sizeEx = 1.4 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};
