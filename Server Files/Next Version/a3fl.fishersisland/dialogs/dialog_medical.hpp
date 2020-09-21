class Dialog_Medical
{
	idd = 73;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\medical\dialog_medical.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class static_manbase: RscPicture
		{
			idc = 1201;
			text = "\A3PL_Common\GUI\medical\man_base.paa";
			x = 0.27625 * safezoneW + safezoneX;
			y = 0.140704 * safezoneH + safezoneY;
			w = 0.427969 * safezoneW;
			h = 0.77 * safezoneH;
		};
		class lb_log: RscListbox
		{
			idc = 1500;
			x = 0.179427 * safezoneW + safezoneX;
			y = 0.415 * safezoneH + safezoneY;
			w = 0.183437 * safezoneW;
			h = 0.363333 * safezoneH;
			sizeEx = "0.015 * safezoneH";
		};
		class lb_injuries: RscListbox
		{
			idc = 1501;
			x = 0.617708 * safezoneW + safezoneX;
			y = 0.371259 * safezoneH + safezoneY;
			w = 0.168646 * safezoneW;
			h = 0.243741 * safezoneH;
		};
		class lb_treatments: RscListbox
		{
			idc = 1502;
			x = 0.618229 * safezoneW + safezoneX;
			y = 0.660963 * safezoneH + safezoneY;
			w = 0.167604 * safezoneW;
			h = 0.116889 * safezoneH;
		};
		class struc_patient: RscStructuredText
		{
			idc = 1100;
			text = $STR_MEDICAL_GUITENSKWATAWADRUDGE;
			x = 0.226718 * safezoneW + safezoneX;
			y = 0.235074 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class struc_heart: RscStructuredText
		{
			idc = 1101;
			text = $STR_MEDICAL_NA; 
			x = 0.293125 * safezoneW + safezoneX;
			y = 0.270852 * safezoneH + safezoneY;
			w = 0.0685937 * safezoneW;
			h = 0.0320741 * safezoneH;
		};
		class struc_blood: RscStructuredText
		{
			idc = 1102;
			text = $STR_MEDICAL_NA; 
			x = 0.293229 * safezoneW + safezoneX;
			y = 0.296556 * safezoneH + safezoneY;
			w = 0.0685937 * safezoneW;
			h = 0.0320741 * safezoneH;
		};
		class struc_bloodlvl: RscStructuredText
		{
			idc = 1103;
			text = $STR_MEDICAL_NA; 
			x = 0.293177 * safezoneW + safezoneX;
			y = 0.325852 * safezoneH + safezoneY;
			w = 0.0685937 * safezoneW;
			h = 0.0320741 * safezoneH;
		};
		class struc_part: RscStructuredText
		{
			idc = 1104;
			text = $STR_MEDICAL_GUILOWERARMLEFT;
			x = 0.632187 * safezoneW + safezoneX;
			y = 0.270852 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class button_clear: RscButtonEmpty
		{
			idc = 1600;
			x = 0.220312 * safezoneW + safezoneX;
			y = 0.788111 * safezoneH + safezoneY;
			w = 0.0990625 * safezoneW;
			h = 0.0383333 * safezoneH;
			action = "[] call A3PL_Medical_ClearLog;";
		};
		class button_treat: RscButtonEmpty
		{
			idc = 1601;
			x = 0.650573 * safezoneW + safezoneX;
			y = 0.786926 * safezoneH + safezoneY;
			w = 0.0990625 * safezoneW;
			h = 0.0383333 * safezoneH;
			action = "[] call A3PL_Medical_TreatWoundButton;";
		};
		class button_head: RscButtonEmpty
		{
			idc = 1602;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.231296 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.0874074 * safezoneH;
			tooltip = $STR_MEDICAL_GUIHEAD;
			action = "['head'] call A3PL_Medical_SelectPart;";
		};
		class button_spine1: RscButtonEmpty
		{
			idc = 1603;
			x = 0.459792 * safezoneW + safezoneX;
			y = 0.320296 * safezoneH + safezoneY;
			w = 0.0615625 * safezoneW;
			h = 0.0753704 * safezoneH;
			tooltip = $STR_MEDICAL_GUICHEST;
			action = "['chest'] call A3PL_Medical_SelectPart;";
		};
		class button_spine2: RscButtonEmpty
		{
			idc = 1604;
			x = 0.461354 * safezoneW + safezoneX;
			y = 0.396481 * safezoneH + safezoneY;
			w = 0.0572395 * safezoneW;
			h = 0.0695926 * safezoneH;
			tooltip = $STR_MEDICAL_GUITORSO;
			action = "['torso'] call A3PL_Medical_SelectPart;";
		};
		class button_spine3: RscButtonEmpty
		{
			idc = 1605;
			x = 0.459271 * safezoneW + safezoneX;
			y = 0.467926 * safezoneH + safezoneY;
			w = 0.0603646 * safezoneW;
			h = 0.0760741 * safezoneH;
			tooltip = $STR_MEDICAL_GUIPELVIS;
			action = "['pelvis'] call A3PL_Medical_SelectPart;";
		};
		class button_leftupperleg: RscButtonEmpty
		{
			idc = 1606;
			x = 0.49125 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0386979 * safezoneW;
			h = 0.113482 * safezoneH;
			tooltip = $STR_MEDICAL_GUILEFTUPPERLEG;
			action = "['left upper leg'] call A3PL_Medical_SelectPart;";
		};
		class button_leftlowerleg: RscButtonEmpty
		{
			idc = 1607;
			x = 0.494323 * safezoneW + safezoneX;
			y = 0.659556 * safezoneH + safezoneY;
			w = 0.0386979 * safezoneW;
			h = 0.113482 * safezoneH;
			tooltip = $STR_MEDICAL_GUILEFTLOWERLEG;
			action = "['left lower leg'] call A3PL_Medical_SelectPart;";
		};
		class button_rightupperleg: RscButtonEmpty
		{
			idc = 1608;
			x = 0.44948 * safezoneW + safezoneX;
			y = 0.544815 * safezoneH + safezoneY;
			w = 0.0386979 * safezoneW;
			h = 0.113482 * safezoneH;
			tooltip = $STR_MEDICAL_GUIRIGHTUPPERLEG;
			action = "['right upper leg'] call A3PL_Medical_SelectPart;";
		};
		class button_rightlowerleg: RscButtonEmpty
		{
			idc = 1609;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.659556 * safezoneH + safezoneY;
			w = 0.0386979 * safezoneW;
			h = 0.113482 * safezoneH;
			tooltip = $STR_MEDICAL_GUIRIGHTLOWERLEG;
			action = "['right lower leg'] call A3PL_Medical_SelectPart;";
		};
		class button_rightupperarm: RscButtonEmpty
		{
			idc = 1610;
			x = 0.417865 * safezoneW + safezoneX;
			y = 0.328407 * safezoneH + safezoneY;
			w = 0.0418229 * safezoneW;
			h = 0.13463 * safezoneH;
			tooltip = $STR_MEDICAL_GUIRIGHTUPPERARM;
			action = "['right upper arm'] call A3PL_Medical_SelectPart;";
		};
		class button_leftupperarm: RscButtonEmpty
		{
			idc = 1611;
			x = 0.521667 * safezoneW + safezoneX;
			y = 0.327593 * safezoneH + safezoneY;
			w = 0.0418229 * safezoneW;
			h = 0.13463 * safezoneH;
			tooltip = $STR_MEDICAL_GUILEFTUPPERARM;
			action = "['left upper arm'] call A3PL_Medical_SelectPart;";
		};
		class button_leftlowerarm: RscButtonEmpty
		{
			idc = 1612;
			x = 0.563958 * safezoneW + safezoneX;
			y = 0.395556 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.132 * safezoneH;
			tooltip = $STR_MEDICAL_GUILEFTLOWERARM;
			action = "['left lower arm'] call A3PL_Medical_SelectPart;";
		};
		class button_rightlowerarm: RscButtonEmpty
		{
			idc = 1613;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.132 * safezoneH;
			tooltip = $STR_MEDICAL_GUIRIGHTLOWERARM;
			action = "['right lower arm'] call A3PL_Medical_SelectPart;";
		};
	};
};

class Dialog_DeathScreen
{
	idd = 7300;
	movingEnable = 0;
    enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controlsBackground { };
	class controls
	{
		class DeathInformation: RscStructuredText
		{
			idc = 1001;
			text = "";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.44 * safezoneH;
		};
	};
};
