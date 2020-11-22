/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_JobOil_PumpStart",
{
	private _pump = param [0,objNull];

	if (!local _pump) exitwith {["Only the owner of the pump can start it", "red"] call A3PL_Player_Notification;};

	private _pumpjacks = _pump nearEntities [["A3PL_Pumpjack"],3];
	private _holes = nearestObjects [_pump, ["A3PL_DrillHole"],3];
	if (count _holes < 1) exitwith {["It doesn't look like there is a hole located nearby this pumpjack", "red"] call A3PL_Player_Notification;};
	if (count _pumpjacks > 1) exitwith {["It looks like a jack pump is already placed near this hole", "red"] call A3PL_Player_Notification;};
	private _hole = _holes select 0;
	if (((_pump modelToWorld (_pump selectionPosition "holePosition")) distance _hole) > 0.2) exitwith {["Please position the pump piece of the pumpjack closer to the hole", "red"] call A3PL_Player_Notification;};

	_oil = [getpos _hole] call A3PL_JobWildcat_CheckForOil;
	_containsOil = _oil select 0;
	_oilLocation = _oil select 1;
	if (!_containsOil) exitwith {["This area doesn't (or no longer) contains crude oil", "red"] call A3PL_Player_Notification;};

	_oilAmount = [_oilLocation] call A3PL_JobWildcat_CheckAmountOil;
	if (_oilAmount <= 0) exitwith {["This oil well is depleted, you need to find another well", "red"] call A3PL_Player_Notification;};

	if ((_pump animationSourcePhase "drill") != 0) exitwith {["It seems like this pump is already running", "red"] call A3PL_Player_Notification;};

	if(!(call A3PL_Player_AntiSpam)) exitWith {};
	[player,_pump] remoteExec ["Server_JobOil_PumpStart", 2];
}] call Server_Setup_Compile;

["A3PL_JobOil_Pump_Animation",
{
	private _pump = param [0,objNull];
	while {(_pump getVariable ["pumping",false])} do
	{
		if (_pump animationSourcePhase "pump" < 0.5) then {
			_pump animateSource ["pump",1];
			waitUntil {_pump animationSourcePhase "pump" >= 0.98};
		} else {
			_pump animateSource ["pump",0,true];
			waitUntil {_pump animationSourcePhase "pump" < 0.1};
		};
	};
}] call Server_Setup_Compile;