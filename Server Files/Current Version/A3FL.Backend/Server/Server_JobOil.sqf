["Server_JobOil_PumpStart", 
{
	private _player = param [0,objNull];
	private _pump = param [1,objNull];
	if ((isNull _player) OR (isNull _pump)) exitwith {};
	
	private _oil = [getpos _pump] call A3PL_JobWildcat_CheckForOil;
	private _containsOil = _oil select 0;
	private _oilLocation = _oil select 1;
	if (!_containsOil) exitwith {};	
	
	if ((_pump animationSourcePhase "drill") != 0) exitwith {[6] remoteExec ["A3PL_JobOil_PumpReceive", (owner _player)];};	
	if (_pump getVariable ["pumping",false]) exitwith {[7] remoteExec ["A3PL_JobOil_PumpReceive", (owner _player)];};
	_pump setVariable ["pumping",true,true];
	[_pump] remoteExec ["A3PL_JobOil_Pump_Animation", -2];
	while {(_pump getVariable ["pumping",false])} do
	{
		private _oilAmount = [_oilLocation] call A3PL_JobWildcat_CheckAmountOil;
		if (_oilAmount <= 0) exitwith {[1] remoteExec ["A3PL_JobOil_PumpReceive", (owner _player)];};
		
		private _pumpjacks = nearestObjects [_pump, ["A3PL_PumpJack"], 2];
		private _holes = nearestObjects [_pump, ["A3PL_DrillHole"], 3];
		if (count _holes < 1) exitwith {[2] remoteExec ["A3PL_JobOil_PumpReceive", (owner _player)];}; //no holes can be found
		private _hole = _holes select 0;
		if (count _pumpjacks > 1) exitwith {[3] remoteExec ["A3PL_JobOil_PumpReceive", (owner _player)];}; //More than one jackpump on this hole?
		if (((_pump modelToWorld (_pump selectionPosition "holePosition")) distance _hole) > 0.2) exitwith {[4] remoteExec ["A3PL_JobOil_PumpReceive", (owner _player)];}; //pump not positioned correctly	

		//Fill up the barrel with 0.5 gallons and broadcast variable, change 0.5 to change pump gallon per pump cycle
		//_oilBarrel setVariable ["crudeOil",(_oilBarrel getVariable ["crudeOil",0]) + 0.5,true];
		_pump setVariable ["crudeOil",(_pump getVariable ["crudeOil",0]) + 1,false]; //change to 0.5
		
		//Take off 42 gallons from the Oil Resource, and spawn oil barrel
		if ((_pump getVariable ["crudeOil",0]) >= 42) then {
			private _pos = (getpos _pump) findEmptyPosition [1,10,"A3PL_OilBarrel"];
			if (count _pos == 0) then {_pos = getpos _pump};	
			private _barrel = createVehicle ["A3PL_OilBarrel",(getpos _pump), [], 0, "None"];
			_barrel setVariable ["class","Crude_Oil",true];
			_barrel setVariable ["owner",(getPlayerUID _player),true];
			{
				if ([(_x select 0),_oilLocation] call Bis_Fnc_AreEqual) exitwith {
					_x set [1,(_x select 1) - 42];
					Server_JobWildCat_Oil set [_forEachIndex,_x];
					publicVariable "Server_JobWildCat_Oil";
				};
			} foreach Server_JobWildCat_Oil;
			_pump setVariable ["crudeOil",nil,false];
		};
		uiSleep 0.26;
	};
	_pump setVariable ["pumping",nil,false];
	_pump animateSource ["pump",0,true];
},true] call Server_Setup_Compile;