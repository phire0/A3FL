class Dialog_Miranda
{
	idd = 12346;
	fadeout = 0;
	fadein = 0;
	duration = 1e+1000;
	onLoad = "disableSerialization; uiNamespace setVariable ['A3PL_HUD_MirandaCard',_this select 0];";
	onUnload = "";
	class controlsBackground
	{
		class RscPicture_1200: RscPicture
		{
			idc = -1;
			text = "A3PL_Common\GUI\A3PL_Miranda_Rights_Card.paa";
			x = 0.721719 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.304219 * safezoneW;
			h = 0.473 * safezoneH;
		};
	};
	class controls {};
};