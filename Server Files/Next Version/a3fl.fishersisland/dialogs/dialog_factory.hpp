/* #Cufypi
$[
	1.063,
	["Factory",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"P:\A3PL_Common\GUI\A3PL_Factory.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"struc_type",[1,"Factory Type",["0.2525 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.464062 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1105,"progress_crafting",[1,"",["0.594531 * safezoneW + safezoneX","0.727185 * safezoneH + safezoneY","0.13099 * safezoneW","0.0275555 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_craft",[1,"",["0.577344 * safezoneW + safezoneX","0.665926 * safezoneH + safezoneY","0.165521 * safezoneW","0.0339259 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"list_recipes",[1,"",["0.28552 * safezoneW + safezoneX","0.253481 * safezoneH + safezoneY","0.195573 * safezoneW","0.288889 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"list_requires",[1,"",["0.526302 * safezoneW + safezoneX","0.252444 * safezoneH + safezoneY","0.196458 * safezoneW","0.294333 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1502,"list_storage",[1,"",["0.424636 * safezoneW + safezoneX","0.618222 * safezoneH + safezoneY","0.145313 * safezoneW","0.211408 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1103,"struc_info",[1,"Item Information",["0.576823 * safezoneW + safezoneX","0.549445 * safezoneH + safezoneY","0.165677 * safezoneW","0.108148 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1104,"struc_status",[1,"Craft Information",["0.577343 * safezoneW + safezoneX","0.770259 * safezoneH + safezoneY","0.165365 * safezoneW","0.079296 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"button_close",[1,"",["0.710313 * safezoneW + safezoneX","0.134222 * safezoneH + safezoneY","0.0309375 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1503,"list_inventory",[1,"",["0.257032 * safezoneW + safezoneX","0.617074 * safezoneH + safezoneY","0.145313 * safezoneW","0.212334 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_moveToStorage",[1,"",["0.403646 * safezoneW + safezoneX","0.675296 * safezoneH + safezoneY","0.0183334 * safezoneW","0.0262962 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"button_moveToInventory",[1,"",["0.403958 * safezoneW + safezoneX","0.728444 * safezoneH + safezoneY","0.0183334 * safezoneW","0.0262962 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_amount",[1,"1",["0.39026 * safezoneW + safezoneX","0.844444 * safezoneH + safezoneY","0.0452084 * safezoneW","0.0192221 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
class Dialog_Factory
{
	idd = 45;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Cufypi)
		////////////////////////////////////////////////////////

		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_Factory.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class struc_type: RscStructuredText
		{
			idc = 1100;
			text = $STR_FACTORY_FactoryType; 
			x = 0.2525 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.464062 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class progress_crafting: RscProgress
		{
			idc = 1105;
			style = "16 + 512";
			x = 0.594531 * safezoneW + safezoneX;
			y = 0.727185 * safezoneH + safezoneY;
			w = 0.13099 * safezoneW;
			h = 0.0275555 * safezoneH;
		};
		class button_craft: RscButtonEmpty
		{
			idc = 1600;
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.665926 * safezoneH + safezoneY;
			w = 0.165521 * safezoneW;
			h = 0.0339259 * safezoneH;
		};
		class list_recipes: RscListbox
		{
			idc = 1500;
			x = 0.28552 * safezoneW + safezoneX;
			y = 0.253481 * safezoneH + safezoneY;
			w = 0.195573 * safezoneW;
			h = 0.288889 * safezoneH;
		};
		class list_requires: RscListbox
		{
			idc = 1501;
			x = 0.526302 * safezoneW + safezoneX;
			y = 0.252444 * safezoneH + safezoneY;
			w = 0.196458 * safezoneW;
			h = 0.294333 * safezoneH;
		};
		class list_storage: RscListbox
		{
			idc = 1502;
			x = 0.424636 * safezoneW + safezoneX;
			y = 0.618222 * safezoneH + safezoneY;
			w = 0.145313 * safezoneW;
			h = 0.211408 * safezoneH;
		};
		class struc_info: RscStructuredText
		{
			idc = 1103;
			text = $STR_FACTORY_GUIINFOSITEMS;
			x = 0.576823 * safezoneW + safezoneX;
			y = 0.549445 * safezoneH + safezoneY;
			w = 0.165677 * safezoneW;
			h = 0.108148 * safezoneH;
		};
		class struc_status: RscStructuredText
		{
			idc = 1104;
			text = $STR_FACTORY_GUISTATUS;
			x = 0.577343 * safezoneW + safezoneX;
			y = 0.770259 * safezoneH + safezoneY;
			w = 0.165365 * safezoneW;
			h = 0.079296 * safezoneH;
		};
		class button_close: RscButtonEmpty
		{
			idc = 1602;
			x = 0.710313 * safezoneW + safezoneX;
			y = 0.134222 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.044 * safezoneH;
			action = "closeDialog 0;";
		};
		class list_inventory: RscListbox
		{
			idc = 1503;
			x = 0.257032 * safezoneW + safezoneX;
			y = 0.617074 * safezoneH + safezoneY;
			w = 0.145313 * safezoneW;
			h = 0.212334 * safezoneH;
		};
		class button_moveToStorage: RscButtonEmpty
		{
			idc = 1601;
			x = 0.403646 * safezoneW + safezoneX;
			y = 0.675296 * safezoneH + safezoneY;
			w = 0.0183334 * safezoneW;
			h = 0.0262962 * safezoneH;
		};
		class button_moveToInventory: RscButtonEmpty
		{
			idc = 1603;
			x = 0.403958 * safezoneW + safezoneX;
			y = 0.728444 * safezoneH + safezoneY;
			w = 0.0183334 * safezoneW;
			h = 0.0262962 * safezoneH;
		};
		class edit_amount: RscEdit
		{
			idc = 1400;
			text = "1"; 
			x = 0.39026 * safezoneW + safezoneX;
			y = 0.844444 * safezoneH + safezoneY;
			w = 0.0452084 * safezoneW;
			h = 0.0192221 * safezoneH;
		};
		class search_recipes: RscEdit
		{
			idc = 1405;
			style = "16 + 512";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.55 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class craft_amount: RscEdit
		{
			idc = 1406;
			text = "1";
			style = "16 + 512";
			x = 0.644375 * safezoneW + safezoneX;
			y = 0.77 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class button_search: RscButtonEmpty
		{
			idc = -1;
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.545 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.03 * safezoneH;
			action = "[] call A3PL_Factory_Search;";
		};
	};
};