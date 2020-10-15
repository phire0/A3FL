class Dialog_ExecutiveMenu
{
	idd = 98;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class Background_PlayerList: IGUIBack
		{
			idc = 2200;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.517 * safezoneH;
		};
		class Background_PlayerInformation: IGUIBack
		{
			idc = 2201;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.28875 * safezoneW;
			h = 0.341 * safezoneH;
		};
		class Background_AdminTools: IGUIBack
		{
			idc = 2202;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class TextField_PlayerListSearch: RscEdit
		{
			idc = 1400;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0928035 * safezoneW;
			h = 0.022002 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class TextField_FactorySearch: RscEdit
		{
			idc = 1401;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0928035 * safezoneW;
			h = 0.022002 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class List_PlayerList: RscListbox
		{
			idc = 1500;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.462 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class List_Factory: RscListbox
		{
			idc = 1501;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.253 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class TextField_FactoryCount: RscEdit
		{
			idc = 1403;
			text = "1";
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0515575 * safezoneW;
			h = 0.022002 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class List_PlayerInventory: RscListbox
		{
			idc = 1502;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.154 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class List_PlayerInformation: RscListbox
		{
			idc = 1503;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.121 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Background_Messaging: IGUIBack
		{
			idc = 2203;
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class List_AdminTools: RscListbox
		{
			idc = 1504;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.143 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_AddToPlayer: RscButton
		{
			idc = 1600;
			text = $STR_EXECUTIVEMENU_GUIADDTOPLAYER; 
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "call A3PL_Admin_AddToPlayer;";
		};
		class Button_AddToFactory: RscButton
		{
			idc = 1601;
			text = $STR_EXECUTIVEMENU_GUIADDTOFACTORY; 
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "call A3PL_Admin_AddToFactory;";
		};
		class Button_RemoveItem: RscButton
		{
			idc = 1602;
			text = "Remove Item";
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "call A3PL_Admin_RemoveItem;";
		};
		class Button_FedGear: RscButton
		{
			idc = 1603;
			text = "FBI Gear";
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "[true] call A3PL_Admin_TakeGear;";
		};
		class Button_SavedGear: RscButton
		{
			idc = 1604;
			text = "Saved Gear";
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "[false] call A3PL_Admin_TakeGear;";
		};
		class Button_Unassigned: RscButton
		{
			idc = 1605;
			text = "";
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "";
		};
		class Button_PlayerHeal: RscButton
		{
			idc = 1606;
			text = $STR_EXECUTIVEMENU_GUIHEAL; 
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "call A3PL_AdminHealPlayer;";
		};
		class Button_TeleportTo: RscButton
		{
			idc = 1607;
			text = $STR_EXECUTIVEMENU_GUITELEPORTTO; 
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "call A3PL_AdminTeleportTo;";
		};
		class Button_TeleportToMe: RscButton
		{
			idc = 1608;
			text = $STR_EXECUTIVEMENU_GUITELEPORTTOME; 
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "call A3PL_AdminTeleportToMe;";
		};
		class Button_GlobalMessage: RscButton
		{
			idc = 1609;
			text = $STR_EXECUTIVEMENU_GUIGLOBALMESSAGE; 
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "call A3PL_AdminGlobalMessage;";
		};
		class Button_AdminMessage: RscButton
		{
			idc = 1610;
			text = $STR_EXECUTIVEMENU_GUIADMINMESSAGE; 
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "call A3PL_AdminAdminMessage;";
		};
		class Button_DirectMessage: RscButton
		{
			idc = 1611;
			text = $STR_EXECUTIVEMENU_GUIDIRECTMESSAGE; 
			x = 0.649531 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "call A3PL_AdminDirectMessage;";
		};
		class TextField_Messages: RscEdit
		{
			idc = 1402;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_FactorySearch: RscButton
		{
			idc = 1612;
			text = "?"; 
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "call A3PL_AdminSearchFactoryList;";
		};
		class Button_PlayerSearch: RscButton
		{
			idc = 1613;
			text = "?"; 
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
			action = "call A3PL_AdminSearchPlayerList;";
		};
		class IGUIBack_2204: IGUIBack
		{
			idc = 2204;
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class IGUIBack_2205: IGUIBack
		{
			idc = 2205;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class DropDown_Factory: RscCombo
		{
			idc = 2100;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class DropDown_PlayerInventories: RscCombo
		{
			idc = 2101;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Text_AdminName: RscText
		{
			idc = 1000;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 24 * GUI_GRID_H + GUI_GRID_Y;
			w = 22.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Text_PanelName: RscText
		{
			idc = 1001;
			text = "Fishers Life";
			x = 34 * GUI_GRID_W + GUI_GRID_X;
			y = 24 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			sizeEx = .8 * GUI_GRID_H;
		};
		class TwitterTags: RscCombo
		{
			idc = 2102;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.6705 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class FactionsSetting: RscCombo
		{
			idc = 2103;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.70 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
	};
};