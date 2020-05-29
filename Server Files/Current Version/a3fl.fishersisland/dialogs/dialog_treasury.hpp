class Dialog_Treasury
{
	idd = 109;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Vuxuby)
		////////////////////////////////////////////////////////
		class static_bg: RscPicture
		{
			idc = 1201;
			text = "\A3PL_Common\gui\A3PL_treasury3.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class edit_salesbalance: RscEdit
		{
			idc = 1400;
			x = 0.348906 * safezoneW + safezoneX;
			y = 0.312074 * safezoneH + safezoneY;
			w = 0.110782 * safezoneW;
			h = 0.0257037 * safezoneH;
		};
		class edit_totalbalance: RscEdit
		{
			idc = 1402;
			x = 0.348333 * safezoneW + safezoneX;
			y = 0.348778 * safezoneH + safezoneY;
			w = 0.111302 * safezoneW;
			h = 0.0266296 * safezoneH;
		};
		class edit_setTax: RscEdit
		{
			idc = 1403;
			x = 0.348437 * safezoneW + safezoneX;
			y = 0.509148 * safezoneH + safezoneY;
			w = 0.110781 * safezoneW;
			h = 0.0257038 * safezoneH;
		};
		class edit_addfactionbalance: RscEdit
		{
			idc = 1404;
			x = 0.348334 * safezoneW + safezoneX;
			y = 0.68237 * safezoneH + safezoneY;
			w = 0.111302 * safezoneW;
			h = 0.0257037 * safezoneH;
		};
		class button_setTax: RscButtonEmpty
		{
			idc = 1600;
			x = 0.466355 * safezoneW + safezoneX;
			y = 0.503555 * safezoneH + safezoneY;
			w = 0.0366145 * safezoneW;
			h = 0.0348519 * safezoneH;
			action = "call A3PL_Government_SetTax;";
		};
		class combo_selectbalance: RscCombo
		{
			idc = 2100;
			x = 0.338854 * safezoneW + safezoneX;
			y = 0.273518 * safezoneH + safezoneY;
			w = 0.129948 * safezoneW;
			h = 0.0238519 * safezoneH;
		};
		class combo_selectTax: RscCombo
		{
			idc = 2101;
			x = 0.339167 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.129948 * safezoneW;
			h = 0.0238519 * safezoneH;
		};
		class combo_selectFaction: RscCombo
		{
			idc = 2102;
			x = 0.339635 * safezoneW + safezoneX;
			y = 0.637556 * safezoneH + safezoneY;
			w = 0.129427 * safezoneW;
			h = 0.022926 * safezoneH;
		};
		class RscCombo_2103: RscCombo
		{
			idc = 2103;
			x = 0.694271 * safezoneW + safezoneX;
			y = 0.279889 * safezoneH + safezoneY;
			w = 0.0846354 * safezoneW;
			h = 0.0247778 * safezoneH;
		};
		class text_lawtext: RscStructuredText
		{
			idc = 1000;
			x = 0.539167 * safezoneW + safezoneX;
			y = 0.32563 * safezoneH + safezoneY;
			w = 0.257187 * safezoneW;
			h = 0.174111 * safezoneH;
		};
		class edit_setLaw: RscEdit
		{
			idc = 1401;
			x = 0.536563 * safezoneW + safezoneX;
			y = 0.572482 * safezoneH + safezoneY;
			w = 0.261875 * safezoneW;
			h = 0.0284815 * safezoneH;
		};
		class button_addfaction: RscButtonEmpty
		{
			idc = 1601;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.044 * safezoneH;
			action = "call A3PL_Government_AddBalance;";
		};
		class button_setlaw: RscButtonEmpty
		{
			idc = 1602;
			x = 0.525781 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.044 * safezoneH;
			action = "call A3PL_Government_SetLaw;";
		};
		class button_addlaw: RscButtonEmpty
		{
			idc = 1603;
			x = 0.62375 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.044 * safezoneH;
			action = "call A3PL_Government_AddLaw;";
		};
		
		class button_removelaw: RscButtonEmpty
		{
			idc = 1605;
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.044 * safezoneH;
			action = "call A3PL_Government_RemoveLaw;";
		};		
		
		class button_close: RscButtonEmpty
		{
			idc = 1604;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
			action = "closeDialog 0;";
		};
	};
};

class Dialog_FactionBudget_History
{
	idd = 138;
	movingEnable = 0;
	enableSimulation = 1;
	class controls
	{
		class static_bg: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_Company_History.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class History: RscListbox
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