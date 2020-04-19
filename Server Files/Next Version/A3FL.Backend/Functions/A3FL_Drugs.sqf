["A3PL_Alcohol_Add",
{
	private _add = param [0,0];
	Player_Alcohol = Player_Alcohol + (_add);
	player setVariable["alcohol",true,true];
	profileNamespace setVariable ["player_alcohol",Player_Alcohol];
}] call Server_Setup_Compile;

["A3PL_Alcohol_Verify",
{
	if(Player_Alcohol < 0) then {
		Player_Alcohol = Player_Alcohol + (_add);
		profileNamespace setVariable ["player_alcohol",Player_Alcohol];
	};
}] call Server_Setup_Compile;

["A3PL_Alcohol_Loop",
{
	private _CurrentAlcool = Player_Alcohol;
	private _totalDrugs = 0;
	{
		_totalDrugs = _totalDrugs + _x;
	} foreach Player_Drugs;

	if(_totalDrugs > 0) exitWith {};

	//Do not loop if not drunk!
	if((_CurrentAlcool <= 0) || !(player getVariable["A3PL_Player_Alive",true])) exitWith {[] call A3PL_Alcohol_ResetEffects;};

	//Incapacitated from too much alcohol little matthew, do not edit the rules!
	if(_CurrentAlcool >= 80) exitWith {
		[] spawn A3PL_Medical_Die;
	};

	//Alcohol Effect
	//Just a little cam shake, it's for me.
	resetCamShake;
	enableCamShake true;
	addCamShake [((_CurrentAlcool)*0.3), 100, 2];

	//Adjusting animations speed for my little drunky mate
	player setAnimSpeedCoef (1-(_CurrentAlcool/100));

	//Visual Effects
	if(_CurrentAlcool >= 15) then {
		"ChromAberration" ppEffectEnable true;
		"ChromAberration" ppEffectAdjust [(_CurrentAlcool/1000), (_CurrentAlcool/1000), true];
		"ChromAberration" ppEffectCommit 0;
	};
	if(_CurrentAlcool > 30) then {
		"RadialBlur" ppEffectEnable true;
		"RadialBlur" ppEffectAdjust [0.01, 0.01, 0.06, 0.06];	//Make it variate with alcohol level
		"RadialBlur" ppEffectCommit 0;
	};

	//Too drunk bro! you fell like a Jason being fucked in the ass!
	_randomFall = random(100);
	if(_randomFall < (_CurrentAlcool)) then {
		if((speed player) > 3) then {
			[] call A3PL_Lib_Ragdoll;
		};
	};

	//Decrese alcohol level
	if(Player_Alcohol <= 0) exitWith {};
	Player_Alcohol = Player_Alcohol - 1;
	profileNamespace setVariable ["player_alcohol",Player_Alcohol];
}] call Server_Setup_Compile;

["A3PL_Alcohol_ResetEffects",
{
	resetCamShake;
	enableCamShake false;
	player setVariable["alcohol",false,true];
	if(!pVar_FastAnimationOn) then {player setAnimSpeedCoef 1;};
	"ChromAberration" ppEffectEnable false;
	"RadialBlur" ppEffectEnable false;
	[] call A3PL_Alcohol_Verify;
}] call Server_Setup_Compile;

//Player_Drugs = [shrooms,cocaine,weed]
["A3PL_Drugs_Add",
{
	private["_type","_add","_new"];
	_type = param [0,"unknown"];
	_add = param [1,0];

	_index = -1;
	switch(true) do {
		case(_type isEqualTo "shrooms"): {
			_index = 0;
		};
		case(_type isEqualTo "cocaine"): {
			_index = 1;
		};
		case(_type IN ["weed_5g","weed_10g","weed_15g","weed_20g","weed_25g","weed_30g","weed_35g","weed_40g","weed_45g","weed_50g","weed_55g","weed_60g","weed_65g","weed_70g","weed_75g","weed_80g","weed_85g","weed_90g","weed_95g","weed_100g"]): {
			_index = 2;
		};
	};
	if(_index < 0) exitwith {};
		hint "added drugs";

	_new = (Player_Drugs select _index) + (_add);
	player setVariable["drugs",true,true];
	Player_Drugs set[_index, _new];
	profileNamespace setVariable ["player_drugs",Player_Drugs];
}] call Server_Setup_Compile;

