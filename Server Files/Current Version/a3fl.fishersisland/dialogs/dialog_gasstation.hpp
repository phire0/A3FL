/* #Zoqeru
$[
	1.063,
	["GasstationGUI",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"static_bg",[1,"P:\A3PL_Common\GUI\A3PL_GasSet.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_enterprice",[1,"",["0.459218 * safezoneW + safezoneX","0.647629 * safezoneH + safezoneY","0.102917 * safezoneW","0.0257037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_setprice",[1,"",["0.42724 * safezoneW + safezoneX","0.695222 * safezoneH + safezoneY","0.165729 * safezoneW","0.0386667 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1401,"edit_gallons_pump1",[1,"",["0.427292 * safezoneW + safezoneX","0.343221 * safezoneH + safezoneY","0.110729 * safezoneW","0.0266297 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1402,"edit_price_pump1",[1,"",["0.546875 * safezoneW + safezoneX","0.344148 * safezoneH + safezoneY","0.110729 * safezoneW","0.0257037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1403,"edit_gallons_pump2",[1,"",["0.42724 * safezoneW + safezoneX","0.405518 * safezoneH + safezoneY","0.110208 * safezoneW","0.0257037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1404,"edit_price_pump2",[1,"",["0.546875 * safezoneW + safezoneX","0.405629 * safezoneH + safezoneY","0.110729 * safezoneW","0.0257037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1405,"edit_gallons_pump3",[1,"",["0.427812 * safezoneW + safezoneX","0.465148 * safezoneH + safezoneY","0.110208 * safezoneW","0.0257037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1406,"edit_price_pump3",[1,"",["0.546927 * safezoneW + safezoneX","0.465148 * safezoneH + safezoneY","0.11125 * safezoneW","0.0257037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1407,"edit_gallons_pump4",[1,"",["0.427812 * safezoneW + safezoneX","0.521889 * safezoneH + safezoneY","0.110208 * safezoneW","0.0257037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1408,"edit_price_pump4",[1,"",["0.546771 * safezoneW + safezoneX","0.522 * safezoneH + safezoneY","0.110729 * safezoneW","0.0257037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_close",[1,"",["0.644375 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.0257812 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1409,"edit_storage",[1,"",["0.546716 * safezoneW + safezoneX","0.58844 * safezoneH + safezoneY","0.111042 * safezoneW","0.0262964 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_GasStation
{
	idd = 69;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_GasSet.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class edit_enterprice: RscEdit
		{
			idc = 1400;
			x = 0.459218 * safezoneW + safezoneX;
			y = 0.647629 * safezoneH + safezoneY;
			w = 0.102917 * safezoneW;
			h = 0.0257037 * safezoneH;
		};
		class button_setprice: RscButtonEmpty
		{
			idc = 1600;
			x = 0.42724 * safezoneW + safezoneX;
			y = 0.695222 * safezoneH + safezoneY;
			w = 0.165729 * safezoneW;
			h = 0.0386667 * safezoneH;
			action = "call A3PL_Hydrogen_SetPrice;";
		};
		class edit_gallons_pump1: RscEdit
		{
			idc = 1401;
			x = 0.427292 * safezoneW + safezoneX;
			y = 0.343221 * safezoneH + safezoneY;
			w = 0.110729 * safezoneW;
			h = 0.0266297 * safezoneH;
		};
		class edit_price_pump1: RscEdit
		{
			idc = 1402;
			x = 0.546875 * safezoneW + safezoneX;
			y = 0.344148 * safezoneH + safezoneY;
			w = 0.110729 * safezoneW;
			h = 0.0257037 * safezoneH;
		};
		class edit_gallons_pump2: RscEdit
		{
			idc = 1403;
			x = 0.42724 * safezoneW + safezoneX;
			y = 0.405518 * safezoneH + safezoneY;
			w = 0.110208 * safezoneW;
			h = 0.0257037 * safezoneH;
		};
		class edit_price_pump2: RscEdit
		{
			idc = 1404;
			x = 0.546875 * safezoneW + safezoneX;
			y = 0.405629 * safezoneH + safezoneY;
			w = 0.110729 * safezoneW;
			h = 0.0257037 * safezoneH;
		};
		class edit_gallons_pump3: RscEdit
		{
			idc = 1405;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.465148 * safezoneH + safezoneY;
			w = 0.110208 * safezoneW;
			h = 0.0257037 * safezoneH;
		};
		class edit_price_pump3: RscEdit
		{
			idc = 1406;
			x = 0.546927 * safezoneW + safezoneX;
			y = 0.465148 * safezoneH + safezoneY;
			w = 0.11125 * safezoneW;
			h = 0.0257037 * safezoneH;
		};
		class edit_gallons_pump4: RscEdit
		{
			idc = 1407;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.521889 * safezoneH + safezoneY;
			w = 0.110208 * safezoneW;
			h = 0.0257037 * safezoneH;
		};
		class edit_price_pump4: RscEdit
		{
			idc = 1408;
			x = 0.546771 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.110729 * safezoneW;
			h = 0.0257037 * safezoneH;
		};
		class button_close: RscButtonEmpty
		{
			idc = 1601;
			x = 0.644375 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
			action = "closeDialog 0;";
		};
		class edit_storage: RscEdit
		{
			idc = 1409;
			x = 0.546716 * safezoneW + safezoneX;
			y = 0.58844 * safezoneH + safezoneY;
			w = 0.111042 * safezoneW;
			h = 0.0262964 * safezoneH;
		};
	};
};