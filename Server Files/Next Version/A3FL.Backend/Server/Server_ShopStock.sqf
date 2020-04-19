["Server_ShopStock_Load",
{
	private _stocks = ["SELECT object,stock FROM shops ORDER BY id ASC", 2, true] call Server_Database_Async;
	{
		private _object = call compile (_x select 0);
		private _stock = call compile (_x select 1);
		_object setVariable ["stock",_stock,true];
	} foreach _stocks;
},true] call Server_Setup_Compile;

["Server_ShopStock_Save",
{
	{
		private _query = format ["UPDATE shops SET stock = '%1' WHERE object = '%2'",(_x getVariable ["stock",[]]),_x];
		[_query,1] spawn Server_Database_Async;
		sleep 2;
	} foreach Config_Shops_StockSystemObjects;
},true] call Server_Setup_Compile;