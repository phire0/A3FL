/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_JobMcfisher_CookBurger",
{
	private _burger = param [0,objNull];
	private _class = typeOf _burger;
	private _grill = attachedTo _burger;

	if (isNull _burger) exitwith {[localize"STR_A3PL_JobMcfisher_BurgerNullReport", "red"] call a3pl_player_notification;};
	if (isNull _grill) exitwith {[localize"STR_A3PL_JobMcfisher_GrillNullReport", "red"] call a3pl_player_notification;};
	if (typeOf _grill != "A3PL_Mcfisher_Grill") exitwith {[localize"STR_A3PL_JobMcfisher_ErrorGrill", "red"] call a3pl_player_notification;};
	if (isNil "_class") exitwith {[localize"STR_A3PL_JobMcfisher_BurgerNoClass", "red"] call a3pl_player_notification;};

	//first check if any cook variable already exist, or apply
	private _cookstate = _burger getVariable "cookstate";
	if (isNil "_cookstate") then {
		_burger setVariable ["cookstate",0,true];
	};
	[_burger,_grill,_class] spawn
	{
		private _burger = param [0,ObjNull];
		private _grill = param [1,ObjNull];
		private _class = param [2,""];
		private _amount = _burger getVariable ["amount",1];
		if (_class isEqualTo "") exitwith {};
		while {(attachedTo _burger) == _grill} do
		{
			private ["_cookstate","_newcookstate"];
			_cookstate = _burger getVariable "cookstate";
			_newcookstate = _cookstate + 10;
			_burger setVariable ["cookstate",_newcookstate,true];
			uiSleep 10;
			if (_newcookstate > 90) exitwith {};
			if (isNull _burger) exitwith {};
		};

		private _cookstate = _burger getVariable "cookstate";
		if (isNil "_cookstate") exitwith {};
		if (_cookstate > 90) then {
			if (_class IN ["A3PL_Burger_Raw","A3PL_Burger_Cooked","A3PL_Fish_Raw","A3PL_Fish_Cooked"]) then {
				[player,_burger,_amount] remoteExec ["Server_JobMcfisher_cookthres",2];
			};
			if (_class IN  ["A3PL_Burger_Burnt","A3PL_Fish_Burned"]) then {
				_burger setVariable ["cookstate",nil,true];
			};
		};
	};
}
] call Server_Setup_Compile;
