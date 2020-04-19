class Dialog_HUD_Overlay
{
	idd = 234;
	fadeout = 0;
	fadein = 0;
	duration = 1e+1000;
	onLoad = "disableSerialization; uiNamespace setVariable ['A3PL_HUD_Overlay',_this select 0];";
	onUnload = "";

	class controlsBackground
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Kinime)
		////////////////////////////////////////////////////////

		class MainOverlay: RscPicture
		{
			idc = 1200;
			text = "";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};

		class SecondOverlay: RscPicture
		{
			idc = 1201;
			text = "";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
	class controls
	{
	};
};

class Dialog_HUD_AdminCursor
{
	idd = 44875;
	duration = 1e+012;
	onLoad = "uiNamespace setVariable [""Dialog_HUD_AdminCursor"", _this select 0]";
	class Controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Xyxyle)
		////////////////////////////////////////////////////////

		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.22492 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.297086 * safezoneH;
		};
		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.22492 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.297086 * safezoneH;
		};
		class RscText_1000: RscStructuredText
		{
			idc = 1000;
			text = $STR_ADMIN_CURSORNO; //--- ToDo: Localize;
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.22492 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.0440128 * safezoneH;
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.268933 * safezoneH + safezoneY;
			w = 0.144371 * safezoneW;
			h = 0.187054 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = ""; 
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.46699 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.0440128 * safezoneH;
		};
		class frameding: RscStructuredText
		{
			idc = 2414;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.268933 * safezoneH + safezoneY;
			w = 0.144371 * safezoneW;
			h = 0.187054 * safezoneH;
		};
		class RscText_1008: RscText
		{
			idc = 1008;
			text = $STR_ADMIN_GUIF2QUIT;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.522006 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
			style = ST_CENTER;  // defined constant

		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};