/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Business_Buy",
{
	diag_log "calling";
	private _player = param [0,objNull];
	private _playerUID = getPlayerUID _player;
	private _business = param [1,objNull];
	if ((isNull _player) OR (isNull _business)) exitwith {diag_log "exit";};
	private _name = param [2,""];
	private _rentTime = (param [3,1]) * 60;
	private _rentCost = param [4,1];
	private _sign = param [5,objNull];
	A3PL_Business_List = missionNameSpace getVariable ["A3PL_Business_List",[]];

	{
		if ((_x select 0) isEqualTo _business) exitwith {_taken = true};
		if ((_x select 1) isEqualTo _playerUID) exitwith {_taken = true};
	} foreach A3PL_Business_List;
	if (!isNil "_taken") exitwith {};

	_newMoney = (_player getVariable ["player_cash",0]) - _rentcost;
	if (_newMoney < 0) exitwith {};
	_player setvariable ["player_cash",_newMoney,true];

	private _marker = createMarker [format ["business%1",floor random 3000], _business];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "A3PL_Markers_Business";
	_marker setMarkerText _name;

	A3PL_Business_List pushback [_business,_playerUID,diag_tickTime + _rentTime,_marker];
	_business setVariable ["bOwner",_playerUID,true];
	_business setVariable ["bName",_name,true];

	if (!isNull _sign) then {
		_sign setObjectTextureGlobal [0,"\A3PL_Objects\Street\business_sign\business_rented_co.paa"];
	};

	if ((_player getVariable ["job","unemployed"]) != "business") then {[_player,"business"] call Server_NPC_RequestJob;};
	["Federal Reserve",_rentCost] remoteExec ["Server_Government_AddBalance",2];
	[getPlayerUID _player,"BusinessRented",["No info"]] remoteExec ["Server_Log_New",2];
},true] call Server_Setup_Compile;

["Server_Business_Loop",
{
	{
		private _business = _x select 0;
		private _uid = _x select 1;
		private _player = [_uid] call A3PL_Lib_UIDToObject;
		private _rentTime = _x select 2;
		if ((isNull _player) OR (diag_tickTime > _rentTime)) then {
			private _marker = _x select 3;
			deleteMarker _marker;
			_player setVariable ["job","unemployed",true];
			_business setVariable ["bOwner",nil,true];
			_business setVariable ["bName",nil,true];
			A3PL_Business_List deleteAt _forEachIndex;
		};
	} foreach (missionNameSpace getVariable ["A3PL_Business_List",[]]);
},true] call Server_Setup_Compile;

["Server_Business_Sellitem",
{
	private _player = param [0,objNull];
	private _obj = param [1,objNull];
	private _type = param [2,""];
	private _bChecked = param [3,false];
	private _name = param [4,""];
	private _price = param [5,0];
	if (isNull _player OR isNull _obj) exitwith {};
	_obj setVariable ["bItem",[_price,_name,_bChecked,getPlayerUID _player],true];
},true] call Server_Setup_Compile;

["Server_Business_Sellitemstop",
{
	private _obj = param [0,objNull];
	_obj setVariable ["bItem",nil,true];
},true] call Server_Setup_Compile;

