class iPhone_X_contacts: RscControlsGroup
{
	idc = 98000;
	x = 0;
	y = 0;
	w = safeZoneW * 0.135;
	h = safeZoneH * 0.052;
	class Controls
	{
		class iPhone_X_contactName: RscText
		{
			idc = 98002;
			style = ST_LEFT;
			x = 0;
			y = 0;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.02;
			text = "";
			sizeEx = 0.02 * safezoneW;
			colorText[] = {0,0,0,1};
			shadow = 0;
		};
		class iPhone_X_contactNumber: RscText
		{
			idc = 98003;
			style = ST_LEFT;
			x = 0;
			y = 0.02 * safezoneW;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.018;
			text = "";
			sizeEx = 0.018 * safezoneW;
			colorText[] = {0.62,0.62,0.62,1};
			shadow = 0;
		};
		class Separator: RscText
		{
			idc = 98004;
			style = ST_HUD_BACKGROUND;
			x = 0;
			y = (0.02 * safezoneW) + (0.018 * safezoneW);
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.001;
			colorBackground[] = {0.8,0.8,0.8,1};
		};
	};
};
class iPhone_X_conversations: RscControlsGroup
{
    idc = 98100;
    x = 0;
    y = 0;
    w = safeZoneW * 0.135;
    h = safeZoneH * 0.052;
    class Controls
    {
        class iPhone_X_SMSListContactName: RscText
        {
            idc = 98101;
            style = ST_LEFT;
            x = 0;
            y = 0;
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.02;
            text = "";
            sizeEx = 0.02 * safezoneW;
            colorText[] = {0,0,0,1};
            shadow = 0;
        }; 
        class iPhone_X_SMSListLastSMS: RscText
        {
            idc = 98102;
            style = ST_LEFT;
            x = 0;
            y = 0.02 * safezoneW;
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.018;
            text = "";
            sizeEx = 0.018 * safezoneW;
            colorText[] = {0.62,0.62,0.62,1};
            shadow = 0;
        }; 
        class Separator: RscText
        {
            idc = 98103;
            style = ST_HUD_BACKGROUND;
            x = 0;
            y = (0.02 * safezoneW) + (0.018 * safezoneW);
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.001;
            colorBackground[] = {0.8,0.8,0.8,1};
        };
    };
};
class iPhone_X_Tweet: RscControlsGroup
{
    idc = 98150;
    x = 0;
    y = 0;
    w = safeZoneW * 0.135;
    h = safeZoneH * 0.052;
    class Controls
    {
        class iPhone_X_TweetName: RscStructuredText
        {
            idc = 98301;
            style = ST_LEFT;
            x = 0;
            y = 0;
            w = safeZoneW * 0.134;
            h = safeZoneH * 0.02;
            text = "";
            sizeEx = 0.02 * safezoneW;
            colorText[] = {0,0,0,1};
            shadow = 0;
        };
        class iPhone_X_Tweet: RscStructuredText
        {
            idc = 98302;
			style = 0;
            x = 0;
            y = 0.02 * safezoneW;
            w = safeZoneW * 0.134;
            h = safeZoneH * 0.018;
            text = "";
            sizeEx = 0.016 * safezoneW;
            colorText[] = {0,0,0,1};
            shadow = 0;
        };
        class Separator: RscText
        {
            idc = 98303;
            style = ST_HUD_BACKGROUND;
            x = 0;
            y = (0.02 * safezoneW) + (0.018 * safezoneW);
            w = safeZoneW * 0.134;
            h = safeZoneH * 0.001;
            colorBackground[] = {0.8,0.8,0.8,1};
        };
    };
};
class iPhone_X_receiveSMS: RscControlsGroup
{
	idc = 98110;
	x = 0;
	y = 0;
	w = safeZoneW * 0.135;
	h = safeZoneH * 0.05;
	class Controls
	{
		class iPhone_X_backgroundReceiveSMS: RscText
		{
			idc = 98111;
			style = ST_HUD_BACKGROUND;
			x = 0;
			y = 0;
			w = safeZoneW * 0.0965;
			h = safeZoneH * 0.02;
			colorBackground[] = {0.6,0.8,1,0.8};
		};
		class iPhone_X_messageReceiveSMS: RscStructuredText
		{
			idc = 98112;
			style = ST_LEFT + ST_MULTI + ST_NO_RECT;
			x = 0;
			y = 0;
			w = safeZoneW * 0.0915;
			h = safeZoneH * 0.02;
			sizeEx = 0.0175 * safezoneW;
			lineSpacing = 0.8;
			text = "";
			colorText[] = {0.1,0.1,0.1,0.8};
			shadow = 0;
		};
	};
};
class iPhone_X_sendSMS: RscControlsGroup
{
    idc = 98120;
    x = 0;
    y = 0;
    w = safeZoneW * 0.135;
    h = safeZoneH * 0.05;
    class Controls
    {
        class iPhone_X_backgroundSendSMS: RscText
        {
            idc = 98111;
            style = ST_HUD_BACKGROUND;
            x = (safeZoneW * 0.135) - (safeZoneW * 0.10225);
            y = 0;
            w = safeZoneW * 0.0965;
            h = safeZoneH * 0.02;
            colorBackground[] = {1,1,0.4,0.8};
        };
        class iPhone_X_messageSendSMS: RscStructuredText
        {
            idc = 98112;
            style = ST_LEFT + ST_MULTI + ST_NO_RECT;
            x = (safeZoneW * 0.135) - (safeZoneW * 0.10225);
            y = 0;
            w = safeZoneW * 0.0915;
            h = safeZoneH * 0.02;
            sizeEx = 0.015 * safezoneW;
            lineSpacing = 0.8;
            text = "";
            colorText[] = {0.1,0.1,0.1,1};
            shadow = 0;
        };
    };
};
class iPhone_X_SMSEnterprise: RscControlsGroup
{
	idc = 98057;
	x = 0;
	y = 0;
	w = safeZoneW * 0.135;
	h = safeZoneH * 0.05;
	class Controls
	{
		class iPhone_X_backgroundSMSEnterprise: RscText
		{
			idc = 98058;
			style = ST_HUD_BACKGROUND;
			x = 0;
			y = 0;
			w = safeZoneW * 0.0965;
			h = safeZoneH * 0.02;
			colorBackground[] = {0.6,0.8,1,0.8};
		};
		class iPhone_X_messageSMSEnterprise: RscStructuredText
		{
			idc = 98059;
			style = ST_LEFT + ST_MULTI + ST_NO_RECT;
			x = 0;
			y = 0;
			w = safeZoneW * 0.0915;
			h = safeZoneH * 0.02;
			sizeEx = 0.0175 * safezoneW;
			lineSpacing = 0.8;
			text = "";
			colorText[] = {0.1,0.1,0.1,0.8};
			shadow = 0;
		};
	};
};
class iPhone_X_switchboard: RscControlsGroup
{
    idc = 98055;
    x = 0;
    y = 0;
    w = safeZoneW * 0.135;
    h = safeZoneH * 0.05;
    class Controls
    {
        class iPhone_X_displayText: RscText
        {
            idc = 98056;
            style = ST_LEFT;
            x = 0;
            y = 0;
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.02;
            text = "";
            sizeEx = 0.02 * safezoneW;
            colorText[] = {0,0,0,1};
            shadow = 0;
        }; 
        class Separator: RscText
        {
            idc = -1;
            style = ST_HUD_BACKGROUND;
            x = 0;
            y = 0.02 * safezoneW;
            w = safeZoneW * 0.132;
            h = safeZoneH * 0.001;
            colorBackground[] = {0.8,0.8,0.8,1};
        };
    };
};

class iPhone_Details_Radios: RscControlsGroup
{
	idc = 98000;
	x = 0;
	y = 0;
	w = safeZoneW * 0.135;
	h = safeZoneH * 0.055;
	class Controls
	{
		class iPhone_X_radioName: RscText
		{
			idc = 98002;
			style = ST_LEFT;
			x = 0;
			y = 0;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.02;
			text = "";
			sizeEx = 0.02 * safezoneW;
			colorText[] = {1,1,1,1};
			shadow = 0;
		};
		class iPhone_X_freq: RscText
		{
			idc = 98003;
			style = ST_LEFT;
			x = 0;
			y = 0.02 * safezoneW;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.018;
			text = "";
			sizeEx = 0.018 * safezoneW;
			colorText[] = {1,1,1,1};
			shadow = 0;
		};
		class Separator: RscText
		{
			idc = 98004;
			style = ST_HUD_BACKGROUND;
			x = 0;
			y = (0.02 * safezoneW) + (0.018 * safezoneW);
			w = safeZoneW * 0.132;
			h = safeZoneH * 0.001;
			colorBackground[] = {1,1,1,1};
		};
	};
};

