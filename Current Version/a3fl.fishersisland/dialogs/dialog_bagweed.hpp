class Dialog_BagWeed
{
	idd = 74;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "A3PL_JobFarming_Scale = nil;";
	class controls
	{
		class static_bg: IGUIBack
		{
			idc = 2200;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class text_info: RscText
		{
			idc = 1000;
			text = $STR_BAGWEED_GUIINFO; 
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.016 * safeZoneH;
		};
		class edit_grams: RscEdit
		{
			idc = 1400;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_amount: RscText
		{
			idc = 1001;
			text = $STR_BAGWEED_GUIAMOUNT; 
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.017 * safeZoneH;
		};
		class button_bag: RscButton
		{
			idc = 1600;
			text = $STR_BAGWEED_GUIBAG; 
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};