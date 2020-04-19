class Dialog_Shop
{
	idd = 20;
	name= "Dialog_Shop";
	movingEnable = false;
	enableSimulation = true;
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Winston Halstead, v1.063, #Sicuza)
		////////////////////////////////////////////////////////
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_Shops.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class button_buy: RscButtonEmpty
		{
			idc = 1602;
			text = "";
			x = 0.0720312 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class button_sell: RscButtonEmpty
		{
			idc = 1603;
			text = "";
			x = 0.0720312 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class list: RscListbox
		{
			idc = 1500;
			x = 0.0410937 * safezoneW + safezoneX;
			y = 0.245 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class edit_amount: RscEdit
		{
			idc = 1400;
			x = 0.070 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0249 * safezoneH;
		};
		class stock: RscStructuredText
		{
			idc = 1102;
			text = "";
			x = 0.154531 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class buyP: RscStructuredText
		{
			idc = 1100;
			text = "";
			x = 0.154531 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class sellP: RscStructuredText
		{
			idc = 1101;
			text = "";
			x = 0.154531 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class slider_dir: RscSlider
		{
			idc = 1900;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.85 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};