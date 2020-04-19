class Dialog_ReceiveTicket
{
	idd = 37;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Kane, v1.063, #Zomiqi)
	////////////////////////////////////////////////////////
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class button_Yes: RscButton
		{
			idc = 1600;
			text = $STR_Various_Yes; 
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
			action = "[] call A3PL_Police_PayTicket;";
		};
		class button_No: RscButton
		{
			idc = 1601;
			text = $STR_Various_No; 
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
			action = "[] call A3PL_Police_RefuseTicket;";
		};
		class text_amount: RscText
		{
			idc = 1000;
			text = $STR_RECEIVETICKET_GUIAMOUNT; 
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class static_payticket: RscText
		{
			idc = 1001;
			text = $STR_RECEIVETICKET_GUIPAYTICKET; 
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.180469 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};