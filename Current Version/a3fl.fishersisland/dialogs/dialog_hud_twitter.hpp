class Dialog_HUD_Twitter
{
	idd = -1;
	duration = 1e+012;
	onLoad = "uiNamespace setVariable [""Dialog_HUD_Twitter"", _this select 0]";
	class Controls
	{
		class static_header: RscText
		{
			idc = 1000;
			text = ""; 
			font = "EtelkaNarrowMediumPro";
			sizeEx = 0.06;
			x = safeZoneX;
			y = safeZoneY + safeZoneH*1.62/3.05;
			w = 0.6 * safeZoneW;
			h = 0.05 * 8;
		};		

		class struc_messages: RscStructuredText
		{
			idc = 100;
			style = 256;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			colorShadow[] = {0.2,0.2,0.2,1};
			size = 0.06;
			sizeEx = 0.03;
			x = "safeZoneX";
			y = "safeZoneY + safeZoneH*2/3";
			w = "0.6 * safeZoneW";
			h = "0.05 * 8";
			text = "Message 1<br />Message 2";
			class Attributes
			{
				font = "PuristaBold";
				color = "#ffffff";
				align = "left";
				valign = "middle";
				shadow = 1;
				shadowColor = "#333333";
				size = 0.8;
			};
		};
	};
};