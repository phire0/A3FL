/* #Zovizi
$[
	1.063,
	["CarStorage",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"static_bg",[1,"",["0.396876 * safezoneW + safezoneX","0.302 * safezoneH + safezoneY","0.20625 * safezoneW","0.418 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_retrieve",[1,"Retrieve",["0.448438 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.0979687 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"list_vehicles",[1,"",["0.427812 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.139219 * safezoneW","0.253 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"static_textstorage",[1,"Car storage",["0.453594 * safezoneW + safezoneX","0.302 * safezoneH + safezoneY","0.0876563 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","2"],[]]
]
*/


class Dialog_ObjectStorage
{
	idd = 58;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "A3PL_Storage_ReturnArray = []";
	onUnload = "A3PL_Storage_ReturnArray = Nil";

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Zovizi)
		////////////////////////////////////////////////////////

		class static_bg: IGUIBack
		{
			idc = 2200;
			x = 0.396876 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.418 * safezoneH;
		};
		class button_retrieve: RscButton
		{
			idc = 1600;
			text = $STR_OBJECTSTORAGE_GUIRETRIEVE; 
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.044 * safezoneH;
			action = "[] call A3PL_Storage_ObjectRetrieveButton";
		};
		class list_vehicles: RscListbox
		{
			idc = 1500;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.253 * safezoneH;
		};
		class static_textstorage: RscText
		{
			idc = 1000;
			text = $STR_OBJECTSTORAGE_GUISTORAGE;
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};


