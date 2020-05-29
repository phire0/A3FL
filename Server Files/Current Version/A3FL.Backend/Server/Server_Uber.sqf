/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

['Server_Uber_AddDriver',
{
    params[["_user",objNull,[objNull]]];
    if(!(_user in A3PL_Uber_Drivers)) then {
        A3PL_Uber_Drivers pushBack _user;
    };
    _user setVariable ["job","uber",true];
}, true] call Server_Setup_Compile;

['Server_Uber_FlushDrivers',
{
    {
        if (isNull _x) then {A3PL_Uber_Drivers deleteAt _forEachIndex;};
    } forEach A3PL_Uber_Drivers;
}, true] call Server_Setup_Compile;

['Server_Uber_RemoveDriver',
{
    params[["_user",objNull,[objNull]]];
    if(_user in A3PL_Uber_Drivers) then {
        private _id = A3PL_Uber_Drivers find _user;
        A3PL_Uber_Drivers deleteAt _id;
    };
    _user setVariable ["job","unemployed",true];
}, true] call Server_Setup_Compile;

['Server_Uber_RequestDriver',
{
    private ["_user"];
    params[["_user",objNull,[objNull]]];

    call Server_Uber_flushDrivers;
    if(count A3PL_Uber_Drivers < 1) then {
        [localize"STR_SERVER_UBER_NOUBERAVAILABLE", "red"] remoteExec ["A3PL_Player_Notification", _user];
    } else {
        [localize"STR_SERVER_UBER_UBEREQUEST", "green"] remoteExec ["A3PL_Player_Notification", _user];
        {
            [_user] remoteExec ["A3PL_Uber_RecieveRequest", _x];
        } forEach A3PL_Uber_Drivers;
    };
}, true] call Server_Setup_Compile;