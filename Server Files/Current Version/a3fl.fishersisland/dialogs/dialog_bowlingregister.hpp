////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Caiden, v1.063, #Kecaso)
////////////////////////////////////////////////////////

class A3PL_BowlingRegister
{
	idd = 10;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	
	class Controls
	{
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Caiden, v1.063, #Hohila)
	////////////////////////////////////////////////////////
	
	class RscPicture_1200: RscPicture
	{
		idc = 1200;
		text = "A3PL_Common\GUI\KarmaLanes_Scores.paa";
		x = 0.00213537 * safezoneW + safezoneX;
		y = -0.0107038 * safezoneH + safezoneY;
		w = 0.998385 * safezoneW;
		h = 1.00778 * safezoneH;
	};	
	
	class lb_lane1: RscListbox
	{
		idc = 1500;
		x = 0.282083 * safezoneW + safezoneX;
		y = 0.417519 * safezoneH + safezoneY;
		w = 0.13927 * safezoneW;
		h = 0.166259 * safezoneH;
	};
	class lb_lane2: RscListbox
	{
		idc = 1501;
		x = 0.431406 * safezoneW + safezoneX;
		y = 0.416296 * safezoneH + safezoneY;
		w = 0.13875 * safezoneW;
		h = 0.16626 * safezoneH;
	};
	class lb_lane3: RscListbox
	{
		idc = 1502;
		x = 0.579375 * safezoneW + safezoneX;
		y = 0.418038 * safezoneH + safezoneY;
		w = 0.13875 * safezoneW;
		h = 0.166259 * safezoneH;
	};
	class lb_lane4: RscListbox
	{
		idc = 1503;
		x = 0.282448 * safezoneW + safezoneX;
		y = 0.681148 * safezoneH + safezoneY;
		w = 0.139791 * safezoneW;
		h = 0.165333 * safezoneH;
	};
	class lb_lane5: RscListbox
	{
		idc = 1504;
		x = 0.431458 * safezoneW + safezoneX;
		y = 0.681111 * safezoneH + safezoneY;
		w = 0.13875 * safezoneW;
		h = 0.166259 * safezoneH;
	};
	class lb_lane6: RscListbox
	{
		idc = 1505;
		x = 0.579427 * safezoneW + safezoneX;
		y = 0.681444 * safezoneH + safezoneY;
		w = 0.13927 * safezoneW;
		h = 0.166259 * safezoneH;
	};
	class button_register1: RscButtonEmpty
	{
		idc = 1600;
		text = $STR_BOWLINIGREGISTER_Register; 
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.586148 * safezoneH + safezoneY;
		w = 0.0459376 * safezoneW;
		h = 0.0302223 * safezoneH;
		action = "[1] call A3PL_Bowling_BRegL;";
	};
	class button_restart1: RscButtonEmpty
	{
		idc = 1601;
		text = $STR_BOWLINIGREGISTER_Restart; 
		x = 0.329844 * safezoneW + safezoneX;
		y = 0.586148 * safezoneH + safezoneY;
		w = 0.0453647 * safezoneW;
		h = 0.0303334 * safezoneH;
		action = "[1] call A3PL_Bowling_BRestart;";
	};
	class button_register4: RscButtonEmpty
	{
		idc = 1602;
		text = $STR_BOWLINIGREGISTER_Register; 
		x = 0.28302 * safezoneW + safezoneX;
		y = 0.84863 * safezoneH + safezoneY;
		w = 0.0459375 * safezoneW;
		h = 0.0320741 * safezoneH;
		action = "[4] call A3PL_Bowling_BRegL;";
	};
	class button_restart4: RscButtonEmpty
	{
		idc = 1603;
		text = $STR_BOWLINIGREGISTER_Restart; 
		x = 0.329844 * safezoneW + safezoneX;
		y = 0.849222 * safezoneH + safezoneY;
		w = 0.0454166 * safezoneW;
		h = 0.0320741 * safezoneH;
		action = "[4] call A3PL_Bowling_BRestart;";
	};
	class button_register2: RscButtonEmpty
	{
		idc = 1604;
		text = $STR_BOWLINIGREGISTER_Register; 
		x = 0.431875 * safezoneW + safezoneX;
		y = 0.585 * safezoneH + safezoneY;
		w = 0.0459375 * safezoneW;
		h = 0.0311481 * safezoneH;
		action = "[2] call A3PL_Bowling_BRegL;";
	};
	class button_restart2: RscButtonEmpty
	{
		idc = 1605;
		text = $STR_BOWLINIGREGISTER_Restart; 
		x = 0.478854 * safezoneW + safezoneX;
		y = 0.585222 * safezoneH + safezoneY;
		w = 0.0448958 * safezoneW;
		h = 0.0311481 * safezoneH;
		action = "[2] call A3PL_Bowling_BRestart;";
	};
	class button_register5: RscButtonEmpty
	{
		idc = 1606;
		text = $STR_BOWLINIGREGISTER_Register; 
		x = 0.431302 * safezoneW + safezoneX;
		y = 0.849445 * safezoneH + safezoneY;
		w = 0.0459375 * safezoneW;
		h = 0.033 * safezoneH;
		action = "[5] call A3PL_Bowling_BRegL;";
	};
	class button_restart5: RscButtonEmpty
	{
		idc = 1607;
		text = $STR_BOWLINIGREGISTER_Restart; 
		x = 0.478333 * safezoneW + safezoneX;
		y = 0.849222 * safezoneH + safezoneY;
		w = 0.0454167 * safezoneW;
		h = 0.033 * safezoneH;
		action = "[5] call A3PL_Bowling_BRestart;";
	};
	class button_register3: RscButtonEmpty
	{
		idc = 1608;
		text = $STR_BOWLINIGREGISTER_Register; 
		x = 0.580417 * safezoneW + safezoneX;
		y = 0.585222 * safezoneH + safezoneY;
		w = 0.0448959 * safezoneW;
		h = 0.0292962 * safezoneH;
		action = "[3] call A3PL_Bowling_BRegL;";
	};
	class button_restart3: RscButtonEmpty
	{
		idc = 1609;
		text = $STR_BOWLINIGREGISTER_Restart; 
		x = 0.626302 * safezoneW + safezoneX;
		y = 0.585222 * safezoneH + safezoneY;
		w = 0.0454166 * safezoneW;
		h = 0.0292963 * safezoneH;
		action = "[3] call A3PL_Bowling_BRestart;";
	};
	class button_register6: RscButtonEmpty
	{
		idc = 1610;
		text = $STR_BOWLINIGREGISTER_Register; 
		x = 0.580104 * safezoneW + safezoneX;
		y = 0.849555 * safezoneH + safezoneY;
		w = 0.0454167 * safezoneW;
		h = 0.0302222 * safezoneH;
		action = "[6] call A3PL_Bowling_BRegL;";
	};
	class button_restart6: RscButtonEmpty
	{
		idc = 1611;
		text = $STR_BOWLINIGREGISTER_Restart; 
		x = 0.626459 * safezoneW + safezoneX;
		y = 0.850037 * safezoneH + safezoneY;
		w = 0.0459375 * safezoneW;
		h = 0.0311481 * safezoneH;
		action = "[6] call A3PL_Bowling_BRestart;";
	};
	class button_kick1: RscButtonEmpty
	{
		idc = 1612;
		text = $STR_BOWLINIGREGISTER_Kick; 
		x = 0.37625 * safezoneW + safezoneX;
		y = 0.586037 * safezoneH + safezoneY;
		w = 0.0459375 * safezoneW;
		h = 0.0302222 * safezoneH;
		action = "[1] call A3PL_Bowling_KickL;";
	};
	class button_kick2: RscButtonEmpty
	{
		idc = 1613;
		text = $STR_BOWLINIGREGISTER_Kick; 
		x = 0.524479 * safezoneW + safezoneX;
		y = 0.585037 * safezoneH + safezoneY;
		w = 0.0454166 * safezoneW;
		h = 0.0311481 * safezoneH;
		action = "[2] call A3PL_Bowling_KickL;";
	};
	class button_kick3: RscButtonEmpty
	{
		idc = 1614;
		text = $STR_BOWLINIGREGISTER_Kick; 
		x = 0.672708 * safezoneW + safezoneX;
		y = 0.584296 * safezoneH + safezoneY;
		w = 0.0448959 * safezoneW;
		h = 0.0302223 * safezoneH;
		action = "[3] call A3PL_Bowling_KickL;";
	};
	class button_kick4: RscButtonEmpty
	{
		idc = 1615;
		text = $STR_BOWLINIGREGISTER_Kick; 
		x = 0.375782 * safezoneW + safezoneX;
		y = 0.849222 * safezoneH + safezoneY;
		w = 0.0448958 * safezoneW;
		h = 0.032074 * safezoneH;
		action = "[4] call A3PL_Bowling_KickL;";
	};
	class button_kick5: RscButtonEmpty
	{
		idc = 1616;
		text = $STR_BOWLINIGREGISTER_Kick; 
		x = 0.524583 * safezoneW + safezoneX;
		y = 0.849481 * safezoneH + safezoneY;
		w = 0.0453646 * safezoneW;
		h = 0.033 * safezoneH;
		action = "[5] call A3PL_Bowling_KickL;";
	};
	class button_kick6: RscButtonEmpty
	{
		idc = 1617;
		text = $STR_BOWLINIGREGISTER_Kick; 
		x = 0.672813 * safezoneW + safezoneX;
		y = 0.849593 * safezoneH + safezoneY;
		w = 0.0459375 * safezoneW;
		h = 0.0311482 * safezoneH;
		action = "[6] call A3PL_Bowling_KickL;";
	};
	class button_refresh: RscButtonEmpty
	{
		idc = 1618;
		text = $STR_Various_Refresh; 
		x = 0.755104 * safezoneW + safezoneX;
		y = 0.350296 * safezoneH + safezoneY;
		w = 0.0277083 * safezoneW;
		h = 0.0497778 * safezoneH;
		action = "call A3PL_Bowling_BRefresh;";
	};
	
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////
		
	};
};
