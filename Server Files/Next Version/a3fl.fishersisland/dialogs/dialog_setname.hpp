/* #Hocudo
$[
	1.063,
	["a",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[1,"",["0.438125 * safezoneW + safezoneX","0.434 * safezoneH + safezoneY","0.139219 * safezoneW","0.11 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.8],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"",[1,"",["0.443281 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.128906 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"Save Name",["0.469062 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.0773437 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/



class Dialog_Nametag
{
	idd = 05;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{
		class RscText_1000: RscText
		{
			idc = 1000;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.11 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};
		class RscEdit_1400: RscEdit
		{
			idc = 1400;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = $STR_IPHONEX_GUISAVENAME; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.033 * safezoneH;
			action = "call A3PL_Player_SaveNametag;";
		};
	};
};