class Dialog_DeveloperDebug
{
	idd = 155;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Winston, v1.063, #Bawubi)
		////////////////////////////////////////////////////////
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.500156 * safezoneW;
			h = 0.506 * safezoneH;
		};
		class DebugText: RscEdit
		{
			idc = 1400;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.5 * safezoneW;
			h = 0.5 * safezoneH;
			style = "16";
			autocomplete = "scripting";
		};
		class CompileServer: RscButton
		{
			idc = -1;
			text = "SERVER";
			x = 0.2525 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.033 * safezoneH;
			action = "['Server'] call A3PL_Debug_Execute;";
		};
		class CompileGlobal: RscButton
		{
			idc = -1;
			text = "GLOBAL";
			x = 0.391719 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.033 * safezoneH;
			action = "['Global'] call A3PL_Debug_Execute;";
		};
		class CompileAC: RscButton
		{
			idc = -1;
			text = "ALL CLIENTS";
			x = 0.525781 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.033 * safezoneH;
			action = "['All Clients'] call A3PL_Debug_Execute;";
		};
		class CompileLocal: RscButton
		{
			idc = -1;
			text = "LOCAL";
			x = 0.654688 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.033 * safezoneH;
			action = "['Local'] call A3PL_Debug_Execute;";
		};
		class ClearDebug: RscButton
		{
			idc = -1;
			text = "CLEAR";
			x = 0.757813 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.506 * safezoneH;
			action = "ctrlSetText [1400, ''];";
		};
	};
};