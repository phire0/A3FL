/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['A3PL_Uber_AcceptRequest', {
    private ["_job","_marker"];

    closeDialog 0;
    A3PL_Uber_JobActive = true;
    A3PL_Uber_CurrentJobPlayer = A3PL_Uber_ActiveRequest;

    deleteMarkerLocal "uber";

    _marker = createMarkerLocal ["uber", A3PL_Uber_CurrentJobPlayer];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "mil_warning";
    _marker setMarkerTextLocal format ["Uber Requested!"];
    _marker setMarkerColorLocal "ColorRed";

    [localize"STR_UBER_Accept1","green"] call A3PL_Player_Notification;
    [localize"STR_UBER_Accept2","green"] call A3PL_Player_Notification;
    [localize"STR_UBER_Accept3", "green"] remoteExec ["A3PL_Player_Notification",A3PL_Uber_CurrentJobPlayer];
}, false] call Server_Setup_Compile;

['A3PL_Uber_AddDriver', {
    [player] remoteExec ["Server_Uber_addDriver", 2];
    [localize"STR_UBER_Work","green"] call A3PL_Player_Notification;
}, false] call Server_Setup_Compile;

['A3PL_Uber_EndJob', {
    A3PL_Uber_JobActive = false;
    deleteMarkerLocal "uber";
    A3PL_Uber_CurrentJobPlayer = nil;
    [localize"STR_UBER_WorkEnd","green"] call A3PL_Player_Notification;
}, false] call Server_Setup_Compile;

['A3PL_Uber_Open', {
    disableSerialization;
    createDialog "Dialog_Phone_UberMenu";

    if (player getVariable ["job","unemployed"] == "uber") then {
        ctrlSetText [1609, "Leave Job"];
        buttonSetAction [1609, "call A3PL_Uber_removeDriver"];
        if (A3PL_Uber_JobActive) then {
            ctrlSetText [1613, "End current drive"];
            buttonSetAction [1613, "call A3PL_Uber_EndJob;"];
        } else {
            ctrlSetText [1613, ""];
            ctrlEnable [1613, false];
        };
    } else {
        buttonSetAction [1613, "call A3PL_Uber_requestDriver;"];
        buttonSetAction [1609, "call A3PL_Uber_addDriver;"];
    };
}, false] call Server_Setup_Compile;

['A3PL_Uber_RecieveRequest', {
    if (A3PL_Uber_JobActive) exitWith {};
    params[["_customer",objNull,[objNull]]];

    A3PL_Uber_ActiveRequest = _customer;

    closeDialog 0;
    createDialog "Dialog_UberAccept";
}, false] call Server_Setup_Compile;

['A3PL_Uber_RemoveDriver', {
    if (!((player getVariable ["job","unemployed"]) isEqualTo "uber")) exitwith {
        [localize"STR_UBER_Uberno","red"] call A3PL_Player_Notification;
    };

    [player] remoteExec ["Server_Uber_removeDriver", 2];
    [localize"STR_UBER_WorkFinished","green"] call A3PL_Player_Notification;

    if (A3PL_Uber_JobActive) then {
        call A3PL_Uber_EndJob;
    };
}, false] call Server_Setup_Compile;

['A3PL_Uber_RequestDriver', {
    disableSerialization;

    [player] remoteExec ["Server_Uber_requestDriver",2];
    [localize"STR_UBER_Send","red"] call A3PL_Player_Notification;
}, false] call Server_Setup_Compile;
