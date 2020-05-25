class Dialog_IE
{
	idd = 48;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_ImportSystem.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class lb_availableitems: RscListbox
		{
			idc = 1500;
			x = 0.272083 * safezoneW + safezoneX;
			y = 0.317852 * safezoneH + safezoneY;
			w = 0.2175 * safezoneW;
			h = 0.314259 * safezoneH;
		};
		class lb_myshipments: RscListbox
		{
			idc = 1501;
			x = 0.509791 * safezoneW + safezoneX;
			y = 0.31637 * safezoneH + safezoneY;
			w = 0.216459 * safezoneW;
			h = 0.444815 * safezoneH;
		};
		class edit_currentimport: RscEdit
		{
			idc = 1400;
			x = 0.382968 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.101927 * safezoneW;
			h = 0.0229259 * safezoneH;
			canModify = 0;
			style = "0x02 + 0x40";
		};
		class edit_currentexport: RscEdit
		{
			idc = 1401;
			x = 0.382968 * safezoneW + safezoneX;
			y = 0.676926 * safezoneH + safezoneY;
			w = 0.102448 * safezoneW;
			h = 0.0229259 * safezoneH;
			canModify = 0;
			style = "0x02 + 0x40";
		};
		class edit_amount: RscEdit
		{
			idc = 1402;
			x = 0.382448 * safezoneW + safezoneX;
			y = 0.707148 * safezoneH + safezoneY;
			w = 0.102448 * safezoneW;
			h = 0.022 * safezoneH;
			style = "0x02 + 0x40";
		};
		class button_import: RscButtonEmpty
		{
			idc = -1;
			x = 0.294218 * safezoneW + safezoneX;
			y = 0.773148 * safezoneH + safezoneY;
			w = 0.0746354 * safezoneW;
			h = 0.031148 * safezoneH;
			action = "[true] call A3PL_IE_addShipment;";
		};
		class button_export: RscButtonEmpty
		{
			idc = -1;
			x = 0.393542 * safezoneW + safezoneX;
			y = 0.773963 * safezoneH + safezoneY;
			w = 0.0746354 * safezoneW;
			h = 0.0311482 * safezoneH;
			action = "[false] call A3PL_IE_addShipment;";
		};
		class button_retrieve: RscButtonEmpty
		{
			idc = -1;
			x = 0.583542 * safezoneW + safezoneX;
			y = 0.773037 * safezoneH + safezoneY;
			w = 0.0734375 * safezoneW;
			h = 0.0339259 * safezoneH;
			action = "call A3PL_IE_collectShipment;";
		};
		class edit_totalprice: RscEdit
		{
			idc = 1403;
			x = 0.383437 * safezoneW + safezoneX;
			y = 0.738296 * safezoneH + safezoneY;
			w = 0.102448 * safezoneW;
			h = 0.022 * safezoneH;
			canModify = 0;
			style = "0x02 + 0x40";
		};
	};
};