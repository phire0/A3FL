class Dialog_HouseBuy
{
	idd = 72;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_HouseBuy.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class button_yes: RscButtonEmpty
		{
			idc = -1;
			x = 0.378802 * safezoneW + safezoneX;
			y = 0.588926 * safezoneH + safezoneY;
			w = 0.0980208 * safezoneW;
			h = 0.0367037 * safezoneH;
			action = "call A3PL_Housing_Buy;";
		};
		class button_no: RscButtonEmpty
		{
			idc = -1;
			x = 0.514114 * safezoneW + safezoneX;
			y = 0.586519 * safezoneH + safezoneY;
			w = 0.0994268 * safezoneW;
			h = 0.0384444 * safezoneH;
			action = "closeDialog 0; A3PL_Housing_Object = nil;";
		};
		class text_currentPrice: RscText
		{
			idc = 1000;
			text = "$"; 
			x = 0.542239 * safezoneW + safezoneX;
			y = 0.43337 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			sizeEx = "0.03 * safezoneH";
		};
	};
};