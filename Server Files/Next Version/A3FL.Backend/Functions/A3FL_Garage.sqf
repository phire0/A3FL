/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define GARAGE_CAM_OFFSET [0.3,5.2,0.9]
#define GARAGE_CAM_DIR 20

//Open garage menu
["A3PL_Garage_Open",
{
	disableSerialization;
	private ["_cam","_logic","_garage","_display","_control","_upgrades","_veh","_typeOf","_allHitPoints","_textures","_hitArray","_dmghitArray"];
	_garage = param [0,objNull]; //garage building
	_job = player getVariable["job","unemployed"];
	if (_garage IN [AircraftPaint]) then
	{
		_veh = (nearestObjects [player,["Helicopter","plane"],25]) select 0;
	} else
	{
		_veh = (nearestObjects [player,["Car_F","Ship_F","Tank_F"],10]) select 0;
	};
	if (isNil "_veh") exitwith {["There is no vehicle near the garage","red"] call A3PL_Player_Notification;};

	if (isNull _garage OR isNull _veh) exitwith {}; //incorrect params
	_typeOf = typeOf _veh;

	createDialog "Dialog_Garage";
	_display = findDisplay 62; //display of menu

	_logic = "logic" createvehicleLocal [0,0,0];
	_logic setposASL [(getPosWorld _veh) select 0,(getposWorld _veh) select 1,((getposWorld _veh) select 2) - 1]; //offset depending on veh
	_logic setDir (getDir _veh + GARAGE_CAM_DIR); //dir of camera in relation to target
	_cam = "camera" camCreate [0,0,0];
	_cam camSetTarget _logic;
	_cam camSetPos (positionCameraToWorld [0,0,0]);
	_cam camCommit 0;
	_cam cameraEffect ["internal", "BACK"];
	if (_garage == AircraftPaint) then
	{
		_cam camSetRelPos [7,-3,0.9];
	} else
	{
		_cam camSetRelPos GARAGE_CAM_OFFSET;
	};
	_cam camCommit 1;

	//add damages to list
	_control = _display displayCtrl 1502;
	_i = _control lbAdd "Repair All";
	_control lbSetData [_i,"all"];
	
	_allHitPoints = getAllHitPointsDamage _veh;
	_hitArray = _allHitPoints select 1;
	_dmghitArray = _allHitPoints select 2;
	{
		if (_x != "") then
		{
			private ["_name"];
			_name = [_x,"title"] call A3PL_Config_GetGarageRepair;
			if (typeName _name == "BOOL") then {_name = _x};
			_i = _control lbAdd _name;
			_control lbSetData [_i,_x];
		};
	} foreach _hitArray;
	
	//add textures to list
	_control = _display displayCtrl 1504;
	_textures = ["all",_typeOf,"",_job] call A3PL_Config_GetGaragePaint;
	{
		private ["_i"];
		_i = _control lbAdd (_x select 2);
		_control lbSetData [_i,(_x select 0)];
	} foreach _textures;

	//add upgrades to list
	_control = _display displayCtrl 1500;
	_upgrades = ["all",_typeOf,""] call A3PL_Config_GetGarageUpgrade;
	{
		private ["_i"];
		_i = _control lbAdd (_x select 3);
		_control lbSetData [_i,(_x select 0)];
	} foreach _upgrades;

	//add materials to list
	_control = _display displayCtrl 1505;
	{
		private ["_i"];
		_i = _control lbAdd (_x select 1);
		_control lbSetData [_i,(_x select 0)];
	} foreach Config_Garage_Materials;

	//what happends when we press an item in the upgrade listbox
	_control = _display displayCtrl 1500;
	_control ctrlAddEventhandler ["LBSelChanged","_this call A3PL_Garage_ClickUpgrade"];

	//what happends when we press an item in the material listbox
	_control = _display displayCtrl 1505;
	_control ctrlAddEventhandler ["LBSelChanged",format ["['%1',_this] call A3PL_Garage_ClickMaterial;",_veh]];

	//what if we click one of our components in the Repair list
	_control = _display displayCtrl 1502;
	_control ctrlAddEventhandler ["LBSelChanged",format ["['%1'] call A3PL_Garage_LBRepair;",_veh]];

	//what if we click one of our texture in the paint list
	_control = _display displayCtrl 1504;
	_control ctrlAddEventhandler ["LBSelChanged",format ["['%1','tex'] call A3PL_Garage_SetSliderColour",_veh]];

	//what happends when we move the slider
	_control = _display displayCtrl 1900;
	_control sliderSetRange [0,1];
	_control ctrlAddEventhandler ["SliderPosChanged",format ["['%1'] call A3PL_Garage_SetSliderColour",_veh]];
	_control = _display displayCtrl 1901;
	_control sliderSetRange [0,1];
	_control ctrlAddEventhandler ["SliderPosChanged",format ["['%1'] call A3PL_Garage_SetSliderColour",_veh]];
	_control = _display displayCtrl 1902;
	_control sliderSetRange [0,1];
	_control ctrlAddEventhandler ["SliderPosChanged",format ["['%1'] call A3PL_Garage_SetSliderColour",_veh]];

	//Set the button actions
	_control = _display displayCtrl 1600;
	_control buttonSetAction "['No upgrade selected','red'] call A3PL_Player_Notification;";
	_control = _display displayCtrl 1601;
	_control buttonSetAction format ["['%1'] call A3PL_Garage_Repair",_veh];
	_control = _display displayCtrl 1602;
	_control buttonSetAction format ["['tex','%1'] call A3PL_Garage_ColourSet",_veh];
	_control = _display displayCtrl 1603;
	_control buttonSetAction "call A3PL_Garage_ColourSet";
	_control = _display displayCtrl 1605;
	_control buttonSetAction "call A3PL_Garage_SetMaterial";
	_control = _display displayCtrl 1606;
	_control buttonSetAction "call A3PL_Garage_SetLicensePlate";

	A3PL_Garage_Veh = _veh;
	A3PL_Garage_Cam = _cam; //save in missionNamespace so we can reference it later
	A3PL_Garage_Logic = _logic;
	A3PL_Garage_MyColor = ((getObjectTextures _veh) select 0);

	//get material
	A3PL_Garage_MyMaterial = (getObjectMaterials _veh) select 0;
	if (A3PL_Garage_MyMaterial == "") then
	{
		A3PL_Garage_MyMaterial = "A3PL_Cars\common\rvmats\car_paint.rvmat";
	};

	while {!isNull _display} do
	{
		uiSleep 0.01;
	};

	//dialog was closed
	camDestroy _cam;
	A3PL_Garage_Cam = nil;
	A3PL_Garage_Veh = nil;
	A3PL_Garage_Logic = nil;

	//assign new color
	if ((missionNameSpace getVariable ["A3PL_Garage_NewColor",A3PL_Garage_MyColor]) != A3PL_Garage_MyColor) then
	{
		_file = A3PL_Garage_NewColor;
		_cnt = count _file;
		if (_cnt == 1) then {_file1 = _file select 0;_veh setObjectTextureGlobal [0,_file1]};
		if (_cnt == 2) then {_file1 = _file select 0;_file2 = _file select 1;_veh setObjectTextureGlobal [0,_file1];_veh setObjectTextureGlobal [1,_file2]};
		if (_cnt == 3) then {_file1 = _file select 0;_file2 = _file select 1;_file3 = _file select 2;_veh setObjectTextureGlobal [0,_file1];_veh setObjectTextureGlobal [1,_file2];_veh setObjectTextureGlobal [2,_file3]};
		if (_cnt == 4) then {_file1 = _file select 0;_file2 = _file select 1;_file3 = _file select 2;_file4 = _file select 3;_veh setObjectTextureGlobal [0,_file1];_veh setObjectTextureGlobal [1,_file2];_veh setObjectTextureGlobal [2,_file3];_veh setObjectTextureGlobal [3,_file4]};

	} else
	{
		_veh setObjectTextureGlobal [0,A3PL_Garage_MyColor];
	};

	//assign new material
	if ((missionNameSpace getVariable ["A3PL_Garage_NewMaterial",A3PL_Garage_MyMaterial]) != A3PL_Garage_MyMaterial) then
	{
		//set new bought material globally
		_veh setObjectMaterialGlobal [0,A3PL_Garage_NewMaterial];
	} else
	{
		//reset material
		_veh setObjectMaterial [0,A3PL_Garage_MyMaterial];
	};

	//clear any temp upgrades
	if ((missionNameSpace getVariable ["A3PL_Garage_tUpgrade",""]) != "") then
	{
		[_veh,A3PL_Garage_tUpgrade,0] call A3PL_Garage_Upgrade;
	};
	A3PL_Garage_tUpgrade = nil;
	A3PL_Garage_MyColor = nil;
	A3PL_Garage_MyMaterial = nil;
	A3PL_Garage_NewMaterial = nil;
	A3PL_Garage_NewColor = nil;
	deleteVehicle _logic;
	player cameraEffect ["terminate", "BACK"];
}] call Server_Setup_Compile;

