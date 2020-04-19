class Dialog_HUD_IDCard
{
	idd = 12345;
	fadeout = 0;
	fadein = 0;
	duration = 1e+1000;
	onLoad = "disableSerialization; uiNamespace setVariable ['A3PL_HUD_IDCard',_this select 0];";
	onUnload = "";
	class controlsBackground
	{
		class RscIDCard: RscPicture
		{
			idc = 999;
			text = "\A3PL_Common\GUI\Cards\Card_CIV.paa";
			x = -0.0620313 * safezoneW + safezoneX;
			y = 0.159 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.594 * safezoneH;
		};
	};
	class controls
	{
		class PLAYERID: RscStructuredText
		{
			idc = 1000;
			x = 0.0875 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class PLAYERFNAME: RscStructuredText
		{
			idc = 1001;
			x = 0.0875 * safezoneW + safezoneX;
			y = 0.276 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class PLAYERLNAME: RscStructuredText
		{
			idc = 1002;
			x = 0.0875 * safezoneW + safezoneX;
			y = 0.305 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class PLAYERDOB: RscStructuredText
		{
			idc = 1003;
			x = 0.0926562 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class PLAYERGENDER: RscStructuredText
		{
			idc = 1004;
			x = 0.0926562 * safezoneW + safezoneX;
			y = 0.365 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class PLAYERPASS: RscStructuredText
		{
			idc = 1005;
			x = 0.108125 * safezoneW + safezoneX;
			y = 0.3975 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class PLAYERLICENSES: RscStructuredText
		{
			idc = 1006;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.165 * safezoneH;
		};
	};
};

class Dialog_HUD_FactionCard
{
	idd = 12346;
	fadeout = 0;
	fadein = 0;
	duration = 1e+1000;
	onLoad = "disableSerialization; uiNamespace setVariable ['A3PL_HUD_FactionCard',_this select 0];";
	onUnload = "";
	class controlsBackground
	{
		class RscFactionCard: RscPicture
		{
			idc = 999;
			text = "";
			x = -0.0620313 * safezoneW + safezoneX;
			y = 0.159 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.594 * safezoneH;
		};
	};
	class controls
	{
		class PLAYERID: RscStructuredText
		{
			idc = 1000;
			x = 0.0875 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class PLAYERFNAME: RscStructuredText
		{
			idc = 1001;
			x = 0.0875 * safezoneW + safezoneX;
			y = 0.276 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class PLAYERLNAME: RscStructuredText
		{
			idc = 1002;
			x = 0.0875 * safezoneW + safezoneX;
			y = 0.305 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class PLAYERFACTION: RscStructuredText
		{
			idc = 1003;
			x = 0.0926562 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class PLAYERRANK: RscStructuredText
		{
			idc = 1004;
			x = 0.0926562 * safezoneW + safezoneX;
			y = 0.365 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.025 * safezoneH;
		};
	};
};