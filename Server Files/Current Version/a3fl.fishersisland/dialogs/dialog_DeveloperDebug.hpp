class Dialog_DeveloperDebug
{
	idd = 155;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class BG_Debug: IGUIBack
		{
			idc = 2200;
			x = 0.298909 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.495 * safezoneH;
		};
		class B_DebugLocalExecute: RscButton
		{
			idc = 1600;
			text = $STR_DEVDEBUG_GUIEXECUTE; 
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			action = "call A3PL_Debug_Execute;";
		};
		class F_Debug: RscEdit
		{
			idc = 1400;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.391875 * safezoneW;
			h = 0.473 * safezoneH;
			sizeEx = 1 * GUI_GRID_H;
			style = "16";
			autocomplete = "scripting";
		};
		class DL_DebugExecutables: RscCombo
		{
			idc = 2100;
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
		};
	};
};