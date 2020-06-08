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
		class BackgroundImage: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3FL_Warehouse.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class button_yes: RscButtonEmpty
		{
			idc = 1600;
			x = 0.385 * safezoneW + safezoneX;
			y = 0.543 * safezoneH + safezoneY;
			w = 0.0980208 * safezoneW;
			h = 0.0367037 * safezoneH;
			action = "call A3PL_Warehouses_Buy;";
		};
		class button_no: RscButtonEmpty
		{
			idc = 1601;
			action = "closeDialog 0;";
			x = 0.505 * safezoneW + safezoneX;
			y = 0.543 * safezoneH + safezoneY;
			w = 0.0994268 * safezoneW;
			h = 0.0384444 * safezoneH;
			action = "closeDialog 0; A3PL_Warehouses_Object = nil;";
		};
		class static_currentPrice: RscText
		{
			idc = 1000;
			text = "";
			x = 0.535 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			sizeEx = 1.3 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