class iPhone_Details_Factory: RscControlsGroup
{
	idc = -1;
	x = 0;
	y = 0;
	w = safeZoneW * 0.135;
	h = safeZoneH * 0.055;
	class Controls
	{
		class iPhone_X_factoryName: RscText
		{
			idc = 98002;
			style = ST_LEFT;
			x = 0;
			y = 0;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.02;
			text = "";
			sizeEx = 0.02 * safezoneW;
			colorText[] = {0,0,0,1};
			shadow = 0;
		};
		class iPhone_X_time: RscText
		{
			idc = 98003;
			style = ST_LEFT;
			x = 0;
			y = 0.02 * safezoneW;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.018;
			text = "";
			sizeEx = 0.018 * safezoneW;
			colorText[] = {0.8,0.8,0.8,1};
			shadow = 0;
		};
		class Separator: RscText
		{
			idc = 98004;
			style = ST_HUD_BACKGROUND;
			x = 0;
			y = (0.02 * safezoneW) + (0.018 * safezoneW);
			w = safeZoneW * 0.132;
			h = safeZoneH * 0.001;
			colorBackground[] = {1,1,1,1};
		};
	};
};

class A3PL_iPhone_Locked
{
	idd = 97000;
	movingEnable = 0;
	enableSimulation = 1;
	name = "iPhone_X_Locked";
	class ControlsBackground
	{
		class iPhone_Background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_1.paa";
		};
		class iPhone_Shadow: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "";
			colorText[] = {0,0,0,1};
		};
		class iPhone_Shadow_home: RscPicture
		{
			idc = 97115;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_OFF.paa";
			colorText[] = {0,0,0,0.5};
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_FactionCounter: RscStructuredText
		{
			idc = 1000;
			text = "";
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = 0.018 * safezoneW;
			style = "16";
			colorText[] = {1,1,1,1};
		};
		class iPhone_PhoneNumber: RscText
		{
			idc = 97800;
			style = ST_CENTER;
			x = safeZoneX + safeZoneW * 0.72088282;
			y = safeZoneY + safeZoneH * 0.42;
			w = safeZoneW * 0.09532032;
			h = safeZoneH * 0.04541667;
			text = "No SIM";
			sizeEx = 0.02 * safezoneW;
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_button_master: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.69894219;
			y = safeZoneY + safeZoneH * 0.30690278;
			w = safeZoneW * 0.13914844;
			h = safeZoneH * 0.54570834;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
		};
	};
};

class A3PL_iPhone_Home
{
	idd = 97100;
	movingEnable = 0;
	enableSimulation = 1;
	name = "A3PL_iPhone_Home";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_1.paa";
		};
		class iPhone_Bottom: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21501389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_bottom.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_Icon_appPhone: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.708203126;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_phone.paa";
		};
		class iPhone_Button_appPhone: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.708203126;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "closeDialog 0; call A3PL_iPhoneX_appPhone;";
		};
		class iPhone_Icon_appContact: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.740625002;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_contact.paa";
		};
		class iPhone_Button_appContact: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.740625002;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "closeDialog 0; call A3PL_iPhoneX_appContactsList;";
		};
		class iPhone_Icon_appSMS: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_sms.paa";
		};
		class iPhone_Button_appSMS: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "closeDialog 0; call A3PL_iPhoneX_AppSMSList;";
		};
		class iPhone_Icon_appSettings: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.805468754;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_settings.paa";
		};
		class iPhone_Button_appSettings: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.805468754;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "closeDialog 0; call A3PL_iPhoneX_AppSettings;";
		};
		class iPhone_Icon_appCompaniesBills: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.708203126;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_cBills.paa";
		};
		class iPhone_Button_appCompaniesBills: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.708203126;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "call A3PL_iPhoneX_appCBillsLaunch;";
		};
		class iPhone_Icon_appUber: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.740625002;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_uber.paa";
		};
		class iPhone_Button_appUber: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.740625002;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "closeDialog 0; call A3PL_iPhoneX_AppUber;";
		};
		class iPhone_Icon_appCalculator: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.805468754;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_calculator.paa";
		};
		class iPhone_Button_appCalculator: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.805468754;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "closeDialog 0; call A3PL_iPhoneX_AppCalculator";
		};
		class iPhone_Icon_appTax: RscPicture
		{
			idc = -1;
			x = 0.708203 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_tax.paa";
		};
		class iPhone_Button_appTax: RscButtonEmpty
		{
			idc = -1;
			x = 0.708203 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			action = "closeDialog 0; call A3PL_iPhoneX_AppTax;";
		};
		class iPhone_Icon_appBank: RscPicture
		{
			idc = -1;
			x = 0.740625 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_bank.paa";
		};
		class iPhone_Button_appBank: RscButtonEmpty
		{
			idc = -1;
			x = 0.740625 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			action = "closeDialog 0; call A3PL_iPhoneX_appBank;";
		};
		class iPhone_Icon_appKeys: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = safeZoneY + safeZoneH * 0.401;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_keys.paa";
		};
		class iPhone_Button_appKeys: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = safeZoneY + safeZoneH * 0.401;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "closeDialog 0; call A3PL_iPhoneX_appKeys;";
		};
		class iPhone_Icon_appGang: RscPicture
		{
			idc = -1;
			x = 0.805468754 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_gang.paa";
		};
		class iPhone_Button_appGang: RscButtonEmpty
		{
			idc = -1;
			x = 0.805468754 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			action = "closeDialog 0; call A3PL_iPhoneX_appGang;";
		};
		class iPhone_Icon_appNews: RscPicture
		{
			idc = -1;
			x = 0.708203 * safezoneW + safezoneX;
			y = 0.45658333 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_news.paa";
		};
		class iPhone_Button_appNews: RscButtonEmpty
		{
			idc = -1;
			x = 0.708203 * safezoneW + safezoneX;
			y = 0.45658333 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			action = "closeDialog 0; call A3PL_iPhoneX_appNews;";
		};
		class iPhone_Icon_appFactory: RscPicture
		{
			idc = -1;
			x = 0.740625 * safezoneW + safezoneX;
			y = 0.45658333 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_clock.paa";
		};
		class iPhone_Button_appFactory: RscButtonEmpty
		{
			idc = -1;
			x = 0.740625 * safezoneW + safezoneX;
			y = 0.45658333 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			action = "closeDialog 0; call A3PL_iPhoneX_appFactory;";
		};
		class iPhone_Icon_appLevel: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = 0.45658333 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_level.paa";
		};
		class iPhone_Button_appLevel: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = 0.45658333 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			action = "closeDialog 0; call A3PL_iPhoneX_appLevel;";
		};
		class iPhone_Icon_appRadios: RscPicture
		{
			idc = 97103;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = 0.73449998 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_radios.paa";
			show=false;
		};
		class iPhone_Button_appRadios: RscButtonEmpty
		{
			idc = 97104;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = 0.73449998 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			action = "closeDialog 0; call A3PL_iPhoneX_appRadios;";
			show=false;
		};
		class iPhone_Icon_appSwitchboard: RscPicture
		{
			idc = 97101;
			x = 0.805468754 * safezoneW + safeZoneX;
			y = 0.73449998 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_emergency.paa";
			show=false;
		};
		class iPhone_Button_appSwitchboard: RscButtonEmpty
		{
			idc = 97102;
			x = 0.805468754 * safezoneW + safeZoneX;
			y = 0.73449998 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_AppSwitchboard";
			show=false;
		};
		class iPhone_Icon_appTwitter: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_twitter.paa";
		};
		class iPhone_Button_appTwitter: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_AppTwitter;";
		};
	};
};

