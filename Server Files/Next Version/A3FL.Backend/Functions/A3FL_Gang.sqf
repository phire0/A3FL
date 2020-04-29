/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define MINCOPSREQUIRED 3

["A3PL_Gang_SetData",
{
	A3PL_Gang_Data = (_this select 0);
	[] call A3PL_Gang_Init;
}] call Server_Setup_Compile;

["A3PL_Gang_Init",
{
	private["_group"];
	if (count A3PL_Gang_Data isEqualTo 0) exitWith {};
	{
		_groupData = _x getVariable ["gang_data",nil];
		if (!isNil "_groupData") then {
			_groupID = _x getVariable ["gang_id",nil];
			if (isNil "_groupID") exitWith {};
			if ((A3PL_Gang_Data select 0) isEqualTo _groupID) exitWith {
				_group = _x;
			};
		};
	} forEach allGroups;

	if (!isNil "_group") then {
		[player] joinSilent _group;
		if ((A3PL_Gang_Data select 1) isEqualTo getPlayerUID player) then {
			_group selectLeader player;
		};
	} else {
		_group = group player;
		_group setVariable ["gang_data",A3PL_Gang_Data,true];
	};
}] call Server_Setup_Compile;

["A3PL_Gang_Create",
{
	private["_groupName"];
	_groupName = param [0,""];
	[player, _groupName] remoteExec ["Server_Gang_Create",2];
}] call Server_Setup_Compile;

["A3PL_Gang_Invite",
{
	private["_invited","_invitedName","_group"];
	_invited = param [0,""];

	_group = group player;
	_gang = _group getVariable ["gang_data",nil];

	if(isNil '_gang') exitWith {};
	_members = _gang select 3;
	_maxMembers = _gang select 5;
	if((count _members) > _maxMembers) exitWith {[format [localize"STR_NewGang_4",_maxMembers],"red"] call A3PL_Player_Notification;};
	{
		if(_invited isEqualTo (getPlayerUID _x)) exitWith {
			_hasGang = (group _x) getVariable["gang_data",nil];
			if(isNil '_hasGang') then {
				[_group, player] remoteExec ["A3PL_Gang_InviteReceived",_x];
				[localize"STR_NewGang_25","green"] call A3PL_Player_Notification;
			} else {
				[localize"STR_NewGang_1","red"] call A3PL_Player_Notification;
			};
		};
	} forEach AllPlayers;
}] call Server_Setup_Compile;

["A3PL_Gang_InviteReceived",
{
	private["_group"];
	_group = param [0,grpNull];
	_sender = param [1,objNull];
	_gang = _group getVariable ["gang_data",nil];

	if(isNil '_gang') exitWith {};
	_groupName = _gang select 2;

	/* Confirmation button */
	_exit = false;
	_action = [format["You have been invited to join the group %1. <br/> Would you like to join him?",_groupName],"Gang Invitation","Yes","No"] call BIS_fnc_guiMessage;
	if (!isNil "_action" && {!_action}) exitWith {_exit = true;};
	if(_exit) exitWith{[format["STR_NewGang_2",player getVariable["name",""]], "red"] remoteExec ["A3PL_Player_Notification",_sender];};

	//Join group
	[player] joinSilent _group;
	[getPlayerUID player, _group] call A3PL_Gang_AddMember;
	[format[localize"STR_NewGang_3",player getVariable["name",""]], "green"] remoteExec ["A3PL_Player_Notification",_sender];
}] call Server_Setup_Compile;

