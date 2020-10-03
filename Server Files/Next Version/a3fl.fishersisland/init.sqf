enableSaving [false,false];
showChat false;

if(isDedicated) exitWith {
    [] spawn {
        waitUntil{uiSleep 0.05; (!isNil "A3PL_ServerLoaded")};
        waitUntil{uiSleep 0.05; A3PL_ServerLoaded};
        Ship_BlackMarket enableSimulationGlobal true;
        Ship_BlackMarket animate["Door_1",1,true]; 
        Ship_BlackMarket animate["Door_2",1,true];
        Ship_BlackMarket animate["Door_3",1,true];
        Ship_BlackMarket animate["Door_4",1,true];
        Ship_BlackMarket animate["Door_5",1,true];
        Ship_BlackMarket animate["Door_6",1,true];
        Ship_BlackMarket animate["Door_7",1,true];
        Ship_BlackMarket animate["Door_8",1,true];
        Ship_BlackMarket allowDamage false; 
        Ship_BlackMarket setFuel 0;
        sleep 60;
        Ship_BlackMarket enableSimulationGlobal false;
    };
};
waitUntil{!(isNull player)};

player enableSimulation false;
[] spawn {
	waitUntil{uiSleep 0.05; (!isNil "A3PL_ServerLoaded")};
	waitUntil{uiSleep 0.05; A3PL_ServerLoaded};

	Player_Loaded = false;

	waitUntil {uiSleep 0.05; ((vehicle player) isEqualTo player)};
	waitUntil {uiSleep 0.05; !isNil "A3PL_Player_Initialize"};

	call A3PL_Player_TeamspeakID;
	call A3PL_Player_Initialize;
};

/*[] spawn {
    _teamspeakName = "ArmA 3 Fishers Life - Official Teamspeak";
    _temspeakAdress = "ts3.arma3fisherslife.net";
    _channelName = "TaskForceRadio";

    if (isNil "TFAR_fnc_isTeamSpeakPluginEnabled") exitwith {
        999999 cutText ["TaskForceRadio is not enabled on your computer!","BLACK FADED"];
        999999 cutFadeOut 99999999;
    };

    _tfarEnabled = true;
    _playerOnTeamspeak = true;
    _playerInChannel = false;
    _sleep = 2;
    _alreadyKnow = false;

    while {true} do {
        if !(call TFAR_fnc_isTeamSpeakPluginEnabled) then {
            titleText ["TaskForceRadio teamspeak plugin is not activated!", "BLACK"];
            _tfarEnabled = false;
        } else {
            _tfarEnabled = true;
        };

        if !(_teamspeakName == (call TFAR_fnc_getTeamSpeakServerName)) then {
            titleText [format ["Join our teamspeak to play: %1",_temspeakAdress], "BLACK"];
            _playerOnTeamspeak = false;
        } else {
            _playerOnTeamspeak = true;
        };

        if !(_channelName == (call TFAR_fnc_getTeamSpeakChannelName)) then {
            titleText ["Reload your TaskForceRadio teamspeak plugin to be moved to the TaskForceRadio channel!", "BLACK"];
            _playerInChannel = false;
        } else {
            _playerInChannel = true;
        };

        if (_tfarEnabled && _playerOnTeamspeak && _playerInChannel) then {
            if !(_alreadyKnow) then {
                titleText ["TaskForceRadio initialized","BLACK IN"];
                _alreadyKnow = true;
            };
            _sleep = 5;
        } else {
            _alreadyKnow = false;
            _sleep = 2;
        };
       
        sleep _sleep;
    };
};*/