class A3PL_iPhone_Phone
{
	idd = 97300;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_Phone";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appPhone.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_X_phoneNumber: RscEdit
        {
            idc = 97613;
            style = ST_CENTER;
            x = safeZoneX + safeZoneW * 0.71898438;
            y = safeZoneY + safeZoneH * 0.37263889;
            w = safeZoneW * 0.10114063;
            h = safeZoneH * 0.03;
            text = "Number";
            colorText[] = {0,0,0,1};
            colorBackground[] = {0,0,0,0};
            shadow = 0;
            maxChars = 10;
            sizeEx = 0.015 * safezoneW;
            onMouseButtonClick = "_text = ctrlText 97613; if (_text isEqualTo ""Number"") then {ctrlSetText [97613,""""]};";
        };
		class iPhone_ButtonBack: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.8225;
			y = safeZoneY + safeZoneH * 0.37563889;
			w = safeZoneW * 0.01;
			h = safeZoneH * 0.02;
			action = "ctrlSetText [97613,''];";
		};
		class iPhone_Button_appAddContact: RscButtonEmpty
		{
			idc = 97656;
			x = safeZoneX + safeZoneW * 0.7065;
			y = safeZoneY + safeZoneH * 0.37563889;
			w = safeZoneW * 0.01;
			h = safeZoneH * 0.02;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_appAddContact;";
		};
		class iPhone_Button_number_01: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.714503126;
			y = safeZoneY + safeZoneH * 0.46141667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = ((ctrlText _display) + '1'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_number_02: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.755625002;
			y = safeZoneY + safeZoneH * 0.46141667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '2'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_number_03: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.797046878;
			y = safeZoneY + safeZoneH * 0.46141667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '3'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_number_04: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.714503126;
			y = safeZoneY + safeZoneH * 0.52641667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '4'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_number_05: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.755625002;
			y = safeZoneY + safeZoneH * 0.52641667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '5'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_number_06: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.797046878;
			y = safeZoneY + safeZoneH * 0.52641667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '6'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_number_07: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.714503126;
			y = safeZoneY + safeZoneH * 0.59241667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '7'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_number_08: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.755625002;
			y = safeZoneY + safeZoneH * 0.59241667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '8'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_number_09: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.797046878;
			y = safeZoneY + safeZoneH * 0.59241667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '9'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_number_00: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.755625002;
			y = safeZoneY + safeZoneH * 0.65861667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '0'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_number_star: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.714503126;
			y = safeZoneY + safeZoneH * 0.65861667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '*'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_number_diese: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.797046878;
			y = safeZoneY + safeZoneH * 0.65861667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_display = ((findDisplay 97300) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '#'); _display ctrlSetText format['%1',_num];";
		};
		class iPhone_Button_phoneCall: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.755625002;
			y = safeZoneY + safeZoneH * 0.72471667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "[ctrlText((findDisplay 97300) displayCtrl 97613)] spawn A3PL_iPhoneX_sendCall;";
		};
		class iPhone_Button_appContact: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.748625002;
			y = safeZoneY + safeZoneH * 0.81451667;
			w = safeZoneW * 0.0125;
			h = safeZoneH * 0.0225;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_appContactsList;";
		};
		class iPhone_Icon_Home: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_home;";
			class Attributes {align = "center";};
		};
	};
};

class A3PL_iPhone_ContactsList
{
	idd = 97400;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_ContactsList";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appContactsList.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_Button_addContact: RscButtonEmpty
		{
			idc = 97654;
			x = safeZoneX + safeZoneW * 0.82205002;
			y = safeZoneY + safeZoneH * 0.33841667;
			w = safeZoneW * 0.01074219;
			h = safeZoneH * 0.01909723;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_appAddContact;";
		};
		class iPhone_Icon_home_appContactsList: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_home;";
			class Attributes{align = "center";};
		};
		class iPhone_ContactsListGroup: RscControlsGroup
		{
			idc = 97514;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.4795;
			class VScrollbar
			{
				width = 0.004 * safezoneW;
				height = 0;
				autoScrollSpeed = -1;
				autoScrollDelay = 5;
				autoScrollRewind = 0;
				shadow = 0;
				scrollSpeed = 0.1;
				color[] = {1,0,0,0.6};
				colorActive[] = {0.5,0.5,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
				arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
				arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
				border = "#(argb,8,8,3)color(0,0,0,0.1)";
			};
    		class HScrollbar : HScrollbar{height = 0;};
			class Controls{};
		};
	};
};

class A3PL_iPhone_appContact
{
	idd = 97500;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appContact";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appContact.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_NameContact: RscText
        {
            idc = 97609;
            style = ST_CENTER;
            x = safeZoneX + safeZoneW * 0.70898438;
            y = safeZoneY + safeZoneH * 0.43013889;
            w = safeZoneW * 0.11914063;
            h = safeZoneH * 0.027;
            text = "";
            sizeEx = 0.015 * safezoneW;
            colorText[] = {0,0,0,1};
            colorBackground[] = {0,0,0,0};
            shadow = 0;
        };
		class iPhone_NumberContact: RscText
		{
			idc = 97610;
			x = safeZoneX + safeZoneW * 0.70398438;
			y = safeZoneY + safeZoneH * 0.55113889;
			w = safeZoneW * 0.059;
			h = safeZoneH * 0.0225;
			text = "";
			sizeEx = 0.015 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_NoteContact: RscText
		{
			idc = 97659;
			style = ST_LEFT + ST_MULTI + ST_NO_RECT;
			x = safeZoneX + safeZoneW * 0.70398438;
			y = safeZoneY + safeZoneH * 0.58;
			w = safeZoneW * 0.131;
			h = safeZoneH * 0.066;
			text = "";
			sizeEx = 0.015 * safezoneW;
			lineSpacing = 1;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_Button_SMSContact: RscButtonEmpty
		{
			idc = 97657;
			x = safeZoneX + safeZoneW * 0.745;
			y = safeZoneY + safeZoneH * 0.47141667;
			w = safeZoneW * 0.02;
			h = safeZoneH * 0.03;
			action = "_nameContact = ctrlText 97609; _phoneNumberContact = ctrlText 97610; closeDialog 0; [_nameContact, _phoneNumberContact] spawn A3PL_iPhoneX_AppSMSFromContact";
		};
		class iPhone_Button_callContact: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.7775;
			y = safeZoneY + safeZoneH * 0.47141667;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.03;
			action = "_phoneNumberContact = ctrlText 97610; closeDialog 0; [_phoneNumberContact] spawn A3PL_iPhoneX_SendCall;";
		};
		class iPhone_Button_editContact: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.82205002;
			y = safeZoneY + safeZoneH * 0.34141667;
			w = safeZoneW * 0.01074219;
			h = safeZoneH * 0.01909723;
			action = "_phoneNumberContact = ctrlText 97610; [_phoneNumberContact] spawn A3PL_iPhoneX_DeleteContact;";
		};
		class iPhone_Button_appContacts: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.70305002;
			y = safeZoneY + safeZoneH * 0.34141667;
			w = safeZoneW * 0.03824219;
			h = safeZoneH * 0.01909723;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_appContactsList;";
		};
		class iPhone_Button_appPhone: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.776625002;
			y = safeZoneY + safeZoneH * 0.81451667;
			w = safeZoneW * 0.0125;
			h = safeZoneH * 0.0225;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_appPhone;";
		};
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_X_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes {align = "center";};
		};
	};
};

class A3PL_iPhone_appAddContact
{
	idd = 97600;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appAddContact";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appAddContact.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_X_nameContact: RscEdit
        {
            idc = 97605;
            style = ST_CENTER;
            x = safeZoneX + safeZoneW * 0.70898438;
            y = safeZoneY + safeZoneH * 0.43013889;
            w = safeZoneW * 0.11914063;
            h = safeZoneH * 0.027;
            text = "Identity";
            sizeEx = 0.015 * safezoneW;
            colorText[] = {0,0,0,1};
            colorBackground[] = {0,0,0,0};
            shadow = 0;
            maxChars = 19;
            onMouseButtonClick = "_text = ctrlText 97605; if (_text isEqualTo ""Identity"") then {ctrlSetText [97605,""""]};";
        };
		class iPhone_X_phoneNumberContact: RscEdit
		{
			idc = 97606;
			x = safeZoneX + safeZoneW * 0.70398438;
			y = safeZoneY + safeZoneH * 0.55113889;
			w = safeZoneW * 0.059;
			h = safeZoneH * 0.0225;
			text = "Number";
			sizeEx = 0.015 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
			maxChars = 10;
			onMouseButtonClick = "_text = ctrlText 97606; if (_text isEqualTo ""Number"") then {ctrlSetText [97606,""""]};";
		};
		class iPhone_X_noteContact: RscEdit
		{
			idc = 97658;
			style = ST_LEFT + ST_MULTI;
			x = safeZoneX + safeZoneW * 0.70398438;
			y = safeZoneY + safeZoneH * 0.58;
			w = safeZoneW * 0.131;
			h = safeZoneH * 0.066;
			text = "Note";
			sizeEx = 0.015 * safezoneW;
			lineSpacing = 1;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
			maxChars = 65;
			onMouseButtonClick = "_text = ctrlText 97658; if (_text isEqualTo ""Note"") then {ctrlSetText [97658,""""]};";
		};
		class iPhone_ButtonAddContact: RscButtonEmpty
		{
			idc = 97627;
			x = safeZoneX + safeZoneW * 0.82205002;
			y = safeZoneY + safeZoneH * 0.34141667;
			w = safeZoneW * 0.01074219;
			h = safeZoneH * 0.01909723;
			action = "[] spawn A3PL_iPhoneX_AddContact;";
		};
		class iPhone_Button_appContactsList: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.70305002;
			y = safeZoneY + safeZoneH * 0.34141667;
			w = safeZoneW * 0.05824219;
			h = safeZoneH * 0.01909723;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_appContactsList";
		};
		class iPhone_Button_appPhone: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.776625002;
			y = safeZoneY + safeZoneH * 0.81451667;
			w = safeZoneW * 0.0125;
			h = safeZoneH * 0.0225;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_appPhone;";
		};
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			class Attributes {align = "center";};
		};
	};
};