//when we click the "change license plate" button
["A3PL_Garage_SetLicensePlate",
{
	private ["_display","_control","_veh","_newLP","_allowedChars","_validChars"];
	_veh = A3PL_Garage_Veh;
	_display = findDisplay 62;
	_control = _display displayCtrl 1400;


	//check if we have motorhead perk
	if (!(["motorhead"] call A3PL_Lib_hasPerk)) exitwith {["You don't have the motorhead perk, for more information -> www.arma3fisherslife.net","red"] call A3PL_Player_Notification;};

	//check if we own the vehicle
	if (!(((_veh getVariable ["owner",["",""]]) select 0) == (getPlayerUID player))) exitwith {["This vehicle does not belong to you, you can only change plates on a vehicle you own!","red"] call A3PL_Player_Notification;closeDialog 0;};

	// check if we have enough cash
	_pCash = player getVariable ["player_cash",0];
	_price = 20000;
	if (_price > _pCash) exitwith {[format["You are missing $%1 to change the license plate!",_price-_pCash]] call A3PL_Player_notification;};

	//check if new LP is 7 chars and only contains numbers and letters
	_newLP = ctrlText _control;
	_allowedChars = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
	if ((count _newLP) != 7) exitwith {["Your personalized license plate must have 7 characters!","red"] call A3PL_Player_Notification;};
	_validChars = true;

	for "_i" from 0 to ((count _newLP) - 1) do
	{
		private ["_test"];
		_test = _newLP select [_i,1];
		if (!(_test IN _allowedChars)) exitwith {_validChars = false;};
	};

	if (!(_validChars)) exitwith {["Your custom license plate contains invalid characters (allowed characters: 0 to 9 and lowercase a-z).","red"] call A3PL_Player_Notification;};


	//Plate protection
	_cars = nearestObjects [player, ["Car"], 10];
	_car = _cars select 0;
	_id = _car getVariable "owner" select 1;

	if (_id IN ["WASTE","DELIVER","EXTERMINATOR","KARTING","ADMIN","ROADSIDE"]) exitWith {["You cannot change the plate of this vehicle", "red"] call A3PL_Player_Notification;};

	//Tell the server that heeey we want our license plate to be changed
	[player,_veh,_newLP] remoteExec ["Server_Vehicle_InitLPChange", 2, false];
	[player, 15] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_Garage_SetLicensePlateResponse",
{
	private ["_response"];
	 _response = param [0,0];

	 switch (_response) do
	 {
		case (0): {["License plate already used!","red"] call A3PL_Player_Notification;};
    	case (1): {["The license plate has been successfully modified!","green"] call A3PL_Player_Notification;};
		case (2): {["You recently changed the license plate of this vehicle!","red"] call A3PL_Player_Notification;};
		case (3): {["You do not have enough money to change the license plate of this vehicle!","red"] call A3PL_Player_Notification;};
	};
}] call Server_Setup_Compile;

//when we click a component in the material list
["A3PL_Garage_ClickMaterial",
{
	private ["_veh","_selectedIndex","_newMaterial"];
	_veh = A3PL_Garage_Veh;
	_selectedIndex = (param [1,[]]) select 1;
	_newMaterial = (Config_Garage_Materials select _selectedIndex) select 0;

	_veh setObjectMaterial [0,_newMaterial];

}] call Server_Setup_Compile;

//when we click the set material button
["A3PL_Garage_SetMaterial",
{
	private ["_display","_control","_veh","_selectedIndex"];
	_display = findDisplay 62;
	_control = _display displayCtrl 1505;
	_veh = A3PL_Garage_Veh;
	_selectedIndex = lbCurSel _control;

	//check if we have motorhead perk
	if (!(["motorhead"] call A3PL_Lib_hasPerk)) exitwith {["You don't have the motorhead perk, for more information -> www.arma3fisherslife.net","red"] call A3PL_Player_Notification;};

	// check if we have enough cash
	_pCash = player getVariable["player_cash", 0];
	_price = 2000;
	if (_price > _pCash) exitwith{[format["You are missing $%1 to change the vehicle material!",_price-_pCash]] call A3PL_Player_notification;};

	//check if we own the vehicle
	if (!(((_veh getVariable ["owner",["",""]]) select 0) == (getPlayerUID player))) exitwith {["This is not your vehicle!","red"] call A3PL_Player_Notification;};

	if ((lbCurSel _control) < 0) exitwith {["Please select a material","red"] call A3PL_Player_Notification;};
	A3PL_Garage_NewMaterial = (Config_Garage_Materials select _selectedIndex) select 0;

	player setVariable["Player_Cash", _pCash - _price, true];
	["You changed the material of your vehicle for $2,000!","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//when we click a component in the repair list
["A3PL_Garage_LBRepair",
{
	private ["_veh","_allHitPoints","_hitArray","_dmgHitArray","_display","_control","_selHit","_selHiti","_dmgValue"];
	_veh = param [0,objNull];
	_display = findDisplay 62;
	if (typeName _veh == "STRING") then
	{
		_veh = [_veh] call A3PL_Lib_vehStringToObj;
	};

	_control = _display displayCtrl 1502;
	_selHit = _control lbData (lbCurSel _control);
	if(_selHit == "all") then {
		_dmgValue = 1-(damage _veh);
	} else {
		_allHitPoints = getAllHitPointsDamage _veh;
		_hitArray = _allHitPoints select 1;
		_dmghitArray = _allHitPoints select 2;
		_selHiti = _hitArray find _selHit;
		_dmgValue = _dmgHitArray select _selHiti;
	};

	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format ["<t align='center' size ='1.4'> %1%2 </t>",round(_dmgValue*100),"%"];
}] call Server_Setup_Compile;

//when we click the repair button
["A3PL_Garage_Repair",
{
	private ["_veh","_selHit"];
	_veh = param [0,objNull];
	if (typeName _veh == "STRING") then
	{
		_veh = [_veh] call A3PL_Lib_vehStringToObj;
	};

	_display = findDisplay 62;
	_control = _display displayCtrl 1502;
	_selHit = _control lbData (lbCurSel _control);

	_title = "your vehicle";
	if(_selHit == "all") then {
		_veh setDamage 0;
	} else {
		_veh setHit [_selHit,0];
		_title = [_selHit,"title"] call A3PL_Config_GetGarageRepair;
	};
	[format ["You repaired %1",_title],"green"] call A3PL_Player_Notification;

	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format ["<t align='center' size ='1.4'> %1%2 </t>",0,"%"];
}] call Server_Setup_Compile;

["A3PL_Garage_ColourSet",
{
	private ["_display","_control","_rSlider","_gSlider","_bSlider","_veh","_text","_texture"];
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	_texture = param [0,""];
	_veh = param [1,objNull];
	if (typeName _veh == "STRING") then //edited bypass used in ATC so we can send object from setButtonAction
	{
		_veh = [_veh] call A3PL_Lib_vehStringToObj;
	};
	_display = findDisplay 62;

	// check if we have enough cash
	_pCash = player getVariable["player_cash", 0];
	_price = 2000;
	if (_price > _pCash) exitwith{ [format["You are missing $%1 to change the vehicle color!",_price - _pCash]] call A3PL_Player_notification; };

	if (_texture != "") exitwith
	{
		private ["_id","_file"];
		_control = _display displayCtrl 1504;
		_id = _control lbData (lbCurSel _control);
		_job = player getVariable["job","unemployed"];
		_file = [_id,typeOf _veh,"file",_job] call A3PL_Config_GetGaragePaint;

		if (typeName _file == "ARRAY") then
		{
			_cnt = count _file;
			if (_cnt == 1) then {_file1 = _file select 0;_veh setObjectTextureGlobal [0,_file1]};
			if (_cnt == 2) then {_file1 = _file select 0;_file2 = _file select 1;_veh setObjectTextureGlobal [0,_file1];_veh setObjectTextureGlobal [1,_file2]};
			if (_cnt == 3) then {_file1 = _file select 0;_file2 = _file select 1;_file3 = _file select 2;_veh setObjectTextureGlobal [0,_file1];_veh setObjectTextureGlobal [1,_file2];_veh setObjectTextureGlobal [2,_file3]};
			if (_cnt == 4) then {_file1 = _file select 0;_file2 = _file select 1;_file3 = _file select 2;_file4 = _file select 3;_veh setObjectTextureGlobal [0,_file1];_veh setObjectTextureGlobal [1,_file2];_veh setObjectTextureGlobal [2,_file3];_veh setObjectTextureGlobal [3,_file4]};
		};
		A3PL_Garage_NewColor = _file select 0;
		A3PL_Garage_NewColorArry = _file;
	};

	_control = _display displayCtrl 1900;
	_rSlider = sliderPosition _control;
	_control = _display displayCtrl 1901;
	_gSlider = sliderPosition _control;
	_control = _display displayCtrl 1902;
	_bSlider = sliderPosition _control;
	_text = format ["#(argb,8,8,3)color(%1,%2,%3,1.0,CO)",_rSlider,_gSlider,_bSlider];
	A3PL_Garage_NewColor = _text;

	[_veh,_text] remoteExec ["Server_Vehicle_SetPaint",2];
	player setVariable["Player_Cash", _pCash - _price, true];
	["You have repainted your vehicle for $2,000.","green"] call A3PL_Player_Notification;	
}] call Server_Setup_Compile;

["A3PL_Garage_SetSliderColour",
{
	private ["_texture","_control","_display","_rSlider","_gSlider","_bSlider","_veh","_text"];
	_veh = param [0,objNull];
	_texture = param [1,""];
	_display = findDisplay 62;

	if (typeName _veh == "STRING") then //edited bypass used in ATC so we can send object from setButtonAction
	{
		_veh = [_veh] call A3PL_Lib_vehStringToObj;
	};
	if (isNull _veh) exitwith {};

	//set a vehicle texture instead
	if (_texture != "") exitwith
	{
		private ["_id","_file"];
		_control = _display displayCtrl 1504;
		_id = _control lbData (lbCurSel _control);
		_job = player getVariable["job","unemployed"];
		_file = [_id,typeOf _veh,"file",_job] call A3PL_Config_GetGaragePaint;
		if (typeName _file == "BOOL") exitwith {};
		if (typeName _file == "ARRAY") then
		{
			_cnt = count _file;
			if (_cnt == 1) then {_file1 = _file select 0;_veh setObjectTextureGlobal [0,_file1]};
			if (_cnt == 2) then {_file1 = _file select 0;_file2 = _file select 1;_veh setObjectTextureGlobal [0,_file1];_veh setObjectTextureGlobal [1,_file2]};
			if (_cnt == 3) then {_file1 = _file select 0;_file2 = _file select 1;_file3 = _file select 2;_veh setObjectTextureGlobal [0,_file1];_veh setObjectTextureGlobal [1,_file2];_veh setObjectTextureGlobal [2,_file3]};
			if (_cnt == 4) then {_file1 = _file select 0;_file2 = _file select 1;_file3 = _file select 2;_file4 = _file select 3;_veh setObjectTextureGlobal [0,_file1];_veh setObjectTextureGlobal [1,_file2];_veh setObjectTextureGlobal [2,_file3];_veh setObjectTextureGlobal [3,_file4]};
		};
	};

	_control = _display displayCtrl 1900;
	_rSlider = sliderPosition _control;
	_control = _display displayCtrl 1901;
	_gSlider = sliderPosition _control;
	_control = _display displayCtrl 1902;
	_bSlider = sliderPosition _control;
	_text = format ["#(argb,8,8,3)color(%1,%2,%3,1.0,CO)",_rSlider,_gSlider,_bSlider];
	_veh setObjectTextureGlobal [0,_text];
}] call Server_Setup_Compile;

//what happends when we click an upgrade in the listbox
["A3PL_Garage_ClickUpgrade",
{
	disableSerialization;
	private ["_display","_control","_veh","_typeOf","_tpos","_tOffset","_logic","_upgradeType","_title"];
	_display = findDisplay 62; //display of menu
	_control = param [0,controlNull]; //vehicle upgrade lb
	_i = param [1,0]; //index
	_veh = missionNameSpace getVariable ["A3PL_Garage_Veh",ObjNull];
	_cam = missionNameSpace getVariable ["A3PL_Garage_Cam",ObjNull];
	_logic = missionNameSpace getVariable ["A3PL_Garage_Logic",ObjNull];
	_typeOf = typeOf _veh;
	_id = _control lbData _i; //id of selected upgrade

	_upgradeType = [];
	_title = [_id,_typeOf,"title"] call A3PL_Config_GetGarageUpgrade;
	_tPos = [_id,_typeOf,"camTarget"] call A3PL_Config_GetGarageUpgrade; //new camera target
	if (typeName _tPos == "string") then {_tPos = _veh selectionPosition [_tPos,"memory"];}; //get model position of memory point
	_tOffset = [_id,_typeOf,"camOffset"] call A3PL_Config_GetGarageUpgrade; //new camera offset from target

	//set new cam positions
	_logic setpos (_veh modelToWorld _tPos);
	_cam camSetTarget _logic;
	_cam camSetRelPos _tOffset;
	_cam camCommit 2; //2 sec transition

	//set the description of the item
	_control = _display displayCtrl 1101;
	_control ctrlSetStructuredText parseText format ["<t align='center' size ='1'>%1</t>",([_id,_typeOf,"desc"] call A3PL_Config_GetGarageUpgrade)];

	//set the price
	_control = _display displayCtrl 1102;
	_control ctrlSetStructuredText parseText format ["<t align='center' size ='1.2'>$%1</t>",([_id,_typeOf,"price"] call A3PL_Config_GetGarageUpgrade)];

	_control = _display displayCtrl 1501;
	lbClear _control;
	_required = [_id,_typeOf,"required"] call A3PL_Config_GetGarageUpgrade;
	_lbArray = [];
	{
		private ["_i","_name","_amount","_class"];
		_class = _x select 0;
		_amount = _x select 1;
		_name = format ["%1x %2",_amount,([_class,"name"] call A3PL_Config_GetItem)];
		if ([_class,_amount] call A3PL_Inventory_Has) then
		{
			_lbArray pushback [_name,_class,true];
		} else
		{
			_lbArray pushback [_name,_class,false];
		};
	} foreach _required;
	lbClear _control;
	{
		_i = _control lbAdd (_x select 0);
		_control lbSetData [_i,(_x select 1)];
		if (_x select 2) then {_control lbSetColor [_i,[0, 1, 0, 1]];} else {_control lbSetColor [_i,[1, 0, 0, 1]];};
	} foreach _lbArray;

	//Set the button action for upgrading
	_control = _display displayCtrl 1600;
	_requiredLevel = [_id,_typeOf,"level"] call A3PL_Config_GetGarageUpgrade;
	_playerLevel = player getVariable["Player_Level",0];
	if(_playerLevel < _requiredLevel) then {
		_control ctrlEnable false;
		_control buttonSetAction "";
		_control = _display displayCtrl 1101;
		_control ctrlSetStructuredText parseText format ["<t align='center' size ='1' color='#FD1703'>Level %1 needed</t>",_requiredLevel];
	} else {
		_control ctrlEnable true;
		_control buttonSetAction format
		[
			"
				private ['_installed'];
				if(!(call A3PL_Player_AntiSpam)) exitWith {};
				_installed = isNil 'A3PL_Garage_tUpgrade';
				if (_installed) then {_installed = 0;} else {_installed = 1};
				['%1','%2',_installed, false] call A3PL_Garage_Upgrade;
			",_veh,_id,_title,"green"
		];
	};

	//undo any previous temp upgrades
	if ((missionNameSpace getVariable ["A3PL_Garage_tUpgrade",""]) != "") then
	{
		[_veh,A3PL_Garage_tUpgrade,0] call A3PL_Garage_Upgrade;
	};

	//install the addon while we preview it
	if (!([_veh,_id] call A3PL_Garage_isInstalled)) then
	{
		[_veh,_id] call A3PL_Garage_Upgrade;
		A3PL_Garage_tUpgrade = _id;
	} else
	{
		A3PL_Garage_tUpgrade = nil;
	};
}] call Server_Setup_Compile;

//check if an upgrade is already installed
["A3PL_Garage_isInstalled",
{
	private ["_veh","_id","_typeOf","_installed","_upgradeType"];
	_veh = param [0,objNull,[objNull,""]];
	if (typeName _veh == "STRING") then //edited bypass used in ATC so we can send object from setButtonAction
	{
		_veh = [_veh] call A3PL_Lib_vehStringToObj;
	};
	if (isNull _veh) exitwith {["Error code #03","red"] call A3PL_Player_Notification;};
	_id = param [1,""];
	_typeOf = typeOf _veh;
	_upgradeType = [_id,_typeOf,"type"] call A3PL_Config_GetGarageUpgrade;

	_installed = false;
	switch (_upgradeType) do
	{
		case ("addon"):
		{
			private ["_animation"];
			_animation = [_id,_typeOf,"class"] call A3PL_Config_GetGarageUpgrade;
			if (_veh animationSourcePhase _animation > 0.5) then
			{
				_installed = true;
			};
		};
	};
	_installed;
}] call Server_Setup_Compile;

//either installs, or deinstalls an upgrade
["A3PL_Garage_Upgrade",
{
	private ["_veh","_id","_typeOf","_isInstalled","_upgradeType","_upgradeClass","_forceInstall"];
	_veh = param [0,objNull,[objNull,""]];
	_id = param [1,""];
	_forceInstall = param [2,-1]; //-1 dont force, 0 no, 1 yes NOTE: will also be used as new anim value
	_preview = param [3,true];

	if (typeName _veh == "STRING") then //edited bypass used in ATC so we can send object from setButtonAction
	{
		_veh = [_veh] call A3PL_Lib_vehStringToObj;
	};
	_typeOf = typeOf _veh;
	_upgradeType = [_id,_typeOf,"type"] call A3PL_Config_GetGarageUpgrade;
	_upgradeClass = [_id,_typeOf,"class"] call A3PL_Config_GetGarageUpgrade;
	if (isNil "_veh") exitwith {["Error code #05","red"] call A3PL_Player_Notification;};

	//determine if upgrade is already installed
	_isInstalled = [_veh,_id] call A3PL_Garage_isInstalled;

	_failed = false;
	if(!_preview) then {
		if(_forceInstall isEqualTo 1) then {
			_upgradePrice = [_id,_typeOf,"price"] call A3PL_Config_GetGarageUpgrade;
			_required = [_id,_typeOf,"required"] call A3PL_Config_GetGarageUpgrade;
			_pCash = player getVariable ["Player_Cash",0];
			if (_pCash < _upgradePrice) exitwith {[format["You are missing $%1 to buy this upgrade",_upgradePrice-_pCash],"red"] call A3PL_Player_Notification;_failed=true;};
			{if (!([_x select 0,_x select 1] call A3PL_Inventory_Has)) exitwith {[format["You do not have the necessary equipment to make a %1",[_id,_typeOf,"title"] call A3PL_Config_GetGarageUpgrade],"red"] call A3PL_Player_Notification; _failed=true;};} foreach _required;
			if (_failed) exitwith {};
			player setVariable ["Player_Cash",(player getVariable ["Player_Cash",0]) - _upgradePrice,true];
			{[_x select 0,-(_x select 1)] call A3PL_Inventory_Add;} foreach _required;
			[format['You have installed a new improvement (%1)',[_id,_typeOf,"title"] call A3PL_Config_GetGarageUpgrade],"green"] call A3PL_Player_Notification;
		};
	};

	if !(_failed) then {
		switch (_upgradeType) do
		{
			case ("addon"):
			{
				if (_forceInstall == -1) exitwith
				{
					if (!_isInstalled) then { [_veh, nil, [_upgradeClass, 1]] call A3PL_Garage_InstallUpgrades; } else { [_veh, nil, [_upgradeClass, 0]] call A3PL_Garage_InstallUpgrades; }; //just writing it on one line since its not that complicated
				};
				if ((_veh animationSourcePhase _upgradeClass) != _forceInstall) then
				{
					[_veh, nil, [_upgradeClass, _forceInstall]] call A3PL_Garage_InstallUpgrades;
				};
				if (_forceInstall == 1) then
				{
					A3PL_Garage_tUpgrade = nil;
				} else
				{
					A3PL_Garage_tUpgrade = _id;
				};
			};
		};
	};
}] call Server_Setup_Compile;

//COMPILE BLOCK
["A3PL_Garage_InstallUpgrades",
{
	private ["_vehicle","_variant","_animations", "_bChangeMass"];
	_vehicle 	= param [0, objNull, [objNull]];
	_variant 	= param [1, false, ["STRING", false, 0, []]];
	_animations 	= param [2, false, [[], false, "STRING"]];
	_bChangeMass 	= param [3, false, [false, 0]];

	//if !(local _vehicle) exitWith {false};

	/*---------------------------------------------------------------------------
		Get parameters from the config & the vehicle & prepare the local variables
	---------------------------------------------------------------------------*/
	private ["_vehicleType", "_listToSkip", "_addMass","_isCampaign"];
	_vehicleType = typeOf _vehicle;
	_skipRandomization = ({(_vehicleType isEqualTo _x) || (_vehicleType isKindOf _x) || (format ["%1", _vehicle] isEqualTo _x)} count (getArray(missionConfigfile >> "disableRandomization")) > 0 || !(_vehicle getVariable ["BIS_enableRandomization", true]));

	if (_bChangeMass isEqualType 0) then {
		_addMass = _bChangeMass;
		_bChangeMass = true;
	} else {
		_addMass = 0;
	};

	if (getNumber(missionConfigfile >> "CfgVehicleTemplates" >> "disableMassChange") == 1) then {
		_bChangeMass = false;
	};

	_isCampaign = isClass(campaignConfigFile >> "CfgVehicleTemplates");

	/*---------------------------------------------------------------------------
		Texture source selection & Set the selected texture
	---------------------------------------------------------------------------*/
	if !(_variant isEqualTo false) then {
		private ["_texturesToApply","_textureList","_textureSources","_textureSource","_probabilities","_materialsToApply"];
		_texturesToApply = [];
		_materialsToApply = [];
		_textureList = getArray(configFile >> "CfgVehicles" >> _vehicleType >> "TextureList");

		if (_variant isEqualType []) then {
			_textureList = _variant;
			_variant = "";
		};

		if (_variant isEqualType true) Then {
			if (count _textureList > 0) Then {
				_variant = _textureList select 0;
			} else {
				_variant = "";
			};
		};

		// 1 Support for the old method from Pettka
		if (_variant isEqualType 0) then {
			_variant = if ((_variant >= 0) && ((_variant * 2) <= (count _textureList) -2)) then {_textureList select (_variant * 2)} else {""};
		};

		// 2 Try from the config file (parents only)
		if (_vehicleType in ([(configFile >> "CfgVehicles" >> _variant), true] call BIS_fnc_returnParents)) then {
			private ["_cfgRoot"];
			_textureList = getArray(configFile >> "CfgVehicles" >> _variant >> "TextureList");
			_textureSources = [];
			_probabilities = [];
			for "_i" from 0 to (count _textureList -1) step 2 do {
				_textureSources append [_textureList select _i];
				_probabilities append [_textureList select (_i +1)];
			};
			_cfgRoot = (configFile >> "CfgVehicles" >> _variant >> "textureSources" >> ([_textureSources, _probabilities] call bis_fnc_selectRandomWeighted));
			_texturesToApply = getArray(_cfgRoot >> "textures");
			_materialsToApply = getArray(_cfgRoot >> "materials");
		};

		// 3 Try from the textureSources of the current vehicle
		if (count _texturesToApply == 0 && {isClass (configfile >> "CfgVehicles" >> _vehicleType >> "textureSources" >> _variant)}) then {
			_texturesToApply = getArray(configfile >> "CfgVehicles" >> _vehicleType >> "textureSources" >> _variant >> "textures");
			_materialsToApply = getArray(configfile >> "CfgVehicles" >> _vehicleType >> "textureSources" >> _variant >> "materials");
		};

		// 4 Valid class from the campaign config file
		if (_isCampaign && {isClass (campaignConfigFile >> "CfgVehicleTemplates" >> _variant)}) then {
			if (count (getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _variant >> "textures")) >= 1) then {
				_texturesToApply = getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _variant >> "textures");
				_materialsToApply = getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _variant >> "materials");
			} else {
				_texturesToApply = [];
				_materialsToApply = [];
				_textureList = getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _variant >> "textureList")
			};
		};

		// 5 If _variant is a valid class from the mission config file, override textureList and empty texturesToApply
		if (isClass (missionConfigFile >> "CfgVehicleTemplates" >> _variant)) then {
			if (count (getArray(missionConfigFile >> "CfgVehicleTemplates" >> _variant >> "textures")) >= 1) then {
				_texturesToApply = getArray(missionConfigFile >> "CfgVehicleTemplates" >> _variant >> "textures");
				_materialsToApply = getArray(missionConfigFile >> "CfgVehicleTemplates" >> _variant >> "materials");
			} else {
				_texturesToApply = [];
				_materialsToApply = [];
				_textureList = getArray(missionConfigFile >> "CfgVehicleTemplates" >> _variant >> "textureList")
			};
		};

		// 4 Else, randomize using the texture list (from the config of the current vehicle)
		if (!(_skipRandomization) && {count _texturesToApply == 0 && {count _textureList >= 2}}) then {
			private ["_cfgRoot"];
			_textureSources = [];
			_probabilities = [];
			for "_i" from 0 to (count _textureList -1) step 2 do {
				_textureSources append [_textureList select _i];
				_probabilities append [_textureList select (_i +1)];
			};
			_cfgRoot = configFile >> "CfgVehicles" >> _vehicleType >> "textureSources" >> ([_textureSources, _probabilities] call bis_fnc_selectRandomWeighted);
			_texturesToApply = getArray(_cfgRoot >> "textures");
			_materialsToApply = getArray(_cfgRoot >> "materials");
		};

		// change the textures
		{_vehicle setObjectTextureGlobal [_forEachindex, _x];} forEach _texturesToApply;

		// change the materials when it is appropriate
		{if (_x != "") then {_vehicle setObjectMaterialGlobal [_forEachindex, _x];};} forEach _materialsToApply;
	};

	/*---------------------------------------------------------------------------
		Animation sources
	---------------------------------------------------------------------------*/
	if !(_animations isEqualTo false) then {
		private ["_animationList","_resetAnimationSources"];

		_animationList = getArray(configFile >> "CfgVehicles" >> _vehicleType >> "animationList");

		// Find if whether or not the reset of the animation sources should be reset
		_resetAnimationSources = if (_animations isEqualType [] && {count _animations > 0 && {(_animations select 0) isEqualType true}}) then
		{
			[_animations] call bis_fnc_arrayShift
		} else {
			true
		};

		if (_resetAnimationSources) then {
			// reset animations
			{
				if (_x isEqualType "") then {
					_vehicle animatesource [_x, getNumber(configFile >> "CfgVehicles" >> _vehicleType >> "animationSources" >> _x >> "initPhase"), true];
				};
			} forEach _animationList;
		};

		// Exit if _animations is true (nothing else to do)
		if (_animations isEqualTo true) exitWith {};

		if (!(_skipRandomization) && {(_animations isEqualType "" || _variant isEqualType "")}) then {
			// 6 - Variant parameter - If the variant is a string and animation is either, an empty string or array
			if ((_variant isEqualType "") && {isClass (configFile >> "CfgVehicles" >> _variant) && {_animations isEqualTo "" || _animations isEqualTo []}}) then {
				_animationList = getArray(configFile >> "CfgVehicles" >> _variant >> "animationList");
			};

			// 5 - Variant parameter - Campaign
			if (_isCampaign && {(_variant isEqualType "") && {(_animations isEqualTo "" || _animations isEqualTo []) && {isClass (campaignConfigFile >> "CfgVehicleTemplates" >> _variant)}}}) then
			{
				_animationList = getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _variant >> "animationList");
			};

			// 4 - Variant parameter - Try from the mission config (_variant)
			if ((_variant isEqualType "") && {isClass (missionConfigFile >> "CfgVehicleTemplates" >> _variant) && {_animations isEqualTo "" || _animations isEqualTo []}}) then {
				_animationList = getArray(missionConfigFile >> "CfgVehicleTemplates" >> _variant >> "animationList");
			};

			// 3 - animation parameter - Try from the config (_animations)
			if (_animations isEqualType "" && {isArray (configFile >> "CfgVehicles" >> _animations >> "animationList")}) then {
				_animationList = getArray(configFile >> "CfgVehicles" >> _animations >> "animationList");
			};

			// 2 - animation parameter - Campaign
			if (_isCampaign && {_animations isEqualType "" && {isArray (campaignConfigFile >> "CfgVehicleTemplates" >> _animations >> "animationList")}}) then {
				_animationList = getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _animations >> "animationList");
			};

			// 1 - animation parameter - Try from the mission config (template class name)
			if (_animations isEqualType "" && {isArray (missionConfigFile >> "CfgVehicleTemplates" >> _animations >> "animationList")}) then {
				_animationList = getArray(missionConfigFile >> "CfgVehicleTemplates" >> _animations >> "animationList");
			};
		};

		// 4 If (_animations is an array) then, use it
		if (_animations isEqualType [] && {count _animations > 1 && {count _animations mod 2 == 0 && {(_animations select 1) isEqualType 0}}}) then {
			_animationList = _animations;
		};

		// Change animation sources
		_vehicle setvariable ["bis_fnc_initVehicle_animations",_animationList];
		if (count _animationList > 1) then {
			private ["_CfgPath"];
			_CfgPath = (configfile >> "CfgVehicles" >> _vehicleType >> "AnimationSources");

			for "_i" from 0 to (count _animationList -1) step 2 do {
				private ["_source", "_lockCargoAnimationPhase", "_lockCargo", "_chance", "_rand", "_bLockCargo", "_bLockTurret", "_forceAnimatePhase", "_forceAnimate", "_phase", "_lockTurretAnimationPhase", "_lockTurret"];

				_source = _animationList select _i;
				_lockCargoAnimationPhase = getNumber(_CfgPath >> _source >> "lockCargoAnimationPhase");
				_lockCargo = getArray(_CfgPath >> _source >> "lockCargo");
				_forceAnimatePhase = getNumber(_CfgPath >> _source >> "forceAnimatePhase");
				_forceAnimate = getArray(_CfgPath >> _source >> "forceAnimate");
				_chance = _animationList select (_i+1);

				_phase = if ((random 1) <= _chance) then {1} else {0};

				_vehicle animatesource [_source, _phase, true];

				if (_forceAnimatePhase == _phase) then {
					for "_i" from 0 to (count _forceAnimate -1) step 2 do {

						_vehicle animatesource [(_forceAnimate select _i), (_forceAnimate select (_i +1)), true];
					};
				};

				_blockCargo = (_lockCargoAnimationPhase == _phase);
				{_vehicle lockCargo [_x, _blockCargo];} forEach _lockCargo;
				[_vehicle, _phase] call compile (getText(configfile >> "CfgVehicles" >> _vehicleType >> "AnimationSources" >> _source >> "onPhaseChanged"));
			};

			//Update in DB
			_upgrades = ["all",(typeOf _vehicle),""] call A3PL_Config_GetGarageUpgrade;
			_addons = [];
			{_addons pushBack ([_x select 0, _vehicle animationSourcePhase (_x select 0)]);} foreach _upgrades;
			[_vehicle,_addons] remoteExec ["Server_Garage_UpdateAddons",2];
		};
	};

	/*---------------------------------------------------------------------------
		Mass change
	---------------------------------------------------------------------------*/
	if (_bChangeMass) then {
		_bChangeMass = [_vehicle, _bChangeMass, _addMass] call bis_fnc_setVehicleMass;
	};

	/*---------------------------------------------------------------------------
		End of function
	---------------------------------------------------------------------------*/

	//true
}] call Server_Setup_Compile;