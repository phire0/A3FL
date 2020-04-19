/* #Karitu
$[
	1.063,
	["CombineMenu",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"static_bg",[1,"",["0.4175 * safezoneW + safezoneX","0.302 * safezoneH + safezoneY","0.165 * safezoneW","0.396 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"lb_items",[1,"",["0.427812 * safezoneW + safezoneX","0.335 * safezoneH + safezoneY","0.144375 * safezoneW","0.176 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"static_requires",[1,"Requires:",["0.474219 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.04125 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"static_itemstext",[1,"Items:",["0.479375 * safezoneW + safezoneX","0.302 * safezoneH + safezoneY","0.0464063 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"lb_required",[1,"",["0.427812 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.144375 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_combine",[1,"Combine",["0.515469 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.0567187 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_amount",[1,"",["0.438125 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.0567187 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"static_amount",[1,"Amount:",["0.448438 * safezoneW + safezoneX","0.632 * safezoneH + safezoneY","0.0360937 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
class Dialog_CombineItems
{
	idd = 9;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Karitu)
		////////////////////////////////////////////////////////

		class static_bg: IGUIBack
		{
			idc = 2200;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.396 * safezoneH;
		};
		class lb_items: RscListbox
		{
			idc = 1500;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.176 * safezoneH;
		};
		class static_requires: RscText
		{
			idc = 1000;
			text = $STR_COMBINEITEMS_GUIREQUIRES; 
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class static_itemstext: RscText
		{
			idc = 1001;
			text = $STR_COMBINEITEMS_GUIITEMS; 
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class lb_required: RscListbox
		{
			idc = 1501;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.088 * safezoneH;
		};
		class button_combine: RscButton
		{
			idc = 1600;
			text = $STR_COMBINEITEMS_GUICOMBINE; 
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_amount: RscEdit
		{
			idc = 1400;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_amount: RscText
		{
			idc = 1002;
			text = $STR_COMBINEITEMS_GUIAMOUNT; 
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.033 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};