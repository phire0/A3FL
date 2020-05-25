/* #Tabinu
$[
	1.063,
	["Uber",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[1,"",["0.402031 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.175313 * safezoneW","0.099 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.75],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"Accept Uber Request",["0.407187 * safezoneW + safezoneX","0.456 * safezoneH + safezoneY","0.165 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"Yes",["0.407187 * safezoneW + safezoneX","0.489 * safezoneH + safezoneY","0.0773437 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[1,"No",["0.494844 * safezoneW + safezoneX","0.489 * safezoneH + safezoneY","0.0773437 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
class Dialog_UberAccept
{
	idd = 61;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{
		class RscText_1000: RscText
		{
			idc = 1000;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.099 * safezoneH;
			colorBackground[] = {0,0,0,0.75};
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = $STR_UBERACCEPT_GUIACCEPT; 
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = $STR_Various_Yes; 
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.044 * safezoneH;
			action = "call A3PL_Uber_AcceptRequest;";
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = $STR_Various_No; 
			x = 0.494844 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.044 * safezoneH;
			action = "closeDialog 0;";
		};
	};
};