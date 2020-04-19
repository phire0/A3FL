class Dialog_CompanyBillList {
	idd = 139;
	name= "Dialog_CompanyBillList";
	movingEnable = false;
	enableSimulation = true;
	class controls
	{
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "A3PL_Common\GUI\A3PL_Company_BillList.paa";
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.093 * safezoneH + safezoneY;
			w = 0.840469 * safezoneW;
			h = 0.88 * safezoneH;
		};
		class bill_list: RscListbox
		{
			idc = 1500;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.264 * safezoneH;
		};
		class Company_Name: RscText
		{
			idc = 1000;
			text = ""; //--- ToDo: Localize;
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.378 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class Bill_Amount: RscText
		{
			idc = 1001;
			text = ""; //--- ToDo: Localize;
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class Desc_Bill: RscStructuredText
		{
			idc = 1100;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class PayCitizen: RscButtonEmpty
		{
			idc = 1600;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Pic_Pay_Faction: RscPicture
		{
			idc = 1201;
			text = "A3PL_Common\GUI\A3PL_Company_BillButtonFaction.paa";
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.70125 * safezoneW;
			h = 0.825 * safezoneH;
		};
		class Pic_Pay_Company: RscPicture
		{
			idc = 1202;
			text = "A3PL_Common\GUI\A3PL_Company_BillButtonCompany.paa";
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.70125 * safezoneW;
			h = 0.825 * safezoneH;
		};
		class Btn_Pay_Faction: RscButtonEmpty
		{
			idc = 1602;
			x = 0.489687 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Btn_Pay_Company: RscButtonEmpty
		{
			idc = 1603;
			x = 0.489687 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class close: RscButtonEmpty
		{
			idc = 1601;
			x = 0.587656 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};

class Dialog_CompanyBillListInfo {
	idd = 140;
	name= "Dialog_CompanyBillListInfo";
	movingEnable = false;
	enableSimulation = true;
	class controls
	{
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "A3PL_Common\GUI\A3PL_Company_BillListCompany.paa";
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.093 * safezoneH + safezoneY;
			w = 0.840469 * safezoneW;
			h = 0.88 * safezoneH;
		};
		class bill_list: RscListbox
		{
			idc = 1500;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.264 * safezoneH;
		};
		class Player_Name: RscText
		{
			idc = 1000;
			text = ""; //--- ToDo: Localize;
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.378 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class Bill_Amount: RscText
		{
			idc = 1001;
			text = ""; //--- ToDo: Localize;
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class Desc_Bill: RscStructuredText
		{
			idc = 1100;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class close: RscButtonEmpty
		{
			idc = 1601;
			x = 0.587656 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};