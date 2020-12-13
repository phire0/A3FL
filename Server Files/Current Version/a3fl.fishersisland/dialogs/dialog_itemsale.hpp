/* #Sobycu
$[
	1.063,
	["ItemSale",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"P:\A3PL_Common\GUI\A3PL_ItemSale.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_itemname",[1,"",["0.448438 * safezoneW + safezoneX","0.400185 * safezoneH + safezoneY","0.165 * safezoneW","0.0311482 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1900,"slider_price",[1,"",["0.448438 * safezoneW + safezoneX","0.475333 * safezoneH + safezoneY","0.165 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"struc_info",[1,"",["0.377292 * safezoneW + safezoneX","0.513778 * safezoneH + safezoneY","0.236666 * safezoneW","0.107222 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_sell",[1,"",["0.378854 * safezoneW + safezoneX","0.63837 * safezoneH + safezoneY","0.0979167 * safezoneW","0.0376297 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_stopsell",[1,"",["0.515469 * safezoneW + safezoneX","0.635778 * safezoneH + safezoneY","0.0979167 * safezoneW","0.0394815 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"button_close",[1,"",["0.597969 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.0257812 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2800,"check_business",[1,"",["0.503594 * safezoneW + safezoneX","0.434926 * safezoneH + safezoneY","0.0232291 * safezoneW","0.0404074 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2801,"check_consumer",[1,"",["0.594844 * safezoneW + safezoneX","0.434926 * safezoneH + safezoneY","0.0232291 * safezoneW","0.0404074 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
class Dialog_ItemSale
{
	idd = 58;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class BackgroundPicture: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_ItemSale.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class sellbtn: RscButtonEmpty
		{
			idc = 1600;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class stopbtn: RscButtonEmpty
		{
			idc = 1601;
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class closebtn: RscButtonEmpty
		{
			idc = -1;
			x = 0.62375 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.033 * safezoneH;
			action = "closeDialog 0;";
		};
		class itemdesc: RscEdit
		{
			idc = 1400;
			x = 0.518 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.038 * safezoneH;
		};
		class itemprice: RscEdit
		{
			idc = 1900;
			x = 0.518 * safezoneW + safezoneX;
			y = 0.4035 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.038 * safezoneH;
		};
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Winston, v1.063, #Vizuqi)
////////////////////////////////////////////////////////
