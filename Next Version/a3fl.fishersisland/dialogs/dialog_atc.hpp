class Dialog_ATC {
	idd = 91;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class background_radar: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\ATC\atc_background.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};
		class background_rotating: RscPicture
		{
			idc = 1201;
			text = "\A3PL_Common\GUI\ATC\atc_radar.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};
		class aircraft_background: IGUIBack
		{
			idc = 2200;
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.374 * safezoneH;
		};
		class static_callsign: RscText
		{
			idc = 1000;
			text = $STR_ATC_GUICALLSIGN; 
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.016 * safezoneH";
		};
		class static_header: RscText
		{
			idc = 1001;
			text = $STR_ATC_GUIHEADER; 
			x = 0.737188 * safezoneW + safezoneX;
			y = 0.104 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = "0.018 * safezoneH";
		};
		class static_type: RscText
		{
			idc = 1002;
			text = $STR_ATC_GUITYPE; 
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.159 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.016 * safezoneH";
		};
		class edit_type: RscEdit
		{
			idc = 1400;
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.159 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_callsign: RscEdit
		{
			idc = 1401;
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_squawk: RscText
		{
			idc = 1003;
			text = $STR_ATC_GUISQUAWK; 
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.016 * safezoneH";
		};
		class edit_squawk: RscEdit
		{
			idc = 1402;
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_transponder: RscText
		{
			idc = 1004;
			text = $STR_ATC_GUITRANSPONDER; 
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.016 * safezoneH";
		};
		class edit_transponder: RscEdit
		{
			idc = 1403;
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_heading: RscText
		{
			idc = 1005;
			text = $STR_ATC_GUITITLE; 
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.016 * safezoneH";
		};
		class edit_heading: RscEdit
		{
			idc = 1404;
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class RscText_1011: RscText
		{
			idc = 1011;
			text = $STR_ATC_GUIRADARRADIUS; 
			x = 0.43875 * safezoneW + safezoneX;
			y = 0.104 * safezoneH + safezoneY;
			w = 0.12 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.018 * safezoneH";
		};

		class button_decrease: RscButton
		{
			idc = 1600;
			text = "-"; 
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.093 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class button_increase: RscButton
		{
			idc = 1601;
			text = "+"; 
			x = 0.665 * safezoneW + safezoneX;
			y = 0.093 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class static_clearance: RscText
		{
			idc = 1006;
			text = $STR_ATC_GUICLEARANCE; 
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = "0.016 * safezoneH";
		};
		class checkbox_clearance: RscTextCheckbox
		{
			idc = 2500;
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class button_transfer: RscButton
		{
			idc = 1602;
			text = $STR_ATC_GUITRANSFER; 
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class static_ias: RscText
		{
			idc = 1007;
			text = $STR_ATC_GUIIAS; 
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.016 * safezoneH";
		};
		class edit_ias: RscEdit
		{
			idc = 1405;
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_alt: RscText
		{
			idc = 1008;
			text = $STR_ATC_GUIALT; 
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.016 * safezoneH";
		};
		class edit_altitude: RscEdit
		{
			idc = 1406;
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class struc_airportInfo: RscStructuredText
		{
			idc = 1100;
			x = 0.133906 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 1 * safezoneH;
			sizeEx = "0.02 * safezoneH";
		};
		class header_atis: RscText
		{
			idc = 1009;
			text = $STR_ATC_GUIATIS; 
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.874 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.02 * safezoneH";
		};
		class background_atis: IGUIBack
		{
			idc = 2201;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.896 * safezoneH + safezoneY;
			w = 0.422812 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class header_airportinfo: RscText
		{
			idc = 1010;
			text = $STR_ATC_GUIAIRPORTINFO; 
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.104 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.018 * safezoneH";
		};
		class edit_atis: RscEdit
		{
			idc = 1407;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.896 * safezoneH + safezoneY;
			w = 0.422812 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class button_previewATIS: RscButton
		{
			idc = 1603;
			text = $STR_ATC_GUIPREVIEWATIS; 
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.929 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class button_pushATIS: RscButton
		{
			idc = 1604;
			text = $STR_ATC_GUIPUSHATIS; 
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.929 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};