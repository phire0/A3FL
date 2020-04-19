class Dialog_CCTV
{
	idd = 27;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "if (!isNull A3PL_NPC_Cam) then {A3PL_NPC_Cam cameraEffect ['TERMINATE', 'BACK']; camDestroy A3PL_NPC_Cam};";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Jezuri)
		////////////////////////////////////////////////////////

		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_CCTV2.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class A3PL_CCTV_3: RscPicture
		{
			idc = 1202;
			text = "#(argb,256,256,1)r2t(A3PL_CCTV_3_RT,1.0)";
			x = 0.185469 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.308 * safezoneH;
		};
		class A3PL_CCTV_2: RscPicture
		{
			idc = 1203;
			text = "#(argb,256,256,1)r2t(A3PL_CCTV_2_RT,1.0)";
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.308 * safezoneH;
		};
		class A3PL_CCTV_4: RscPicture
		{
			idc = 1204;
			text = "#(argb,256,256,1)r2t(A3PL_CCTV_4_RT,1.0)";
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.308 * safezoneH;
		};
		class A3PL_CCTV_1: RscPicture
		{
			idc = 1201;
			text = "#(argb,256,256,1)r2t(A3PL_CCTV_1_RT,1.0))";
			x = 0.185469 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.308 * safezoneH;
		};
		class combo_cam1: RscCombo
		{
			idc = 2100;
			x = 0.206197 * safezoneW + safezoneX;
			y = 0.15856 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class combo_cam2: RscCombo
		{
			idc = 2101;
			x = 0.581881 * safezoneW + safezoneX;
			y = 0.1579 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class combo_cam3: RscCombo
		{
			idc = 2102;
			x = 0.206094 * safezoneW + safezoneX;
			y = 0.874 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class combo_cam4: RscCombo
		{
			idc = 2103;
			x = 0.581984 * safezoneW + safezoneX;
			y = 0.874 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.033 * safezoneH;
		};		
		
		class check_normal: RscTextCheckbox
		{
			idc = 2500;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.164556 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.022 * safezoneH;
			strings[] = 
			{
				"NORMAL"
			};
			checked_strings[] = 
			{
				"NORMAL"
			};			
		};
		class check_night: RscTextCheckbox
		{
			idc = 2501;
			text = $STR_CCTV_Normal;
			x = 0.479896 * safezoneW + safezoneX;
			y = 0.164444 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.022 * safezoneH;
			strings[] = 
			{
				"NV"
			};
			checked_strings[] = 
			{
				"NV"
			};				
		};
		class check_thermal: RscTextCheckbox
		{
			idc = 2502;
			text = $STR_CCTV_Normal;
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.164444 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.022 * safezoneH;
			strings[] = 
			{
				"THERMAL"
			};
			checked_strings[] = 
			{
				"THERMAL"
			};			
		};	
	};
};