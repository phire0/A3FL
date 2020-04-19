/* #Xymudy
$[
	1.063,
	["policemdc",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"static_background",[1,"#(argb,8,8,3)color(0,0,0,1)",["0.29375 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.4125 * safezoneW","0.55 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1401,"edit_input",[1,"",["0.298906 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.402187 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"struc_policedb",[1,"",["0.298906 * safezoneW + safezoneX","0.236 * safezoneH + safezoneY","0.402187 * safezoneW","0.495 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_PoliceDatabase
{
	idd = 211;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
	
		class static_background: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0,0,0,1)";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
		};
			class edit_input: RscEdit
			{
				idc = 1401;
				x = 0.309218 * safezoneW + safezoneX;
				y = 0.742 * safezoneH + safezoneY;
				w = 0.391875 * safezoneW;
				h = 0.022 * safezoneH;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0,1,0,1};
			colorSelection[] = {0,0,0,0};
			colorDisabled[] = 
			{
				0,
				0,
				0,
				0
			};	

			tooltipColorText[] = 
			{
				0,
				0,
				0,
				0
			};
			tooltipColorBox[] = 
			{
				0,
				0,
				0,
				0
			};
			tooltipColorShade[] = 
			{
				0,
				0,
				0,
				0
			};			
		};
		class struc_policedb: RscStructuredText
		{
			idc = 1100;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.495 * safezoneH;
			text = "";
		  class Attributes {
			font = "PuristaMedium";
			color = "#00FF00";
			align = "left";
			valign = "middle";
			shadow = 0;
			shadowColor = "#000000";
			size = "1";
		  };			
		};
		
		class RscText_1000: RscText
		{
			idc = 1000;
			text = ">"; 
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.748 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.011 * safezoneH;
			colorText[] = {0,1,0,1};
		};				
		
	};
};