class A3PL_BowlingScoring
{
	idd = 11;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	
	class Controls
	{
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Caiden, v1.063, #Dajyny)
	////////////////////////////////////////////////////////
		class static_picture: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Bowling\scoring.paa";
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.268125 * safezoneW;
			h = 0.671 * safezoneH;
		};
		class lb_scores: RscListbox
		{
			idc = 1500;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.353 * safezoneH + safezoneY;
			w = 0.13006 * safezoneW;
			h = 0.409 * safezoneH;
			color[] = {0,0,0,1};
		};
		class text_header: RscText
		{
			idc = 1000;
			text = ""; 
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 1.5 * GUI_GRID_H;
		};
		class button_lane1: RscButton
		{
			idc = 1600;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[0] call A3PL_Bowling_BScoreScript;";
		};
		class button_lane2: RscButton
		{
			idc = 1601;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[1] call A3PL_Bowling_BScoreScript;";
		};
		class button_lane3: RscButton
		{
			idc = 1602;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[2] call A3PL_Bowling_BScoreScript;";
		};
		class button_lane4: RscButton
		{
			idc = 1603;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[3] call A3PL_Bowling_BScoreScript;";
		};
		class button_lane5: RscButton
		{
			idc = 1604;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[4] call A3PL_Bowling_BScoreScript;";
		};
		class button_lane6: RscButton
		{
			idc = 1605;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[5] call A3PL_Bowling_BScoreScript;";
		};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////


	};
};