class A3PL_iPhone_appUber
{
	idd = 97700;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appUber";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appUber.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_Text_Uber_1: RscText
		{
			idc = 10616;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37263889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIUBER1;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_Text_Uber_2: RscText
		{
			idc = 10617;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.40763889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIUBER2;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_Text_Uber_3: RscText
		{
			idc = 10618;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.44263889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIUBER3;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_Button_Uber_1: RscButtonEmpty
		{
			idc = 10719;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37263889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			action = "[] spawn A3PL_Uber_requestDriver;";
		};
		class iPhone_Button_Uber_2: RscButtonEmpty
		{
			idc = 10720;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.40763889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			action = "[] spawn A3PL_Uber_addDriver;";
		};
		class iPhone_Button_Uber_3: RscButtonEmpty
		{
			idc = 10721;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.44263889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			action = "[] spawn A3PL_Uber_removeDriver;";
		};
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes {align = "center";};
		};
	};
};

class A3PL_iPhone_appCalculator
{
	idd = 97800;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appCalculator";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appCalculator.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class multiplication: RscButtonEmpty
		{
			idc = -1;
			x = 0.701094 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "[] spawn A3PL_Calculator_Multiplication;";
		};
		class addition: RscButtonEmpty
		{
			idc = -1;
			x = 0.721719 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "[] spawn A3PL_Calculator_Addition;";
		};
		class substraction: RscButtonEmpty
		{
			idc = -1;
			x = 0.742344 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "[] spawn A3PL_Calculator_Substraction;";
		};
		class division: RscButtonEmpty
		{
			idc = -1;
			x = 0.757813 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "[] spawn A3PL_Calculator_Division;";
		};
		class 2222: RscButtonEmpty
		{
			idc = -1;
			x = 0.778437 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "[] spawn A3PL_Calculator_Puissance;";
		};
		class percentage: RscButtonEmpty
		{
			idc = -1;
			x = 0.799062 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "[] spawn A3PL_Calculator_Percentage;";
		};
		class p_percentage: RscButtonEmpty
		{
			idc = -1;
			x = 0.814531 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "[] spawn A3PL_Calculator_PartPercentage;";
		};
		class case1: RscEdit
		{
			idc = 771;
			style = "16 + 512";
			colorText[] = {0,0,0,1};
			x = 0.701094 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.013 * safezoneH;
			sizeEx = 0.02;
			class Attributes {align = "center";};
		};
		class case2: RscEdit
		{
			idc = 772;
			style = "16 + 512";
			colorText[] = {0,0,0,1};
			x = 0.701093 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.013 * safezoneH;
			sizeEx = 0.02;
			class Attributes{align = "center";};
		};
		class result: RscText
		{
			idc = 774;
			style=ST_CENTER;
			colorText[] = {0,0,0,1};
			text = "";
			x = 0.701094 * safezoneW + safezoneX;
			y = 0.477 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 0.02;
			class Attributes {align = "center";};
		};
		class iPhone_X_icon_home_appCalculator: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_X_button_home_appCalculator: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes {align = "center";};
		};	
	};
};

class A3PL_iPhone_appTax
{
	idd = 97900;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appTax";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appTax.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes {align = "center";};
		};
		class iPhone_TaxListGroup: RscControlsGroup
		{
			idc = 97901;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.4795;
			class VScrollbar
			{
				width = 0.004 * safezoneW;
				height = 0;
				autoScrollSpeed = -1;
				autoScrollDelay = 5;
				autoScrollRewind = 0;
				shadow = 0;
				scrollSpeed = 0.1;
				color[] = {0,0,0,0.6};
				colorActive[] = {0,0,0,0};
				colorDisabled[] = {0,0,0,0};
				thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
				arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
				arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
				border = "#(argb,8,8,3)color(0,0,0,0.1)";
			};
    		class HScrollbar : HScrollbar {height = 0;};
			class Controls {};
		};
	};
};

