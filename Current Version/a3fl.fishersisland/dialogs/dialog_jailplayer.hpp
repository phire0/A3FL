/* #Qifyxy
$[
	1.063,
	["JailPlayer",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"",[1,"",["0.407187 * safezoneW + safezoneX","0.434 * safezoneH + safezoneY","0.195937 * safezoneW","0.165 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"Jail Player",["0.45875 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.0928125 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"static_amount",[1,"Amount:",["0.484531 * safezoneW + safezoneX","0.456 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"",[1,"",["0.448438 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.113437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_JailPlayer
{
	idd = 40;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{

		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class button_createticket: RscButton
		{
			idc = 1600;
			text = $STR_JAILPLAYER_GUIJAIL;
			x = 0.45875 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.033 * safezoneH;
			action = "[] call A3PL_Police_JailPlayer;";
		};
		class static_amount: RscText
		{
			idc = 1000;
			text = $STR_JAILPLAYER_GUITIME;
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_amount: RscEdit
		{
			idc = 1400;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.022 * safezoneH;
		};

	};
};