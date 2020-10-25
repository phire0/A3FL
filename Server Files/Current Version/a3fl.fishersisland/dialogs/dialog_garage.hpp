class Dialog_Garage
{
	idd = 62;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Sisisa)
		////////////////////////////////////////////////////////

		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_Garage.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class lb_upgrades: RscListbox
		{
			idc = 1500;
			x = 0.736615 * safezoneW + safezoneX;
			y = 0.114667 * safezoneH + safezoneY;
			w = 0.23552 * safezoneW;
			h = 0.258815 * safezoneH;
		};
		class lb_requiredupgrade: RscListbox
		{
			idc = 1501;
			x = 0.735625 * safezoneW + safezoneX;
			y = 0.505556 * safezoneH + safezoneY;
			w = 0.235 * safezoneW;
			h = 0.0773336 * safezoneH;
		};
		class lb_repairlist: RscListbox
		{
			idc = 1502;
			x = 0.0276562 * safezoneW + safezoneX;
			y = 0.116741 * safezoneH + safezoneY;
			w = 0.235521 * safezoneW;
			h = 0.192148 * safezoneH;
		};
		class lb_requiredrepair: RscListbox
		{
			idc = 1503;
			x = 0.0276562 * safezoneW + safezoneX;
			y = 0.417444 * safezoneH + safezoneY;
			w = 0.236042 * safezoneW;
			h = 0.105111 * safezoneH;
		};
		class lb_painttextures: RscListbox
		{
			idc = 1504;
			x = 0.0276562 * safezoneW + safezoneX;
			y = 0.798741 * safezoneH + safezoneY;
			w = 0.23448 * safezoneW;
			h = 0.107889 * safezoneH;
		};
		class struc_damage: RscStructuredText
		{
			idc = 1100;
			text = "<t align='center' size ='1.4'> 0% </t>";
			x = 0.1225 * safezoneW + safezoneX;
			y = 0.333148 * safezoneH + safezoneY;
			w = 0.12052 * safezoneW;
			h = 0.0302222 * safezoneH;
		};
		class struc_desc: RscStructuredText
		{
			idc = 1101;
			text = "<t align='center' size ='1'></t>";
			x = 0.83 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class struc_upgradeprice: RscStructuredText
		{
			idc = 1102;
			text = "<t align='center' size ='1.2'></t>";
			x = 0.856823 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class button_upgrade: RscButtonEmpty
		{
			idc = 1600;
			x = 0.802136 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.0979166 * safezoneW;
			h = 0.0404074 * safezoneH;
		};
		class button_repair: RscButtonEmpty
		{
			idc = 1601;
			x = 0.0926562 * safezoneW + safezoneX;
			y = 0.554074 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.0413333 * safezoneH;
		};
		class button_painttexture: RscButtonEmpty
		{
			idc = 1602;
			x = 0.0364583 * safezoneW + safezoneX;
			y = 0.92437 * safezoneH + safezoneY;
			w = 0.0989584 * safezoneW;
			h = 0.0376296 * safezoneH;
		};
		class button_paintrgb: RscButtonEmpty
		{
			idc = 1603;
			x = 0.153489 * safezoneW + safezoneX;
			y = 0.925296 * safezoneH + safezoneY;
			w = 0.0989584 * safezoneW;
			h = 0.0376296 * safezoneH;
		};
		class button_close: RscButtonEmpty
		{
			idc = 1604;
			x = 0.958906 * safezoneW + safezoneX;
			y = 0.038 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscEditRed: RscEdit
		{
			idc = 1400;
			text = "0";
			x = 0.115 * safezoneW + safezoneX;
			y = 0.695 * safezoneH + safezoneY;
			w = 0.148 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class RscEditGreen: RscEdit
		{
			idc = 1401;
			text = "0";
			x = 0.115 * safezoneW + safezoneX;
			y = 0.728 * safezoneH + safezoneY;
			w = 0.148 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class RscEditBlue: RscEdit
		{
			idc = 1402;
			text = "0";
			x = 0.115 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.148 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class lb_materials: RscListbox
		{
			idc = 1505;
			x = 0.386047 * safezoneW + safezoneX;
			y = 0.11324 * safezoneH + safezoneY;
			w = 0.241771 * safezoneW;
			h = 0.0818519 * safezoneH;
		};
		class button_setMaterial: RscButtonEmpty
		{
			idc = 1605;
			x = 0.4505 * safezoneW + safezoneX;
			y = 0.21224 * safezoneH + safezoneY;
			w = 0.0985417 * safezoneW;
			h = 0.0411112 * safezoneH;
		};

		class edit_licenseplate: RscEdit
		{
			idc = 1405;
			x = 0.390687 * safezoneW + safezoneX;
			y = 0.87114 * safezoneH + safezoneY;
			w = 0.236198 * safezoneW;
			h = 0.0357777 * safezoneH;
		};
		
		class button_setLicensePlate: RscButtonEmpty
		{
			idc = 1606;
			x = 0.458334 * safezoneW + safezoneX;
			y = 0.923555 * safezoneH + safezoneY;
			w = 0.0980209 * safezoneW;
			h = 0.0411112 * safezoneH;
		};		
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};