class A3PL_iPhone_appCall
{
	idd = 98000;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appCall";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appCall.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_X_phoneNumberAppCall: RscText
		{
			idc = 97661;
			style = ST_CENTER;
			x = safeZoneX + safeZoneW * 0.72088282;
			y = safeZoneY + safeZoneH * 0.37;
			w = safeZoneW * 0.09532032;
			h = safeZoneH * 0.04541667;
			text = "";
			sizeEx = 0.025 * safezoneW;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_informations: RscText
		{
			idc = 97670;
			style = ST_CENTER;
			x = safeZoneX + safeZoneW * 0.71898438;
			y = safeZoneY + safeZoneH * 0.41263889;
			w = safeZoneW * 0.10114063;
			h = safeZoneH * 0.03;
			text = "";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_picture_unhookValidate: RscPicture
		{
			idc = 97675;
			x = safeZoneX + safeZoneW * 0.714503126;
			y = safeZoneY + safeZoneH * 0.72471667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_unhook.paa";
			show = false;
		};
		class iPhone_X_button_unhookValidate: RscButtonEmpty
		{
			idc = 97676;
			x = safeZoneX + safeZoneW * 0.714503126;
			y = safeZoneY + safeZoneH * 0.72471667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "";
			show = false;
		};
		class iPhone_X_picture_hangup: RscPicture
		{
			idc = 97667;
			x = safeZoneX + safeZoneW * 0.755625002;
			y = safeZoneY + safeZoneH * 0.72471667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_hangup.paa";
			show = false;
		};
		class iPhone_X_button_hangup: RscButtonEmpty
		{
			idc = 97663;
			x = safeZoneX + safeZoneW * 0.755625002;
			y = safeZoneY + safeZoneH * 0.72471667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "";
			show = false;
		};
		class iPhone_X_picture_hangupValidate: RscPicture
		{
			idc = 97677;
			x = safeZoneX + safeZoneW * 0.797046878;
			y = safeZoneY + safeZoneH * 0.72471667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_hangup.paa";
			show = false;
		};
		class iPhone_X_button_hangupValidate: RscButtonEmpty
		{
			idc = 97678;
			x = safeZoneX + safeZoneW * 0.797046878;
			y = safeZoneY + safeZoneH * 0.72471667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "";
			show = false;
		};
		class iPhone_X_picture_increaseVolume: RscPicture
		{
			idc = 97668;
			x = safeZoneX + safeZoneW * 0.755625002;
			y = safeZoneY + safeZoneH * 0.52641667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_increaseVolume.paa";
			show = false;
		};
		class iPhone_X_button_increaseVolume: RscButtonEmpty
		{
			idc = 97664;
			x = safeZoneX + safeZoneW * 0.755625002;
			y = safeZoneY + safeZoneH * 0.52641667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_radio = call TFAR_fnc_ActiveSWRadio; _volume = _radio call TFAR_fnc_getSwVolume; if (_volume < 10) then {_volume = _volume + 1}; [_radio, _volume] call TFAR_fnc_setSwVolume;";
			show = false;
		};
		class iPhone_X_picture_decreaseVolume: RscPicture
		{
			idc = 97669;
			x = safeZoneX + safeZoneW * 0.755625002;
			y = safeZoneY + safeZoneH * 0.59241667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_decreaseVolume.paa";
			show = false;
		};
		class iPhone_X_button_decreaseVolume: RscButtonEmpty
		{
			idc = 97665;
			x = safeZoneX + safeZoneW * 0.755625002;
			y = safeZoneY + safeZoneH * 0.59241667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_radio = call TFAR_fnc_ActiveSWRadio; _volume = _radio call TFAR_fnc_getSwVolume; if !(_volume isEqualTo 0) then {_volume = _volume - 1}; [_radio, _volume] call TFAR_fnc_setSwVolume;";
			show = false;
		};
		class iPhone_X_picture_speakers: RscPicture
		{
			idc = 97671;
			x = safeZoneX + safeZoneW * 0.797046878;
			y = safeZoneY + safeZoneH * 0.52641667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_speakersOFF.paa";
			show = false;
		};
		class iPhone_X_button_speakers: RscButtonEmpty
		{
			idc = 97672;
			x = safeZoneX + safeZoneW * 0.797046878;
			y = safeZoneY + safeZoneH * 0.52641667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			action = "_radio = call TFAR_fnc_ActiveSWRadio; [_radio] call TFAR_fnc_setSwSpeakers; _speakers = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwSpeakers; if (_speakers) then {ctrlSetText [97671,""A3PL_Common\GUI\phone\iPhone_X_icon_speakersON.paa""];} else {ctrlSetText [97671,""A3PL_Common\GUI\phone\iPhone_X_icon_speakersOFF.paa""];};";
			show = false;
		};
		class iPhone_X_picture_mute: RscPicture
		{
			idc = 97673;
			x = safeZoneX + safeZoneW * 0.714503126;
			y = safeZoneY + safeZoneH * 0.52641667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_muteOFF.paa";
			show = false;
		};
		class iPhone_X_button_mute: RscButtonEmpty
		{
			idc = 97674;
			x = safeZoneX + safeZoneW * 0.714503126;
			y = safeZoneY + safeZoneH * 0.52641667;
			w = safeZoneW * 0.025;
			h = safeZoneH * 0.045;
			//action = "if (TF_tangent_iPhone_X_pressed) then {_info = ""Mute""; [_info] call TFAR_fnc_oniPhoneXTangentReleased; ctrlSetText [97673,""A3PL_Common\GUI\phone\iPhone_X_icon_muteON.paa""];} else {_info = ""Appel en cours...""; [_info] call TFAR_fnc_oniPhoneXTangentPressed; ctrlSetText [97673,""A3PL_Common\GUI\phone\iPhone_X_icon_muteOFF.paa""];};";
			show = false;
		};
	};
};

class A3PL_iPhone_appTwitter
{
	idd = 98100;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appTwitter";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appTwitter.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes {align = "center";};
		};
		class iPhone_TwitterListGroup: RscControlsGroup
		{
			idc = 98101;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.4;//4795
			class VScrollbar
			{
				width = 0.004 * safezoneW;
				height = 0;
				autoScrollSpeed = -1;
				autoScrollDelay = 5;
				autoScrollRewind = 0;
				shadow = 0;
				scrollSpeed = 0.1;
				color[] = {1,0,0,0.6};
				colorActive[] = {0.5,0.5,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
				arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
				arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
				border = "#(argb,8,8,3)color(0,0,0,0.1)";
			};
    		class HScrollbar : HScrollbar{height = 0;};
			class Controls {};
		};
		class iPhone_Button_NewTweet: RscButtonEmpty
		{
			idc = 98102;
			x = safeZoneX + safeZoneW * 0.80;
			y = safeZoneY + safeZoneH * 0.77;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_appTwitterPost;";
		};
	};
};

class A3PL_iPhone_appTwitterPost
{
	idd = 98200;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appTwitterPost";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appNewTweet.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome_appNewTweet: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_IconHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_appTwitter;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			class Attributes{align = "center";};
		};
		class iPhone_X_TweetText: RscEdit
        {
            idc = 98311;
            style = "16";
            x = safeZoneX + safeZoneW * 0.71898438;
            y = safeZoneY + safeZoneH * 0.35;
            w = safeZoneW * 0.10114063;
            h = safeZoneH * 0.08;
            text = "";
            sizeEx = 0.015 * safezoneW;
            colorText[] = {0,0,0,1};
            colorBackground[] = {0,0,0,0};
            shadow = 0;
            maxChars = 100;
        };
		class iPhone_X_button_SendTweet: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.803;
			y = safeZoneY + safeZoneH * 0.435;
			w = safeZoneW * 0.024;
			h = safeZoneH * 0.025;
			action = "[] spawn A3PL_Twitter_Send;";
		};
	};
};

class A3PL_iPhone_appSettings
{
	idd = 98300;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appSettings";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appSettings.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_Button_Wallpaper: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37263889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			action = "closeDialog 0; call A3PL_iPhoneX_AppWallpaper";
		};
		class iPhone_Button_Sounds: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.40763889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			action = "closeDialog 0; call A3PL_iPhoneX_AppSound;";
		};
		class iPhone_Button_SIM: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.44263889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			action = "closeDialog 0; call A3PL_iPhoneX_appSIM;";
		};
		class iPhone_Button_General: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.47763889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			action = "closeDialog 0; call A3PL_iPhoneX_appGeneral;";
		};
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
	};
};

