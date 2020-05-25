class Dialog_Company_Create
{
	idd = 136;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class MainPic: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_Company_Create.paa";
			x = 0.00484126 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class BTN_Valid: RscButtonEmpty
		{
			idc = 1601;
			x = 0.2525 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.033 * safezoneH;
			action = "call A3PL_Company_Create;";
		};
		class BTN_Close: RscButtonEmpty
		{
			idc = 1600;
			x = 0.690781 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.033 * safezoneH;
			action = "closeDialog 0;";
		};
		class Edit_Name: RscEdit
		{
			idc = 1400;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.385 * safezoneH + safezoneY;
			w = 0.381563 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class Edit_Desc: RscEdit
		{
			idc = 1401;
			style = ST_Multi;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.485 * safezoneH + safezoneY;
			w = 0.381563 * safezoneW;
			h = 0.189 * safezoneH;
		};
	};
};

class Dialog_Company_Delete
{
	idd = 154;
	movingEnable = 0;
	enableSimulation = 1;
	name="Dialog_Company_Delete";
	class Controls
	{
		class RscPictureCompanyDelete: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_Government_CompanyDelete.paa";
			x = 0.222353 * safezoneW + safezoneX;
			y = 0.236827 * safezoneH + safezoneY;
			w = 0.555294 * safezoneW;
			h = 0.545143 * safezoneH;
		};
		class Register: RscListbox
		{
			idc = 1804;
			x = 0.354566 * safezoneW + safezoneX;
			y = 0.349616 * safezoneH + safezoneY;
			w = 0.290868 * safezoneW;
			h = 0.234975 * safezoneH;
		};
		class description: RscStructuredText
		{
			idc = 1805;
			x = 0.433894 * safezoneW + safezoneX;
			y = 0.59399 * safezoneH + safezoneY;
			w = 0.21154 * safezoneW;
			h = 0.018798 * safezoneH;
		};
		class phonenumber: RscStructuredText
		{
			idc = 1806;
			x = 0.403044 * safezoneW + safezoneX;
			y = 0.612788 * safezoneH + safezoneY;
			w = 0.24239 * safezoneW;
			h = 0.00939902 * safezoneH;
		};
		class BTN_CloseCompany: RscButtonEmpty
		{
			idc = 1807;
			x = 0.451522 * safezoneW + safezoneX;
			y = 0.650384 * safezoneH + safezoneY;
			w = 0.096956 * safezoneW;
			h = 0.0281971 * safezoneH;
			action = "call A3PL_Government_CompanyDelete";
		};
		class BTN_Close: RscButtonEmpty
		{
			idc = 1808;
			action="closeDialog 0;";
			x = 0.649841 * safezoneW + safezoneX;
			y = 0.302621 * safezoneH + safezoneY;
			w = 0.0132213 * safezoneW;
			h = 0.018798 * safezoneH;
		};
	};
};
class Dialog_Company_History
{
	idd = 138;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class static_bg: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_Company_History.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class History: RscListbox
		{
			idc = 1500;
			x = 0.237031 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.525937 * safezoneW;
			h = 0.495 * safezoneH;
		};
		class BTN_Close: RscButtonEmpty
		{
			idc = 1600;
			action = "closeDialog 0;";
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};
class Dialog_Company_Register
{
	idd = 153;
	movingEnable = 0;
	enableSimulation = 1;
	name="Dialog_Company_Register";
	class Controls
	{
		class RscPictureCompanyRegister: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_Company_Register.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class Register: RscListbox
		{
			idc = 1800;
			x = 0.354566 * safezoneW + safezoneX;
			y = 0.349616 * safezoneH + safezoneY;
			w = 0.290868 * safezoneW;
			h = 0.234975 * safezoneH;
		};
		class description: RscStructuredText
		{
			idc = 1801;
			x = 0.433894 * safezoneW + safezoneX;
			y = 0.59399 * safezoneH + safezoneY;
			w = 0.21154 * safezoneW;
			h = 0.018798 * safezoneH;
		};
		class phonenumber: RscStructuredText
		{
			idc = 1802;
			x = 0.403044 * safezoneW + safezoneX;
			y = 0.612788 * safezoneH + safezoneY;
			w = 0.24239 * safezoneW;
			h = 0.00939902 * safezoneH;
		};
		class BTN_Close: RscButtonEmpty
		{
			idc = 1803;
			action = "closeDialog 0;";
			x = 0.451522 * safezoneW + safezoneX;
			y = 0.650384 * safezoneH + safezoneY;
			w = 0.096956 * safezoneW;
			h = 0.0281971 * safezoneH;
		};
	};
};

class Dialog_Company_Manage
{
	idd = 137;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class MainPic: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_Company_Manage.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class AccountValue: RscStructuredText
		{
			idc = 1100;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class LB_Employees: RscListbox
		{
			idc = 1500;
			x = 0.262812 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.286 * safezoneH;
		};
		class LB_Transfer: RscListbox
		{
			idc = 5472;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.09 * safezoneH;
		};
		class EditTransfer: RscEdit
		{
			idc = 5372;
			x = 0.62375 * safezoneW + safezoneX;
			y = 0.232 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class EditPay: RscEdit
		{
			idc = 1401;
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.542 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class EditDesc: RscEdit
		{
			idc = 1402;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class BTN_Fire: RscButtonEmpty
		{
			idc = 1700;
			x = 0.262812 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class BTN_PayEdit: RscButtonEmpty
		{
			idc = 1701;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class BTN_DescEdit: RscButtonEmpty
		{
			idc = 1702;
			x = 0.659844 * safezoneW + safezoneX;
			y = 0.67 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class BTN_Close: RscButtonEmpty
		{
			idc = 1703;
			x = 0.685625 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class BTN_Transfer: RscButtonEmpty
		{
			idc = 1704;
			x = 0.670156 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};

class Dialog_Company_Storage
{
	idd = 142;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_HouseVirtual.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class lb_inventory: RscListbox
		{
			idc = 1500;
			x = 0.272083 * safezoneW + safezoneX;
			y = 0.324926 * safezoneH + safezoneY;
			w = 0.217083 * safezoneW;
			h = 0.360407 * safezoneH;
		};
		class lb_storage: RscListbox
		{
			idc = 1501;
			x = 0.509844 * safezoneW + safezoneX;
			y = 0.323445 * safezoneH + safezoneY;
			w = 0.218125 * safezoneW;
			h = 0.362259 * safezoneH;
		};
		class button_store: RscButtonEmpty
		{
			idc = 1600;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.701482 * safezoneH + safezoneY;
			w = 0.0745833 * safezoneW;
			h = 0.0303333 * safezoneH;
			action = "call A3PL_Company_Store;";
		};
		class button_take: RscButtonEmpty
		{
			idc = 1601;
			x = 0.657291 * safezoneW + safezoneX;
			y = 0.699481 * safezoneH + safezoneY;
			w = 0.0735417 * safezoneW;
			h = 0.0331111 * safezoneH;
			action = "call A3PL_Company_Take;";
		};
		class edit_store: RscEdit
		{
			idc = 1400;
			x = 0.317968 * safezoneW + safezoneX;
			y = 0.706222 * safezoneH + safezoneY;
			w = 0.0866146 * safezoneW;
			h = 0.022 * safezoneH;
			text = "1";
		};
		class edit_take: RscEdit
		{
			idc = 1401;
			x = 0.555625 * safezoneW + safezoneX;
			y = 0.707148 * safezoneH + safezoneY;
			w = 0.0868228 * safezoneW;
			h = 0.0210741 * safezoneH;
			text = "1";
		};
	};
};