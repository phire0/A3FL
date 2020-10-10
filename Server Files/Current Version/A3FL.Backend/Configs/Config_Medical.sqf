/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//ID, WOUND NAME,CAUSES UNCONSCIOUSNESS,SEVERITY (orange/red),INSTANT BLOOD LOSS, BLOOD LOSS UNTIL TREATED,PAIN LEVEL INCREASE,ITEM TO TREAT, FULLY HEALS, ITEM TO FULLY HEAL
//ID, NAME, COLOR, INSTANT BLOOD LOSS, BLOOD LOSS,
Config_Medical_Wounds =
[
	["bullet",localize"STR_ConfigMedical_2","red",600,60,"med_bandage",false,"med_kit"],

	["wound_minor",localize"STR_ConfigMedical_4","orange",200,20,"med_bandage",true,""],
	["wound_major",localize"STR_ConfigMedical_5","red",300,30,"med_bandage",false,"med_kit"],
	["bruise",localize"STR_ConfigMedical_6","orange",0,0,"med_icepack",true,""],
	["cut",localize"STR_ConfigMedical_8","orange",100,5,"med_bandage",true,""],
	["bone_broken",localize"STR_ConfigMedical_9","red",400,40,"med_splint",false,"med_cast"],
	["taser",localize"STR_ConfigMedical_10","orange",0,0,"",true,""],

	["concussion",localize"STR_ConfigMedical_12","red",0,0,"med_painkillers",false,"med_icepack"],
	["pepper_spray","Pepper Spray","orange",0,0,"",true,"med_eyewash"],

	["smoke_minor",localize"STR_ConfigMedical_15","orange",0,0,"med_painkillers",true,"med_oxygenmask"],
	["smoke_major",localize"STR_ConfigMedical_17","red",0,0,"",false,"med_endotracheal"],
	["burn_first",localize"STR_ConfigMedical_18","orange",0,0,"med_icepack",true,""],
	["burn_second",localize"STR_ConfigMedical_19","orange",0,0,"med_icepack",true,""],

	["nausea",localize"STR_ConfigMedical_13","orange",0,0,"med_painkillers",true,""],
	["breathing",localize"STR_ConfigMedical_14","red",0,0,"",false,"med_endotracheal"],
	["drug_overdose",localize"STR_ConfigMedical_21","red",0,0,"med_narcan",false,"med_narcan"]
];
PublicVariable "Config_Medical_Wounds";