class A3PL_iPhone_appSIM
{
	idd = 98400;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appSIM";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appSIM.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_X_text_SIM_1: RscText
		{
			idc = 97616;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37263889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUISIM1;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_text_SIM_2: RscText
		{
			idc = 97617;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.40763889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUISIM2;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_text_SIM_3: RscText
		{
			idc = 97618;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.44263889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUISIM3;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_button_SIM_1: RscButtonEmpty
		{
			idc = 97719;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37263889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			action = "[player, A3PL_phoneNumberPrimary] remoteExec [""Server_iPhoneX_UpdatePhoneNumberActive"",2];";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
		};
		class iPhone_X_button_SIM_2: RscButtonEmpty
		{
			idc = 97720;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.40763889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			action = "[player, A3PL_phoneNumberSecondary] remoteExec [""Server_iPhoneX_UpdatePhoneNumberActive"",2];";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
		};
		class iPhone_X_button_SIM_3: RscButtonEmpty
		{
			idc = 97721;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.44263889;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.03;
			action = "[player, A3PL_phoneNumberEnterprise] remoteExec [""Server_iPhoneX_UpdatePhoneNumberActive"",2];";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
		};
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_home;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			class Attributes {align = "center";};
		};
	};
};

class A3PL_iPhone_appWallpaper
{
	idd = 98500;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appWallpaper";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appWallpaper.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_X_picture_wallpaper_01: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.664;
			y = safeZoneY + safeZoneH * 0.35063889;
			w = safeZoneW * 0.1225;
			h = safeZoneH * 0.197;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_1.paa";
		};
		class iPhone_X_picture_wallpaper_02: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.7075;
			y = safeZoneY + safeZoneH * 0.35063889;
			w = safeZoneW * 0.1225;
			h = safeZoneH * 0.197;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_2.paa";
		};
		class iPhone_X_picture_wallpaper_03: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.751;
			y = safeZoneY + safeZoneH * 0.35063889;
			w = safeZoneW * 0.1225;
			h = safeZoneH * 0.197;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_3.paa";
		};
		class iPhone_X_picture_wallpaper_04: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.664;
			y = safeZoneY + safeZoneH * 0.502;
			w = safeZoneW * 0.1225;
			h = safeZoneH * 0.197;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_4.paa";
		};
		class iPhone_X_picture_wallpaper_05: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.7075;
			y = safeZoneY + safeZoneH * 0.502;
			w = safeZoneW * 0.1225;
			h = safeZoneH * 0.197;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_5.paa";
		};
		class iPhone_X_picture_wallpaper_06: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.751;
			y = safeZoneY + safeZoneH * 0.502;
			w = safeZoneW * 0.1225;
			h = safeZoneH * 0.197;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_6.paa";
		};
		class iPhone_X_picture_wallpaper_07: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.664;
			y = safeZoneY + safeZoneH * 0.65813889;
			w = safeZoneW * 0.1225;
			h = safeZoneH * 0.197;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_7.paa";
		};
		class iPhone_X_picture_wallpaper_08: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.7075;
			y = safeZoneY + safeZoneH * 0.65813889;
			w = safeZoneW * 0.1225;
			h = safeZoneH * 0.197;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_8.paa";
		};
		class iPhone_X_picture_wallpaper_09: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.751;
			y = safeZoneY + safeZoneH * 0.65813889;
			w = safeZoneW * 0.1225;
			h = safeZoneH * 0.197;
			text = "A3PL_Common\GUI\phone\iPhone_X_background_9.paa";
		};
		class iPhone_X_button_wallpaper_01: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.705;
			y = safeZoneY + safeZoneH * 0.375;
			w = safeZoneW * 0.041;
			h = safeZoneH * 0.148;
			action = "[1] call A3PL_iPhoneX_Wallpaper;";
		};
		class iPhone_X_button_wallpaper_02: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.74825;
			y = safeZoneY + safeZoneH * 0.375;
			w = safeZoneW * 0.041;
			h = safeZoneH * 0.148;
			action = "[2] call A3PL_iPhoneX_Wallpaper;";
		};
		class iPhone_X_button_wallpaper_03: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.7915;
			y = safeZoneY + safeZoneH * 0.375;
			w = safeZoneW * 0.041;
			h = safeZoneH * 0.148;
			action = "[3] call A3PL_iPhoneX_Wallpaper;";
		};
		class iPhone_X_button_wallpaper_04: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.705;
			y = safeZoneY + safeZoneH * 0.5275;
			w = safeZoneW * 0.041;
			h = safeZoneH * 0.148;
			action = "[4] call A3PL_iPhoneX_Wallpaper;";
		};
		class iPhone_X_button_wallpaper_05: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.74825;
			y = safeZoneY + safeZoneH * 0.5275;
			w = safeZoneW * 0.041;
			h = safeZoneH * 0.148;
			action = "[5] call A3PL_iPhoneX_Wallpaper;";
		};
		class iPhone_X_button_wallpaper_06: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.7915;
			y = safeZoneY + safeZoneH * 0.5275;
			w = safeZoneW * 0.041;
			h = safeZoneH * 0.148;
			action = "[6] call A3PL_iPhoneX_Wallpaper;";
		};
		class iPhone_X_button_wallpaper_07: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.705;
			y = safeZoneY + safeZoneH * 0.68;
			w = safeZoneW * 0.041;
			h = safeZoneH * 0.148;
			action = "[7] call A3PL_iPhoneX_Wallpaper;";
		};
		class iPhone_X_button_wallpaper_08: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.74825;
			y = safeZoneY + safeZoneH * 0.68;
			w = safeZoneW * 0.041;
			h = safeZoneH * 0.148;
			action = "[8] call A3PL_iPhoneX_Wallpaper;";
		};
		class iPhone_X_button_wallpaper_09: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.7915;
			y = safeZoneY + safeZoneH * 0.68;
			w = safeZoneW * 0.041;
			h = safeZoneH * 0.148;
			action = "[9] call A3PL_iPhoneX_Wallpaper;";
		};
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes {align = "center";};
		};
	};
};

class A3PL_iPhone_appGeneral
{
	idd = 98600;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appGeneral";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appGeneral.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls {
		class iPhone_X_text_general_1: RscText
		{
			idc = 99714;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.40163889;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIHELP1;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_text_general_2: RscText
		{
			idc = 99715;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.43663889;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIHELP2;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_text_general_3: RscText
		{
			idc = 99716;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.4716;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIHELP3;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_text_silent: RscText
		{
			idc = 99717;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.5066;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIHELP4;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_text_help: RscText
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.5416;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIHELP5;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_text_markerhelp: RscText
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.5766;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIHELP6;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_text_grass: RscText
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.6116;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIHELP7;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_text_GPS: RscText
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.6466;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIHELP8;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_icon_hud: RscPicture
		{
			idc = 99719;
			x = safeZoneX + safeZoneW * 0.808496;
			y = safeZoneY + safeZoneH * 0.396611;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.025;
			text = "";
		};
		class iPhone_X_button_hud: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.715948;
			y = safeZoneY + safeZoneH * 0.396611;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "[99719,'A3PL_HUD_Enabled'] call A3PL_iPhoneX_SetParam;";
		};
		class iPhone_X_icon_twitter: RscPicture
		{
			idc = 99718;
			x = safeZoneX + safeZoneW * 0.808496;
			y = safeZoneY + safeZoneH * 0.434207;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.025;
			text = "";
		};
		class iPhone_X_button_twitter: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.715948;
			y = safeZoneY + safeZoneH * 0.434207;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "[99718,'A3PL_Twitter_Enabled'] call A3PL_iPhoneX_SetParam;";
		};
		class iPhone_X_icon_idplayer: RscPicture
		{
			idc = 99721;
			x = safeZoneX + safeZoneW * 0.808496;
			y = safeZoneY + safeZoneH * 0.471803;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.025;
			text = "";
		};
		class iPhone_X_button_idplayer: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.715948;
			y = safeZoneY + safeZoneH * 0.471803;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "[99721,'Player_EnableID'] call A3PL_iPhoneX_SetParam;";
		};
		class iPhone_IconNotifications: RscPicture
		{
			idc = 99722;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.5086;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.025;
			text = "";
		};
		class iPhone_ButtonNotifications: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.5066;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "[99722,'A3PL_Notifications_Enabled'] call A3PL_iPhoneX_SetParam;";
		};
		class iPhone_IconHelp: RscPicture
		{
			idc = 99723;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.5416;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.025;
			text = "";
		};
		class iPhone_ButtonHelp: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.5416;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "[99723,'A3PL_HELP_Enabled'] call A3PL_iPhoneX_SetParam;";
		};
		class iPhone_IconMarkerHelp: RscPicture
		{
			idc = 99724;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.5766;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.025;
			text = "";
		};
		class iPhone_ButtonMarkerHelp: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.5766;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "[99724,'A3PL_MarkerHelp_Enabled'] call A3PL_iPhoneX_SetParam;";
		};
		class iPhone_IconShowGrass: RscPicture
		{
			idc = 99725;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.6116;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.025;
			text = "";
		};
		class iPhone_ButtonShowGrass: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.6116;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "[99725,'A3PL_ShowGrass'] call A3PL_iPhoneX_SetParam;";
		};
		class iPhone_IconShowGPS: RscPicture
		{
			idc = 99726;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.6466;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.025;
			text = "";
		};
		class iPhone_ButtonShowGPS: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.6466;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "[99726,'A3PL_ShowGPS'] call A3PL_iPhoneX_SetParam;";
		};
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes {align = "center";};
		};
	};
};

class A3PL_iPhone_appSounds
{
	idd = 98700;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appSounds";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appSound.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls {
		class iPhone_X_text_sound_1: RscText
		{
			idc = 97714;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.40163889;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIRING1;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_text_sound_2: RscText
		{
			idc = 97715;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.43663889;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIRING2;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_text_sound_3: RscText
		{
			idc = 97716;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.4716;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = $STR_IPHONEX_GUIRING3;
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_X_button_sound_1: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.40163889;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "[1] call A3PL_iPhoneX_Sound;";
		};
		class iPhone_X_button_sound_2: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.43663889;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "[2] call A3PL_iPhoneX_Sound;";
		};
		class iPhone_X_button_sound_3: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.4716;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "[3] call A3PL_iPhoneX_Sound;";
		};
		class iPhone_IconSilent: RscPicture
		{
			idc = 97717;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.5086;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.025;
			text = "";
		};
		class iPhone_X_text_silent: RscText
		{
			idc = 97718;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.5066;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			text = "Silent";
			sizeEx = 0.0175 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
		};
		class iPhone_Button_Silent: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.719;
			y = safeZoneY + safeZoneH * 0.5066;
			w = safeZoneW * 0.118;
			h = safeZoneH * 0.03;
			action = "call A3PL_iPhoneX_Silent;";
		};
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes {align = "center";};
		};
	};
};

