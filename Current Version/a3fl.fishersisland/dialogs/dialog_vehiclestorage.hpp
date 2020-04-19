class Dialog_VehicleStorage
{
	idd = 30;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "A3PL_Veh_Interact setVariable ['inuse',nil,true]; A3PL_Veh_Interact = nil;";
	class controls
	{
		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_VehicleStorage.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class lb_inventory: RscListbox
		{
			idc = 1500;
			x = 0.272083 * safezoneW + safezoneX;
			y = 0.324926 * safezoneH + safezoneY;
			w = 0.217083 * safezoneW;
			h = 0.360407 * safezoneH;
		};
		class lb_storage: RscListbox
		{
			idc = 1501;
			x = 0.509844 * safezoneW + safezoneX;
			y = 0.323445 * safezoneH + safezoneY;
			w = 0.218125 * safezoneW;
			h = 0.362259 * safezoneH;
		};
		class button_store: RscButtonEmpty
		{
			idc = 1600;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.701482 * safezoneH + safezoneY;
			w = 0.0745833 * safezoneW;
			h = 0.0303333 * safezoneH;
		};
		class button_take: RscButtonEmpty
		{
			idc = 1601;
			x = 0.657291 * safezoneW + safezoneX;
			y = 0.699481 * safezoneH + safezoneY;
			w = 0.0735417 * safezoneW;
			h = 0.0331111 * safezoneH;
		};
		class edit_store: RscEdit
		{
			idc = 1400;
			text = "1";
			x = 0.317968 * safezoneW + safezoneX;
			y = 0.706222 * safezoneH + safezoneY;
			w = 0.0866146 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_take: RscEdit
		{
			idc = 1401;
			text = "1";
			x = 0.555625 * safezoneW + safezoneX;
			y = 0.707148 * safezoneH + safezoneY;
			w = 0.0868228 * safezoneW;
			h = 0.0210741 * safezoneH;
		};
		class InventoryCapacity: RscStructuredText
		{
			idc = 1100;
			x = 0.329844 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class VehcileCapacity: RscStructuredText
		{
			idc = 1101;
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class Close: RscButtonEmpty
		{
			idc = 1602;
			x = 0.716563 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};