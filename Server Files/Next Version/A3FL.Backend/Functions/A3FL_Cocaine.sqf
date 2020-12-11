/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Cocaine_AddItem",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _barrel = param [0,objNull];
	if((player getVariable ["Cuffed",true]) || (player getVariable ["Zipped",true]) || ((animationState player) == "a3pl_takenhostage")) exitwith {[localize"STR_EVENTHANDLERS_RESTRAINACTION","red"] call A3PL_Player_Notification;};
	if (_barrel getVariable ["running",false]) exitwith {["You can't add to a barrel with a process already started!","red"] call A3PL_Player_Notification;};

	private _item = Player_ItemClass;
	[Player_ItemClass,-1] call A3PL_Inventory_Add;
	[false] call A3PL_Inventory_PutBack;
	if(_item isEqualTo "kerosene_jerrycan") then {
		_jerrycan = Player_Item;
		detach _jerrycan;
		private _attachpoint = _barrel selectionPosition "item_pickup";
		_attachpoint set [0,(_attachPoint select 0) - 0.3];
		_attachpoint set [0,(_attachPoint select 1) + 1];
		_attachpoint set [2,(_attachPoint select 2) + 0.2];
		_jerrycan attachTo [_barrel,_attachPoint];
		_jerrycan setVectorDirAndUp [[0,1,0],[1,0,0]];
		playSound3D ["A3PL_Common\effects\gasoline.ogg", _barrel, false, getPos _barrel, 1.36, 1.1, 0];
		uiSleep 4.5;
		_jerrycan setVectorDirAndUp [[0,1,0],[0,0,1]];
		uiSleep 1;
		deleteVehicle _jerrycan;
		[player,"jerrycan_empty",1] remoteExec ["Server_Inventory_Add",2];
	};
	_items = [(_barrel getVariable ["items",[]]), _item, 1] call BIS_fnc_addToPairs;
	_items sort true;
	_barrel setVariable ["items",_items,true];

	[format ["You added %1 to the barrel",[_item,"name"] call A3PL_Config_GetItem],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Cocaine_CheckContents",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _barrel = param [0,objNull];
	private _items = _barrel getVariable ["items",[]];
	private _itemNames = [];
	private _itemNameString = "";
	private _compileList = [];

	{
		_tmp = [(_x select 0),"name"] call A3PL_Config_GetItem;
		_itemNames pushBack [_x select 1,_tmp];
	} forEach _items;
	{
		_itemNameString = _x joinString " ";
		_compileList pushBack _itemNameString;
	} forEach _itemNames;

	_fullStringList = _compileList joinString ", ";
	if(_itemNames isEqualTo []) then {
		_fullStringList = "nothing";
	};

	[format ["There is %1 inside this barrel",_fullStringList],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Cocaine_Reset",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _barrel = param [0,objNull];
	_barrel setVariable ["items",[],true];
	["You removed all of the items from this barrel, they were ruined in the process!","red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Cocaine_Collect",
{
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	private _barrel = param [0,objNull];
	if (_barrel getVariable ["running",false]) exitwith {["You can't add to a barrel with a process already started!","red"] call A3PL_Player_Notification;};
	private _collection = _barrel getVariable ["items",[]];
	{
		[_x select 0, _x select 1] call A3PL_Inventory_Add;
		[format ["You collected %1 %2 from this barrel",_x select 1,[_x select 0,"name"] call A3PL_Config_GetItem],"green"] call A3PL_Player_Notification;
	} forEach _collection;
	_barrel setVariable["items",[],true];
}] call Server_Setup_Compile;

["A3PL_Cocaine_Produce",
{
  if(!(call A3PL_Player_AntiSpam)) exitWith {};
  private ["_barrel"];
  _barrel = param [0,objNull];
  _stage = param [1,1];

  if (_barrel getVariable ["running",false]) exitwith {["The process has already began!","red"] call A3PL_Player_Notification;};
  _playerLevel = player getVariable["Player_Level",0];
	if ((_playerLevel) < 6) exitWith {
		["You will unlock this resource at level 12","red"] call A3PL_Player_Notification;
	};

  _barrel setVariable ["running",true,true];
  ["You have started the process","green"] call A3PL_Player_Notification;

  _sound = createSoundSource ["A3PL_Boiling", (getpos _barrel), [], 0];
  _posSound = getPos _barrel;

  _timeLeft = 30 + round random 10;
  _barrel setVariable ["timeleft",_timeLeft,true];
  _succes = false;
  while {(_timeLeft > 0) && (_barrel getVariable ["running",false])} do
  {
    if (!([_posSound,(getpos _barrel)] call BIS_fnc_areEqual)) then
    {
      _sound setPos (getpos _barrel);
      _posSound = getpos _barrel;
    };


    _timeLeft = _timeLeft - 1;
    _barrel setVariable ["timeleft",_timeLeft,true];
    if (_timeLeft < 1) exitwith {_succes = true; true;};
    uiSleep 1;
  };
  _barrel setVariable ["running",false,true];
  deleteVehicle _sound;

  if (_succes) then
  {
    ["One of your cocaine processes has completed","green"] call A3PL_Player_Notification;
    [player,10] call A3PL_Level_AddXP;
  } else
  {
    ["One of your  cocaine processes has failed!","red"] call A3PL_Player_Notification;
  };

  if(_stage isEqualTo 1) then {
		_inv = _barrel getVariable["items",[]];
		_inv deleteRange [0,5];
		_inv pushBack ["coca_paste",2 + round(random 3)];
    _barrel setVariable ["items",_inv,true];
  };
	if(_stage isEqualTo 2) then {
		_inv = _barrel getVariable["items",[]];
		_inv deleteRange [0,3];
		_inv pushBack ["cocaine_base",3 + round(random 4)];
		_barrel setVariable ["items",_inv,true];
	};
	if(_stage isEqualTo 3) then {
		_inv = _barrel getVariable["items",[]];
		_inv deleteRange [0,4];
		_inv pushBack ["cocaine_hydrochloride",3 + round(random 2)];
		_barrel setVariable ["items",_inv,true];
	};
}] call Server_Setup_Compile;

["A3PL_Cocaine_InBarrel", {
	private _item = param [0,""];
	private _barrel = param [1,cursorObject];
	private _found = false;
	private _items = _barrel getVariable["items",[]];
	{
		if(_item isEqualTo (_x select 0)) exitWith{_found = true};
	} forEach _items;
	if(_found) exitWith {true};
	false
}] call Server_Setup_Compile;

["A3PL_Cocaine_CreateBrick",{
	private _success = false;
	private _target = param [0,player_objIntersect];
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	if((player getVariable ["Cuffed",true]) || (player getVariable ["Zipped",true]) || ((animationState player) == "a3pl_takenhostage")) exitwith {[localize"STR_EVENTHANDLERS_RESTRAINACTION","red"] call A3PL_Player_Notification;};
	if(!(["cocaine_hydrochloride",5] call A3PL_Inventory_Has)) exitWith{["You need 5 Cocaine Hydrochloride to produce a Cocaine Brick!","red"] call A3PL_Player_Notification;};

	[player,"Acts_TerminalOpen"] remoteExec ["A3PL_Lib_SyncAnim",0];
	[_target] spawn
	{
		private _target = param [0,objNull];
		if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
		["Creating Cocaine Brick...",60] spawn A3PL_Lib_LoadAction;
		while { Player_ActionDoing } do {
			if ((player distance2D _target) > 5) exitWith {[localize"STR_CRIMINAL_NEEDTOBENEAR5M", "red"] call A3PL_Player_Notification; Player_ActionInterrupted = true;};
			if (!(vehicle player isEqualTo player)) exitwith {Player_ActionInterrupted = true;};
			if (player getVariable ["Incapacitated",false]) exitwith {Player_ActionInterrupted = true;};
			if (!(["cocaine_hydrochloride",5] call A3PL_Inventory_Has)) exitwith {Player_ActionInterrupted = true;};
			if (animationState player != "Acts_TerminalOpen") then {[player,"Acts_TerminalOpen"] remoteExec ["A3PL_Lib_SyncAnim",0];}
		};
		if ((vehicle player) isEqualTo player) then {player switchMove "";};
		if (Player_ActionInterrupted) exitWith {["Creation of the brick was cancelled!", "red"] call A3PL_Player_Notification;};

		[player,"cocaine_hydrochloride",-5] remoteExec ["Server_Inventory_Add",2];
		["You created a cocaine brick!", "green"] call A3PL_Player_Notification;
		_brick = createVehicle ["A3FL_DrugBag", getpos player, [], 0, "CAN_COLLIDE"];
		_brick setVariable ["class","cocaine_brick",true];
		_brick setVariable ["owner",getPlayerUID player,true];
	};
}] call Server_Setup_Compile;

["A3PL_Cocaine_BreakDownBrick",
{
	private _target = param [0,player_objIntersect];
	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	if((player getVariable ["Cuffed",true]) || (player getVariable ["Zipped",true]) || ((animationState player) == "a3pl_takenhostage")) exitwith {[localize"STR_EVENTHANDLERS_RESTRAINACTION","red"] call A3PL_Player_Notification;};
	private _near = nearestObjects [_target, ["A3FL_DrugBag"],2];
	if ((count _near) < 1) exitwith {["No cocaine bricks nearby, place them near the scale to break them down!","red"] call A3PL_Player_Notification;};
	if (_target getVariable["inUse",false]) exitWith {["This scale is already in use.","red"] call A3PL_Player_Notification;};
	[player,"Acts_TerminalOpen"] remoteExec ["A3PL_Lib_SyncAnim",0];
	[_target,_near] spawn
	{
		private _target = param [0,objNull];
		private _near = param [1,objNull];
		_target setVariable["inUse",true,true];
		if (Player_ActionDoing) exitwith {[localize"STR_NewHunting_Action","red"] call A3PL_Player_Notification;};
		["Breaking down Cocaine Brick...",60] spawn A3PL_Lib_LoadAction;
		while { Player_ActionDoing } do {
			if ((player distance2D _target) > 5) exitWith {["Someone moved the scale away!", "red"] call A3PL_Player_Notification; Player_ActionInterrupted = true;};
			if (!((vehicle player) isEqualTo player)) exitwith {Player_ActionInterrupted = true;};
			if (player getVariable ["Incapacitated",false]) exitwith {Player_ActionInterrupted = true;};
			if (animationState player != "Acts_TerminalOpen") then {[player,"Acts_TerminalOpen"] remoteExec ["A3PL_Lib_SyncAnim",0];}
		};
		_target setVariable["inUse",false,true];
		if ((vehicle player) isEqualTo player) then {player switchMove "";};
		if (Player_ActionInterrupted) exitWith {["Breaking down of the brick was cancelled!", "red"] call A3PL_Player_Notification;};

		private _bagCount = 4 + (round(random 2));
		[player,"cocaine",_bagCount] remoteExec ["Server_Inventory_Add",2];
		[format["You broke down this cocaine brick into %1 bags",_bagCount], "green"] call A3PL_Player_Notification;
		deleteVehicle (_near select 0);
	};
}] call Server_Setup_Compile;
