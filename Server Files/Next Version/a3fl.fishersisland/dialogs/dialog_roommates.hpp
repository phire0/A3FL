class Dialog_Roommates
{
	idd = 87;
	name = "Dialog_Roommates";
	movingEnable = false;
	enableSimulation = true;
	class controls
	{
		class BackPicture: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_Insurance.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class RoommateList: RscListbox
		{
			idc = 1500;
			x = 0.383906 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.176 * safezoneH;
		};
		/* TODO: Remove */
		class PriceDisplay: RscStructuredText
		{
			idc = 1100;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class button_insure: RscButtonEmpty
		{
			idc = 1601;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.765 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.04 * safezoneH;
			//action = "call A3PL_Housing_RemoveRoommate;";
			action = "[player, player getVariable [""house"", objNull]] remoteExec [""Server_Housing_GetRoommates"", 2];";
		};
		class button_close: RscButtonEmpty
		{
			idc = 1602;
			x = 0.634062 * safezoneW + safezoneX;
			y = 0.765 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.04 * safezoneH;
			action = "closeDialog 0;";
		};
	};
};