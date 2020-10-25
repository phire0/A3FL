/* #Monuty
$[
	1.063,
	["BusinessRent",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"\A3PL_Common\GUI\A3PL_BusinessBuy.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_businessname",[1,"",["0.478854 * safezoneW + safezoneX","0.319481 * safezoneH + safezoneY","0.135521 * safezoneW","0.0303333 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1900,"slider_rent",[1,"",["0.478907 * safezoneW + safezoneX","0.368926 * safezoneH + safezoneY","0.135053 * safezoneW","0.0303333 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"struc_info",[1,"",["0.37797 * safezoneW + safezoneX","0.416037 * safezoneH + safezoneY","0.237187 * safezoneW","0.099 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_rent",[1,"",["0.378854 * safezoneW + safezoneX","0.524778 * safezoneH + safezoneY","0.0979167 * safezoneW","0.0376297 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_close",[1,"",["0.515469 * safezoneW + safezoneX","0.523741 * safezoneH + safezoneY","0.0979167 * safezoneW","0.0394815 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"button_close2",[1,"",["0.597969 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0265625 * safezoneW","0.0570741 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
class Dialog_EstateSell
{
	idd = 67;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class BackgroundImage: RscPicture
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_SellHouse.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class ButtonYes: RscButtonEmpty
		{
			idc = 100;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.044 * safezoneH;
			action = "[] call A3PL_RealEstates_Sell;";
		};
		class ButtonNo: RscButtonEmpty
		{
			idc = -1;
			x = 0.54125 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;";
		};
		class DisplayPrice: RscStructuredText
		{
			idc = 1100;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.077 * safezoneH;
		};
	};
};