["Server_Business_BuyItem",
{
	private _buyer = param [0,objNull];
	private _obj = param [1,objNull];
	private _factionBuy = param [2,false];
	private _buyerUID = getPlayerUID _buyer;
	private _bItem = _obj getVariable ["bItem",nil];
	if (isNil "_bItem") exitwith {};
	private _price = _bItem select 0;
	private _businessItem = _bItem select 2;
	private _owner = _bItem select 3;
	switch (true) do {
		case (_obj isKindOf "car"): {
			private _id = _obj getVariable ["owner",nil];
			private _isCustomPlate = _obj getVariable ["isCustomPlate",0];
			if (isNil "_id") exitwith {};
			private _id = _id select 1;
			if(_isCustomPlate isEqualTo 1) then {
				private _newID = [7] call Server_Housing_GenerateID;
				private _query = format ["UPDATE objects SET uid='%1' WHERE id='%2'",_buyerUID,_id];
				[_query,1] spawn Server_Database_Async;
				private _query2 = format ["UPDATE objects SET id = '%2',numpchange='0',iscustomplate='0' WHERE id = '%1'",_id,_newID];
				[_query2,1] spawn Server_Database_Async;
				_obj setVariable ["owner",[_buyerUID,_newID],true];
				[_newID,_obj] call Server_Vehicle_Init_SetLicensePlate;
			} else {
				private _query = format ["UPDATE objects SET uid='%1' WHERE id='%2'",_buyerUID,_id];
				_obj setVariable ["owner",[_buyerUID,_id],true];
				[_query,1] spawn Server_Database_Async;
			};
			[_obj] remoteExec ["A3PL_Vehicle_AddKey",_buyer];
			[_obj,false] remoteExec ["A3PL_Vehicle_AddKey",_owner];
		};
		case (_obj isKindOf "tank"): {
			private _id = _obj getVariable ["owner",nil];
			if (isNil "_id") exitwith {};
			private _isCustomPlate = _obj getVariable ["isCustomPlate",0];
			private _id = _id select 1;
			if(_isCustomPlate isEqualTo 1) then {
				private _newID = [7] call Server_Housing_GenerateID;
				private _query = format ["UPDATE objects SET uid='%1' WHERE id='%2'",_buyerUID,_id];
				[_query,1] spawn Server_Database_Async;
				private _query2 = format ["UPDATE objects SET id = '%2',numpchange='0',iscustomplate='0' WHERE id = '%1'",_id,_newID];
				[_query2,1] spawn Server_Database_Async;
				_obj setVariable ["owner",[_buyerUID,_newID],true];
				[_newID,_obj] call Server_Vehicle_Init_SetLicensePlate;
			} else {
				_query = format ["UPDATE objects SET uid='%1' WHERE id='%2'",_buyerUID,_id];
				_obj setVariable ["owner",[_buyerUID,_id],true];
				[_query,1] spawn Server_Database_Async;
			};
			[_obj] remoteExec ["A3PL_Vehicle_AddKey",_buyer];
			[_obj,false] remoteExec ["A3PL_Vehicle_AddKey",_owner];
		};
		case (_obj isKindOf "ship"): {
			private _id = _obj getVariable ["owner",nil];
			if (isNil "_id") exitwith {};
			private _isCustomPlate = _obj getVariable ["isCustomPlate",0];
			private _id = _id select 1;
			if(_isCustomPlate isEqualTo 1) then {
				private _newID = [7] call Server_Housing_GenerateID;
				private _query = format ["UPDATE objects SET uid='%1' WHERE id='%2'",_buyerUID,_id];
				[_query,1] spawn Server_Database_Async;
				private _query2 = format ["UPDATE objects SET id = '%2',numpchange='0',iscustomplate='0' WHERE id = '%1'",_id,_newID];
				[_query2,1] spawn Server_Database_Async;
				_obj setVariable ["owner",[_buyerUID,_newID],true];
				[_newID,_obj] call Server_Vehicle_Init_SetLicensePlate;
			} else {
				private _query = format ["UPDATE objects SET uid='%1' WHERE id='%2'",_buyerUID,_id];
				_obj setVariable ["owner",[_buyerUID,_id],true];
				[_query,1] spawn Server_Database_Async;
			};
			[_obj] remoteExec ["A3PL_Vehicle_AddKey",_buyer];
			[_obj,false] remoteExec ["A3PL_Vehicle_AddKey",_owner];
		};
		case (_obj isKindOf "Thing"): {
			_obj setVariable ["owner",_buyerUID,true];
		};
		case (!isNil {_obj getVariable ["class",nil]}): {
			_obj setVariable ["owner",[_id,_buyerUID],true];
		};
		default {
			_obj setVariable ["owner",_buyerUID,true];
		};
	};
	[_obj] call Server_Business_Sellitemstop;

	if (_factionBuy) then {
		private _balance = [_buyer,true] call A3PL_Government_MyFactionBalance;
		[_balance,-_price] call Server_Government_AddBalance;
	} else {
		private _cash = _buyer getVariable ["player_cash",0];
		_buyer setVariable ["player_cash",(_cash - _price),true];
	};
	if (!isNil "_owner") then {
		private _ownerObj = [_owner] call A3PL_Lib_UIDToObject;
		if (!isNull _ownerObj) then {
			_ownerObj setVariable ["player_cash",((_ownerObj getVariable ["player_cash",0]) + _price),true]; //also add money to seller
			[0,_price] remoteExec ["A3PL_Business_BuyItemReceive",(owner _ownerObj)];
		};
	};
	[1] remoteExec ["A3PL_Business_BuyItemReceive",(owner _buyer)];
	[getPlayerUID _buyer,"BusinessBought",[typeOf(_obj),str(_price)]] remoteExec ["Server_Log_New",2];
	[getPlayerUID _owner,"BusinessSold",[typeOf(_obj),str(_price)]] remoteExec ["Server_Log_New",2];
},true] call Server_Setup_Compile;

["Server_Business_CheckRentTime", {
	private _businessObj = param [0, objNull];
	private _player = param [1,objNull];
	private _businessList = missionNameSpace getVariable ["A3PL_Business_List",[]];
	{
		[str (_x select 0),"blue"] remoteExec ["A3PL_Player_Notification",_player];
		[str _businessObj,"blue"] remoteExec ["A3PL_Player_Notification",_player];
		if((str _x select 0) isEqualTo (str _buisinessObj)) then {["found","green"] remoteExec ["A3PL_Player_Notification",_player]; _businessToCheck = _x;};
	} foreach _businessList;
	private _rentTime = ((_businessList select _businessToCheck) select 2);
	private _remainingTime = diag_tickTime - _rentTime;
	[format["There is %1 minutes remaining on this businesses rental time",str _remainingTime],"blue"] remoteExec ["A3PL_Player_Notification",_player];
},true] call Server_Setup_Compile;
