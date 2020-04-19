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
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_SellHouse.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class edit_businessname: RscStructuredText
		{
			idc = 1400;
			x = 0.478854 * safezoneW + safezoneX;
			y = 0.319481 * safezoneH + safezoneY;
			w = 0.135521 * safezoneW;
			h = 0.0303333 * safezoneH;
		};
		class slider_rent: RscSlider
		{
			idc = 1900;
			x = 0.478907 * safezoneW + safezoneX;
			y = 0.368926 * safezoneH + safezoneY;
			w = 0.135053 * safezoneW;
			h = 0.0303333 * safezoneH;
		};
		class struc_info: RscStructuredText
		{
			idc = 1100;
			x = 0.37797 * safezoneW + safezoneX;
			y = 0.416037 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.099 * safezoneH;
		};
		class button_rent: RscButtonEmpty
		{
			idc = 1600;
			x = 0.378854 * safezoneW + safezoneX;
			y = 0.524778 * safezoneH + safezoneY;
			w = 0.0979167 * safezoneW;
			h = 0.0376297 * safezoneH;
			action = "[] call A3PL_RealEstates_Sell;";
		};
		class button_close: RscButtonEmpty
		{
			idc = 1601;
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.523741 * safezoneH + safezoneY;
			w = 0.0979167 * safezoneW;
			h = 0.0394815 * safezoneH;
			action = "closeDialog 0;";
		};
		class button_close2: RscButtonEmpty
		{
			idc = 1602;
			x = 0.597969 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0265625 * safezoneW;
			h = 0.0570741 * safezoneH;
			action = "closeDialog 0;";
		};
	};
};