["A3PL_Drugs_Loop",
{
	private["_totalDrugs"];
	_totalDrugs = 0;
	{
		_totalDrugs = _totalDrugs + _x;
	} foreach Player_Drugs;


	if((_totalDrugs <= 0) || !(player getVariable["A3PL_Player_Alive",true])) exitWith {[] call A3PL_Drugs_ResetEffects;};


	//Incapacitated from too much drugs!
	if(_totalDrugs >= 150) exitWith {
		profileNamespace setVariable ["player_drugs",[0,0,0]];
		Player_Drugs = [0,0,0];
		[player, "left upper arm", "drug_overdose"] call A3PL_Medical_ApplyWound;
		[] spawn A3PL_Medical_Die;
	};

	if((Player_Drugs select 0) > 0) then {
		_shrooms = Player_Drugs select 0;

		//Effects - on total drug level for now - SAME AS ALCOHOL FOR NOW
		resetCamShake;
		enableCamShake true;
		addCamShake [((_totalDrugs)*0.6), 100, 2];

		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [0.5, 0.5, 0, [(random 10),(random 10),(random 10),0.2], [1,1,5,2], [(random 5),(random 5),(random 5),(random 5)]];
		"colorCorrections" ppEffectCommit 40;
		player setstamina 100;

		//Adjusting animations speed
		//player setAnimSpeedCoef (1+(_totalDrugs/200));

		//Visual Effects
		if(_shrooms >= 15) then {
			"ChromAberration" ppEffectEnable true;
			"ChromAberration" ppEffectAdjust [(_totalDrugs/800), (_totalDrugs/800), true];
			"ChromAberration" ppEffectCommit 30;
		};
		if(_shrooms > 30) then {
			"RadialBlur" ppEffectEnable true;
			"RadialBlur" ppEffectAdjust [0.01, 0.01, 0.06, 0.06];	//Make it variate with alcohol level
			"RadialBlur" ppEffectCommit 30;
			player enableStamina false;
		};
	};

	if((Player_Drugs select 1) > 0) then {
		_coke = Player_Drugs select 1;


		resetCamShake;
		enableCamShake true;
		addCamShake [((_coke)*0.6), 100, 2];

		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [0.5, 0.5, 0, [(random 10),(random 10),(random 10),0.2], [1,1,5,2], [(random 5),(random 5),(random 5),(random 5)]];
		"colorCorrections" ppEffectCommit 40;
		player setAnimSpeedCoef 1.3;

		//Adjusting animations speed
		//player setAnimSpeedCoef (1+(_totalDrugs/200));

		//Visual Effects
		if(_coke > 30) then {
			"colorCorrections" ppEffectEnable true;
			"colorCorrections" ppEffectAdjust [0.01, 0.01, 0.06, 0.06];	//Make it variate with alcohol level
			"colorCorrections" ppEffectCommit 30;
			player setStamina 200;
		};
		if(_coke >= 15) then {
			"colorCorrections" ppEffectEnable true;
			"colorCorrections" ppEffectAdjust [(_coke/800), (_coke/800), true];
			"colorCorrections" ppEffectCommit 30;
			player setStamina 150;
		};
	};

	if((Player_Drugs select 2) > 0) then {
		_weed = (Player_Drugs select 2);

		"dynamicBlur" ppEffectEnable true;
		"dynamicBlur" ppEffectAdjust [0.25];
		"dynamicBlur" ppEffectCommit 1;

		//Adjusting animations speed
		player setAnimSpeedCoef 0.7;

		//Visual Effects
		if(_weed > 50) then {
			"dynamicBlur" ppEffectEnable true;
			"dynamicBlur" ppEffectAdjust [0.75];	//Make it variate with alcohol level
			"dynamicBlur" ppEffectCommit 1;
			player setAnimSpeedCoef 0.5;
			_bloodLevel = [player,"blood"] call A3PL_Medical_GetVar;
			if(_bloodLevel < 5000) then {
				[player,[200]] call A3PL_Medical_ApplyVar;
			};
		};
	};

	//Decrease Drug level
	{
		if(_x > 0) then {
			Player_Drugs set[_forEachIndex, (_x - 3)];
		};
	} foreach Player_Drugs;
	profileNamespace setVariable ["player_drugs",Player_Drugs];
}] call Server_Setup_Compile;

["A3PL_Drugs_ResetEffects",
{
	Player_Drugs = [0,0,0];
	player setVariable["drugs",false,true];
	resetCamShake;
	enableCamShake false;
	if(!pVar_FastAnimationOn) then {player setAnimSpeedCoef 1;};
	"colorCorrections" ppEffectEnable false;
	"ChromAberration" ppEffectEnable false;
	"RadialBlur" ppEffectEnable false;
	"filmGrain" ppEffectEnable false;
	"dynamicBlur" ppEffectEnable false;
}] call Server_Setup_Compile;

["A3PL_Drugs_DrugTest",
{
	private["_target"];
	_target = param [0,objNull];
	[player] remoteExec ["A3PL_Drugs_DrugTestReturn",_target];
	[player_item] call A3PL_Inventory_Clear;
	[player,"drug_kit",-1] remoteExec ["Server_Inventory_Add",2];
}] call Server_Setup_Compile;

["A3PL_Drugs_DrugTestReturn",
{
	private["_cop","_drugLevel"];
	_cop = param [0,objNull];
	_drugLevel = Player_Drugs;
	_job = _cop getVariable["job","unemployed"];

	if(_job isEqualTo "fifr") then {
		_shrooms = _drugLevel select 0;
		_coke = _drugLevel select 1;
		_weed = _drugLevel select 2;
		[format["Cocaine: %1<br/>Marijuana: %2<br/>Shrooms: %3",_coke,_weed,_shrooms],"blue"] remoteExec ["A3PL_Player_Notification",_cop];
	} else {
		_totalDrugs = 0;
		{_totalDrugs = _totalDrugs + _x;} foreach _drugLevel;
		if(_totalDrugs > 0) then {["The drug test returned positive, FIFR can provide more detailed results on what drugs have been taken!","blue"] remoteExec ["A3PL_Player_Notification",_cop];};
		if(_totalDrugs == 0) then {["The drug test returned negative!","blue"] remoteExec ["A3PL_Player_Notification",_cop];};
	};
}] call Server_Setup_Compile;