class A3PL_iPhone_appSwitchBoard
{
	idd = 98800;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appSwitchBoard";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appSwitchboard.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls {
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class iPhone_SwitchboardGroup: RscControlsGroup
		{
			idc = 98261;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.4795;
			class VScrollbar
			{
				width = 0.004 * safezoneW;
				height = 0;
				autoScrollSpeed = -1;
				autoScrollDelay = 5;
				autoScrollRewind = 0;
				shadow = 0;
				scrollSpeed = 0.1;
				color[] = {1,0,0,0.6};
				colorActive[] = {0.5,0.5,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
				arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
				arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
				border = "#(argb,8,8,3)color(0,0,0,0.1)";
			};
    		class HScrollbar : HScrollbar{height = 0;};
			class Controls{};
		};
	};
};

class A3PL_iPhone_appSMSList
{
	idd = 98900;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appSMSList";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appSMSList.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls {
		class iPhone_Button_addConversation: RscButtonEmpty
		{
			idc = 97655;
			x = safeZoneX + safeZoneW * 0.82205002;
			y = safeZoneY + safeZoneH * 0.33841667;
			w = safeZoneW * 0.01074219;
			h = safeZoneH * 0.01909723;
			action = "call A3PL_iPhoneX_appAddConversation;";
		};
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_home;";
			class Attributes{align = "center";};
		};
		class iPhone_appSMSGroup: RscControlsGroup
		{
			idc = 97516;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.4795;
			class VScrollbar
			{
				width = 0.004 * safezoneW;
				height = 0;
				autoScrollSpeed = -1;
				autoScrollDelay = 5;
				autoScrollRewind = 0;
				shadow = 0;
				scrollSpeed = 0.1;
				color[] = {1,0,0,0.6};
				colorActive[] = {0.5,0.5,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
				arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
				arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
				border = "#(argb,8,8,3)color(0,0,0,0.1)";
			};
    		class HScrollbar : HScrollbar {height = 0;};
			class Controls {};
		};
	};
};

class A3PL_iPhone_appAddConversation
{
	idd = 99000;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appAddConversation";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appAddConversations.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls {
		class iPhone_X_nameConversation: RscEdit
        {
            idc = 97607;
            style = ST_CENTER;
            x = safeZoneX + safeZoneW * 0.70898438;
            y = safeZoneY + safeZoneH * 0.43013889;
            w = safeZoneW * 0.11914063;
            h = safeZoneH * 0.027;
            text = $STR_IPHONEX_GUIDENTITY;
            sizeEx = 0.015 * safezoneW;
            colorText[] = {0,0,0,1};
            colorBackground[] = {0,0,0,0};
            shadow = 0;
            maxChars = 19;
            onMouseButtonClick = "_text = ctrlText 97607; if (_text isEqualTo ""Identity"") then {ctrlSetText [97607,""""]};";
        };
		class iPhone_X_phoneNumberConversation: RscEdit
		{
			idc = 97608;
			x = safeZoneX + safeZoneW * 0.70398438;
			y = safeZoneY + safeZoneH * 0.55113889;
			w = safeZoneW * 0.059;
			h = safeZoneH * 0.0225;
			text = $STR_IPHONEX_GUINUMBER;
			sizeEx = 0.015 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
			maxChars = 10;
			onMouseButtonClick = "_text = ctrlText 97608; if (_text isEqualTo ""Number"") then {ctrlSetText [97608,""""]};";
		};
		class iPhone_Button_okConversation: RscButtonEmpty
		{
			idc = 97629;
			x = safeZoneX + safeZoneW * 0.82205002;
			y = safeZoneY + safeZoneH * 0.34141667;
			w = safeZoneW * 0.01074219;
			h = safeZoneH * 0.01909723;
			action = "call A3PL_iPhoneX_addConversation;";
		};
		class iPhone_Button_appSMSList: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.70305002;
			y = safeZoneY + safeZoneH * 0.34141667;
			w = safeZoneW * 0.05724219;
			h = safeZoneH * 0.01909723;
			action = "closeDialog 0; call A3PL_iPhoneX_appSMSList";
		};
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes {align = "center";};
		};
	};
};

class A3PL_iPhone_appSMS
{
	idd = 99100;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appSMS";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appSMS.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls {
		class iPhone_X_nameContactAppSMS: RscText
        {
            idc = 97620;
            style = ST_CENTER;
            x = safeZoneX + safeZoneW * 0.70898438;
            y = safeZoneY + safeZoneH * 0.33741667;
            w = safeZoneW * 0.11914063;
            h = safeZoneH * 0.027;
            text = "";
            sizeEx = 0.015 * safezoneW;
            colorText[] = {0,0,0,1};
            colorBackground[] = {0,0,0,0};
            shadow = 0;
        };
		class iPhone_X_SMS: RscEdit
		{
			idc = 97621;
			style = ST_LEFT;
			x = safeZoneX + safeZoneW * 0.73;
			y = safeZoneY + safeZoneH * 0.8175;
			w = safeZoneW * 0.084;
			h = safeZoneH * 0.02;
			text = "Message...";
			sizeEx = 0.015 * safezoneW;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
			maxChars = 1500;
			onMouseButtonClick = "_text = ctrlText 97621; if (_text isEqualTo ""Message..."") then {ctrlSetText [97621,""""]};";
		};
		class iPhone_X_button_sendSMS: RscButtonEmpty
		{
			idc = 97622;
			x = safeZoneX + safeZoneW * 0.8178;
			y = safeZoneY + safeZoneH * 0.8155;
			w = safeZoneW * 0.0115;
			h = safeZoneH * 0.0235;
			action = "_message = ctrlText 97621; [_message] spawn A3PL_iPhoneX_sendSMS; _sms = ((findDisplay 99100) displayCtrl 97621); _sms ctrlSetText ""Message...""";
		};
		class iPhone_X_button_smiley: RscButtonEmpty
		{
			idc = 97623;
			x = safeZoneX + safeZoneW * 0.708;
			y = safeZoneY + safeZoneH * 0.8145;
			w = safeZoneW * 0.018;
			h = safeZoneH * 0.027;
			action = "";
		};
		class iPhone_X_button_appSMSListAppSMS: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.70305002;
			y = safeZoneY + safeZoneH * 0.34141667;
			w = safeZoneW * 0.01024219;
			h = safeZoneH * 0.01909723;
			action = "closeDialog 0; call A3PL_iPhoneX_appSMSList";
		};
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class iPhone_X_appSMSGroup: RscControlsGroup
		{
			idc = 97511;
			x = safeZoneX + safeZoneW * 0.703;
			y = safeZoneY + safeZoneH * 0.37;
			w = safeZoneW * 0.134;
			h = safeZoneH * 0.435;
			class VScrollbar
			{
				width = 0.004 * safezoneW;
				height = 0;
				autoScrollSpeed = -1;
				autoScrollDelay = 5;
				autoScrollRewind = 0;
				shadow = 0;
				scrollSpeed = 0.1;
				color[] = {1,0,0,0.6};
				colorActive[] = {0.5,0.5,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
				arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
				arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
				border = "#(argb,8,8,3)color(0,0,0,0.1)";
			};
    		class HScrollbar : HScrollbar {height = 0;};
			class Controls {};
		};
	};
};

class A3PL_iPhone_appGangCreation
{
	idd = 99200;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appGangCreation";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appGang.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			class Attributes{align = "center";};
		};
		class iPhone_GangName: RscEdit
        {
            idc = 99201;
            style = "16";
            x = 0.711406 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
            text = "";
            sizeEx = 0.015 * safezoneW;
            colorText[] = {0,0,0,1};
            colorBackground[] = {0,0,0,0};
            shadow = 0;
            maxChars = 15;
        };
		class iPhone_ButtonCreateGang: RscButtonEmpty
		{
			idc = -1;
			x = 0.726875 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.044 * safezoneH;
			action = "call A3PL_iPhoneX_CreateGang;";
		};
	};
};

