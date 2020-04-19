class Dialog_NewPlayer
{
	idd = 111;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class static_background: IGUIBack
		{
			idc = 2200;
			x = 0.335 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.33 * safezoneW;
			h = 0.297 * safezoneH;
		};
		class struc_header: RscStructuredText
		{
			idc = 1100;
			text = $STR_NEWPLAYER_GUIWELCOME;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.268125 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class static_firstname: RscText
		{
			idc = 1001;
			text = $STR_NEWPLAYER_GUIFIRSTNAME;
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_lastname: RscText
		{
			idc = 1002;
			text = $STR_NEWPLAYER_GUILASTNAME;
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_firstname: RscEdit
		{
			idc = 1400;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_lastname: RscEdit
		{
			idc = 1401;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class button_submit: RscButton
		{
			idc = 1600;
			text = $STR_NEWPLAYER_GUISEND;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.033 * safezoneH;
			action = "[] call A3PL_Player_NewPlayerSubmit;";
		};
		class static_gender: RscText
		{
			idc = 1003;
			text = $STR_NEWPLAYER_GUISEX;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_dob: RscText
		{
			idc = 1004;
			text = $STR_NEWPLAYER_GUIDOB;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_gender: RscCombo
		{
			idc = 1403;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_day: RscCombo
		{
			idc = 1404;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_month: RscCombo
		{
			idc = 1405;
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_year: RscCombo
		{
			idc = 1406;
			x = 0.613437 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};
