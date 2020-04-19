["Server_Dogs_BuyRequest",
{
	private _player = param [0,objNull];
	private _class = param [1,""];
	[_class] remoteExec ["A3PL_Dogs_BuyReceive",(owner _player)];
},true] call Server_Setup_Compile;

["Server_Dogs_HandleLocality",
{
	private _dog = param [0,objNull];
	if (isNull _dog) exitwith {};
	_dog addEventHandler ["Local", {
		private _dog = _this select 0;
		private _local = _this select 1;
		if (_local) then {deleteVehicle _dog};
	}];
},true] call Server_Setup_Compile;