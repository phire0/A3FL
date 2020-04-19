class Dialog_HUD_GPS {
	idd=-1;
	name="Dialog_HUD_GPS";
	onLoad="uiNamespace setVariable [""Dialog_HUD_GPS"",_this select 0]";
	movingEnable=0;
	fadein=6;
	duration=9999999999999;
	fadeout=0;
	class controlsBackground {
		class GPS_FRAME: RscPicture {
			idc = 23540;
			x = -0.0259375 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.252656 * safezoneW;
			h = 0.396 * safezoneH;
		};
		class GPS_AZIMUT_INFO: RscStructuredText {
			idc = 23542;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.835 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
			style = ST_CENTER;
		};
		class GPS_ALTITUDE_INFO: RscStructuredText {
			idc = 23543;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.863 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
			style = ST_CENTER;
		};
		class GPS_POSITION_INFO: RscStructuredText {
			idc = 23544;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.895 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
			style = ST_CENTER;
		};
		class GPS_MAP: RscMapControl {
			idc = 23539;
			x = 0.0514062 * safezoneW + safezoneX;
			y = 0.819 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.154 * safezoneH;
		};
	};
	class controls {};
};