class Dialog_ATM {
	idd = -1;
	name= "Dialog_ATM";
	movingEnable = false;
	enableSimulation = true;
	controls[]=
	{
		background,
		text1,
		text2,
		buttonDeposit,
		buttonWithdraw,
		buttonClose,
		buttonTransfer,
		textBank,
		textCash,
		listBox,
		editBox
	};

	class background: RscPicture
	{
		idc = IDC_DIALOG_ATM_BACKGROUND;
		text = "#(argb,8,8,3)color(0,0,0,0.8)";
		x = 0.2 * safezoneW + safezoneX;
		y = 0.16 * safezoneH + safezoneY;
		w = 0.6 * safezoneW;
		h = 0.44 * safezoneH;
	};
	class text1: RscText
	{
		idc = IDC_DIALOG_ATM_TEXT1;
		text = $STR_ATM_GUIBANKSOLD; 
		x = 0.225 * safezoneW + safezoneX;
		y = 0.2 * safezoneH + safezoneY;
		w = 0.1125 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class text2: RscText
	{
		idc = IDC_DIALOG_ATM_TEXT2;
		text = $STR_ATM_GUICASH; 
		x = 0.225 * safezoneW + safezoneX;
		y = 0.28 * safezoneH + safezoneY;
		w = 0.1125 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class buttonDeposit: RscButton
	{
		idc = IDC_DIALOG_ATM_BUTTONDEPOSIT;
		text = $STR_ATM_GUIDEPOSIT; 
		x = 0.225 * safezoneW + safezoneX;
		y = 0.44 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.04 * safezoneH;
		action = "call A3PL_ATM_Deposit;";
	};
	class buttonWithdraw: RscButton
	{
		idc = IDC_DIALOG_ATM_BUTTONWITHDRAW;
		text = $STR_ATM_GUIWITHDRAW; 
		x = 0.225 * safezoneW + safezoneX;
		y = 0.52 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.04 * safezoneH;
		action = "call A3PL_ATM_Withdraw;";
	};
	class buttonClose: RscButton
	{
		idc = IDC_DIALOG_ATM_BUTTONCLOSE;
		text = $STR_ATM_GUICLOSE; 
		x = 0.525 * safezoneW + safezoneX;
		y = 0.52 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.04 * safezoneH;
		action = "closeDialog 0;";
	};
	class buttonTransfer: RscButton
	{
		idc = IDC_DIALOG_ATM_BUTTONTRANSFER;
		text = $STR_ATM_GUITRANSFER; 
		x = 0.525 * safezoneW + safezoneX;
		y = 0.44 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.04 * safezoneH;
		action = "call A3PL_ATM_Transfer;";
	};
	class textBank: RscText
	{
		idc = IDC_DIALOG_ATM_TEXTBANK;
		text = "%1"; 
		x = 0.35 * safezoneW + safezoneX;
		y = 0.2 * safezoneH + safezoneY;
		w = 0.125 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class textCash: RscText
	{
		idc = IDC_DIALOG_ATM_TEXTCASH;
		text = "%1"; 
		x = 0.35 * safezoneW + safezoneX;
		y = 0.28 * safezoneH + safezoneY;
		w = 0.125 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class listBox: RscListbox
	{
		idc = IDC_DIALOG_ATM_LISTBOX;
		x = 0.525 * safezoneW + safezoneX;
		y = 0.2 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.2 * safezoneH;
	};
	class editBox: RscEdit
	{
		idc = IDC_DIALOG_ATM_EDITBOX;
		x = 0.225 * safezoneW + safezoneX;
		y = 0.36 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.04 * safezoneH;
	};
};


class Dialog_ATM_Menu {
	idd = 253;
	name= "Dialog_ATM_Menu";
	movingEnable = false;
	enableSimulation = true;
	class Controls
	{
		class BackPicture: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_ATM.paa";
			x = 0.190625 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.629062 * safezoneW;
			h = 0.649 * safezoneH;
		};
		class ButtonWithdraw: RscButtonEmpty
		{
			idc = 5575;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.022 * safezoneH;
			action = "call A3PL_ATM_Withdraw;";
		};
		class ButtonClose: RscButtonEmpty
		{
			idc = 5574;
			x = 0.62375 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.022 * safezoneH;
			action = "closeDialog 0";
		};
		class MoenyAmount: RscEdit
		{
			idc = 5372;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			style = "16 + 512";
			colorText[] = {0,0,0,1};
			class Attributes {align = "center";};
		};
		class MoenyDisplay: RscText
		{
			idc = 4974;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorText[] = {0,0,0,1};
			class Attributes {align = "center";};
		};
	};
};