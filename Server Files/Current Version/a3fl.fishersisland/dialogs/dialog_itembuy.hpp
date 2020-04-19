/* #Dimahe
$[
	1.063,
	["itemBuy",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"P:\A3PL_Common\GUI\A3PL_ItemBuy.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"struc_name",[1,"",["0.463906 * safezoneW + safezoneX","0.459704 * safezoneH + safezoneY","0.134062 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"struc_price",[1,"",["0.463385 * safezoneW + safezoneX","0.497222 * safezoneH + safezoneY","0.134062 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_close",[1,"",["0.596458 * safezoneW + safezoneX","0.37437 * safezoneH + safezoneY","0.0268229 * safezoneW","0.0487408 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_buy",[1,"",["0.386041 * safezoneW + safezoneX","0.545741 * safezoneH + safezoneY","0.100104 * safezoneW","0.0383333 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"button_factionbuy",[1,"",["0.506406 * safezoneW + safezoneX","0.54563 * safezoneH + safezoneY","0.0990623 * safezoneW","0.0392592 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
class Dialog_ItemBuy
{
	idd = 59;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Dimahe)
		////////////////////////////////////////////////////////

		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_ItemBuy.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class struc_name: RscStructuredText
		{
			idc = 1100;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.459704 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class struc_price: RscStructuredText
		{
			idc = 1101;
			x = 0.463385 * safezoneW + safezoneX;
			y = 0.497222 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class button_close: RscButtonEmpty
		{
			idc = 1600;
			x = 0.596458 * safezoneW + safezoneX;
			y = 0.37437 * safezoneH + safezoneY;
			w = 0.0268229 * safezoneW;
			h = 0.0487408 * safezoneH;
			action = "closeDialog 0;";
		};
		class button_buy: RscButtonEmpty
		{
			idc = 1601;
			x = 0.386041 * safezoneW + safezoneX;
			y = 0.545741 * safezoneH + safezoneY;
			w = 0.100104 * safezoneW;
			h = 0.0383333 * safezoneH;
		};
		class button_factionbuy: RscButtonEmpty
		{
			idc = 1602;
			x = 0.506406 * safezoneW + safezoneX;
			y = 0.54563 * safezoneH + safezoneY;
			w = 0.0990623 * safezoneW;
			h = 0.0392592 * safezoneH;
		};
	};
};