["A3PL_Gang_Created",
{
	private["_group","_gang","_groupName"];
	_group = group player;
	_gang = _group getVariable ["gang_data",nil];

	if(isNil '_gang') exitWith {};
	_groupName = _gang select 2;
	[format [localize"STR_NewGang_24",_groupName],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Gang_AddMember",
{
	private["_group","_gang","_addUID","_members","_maxMembers"];
	_addUID = param [0,""];
	_group = param [1,grpNull];
	_gang = _group getVariable ["gang_data",nil];

	if(isNil '_gang') exitWith {};
	_members = _gang select 3;
	_members pushBack(_addUID);
	_gang set[3,_members];
	_group setVariable ["gang_data",_gang,true];
	[_group] remoteExec ["Server_Gang_SaveMembers",2];
}] call Server_Setup_Compile;

["A3PL_Gang_RemoveMember",
{
	private["_group","_gang","_removeUID","_members"];
	_removeUID = param [0,""];
	_kicked = param [1,false];

	_group = group player;
	_gang = _group getVariable ["gang_data",nil];

	if(isNil '_gang') exitWith {};
	_members = _gang select 3;
	_members = _members - [_removeUID];
	_gang set[3,_members];
	_group setVariable ["gang_data",_gang,true];
	[_group] remoteExec ["Server_Gang_SaveMembers",2];

	if(_kicked) then {
		{
			if((getPlayerUID _x) isEqualTo _removeUID) exitWith {
				[] remoteExec ["A3PL_Gang_Kicked",_x];
			};
		} forEach AllPlayers;
	};
}] call Server_Setup_Compile;

["A3PL_Gang_Kicked",
{
	A3PL_Gang_Data = objNull;
    [player] joinSilent (createGroup civilian);
    [format [localize"STR_NewGang_5"],"red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Gang_Leave",
{
	_group = group player;
	_gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};

	//Check if leader
	if(((getPlayerUID player) == (_gang select 1))) exitWith {
		[format [localize"STR_NewGang_6"],"red"] call A3PL_Player_Notification;
	};

	[getPlayerUID player] call A3PL_Gang_RemoveMember;
	[player] joinSilent (createGroup civilian);
	A3PL_Gang_Data = nil;

	[localize"STR_NewGang_7","green"] call A3PL_Player_Notification;
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_Gang_Delete",
{
	private["_group","_gang"];
	_group = group player;
	_gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};

	if(((getPlayerUID player) != (_gang select 1))) exitWith {
		[format [localize"STR_NewGang_8"],"red"] call A3PL_Player_Notification;
	};

	[_group] remoteExec ["Server_Gang_DeleteGang",2];
}] call Server_Setup_Compile;

["A3PL_Gang_SetLead",
{
	private["_group","_gang"];
	_newUID = param [0,""];
	_group = group player;
	_gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};

	//Check if leader
	if((getPlayerUID player != _gang select 1)) exitWith {
		[format [localize"STR_NewGang_13"],"red"] call A3PL_Player_Notification;
	};

	if((getPlayerUID player == _newUID)) exitWith {
		[format [localize"STR_NewGang_14"],"red"] call A3PL_Player_Notification;
	};

	_gang set[1,_newUID];
	_group setVariable["gang_data",_gang,true];

	[_group] remoteExec ["Server_Gang_SetLead",2];
	[format [localize"STR_NewGang_15"],"red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Gang_AddBank",
{
	private["_group","_amount","_gang"];
	_group = param [0,grpNull];
	_amount = param [1,0];

	_gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};

	_currentBank = _gang select 4;

	_gang set[4,_currentBank + (_amount)];
	_group setVariable["gang_data",_gang,true];
	[_group] remoteExec ["Server_Gang_SaveBank",2];
}] call Server_Setup_Compile;

["A3PL_Gang_Capture",
{
	private ["_gangName","_obj","_cops","_win"];
	_obj = param [0,objNull];
	_win = 10000;
	_group = group player;

	if((player getVariable ["job","unemployed"]) IN ["fifr","uscg","fisd","doj","dmv"]) exitWith {};
	if ((currentWeapon player) == "") exitwith {["You do not brandish any weapon","red"] call A3PL_Player_Notification;};
	if ((currentWeapon player) IN ["A3PL_FireAxe","A3PL_Shovel","A3PL_Pickaxe","A3PL_Golf_Club","A3PL_Jaws","A3PL_High_Pressure","A3PL_Medium_Pressure","A3PL_Low_Pressure","A3PL_Taser","A3PL_FireExtinguisher","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","A3PL_Predator"]) exitwith {[localize"STR_NewGang_23","red"] call A3PL_Player_Notification;};

	_capturedTime = _obj getVariable["CapturedTime",serverTime-1800];
	if(_capturedTime > (serverTime-1800)) exitWith {[localize"STR_NewGang_26","red"] call A3PL_Player_Notification;};

	_gang = _group getVariable["gang_data",nil];
	if(isNil '_gang') exitWith {[localize"STR_NewGang_16","red"] call A3PL_Player_Notification;};
	_gangID = _gang select 0;
	if((_obj getVariable["captured",-1]) isEqualTo _gangID) exitWith {[localize"STR_NewGang_17","red"] call A3PL_Player_Notification;};

	if (Player_ActionDoing) exitwith {[localize"STR_NewGang_20","red"] call A3PL_Player_Notification;};
	Player_ActionCompleted = false;
	["Capture...",75] spawn A3PL_Lib_LoadAction;
	waitUntil{Player_ActionDoing};
	_success = true;
	_animTime = diag_tickTime;
	while {Player_ActionDoing} do {
		if(_animTime >= diag_tickTime-5) then {
			player playMoveNow 'AinvPknlMstpSnonWnonDnon_medic_1';
			_animTime = diag_tickTime;
		};
		if (Player_ActionInterrupted) exitWith {_success = false;};
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if (!(vehicle player == player)) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
	};
	if(Player_ActionInterrupted || !_success) exitWith {[localize"STR_NewGang_21","red"] call A3PL_Player_Notification;};

	_obj setVariable["captured",_gangID,true];
	_obj setVariable["CapturedTime",serverTime,true];

	_gangName = _gang select 2;
	[format[localize "STR_GANG_CAPTURED",_gangName], "yellow"] remoteExec ["A3PL_Player_Notification",-2];

	[localize"STR_NewGang_22","green"] call A3PL_Player_Notification;
	[_group,_win] call A3PL_Gang_AddBank;
}] call Server_Setup_Compile;

["A3PL_Gang_CapturedPaycheck",
{
	private["_objects","_win","_group","_gang","_gangID"];
	_objects = [hideout_obj_1,hideout_obj_2,hideout_obj_3];
	_win = 0;
	_group = group player;

	_gang = _group getVariable["gang_data",nil];
	if(isNil '_gang') exitWith {};
	_gangID = _gang select 0;

	{
		if((_x getVariable["captured",-1]) isEqualTo _gangID) then {_win = _win + 1000;};
	} forEach _objects;

	if(_win isEqualTo 0) exitWith {};

	[format[localize"STR_NewGang_27",_win],"green"] call A3PL_Player_Notification;
	[_group,_win] call A3PL_Gang_AddBank;
}] call Server_Setup_Compile;
