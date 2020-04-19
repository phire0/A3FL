/* #Dozywy
$[
	1.063,
	["ProspectFound",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"static_bg",[1,"P:\A3PL_Common\GUI\A3PL_ProspectFound.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"struc_text",[1,"<t size='1.5' align='center'>You found Iron Ore!</t>",["0.390156 * safezoneW + safezoneX","0.456926 * safezoneH + safezoneY","0.20625 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_close",[1,"",["0.597969 * safezoneW + safezoneX","0.39 * safezoneH + safezoneY","0.0257812 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_mark",[1,"",["0.443281 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.102656 * safezoneW","0.0484074 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_ProspectFound
{
	idd = 132;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Dozywy)
		////////////////////////////////////////////////////////

		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_ProspectFound.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class struc_text: RscStructuredText
		{
			idc = 1100;
			text = "<t size='1.5' align='center'></t>"; //--- ToDo: Localize;
			x = 0.390156 * safezoneW + safezoneX;
			y = 0.456926 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class button_close: RscButtonEmpty
		{
			idc = 1600;
			x = 0.597969 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
			action = "closeDialog 0;";
		};
		class button_mark: RscButtonEmpty
		{
			idc = 1601;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.102656 * safezoneW;
			h = 0.0484074 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};