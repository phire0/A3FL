class Dialog_Kane9
{
	idd = 93;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.242 * safezoneH;
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.154 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = $STR_KANE9_GUIBUY;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = "0.015 * safezoneH";
			action = "call A3PL_Dogs_BuyRequest;";
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = $STR_KANE9_GUIPRICE;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.015 * safezoneH";
		};
	};
};