/* #Zuxenu
$[
	1.063,
	["FactionSetup",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"P:\A3PL_Common\GUI\FactionSetup.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"lb_rankmembers",[1,"",["0.0770833 * safezoneW + safezoneX","0.241222 * safezoneH + safezoneY","0.188646 * safezoneW","0.345741 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"lb_allmembers",[1,"",["0.353542 * safezoneW + safezoneX","0.240519 * safezoneH + safezoneY","0.176146 * safezoneW","0.347593 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1502,"lb_ranks",[1,"",["0.0785937 * safezoneW + safezoneX","0.650185 * safezoneH + safezoneY","0.187084 * safezoneW","0.123519 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_addrank",[1,"",["0.352292 * safezoneW + safezoneX","0.651815 * safezoneH + safezoneY","0.17724 * safezoneW","0.020963 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1401,"edit_setpay",[1,"",["0.351823 * safezoneW + safezoneX","0.752074 * safezoneH + safezoneY","0.17724 * safezoneW","0.020963 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_setrank",[1,"",["0.278282 * safezoneW + safezoneX","0.392667 * safezoneH + safezoneY","0.060625 * safezoneW","0.0394815 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_addrank",[1,"",["0.278386 * safezoneW + safezoneX","0.643815 * safezoneH + safezoneY","0.060625 * safezoneW","0.0394815 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"button_removerank",[1,"",["0.278542 * safezoneW + safezoneX","0.69337 * safezoneH + safezoneY","0.060625 * safezoneW","0.0394815 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"button_setpay",[1,"",["0.278594 * safezoneW + safezoneX","0.742704 * safezoneH + safezoneY","0.060625 * safezoneW","0.0394815 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"struc_factionbalance",[1,"",["0.178958 * safezoneW + safezoneX","0.797926 * safezoneH + safezoneY","0.0657292 * safezoneW","0.0262963 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"struc_totalmembers",[1,"",["0.179011 * safezoneW + safezoneX","0.830815 * safezoneH + safezoneY","0.0657292 * safezoneW","0.0262963 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1504,"lb_blueprints",[1,"",["0.661822 * safezoneW + safezoneX","0.255556 * safezoneH + safezoneY","0.199063 * safezoneW","0.329074 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"combo_cats",[1,"",["0.693698 * safezoneW + safezoneX","0.185407 * safezoneH + safezoneY","0.131718 * safezoneW","0.0218889 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1604,"button_close1",[1,"",["0.507813 * safezoneW + safezoneX","0.105963 * safezoneH + safezoneY","0.04125 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1605,"button_close2",[1,"",["0.901145 * safezoneW + safezoneX","0.111407 * safezoneH + safezoneY","0.04125 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1606,"button_createBP",[1,"",["0.729792 * safezoneW + safezoneX","0.615222 * safezoneH + safezoneY","0.0605208 * safezoneW","0.0374074 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
class Dialog_FactionSetup
{
	idd = 111;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Zuxenu)
		////////////////////////////////////////////////////////

		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\FactionSetup.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class lb_rankmembers: RscListbox
		{
			idc = 1500;
			x = 0.0770833 * safezoneW + safezoneX;
			y = 0.241222 * safezoneH + safezoneY;
			w = 0.188646 * safezoneW;
			h = 0.345741 * safezoneH;
		};
		class lb_allmembers: RscListbox
		{
			idc = 1501;
			x = 0.353542 * safezoneW + safezoneX;
			y = 0.240519 * safezoneH + safezoneY;
			w = 0.176146 * safezoneW;
			h = 0.347593 * safezoneH;
		};
		class lb_ranks: RscListbox
		{
			idc = 1502;
			x = 0.0785937 * safezoneW + safezoneX;
			y = 0.650185 * safezoneH + safezoneY;
			w = 0.187084 * safezoneW;
			h = 0.123519 * safezoneH;
		};
		class edit_addrank: RscEdit
		{
			idc = 1400;
			x = 0.352292 * safezoneW + safezoneX;
			y = 0.651815 * safezoneH + safezoneY;
			w = 0.17724 * safezoneW;
			h = 0.020963 * safezoneH;
		};
		class edit_setpay: RscEdit
		{
			idc = 1401;
			x = 0.351823 * safezoneW + safezoneX;
			y = 0.752074 * safezoneH + safezoneY;
			w = 0.17724 * safezoneW;
			h = 0.020963 * safezoneH;
		};
		class button_setrank: RscButtonEmpty
		{
			idc = 1600;
			x = 0.278282 * safezoneW + safezoneX;
			y = 0.392667 * safezoneH + safezoneY;
			w = 0.060625 * safezoneW;
			h = 0.0394815 * safezoneH;
			action = "call A3PL_Government_SetRank;";
		};
		class button_addrank: RscButtonEmpty
		{
			idc = 1601;
			x = 0.278386 * safezoneW + safezoneX;
			y = 0.643815 * safezoneH + safezoneY;
			w = 0.060625 * safezoneW;
			action = "call A3PL_Government_AddRank;";
			h = 0.0394815 * safezoneH;
		};
		class button_removerank: RscButtonEmpty
		{
			idc = 1602;
			x = 0.278542 * safezoneW + safezoneX;
			y = 0.69337 * safezoneH + safezoneY;
			w = 0.060625 * safezoneW;
			h = 0.0394815 * safezoneH;
			action = "call A3PL_Government_RemoveRank;";
		};
		class button_setpay: RscButtonEmpty
		{
			idc = 1603;
			x = 0.278594 * safezoneW + safezoneX;
			y = 0.742704 * safezoneH + safezoneY;
			w = 0.060625 * safezoneW;
			h = 0.0394815 * safezoneH;
			action = "call A3PL_Government_SetPay;";
		};
		class struc_factionbalance: RscStructuredText
		{
			idc = 1100;
			x = 0.178958 * safezoneW + safezoneX;
			y = 0.797926 * safezoneH + safezoneY;
			w = 0.0657292 * safezoneW;
			h = 0.0262963 * safezoneH;
		};
		class struc_totalmembers: RscStructuredText
		{
			idc = 1101;
			x = 0.179011 * safezoneW + safezoneX;
			y = 0.830815 * safezoneH + safezoneY;
			w = 0.0657292 * safezoneW;
			h = 0.0262963 * safezoneH;
		};
		class lb_blueprints: RscListbox
		{
			idc = 1504;
			x = 0.661822 * safezoneW + safezoneX;
			y = 0.255556 * safezoneH + safezoneY;
			w = 0.199063 * safezoneW;
			h = 0.329074 * safezoneH;
		};
		class combo_cats: RscCombo
		{
			idc = 2100;
			x = 0.693698 * safezoneW + safezoneX;
			y = 0.185407 * safezoneH + safezoneY;
			w = 0.131718 * safezoneW;
			h = 0.0218889 * safezoneH;
		};
		class button_close1: RscButtonEmpty
		{
			idc = 1604;
			x = 0.507813 * safezoneW + safezoneX;
			y = 0.105963 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;";
		};
		class button_close2: RscButtonEmpty
		{
			idc = 1605;
			x = 0.901145 * safezoneW + safezoneX;
			y = 0.111407 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;";
		};
		class button_createBP: RscButtonEmpty
		{
			idc = 1606;
			x = 0.729792 * safezoneW + safezoneX;
			y = 0.615222 * safezoneH + safezoneY;
			w = 0.0605208 * safezoneW;
			h = 0.0374074 * safezoneH;
			action = "call A3PL_Government_ItemBuy;";
		};
		class button_fire: RscButtonEmpty
		{
			idc = -1;
			x = 0.278281 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.044 * safezoneH;
			action = "call A3PL_Government_Fire;";
		};
	};
};