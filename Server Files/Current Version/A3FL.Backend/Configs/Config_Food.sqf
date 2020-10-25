/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//['class', gain, isDrug]
Config_Food =
[
	["tacoshell",2,false],
	["lettuce",4,false],
	["salad",5,false],
	["apple",6,false],
	["corn",7,false],
	["burger_bun",8,false],
	["donut",13,false],
	["cereal",20,false],
	["fish_cooked",15,false],
	["bread",10,false],
	["applecookies",17,false],
	["taco_cooked",50,false],
	["burger_cooked",18,false],
	["cookies",15,false],
	["burger_full_cooked",50,false],
	["lamington",15,false],
	["soupcup",20,false],
	["meatpie",100,false],
	["sausages",30,false],
	["pizzabites",25,false],
	["fish_raw",-4,false],
	["burger_raw",-6,false],
	["fish_burned",-8,false],
	["burger_burnt",-9,false],
	["taco_raw",-12,false],
	["burger_full_raw",-13,false],
	["taco_burned",-15,false],
	["burger_full_burnt",-16,false],

	/*	DRUGS	*/
	["shrooms",25,true],
	["cocaine",40,true],
	["weed_5g",5,true],
	["weed_10g",10,true],
	["weed_15g",15,true],
	["weed_20g",20,true],
	["weed_25g",25,true],
	["weed_30g",30,true],
	["weed_35g",35,true],
	["weed_40g",40,true],
	["weed_45g",45,true],
	["weed_50g",50,true],
	["weed_55g",55,true],
	["weed_60g",60,true],
	["weed_65g",65,true],
	["weed_70g",70,true],
	["weed_75g",75,true],
	["weed_80g",80,true],
	["weed_85g",85,true],
	["weed_90g",90,true],
	["weed_95g",95,true],
	["weed_100g",100,true]
];
publicVariable "Config_Food";

//['class', gain, isAlcohol, coffeeEffectsLength (Minutes)]
Config_Thirst =
[
	["coffee",30,false,8],
	["coke",30,false,0],
	["waterbottle",50,false,0],
	["coffee_cup_large",50,false,12],
	["coffee_cup_medium",40,false,10],
	["coffee_cup_small",30,false,8],

	//Alcohol
	["beer",10,true,0],
	["beer_gold",30,true,0]
];
publicVariable "Config_Thirst";