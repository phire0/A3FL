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
		[[2580.85,5514.1,0],800,"Silverton","Main city"],
		[[3540.16,6664.84,0],800,"Palm Beach","Small motels"],
		[[3471.51,7537.87,0],700,"Stoney Creek","Port city"],
		[[4112.35,6302.47,0],200,"Beach Valley","Like a beach, really cool"],
		[[6092.58,7377.73,0],200,"Elk City","In the middle of everything"],
		[[7037.48,7175.65,0],300,"Boulder City","A very narrow city"],
		[[9922.94,7906.62,0],300,"Deadwood","The city of death"],
		[[8858.01,6371.74,0],300,"Springfield","The Simpsons family is here"],
		[[10224,8571.71,0],300,"Northdale","Second main city"]
	];
	private _Server_Roads_Data = [
		[[3835.88,6376.76,0],[11732,9261.72,0],"Main Service Road"],
		[[2234.51,5060.15,0],[2057.03,5059.58,0], "Coast Guard Base"],
		[[2115.22,5053.55,0],[2114.82,4982.33,0],"Coast Guard Base"],
		[[2154.35,5129.33,0],[2247.88,5125.88,0],"Coast Guard Base"],
		[[2149.53,5134.82,0],[2150.55,5187.6,0],"Coast Guard Base"],
		[[2674.13,5430.42,0],[2697.7,5347.87,0],"Airport Access"],
		[[6250,7699.3,0],[6173.62,7769.09,0],"Sheriff HQ"],
		[[4704.92,5739.26,0],[4722.13,6411.35,0],"Department Of Corrections"],
		[[2612.29,5414.15,0],[2600.32,5430.42,0],"Silverton Sheriff Department"],
		[[4471.26,6826.82,0],[4191.39,6780.1,0],"Steel Mill"],
		[[4215.91,4848.48,0],[3842.27,4767.45,0],"Axel Avenue"],
		[[4237.61,5259.22,0],[3627.38,5184.45,0],"Father Gaben Boulevard"],
		[[4315.62,5743.1,0],[4204.72,4438.77,0],"Gaben's Way"],
		[[3527.19,7533.99,0],[2726.55,5491.44,0],"Star Avenue"],
		[[5938.67,5008.91,0],[5938.72,4932.71,0],"Freeman Court"],
		[[6050.47,7524.44,0],[5929.36,7342.21,0],"Frost Avenue"],
		[[3507.16,7452.74,0],[3522.78,7603.98,0],"Winston Square"],
		[[3516.7,7604.31,0],[3436.22,7613.49,0],"Winston Square"],
		[[3427.54,7617.92,0],[3412.11,7469.36,0],"Winston Square"],
		[[3420.55,7464.87,0],[3500.44,7455.85,0],"Winston Square"],
		[[3179.59,5488.41,0],[3058.81,5373.47,0],"Abrams Avenue"],
		[[3850.93,6662.29,0],[3431.82,6661.25,0],"Boomer Boulevard"],
		[[3294.7,5743.52,0],[3284.93,5742.37,0],"CarCrash Road"],
		[[2538.24,5623.26,0],[2712.87,5485.4,0],"Walkins Street"],
		[[8617.38,7930.56,0],[8565.61,6242.87,0],"Casey Boulevard"],
		[[4064.11,6010.22,0],[3578.01,6168.27,0],"Fronkfurt Avenue"],
		[[6769.92,7162.73,0],[7231.74,7156.63,0],"Booker Street"],
		[[2711.14,5473.4,0],[2583.13,5700.5,0],"Fred Weeks Loop"],
		[[2491.71,5399.38,0],[2757.28,5555.79,0],"Hardy Lane"],
		[[5932.59,6181.43,0],[8184.5,6238.16,0],"Dep's Road"],
		[[9603.15,8007.19,0],[10173,8203,0],"George Road"],
		[[5894.06,7251.83,0],[6830.36,7606.05,0],"Electric Avenue"],
		[[8800.9,6321.12,0],[8857.23,6325.6,0],"Jason Road"],
		[[3834.72,7083.22,0],[4145.77,6394.88,0],"DeLaware Avenue"],
		[[6918.88,7013.3,0],[7228.06,7170.01,0],"Crimson Avenue"],
		[[6909.51,7785.59,0],[6772.37,7943.47,0],"Fullman Terrace"],
		[[4142.62,5951.45,0],[4153.49,6387.6,0],"Fitzcharles Valley"],
		[[6882.51,7060.49,0],[7231.85,7244.74,0],"Wick Boulevard"],
		[[4074.95,6387.56,0],[4146.27,6193.48,0],"Tosh Lane"],
		[[5913.76,7053.66,0],[6101.68,6809.28,0],"Patel Avenue"],
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
		[[2582.43,5581.18,0],[2502.13,5479.35,0],"Dings Lane"],
		[[4233.78,7099.04,0],[4330.63,6952.7,0],"Conehead Lane"],
		[[7020.54,7285.83,0],[7161.52,7083.47,0],"Leightonville Boulevard"],
		[[7085.71,7317.5,0],[7217.04,7150.56,0],"Patel Boulevard"],
		[[4458.83,5716.66,0],[4454.17,5678.36,0],"Freeman Mansion"],
		[[6554.06,7677.49,0],[7221.19,7921.64,0],"Greene Mile"],
		[[2431.55,5725.05,0],[2538.41,5651.14,0],"Phillip's Boulevard"],
		[[10462.1,8416.58,0],[10687.5,8876.15,0],"Axel Airport Road"],
		[[7857.95,8730.71,0],[7655.2,8501.17,0],"Executioner's Point"],
		[[2329.74,5579.8,0],[2437.28,5508.93,0],"Fronklin Lane"],
		[[7870.88,6064.1,0],[7678.99,6513.06,0],"Redd Road"],
		[[9844.23,8333.92,0],[9836.05,8318.54,0],"Hillbuns Landing"],
		[[3530.85,6307.84,0],[3607.9,6201.12,0],"Mossy Lane"],
		[[2378.98,5538.96,0],[2289.71,5409.67,0],"Hastings Lane"],
		[[2356.83,5493.73,0],[2438.07,5440.01,0],"Corruption Lane"],
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
		[[9711.7,7846.4,0],[9745.68,7936.6,0],"Coffin Cut off"],
		[[8667.38,7664.7,0],[8941.41,7664.38,0],"Beach Front Drive"],
		[[2764.97,5541.12,0],[3221.46,5499.35,0],"Evergreen Way"],
		[[3114.83,5368.55,0],[3026.39,5207.3,0],"Industrial Drive"],
		[[4825.63,5275.62,0],[4716.83,5603.88,0],"Landlubber Drive"],
		[[6055.92,7272.77,0],[5902.71,7283.09,0],"Parker Way"],
		[[4825.18,5297.39,0],[4572.95,5463.59,0],"Porpoise Drive"],
		[[4742.87,5697.59,0],[4574.61,5475.42,0],"Porpoise Drive"],
		[[6077.59,7416.95,0],[6155.48,7365.84,0],"That Road"],
		[[6074.87,7341.08,0],[6047.23,7292.27,0],"This Road"],
		[[6133.67,7320.36,0],[6202.46,7425.33,0],"The Other Road"],
		[[5693.54,6507.94,0],[5377.16,6660.18,0],"Spike Avenue"],
		[[5187.94,5771.07,0],[5671.62,6455.01,0],"Dayhart Lane"]
	];

	Server_Addresses_Roads = [];
	{
		private _a = _x select 0;
		private _b = _x select 1;
		private _name = _x select 2;
		private _roadObject = str (roadAt _a);
		private _aID = parseNumber (( _roadObject splitString ":" ) select 0);
		private _roadObject = str (roadAt _b);
		private _bID = parseNumber (( _roadObject splitString ":" ) select 0);
		Server_Addresses_Roads pushBack [_aID,_bID,_name];
	} forEach _Server_Roads_Data;
	publicVariable "Server_Addresses_Roads";

	_buidlingsArray = ["Land_A3FL_Fishers_Jewelry","Land_A3PL_Bank","Land_A3PL_Capital","Land_A3PL_Sheriffpd","Land_A3FL_SheriffPD","Land_Shop_DED_Shop_01_F","land_smallshop_ded_smallshop_01_f","land_market_ded_market_01_f","Land_Taco_DED_Taco_01_F","Land_A3PL_Gas_Station","Land_A3PL_Garage","Land_John_Hangar","Land_A3PL_CG_Station","land_a3pl_ch","Land_A3PL_Clinic","Land_A3PL_Firestation","Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_Mansion01","Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_BostonHouse","Land_A3PL_Shed3","Land_A3PL_Shed4","Land_A3PL_Shed2","Land_John_House_Grey","Land_John_House_Blue","Land_John_House_Red","Land_John_House_Green","Land_A3FL_Warehouse","Land_A3FL_Airport_Hangar","Land_A3FL_Airport_Terminal","Land_A3FL_Barn","Land_A3FL_Brick_Shop_1","Land_A3FL_Brick_Shop_2","Land_A3FL_Office_Building","Land_A3FL_Mansion","Land_A3FL_House1_Cream","Land_A3FL_House1_Green","Land_A3FL_House1_Blue","Land_A3FL_House1_Brown","Land_A3FL_House1_Yellow","Land_A3FL_House2_Cream","Land_A3FL_House2_Green","Land_A3FL_House2_Blue","Land_A3FL_House2_Brown","Land_A3FL_House2_Yellow","Land_A3FL_House3_Cream","Land_A3FL_House3_Green","Land_A3FL_House3_Blue","Land_A3FL_House3_Brown","Land_A3FL_House3_Yellow","Land_A3FL_House4_Cream","Land_A3FL_House4_Green","Land_A3FL_House4_Blue","Land_A3FL_House4_Brown","Land_A3FL_House4_Yellow","Land_A3FL_Anton_Modern_Bungalow"];
	_buildings = nearestObjects [[worldSize/2, worldsize/2, 0], _buidlingsArray, 5000000];
	{
		private["_x","_address","_number","_road","_city"];
		_number = [_x] call Server_Addresses_GetAddressNb;
		_road = [_x] call Server_Addresses_GetAddressRoad;
		_city = [_x] call Server_Addresses_GetAddressCity;
		_address = format["%1 %2, %3", _number, _road, _city];
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
	_nearestRoad = _nearestRoad select 0;
	private _roadObject = str(_nearestRoad);
	private _roadID = parseNumber((_roadObject splitString ":") select 0);
	if(isNil "_roadID") exitWith {_road;};
	{
		private ["_a","_b"];
		_a = _x select 0;
		_b = _x select 1;
		if(_a < _b) then {
			if(_roadID >= _a && _roadID <= _b) exitWith {
				_road = _x select 2;
			};
		} else {
			if(_roadID >= _b && _roadID <= _a) exitWith {
				_road = _x select 2;
			};
		};
	} forEach Server_Addresses_Roads;
	_road;
},true] call Server_Setup_Compile;

["Server_Addresses_GetAddressCity",
{
	private _building = param [0,objNull];
	private _city = "Fishers Island";
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
