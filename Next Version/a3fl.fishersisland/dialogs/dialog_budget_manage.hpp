class Dialog_Budget_Manage
{
	idd = 140;
	movingEnable = 0;
	enableSimulation = 1;
	name="Dialog_Budget_Manage";

	class Controls
	{
		class RscPictureBudget: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_Budget_Manage.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class amount: RscStructuredText
		{
			idc = 1201;
			x = 0.433894 * safezoneW + safezoneX;
			y = 0.293222 * safezoneH + safezoneY;
			w = 0.123399 * safezoneW;
			h = 0.0281971 * safezoneH;
		};
		class edit_amount: RscEdit
		{
			idc = 1202;
			x = 0.433894 * safezoneW + safezoneX;
			y = 0.434207 * safezoneH + safezoneY;
			w = 0.123399 * safezoneW;
			h = 0.0281971 * safezoneH;
		};
		class button_transfert: RscButtonEmpty
		{
			idc = 1203;
			text = "";
			x = 0.429487 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.132213 * safezoneW;
			h = 0.0281971 * safezoneH;
			action = "[] call A3PL_Government_BudgetAdd;";
		};
		class button_withdraw: RscButtonEmpty
		{
			idc = 1204;
			text = "";
			x = 0.429487 * safezoneW + safezoneX;
			y = 0.546995 * safezoneH + safezoneY;
			w = 0.132213 * safezoneW;
			h = 0.0281971 * safezoneH;
			action = "[] call A3PL_Government_BudgetWithdraw;";
		};
	};
};