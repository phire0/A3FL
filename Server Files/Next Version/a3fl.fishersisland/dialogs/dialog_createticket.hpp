class Dialog_CreateTicket
{
	idd = 38;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class button_createticket: RscButton
		{
			idc = 1600;
			text = $STR_CREATETICKET_GUICREATETICKET; 
			x = 0.45875 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.033 * safezoneH;
			action = "call A3PL_Police_CreateTicket;";
		};
		class static_amount: RscText
		{
			idc = 1000;
			text = $STR_CREATETICKET_GUIAMOUNT; 
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_amount: RscEdit
		{
			idc = 1400;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};
