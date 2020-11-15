/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

// Get road segment : diag_log str(ASLToAGL getPosASL player);
//hint str(player_objintersect getVariable["Building_Address","zizi"]);
["Server_Addresses_Setup",
{
	Server_Addresses_Cities = [
		[[2580.85,5514.1,0],800,"Silverton"],
		[[3540.16,6664.84,0],250,"Palm Beach"],
		[[3471.51,7537.87,0],700,"Stoney Creek"],
		[[4111.79,6306.76,0],250,"Beach Valley"],
		[[6088.25,7380.93,0],300,"Elk City"],
		[[7037.48,7175.65,0],300,"Boulder City"],
		[[9923.96,7906.19,0],300,"Deadwood"],
		[[8818.21,6435.89,0],250,"James Town"],
		[[8818.21,6435.89,0],300,"Springfield"],
		[[10224,8571.71,0],375,"Northdale"],
		[[2111.79,11966.5,0],700,"Lubbock"],
		[[3350.49,12305.5,0],450,"Salt Point"],
		[[4254.72,4162.6,0],300,"Coral Cove"],
		[[3781.04,4766.17,0],220,"Axel's Garden"],
		[[4607.94,4663.9,0],80,"Wick's Estate"],
		[[4622.33,4972.67,0],160,"Vanderzee Estate"],
		[[4415.05,5908.73,0],100,"T-Money Ranch"],
		[[5429.91,5451.57,0],100,"Paradise Falls"],
		[[6013.47,5541.18,0],375,"Swamp"],
		[[8953.12,7665.37,0],180,"Janitor's Peek"],
		[[11319.8,8741.16,0],60,"Mexican Hill"],
		[[5939.21,4951.24,0],100,"Tri-State"],
		[[6304.08,6483.44,0],120,"Greenie's Manor"],
		[[7578.25,6669.05,0],150,"Camorra Estate"],
		[[7931.35,6489.01,0],95,"Boyd Manor"]
	];
	private _Server_Roads_Data = [
		[[3835.88,6376.76,0],[11732,9261.72,0],"Main Service Road"],
		[[6250,7699.3,0],[6173.62,7769.09,0],"Sheriff HQ"],
		[[4704.92,5739.26,0],[4758.06,6021.17,0],"Department Of Corrections"],
		[[4471.26,6826.82,0],[4191.39,6780.1,0],"Steel Mill"],
		[[4215.91,4848.48,0],[3842.27,4767.45,0],"Axel Avenue"],
		[[4237.61,5259.22,0],[3627.38,5184.45,0],"Father Gaben Boulevard"],
		[[4315.62,5743.1,0],[4204.72,4438.77,0],"Gaben's Way"],
		[[3527.19,7533.99,0],[2762.96,5560.38,0],"Star Avenue"],
		[[5938.67,5008.91,0],[5938.72,4932.71,0],"Freeman Court"],
		[[6050.47,7524.44,0],[5929.36,7342.21,0],"Frost Avenue"],
		[[3507.16,7452.74,0],[3522.78,7603.98,0],"Winston Square"],
		[[3516.7,7604.31,0],[3436.22,7613.49,0],"Winston Square"],
		[[3427.54,7617.92,0],[3412.11,7469.36,0],"Winston Square"],
		[[3420.55,7464.87,0],[3500.44,7455.85,0],"Winston Square"],
		[[3850.93,6662.29,0],[3431.82,6661.25,0],"Boomer Boulevard"],
		[[3294.7,5743.52,0],[3284.93,5742.37,0],"CarCrash Road"],
		[[8617.38,7930.56,0],[8565.61,6242.87,0],"Casey Boulevard"],
		[[4064.11,6010.22,0],[3578.01,6168.27,0],"Fronkfurt Avenue"],
		[[6769.92,7162.73,0],[7231.74,7156.63,0],"Booker Street"],
		[[2342.9,5498.88,0],[2548.94,5390.52,0],"Fred Weeks Loop"],
		[[9603.15,8007.19,0],[10173,8203,0],"George Road"],
		[[5894.06,7251.83,0],[6830.36,7606.05,0],"Electric Avenue"],
		[[3834.72,7083.22,0],[4145.77,6394.88,0],"DeLaware Avenue"],
		[[6918.88,7013.3,0],[7228.06,7170.01,0],"Crimson Avenue"],
		[[6909.51,7785.59,0],[6772.37,7943.47,0],"Fullman Terrace"],
		[[4142.62,5951.45,0],[4153.49,6387.6,0],"Fitzcharles Valley"],
		[[6882.51,7060.49,0],[7231.85,7244.74,0],"Wick Boulevard"],
		[[4074.95,6387.56,0],[4146.27,6193.48,0],"Tosh Lane"],
		[[4145.94,6304.18,0],[4081.19,6303.43,0],"Axel Parkway West"],
		[[3371.66,5913.42,0],[3749.68,6018.35,0],"Redhawk Boulevard"],
		[[6835.6,7110.36,0],[7186.52,7291.03,0],"Sticks Avenue"],
		[[7095.33,7330.94,0],[6775.96,7174.03,0],"Jefferson Road"],
		[[9882.86,8136.03,0],[8839.3,8379.98,0],"Kings Landing"],
		[[11237,8623.21,0],[11331.9,8836.27,0],"Mexican Hill"],
		[[6808.74,7489.35,0],[6963.73,7044.08,0],"Happy Road"],
		[[6939.48,7245.84,0],[7081.21,7025.19,0],"Roach Avenue"],
		[[2886.64,5602.58,0],[3394.03,5969.57,0],"Craiggy Way"],
		[[6164.88,8104.43,0],[6553.42,7830.99,0],"Ragging Hill"],
		[[4160.47,7093.5,0],[4144.39,6794.14,0],"Greenie's Lettuce Road"],
		[[4131.46,5939.09,0],[4125.5,5706.75,0],"Green Street"],
		[[3160.9,5897,0],[3302.46,5798.5,0],"Fishers Grove"],
		[[3356.85,5982.43,0],[3402.81,6138.61,0],"Ocean View Way"],
		[[4233.78,7099.04,0],[4330.63,6952.7,0],"Conehead Lane"],
		[[7020.54,7285.83,0],[7161.52,7083.47,0],"Leightonville Boulevard"],
		[[7085.71,7317.5,0],[7217.04,7150.56,0],"Patel Boulevard"],
		[[4458.83,5716.66,0],[4454.17,5678.36,0],"Freeman Mansion"],
		[[6554.06,7677.49,0],[7221.19,7921.64,0],"Greene Mile"],
		[[7870.88,6064.1,0],[7678.99,6513.06,0],"Redd Road"],
		[[3530.85,6307.84,0],[3607.9,6201.12,0],"Mossy Lane"],
		[[5974.64,7413.1,0],[6148.27,7303.62,0],"Caroo Crescent"],
		[[6114.1,7484.97,0],[6043.09,7376.93,0],"Creston Enterprises Way"],
		[[7695.45,6551.77,0],[7495.6,6712.25,0],"Young Lane"],
		[[4068.94,7098.7,0],[4147.79,7174.47,0],"Jose Inc. View"],
		[[6391.05,8075.18,0],[6778.93,8126.47,0],"Shags Corner"],
		[[7753.28,8050.22,0],[7138.37,7987.71,0],"Eight field bend."],
		[[4362.02,5740.33,0],[4396.84,5948.89,0],"T Money Ranch"],
		[[9881.05,7861.71,0],[9972.99,7864.25,0],"Deadwood Original"],
		[[9977.16,7938.17,0],[9980.17,7865.86,0],"MC Main Street"],
		[[9678.07,7955.52,0],[9968.5,7945.09,0],"Deadwood Boulevard"],
		[[9869.75,7934.62,0],[9871.94,7888.83,0],"Deadmans Corner"],
		[[8667.38,7664.7,0],[8941.41,7664.38,0],"Beach Front Drive"],
		[[3114.83,5368.55,0],[3026.39,5207.3,0],"Industrial Drive"],
		[[4825.63,5275.62,0],[4716.83,5603.88,0],"Landlubber Drive"],
		[[6055.92,7272.77,0],[5902.71,7283.09,0],"Parker Way"],
		[[4825.18,5297.39,0],[4572.95,5463.59,0],"Porpoise Drive"],
		[[4742.87,5697.59,0],[4574.61,5475.42,0],"Porpoise Drive"],
		[[5693.54,6507.94,0],[5377.16,6660.18,0],"Spike Avenue"],
		[[5187.94,5771.07,0],[5671.62,6455.01,0],"Dayhart Lane"],

		[[2149.94,11419.4,0],[3123.29,12239.2,0],"Lubbock MSR"],
		[[2037.06,11458.2,0],[1839.72,11365.6,0],"Lubbock Airport"],
		[[1834.15,11365.6,0],[1678.93,11366,0],"Coast Guard Station #61"],
		[[2929.73,11197.2,0],[3024.06,11648,0],"Farmers Drive"],
		[[2456.04,11438.4,0],[2382.92,11258.8,0],"Macklin's Farm"],
		[[3130.56,12371.2,0],[2337.7,11292.9,0],"Macklin's Farm"],
		[[3073.03,12305.2,0],[3073.03,12305.2,0],"Salt Round"],
		[[3626.4,12653.5,0],[3323.96,12398.4,0],"Drills Way"],
		[[3188.99,12305,0],[3424.3,12304.9,0],"Palm Street"],
		[[3435.07,12304.4,0],[3435.01,12224.6,0],"Palm Street"],
		[[3317.17,12296.7,0],[3317.19,12393.1,0],"Palm Street"],
		[[3427.58,12219.4,0],[3236.02,12295.7,0],"South Edge"],
		[[2100.42,11522.5,0],[1925.38,11937.4,0],"Hamilton Avenue"],
		[[2089.75,11623.5,0],[2021.07,11818.5,0],"Meadow Street"],
		[[2031.83,11682.2,0],[2256.06,12137.1,0],"Spruce Avenue"],
		[[2309.46,12236.5,0],[2288.16,12256.7,0],"Sunset Round"],
		[[2147.12,12249,0],[2146.92,11690.2,0],"1st Street"],
		[[2123.07,11766.8,0],[1938.66,11944.8,0],"Oak Street"],
		[[2005.78,11956.2,0],[2005.52,12129.1,0],"5th Street"],
		[[2247.22,12019.3,0],[2014.12,12019.1,0],"West Drive"],
		[[2081.08,12011,0],[2080.74,11954.6,0],"Capitol's Way"],
		[[2206.58,11913.3,0],[2297.12,11913.2,0],"East Way"]
	];

	Server_Addresses_Roads = [];
	{
		private _a = _x select 0;
		private _b = _x select 1;
		private _name = _x select 2;
		private _roadObject = roadAt _a;
		if(!isNull _roadObject) then {
			private _aID = parseNumber ((str (_roadObject) splitString ":") select 0);
			private _roadObject = roadAt _b;
			if(!isNull _roadObject) then {
				private _bID = parseNumber ((str(_roadObject) splitString ":") select 0);
				Server_Addresses_Roads pushBack [_aID,_bID,_name];
			};
		};
	} forEach _Server_Roads_Data;
	publicVariable "Server_Addresses_Roads";

	private _buidlingsArray = ["Land_A3FL_DOC_Gate","Land_A3FL_Fishers_Jewelry","Land_A3PL_Motel","Land_A3PL_Showroom","Land_A3PL_Bank","Land_A3PL_Capital","Land_A3PL_Sheriffpd","Land_A3FL_SheriffPD","Land_Shop_DED_Shop_01_F","land_smallshop_ded_smallshop_01_f","land_market_ded_market_01_f","Land_Taco_DED_Taco_01_F","Land_A3PL_Gas_Station","Land_A3PL_Garage","Land_John_Hangar","Land_A3PL_CG_Station","land_a3pl_ch","Land_A3PL_Clinic","Land_A3PL_Firestation","Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_Mansion01","Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_BostonHouse","Land_A3PL_Shed3","Land_A3PL_Shed4","Land_A3PL_Shed2","Land_John_House_Grey","Land_John_House_Blue","Land_John_House_Red","Land_John_House_Green","Land_A3FL_Warehouse","Land_A3FL_Airport_Hangar","Land_A3FL_Airport_Terminal","Land_A3FL_Barn","Land_A3FL_Brick_Shop_1","Land_A3FL_Brick_Shop_2","Land_A3FL_Office_Building","Land_A3FL_Mansion","Land_A3FL_House1_Cream","Land_A3FL_House1_Green","Land_A3FL_House1_Blue","Land_A3FL_House1_Brown","Land_A3FL_House1_Yellow","Land_A3FL_House2_Cream","Land_A3FL_House2_Green","Land_A3FL_House2_Blue","Land_A3FL_House2_Brown","Land_A3FL_House2_Yellow","Land_A3FL_House3_Cream","Land_A3FL_House3_Green","Land_A3FL_House3_Blue","Land_A3FL_House3_Brown","Land_A3FL_House3_Yellow","Land_A3FL_House4_Cream","Land_A3FL_House4_Green","Land_A3FL_House4_Blue","Land_A3FL_House4_Brown","Land_A3FL_House4_Yellow","Land_A3FL_Anton_Modern_Bungalow"];
	private _buildings = nearestObjects [[worldSize/2, worldsize/2, 0], _buidlingsArray, 5000000];
	{
		private _number = [_x] call Server_Addresses_GetAddressNb;
		private _road = [_x] call Server_Addresses_GetAddressRoad;
		private _city = [_x] call Server_Addresses_GetAddressCity;
		private _address = format["%1 %2, %3", _number, _road, _city];
		_x setVariable["Building_Address",_address,true];
	} forEach _buildings;
},true] call Server_Setup_Compile;

