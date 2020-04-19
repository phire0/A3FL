class FishersNews
{
	idd=-1;
	fadein=0;
	fadeout=0;
	duration=9.9999998e+010;
	name="FishersNews";
	onLoad="uinamespace setvariable ['FishersNews',_this select 0]";
	onUnLoad="uinamespace setvariable ['FishersNews',nil]";
	class ControlsBackground {};
	class Controls
	{
		class LogoCorner: RscPicture
		{
			x="safezoneX + safezoneW - 7 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			y="safezoneY + 1 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			w="6 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			h="3 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			colorText[]={1,1,1,0.25};
			text="\A3PL_Common\GUI\FI_News_Logo_Corner.paa";
		};
		class BackgroundMain: RscText
		{
			x="safezoneX";
			y="safezoneY + safezoneH - 4.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			w="safezoneW";
			h="3 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			colorBackground[]={0.28999999,0,0,0.60000002};
		};
		class Logo: RscPicture
		{
			x="safezoneX + 0.5 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			y="safezoneY + safezoneH - 4.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			w="12 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			h="3 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			text="\A3PL_Common\GUI\FI_News_Logo.paa";
		};
		class Title: RscStructuredText
		{
			idc=3001;
			x="safezoneX + 10.5 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			y="safezoneY + safezoneH - 4.25 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			w="safezoneW - 10.5 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			h="2.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			shadow=0;
			class Attributes
			{
				font="PuristaMedium";
				color="#ffffff";
				align="left";
				shadow=0;
			};
		};
		class LineBlack: BackgroundMain
		{
			y="safezoneY + safezoneH - 1.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 2 * pixelH";
			h="2 * pixelH";
			colorBackground[]={0,0,0,1};
		};
		class BackgroundStripe: BackgroundMain
		{
			y="safezoneY + safezoneH - 1.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			h="(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			colorBackground[]={1,1,1,1};
		};
		class Stripe: RscControlsGroupNoScrollbars
		{
			x="safezoneX";
			y="safezoneY + safezoneH - 1.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			w="safezoneW";
			h="(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			class Controls
			{
				class StripeText1: RscStructuredText
				{
					idc=3002;
					x=0;
					y=0;
					w="safezoneW";
					h="(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
					shadow=0;
					size="0.9 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
					class Attributes
					{
						font="PuristaLight";
						color="#000000";
						align="left";
						shadow=0;
					};
				};
				class StripeText2: StripeText1
				{
					idc=3004;
				};
			};
		};
		class StripeLeft: RscPicture
		{
			x="safezoneX";
			y="safezoneY + safezoneH - 1.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			w="0.5 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			h="(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			colorText[]={0,0,0,1};
			text="\a3\Ui_f\data\GUI\Rsc\RscDisplayInventory\InventoryStripe_ca.paa";
		};
		class StripeRight: StripeLeft
		{
			x="safezoneX + safezoneW - 6.5 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			angle=180;
		};
		class BackgroundClock: RscText
		{
			x="safezoneX + safezoneW - 6 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			y="safezoneY + safezoneH - 1.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			w="6 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) + pixelW";
			h="(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			colorBackground[]={0,0,0,1};
		};
		class Clock: RscText
		{
			idc=3003;
			x="safezoneX + safezoneW - 6 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			y="safezoneY + safezoneH - 1.55 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			w="6 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			h="(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			text="23:32";
			font="PuristaLight";
			sizeEx="0.9 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
		};
		class LogoClock: RscPicture
		{
			x="safezoneX + safezoneW - 3.5 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			y="safezoneY + safezoneH - 1.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			w="4 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			h="(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			text="\A3PL_Common\GUI\FI_News_Logo.paa";
		};
	};
};