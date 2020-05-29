class Dialog_Inventory
{
	idd = 1001;
	name = "Dialog_Inventory";
	movingEnable = false;
	enableSimulation = true;
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Wakiku)
		////////////////////////////////////////////////////////
		class static_background: RscPicture
		{
			idc = IDC_DIALOG_INVENTORY_BACKGROUND;
			text = "\A3PL_Common\GUI\A3PL_Inventory.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class itemList: RscListbox
		{
			idc = IDC_DIALOG_INVENTORY_ITEMLIST;
			x = 0.2505 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.360937 * safezoneW;
			h = 0.264 * safezoneH;
			onLBDblClick = "call A3PL_Inventory_Use;";
		};
		class amount: RscEdit
		{
			idc = IDC_DIALOG_INVENTORY_AMOUNT;
			style = ST_CENTER;
			sizeEx = 0.1;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class UseButton: RscButtonEmpty
		{
			idc = IDC_DIALOG_INVENTORY_USEBUTTON;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.066 * safezoneH;
			tooltip = $STR_INVENTORY_GUIUSEOBJECT;
		};
		class dropButton: RscButtonEmpty
		{
			idc = IDC_DIALOG_INVENTORY_DROPBUTTON;
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0463 * safezoneW;
			h = 0.07 * safezoneH;
			tooltip = $STR_INVENTORY_GUIDROPITEM;
		};
		class weightText: RscStructuredText
		{
			idc = IDC_DIALOG_INVENTORY_WEIGHTTEXT;
			text = $STR_INVENTORY_GUIWEIGHT; 
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class closeButton: RscButtonEmpty
		{
			idc = IDC_DIALOG_INVENTORY_CLOSEBUTTON;
			x = 0.726875 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = $STR_INVENTORY_GUICLOSEINVENTORY;
		};
		class listbox_keys: RscListbox
		{
			idc = 1900;
			x = 0.2505 * safezoneW + safezoneX;
			y = 0.548 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.135 * safezoneH;
			onLBDblClick = "call A3PL_Housing_Grabkey;";
		};
		class button_usekey: RscButtonEmpty
		{
			idc = 1604;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.042 * safezoneW;
			h = 0.077 * safezoneH;
			action = "call A3PL_Housing_Grabkey";
			tooltip = $STR_INVENTORY_GUITAKEKEY;
		};
		class list_licenses: RscListbox
		{
			idc = 1503;
			x = 0.2505 * safezoneW + safezoneX;
			y = 0.781 * safezoneH + safezoneY;
			w = 0.5 * safezoneW;
			h = 0.125 * safezoneH;
		};
	};
};