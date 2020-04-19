class Dialog_Laws
{
	idd = 99;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Winston Halstead, v1.063, #Qaxoqy)
		////////////////////////////////////////////////////////
		class static_bg: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_GovLaws.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class LawsList: RscListbox
		{
			idc = 1500;
			x = 0.237031 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.525937 * safezoneW;
			h = 0.495 * safezoneH;
		};
		class BTN_Close: RscButtonEmpty
		{
			idc = 1600;
			action = "closeDialog 0;";
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};