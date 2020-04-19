/* #Dokoke
$[
	1.063,
	["prospectFor",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"static_bg",[1,"P:\A3PL_Common\GUI\ProspectFor.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"combo_prospect",[1,"",["0.407656 * safezoneW + safezoneX","0.496185 * safezoneH + safezoneY","0.177344 * safezoneW","0.0283704 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_close",[1,"",["0.587968 * safezoneW + safezoneX","0.356741 * safezoneH + safezoneY","0.04125 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_prospect",[1,"",["0.448021 * safezoneW + safezoneX","0.546445 * safezoneH + safezoneY","0.0990625 * safezoneW","0.0411111 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_Prospect
{
	idd = 131;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Dokoke)
		////////////////////////////////////////////////////////

		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\ProspectFor.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class combo_prospect: RscCombo
		{
			idc = 2100;
			x = 0.407656 * safezoneW + safezoneX;
			y = 0.496185 * safezoneH + safezoneY;
			w = 0.177344 * safezoneW;
			h = 0.0283704 * safezoneH;
		};
		class button_close: RscButtonEmpty
		{
			idc = 1600;
			x = 0.587968 * safezoneW + safezoneX;
			y = 0.356741 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;";
		};
		class button_prospect: RscButtonEmpty
		{
			idc = 1601;
			x = 0.448021 * safezoneW + safezoneX;
			y = 0.546445 * safezoneH + safezoneY;
			w = 0.0990625 * safezoneW;
			h = 0.0411111 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};