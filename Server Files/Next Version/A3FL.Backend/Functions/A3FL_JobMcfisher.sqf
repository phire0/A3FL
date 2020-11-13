/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_JobMcfisher_CombineBurger",
{
	private ["_intersect","_classIntersect","_burgers"];
	_intersect = param [0,ObjNull];
	_creating = param [1,"burger"];
	_classIntersect = _intersect getVariable "class";

	if(!(call A3PL_Player_AntiSpam)) exitWith {}; //anti spam
	if (isNull _intersect) exitwith {[localize"STR_A3PL_JobMcfisher_ErrorSystemNull", "red"] call a3pl_player_notification;};
	if (isNil "_classIntersect") exitwith {[localize"STR_A3PL_JobMcfisher_ErrorSystemClass", "red"] call a3pl_player_notification;};
	if (!(_classIntersect IN ["burger_bun","burger_cooked","burger_raw","burger_burnt","tacoshell"])) exitwith {[localize"STR_A3PL_JobMcfisher_ErrorCombine", "red"] call a3pl_player_notification;};
	if (!isNull player_item) exitwith {[localize"STR_A3PL_JobMcfisher_YouCarrySomething", "red"] call a3pl_player_notification;};

	//if creating burger
	if (_creating == "taco") exitwith
	{
		_burgers = nearestObjects [_intersect, ["A3PL_Fish_Raw","A3PL_Fish_Cooked","A3PL_Fish_Burned"], 1];
		if (!isNull player_item) then {_burgers = _burgers - [player_item];};
		if (count _burgers == 0) exitwith {[localize"STR_A3PL_JobMcfisher_NoFish", "red"] call a3pl_player_notification;};

		_salads = nearestObjects [_intersect, ["A3PL_Salad"], 1];
		if (!isNull player_item) then {_salads = _salads - [player_item];};
		if (count _salads == 0) exitwith {[localize"STR_A3PL_JobMcfisher_NoSalad", "red"] call a3pl_player_notification;};

		[player,_intersect] remoteExec ["Server_JobMcfisher_combine",2];
	};

	//we are doing this seperate, dont know why buy maybe it'll be useful if we ever need to do this client-side
	if (_classIntersect == "burger_bun") exitwith //it's a bread piece that we are interacting with
	{
			_burgers = nearestObjects [_intersect, ["A3PL_Burger_Raw","A3PL_Burger_Cooked","A3PL_Burger_Burnt"], 1];
			if (!isNull player_item) then {_burgers = _burgers - [player_item];};
			if (count _burgers == 0) exitwith {[localize"STR_A3PL_JobMcfisher_NothingNear", "red"] call a3pl_player_notification;};

			_salads = nearestObjects [_intersect, ["A3PL_Salad"], 1];
			if (!isNull player_item) then {_salads = _salads - [player_item];};
			if (count _salads == 0) exitwith {[localize"STR_A3PL_JobMcfisher_NoSalad1", "red"] call a3pl_player_notification;};

			//send request to server to combine
			[player,_intersect] remoteExec ["Server_JobMcfisher_combine",2];

	};

	_burgers = nearestObjects [_intersect, ["A3PL_Burger_Bun"], 1];
	if (!isNull player_item) then {_burgers = _burgers - [player_item];};
	if (count _burgers == 0) exitwith {[localize"STR_A3PL_JobMcfisher_NothingNear1", "red"] call a3pl_player_notification;};
	[player,_intersect] remoteExec ["Server_JobMcfisher_combine",2];

}] call Server_Setup_Compile;

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