["Server_Addresses_GetAddressNb",
{
	private _building = param [0,objNull];
	private _number = [_building] call Server_Addresses_GetObjectID;
	parseNumber(_number);
},true] call Server_Setup_Compile;

["Server_Addresses_GetAddressRoad",
{
	private _building = param [0,objNull];
	private _road = "Unknown Street";
	private _nearestRoad = _building nearRoads 200;
	if(count(_nearestRoad) isEqualTo 0) exitWith {_road;};
	_nearestRoad = _nearestRoad select ((count _nearestRoad)-1);
	private _roadObject = str(_nearestRoad);
	private _roadID = parseNumber((_roadObject splitString ":") select 0);
	if(isNil "_roadID") exitWith {_road;};
	{
		private _a = _x select 0;
		private _b = _x select 1;
		if(_a < _b) then {
			if((_roadID >= _a) && {_roadID <= _b}) exitWith {
				_road = _x select 2;
			};
		} else {
			if((_roadID >= _b) && {_roadID <= _a}) exitWith {
				_road = _x select 2;
			};
		};
	} forEach Server_Addresses_Roads;
	_road;
},true] call Server_Setup_Compile;

["Server_Addresses_GetAddressCity",
{
	private _building = param [0,objNull];
	private _city = "Suffolk County";
	{
		if(_building distance (_x select 0) < (_x select 1)) exitWith {_city = _x select 2;};
	} forEach Server_Addresses_Cities;
	_city;
},true] call Server_Setup_Compile;

["Server_Addresses_GetObjectID",
{
	private _object = _this select 0;
	private _foundHash = false;
	private _foundColon = false;
	private _objectID = [];
	private _characterArray = toArray(str _object);
	{
		if (_x == 58) then {
			_foundColon = true;
		};
		if (_foundHash && (_x != 32) && !_foundColon) then {
			_objectID = _objectID + [_x];
		};
		if (_x == 35) then {
			_foundHash = true;
		};
	} forEach _characterArray;
	format["%1%2",_objectID select 0,_objectID select 1,_objectID select 2];
},true] call Server_Setup_Compile;