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
			// Fix location.
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
		class button_remove: RscButtonEmpty
		{
			idc = 1601;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.765 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[player] call A3PL_Housing_RemoveRoommate;";
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