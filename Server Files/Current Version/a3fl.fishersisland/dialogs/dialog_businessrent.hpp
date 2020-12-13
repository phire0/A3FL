class Dialog_BusinessRent
{
	idd = 57;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Hyjupe)
		////////////////////////////////////////////////////////

		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_BusinessBuy.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class edit_businessname: RscEdit
		{
			idc = 1400;
			x = 0.478854 * safezoneW + safezoneX;
			y = 0.319481 * safezoneH + safezoneY;
			w = 0.135521 * safezoneW;
			h = 0.0303333 * safezoneH;
		};
		class rent_time: RscEdit
		{
			idc = 1900;
			text = "10";
			x = 0.478907 * safezoneW + safezoneX;
			y = 0.368926 * safezoneH + safezoneY;
			w = 0.135053 * safezoneW;
			h = 0.0303333 * safezoneH;
		};
		class struc_info: RscStructuredText
		{
			idc = 1100;
			x = 0.37797 * safezoneW + safezoneX;
			y = 0.416037 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class button_rent: RscButtonEmpty
		{
			idc = 1600;
			x = 0.378854 * safezoneW + safezoneX;
			y = 0.524778 * safezoneH + safezoneY;
			w = 0.0979167 * safezoneW;
			h = 0.0376297 * safezoneH;
			action = "[] call A3PL_Business_Rent";
		};
		class button_close: RscButtonEmpty
		{
			idc = -1;
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.523741 * safezoneH + safezoneY;
			w = 0.0979167 * safezoneW;
			h = 0.0394815 * safezoneH;
			action = "closeDialog 0;";
		};
		class button_close2: RscButtonEmpty
		{
			idc = -1;
			x = 0.597969 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0265625 * safezoneW;
			h = 0.0570741 * safezoneH;
			action = "closeDialog 0;";
		};
	};
};