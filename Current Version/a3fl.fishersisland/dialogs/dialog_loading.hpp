class Dialog_Loading
{
	idd = 15;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class static_loadingImage: RscPicture
		{
			idc = IDC_DIALOG_LOADING_BACKGROUND;
			text = "\A3PL_Common\GUI\A3FL_Loading_Screen.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class Progress_loadingbar: RscProgress
		{
			idc = IDC_DIALOG_LOADING_LOADINGBAR;
			colorFrame[] = {0.72,0.72,0.72,1};
			colorBar[] = {0.641,0.25,0.109,1};
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.658 * safezoneH + safezoneY;
			w = 0.433125 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class text_welcomeHeader: RscStructuredText
		{
			idc = 69;
			text = $STR_LOADING_GUIWELCOME;
			x = 0.296823 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.401146 * safezoneW;
			h = 0.347 * safezoneH;
		};
		class Progress_welcomeHeader: RscStructuredText
		{
			idc = IDC_DIALOG_LOADING_LOADINGTEXT;
			text = $STR_LOADING_GUIWELCOME;
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.66 * safezoneH + safezoneY;
			w = 0.433125 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class text_percentage: RscStructuredText
		{
			idc = IDC_DIALOG_LOADING_LOADINGHEADER;
			text = "50%"; 
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.077 * safezoneH;
			sizeEx = 1.5 * GUI_GRID_H;
		};
	};
};