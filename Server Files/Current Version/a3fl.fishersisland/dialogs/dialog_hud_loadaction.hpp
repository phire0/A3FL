class Dialog_HUD_LoadAction
{
	idd = 39;
	fadeout = 0;
	fadein = 0;
	duration = 1e+1000;
	onLoad = "disableSerialization; uiNamespace setVariable ['Dialog_HUD_LoadAction',_this select 0];";
	onUnload = "";
	class controlsBackground
	{
		class static_loadingImage: RscPicture
		{
			idc = 394;
			text = "\A3PL_Common\GUI\A3PL_LoadAction.paa";
			x = -0.000156274 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.995156 * safezoneW;
			h = 1.001 * safezoneH;
		};
		class Progress_loadingbar: RscProgress
		{
			idc = 350;
			colorFrame[] = {0.72,0.72,0.72,1};
			colorBar[] = {0.641,0.25,0.109,1};
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.295781 * safezoneW + safezoneX;
			y = 0.758445 * safezoneH + safezoneY;
			w = 0.403542 * safezoneW;
			h = 0.0413333 * safezoneH;
		};
		class Progress_welcomeHeader: RscStructuredText
		{
			idc = 351;
			text = "Action en cours...";
			x = 0.295781 * safezoneW + safezoneX;
			y = 0.768445 * safezoneH + safezoneY;
			w = 0.403542 * safezoneW;
			h = 0.0413333 * safezoneH;
		};
		class text_percentage: RscStructuredText
		{
			idc = 352;
			text = "0%"; 
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.0465 * safezoneW;
			h = 0.077 * safezoneH;
			sizeEx = 1.6 * GUI_GRID_H;
		};
	};
};