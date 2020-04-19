/* #Vydeje
$[
	1.063,
	["HouseVirtual",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"static_bg",[1,"\A3PL_Common\GUI\A3PL_HouseVirtual.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"lb_inventory",[1,"",["0.272083 * safezoneW + safezoneX","0.324926 * safezoneH + safezoneY","0.217083 * safezoneW","0.360407 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"lb_storage",[1,"",["0.509844 * safezoneW + safezoneX","0.323445 * safezoneH + safezoneY","0.218125 * safezoneW","0.362259 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_store",[1,"",["0.4175 * safezoneW + safezoneX","0.701482 * safezoneH + safezoneY","0.0745833 * safezoneW","0.0303333 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_take",[1,"",["0.657291 * safezoneW + safezoneX","0.699481 * safezoneH + safezoneY","0.0735417 * safezoneW","0.0331111 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_store",[1,"",["0.317968 * safezoneW + safezoneX","0.706222 * safezoneH + safezoneY","0.0866146 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1401,"edit_take",[1,"",["0.555625 * safezoneW + safezoneX","0.707148 * safezoneH + safezoneY","0.0868228 * safezoneW","0.0210741 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/


class Dialog_HouseVirtual
{
	idd = 37;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{	
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Maqyro)
		////////////////////////////////////////////////////////

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
		};
		class button_take: RscButtonEmpty
		{
			idc = 1601;
			x = 0.657291 * safezoneW + safezoneX;
			y = 0.699481 * safezoneH + safezoneY;
			w = 0.0735417 * safezoneW;
			h = 0.0331111 * safezoneH;
		};
		class edit_store: RscEdit
		{
			idc = 1400;
			text = "1";
			x = 0.317968 * safezoneW + safezoneX;
			y = 0.706222 * safezoneH + safezoneY;
			w = 0.0866146 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_take: RscEdit
		{
			idc = 1401;
			text = "1";
			x = 0.555625 * safezoneW + safezoneX;
			y = 0.707148 * safezoneH + safezoneY;
			w = 0.0868228 * safezoneW;
			h = 0.0210741 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
				
		
	};
};