class A3PL_iPhone_appGangManagement
{
	idd = 99300;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appGangManagement";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appGangManagement.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class Listbox_AllMembers: RscListbox
		{
			idc = 1500;
			x = 0.701094 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class btn_kickmember: RscButtonEmpty
		{
			idc = 1600;
			x = 0.742344 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.011 * safezoneH;
			action = "call A3PL_iPhoneX_GangKick;";
		};
		class btn_leader: RscButtonEmpty
		{
			idc = 1601;
			x = 0.78875 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.011 * safezoneH;
			action = "call A3PL_iPhoneX_GangSetLead;";
		};
		class btn_invite: RscButtonEmpty
		{
			idc = -1;
			x = 0.793906 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			action = "call A3PL_iPhoneX_GangInvite;";
		};
		class btn_leavegang: RscButtonEmpty
		{
			idc = -1;
			x = 0.701094 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
			action = "call A3PL_Gang_Leave;";
		};
		class btn_gangbank: RscButtonEmpty
		{
			idc = -1;
			x = 0.742344 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
			action = "call A3PL_iPhoneX_appGangBank;";
		};
		class btn_deletegang: RscButtonEmpty
		{
			idc = -1;
			x = 0.778437 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
			action = "call A3PL_Gang_Delete;";
		};
		class Combo_AllPlayers: RscCombo
		{
			idc = 2100;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class text_bank: RscStructuredText
		{
			idc = 1100;
			text = $STR_IPHONEX_GUIGANGAMOUNT;
			x = 0.726875 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class text_money: RscStructuredText
		{
			idc = 1101;
			text = "1234567890";
			x = 0.737188 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};

class A3PL_iPhone_appBank
{
	idd = 99400;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appBank";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appBank.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class iPhone_Button_GetBills: RscButtonEmpty
		{
			idc = -1;
			x = 0.726875 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.044 * safezoneH;
			action = "closeDialog 0; call A3PL_Company_BillsMenu;";
		};
		class iPhone_SendAmount: RscEdit
		{
			idc = 99401;
			x = 0.742344 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class iPhone_Button_SendAmount: RscButtonEmpty
		{
			idc = -1;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
			action = "call A3PL_iPhoneX_bankSend;";
		};
		class iPhone_BankAmount: RscStructuredText
		{
			idc = 99400;
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class iPhone_BankPlayersList: RscCombo
		{
			idc = 99402;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};

class A3PL_iPhone_appKeys
{
	idd = 99500;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appKeys";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appKeys.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class iPhone_Button_GiveKey: RscButtonEmpty
		{
			idc = -1;
			x = 0.726875 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.044 * safezoneH;
			action = "call A3PL_iPhoneX_GiveKeys;";
		};
		class iPhone_BankPlayersList: RscCombo
		{
			idc = 99402;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class iPhone_KeysList: RscListbox
		{
			idc = 99500;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.308 * safezoneH;
			colorBackground[] = {0,0,0,0.1};
		};
	};
};

class A3PL_iPhone_appNews
{
	idd = 99600;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appNews";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appNews.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class iPhone_Edit_NewsTitle: RscEdit
		{
			idc = 1400;
			x = 0.742344 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.018 * safezoneW;
			colorText[] = {1,1,1,1};
		};
		class iPhone_Edit_NewsMessage: RscEdit
		{
			idc = 1401;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.154 * safezoneH;
			sizeEx = 0.018 * safezoneW;
			style = "16";
			colorText[] = {1,1,1,1};
		};
		class iPhone_ButtonNews: RscButtonEmpty
		{
			idc = -1;
			x = 0.752656 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.044 * safezoneH;
			action = "call A3PL_iPhoneX_SendNews;";
		};
		/*
		class AnonymousSend: RscCheckbox
		{
			idc = 2800;
			x = 0.783594 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		*/
	};
};

class A3PL_iPhone_appRadios
{
	idd = 99700;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appRadios";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appRadios.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class iPhone_RadiosListGroup: RscControlsGroup
		{
			idc = 99701;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.4795;
			class VScrollbar
			{
				width = 0.004 * safezoneW;
				height = 0;
				autoScrollSpeed = -1;
				autoScrollDelay = 5;
				autoScrollRewind = 0;
				shadow = 0;
				scrollSpeed = 0.1;
				color[] = {1,0,0,0.6};
				colorActive[] = {0.5,0.5,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
				arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
				arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
				border = "#(argb,8,8,3)color(0,0,0,0.1)";
			};
    		class HScrollbar : HScrollbar{height = 0;};
			class Controls{};
		};
	};
};

class A3PL_iPhone_appFactory
{
	idd = 99800;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appFactory";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appFactory.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class iPhone_FactoriesListGroup: RscControlsGroup
		{
			idc = 99801;
			x = safeZoneX + safeZoneW * 0.702;
			y = safeZoneY + safeZoneH * 0.37;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.4795;
			class VScrollbar
			{
				width = 0.004 * safezoneW;
				height = 0;
				autoScrollSpeed = -1;
				autoScrollDelay = 5;
				autoScrollRewind = 0;
				shadow = 0;
				scrollSpeed = 0.1;
				color[] = {1,0,0,0.6};
				colorActive[] = {0.5,0.5,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
				arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
				arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
				border = "#(argb,8,8,3)color(0,0,0,0.1)";
			};
    		class HScrollbar : HScrollbar{height = 0;};
			class Controls{};
		};
	};
};

class A3PL_iPhone_appLevel
{
	idd = 99900;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appLevel";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appLevel.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class ActualLevel: RscStructuredText
		{
			idc = 99901;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class NextLevel: RscStructuredText
		{
			idc = 99902;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class XPRatio: RscStructuredText
		{
			idc = 99903;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class ProgressXP: RscProgress
		{
			idc = 99904;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.015 * safezoneH;
			colorFrame[] = {-1,-1,-1,-1};
			colorBar[] = {1,0,0,1};
		};
		class NextPerks: RscStructuredText
		{
			idc = 99905;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.165 * safezoneH;
		};
	};
};

class A3PL_iPhone_appBills
{
	idd = 100000;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appBills";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appFactory.paa"; //Missing background image
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		/*
			MISSING :
				Billslist - RscListBox - 100001
				Amount Bill - RscEdit - 101002
				Description Bill - RscEdit - 101003
				Button to pay bill - RscButtonEmpty - -1
				Button to pay bill if company - RscButtonEmpty - -1
				Button to pay bill if faction - RscButtonEmpty - -1
				Button to create bill if company - RscButtonEmpty - -1
		*/
	};
};

class A3PL_iPhone_appCreateBill
{
	idd = 101000;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appCreateBill";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appCreateBill.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class PlayersList: RscCombo
		{
			idc = 101001;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class BillAmount: RscEdit
		{
			idc = 101002;
			style = ST_CENTER;
			text = "0";
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class BillDescription: RscEdit
		{
			idc = 101003;
			style = "16";
			text = "";
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class SendBill: RscButtonEmpty
		{
			idc = -1;
			x = 0.726875 * safezoneW + safezoneX;
			y = 0.731 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.044 * safezoneH;
			action = "[] call A3PL_iPhoneX_sendBill;";
		};
	};
};

class A3PL_iPhone_appCompaniesBills
{
	idd = 102000;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appCompaniesBills";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appCompaniesBills.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class BillsListBox: RscListbox
		{
			idc = 102001;
			x = 0.701094 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.176 * safezoneH;
			sizeEx = 0.01 * safezoneW;
			colorBackground[] = {0,0,0,0.1};
		};
		class DetailsText: RscStructuredText
		{
			idc = 102002;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.121 * safezoneH;
		};
		class GoCreateButton: RscButtonEmpty
		{
			idc = -1;
			x = 0.721719 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.033 * safezoneH;
			action = "closeDialog 0; call A3PL_iPhoneX_appCreateBill;";
		};
	};
};

class A3PL_iPhone_appGangBank
{
	idd = 102100;
	movingEnable = true;
	enableSimulation = true;
	name = "A3PL_iPhone_appBank";
	class ControlsBackground
	{
		class iPhone_X_background: RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_appGangBank.paa";
		};
		class iPhone_Base: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
		};
	};
	class Controls
	{
		class iPhone_IconHome: RscPicture
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
		};
		class iPhone_ButtonHome: RscButtonEmpty
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.80948282;
			y = safeZoneY + safeZoneH * 0.31525;
			w = safeZoneW * 0.0175;
			h = safeZoneH * 0.0175;
			action = "closeDialog 0; [] spawn A3PL_iPhoneX_Home;";
			class Attributes{align = "center";};
		};
		class iPhone_SendAmount: RscEdit
		{
			idc = 99401;
			x = 0.742344 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class iPhone_Button_SendAmount: RscButtonEmpty
		{
			idc = -1;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
			action = "call A3PL_iPhoneX_gangBankSend;";
		};
		class iPhone_BankAmount: RscStructuredText
		{
			idc = 99400;
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class iPhone_BankPlayersList: RscCombo
		{
			idc = 99402;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};