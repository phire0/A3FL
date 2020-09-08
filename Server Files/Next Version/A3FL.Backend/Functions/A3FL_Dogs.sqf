/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

#define DOGSMELLDISTANCE 10
#define ILLEGAL_ITEMS ["seed_marijuana","marijuana","cocaine","shrooms","cannabis_bud","cannabis_bud_cured","cannabis_grinded_5g","weed_5g","weed_10g","weed_15g","weed_20g","weed_25g","weed_30g","weed_35g","weed_40g","weed_45g","weed_50g","weed_55g","weed_60g","weed_65g","weed_70g","weed_75g","weed_80g","weed_85g","weed_90g","weed_95g","weed_100g","jug_moonshine","turtle","coca_paste","cocaine_base","cocaine_hydrochloride","acetone","calcium_carbonate","potassium_permangate","ammonium_hydroxide"]

["A3PL_Dogs_OpenMenu",
{
	if(!(isNull(player getVariable["Player_Dog",objNull]))) exitwith {["You already have a dog","red"] call A3PL_Player_Notification;};
	createDialog "Dialog_Kane9";
	private _control = _display displayCtrl 1500;
	private _dogs = [["Dog 1 (Sand)","Alsatian_Sand_F"],["Dog 2 (Black)","Alsatian_Black_F"],["Dog 3 (Sandblack)","Alsatian_Sandblack_F"]];
	{
		_i = _control lbAdd (_x select 0);
		_control lbSetData [_i,(_x select 1)];
	} foreach _dogs;
	_control lbSetCurSel 0;
}] call Server_Setup_Compile;

["A3PL_Dogs_BuyRequest",
{
	private _class = lbData [1500,(lbCurSel 1500)];
	[localize"STR_DOGS_DOGBUY","green"] call A3PL_Player_Notification;
	[player,_class] remoteExec ["Server_Dogs_BuyRequest",2];
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_Dogs_BuyReceive",
{
	private _class = param [0,"Alsatian_Sand_F"];
	private _dog = createAgent [_class, getPosATL player, [], 1, "CAN_COLLIDE"];
	_dog setposATL (getposATL player);
	_dog playMove "Dog_Sit";

	player setVariable["Player_Dog",_dog,false];
	_dog setVariable["Dog_Moving",false,true];
	_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
	[_dog] spawn {
		private _dog = param [0,objNull];
		private _doDrugsCheck = 0;
		private _moved = false;
		while {alive _dog} do
		{
			sleep 0.5;
			private _moving = _dog getVariable["Dog_Moving",false];
			if (vehicle player != player) then
			{
				if (!(attachedTo _dog == (vehicle player))) then
				{
					_attachPoint = [0,-0.2,-0.6];
					switch (typeOf (vehicle player)) do
					{
						case ("A3PL_Tahoe_FD"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_Tahoe_PD"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_Tahoe_PD_Slicktop"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_CVPI_PD"): {_attachPoint = [0,-0.3,-1.1]};
						case ("A3PL_CVPI_PD_Slicktop"): {_attachPoint = [0,-0.3,-1.1]};
						case ("A3PL_Mustang_PD"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_Mustang_PD_Slicktop"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_Charger_PD"): {_attachPoint = [0,0.2,-1.2]};
						case ("A3PL_Charger_PD_Slicktop"): {_attachPoint = [0,0.2,-1.2]};
						case ("A3PL_Silverado_PD"): {_attachPoint = [0,0.5,-0.7]};
						case ("A3PL_RBM"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_Jayhawk"): {_attachPoint = [0,0.2,-1.1]};
					};
					_dog attachto [vehicle player,_attachPoint];
					_dog playMoveNow "Dog_Sit";
				};
			} else {
				if(_moving) then {
					if (vehicle player == player) then {
						if (!isNull (attachedTo _dog)) then {detach _dog;};
					};
					if (((player distance _dog) > 5)) then {
						if((player distance _dog) > 20) then {
							_dog playMoveNow "Dog_Sprint";
						} else {
							_dog playMoveNow "Dog_Walk";
						};
						_moved = true;
						_dog moveTo (getpos player);
					} else {
						if(_moved) then {
							_dog playMoveNow "Dog_Stop";
							_moved = false;
						};
					};
				} else {
					if(_moved) then {
						_dog playMoveNow "Dog_Stop";
						_moved = false;
					};
				};

				_doDrugsCheck = _doDrugsCheck + 0.5;
				if (_doDrugsCheck >= 6) then
				{
					private ["_nearbyPlayers","_foundDrugs"];
					_doDrugsCheck = 0;
					_foundDrugs = false;

					_nearbyPlayers = [];
					{
						if ((_dog distance2D _x) < 5) then {_nearbyPlayers pushback _x;};
					} foreach allPlayers;
					{
						private ["_player"];
						_player = _x;
						{
							if ([_x,1,_player] call A3PL_Inventory_Has) exitwith {_foundDrugs = true;};
						} foreach ILLEGAL_ITEMS;
					} foreach _nearbyPlayers;

					_nearestVehicle = (nearestObjects [player,["Car"],10]) select 0;
					if(!(isNil "_nearestVehicle")) then {
						_storage = _nearestVehicle getVariable["storage",[]];
						{
							if(_x select 0 in ILLEGAL_ITEMS) exitwith {_foundDrugs = true;};
						} foreach _storage;
					};
					if ((count (nearestObjects [_dog,["A3PL_Cannabis_Bud","A3PL_MarijuanaBag","A3PL_PowderedMilk","A3PL_TacticalBacon","A3PL_Marijuana","A3PL_Seed_Marijuana","A3PL_Gunpowder","A3FL_DrugBag"], 10])) > 0) then {_foundDrugs = true; };
					if (_foundDrugs) then { playSound3D ["A3PL_Common\effects\dogbark.ogg", _dog, false, getPosASL _dog, 7, 1, 50]; };
				};
			};
		};
	};
	[localize"STR_DOGS_INFODOG","green"] call A3PL_Player_Notification;
	[_dog] remoteExec ["Server_Dogs_HandleLocality", 2];
	[player, 8] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;
