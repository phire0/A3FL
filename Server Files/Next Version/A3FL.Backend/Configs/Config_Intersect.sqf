/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

//Replaces memory point/interaction text and sets the correct icon,uses default icon and memory point name if not defined!
//NameOfSelection,Name to display,Icon to use
//Does not support icons located in mission folder
private _dir = "\a3\ui_f\data\";

//Mainly for placeables or objects with no proper bones in fire geometry
Config_Intersect_NoName =
[
	["PipeFence_01_m_gate_v2_F","Open Gate",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa"],
	["RoadCone_F","Cone","\a3\ui_f\data\gui\Rsc\RscDisplayArcadeMap\icon_toolbox_triggers_ca.paa"],
	["Box_GEN_Equip_F",localize"STR_INTSECT_ACCVIRSTOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa"],
	["Land_MetalCase_01_large_F",localize"STR_INTSECT_ACCVIRSTOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa"],
	["B_supplyCrate_F",localize"STR_INTSECT_ACCVIRSTOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa"],
	["Land_GarbageBin_03_F","Search Trash",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa"],
	["Land_ToolTrolley_02_F","Work",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa"]
];
publicVariable "Config_Intersect_NoName";

Config_IntersectArray =
[
	["item_pickup","Add Item","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) isEqualTo "A3FL_PlasticBarrel") && {(Player_ItemClass IN ["kerosene_jerrycan","sulphuric_acid","calcium_carbonate","coca_paste","potassium_permangate","cocaine_base","ammonium_hydroxide","acetone","hydrocloric_acid","coca"])}}],
	["item_pickup","Collect Product","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) isEqualTo "A3FL_PlasticBarrel") && {((["coca_paste"] call A3PL_Cocaine_InBarrel) or (["cocaine_base"] call A3PL_Cocaine_InBarrel) or (["cocaine_hydrochloride"] call A3PL_Cocaine_InBarrel))}}],
	["item_pickup","Check Barrel Contents","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) isEqualTo "A3FL_PlasticBarrel")}],
	["item_pickup","Produce Coca Paste","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) isEqualTo "A3FL_PlasticBarrel") && {([["acetone",1],["calcium_carbonate",1],["coca",5],["kerosene_jerrycan",1],["sulphuric_acid",1]] isEqualTo (player_objIntersect getVariable["items",[]]))}}],
	["item_pickup","Produce Cocaine Base","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) isEqualTo "A3FL_PlasticBarrel") && {([["coca_paste",5],["potassium_permangate",1]] isEqualTo (player_objIntersect getVariable["items",[]]))}}],
	["item_pickup","Produce Cocaine Hydrochloride","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) isEqualTo "A3FL_PlasticBarrel") && {([["acetone",1],["ammonium_hydroxide",1],["cocaine_base",3],["hydrocloric_acid",1]] isEqualTo (player_objIntersect getVariable["items",[]]))}}],
	["item_pickup","Remove Barrel Contents","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) isEqualTo "A3FL_PlasticBarrel")}],
	["item_Pickup","Create Cocaine Brick","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) isEqualTo "A3PL_Scale")}],
	["item_Pickup","Break Down Cocaine Brick","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) isEqualTo "A3PL_Scale")}],

	//moonshine
	["distillery_end",localize"STR_INTSECT_InstallHose",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((count (nearestObjects [player_objintersect, ["A3PL_Distillery_Hose"], 2])) > 0) && {((count ([player_objintersect] call A3PL_Lib_AttachedAll)) < 1)}}],
	["distillery_main",localize"STR_INTSECT_StartDistillery",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{true}],
	["distillery_main",localize"STR_INTSECT_CheckDistilleryStatus",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect getVariable ["running",false])}],
	["distillery_main",localize"STR_INTSECT_AddItemToDistillery",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{true}],
	["item_Pickup",localize"STR_INTSECT_ConnectJugToHose","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Distillery_Hose") && ((count ([player_objIntersect] call A3PL_Lib_AttachedAll)) < 1)}],
	["item_Pickup",localize"STR_INTSECT_GrindWheatIntoYeast","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Mixer")}],
	["item_Pickup",localize"STR_INTSECT_GrindWheatIntoMalt","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Mixer")}],
	["item_Pickup",localize"STR_INTSECT_GrindCornIntoCornmeal","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Mixer")}],
	["scooter_driver",localize"STR_INTSECT_USEJERRYC", "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa", {player_itemClass == "jerrycan" && {(typeOf player_objintersect == "C_Quadbike_01_F")}}],
	["spine3",localize"STR_QuickActionsNPC_StationStore",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_fuel_1,npc_fuel_2,npc_fuel_3,npc_fuel_4,npc_fuel_6,npc_fuel_8,npc_fuel_9,npc_fuel_10,npc_fuel_11,npc_fuel_12]}],

	//hunting
	["spine2",localize"STR_QuickActionsNPC_SkinAnimal",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((typeOf player_objintersect) IN ["Sheep","Sheep02","Sheep03","Goat","Goat02","Goat03","WildBoar","Cow01","Cow02","Cow03","Cow04","Cow05"]) && {!alive player_objintersect}}],
	["hips",localize"STR_QuickActionsNPC_SkinAnimal",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((typeOf player_objintersect) IN ["Sheep","Sheep02","Sheep03","Goat","Goat02","Goat03","WildBoar","Cow01","Cow02","Cow03","Cow04","Cow05"]) && {!alive player_objintersect}}],
	["spine",localize"STR_QuickActionsNPC_SkinAnimal",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((typeOf player_objintersect) IN ["Sheep","Sheep02","Sheep03","Goat","Goat02","Goat03","WildBoar","Cow01","Cow02","Cow03","Cow04","Cow05"]) && {!alive player_objintersect}}],
	["head",localize"STR_QuickActionsNPC_SkinAnimal",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((typeOf player_objintersect) IN ["Sheep","Sheep02","Sheep03","Goat","Goat02","Goat03","WildBoar","Cow01","Cow02","Cow03","Cow04","Cow05"]) && {!alive player_objintersect}}],
	["aimpoint",localize"STR_QuickActionsNPC_SkinAnimal",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((typeOf player_objintersect) IN ["Cow01","Cow02","Cow03","Cow04","Cow05"]) && {!alive player_objintersect}}],
	["item_pickup",localize"STR_INTSECT_TagMeat",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect getVariable ["class","unknown"]) IN ["meat_sheep","meat_goat","meat_boar","mullet","shark_2lb","shark_4lb","shark_5lb","shark_7lb","shark_10lb","meat_cow"]}],

	//drugs
	["trunkinside",localize"STR_INTSECT_CureBud","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_WorkBench") && {(player_itemClass == "cannabis_bud")}}],
	["trunkinside",localize"STR_INTSECT_CureBud","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3FL_Table") && {(player_itemClass == "cannabis_bud")}}],
	["item_pickup",localize"STR_INTSECT_CheckCureStatus","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Cannabis_Bud")}],
	["item_Pickup",localize"STR_INTSECT_GrindCannabis","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Mixer")}],
	["item_Pickup",localize"STR_INTSECT_CollectGrindedCannabis","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Mixer")}],
	["item_Pickup",localize"STR_INTSECT_BagMarijuana","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Scale")}],
	["Toggle_Ramp",localize"STR_INTSECT_UPLWRAMP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objintersect isKindOf "A3PL_Car_Trailer"}], //Lower/Raise Ramp

	//Garbage Truck/Job
	["Bin_Controller1",localize"STR_INTSECT_TrashSlideLeft",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {(player_objintersect animationSourcePhase "Bin1" == 0.1)}}],
	["Bin_Controller1",localize"STR_INTSECT_TrashLwLeft",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& {(player_objintersect animationSourcePhase "Bin1" > 0.5)}}],
	["Bin_Controller1",localize"STR_INTSECT_TrashSlideRight",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {(player_objintersect animationSourcePhase "Bin2" == 0.1)}}],
	["Bin_Controller1",localize"STR_INTSECT_TrashLwRight",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {(player_objintersect animationSourcePhase "Bin2" > 0.5)}}],
	["Bin_Controller2",localize"STR_INTSECT_TrashSlideLeft",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& {(player_objintersect animationSourcePhase "Bin1" == 0.1)}}],
	["Bin_Controller2",localize"STR_INTSECT_TrashLwLeft",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& {(player_objintersect animationSourcePhase "Bin1" > 0.5)}}],
	["Bin_Controller2",localize"STR_INTSECT_TrashSlideRight",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& {(player_objintersect animationSourcePhase "Bin2" == 0.1)}}],
	["Bin_Controller2",localize"STR_INTSECT_TrashLwRight",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {(player_objintersect animationSourcePhase "Bin2" > 0.5)}}],

	["Lid",localize"STR_INTSECT_TrashLoad",_dir+"IGUI\Cfg\Actions\take_ca.paa",{[player_objintersect] call A3PL_Waste_CheckNear}],
	["bin1",localize"STR_INTSECT_TrashDischarge",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_P362_Garbage_Truck") && {(player_objintersect animationSourcePhase "Bin1" == 0.1)}}],
	["bin2",localize"STR_INTSECT_TrashDischarge",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_P362_Garbage_Truck") && {(player_objintersect animationSourcePhase "Bin2" == 0.1)}}],
	["Lid",localize"STR_INTSECT_TrashPick",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeOf player_objintersect == "A3PL_WheelieBin"}],
	["Lid",localize"STR_INTSECT_TrashClose",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Lid" > 0.5)}],

	["goose_floats",localize"STR_INTSECT_TOGGLEFLOATS",_dir+"IGUI\Cfg\Actions\autohover_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Toggle Floats
	["goose_fuelpump",localize"STR_INTSECT_TOGGLEFP",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Toggle Fuelpump
	["goose_gear",localize"STR_INTSECT_TOGGLEFP",_dir+"IGUI\Cfg\Actions\autohover_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Toggle Gear
	["goose_bat",localize"STR_INTSECT_TOGGLEBAT",_dir+"IGUI\Cfg\Actions\ico_cpt_batt_on_ca",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Toggle Battery
	["goose_flaps",localize"STR_INTSECT_ADJFLUP",_dir+"IGUI\Cfg\Actions\flapsretract_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Adjust Flaps Upward
	["goose_flaps",localize"STR_INTSECT_ADJFLDWN",_dir+"IGUI\Cfg\Actions\flapsextend_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Adjust Flaps Downward
	["goose_gen",localize"STR_INTSECT_SWITCHGEN",_dir+"IGUI\Cfg\Actions\repair_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Switch Generator
	["goose_ign",localize"STR_INTSECT_SWITCHIGN2",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Switch Ignition/Starter
	["lightswitch",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Toggle Head Lights
	["collision_lights",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}],//Toggle Collision Lights

	["C172_fuelpump",localize"STR_INTSECT_TOGGLEFP",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Toggle Fuelpump
	["C172_batteries",localize"STR_INTSECT_TOGGLEBAT",_dir+"IGUI\Cfg\Actions\ico_cpt_batt_on_ca",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Toggle Battery
	["Switch_C172_Flaps",localize"STR_INTSECT_ADJFLUP",_dir+"IGUI\Cfg\Actions\flapsretract_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Adjust Flaps Upward
	["Switch_C172_Flaps",localize"STR_INTSECT_ADJFLDWN",_dir+"IGUI\Cfg\Actions\flapsextend_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Adjust Flaps Downward
	["C172_Ignition",localize"STR_INTSECT_SWITCHIGN2",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Switch Ignition/Starter
	["lightswitch",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}],  //Toggle Head Lights
	["collision_lights",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}],//Toggle Collision Lights
	["switch_radio_atc",localize"STR_INTSECT_TOGATCR",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_ATC_ON_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Toggle ATC Radio

	["switch_starter", format [localize"STR_INTSECT_TOGSTARENG",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Starter (Engine 1)
	["switch_starter", format [localize"STR_INTSECT_TOGSTARENG",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Starter (Engine 2)
	["switch_throttle", format [localize"STR_INTSECT_THROTCL",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Throttle Closed (Engine 1)
	["switch_throttle2", format [localize"STR_INTSECT_THROTCL",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Throttle Closed (Engine 2)
	["switch_radio_atc", localize"STR_INTSECT_TOGATCR",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_ATC_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle ATC Radio
	["switch_batteries", localize"STR_INTSECT_TOGBATT",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_batt_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Batteries
	["Interior_Lights", localize"STR_INTSECT_COCKLIGHT",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Cockpit Lights
	["Searchlight_Switch", localize"STR_INTSECT_TOGGLESL",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_land_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Searchlight
	["switch_lightsac", localize"STR_INTSECT_TOGCOLLIGHT",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Collision Lights
	["switch_lightsldg", localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_land_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Head Lights
	["switch_rotor_brake", localize"STR_INTSECT_TOGROTBR",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_brk_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Rotor Brake
	["switch_starter_2", format [localize"STR_INTSECT_TOGSTARENG",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Starter (Engine 1)
	["switch_starter_2", format [localize"STR_INTSECT_TOGSTARENG",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Starter (Engine 2)
	["switch_throttle_2", format [localize"STR_INTSECT_THROTCL",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Throttle Closed (Engine 1)
	["switch_throttle2_2", format [localize"STR_INTSECT_THROTCL",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Throttle Closed (Engine 2)

	//MERGE LATER
	["item_pickup",localize"STR_INTSECT_STACKCONE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect IN ["A3PL_RoadCone","A3PL_RoadCone_x10"])}], //Stack cone
	["Pilot_Door",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(player_objintersect isKindOf "Air") && {(vehicle player == player)&& !(player_objIntersect getVariable ["locked",true])} && (!(player getVariable ["Cuffed",true]) && !(player getVariable ["Zipped",true]))}], //Enter as Driver
  	["Pilot_Door",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && {(!(vehicle player getVariable ["trapped",false]))}  && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],
	["Pilot_Door",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],
	["Pilot_Door",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable ["job","unemployed"]) IN ["uscg","fisd","usms"])} && {((speed player_objIntersect) < 5)}}], //Eject All Passengers
	["Pilot_Door",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable ["job","unemployed"]) IN ["uscg","fisd","usms"])}}], //Detain Suspect
	["Pilot_Door",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open\Close Door
	["Pilot_Door",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["CoPilot_Door",localize"STR_INTSECT_ENTCOPIL","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(player_objintersect isKindOf "Air") && {(vehicle player == player)} && {!(player_objIntersect getVariable ["locked",true])}}],	//Enter as Co-Pilot
	["CoPilot_Door",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && {!(player_objIntersect getVariable ["locked",true])} && {(!(vehicle player getVariable ["trapped",false]))}  && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["CoPilot_Door",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["CoPilot_Door",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])} && {((speed player_objIntersect) < 5)}}], //Eject All Passengers
	["CoPilot_Door",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Detain Suspect
	["CoPilot_Door",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open\Close Door
	["CoPilot_Door",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle

	//Heli_Medium01
	["inspect_hitengine1",format [localize"STR_INTSECT_INSPENG",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!("inspect_hitengine1" IN (player_objIntersect getVariable "Inspection"))) && {(player_objintersect animationSourcePhase "Inspect_Panel1_1" > 0.5)}}], //Inspect Engine #%1
	["inspect_hitengine2",format [localize"STR_INTSECT_INSPENG",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!("inspect_hitengine2" IN (player_objIntersect getVariable "Inspection"))) && {(player_objintersect animationSourcePhase "Inspect_Panel2_1" > 0.5)}}], //Inspect Engine #%2
	["inspect_hithrotor1",format [localize"STR_INTSECT_INSPMAINROT",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithrotor1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Main Rotor #1
	["inspect_hithrotor2",format [localize"STR_INTSECT_INSPMAINROT",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithrotor2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Main Rotor #2
	["inspect_hithrotor3",format [localize"STR_INTSECT_INSPMAINROT",3],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithrotor3" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Main Rotor #3
	["inspect_hithrotor4",format [localize"STR_INTSECT_INSPMAINROT",4],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithrotor4" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Main Rotor #4
	["inspect_hitvrotor1",format [localize"STR_INTSECT_INSPTAILROT","#1"],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitvrotor1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Tail Rotor #1
	["inspect_hitvrotor2",format [localize"STR_INTSECT_INSPTAILROT","#2"],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitvrotor2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Tail Rotor #2
	["inspect_hitvrotor3",format [localize"STR_INTSECT_INSPTAILROT","Hub"],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitvrotor3" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Tail Rotor Hub
	["inspect_hittransmission1",localize"STR_INTSECT_INSPTRANS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hittransmission1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Transmission
	["inspect_hitfuel1",localize"STR_INTSECT_INSPFUEL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitfuel1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Fuel
	["inspect_hitgear1",format [localize"STR_INTSECT_INSPGEAR",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitgear1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Gear #1
	["inspect_hitgear2",format [localize"STR_INTSECT_INSPGEAR",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitgear2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Gear #2
	["inspect_hitgear3",format [localize"STR_INTSECT_INSPGEAR",3],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitgear3" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Gear #3
	["inspect_hitgear4",format [localize"STR_INTSECT_INSPGEAR",4],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitgear4" IN (player_objIntersect getVariable "Inspection"))}],//Inspect Gear #4
	["inspect_hithstabilizerl11",format [localize"STR_INTSECT_INSPHORSTAB",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithstabilizerl11" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Horizontal stabilizer #1
	["inspect_hithstabilizerr11",format [localize"STR_INTSECT_INSPHORSTAB",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithstabilizerr11" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Horizontal stabilizer #2
	["inspect_hitlight1",localize "STR_INTSECT_INSPLL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitlight1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Landing Light
	["inspect_hitpitottube1",format [localize"STR_INTSECT_INSPPTUB",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitpitottube1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Pitot Tube #1
	["inspect_hitpitottube2",format [localize"STR_INTSECT_INSPPTUB",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitpitottube2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Pitot Tube #2
	["inspect_hitstaticport1",format [localize"STR_INTSECT_INSPSTP",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitstaticport1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Static Port #1
	["inspect_hitstaticport2",format [localize"STR_INTSECT_INSPSTP",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitstaticport2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Static Port #2
	["inspect_hitvstabilizer11",localize"STR_INTSECT_INSPVERSTAB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitvstabilizer11" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Vertical Stabilizer
	["inspect_intake1",format [localize"STR_INTSECT_INSPINT",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_intake1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Intake #1
	["inspect_intake2",format [localize"STR_INTSECT_INSPINT",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_intake2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Intake #2

	["hatchl","Toggle Left Engine Hatch",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!(player_objIntersect getVariable ["locked",true]))}], //Open Left Engine Hatch
	["hatchr","Toggle Right Engine Hatch",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!(player_objIntersect getVariable ["locked",true]))}], //Open Right Engine Hatch

	//bargate
	["button_bargate2",localize"STR_INTSECT_OPCLBARG",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Bargate
	["button_bargate1",localize"STR_INTSECT_OPCLBARG",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Bargate
	["Virtual_Storage",localize"STR_INTSECT_ACCVIRSTOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Access virtual storage

	// Common
	["Body",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Repair",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["collision_lights",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Collision Lights
	["ignition",localize"STR_INTSECT_IGNITION",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Ignition
	["lightswitch",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Head Lights
	["collision_lights2",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Collision Lights
	["ignition2",localize"STR_INTSECT_IGNITION",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Ignition
	["lightswitch2",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Head Lights
	["collision_lights3",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Collision Lights
	["ignition3",localize"STR_INTSECT_IGNITION",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Ignition
	["lightswitch3",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Head Lights
	["collision_lights4",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Collision Lights
	["ignition4",localize"STR_INTSECT_IGNITION",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Ignition
	["lightswitch4",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Head Lights
	["Door_RF",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(player_objintersect isKindOf "Air") && {(vehicle player == player)} && {!(player_objIntersect getVariable ["locked",true])} && (!(player getVariable ["Cuffed",true]) && !(player getVariable ["Zipped",true]))}], //Enter as Driver
	["Door_LF",localize"STR_INTSECT_ENTCOPIL","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(player_objintersect isKindOf "Air") && (vehicle player == player) && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Co-Pilot
	["Door_LF",localize"STR_INTSECT_ENTERDRIVER",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])} && (!(player getVariable ["Cuffed",true]) && !(player getVariable ["Zipped",true]))}], //Enter as Driver
	["Door_LF",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])} && {((typeof player_objintersect == "A3PL_Goose_Base") || (typeof player_objintersect == "A3PL_Goose_USCG"))}}], //Enter as Passenger
	//boats
	["ship_driver",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])} && (!(player getVariable ["Cuffed",true]) && !(player getVariable ["Zipped",true]))}],	//Enter as Driver
	["ship_driver",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["ship_passenger",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}],	//Enter as Passenger	//Enter as Passenger
	["ship_passenger",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors

	//drill trailer
	["lever_drillarm",localize"STR_INTSECT_REDRARM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Retract/Extend Drill Arm
	["lever_drill",localize"STR_INTSECT_REDRARMD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Retract/Extend Drill

	//pumpjack start
	["pumpjack_connect",localize"STR_INTSECT_STARTJPUMP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Start Jack Pump

	//Ski
	["ski",localize"STR_INTSECT_ATTDETROPE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeOf player_objintersect == "A3PL_Ski_Base"}], //Attach/Detach Rope
	["ski",localize"STR_INTSECT_PUSKI",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeOf player_objintersect == "A3PL_Ski_Base"}], //pickup ski

	//police things
	["spine3",localize"STR_INTSECT_HANDTICKET","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{(player_ItemClass == "ticket") && {(isPlayer player_objintersect)}}], //Hand Ticket

	//ATM
	["Start",localize"STR_INTSECT_UseDistributor",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) isEqualTo 'A3PL_John_ATM'}],

	//Casino
	["playpoker",localize"STR_INTSECT_CasinoPlayPoker",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'Land_A3FL_Poker_P'}],
	["sit01",localize"STR_INTSECT_CasinoSit01",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'Land_A3FL_Poker_P'}],
	["sit02",localize"STR_INTSECT_CasinoSit02",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'Land_A3FL_Poker_P'}],
	["sit03",localize"STR_INTSECT_CasinoSit03",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'Land_A3FL_Poker_P'}],
	["sit04",localize"STR_INTSECT_CasinoSit04",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'Land_A3FL_Poker_P'}],
	["sit05",localize"STR_INTSECT_CasinoSit05",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'Land_A3FL_Poker_P'}],
	["sit06",localize"STR_INTSECT_CasinoSit06",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'Land_A3FL_Poker_P'}],
	["sit07",localize"STR_INTSECT_CasinoSit07",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'Land_A3FL_Poker_P'}],
	["sit08",localize"STR_INTSECT_CasinoSit08",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'Land_A3FL_Poker_P'}],

	//Generator
	["generator_start",localize"STR_INTSECT_GENERATORONOFF",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'A3PL_Generator'}],
	["generator_fuel",localize"STR_INTSECT_GENERATORFUEL",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'A3PL_Generator'}],

	//BodyDead
	["takebody",localize"STR_INTSECT_TAKEBODY",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'A3PL_BodyDead'}],
	["takebody","Secure Gang Hideout",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((typeOf player_objintersect) == 'A3PL_BodyDead') && (player getVariable ["job","unemployed"] IN ["fisd","uscg"])}],
	["takebody",localize"STR_INTSECT_HIDEOUTSHOP",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(typeOf player_objintersect) == 'A3PL_BodyDead'}],

	["spine3",localize"STR_QuickActionsNPC_TalkToTheMcFishersEmpl",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_mcfisher,npc_mcfisher_1,npc_mcfisher_2,npc_mcfisher_3,npc_mcfisher_4]}],
	["spine3",localize"STR_QuickActionsNPC_TakeMcFishersUniform",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_mcfisher,npc_mcfisher_1,npc_mcfisher_2,npc_mcfisher_3,npc_mcfisher_4]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToThePhoneOperator",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_phone_operator}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheDoctorWithoutDiploma",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_medicaldirty,npc_medicaldirty_N]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheDoctorGuard",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_emt,npc_emt_1,NPC_emt_2,NPC_emt_3,npc_emt_4]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheBankEmployee",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_bank,npc_bank_1,npc_bank_2,npc_bank_3,npc_bank_4,npc_bank_5]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheFreight",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_freight_svt,npc_freight_nd,npc_freight_lubbock]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToInsurer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_insurance,npc_insurance_1,npc_insurance_2]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToPort",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_port_1,npc_port_2,npc_port_3,npc_port_4,npc_port_5,npc_port_6]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToUSCGOfficer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_uscg,npc_uscg_1]}],
	["spine3",localize"STR_QuickActionsNPC_WeaponIllegalShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_illegal_eq]}],
	["spine3",localize"STR_QuickActionsNPC_AccessPrisonShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_farmer_1]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheFisherMan",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_fisher,npc_farmer_1,npc_farmer_2]}],
	["spine3",localize"STR_QuickActionsNPC_GoodsFactory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_goodsfactory,npc_goodsfactory_n]}],
	["spine3",localize"STR_QuickActionsNPC_VehiclesFactory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_vehiclefactory}],
	["spine3",localize"STR_QuickActionsNPC_AccessChemicalPlant",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_chimicalfactory}],
	["spine3",localize"STR_QuickActionsNPC_AccessFactoryLegalArms",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_factionweaponfactory}],
	["spine3",localize"STR_QuickActionsNPC_WeaponIllegalFactory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_weaponfactory_1)}],
	// ["spine3",localize"STR_QuickActionsNPC_VehiclePartsFactory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_piecevehiclefactory}],
	["spine3",localize"STR_QuickActionsNPC_FactoryBoat",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_boatfactory}],
	["spine3",localize"STR_QuickActionsNPC_AirbuyFactory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_aircraftfactory}],
	["spine3",localize"STR_QuickActionsNPC_RentATowTruck",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_roadworker,npc_roadworker_1,npc_roadworker_2,npc_roadworker_3,npc_roadworker_4]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheRoadService2",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_roadworker,npc_roadworker_1,npc_roadworker_2,npc_roadworker_3,npc_roadworker_4]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheFermer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_farmer,npc_farmer_1,npc_farmer_2,npc_farmer_N]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheOilExtractor",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_oilrecovery}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheTacoHellEmpl",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_tacohell,npc_tacohell_1,npc_tacohell_2,npc_tacohell_3,npc_tacohell_4]}],
	["spine3",localize"STR_QuickActionsNPC_TakeTacoHellUniform",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_tacohell,npc_tacohell_1,npc_tacohell_2,npc_tacohell_3,npc_tacohell_4]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheDrugDealer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_drugsdealer}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheBlackMarket",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_blackmarket}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheGunsVendor",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_shopguns}],
	["spine3",localize"STR_QuickActionsNPC_TalkToExterminator",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_exterminatorjob}],
	["spine3",localize"STR_QuickActionsNPC_ExterminatorShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_exterminatorjob}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheSupermarket",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_supermarket_1,npc_supermarket_N]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheSupermarket2",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_supermarket_2]}],
	["spine3",localize"STR_QuickActionsNPC_SpeaktoAdherent",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkshop]}],
	["spine3",localize"STR_QuickActionsNPC_SpeaktoThingsPerk",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkthingshop]}],
	["spine3","Big Dicks Sports Store",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_big_dicks_sports]}],
	//["spine3",localize"STR_QuickActionsNPC_ReadDecrees",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_government)}],

	["spine3",localize"STR_QuickActionsNPC_GamerPerkShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkfurniture,npc_furniture_7,npc_perkfurniture_3,npc_perkfurniture_6]}],
	["spine3",localize"STR_QuickActionsNPC_GardenPerkShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkfurniture,npc_furniture_7,npc_perkfurniture_3,npc_perkfurniture_6]}],
	["spine3",localize"STR_QuickActionsNPC_MancavePerkShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkfurniture,npc_furniture_7,npc_perkfurniture_3,npc_perkfurniture_6]}],
	["spine3",localize"STR_QuickActionsNPC_WalldecorPerkShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkfurniture,npc_furniture_7,npc_perkfurniture_3,npc_perkfurniture_6]}],
	["spine3",localize"STR_QuickActionsNPC_WinchesterPerkShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkfurniture,npc_furniture_7,npc_perkfurniture_3,npc_perkfurniture_6]}],

	["spine3",localize"STR_QuickActionsNPC_AccessMinerShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_miningmike]}],
	["spine3",localize"STR_QuickActionsNPC_BuyMapIron",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_miningmike]}],
	["spine3",localize"STR_QuickActionsNPC_BuyMapCharcoal",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_miningmike]}],
	["spine3",localize"STR_QuickActionsNPC_BuyMapAluminium",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_miningmike]}],
	["spine3",localize"STR_QuickActionsNPC_BuyMapSulfur",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_miningmike]}],
	["spine3",localize"STR_QuickActionsNPC_BuyMapOil",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_miningmike]}],

	["spine3",localize"STR_QuickActionsNPC_OpenBusiness",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_government) && {!([getPlayerUID player] call A3PL_Config_InCompany)}}],
	["spine3",localize"STR_QuickActionsNPC_BusinessManagement",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_government) && {([getPlayerUID player] call A3PL_Config_IsCompanyBoss)}}],
	["spine3",localize"STR_QuickActionsNPC_ResignCompany",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect isEqualTo npc_government) && {!([getPlayerUID player] call A3PL_Config_IsCompanyBoss)} && {([getPlayerUID player] call A3PL_Config_InCompany)}}],
	["spine3",localize"STR_QuickActionsNPC_EnterpriseAccountManagment",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect IN [npc_bank,npc_bank_1,npc_bank_2,npc_bank_3,npc_bank_4]) && {([getPlayerUID player] call A3PL_Config_IsCompanyBoss)}}],
	["spine3",localize"STR_QuickActionsNPC_FactionAccount",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_government) && ([(player getVariable['faction','citizen'])] call A3PL_Government_isFactionLeader)}],
	["spine3",localize"STR_QuickActionsNPC_FISecurityService",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_sfp_sign}],
	["spine3",localize"STR_QuickActionsNPC_SFPShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_sfp_sign}],
	["spine3",localize"STR_QuickActionsNPC_AccessVetements",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_clothing_factory)}],
	["spine3",localize"STR_QuickActionsNPC_AccessVetementsLunettes",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_clothing_factory)}],
	["spine3",localize"STR_QuickActionsNPC_AccessVetementsVestes",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_clothing_factory)}],
	["spine3",localize"STR_QuickActionsNPC_AccessVetementsChapeaux",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_clothing_factory)}],
	["spine3",localize"STR_QuickActionsNPC_AccessAcierie",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_fonderie)}],
	["spine3",localize"STR_QuickActionsNPC_AccessFoodFactory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_usinealimentaire,npc_foodfact_N]}],
	["spine3",localize"STR_QuickActionsNPC_AccessFoodFactory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect isEqualTo npc_doc) && (player getVariable ["jailed",false])}],
	["spine3",localize"STR_QuickActionsNPC_OilRefinery",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_oilraffinerie)}],
	//["spine3",localize"STR_QuickActionsNPC_VehiclesFactionFactory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_vehiclefactionfactory)}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheHunter",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_hunting}],
	["spine3",localize"STR_INTSECT_OPIMEXMENU",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_import}], //Open Import/Export Menu
	["spine3",localize"STR_INTSECT_CONVSTOLMONEY",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_moneylaunderer}], //Convert stolen money
	["spine3",localize"STR_QuickActionsNPC_CCTVSilverton",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_Cameras_1}],
	["spine3",localize"STR_QuickActionsNPC_CCTVElk",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_Cameras_2}],
	["spine3",localize"STR_QuickActionsNPC_CCTVCentral",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_Cameras_3}],
	["spine3",localize"STR_QuickActionsNPC_CCTVNorthdale",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_Cameras_4}],
	["spine3",localize"STR_QuickActionsNPC_ResellNearVehicle",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_chopshop}], //Chop Vehicle
	["spine3",localize"STR_QuickActionsNPC_RemoveElectronicBracelet",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_Big_Weapon_Dealer}],

	//shops
	["spine3",localize"STR_INTSECT_CAPTSHIP",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect isEqualTo npc_captureship}],
	["spine3",localize"STR_QuickActionsNPC_CatpuredShip",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect isEqualTo npc_captureship}],
	["spine3",localize"STR_QuickActionsNPC_AccessShopSupply",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_furniture_4,npc_furniture_6,npc_perkfurniture_1,npc_perkfurniture_4]}],
	["spine3",localize"STR_QuickActionsNPC_AccessShopSupply2",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_furniture_3,npc_furniture_5,npc_perkfurniture_2,npc_perkfurniture_5]}],
	["spine3",localize"STR_QuickActionsNPC_AccessGeneralShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_general_1,NPC_general_2,NPC_general_3,NPC_general_4]}],
	["spine3",localize"STR_QuickActionsNPC_PaintBallShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_pinhead]}],
	["spine3",localize"STR_QuickActionsNPC_Store",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_Buckeye_1]}],
	["spine3","Moonshine Trader",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_Buckeye]}],
	["spine3",localize"STR_QuickActionsNPC_BucheronShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_Hemlock]}],
	["spine3",localize"STR_QuickActionsNPC_AccessShopWaste",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_WasteManagement,NPC_WasteManagement_1]}],
	["spine3",localize"STR_QuickActionsNPC_StartStopWaste",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_WasteManagement,NPC_WasteManagement_1]}],
	["spine3",localize"STR_QuickActionsNPC_StartStopDelivery",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_mailman,npc_mailman_stoney,npc_mailman_northdale,npc_mailman_beachV,npc_mailman_lubbock]}],
	["spine3",localize"STR_QuickActionsNPC_MailManShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_mailman,npc_mailman_stoney,npc_mailman_northdale,npc_mailman_beachV,npc_mailman_lubbock]}],
	["spine3",localize"STR_QuickActionsNPC_KartRent",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_Karts]}],
	["spine3","Chemical Dealer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_chemicaldealer}],

	["spine3","Talk to the Ship Captain",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_ship_captain,npc_ship_captain_1,npc_ship_captain_2]}],

	//Rob Stores
	["spine3",localize"STR_QuickActionsNPC_RobShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect IN [Robbable_Shop_1,Robbable_Shop_2,Robbable_Shop_3,Robbable_Shop_4,Robbable_Shop_5])}],
	["spine3",localize"STR_QuickActionsNPC_SecureShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect IN [Robbable_Shop_1,Robbable_Shop_2,Robbable_Shop_3,Robbable_Shop_4,Robbable_Shop_5]) && {((player getVariable ["job","unemployed"]) IN ["security"])}}],

	["spine3",localize"STR_QuickActionsNPC_AccessHardwareShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_hardware_1]}],
	["spine3",localize"STR_QuickActionsNPC_AccessSeedShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_Seed_Store,NPC_Seed_Store_N]}],
	["spine3",localize"STR_QuickActionsNPC_AccessShopGems",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_gemshop]}],
	["spine3",localize"STR_QuickActionsNPC_BuySellHalloweenItems",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_candy]}],
	["spine3",localize"STR_QuickActionsNPC_BuySellChristmasItems",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_christmas]}],
	["spine3",localize"STR_QuickActionsNPC_AccessShopFIMS",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_fifr_supplier, NPC_fifr_supplier_1, NPC_fifr_supplier_2, NPC_fifr_supplier_3, NPC_fifr_supplier_air, NPC_fifr_supplier_4]}],
	["spine3",localize"STR_QuickActionsNPC_AccessShopFIFR",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == NPC_fifr_supplier2) || (player_objintersect == NPC_fifr_supplier3) || (player_objintersect == NPC_fifr_supplier2_1) || (player_objintersect == NPC_fifr_supplier2_2)}],
	["spine3",localize"STR_QuickActionsNPC_AccessShopVFD",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == NPC_fifr_supplier2) || (player_objintersect == NPC_fifr_supplier3) || (player_objintersect == NPC_fifr_supplier2_1) || (player_objintersect == NPC_fifr_supplier2_2)}],
	["spine3",localize"STR_QuickActionsNPC_AccessFIFRVEHShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_fifr_vehicles,npc_fifr_vehicles_elk]}],
	["spine3",localize"STR_QuickActionsNPC_AccessUSCGVehShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_uscg_vehicles,NPC_uscg_vehicles_1]}],
	["spine3",localize"STR_QuickActionsNPC_AccessUSCGBoatShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_uscg_boats}],
	["spine3",localize"STR_QuickActionsNPC_AccessUSCGAirShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_uscg_aircraft,NPC_uscg_aircraft_1]}],
	["spine3",localize"STR_QuickActionsNPC_AccessFIFRAirShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_faa_vehicles}],
	["spine3",localize"STR_QuickActionsNPC_AccessUSCGShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_uscg_supplier,NPC_uscg_supplier_1]}],
	["spine3",localize"STR_QuickActionsNPC_AccessUSCGArmory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_uscg_supplier_2, NPC_uscg_supplier_4]}],
	["spine3",localize"STR_QuickActionsNPC_AccessUSCGPilotShop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_uscg_supplier_3,NPC_uscg_supplier_5]}],
	["spine3",localize"STR_QuickActionsNPC_TalkToTheDMVNPC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_dmv}],

	["spine3",localize"STR_QuickActionsNPC_PriseServiceUSMS",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_usmsshop_1}],
	["spine3",localize"STR_QuickActionsNPC_TalkToSheriff",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_sd_silverton_1,npc_sd_elk,npc_sd_elk1,npc_sd_nd,npc_sd_lubbock]}],
	["spine3",localize"STR_QuickActionsNPC_PriseServiceDOJ",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_doj}],

	["spine3",localize"STR_QuickActionsNPC_ATCManager",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_faastart}],
	["spine3",localize"STR_QuickActionsNPC_ATCExit",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_faastop}],
	["spine3",localize"STR_QuickActionsNPC_OpenRadar",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_faa_supplier}],
	["spine3",localize"STR_QuickActionsNPC_TakeRadio",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_faa_supplier}],

	["spine3",localize"STR_QuickActionsNPC_AccessWeaponsDOC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_usmsshop}],
	["spine3",localize"STR_QuickActionsNPC_AccessSDWeaponsFISD",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_sd_silverton, npc_sd_northdale,npc_sd_elk_shop,npc_sd_lubbock_shop]}],
	["spine3",localize"STR_QuickActionsNPC_AccessUSMSCarVendor",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_usms_vehicles}],
	["spine3",localize"STR_QuickActionsNPC_AccessFISDCarVendor",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_sd_vehicles,npc_sd_vehicles_1,npc_sd_vehicles_2]}],
	["spine3",localize"STR_QuickActionsNPC_AccessFISDSuppliesVendor",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_sd_silverton,npc_sd_northdale,npc_sd_elk_shop,npc_sd_lubbock_shop]}],
	["spine3",localize"STR_QuickActionsNPC_FakeID",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect IN [npc_sd_silverton,npc_sd_northdale,npc_sd_elk_shop,npc_sd_lubbock_shop]) && {(player getVariable["FakeIDAccess",false])} && {(player getVariable["faction","civlian"] == "fisd")}}],
	["spine3",localize"STR_QuickActionsNPC_AccessDOJSuppliesVendor",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_doj}],
	["spine3",localize"STR_QuickActionsNPC_AccessDMVSuppliesVendor",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_dmv}],
	["spine3",localize"STR_QuickActionsNPC_AccessUSMSSuppliesVendor",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_usmsshop}],
	["spine3",localize"STR_QuickActionsNPC_AccessDMVCarVendor",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_dmv_vehicles}],

	["spine3",localize"STR_QuickActionsNPC_FIFDManagment",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == NPC_fifr_supplier2_1) && {(["fifr"] call A3PL_Government_isFactionLeader)}}],
	["spine3",localize"STR_QuickActionsNPC_USCGManagment",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == NPC_uscg_supplier) && {(["uscg"] call A3PL_Government_isFactionLeader)}}],
	["spine3",localize"STR_QuickActionsNPC_FISDManagment",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect IN [npc_sd_silverton_1,npc_sd_elk_shop]) && {(["fisd"] call A3PL_Government_isFactionLeader)}}],
	["spine3",localize"STR_QuickActionsNPC_DMVManagment",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_dmv) && {(["dmv"] call A3PL_Government_isFactionLeader)}}],
	["spine3",localize"STR_QuickActionsNPC_DOJManagment",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_doj) && {(["doj"] call A3PL_Government_isFactionLeader)}}],
	["spine3",localize"STR_QuickActionsNPC_USMSManagment",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect == npc_usmsshop_1) && {(["usms"] call A3PL_Government_isFactionLeader)}}],
	["spine3","Low End Car Dealer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [Low_End_Car_Shop]}],

	//bank drill
	["pilecash",localize"STR_INTSECT_STVAULTMON",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Steal Vault Money --- pilecash
	["Door_bankvault",localize"STR_INTSECT_CONVAULTDRI",_dir+"IGUI\Cfg\Actions\take_ca.paa",{backpack player == "A3PL_Backpack_Drill"}], //Connect Vault Drill
	["Door_bankvault",localize"STR_INTSECT_SECVAULTD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable "job") IN ["uscg","fisd","usms"])}], //Secure Vault Door
	["drill_bit_install",localize"STR_INTSECT_INSTDRLBIT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "drill_bit"}], //Install Drill Bit
	["drill_handle",localize"STR_INTSECT_STARTVDRILL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Start Vault Drill
	["drill_handle",localize"STR_INTSECT_DISSDRILL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Dissemble Drill
	["deposit_1",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_2",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_3",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_4",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_5",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_6",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_7",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_8",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_9",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_10",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_11",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_12",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_13",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_14",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_15",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_16",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_17",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_18",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_19",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box
	["deposit_20",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect animationSourcePhase "door_bankvault") > 0.95)}], //Open Deposit Box


	["vault_door",localize"STR_INTSECT_SECVAULTD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable "job") IN ["uscg","fisd","usms"]) && ((player_objIntersect getVariable ["CanOpenSafe",false]) isEqualTo true)}], //Secure Vault Door
	["vault_door","Open/Close Safe",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objIntersect getVariable ["CanOpenSafe",false])}],
	["Vault_Lock",localize"STR_INTSECT_CONVAULTDRI",_dir+"IGUI\Cfg\Actions\take_ca.paa",{backpack player == "A3PL_Backpack_Drill"}], //Connect Vault Drill

	["jewelry_3_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || (["keycard",1] call A3PL_Inventory_Has)}], //Use Door Button
	["jewelry_3_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || (["keycard",1] call A3PL_Inventory_Has)}], //Use Door Button
	["jewelry_4_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || (["keycard",1] call A3PL_Inventory_Has)}], //Use Door Button
	["jewelry_4_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || (["keycard",1] call A3PL_Inventory_Has)}], //Use Door Button
	["jewelry_5_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || (["keycard",1] call A3PL_Inventory_Has)}], //Use Door Button
	["jewelry_5_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || (["keycard",1] call A3PL_Inventory_Has)}], //Use Door Button

	["case_break_1","Break Glass",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],

	//ATM
	["ATM",localize"STR_INTSECT_USEATM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Use ATM
	["dogcage",localize"STR_INTSECT_OPK9MEN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]}],

	//mcfishers
	["mcfishergrill",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["mcfishergrill",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["mcfishergrill",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["mcfishergrill",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item
	["mcfishertable",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["mcFishersTable1",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["mcFishersTable2",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["mcfishergrill",localize"STR_INTSECT_PLACEBURGER","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Burger
	["mcFishersGrill1",localize"STR_INTSECT_PLACEBURGER","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Burger
	["mcFishersGrill2",localize"STR_INTSECT_PLACEBURGER","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Burger

	//fisherman
	["net",localize"STR_INTSECT_BUSENET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Net
	["buoy",localize"STR_INTSECT_COLLNET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["fishstate",-1]) == -1)}], //Collect Net
	["buoy",localize"STR_INTSECT_DEPLNET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(simulationEnabled player_objIntersect) && {((player_objintersect getVariable ["fishstate",-1]) == -1)}}], //Deploy Net
	["buoy",localize"STR_INTSECT_BaitNet",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(simulationEnabled player_objIntersect) && {((player_objintersect getVariable ["fishstate",-1]) > -1)}}], //Bait Net
	["bucket",localize"STR_INTSECT_BUSEBUCK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Bucket

	//harvest
	["farmingplant",localize"STR_INTSECT_HARPLANT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Harvest Plant
	["plant_cannabis",localize"STR_INTSECT_HARPLANT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Harvest Plant
	["lettuce",localize"STR_INTSECT_HARPLANT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objintersect getVariable ["growState",-1] != -1}], //Harvest Plant

	//Buying tickets for lottery system
	["EstateSign",localize"STR_INTSECT_BUYHOUSE",_dir+"IGUI\Cfg\Actions\settimer_ca.paa",{(((getObjectTextures player_objintersect) select 0) isEqualTo "a3pl_objects\street\estate_sign\house_sale_co.paa")}],
	["EstateSign",localize"STR_INTSECT_SELLHOUSE",_dir+"IGUI\Cfg\Actions\settimer_ca.paa",{(((getObjectTextures player_objintersect) select 0) isEqualTo "a3pl_objects\street\estate_sign\house_rented_co.paa")}],
	["EstateSign",localize"STR_INTSECT_LEAVHOUSE",_dir+"IGUI\Cfg\Actions\settimer_ca.paa",{((((getObjectTextures player_objintersect) select 0) isEqualTo "a3pl_objects\street\estate_sign\house_rented_co.paa")) && {(getPlayerUID player) IN (player_objintersect getVariable['roommates',[]])}}],

	//signs
	["greenhousesign",localize"STR_INTSECT_RENTGH",_dir+"IGUI\Cfg\Actions\settimer_ca.paa",{true}], //Rent Greenhouse
	["sign_business",localize"STR_INTSECT_RENTBUSI",_dir+"IGUI\Cfg\Actions\settimer_ca.paa",{!(count nearestObjects[player,Config_Warehouses_List,15] > 0)}], //Rent Business
	["sign_business","Purchase Warehouse",_dir+"IGUI\Cfg\Actions\settimer_ca.paa",{count nearestObjects[player,Config_Warehouses_List,15] > 0}], //Rent Business

	//FD interactions
	//interactions on adapter ends
	["fd_hoseend",localize"STR_INTSECT_CONROLHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_ItemClass == "FD_hose") && {(typeOf player_objintersect == "A3PL_FD_HoseEnd1_Float")}}], //Connect Rolled Hose
	["fd_hoseend",localize"STR_INTSECT_CONHOSETAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && {(typeOf player_objintersect == "A3PL_FD_HoseEnd1_Float")}}], //hose to hydrant adapter || Connect Hose To Adapter
	["fd_hoseend",localize"STR_INTSECT_CONHOSETAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && {(typeOf player_objintersect IN ["A3PL_FD_HoseEnd1"])}}], //hose adapter to hose adapter ||Connect Hose To Adapter
	["fd_hoseend",localize"STR_INTSECT_HOLDHOSEAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Hold Hose Adapter
	["fd_hoseend",localize"STR_INTSECT_RollupHose",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}],

	//Y-adapter
	["fd_yadapter_in",localize"STR_INTSECT_CONHOSETIN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_FD_yAdapter") && {((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}}], //Connect Hose To Inlet
	["fd_yadapter_out1",localize"STR_INTSECT_CONHOSETIN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_FD_yAdapter") && {((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}}], //Connect Hose To Inlet
	["fd_yadapter_out2",localize"STR_INTSECT_CONHOSETOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_FD_yAdapter") && {((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}}], //Connect Hose To Outlet

	//tanker,gas station
	["outlet_4",localize"STR_INTSECT_CONHOSETTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && {(typeOf player_objintersect == "A3PL_Tanker_Trailer")}}], //Connect Hose To Tanker
	["outlet_3",localize"STR_INTSECT_CONHOSETTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && {(typeOf player_objintersect == "A3PL_Tanker_Trailer")}}], //Connect Hose To Tanker
	["outlet_2",localize"STR_INTSECT_CONHOSETTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && {(typeOf player_objintersect == "A3PL_Tanker_Trailer")}}], //Connect Hose To Tanker
	["outlet_1",localize"STR_INTSECT_CONHOSETTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && {(typeOf player_objintersect == "A3PL_Tanker_Trailer")}}], //Connect Hose To Tanker
	["outlet_1",localize"STR_INTSECT_CONHOSETTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && {(typeOf player_objintersect == "A3PL_Fuel_Van")}}], //Connect Hose To Tanker
	["gas_hoseconnect",localize"STR_INTSECT_CONHOSEADAP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_ItemClass == "FD_adapter") && {(typeOf player_objintersect == "Land_A3PL_Gas_Station")}}], //Connect Hose Adapter
	["gas_hoseswitch",localize"STR_INTSECT_SWITCHGASSTORSW",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //localize"STR_INTSECT_SWITCHGASSTORSW"

	//fire hydrant
	["hydrant_connect",localize"STR_INTSECT_CONHOSEADAP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_ItemClass == "FD_adapter") && {(typeOf player_objintersect == "Land_A3PL_FireHydrant")}}], //Connect Hose Adapter
	["hydrant_wrench",localize"STR_INTSECT_CONHYDWRE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_ItemClass == "FD_hydrantwrench") && {(typeOf player_objintersect == "Land_A3PL_FireHydrant")}}], //Connect Hydrant Wrench

	//wrench itself
	["hydrantwrench",localize"STR_INTSECT_OPENHYDR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_FD_HydrantWrench_F") && {(player_objintersect animationSourcePhase "WrenchRotation" < 0.5)}}], //Open Hydrant
	["hydrantwrench",localize"STR_INTSECT_CLOSEHYDR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_FD_HydrantWrench_F") && {(player_objintersect animationSourcePhase "WrenchRotation" > 0.5)}}], //Close Hydrant

	//ladder truck
	["inlet_r", localize"STR_INTSECT_CONHOSETOLADIN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Ladder Inlet

	//engine truck
	["inlet_ds", localize"STR_INTSECT_CONHOSETOENGIN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Engine Inlet
	["inlet_bt", localize"STR_INTSECT_CONHOSETOENGIN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Engine Inlet
	["ft_lever_11",localize"STR_INTSECT_OPCLINLET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["bt_lever_1",localize"STR_INTSECT_OPCLINLET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["ft_lever_10",localize"STR_INTSECT_OPCLDISCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["bt_lever_2",localize"STR_INTSECT_OPCLDISCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["ft_lever_8",localize"STR_INTSECT_OPCLINLET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["ft_lever_7",localize"STR_INTSECT_OPCLDISCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["ft_lever_1",localize"STR_INTSECT_OPCLDISCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["bt_lever_3",localize"STR_INTSECT_OPCLDISCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["outlet_ps",localize"STR_INTSECT_CONHOSETOENGDIS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //discharges ||Connect Hose To Engine Discharge
	["outlet_ds",localize"STR_INTSECT_CONHOSETOENGDIS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Engine Discharge
	["outlet_1",localize"STR_INTSECT_CONHOSETOENGDIS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //discharges ||Connect Hose To Engine Discharge
	["outlet_2",localize"STR_INTSECT_CONHOSETOENGDIS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Engine Discharge
	["outlet_bt_1",localize"STR_INTSECT_CONHOSETOENGDIS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //discharges ||Connect Hose To Engine Discharge
	["outlet_bt_2",localize"STR_INTSECT_CONHOSETOENGDIS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Engine Discharge

	["burger",localize"STR_INTSECT_CREATEFISHB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{_burgers = nearestObjects [player_objIntersect, ["A3PL_Burger_Bun"], 1]; (count _burgers) > 0}], //Create Fish Burger
	["tacoshell",localize"STR_INTSECT_CREATEFTACO",_dir+"IGUI\Cfg\Actions\take_ca.paa",{_burgers = nearestObjects [player_objIntersect, ["A3PL_Fish_Raw","A3PL_Fish_Cooked","A3PL_Fish_Burned"], 1]; _salads= nearestObjects [player_objIntersect, ["A3PL_Salad"], 1]; ((count _burgers) > 0) && ((count _salads) > 0)}], //Create Fish Taco
	["burgerbread",localize"STR_INTSECT_CREATEFISHB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{_burgers = nearestObjects [player_objIntersect, ["A3PL_Burger_Raw","A3PL_Burger_Cooked","A3PL_Burger_Burnt"], 1]; (count _burgers) > 0}], //Create Fish Burger
	["clothes",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!(isNil {player_objIntersect getVariable "stock"}))}], //Buy/Sell Item

	["handcuffs",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["handcuffs",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["handcuffs",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["handcuffs",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item

	["wrench",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!(isNil {player_objIntersect getVariable "stock"}))}], //Buy/Sell Item
	["housekey",localize"STR_INTSECT_PICKUPKEY",_dir+"IGUI\Cfg\Actions\take_ca.paa",{isNull (attachedTo player_objintersect)}], //Pickup Key

	//retrievals
	["carInfo",localize"STR_INTSECT_VEHSTOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!isNil {player_objIntersect getVariable "positionSpawn"}}], //Vehicle Storage
	["carInfo",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!isNil {player_objIntersect getVariable "positionSpawn"}}], //Store Vehicle

	//aircraft paint
	["carInfo",localize"STR_INTSECT_PAINTAIRC",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objIntersect == AircraftPaint}], //Paint Aircraft
	//["carInfo",localize"STR_INTSECT_STOREAIRC",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objIntersect == AircraftStore}], //Store Aircraft
	["carInfo",localize"STR_INTSECT_STOREAIRC",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objIntersect == AircraftStore_1}], //Store Aircraft

	//city hall
	["Door_8_button1",localize"STR_INTSECT_OPCLDEFROOM",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((player getVariable "job") IN ["uscg","fisd","usms"])}], //Open/Close Defendant Room
	["Door_8_button2",localize"STR_INTSECT_OPCLDEFROOM",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((player getVariable "job") IN ["uscg","fisd","usms"])}], //Open/Close Defendant Room
	["spine3",localize"STR_INTSECT_OPTREASINF",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objIntersect isEqualTo npc_government_2) && {(["fbi"] call A3PL_Government_isFactionLeader)}}],

	//Sheriff DP
	["jailDoor_1",localize"STR_INTSECT_OPCLJAILD",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]}], //Open/Close Jail Door
	["jailDoor_2",localize"STR_INTSECT_OPCLJAILD",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]}], //Open/Close Jail Door
	["jailDoor_3",localize"STR_INTSECT_OPCLJAILD",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]}], //Open/Close Jail Door
	//prison/PD
	["Door_1_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_1_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_2_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_2_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_3_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_3_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_4_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_4_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_5_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_5_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_6_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_6_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_7_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_7_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_8_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_8_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_9_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_9_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_10_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_10_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_11_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_11_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_12_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_12_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_13_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_13_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_14_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_14_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_15_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_15_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_16_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_16_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_22_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_22_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_23_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_23_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_24_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_25_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["Door_26_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"] IN ["uscg","fisd","usms"]) || {(((["keycard",1] call A3PL_Inventory_Has) && {((typeOf cursorObject) != "Land_A3PL_Sheriffpd")}))}}], //Use Door Button
	["hangardoor_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{cursorObject getVariable ["unlocked",false]}], //Use Door Button
	["garageDoor_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor_1_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor_1_source",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor_2_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor1_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor2_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button

	["garageDoor_button",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Spawn vehicle in garage
	["garageDoor_button2",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Spawn vehicle in garage
	["garageDoor_1_button",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Spawn vehicle in garage
	["garageDoor_1_source",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Spawn vehicle in garage
	["garageDoor_2_button",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Spawn vehicle in garage
	["garageDoor1_button",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")} && {((typeOf cursorObject) != "Land_A3PL_Garage")}}], //Spawn vehicle in garage
	["garageDoor2_button",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")} && {((typeOf cursorObject) != "Land_A3PL_Garage")}}], //Spawn vehicle in garage

	["garageDoor_button",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Store Vehicle
	["garageDoor_button2",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Store Vehicle
	["garageDoor_1_button",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Store Vehicle
	["garageDoor_1_source",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Store Vehicle
	["garageDoor_2_button",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Store Vehicle
	["garageDoor1_button",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Store Vehicle
	["garageDoor2_button",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && {(player_objintersect isKindOf "House_f")}}], //Store Vehicle

	["console_cell1",format [localize"STR_INTSECT_OPENCELL",1],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell2",format [localize"STR_INTSECT_OPENCELL",2],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell3",format [localize"STR_INTSECT_OPENCELL",3],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell4",format [localize"STR_INTSECT_OPENCELL",4],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell5",format [localize"STR_INTSECT_OPENCELL",5],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell6",format [localize"STR_INTSECT_OPENCELL",6],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell7",format [localize"STR_INTSECT_OPENCELL",7],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell8",format [localize"STR_INTSECT_OPENCELL",8],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell9",format [localize"STR_INTSECT_OPENCELL",9],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell10",format [localize"STR_INTSECT_OPENCELL",10],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell11",format [localize"STR_INTSECT_OPENCELL",11],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell12",format [localize"STR_INTSECT_OPENCELL",12],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell13",format [localize"STR_INTSECT_OPENCELL",13],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell14",format [localize"STR_INTSECT_OPENCELL",14],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_maincell1",format [localize"STR_INTSECT_OPENMCELL",1],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Main cell %1
	["console_maincell2",format [localize"STR_INTSECT_OPENMCELL",2],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Main cell %1
	["console_maincell3",localize"STR_INTSECT_OPENKCELL",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //open Kitchen Cell
	["console_garage",localize"STR_INTSECT_OPENGARAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Garage
	["console_lockdown",localize"STR_INTSECT_LOCKDOWN",_dir+"IGUI\Cfg\Actions\ico_cpt_col_ON_ca.paa",{true}], //LOCKDOWN!

	//Storage
	["StorageDoor1",localize"STR_INTSECT_VEHSTOR","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Vehicle Storage
	["StorageDoor2",localize"STR_INTSECT_VEHSTOR","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Vehicle Storage
	["StorageDoor3",localize"STR_INTSECT_VEHSTOR","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Vehicle Storage
	["StorageDoor1",localize"STR_INTSECT_STOREVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Vehicle
	["StorageDoor2",localize"STR_INTSECT_STOREVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Vehicle
	["StorageDoor3",localize"STR_INTSECT_STOREVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Vehicle

	// ["StorageDoor1",localize"STR_INTSECT_OBJSTOR","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Object Storage
	// ["StorageDoor2",localize"STR_INTSECT_OBJSTOR","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Object Storage
	// ["StorageDoor3",localize"STR_INTSECT_OBJSTOR","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Object Storage
	// ["StorageDoor1",localize"STR_INTSECT_STOREOBJ","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Object
	// ["StorageDoor2",localize"STR_INTSECT_STOREOBJ","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Object
	// ["StorageDoor3",localize"STR_INTSECT_STOREOBJ","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Object

	//sheriff garage
	["SDStorageDoor3",localize"STR_INTSECT_VEHSTOR","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Vehicle Storage
	["SDStorageDoor6",localize"STR_INTSECT_VEHSTOR","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Vehicle Storage
	["SDStorageDoor3",localize"STR_INTSECT_STOREVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Vehicle
	["SDStorageDoor6",localize"STR_INTSECT_STOREVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Vehicle

	//apt building main doors
	["door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Door
	["door0_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Door

	//apt building appartment front doors
	["apt1_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_1_locked",false])}], //Door
	["apt2_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_2_locked",false])}], //Door
	["apt3_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_3_locked",false])}], //Door
	["apt4_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_4_locked",false])}], //Door
	["apt5_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_5_locked",false])}], //Door
	["apt6_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_6_locked",false])}], //Door
	["apt7_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_7_locked",false])}], //Door
	["apt8_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_8_locked",false])}], //Door
	["apt9_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_9_locked",false])}], //Door
	["apt10_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_10_locked",false])}], //Door
	["apt11_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_11_locked",false])}], //Door
	["apt12_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_12_locked",false])}], //Door

	//gas station
	["gas_openmenu",localize"STR_INTSECT_OPENGASMENU",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],
	["spine3",localize"STR_QuickActionsNPC_TakeFuelStationCash",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objintersect IN [npc_fuel_1,npc_fuel_2,npc_fuel_3,npc_fuel_4,npc_fuel_6,npc_fuel_8,npc_fuel_9,npc_fuel_10,npc_fuel_11,npc_fuel_12]}],
	["gas_openmenu",localize"STR_QuickActionsBuildings_CheckMoneyInCash",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],
	["gas_openmenu",localize"STR_QuickActionsBuildings_TakeFuelStationCash",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],
	["gas_openmenu",localize"STR_QuickActionsBuildings_OpCLoseFuel",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],

	//showroom Garage Doors
	["garage1_open",localize"STR_INTSECT_OPENSHOWDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_A3PL_Showroom"}], //Open Showroom Doors
	["garage1_close",localize"STR_INTSECT_CLOSESHOWDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_A3PL_Showroom"}], //Close Showroom Doors
	["garage2_open",localize"STR_INTSECT_OPENSHOWDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_A3PL_Showroom"}], //Open Showroom Doors
	["garage2_close",localize"STR_INTSECT_CLOSESHOWDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_A3PL_Showroom"}],	 //Close Showroom Doors

	//new doors
	["Door_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_1_locked",false]) && {!(typeOf player_objintersect in ["A3PL_EMS_Locker"])}}], //Door
	["Door_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_2_locked",false])}], //Door
	["Door_3",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_3_locked",false])}], //Door
	["Door_4",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_4_locked",false])}], //Door
	["Door_5",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_5_locked",false])}], //Door
	["Door_6",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_6_locked",false])}], //Door
	["Door_7",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_7_locked",false])}], //Door
	["Door_8",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_8_locked",false])}], //Door
	["Door_9",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_9_locked",false])}], //Door
	["Door_10",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_10_locked",false])}], //Door
	["Door_11",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_11_locked",false])}], //Door
	["Door_12",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_12_locked",false])}], //Door
	["Door_13",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_13_locked",false])}], //Door
	["Door_14",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_14_locked",false])}], //Door
	["Door_15",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_15_locked",false])}], //Door
	["Door_16",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_16_locked",false])}],	 //Door
	["Door_17",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_17_locked",false])}], //Door
	["Door_18",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_18_locked",false])}], //Door
	["Door_19",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_19_locked",false])}], //Door
	["Door_20",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_20_locked",false])}], //Door
	["Door_21",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_21_locked",false])}], //Door
	["Door_22",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_22_locked",false])}], //Door
	["Door_23",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_22_locked",false])}], //Door
	["Door_24",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_24_locked",false])}],	 //Door
	["Door_25",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_25_locked",false])}], //Door
	["Door_26",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_26_locked",false])}], //Door

	["Door_27",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_27_locked",false])}], //Door
	["Door_28",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_28_locked",false])}], //Door
	["Door_29",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_29_locked",false])}], //Door
	["Door_30",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_30_locked",false])}], //Door
	["Door_31",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_31_locked",false])}], //Door
	["Door_32",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_32_locked",false])}], //Door
	["Door_33",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_33_locked",false])}], //Door
	["Door_34",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_34_locked",false])}], //Door
	["Door_35",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_35_locked",false])}], //Door
	["Door_36",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_36_locked",false])}], //Door
	["Door_37",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_37_locked",false])}], //Door
	["Door_38",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_38_locked",false])}], //Door
	["Door_39",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_39_locked",false])}], //Door
	["Door_40",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_40_locked",false])}], //Door
	["Door_41",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_41_locked",false])}], //Door
	["Door_42",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_42_locked",false])}], //Door
	["Door_43",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_43_locked",false])}], //Door
	["Door_44",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_44_locked",false])}], //Door
	["Door_45",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_45_locked",false])}], //Door
	["Door_46",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_46_locked",false])}], //Door
	["Door_47",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_47_locked",false])}], //Door
	["Door_48",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_48_locked",false])}], //Door
	["Door_49",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_49_locked",false])}], //Door
	["Door_50",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_50_locked",false])}], //Door

	["Door_1",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf (call A3PL_Intersect_cursortarget)) IN Config_Houses_List || (typeOf (call A3PL_Intersect_cursortarget)) IN Config_Warehouses_List || (typeOf (call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel","Land_A3PL_Greenhouse"]}], //todo: replace true with some code to check if we own the key to the house || Lock/Unlock Door
	["Door_2",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf (call A3PL_Intersect_cursortarget)) IN Config_Houses_List || (typeOf (call A3PL_Intersect_cursortarget)) IN Config_Warehouses_List || (typeOf (call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel","Land_A3PL_Greenhouse"]}], //Lock/Unlock Door
	["Door_3",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf (call A3PL_Intersect_cursortarget)) IN Config_Houses_List || (typeOf (call A3PL_Intersect_cursortarget)) IN Config_Warehouses_List || (typeOf (call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel"]}],//Lock/Unlock Door
	["Door_4",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf (call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel"]}], //Lock/Unlock Door
	["Door_5",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf (call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel","Land_John_House_Grey","Land_John_House_Blue","Land_John_House_Red","Land_John_House_Green","Land_A3FL_Warehouse"]}], //Lock/Unlock Door
	["Door_6",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf (call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel","Land_A3FL_Warehouse"]}], //Lock/Unlock Door
	["Door_7",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf (call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel","Land_A3FL_Warehouse"]}], //Lock/Unlock Door
	["Door_8",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf (call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel","Land_Mansion01","Land_A3FL_Warehouse"]}], //Lock/Unlock Door

	//new knock doors
	["Door_1",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(typeOf player_objintersect in ["A3PL_EMS_Locker"])}], //Knock On Door
	["Door_2",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_3",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_4",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_5",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_6",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_7",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_8",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_9",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],  //Knock On Door
	["Door_10",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_11",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_12",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_13",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_14",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_15",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_16",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_17",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_18",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_19",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_20",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_21",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_22",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_23",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_24",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_25",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_26",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_26",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_27",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_28",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_29",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_30",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_31",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_32",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_33",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_34",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_35",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_36",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_37",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_38",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_39",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_40",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_41",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_42",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_43",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_44",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_45",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_46",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_47",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_48",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_49",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_50",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door

	["garageButton",localize"STR_INTSECT_GARAGEDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Garage Door

	//jayhawk
	["Door_RB",localize"STR_INTSECT_BOARDHELISSIDE",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf player_objintersect == "A3PL_Jayhawk") && {(vehicle player == player)} && {!(player_objIntersect getVariable ["locked",true])}}], //Board Helicopter (Side)
	["ignition_Switch",localize"STR_INTSECT_SWITCHIGN",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //Switch Ignition
	["battery",localize"STR_INTSECT_SWITCHBAT",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //Switch Battery
	["gen1",localize"STR_INTSECT_APUGEN",_dir+"IGUI\Cfg\Actions\engine_on_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //APU Generator
	["gen2",format [localize"STR_INTSECT_ENGGEN",1],_dir+"IGUI\Cfg\Actions\engine_on_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //ENG Generator NO.%1
	["gen3",format [localize"STR_INTSECT_ENGGEN",2],_dir+"IGUI\Cfg\Actions\engine_on_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //ENG Generator NO.%1
	["apucontrol",localize"STR_INTSECT_APUCONT",_dir+"IGUI\Cfg\Actions\repair_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //APU Control
	["ecs",localize"STR_INTSECT_ECSSTART",_dir+"gui\Rsc\RscDisplayArcadeMap\editor_wind_min_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //ECS/Start
	["fuelpump",localize"STR_INTSECT_FUELPUMP",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //Fuel Pump
	["fold",localize"STR_INTSECT_UNFOJAYHWK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //Unfold/Fold Jayhawk
	["Fold_switch",localize"STR_INTSECT_UNFOJAYHWK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //Unfold/Fold Jayhawk
	["Interior_Lights",localize"STR_INTSECT_COCKLIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //Cockpit Lights
	["Searchlight_Switch",localize"STR_INTSECT_TOGGLESL",_dir+"IGUI\Cfg\Actions\engine_on_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //Toggle Searchlight

	["boatdoor",localize"STR_INTSECT_OPCLGARDOOR2",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open/Close Door
	["driver",localize"STR_INTSECT_UNLOCKPATROL",_dir+"IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(player_objintersect IN A3PL_Player_Vehicles) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Drive Ship
	["driver",localize"STR_INTSECT_DRIVESHIP",_dir+"IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{!(player_objintersect getVariable['locked',true])}], //Drive Ship
	["cargo1",localize"STR_INTSECT_CARGOSHIP",_dir+"IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{!(player_objintersect getVariable['locked',true])}], //Cargo Ship
	["cargo2",localize"STR_INTSECT_CARGOSHIP",_dir+"IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{!(player_objintersect getVariable['locked',true])}], //Cargo Ship
	["extinguisher",localize"STR_INTSECT_CONTREXTING",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_fire_put_down_ca.paa",{true}], //Control Extinguisher

	//police stuff
	["Spine1",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["uscg","fisd","usms"]) && (((player_Itemclass == "handcuffs") && (isPlayer player_objintersect)) OR ((player_objintersect getVariable ["Cuffed",true]) && (isPlayer player_objintersect))) }], //Cuff/Uncuff
	["Spine3",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["uscg","fisd","usms"]) && (((player_Itemclass == "handcuffs") && (isPlayer player_objintersect)) OR ((player_objintersect getVariable ["Cuffed",true]) && (isPlayer player_objintersect)))}], //Cuff/Uncuff
	["RightHand",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["uscg","fisd","usms"]) && (((player_Itemclass == "handcuffs") && (isPlayer player_objintersect)) OR ((player_objintersect getVariable ["Cuffed",true]) && (isPlayer player_objintersect)))}], //Cuff/Uncuff
	["LeftHand",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["uscg","fisd","usms"]) && (((player_Itemclass == "handcuffs") && (isPlayer player_objintersect)) OR ((player_objintersect getVariable ["Cuffed",true]) && (isPlayer player_objintersect)))}], //Cuff/Uncuff
	["LeftForeArm",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["uscg","fisd","usms"]) && (((player_Itemclass == "handcuffs") && (isPlayer player_objintersect)) OR ((player_objintersect getVariable ["Cuffed",true]) && (isPlayer player_objintersect)))}], //Cuff/Uncuff
	["RightForeArm",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["uscg","fisd","usms"]) && (((player_Itemclass == "handcuffs") && (isPlayer player_objintersect)) OR ((player_objintersect getVariable ["Cuffed",true]) && (isPlayer player_objintersect)))}], //Cuff/Uncuff

	//Lockpick handcuffs
	["Spine1",localize"STR_INTSECT_LPCUFF","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(player_Itemclass == "v_lockpick") && {(isPlayer player_objintersect)} && {(player_objintersect getVariable ["Cuffed",true])} && {(isPlayer player_objintersect)}}], //Cuff/Uncuff
	["Spine3",localize"STR_INTSECT_LPCUFF","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(player_Itemclass == "v_lockpick") && {(isPlayer player_objintersect)} && {(player_objintersect getVariable ["Cuffed",true])} && {(isPlayer player_objintersect)}}], //Cuff/Uncuff
	["RightHand",localize"STR_INTSECT_LPCUFF","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(player_Itemclass == "v_lockpick") && {(isPlayer player_objintersect)} && {(player_objintersect getVariable ["Cuffed",true])} && {(isPlayer player_objintersect)}}], //Cuff/Uncuff

	["Spine3",localize"STR_INTSECT_DRAG","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && {(player_objintersect getVariable ["Cuffed",true])} && {((player getVariable "job") IN ["uscg","fisd","usms"])} }], //Drag
	["Spine1",localize"STR_INTSECT_DRAG","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && {(player_objintersect getVariable ["Cuffed",true])} && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Drag
	["Spine3",localize"STR_INTSECT_DRAG","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && {(surfaceIsWater position player)} && {(player_objintersect getVariable ["Cuffed",true])} && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Drag
	["Spine1",localize"STR_INTSECT_DRAG","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && (surfaceIsWater position player) && {(player_objintersect getVariable ["Cuffed",true])} && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Drag
	["spine3",localize"STR_INTSECT_KICKDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{(animationState player_objintersect == "a3pl_handsupkneelcuffed") && (!(player getVariable ["Cuffed",true]) && !(player getVariable ["Zipped",true])) && (animationState player) != "a3pl_takenhostage"}], //Kick Down
	["Spine3",localize"STR_INTSECT_PATDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["fisd","uscg","faa","usms"]) && (isPlayer player_objintersect) && ((animationState player_objintersect IN ["a3pl_idletohandsup","a3pl_handsuptokneel"]) || (player_objintersect getVariable ["Cuffed",true]))}], //Pat down
	["Spine3","Remove Mask","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["fisd","uscg","usms"]) && {(player_objintersect getVariable ["Cuffed",true])} && {(goggles player_objintersect != "")} && {(isPlayer player_objintersect)}}], //Remove mask

	["Spine3",localize"STR_INTSECT_Grab","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && {((player getVariable "job") IN ["uscg"])} && {(surfaceIsWater position player)}}],
	["Spine1",localize"STR_INTSECT_Grab","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && {((player getVariable "job") IN ["uscg"])} && {(surfaceIsWater position player)}}],

	["Spine1",localize"STR_INTSECT_ZIPUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect)) or ((player_objintersect getVariable ["Zipped",true]) && (isPlayer player_objintersect))}], //zip/unzip
	["Spine3",localize"STR_INTSECT_ZIPUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect)) or ((player_objintersect getVariable ["Zipped",true])&& (isPlayer player_objintersect))}], //zip/unzip
	["RightHand",localize"STR_INTSECT_ZIPUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect)) or ((player_objintersect getVariable ["Zipped",true])&& (isPlayer player_objintersect))}], //zip/unzip
	["LeftHand",localize"STR_INTSECT_ZIPUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect))or ((player_objintersect getVariable ["Zipped",true])&& (isPlayer player_objintersect))}], //zip/unzip
	["LeftForeArm",localize"STR_INTSECT_ZIPUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect))or ((player_objintersect getVariable ["Zipped",true])&& (isPlayer player_objintersect))}], //zip/unzip
	["RightForeArm",localize"STR_INTSECT_ZIPUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect))or ((player_objintersect getVariable ["Zipped",true])&& (isPlayer player_objintersect))}], //zip/unzip
	["Spine3",localize"STR_INTSECT_DRAGH","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && {(player_objintersect getVariable ["Zipped",true])}}], //Drag
	["Spine1",localize"STR_INTSECT_DRAGH","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && {(player_objintersect getVariable ["Zipped",true])}}], //Drag
	["Spine3",localize"STR_INTSECT_PATDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && {(player_objintersect getVariable ["Zipped",true])}}], //Pat down

	["Retract_Stinger",localize"STR_INTSECT_RETRACTSTR","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player getVariable "job") IN ["fisd","uscg","usms"]) && ({player_objintersect animationSourcePhase "Deploy_Stinger" > 0.5})}], //Retract Stinger
	["Deploy_Stinger",localize"STR_INTSECT_RETRACTSTR","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player getVariable "job") IN ["fisd","uscg","usms"]) && ({player_objintersect animationSourcePhase "Deploy_Stinger" > 0.1})}], //Retract Stinger
	["Deploy_Stinger",localize"STR_INTSECT_DEPLSTR","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player getVariable "job") IN ["fisd","uscg","usms"])&& ({player_objintersect animationSourcePhase "Deploy_Stinger" < 0.5})}], //Deploy Stinger
	["Deploy_Stinger",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]}) && (player_objintersect animationSourcePhase "Deploy_Stinger" < 0.5)}], //Pickup Item
	["Deploy_Stinger",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]}) && (player_objintersect animationSourcePhase "Deploy_Stinger" < 0.5)}], //Pickup Item To Hand
	["Deploy_Stinger",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["Deploy_Stinger",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item

	["ski",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Driver
	["ski",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && {(!(vehicle player getVariable ["trapped",false]))} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["ski",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],	 //Lock/Unlock Vehicle Doors

	["Door_RF",localize"STR_INTSECT_ENTCODR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((typeOf player_objintersect) IN ["A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_CVPI_PD","A3PL_CVPI_PD_Slicktop","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop"]) && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Co-Driver

	["scooter_driver",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Driver
	["scooter_driver",localize"STR_INTSECT_EXITVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{!((vehicle player) isEqualTo player)}], //Exit Vehicle
	["scooter_driver",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["scooter_driver",localize"STR_INTSECT_RESSCOOT",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{true}], //Reset Scooter
	["scooter_passenger",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)}}], //Enter as Passenger
	["scooter_passenger",localize"STR_INTSECT_EXITVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{!((vehicle player) isEqualTo player)}],	 //Exit Vehicle

	["carinfo",localize"STR_INTSECT_VEHINFO","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(!isNil {player_objIntersect getVariable "stock"})}], //Vehicle Info
	["sirenSwitch",localize"STR_INTSECT_TOGLIGHTB",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player != player)}], //Toggle Lightbar
	["sirenSwitch",localize"STR_INTSECT_TOGSIR",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_sound_on_ca.paa",{(vehicle player != player)}], //Toggle Siren
	["sirenSwitch",format [localize"STR_INTSECT_TOGMANUAL",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_sound_on_ca.paa",{(vehicle player != player)}], //Toggle Manual %1
	["sirenSwitch",format [localize"STR_INTSECT_TOGMANUAL",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_sound_on_ca.paa",{(vehicle player != player)}], //Toggle Manual %1
	["sirenSwitch",format [localize"STR_INTSECT_TOGMANUAL",3],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_sound_on_ca.paa",{(vehicle player != player)}], //Toggle Manual %1
	["carpanel",localize"STR_INTSECT_OPCLTRUNK",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open/Close Trunk
	["policeradio",localize"STR_INTSECT_USEPOLRAD",_dir+"IGUI\RscIngameUI\RscDisplayVoiceChat\microphone_ca.paa",{(vehicle player != player)}], //Use Police Radio

	["hitchTrailer",localize"STR_INTSECT_HITCHTRLER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objIntersect animationSourcePhase "Hitched" <= 1.5}], //Hitch Trailer
	["hitchTrailer",localize"STR_INTSECT_UNHITCHTRL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objIntersect animationSourcePhase "Hitched" > 1.5}], //Unhitch Trailer
	["door",localize"STR_INTSECT_OPCLTRAILD",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(vehicle player) isEqualTo player}], //Open/Close Trailer Door
	["door",localize"STR_INTSECT_LRTRAILERR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(vehicle player) isEqualTo player}], //Lower/Raise Trailer Ramp
	["Cargo_Door_1",localize"STR_INTSECT_LRTRAILERR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect isKindOf "A3PL_Trailer_Base") && {(player_objintersect IN A3PL_Player_Vehicles)}}], //Lock/Unlock Trailer Doors
	["Cargo_Door_2",localize"STR_INTSECT_LRTRAILERR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect isKindOf "A3PL_Trailer_Base") && {(player_objintersect IN A3PL_Player_Vehicles)}}], //Lock/Unlock Trailer Doors
	["hitchTrailer",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["ramp",localize"STR_INTSECT_LRRAMP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objintersect isKindOf "car"}], //Lower/Raise Ramp

	["Hitch_Fold",localize"STR_INTSECT_HITCHFOLD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objIntersect animationSourcePhase "Hitched" <= 1.5) && {(typeOf player_objintersect == "A3PL_Lowboy")}}],
	["hitchTrailer","Toggle Gooseneck",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objIntersect animationSourcePhase "Hitched" <= 1.5) && {(typeOf player_objintersect == "A3PL_Lowboy")}}],
	["trunkSwitch",localize"STR_INTSECT_OPCLTRUNK",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open/Close Trunk

	["Front_LPlate",localize"STR_INTSECT_SPINSIGN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Spin Sign
	["Rear_LPlate",localize"STR_INTSECT_SPINSIGN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Spin Sign

	["cinemaSeat1_1",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat1_2",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat1_3",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat1_4",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat1_5",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat1_6",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat1_7",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat1_8",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down

	["cinemaSeat2_1",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat2_2",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_3",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_4",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_5",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_6",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_7",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_8",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down

	["cinemaSeat3_1",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat3_2",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_3",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_4",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_5",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_6",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_7",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_8",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down

	["Seat_1",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_2",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_3",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_4",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_5",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_6",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_7",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_8",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_9",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_10",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_11",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_12",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_13",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_14",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_15",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_16",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_17",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_18",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_19",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_20",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_21",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_22",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_23",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_24",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_25",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_26",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_27",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_28",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_29",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_30",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_31",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_32",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_33",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_34",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_35",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_36",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_37",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_38",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_39",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_40",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_41",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_42",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_43",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_44",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_45",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_46",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_47",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_48",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_49",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_50",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_51",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_52",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_53",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_54",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_55",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_56",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_57",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_58",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_59",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_60",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_61",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_62",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_63",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_64",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_65",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_66",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_67",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_68",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_69",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_70",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_71",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_72",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_73",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_74",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_75",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_76",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_77",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_78",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_79",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_80",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_81",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_82",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_83",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_84",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_85",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_86",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_87",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_88",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_89",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_90",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_91",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_92",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_93",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_94",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_95",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_96",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_97",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_98",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_99",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_100",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down

	["bed_1",localize"STR_INTSECT_LAYDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Lay down
	["bed_2",localize"STR_INTSECT_LAYDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Lay down
	["bed_3",localize"STR_INTSECT_LAYDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Lay down
	["bed_1",localize"STR_INTSECT_GETUP","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{animationState player == "a3pl_bed"}], //Get Up
	["bed_2",localize"STR_INTSECT_GETUP","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{animationState player == "a3pl_bed"}], //Get Up
	["bed_3",localize"STR_INTSECT_GETUP","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{animationState player == "a3pl_bed"}], //Get Up
	["GetIn_Driver",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Driver
	["GetIn_Driver2",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Driver
	["GetIn_Driver3",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Driver
	["GetIn_Driver4",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Driver
	["GetIn_Driver5",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Driver
	["GetIn_CoPilot",localize"STR_INTSECT_ENTCOPIL","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Co-Pilot
	["GetIn_Gunner0",format [localize"STR_INTSECT_ENTASGUN",1],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner1",format [localize"STR_INTSECT_ENTASGUN",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner2",format [localize"STR_INTSECT_ENTASGUN",3],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner3",format [localize"STR_INTSECT_ENTASGUN",4],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner4",format [localize"STR_INTSECT_ENTASGUN",5],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner5",format [localize"STR_INTSECT_ENTASGUN",6],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner6",format [localize"STR_INTSECT_ENTASGUN",7],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner7",format [localize"STR_INTSECT_ENTASGUN",8],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner8",format [localize"STR_INTSECT_ENTASGUN",9],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner9",format [localize"STR_INTSECT_ENTASGUN",10],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner10",format [localize"STR_INTSECT_ENTASGUN",11],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner11",format [localize"STR_INTSECT_ENTASGUN",12],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner12",format [localize"STR_INTSECT_ENTASGUN",13],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner13",format [localize"STR_INTSECT_ENTASGUN",14],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner14",format [localize"STR_INTSECT_ENTASGUN",15],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner15",format [localize"STR_INTSECT_ENTASGUN",16],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner16",format [localize"STR_INTSECT_ENTASGUN",17],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner17",format [localize"STR_INTSECT_ENTASGUN",18],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner18",format [localize"STR_INTSECT_ENTASGUN",19],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Gunner19",format [localize"STR_INTSECT_ENTASGUN",20],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Gunner %1
	["GetIn_Cargo1",format [localize"STR_INTSECT_SITINSEAT",1],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo2",format [localize"STR_INTSECT_SITINSEAT",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo3",format [localize"STR_INTSECT_SITINSEAT",3],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo4",format [localize"STR_INTSECT_SITINSEAT",4],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo5",format [localize"STR_INTSECT_SITINSEAT",5],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo6",format [localize"STR_INTSECT_SITINSEAT",6],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo7",format [localize"STR_INTSECT_SITINSEAT",7],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo8",format [localize"STR_INTSECT_SITINSEAT",8],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo9",format [localize"STR_INTSECT_SITINSEAT",9],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo10",format [localize"STR_INTSECT_SITINSEAT",10],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo11",format [localize"STR_INTSECT_SITINSEAT",11],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo12",format [localize"STR_INTSECT_SITINSEAT",12],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo13",format [localize"STR_INTSECT_SITINSEAT",13],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo14",format [localize"STR_INTSECT_SITINSEAT",14],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo15",format [localize"STR_INTSECT_SITINSEAT",15],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo16",format [localize"STR_INTSECT_SITINSEAT",16],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo17",format [localize"STR_INTSECT_SITINSEAT",17],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo18",format [localize"STR_INTSECT_SITINSEAT",18],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo19",format [localize"STR_INTSECT_SITINSEAT",19],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo20",format [localize"STR_INTSECT_SITINSEAT",20],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo21",format [localize"STR_INTSECT_SITINSEAT",21],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo22",format [localize"STR_INTSECT_SITINSEAT",22],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo23",format [localize"STR_INTSECT_SITINSEAT",23],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo24",format [localize"STR_INTSECT_SITINSEAT",24],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo25",format [localize"STR_INTSECT_SITINSEAT",25],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo26",format [localize"STR_INTSECT_SITINSEAT",26],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo27",format [localize"STR_INTSECT_SITINSEAT",27],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo28",format [localize"STR_INTSECT_SITINSEAT",28],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo29",format [localize"STR_INTSECT_SITINSEAT",29],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo30",format [localize"STR_INTSECT_SITINSEAT",30],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo31",format [localize"STR_INTSECT_SITINSEAT",31],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo32",format [localize"STR_INTSECT_SITINSEAT",32],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo33",format [localize"STR_INTSECT_SITINSEAT",33],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo34",format [localize"STR_INTSECT_SITINSEAT",34],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo35",format [localize"STR_INTSECT_SITINSEAT",35],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo36",format [localize"STR_INTSECT_SITINSEAT",36],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo37",format [localize"STR_INTSECT_SITINSEAT",37],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo38",format [localize"STR_INTSECT_SITINSEAT",38],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo39",format [localize"STR_INTSECT_SITINSEAT",39],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo40",format [localize"STR_INTSECT_SITINSEAT",40],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo41",format [localize"STR_INTSECT_SITINSEAT",41],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo42",format [localize"STR_INTSECT_SITINSEAT",42],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo43",format [localize"STR_INTSECT_SITINSEAT",43],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo44",format [localize"STR_INTSECT_SITINSEAT",44],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo45",format [localize"STR_INTSECT_SITINSEAT",45],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo46",format [localize"STR_INTSECT_SITINSEAT",46],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo47",format [localize"STR_INTSECT_SITINSEAT",47],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo48",format [localize"STR_INTSECT_SITINSEAT",48],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo49",format [localize"STR_INTSECT_SITINSEAT",49],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Cargo50",format [localize"STR_INTSECT_SITINSEAT",50],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["GetIn_Driver",localize"STR_INTSECT_MOVETODRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Driver
	["GetIn_Driver2",localize"STR_INTSECT_MOVETODRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Driver
	["GetIn_Driver3",localize"STR_INTSECT_MOVETODRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Driver
	["GetIn_Driver4",localize"STR_INTSECT_MOVETODRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Driver
	["GetIn_Driver5",localize"STR_INTSECT_MOVETODRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Driver
	["GetIn_CoPilot",localize"STR_INTSECT_MOVETOCOPIL","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Co-Pilot
	["GetIn_Gunner0",format [localize"STR_INTSECT_MOVTOGUNNR",1],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner1",format [localize"STR_INTSECT_MOVTOGUNNR",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner2",format [localize"STR_INTSECT_MOVTOGUNNR",3],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner3",format [localize"STR_INTSECT_MOVTOGUNNR",4],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner4",format [localize"STR_INTSECT_MOVTOGUNNR",5],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner5",format [localize"STR_INTSECT_MOVTOGUNNR",6],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner6",format [localize"STR_INTSECT_MOVTOGUNNR",7],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner7",format [localize"STR_INTSECT_MOVTOGUNNR",8],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner8",format [localize"STR_INTSECT_MOVTOGUNNR",9],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner9",format [localize"STR_INTSECT_MOVTOGUNNR",10],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner10",format [localize"STR_INTSECT_MOVTOGUNNR",11],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner11",format [localize"STR_INTSECT_MOVTOGUNNR",12],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner12",format [localize"STR_INTSECT_MOVTOGUNNR",13],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner13",format [localize"STR_INTSECT_MOVTOGUNNR",14],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner14",format [localize"STR_INTSECT_MOVTOGUNNR",15],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner15",format [localize"STR_INTSECT_MOVTOGUNNR",16],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner16",format [localize"STR_INTSECT_MOVTOGUNNR",17],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner17",format [localize"STR_INTSECT_MOVTOGUNNR",18],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner18",format [localize"STR_INTSECT_MOVTOGUNNR",19],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Gunner19",format [localize"STR_INTSECT_MOVTOGUNNR",20],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Gunner %1
	["GetIn_Cargo1",format [localize"STR_INTSECT_MOVETOSEAT",1],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo2",format [localize"STR_INTSECT_MOVETOSEAT",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo3",format [localize"STR_INTSECT_MOVETOSEAT",3],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo4",format [localize"STR_INTSECT_MOVETOSEAT",4],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo5",format [localize"STR_INTSECT_MOVETOSEAT",5],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo6",format [localize"STR_INTSECT_MOVETOSEAT",6],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo7",format [localize"STR_INTSECT_MOVETOSEAT",7],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo8",format [localize"STR_INTSECT_MOVETOSEAT",8],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo9",format [localize"STR_INTSECT_MOVETOSEAT",9],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo10",format [localize"STR_INTSECT_MOVETOSEAT",10],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo11",format [localize"STR_INTSECT_MOVETOSEAT",11],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo12",format [localize"STR_INTSECT_MOVETOSEAT",12],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo13",format [localize"STR_INTSECT_MOVETOSEAT",13],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo14",format [localize"STR_INTSECT_MOVETOSEAT",14],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo15",format [localize"STR_INTSECT_MOVETOSEAT",15],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo16",format [localize"STR_INTSECT_MOVETOSEAT",16],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo17",format [localize"STR_INTSECT_MOVETOSEAT",17],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo18",format [localize"STR_INTSECT_MOVETOSEAT",18],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo19",format [localize"STR_INTSECT_MOVETOSEAT",19],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo20",format [localize"STR_INTSECT_MOVETOSEAT",20],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo21",format [localize"STR_INTSECT_MOVETOSEAT",21],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo22",format [localize"STR_INTSECT_MOVETOSEAT",22],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo23",format [localize"STR_INTSECT_MOVETOSEAT",23],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo24",format [localize"STR_INTSECT_MOVETOSEAT",24],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo25",format [localize"STR_INTSECT_MOVETOSEAT",25],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo26",format [localize"STR_INTSECT_MOVETOSEAT",26],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo27",format [localize"STR_INTSECT_MOVETOSEAT",27],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo28",format [localize"STR_INTSECT_MOVETOSEAT",28],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo29",format [localize"STR_INTSECT_MOVETOSEAT",29],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo30",format [localize"STR_INTSECT_MOVETOSEAT",30],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo31",format [localize"STR_INTSECT_MOVETOSEAT",31],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo32",format [localize"STR_INTSECT_MOVETOSEAT",32],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo33",format [localize"STR_INTSECT_MOVETOSEAT",33],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo34",format [localize"STR_INTSECT_MOVETOSEAT",34],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo35",format [localize"STR_INTSECT_MOVETOSEAT",35],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo36",format [localize"STR_INTSECT_MOVETOSEAT",36],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo37",format [localize"STR_INTSECT_MOVETOSEAT",37],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo38",format [localize"STR_INTSECT_MOVETOSEAT",38],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo39",format [localize"STR_INTSECT_MOVETOSEAT",39],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo40",format [localize"STR_INTSECT_MOVETOSEAT",40],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo41",format [localize"STR_INTSECT_MOVETOSEAT",41],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo42",format [localize"STR_INTSECT_MOVETOSEAT",42],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo43",format [localize"STR_INTSECT_MOVETOSEAT",43],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo44",format [localize"STR_INTSECT_MOVETOSEAT",44],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo45",format [localize"STR_INTSECT_MOVETOSEAT",45],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo46",format [localize"STR_INTSECT_MOVETOSEAT",46],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo47",format [localize"STR_INTSECT_MOVETOSEAT",47],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo48",format [localize"STR_INTSECT_MOVETOSEAT",48],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo49",format [localize"STR_INTSECT_MOVETOSEAT",49],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1
	["GetIn_Cargo50",format [localize"STR_INTSECT_MOVETOSEAT",50],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1

	//interactions for yacht
	["yacht_ladder1",localize"STR_INTSECT_USEYACHTL",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Yacht Ladder
	["yacht_ladder2",localize"STR_INTSECT_USEYACHTL",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Yacht Ladder
	["yacht_driver",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{true}], //Enter as Driver

	["Mooring_1","Toggle Mooring Line",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Mooring Line
	["Mooring_2","Toggle Mooring Line",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Mooring Line
	["Mooring_3","Toggle Mooring Line",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Mooring Line
	["Mooring_4","Toggle Mooring Line",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Mooring Line

	["cutterDriver",localize"STR_INTSECT_ENTUSCGCUT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{true}], //replace true condition for USCG faction here later ||Enter USCG Cutter
	["cutterCargo1",localize"STR_INTSECT_ENTUSCGCUTC","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{true}], //Enter USCG Cutter (Cargo)
	["cutterGunner",localize"STR_INTSECT_ENTUSCGCUTG","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{true}], //Enter USCG Cutter (Gunner)
	["cutterladder1_bottom",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder1_top",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder2_bottom",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder2_top",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder3_bottom",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder3_top",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder4_bottom",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder4_top",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder

	//yacht
	["climbYacht",localize"STR_INTSECT_CLIMBINTYA",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{(vehicle player == player)}], //Climb Onto Yacht

	//farming
	["farmingground",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed
	["farmingground1",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed
	["farmingground2",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed
	["farmingground3",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed
	["farmingground4",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed
	["farmingground5",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed

	//gas station
	["gasHose",localize"STR_INTSECT_GRABGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Grab Gas Hose
	["gasHose",localize"STR_INTSECT_TOGGLEFUELP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Fuel Pump
	["gasTurn",localize"STR_INTSECT_TOGGLEFUELP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Fuel Pump
	["hoseback1",localize"STR_INTSECT_RETGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Return Gas Hose
	["hoseback2",localize"STR_INTSECT_RETGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Return Gas Hose
	["hoseback3",localize"STR_INTSECT_RETGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Return Gas Hose
	["hoseback4",localize"STR_INTSECT_RETGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Return Gas Hose
	["hoseback1",localize"STR_INTSECT_GRABGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Grab Gas Hose
	["hoseback2",localize"STR_INTSECT_GRABGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Grab Gas Hose
	["hoseback3",localize"STR_INTSECT_GRABGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Grab Gas Hose
	["hoseback4",localize"STR_INTSECT_GRABGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Grab Gas Hose
	["gastank",localize"STR_INTSECT_CONGASHOSE",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{typeOf Player_Item IN ["A3PL_Gas_Hose","A3PL_GasHose"]}], //Connect Gas Hose
	["gastank",localize"STR_INTSECT_USEJERRYC",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{player_itemClass == "jerrycan"}], //Use jerrycan
	["inspect_hitfuel1",localize"STR_INTSECT_CONGASHOSE",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{typeOf Player_Item IN ["A3PL_Gas_Hose","A3PL_GasHose"]}], //Connect Gas Hose
	["Repair",localize"STR_INTSECT_CONGASHOSE",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{(typeOf Player_Item IN ["A3PL_Gas_Hose","A3PL_GasHose"])&& {(typeOf player_objintersect == "A3PL_RHIB")}}],

	//Cinema popcorn
	["popcornmachine1",localize"STR_INTSECT_GETPOPC",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Get Popcorn
	["popcornmachine2",localize"STR_INTSECT_GETPOPC",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Get Popcorn

	["popcornBucket",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["popcornBucket",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	//Pickup Item To Hand
	["popcornBucket",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}],
	["popcornBucket",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item

	//new garage
	["garage_2_button",localize"STR_INTSECT_GARAGEDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Garage Door
	["garage_1_button",localize"STR_INTSECT_GARAGEDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Garage Door
	["car_lift_button", localize"STR_INTSECT_USECARLIFT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Use Car Lift
	["car_upgrade",localize"STR_INTSECT_UPGRVEH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Upgrade Vehicle

	["mailtruck_trunk",localize"STR_INTSECT_OPCLMAILTD",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open/Close Mailtruck Door
	["mailtruck_trunk",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player_objintersect IN A3PL_Player_Vehicles) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["deliverybox",localize"STR_INTSECT_PickupDeliveryBox",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],
	//["deliverybox",localize"STR_INTSECT_CollectDeliveryBox",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],
	["deliverybox",localize"STR_INTSECT_CheckDeliveryLabel",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],

	//rockets
	["fireworkIgnite",localize"STR_INTSECT_IGNROCKET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect getVariable ["stock",-1]) == -1) && {(simulationEnabled player_objIntersect)}}], //Ignite Rocket
	["fireworkrocket",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["stock",-1] == -1)}], //Buy/Sell Item
	["atego_tow",localize"STR_INTSECT_LoadVehicle",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& {((player getVariable ["job","unemployed"]) IN ["Roadside","uscg","fifr","fisd"])}}],
	["atego_tow",localize"STR_INTSECT_UnloadVehicle",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& {((player getVariable ["job","unemployed"]) IN ["Roadside","uscg","fifr","fisd"])}}],
	["Ramp_Switch",localize"STR_INTSECT_TOGGRAMP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],
	["Spotlight_Switch",localize"STR_INTSECT_TOGREARSPOTL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Rear Spotlight
	["carinfo",localize"STR_INTSECT_IMPNEARVEH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{vehicleVarName player_objintersect IN ["Shop_Impound","Shop_Impound_1","Shop_Impound_2","Shop_Impound_3","Shop_Impound_4","Shop_Impound_5"]}], //Impound Nearest Vehicle

	//impound lot
	["impound_Door_button",localize"STR_INTSECT_OPCLIMPGATE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Impound Gate
	["impound_Door_button_2",localize"STR_INTSECT_OPCLIMPGATE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Impound Gate

	//Fire station
	["big_Door_1_1_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["big_Door_1_2_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door

	["big_Door_2_1_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["big_Door_2_2_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],	 //Door

	["bay_Door_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_3",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_4",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_5",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_6",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_7",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_8",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door

	["Room_All_switch_1",localize"STR_INTSECT_TURNONALLL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On All Lights
	["Room_1_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights

	["bay_Door_1_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_1_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_2_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_2_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_3_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_3_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_4_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_4_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_5_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_5_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_6_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_6_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_7_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_7_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_8_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_8_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door

	["big_Door_1_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["big_Door_1_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["big_Door_2_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["big_Door_2_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],	 //Door

	//FD Ladder
	//Fire truck
	["Ladder_action",localize"STR_INTSECT_TAKELADDER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objintersect animationPhase "ladder" < 0.5}], //Take Ladder
	["Ladder_action",localize"STR_INTSECT_PUTBACKLAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{_ladders = nearestObjects [player, ["A3PL_Ladder"], 2]; (count _ladders) > 0}], //Put Back Ladder

	["Hose_1_action",format [localize"STR_INTSECT_PUTBACKHOSE",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "FD_Hose"}], //Put Back Hose %1
	["Hose_2_action",format [localize"STR_INTSECT_PUTBACKHOSE",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "FD_Hose"}], //Put Back Hose %1
	["Hose_3_action",format [localize"STR_INTSECT_PUTBACKHOSE",3],_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "FD_Hose"}], //Put Back Hose %1
	["Hose_4_action",format [localize"STR_INTSECT_PUTBACKHOSE",4],_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "FD_Hose"}], //Put Back Hose %1
	["Hose_5_action",format [localize"STR_INTSECT_PUTBACKHOSE",5],_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "FD_Hose"}], //Put Back Hose %1

	["Hose_1_action",format [localize"STR_INTSECT_TAKEHOSE",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Hose_1") < 1}], //Take Hose %1
	["Hose_2_action",format [localize"STR_INTSECT_TAKEHOSE",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Hose_2") < 1}], //Take Hose %1
	["Hose_3_action",format [localize"STR_INTSECT_TAKEHOSE",3],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Hose_3") < 1}], //Take Hose %1
	["Hose_4_action",format [localize"STR_INTSECT_TAKEHOSE",4],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Hose_4") < 1}], //Take Hose %1
	["Hose_5_action",format [localize"STR_INTSECT_TAKEHOSE",5],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Hose_5") < 1}],	 //Take Hose %1

	//fire truck
	["controller_cover",localize"STR_INTSECT_TOGCONTCOV",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Controller Cover
	["FT_Switch_1",localize"STR_INTSECT_TOGDSFOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle DS Front Outrigger
	["FT_Switch_2",localize"STR_INTSECT_TOGDROUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle DS Rear Outrigger
	["FT_Switch_3",localize"STR_INTSECT_TOGPSFOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle PS Front Outrigger
	["FT_Switch_4",localize"STR_INTSECT_TOGPSROUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle PS Rear Outrigger
	["FT_Switch_5",localize"STR_INTSECT_TORADSOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle/Raise DS Outriggers
	["FT_Switch_6",localize"STR_INTSECT_TORAPSOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle/Raise PS Outriggers
	["FT_Switch_8",localize"STR_INTSECT_DSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //DS Floodlights
	["FT_Switch_9",localize"STR_INTSECT_PSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //PS Floodlights
	["FT_Switch_10",localize"STR_INTSECT_PERILIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Perimeter Lights
	["FT_Switch_11",localize"STR_INTSECT_LADDERFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Ladder Floodlight
	["FT_Switch_12",localize"STR_INTSECT_LADDERCAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Ladder Cam

	["FT_Switch_13",localize"STR_INTSECT_TOGDSFOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle DS Front Outrigger
	["FT_Switch_14",localize"STR_INTSECT_TOGDROUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle DS Rear Outrigger
	["FT_Switch_15",localize"STR_INTSECT_TOGPSFOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle PS Front Outrigger
	["FT_Switch_16",localize"STR_INTSECT_TOGPSROUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle PS Rear Outrigger
	["FT_Switch_17",localize"STR_INTSECT_TORADSOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle/Raise DS Outriggers
	["FT_Switch_18",localize"STR_INTSECT_TORAPSOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle/Raise PS Outriggers
	["FT_Switch_20",localize"STR_INTSECT_DSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //DS Floodlights
	["FT_Switch_21",localize"STR_INTSECT_PSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //PS Floodlights
	["FT_Switch_22",localize"STR_INTSECT_PERILIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Perimeter Lights
	["FT_Switch_23",localize"STR_INTSECT_LADDERFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Ladder Floodlight
	["FT_Switch_24",localize"STR_INTSECT_LADDERCAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Ladder Cam

	["Ladder_Controls",localize"STR_INTSECT_ENTASLADOP","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Ladder Operator
	["Ladder_Controls",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && {!(player_objIntersect getVariable ["locked",true])} && {(!(vehicle player getVariable ["trapped",false]))} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Ladder_Holder",localize"STR_INTSECT_LORALADRACK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Lower/Raise Ladder Rack
	["FT_Pump_Switch",localize"STR_INTSECT_TONOFFPUMP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On\Off Pump

	//FIFM
	["Room_1_switch_1",localize"STR_QuickActionsBuildings_CheckFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["FireAlarm",false])  && {!(player_objintersect getVariable ["FireAlarmBroke",false])} && {(player_objintersect getVariable ["FireAlarmCanBroke",true])} && {((player getVariable ["job","unemployed"]) == "fifr")}}],
	["Room_1_switch_1",localize"STR_QuickActionsBuildings_TriggerFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["FireAlarm",false])  && {!(player_objintersect getVariable ["FireAlarmBroke",false])}}],
	["Room_1_switch_1",localize"STR_QuickActionsBuildings_ReEnableFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") && {(player_objintersect getVariable ["FireAlarm",false])} && {!(player_objintersect getVariable ["FireAlarmBroke",false])}}],
	["Room_1_switch_1",localize"STR_QuickActionsBuildings_RepairFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") && {(player_objintersect getVariable ["FireAlarm",false])} && {(player_objintersect getVariable ["FireAlarmBroke",false])}}],

	["door_4",localize"STR_QuickActionsBuildings_CheckFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["FireAlarm",false]) && {!(player_objintersect getVariable ["FireAlarmBroke",false])} && {(player_objintersect getVariable ["FireAlarmCanBroke",true])} && {((player getVariable ["job","unemployed"]) == "fifr")}}],
	["door_4",localize"STR_QuickActionsBuildings_TriggerFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["FireAlarm",false])  && !(player_objintersect getVariable ["FireAlarmBroke",false])}],
	["door_4",localize"STR_QuickActionsBuildings_ReEnableFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") && (player_objintersect getVariable ["FireAlarm",false]) && {!(player_objintersect getVariable ["FireAlarmBroke",false])}}],
	["door_4",localize"STR_QuickActionsBuildings_RepairFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") && (player_objintersect getVariable ["FireAlarm",false]) && {(player_objintersect getVariable ["FireAlarmBroke",false])}}],

	["firealarm",localize"STR_QuickActionsBuildings_CheckFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["FireAlarm",false]) && {!(player_objintersect getVariable ["FireAlarmBroke",false])} && {(player_objintersect getVariable ["FireAlarmCanBroke",true])} && {((player getVariable ["job","unemployed"]) == "fifr")}}],
	["firealarm",localize"STR_QuickActionsBuildings_TriggerFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["FireAlarm",false])  && !(player_objintersect getVariable ["FireAlarmBroke",false])}],
	["firealarm",localize"STR_QuickActionsBuildings_ReEnableFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") && (player_objintersect getVariable ["FireAlarm",false]) && {!(player_objintersect getVariable ["FireAlarmBroke",false])}}],
	["firealarm",localize"STR_QuickActionsBuildings_RepairFireAlarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") && (player_objintersect getVariable ["FireAlarm",false]) && {(player_objintersect getVariable ["FireAlarmBroke",false])}}],

	// Ambo
	["Ambo_Switch_7",localize"STR_INTSECT_REARFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Rear Floodlights
	["Ambo_Switch_8",localize"STR_INTSECT_DSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}],//DS Floodlights
	["Ambo_Switch_9",localize"STR_INTSECT_PSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //PS Floodlights
	["Ambo_Switch_10",localize"STR_INTSECT_INTLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Interior Lights
	["Ambo_Switch_11",localize"STR_INTSECT_HIGHBEAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //High Beam
	["Stretcher_Action",localize"STR_INTSECT_USESTRETCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {((player getVariable ["job","unemployed"]) == "fifr")}}], //Use Stretcher
	["Stretcher_Action",localize"STR_INTSECT_STORESTRETCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {((player getVariable ["job","unemployed"]) == "fifr")} && {(typeOf player_objIntersect isEqualTo 'A3PL_EMS_Stretcher')}}], //Store Stretcher
	["Stretcher_Action",format [localize"STR_INTSECT_SITINSEAT",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Sit In Seat %1
	["Stretcher_Action",format [localize"STR_INTSECT_MOVETOSEAT",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Move to Seat %1

	//Common Action
	["Switch_Fair_Available",localize"STR_INTSECT_TGLFAIRAVAIL",_dir+"IGUI\Cfg\Actions\lightsiconon_ca.paa",{player == driver player_objintersect}], //Toggle Fair Available
	["Switch_Pause_Fair",localize"STR_INTSECT_PAUSEFAIR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player == driver player_objintersect}], //Pause Fair
	["Switch_Reset_Fair",localize"STR_INTSECT_RESETFAIR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player == driver player_objintersect}], //Reset Fair
	["Switch_Start_Fair",localize"STR_INTSECT_STARTFAIR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player == driver player_objintersect}], //Start Fair
	["Switch_Stop_Fair",localize"STR_INTSECT_STOPFAIR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player == driver player_objintersect}], //Stop Fair
	["ASC_Switch",localize"STR_INTSECT_AIRSUSCONT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Air Suspension Control
	["PD_lightSwitch",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Head Lights
	["PD_Switch_8",localize"STR_INTSECT_TOGSPOTLIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Spotlight
	["PD_Switch_9",localize"STR_INTSECT_LEFTALLLIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Left Alley Light
	["PD_Switch_10",localize"STR_INTSECT_RIGHTALLLIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Right Alley Light
	["High_Beam_Switch",localize"STR_INTSECT_HIGHBEAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //High Beam
	["lightSwitch",localize"STR_INTSECT_HIGHBEAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //High Beam
	["Reverse_Cam_Button",localize"STR_INTSECT_REVERSECAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Reverse Cam
	["FT_Switch_33",localize"STR_INTSECT_AIRHORN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Airhorn
	["FT_Switch_34",localize"STR_INTSECT_ELECHORN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Electric Horn
	["FT_Switch_35",localize"STR_INTSECT_ELECAIRH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Electric Airhorn
	["FT_Switch_36",localize"STR_INTSECT_RUMBLERMAN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Rumbler Manual
	["FT_Switch_37",localize"STR_INTSECT_T3YELP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //T3 Yelp
	["FT_Switch_38",localize"STR_INTSECT_MASTERON",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Master On
	["Directional_Switch",localize"STR_INTSECT_DIRECTMASTER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Directional Master
	["powerswitch_1",localize"STR_INTSECT_DIRECTMASTER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Directional Master
	["Directional_Control_Noob",localize"STR_INTSECT_DIRECTCONTR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Directional Control
	["Siren_Control_Switch",localize"STR_INTSECT_SIRENMASTER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Siren Master
	["sirenswitch_1",localize"STR_INTSECT_SIRENMASTER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}],
	["Siren_Control_Noob",localize"STR_INTSECT_SIRENCONTR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Siren Control
	//A3PL interaction
	["Laptop_Top",localize"STR_INTSECT_TURNONOFFLAP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Turn On/Off Laptop
	["Laptop_Top",localize"STR_INTSECT_ACCPOLDB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Access Police Database
	["Laptop",localize"STR_INTSECT_SWIVELLAP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}],

	["Switch_Radar_Master",localize"STR_INTSECT_RADARMASTER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Radar Master
	["Switch_Radar_Rear",localize"STR_INTSECT_REARRADAR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Rear Radar
	["Switch_Radar_Front",localize"STR_INTSECT_FRONTRADAR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Front Radar
	["Switch_Radar_Master",localize"STR_INTSECT_RESETLOCKFAST",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Reset Lock/Fast
	["Lightbar_Switch",localize"STR_INTSECT_TOGLIGHTB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Lightbar

	//Mini Excavator
	["groundShov_Switch",localize"STR_INTSECT_TOGDOZBLAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Toggle Dozer Blade
	["Attachment_Switch",localize"STR_INTSECT_DETATTACHM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player) && {(cameraView isEqualTo "INTERNAL")}}], //Detach Attachment
	["Attachment",localize"STR_INTSECT_CONNBUCKET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "ME_Bucket"}], //Connect Bucket
	["Attachment",localize"STR_INTSECT_CONNJACKHAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "ME_Jackhammer"}], //Connect Jackhammer
	["Attachment",localize"STR_INTSECT_CONNECTCLAW",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "ME_Claw"}], //Connect Claw

	//FD Shops
	["hydrantwrench",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_hoseend",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_yadapter",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_hoserolled",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_axe",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_oxygen",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_mask",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_helmet",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item

	//Mail box
	["Door_mailbox",localize"STR_INTSECT_OPCLMAILB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Mailbox

	//Item pickup
	["item_pickup",localize"STR_INTSECT_FillBottle",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeOf player_objintersect) in ["A3PL_SinkSingleCabinet","A3PL_SinkBigCounter"]) && {(Player_ItemClass == "waterbottlempty")}}],
	["furniture",localize"STR_INTSECT_FillBottle",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeOf player_objintersect) in ["A3PL_ModularKitchen4"]) && (Player_ItemClass == "waterbottlempty")}],
	["furniture",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{((typeOf player_objintersect) in ["A3PL_Chair1","A3PL_Chair2","A3PL_Chair3","A3PL_Chair4","A3PL_KitchenChair1","A3PL_KitchenChair2","A3PL_Pouf","A3PL_DiningChair","A3PL_Sofa1","A3PL_Sofa2","A3PL_Sofa3","A3PL_Sofa4"])}],
	["furniture",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["furniture",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["furniture",localize"STR_INTSECT_LOADPINTOTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["class",""]) == "Petrol"}],	//Load Petrol Into Tanker
	["item_pickup",localize"STR_INTSECT_LoadKeroseneIntoTruck",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["class",""]) == "Kerosene"}],	//Load Petrol Into Tanker
	["furniture",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["furniture",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["furniture",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item

	//Items
	["burger",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["burger",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item To Hand
	["burger",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["burger",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["burgerbread",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["burgerbread",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["burgerbread",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["burgerbread",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["fishburger",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["fishburger",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["fishburger",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fishburger",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["taco",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["taco",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["taco",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["taco",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["wrench",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["wrench",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["wrench",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["wrench",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["cash",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["cash",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["cash",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["bucket",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["bucket",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["bucket",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["bucket",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["buoy",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["buoy",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["buoy",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["buoy",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["fireworkrocket",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["fireworkrocket",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["fireworkrocket",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fireworkrocket",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item

	//picking up seeds
	["seedbox",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["seedbox",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["seedbox",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["seedbox",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item

	//pickup corn and marijuana
	["cornCob",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["cornCob",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["cornCob",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["cornCob",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["weedbag",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["weedbag",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["weedbag",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["weedbag",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["lettuce",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["lettuce",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["lettuce",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["lettuce",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["salad",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["salad",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["salad",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["salad",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["tacoshell",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["tacoshell",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["tacoshell",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["tacoshell",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item

	["fish",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item
	["fish",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["fish",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fish",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item

	["fd_yadapter",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]}) && {(simulationEnabled player_objIntersect)}}],	 //Pickup Item
	["fd_yadapter",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]}) && {(simulationEnabled player_objIntersect)}}], //Pickup Item To Hand
	["fd_yadapter",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fd_yadapter",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["fd_hoseend",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]}) && {(!(typeOf player_objintersect IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]))}}],	 //Pickup Item
	["fd_hoseend",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]}) && {(simulationEnabled player_objIntersect)} && {(typeOf player_objintersect != "A3PL_FD_HoseEnd1_Float")} && {(!(typeOf player_objintersect IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]))}}],	 //Pickup Item To Hand
	["fd_hoseend",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fd_hoseend",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["fd_hoserolled",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item
	["fd_hoserolled",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["fd_hoserolled",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fd_hoserolled",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item
	["fd_mask",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item
	["fd_mask",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["fd_mask",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fd_mask",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["hydrantwrench",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["hydrantwrench",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item To Hand
	["hydrantwrench",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["hydrantwrench",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item
	["ore",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item
	["ore",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["ore",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["ore",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item

	["crate",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["crate",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["crate",localize"STR_INTSECT_COLLECTITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Collect Item
	["crate",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["crate",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item
	["clothing",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["clothing",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["clothing",localize"STR_INTSECT_COLLECTITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Collect Item
	["clothing",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["clothing",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item

	["Item_Pickup","Refuel Jerrycan",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{(typeOf player_objintersect isEqualTo 'A3PL_JerryCan') && (typeOf Player_Item) IN ["A3PL_Gas_Hose","A3PL_GasHose"]}],
	["Item_Pickup",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["Item_Pickup",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["Item_Pickup",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["Item_Pickup",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item
	["Item_Pickup",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand

	["deliverybox",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["deliverybox",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["deliverybox",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item

	//medical
	["spine3",localize"STR_A3PL_Medical_ChestCompressions","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{(Player_ActionCompleted) && {isPlayer player_objIntersect} && {!(player_objIntersect getVariable ["A3PL_Medical_Alive", true])}}], //Chest Compressions
	["spine3",localize"STR_INTSECT_OPENMEDICALMEN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") && {(Player_ActionCompleted)} && {isPlayer player_objIntersect}}], //Open Medical Menu

	//Ladder Actions
	["Ladder_1",localize"STR_INTSECT_PICKUPLAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeof player_objintersect == "A3PL_Ladder"}], //Pickup Ladder
	["Ladder_1",format [localize"STR_INTSECT_CLIMBUPL",1],_dir+"IGUI\Cfg\Actions\ladderup_ca.paa",{true}], //Climb Up Ladder %1
	["Ladder_2",format [localize"STR_INTSECT_CLIMBUPL",2],_dir+"IGUI\Cfg\Actions\ladderup_ca.paa",{true}],//Climb Up Ladder %1
	["Ladder_3",format [localize"STR_INTSECT_CLIMBUPL",3],_dir+"IGUI\Cfg\Actions\ladderup_ca.paa",{true}],//Climb Up Ladder %1
	["Ladder_4",format [localize"STR_INTSECT_CLIMBUPL",4],_dir+"IGUI\Cfg\Actions\ladderup_ca.paa",{true}],//Climb Up Ladder %1
	["Ladder_5",format [localize"STR_INTSECT_CLIMBUPL",5],_dir+"IGUI\Cfg\Actions\ladderup_ca.paa",{true}],//Climb Up Ladder %1
	["Ladder_1",format [localize"STR_INTSECT_CLIMBDOWNL",1],_dir+"IGUI\Cfg\Actions\ladderdown_ca.paa",{true}], //Climb Down Ladder %1
	["Ladder_2",format [localize"STR_INTSECT_CLIMBDOWNL",2],_dir+"IGUI\Cfg\Actions\ladderdown_ca.paa",{true}], //Climb Down Ladder %1
	["Ladder_3",format [localize"STR_INTSECT_CLIMBDOWNL",3],_dir+"IGUI\Cfg\Actions\ladderdown_ca.paa",{true}], //Climb Down Ladder %1
	["Ladder_4",format [localize"STR_INTSECT_CLIMBDOWNL",4],_dir+"IGUI\Cfg\Actions\ladderdown_ca.paa",{true}], //Climb Down Ladder %1
	["Ladder_5",format [localize"STR_INTSECT_CLIMBDOWNL",5],_dir+"IGUI\Cfg\Actions\ladderdown_ca.paa",{true}], //Climb Down Ladder %1
	["Ladder_1",localize"STR_INTSECT_EXRELADDER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeof player_objintersect == "A3PL_Ladder"}], //Extend/Retract Ladder

	//RBM
	["Door_1",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect IN A3PL_Player_Vehicles) && {(simulationEnabled player_objIntersect)} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_1",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])} && {(player_objintersect IN ["A3PL_RBM","A3FL_LCM"])}}], //Enter as Driver
	["Door_1",localize"STR_INTSECT_ENTERASENG","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])} && {(player_objintersect isKindOf "A3PL_RBM")}}], //Enter as Engineer
	["Door_1",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])} && {(player_objintersect isKindOf "A3PL_RBM")}}], //Enter as passanger
	["Door_1",localize"STR_INTSECT_ENTASCAP","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])} && {(player_objintersect isKindOf "A3PL_RBM")}}], //Enter as Captain
	["Door_1",localize"STR_INTSECT_ENTERASGUN","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])} && {(player_objintersect isKindOf "A3PL_RBM")}}], //Enter as Gunner
	["Bow_Gun",localize"STR_INTSECT_ENTERASBOWG","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])} && {(player_objintersect isKindOf "A3PL_RBM")}}], //Enter as Bow Gunner

	["Lifebuoy_1_action",localize"STR_INTSECT_GRABLLB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Grab Left Lifebuoy
	["Lifebuoy_1_action",localize"STR_INTSECT_PUTBACKLLB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Put Back Left Lifebuoy
	["Lifebuoy_2_action",localize"STR_INTSECT_GRABRLB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Grab Right Lifebuoy
	["Lifebuoy_2_action",localize"STR_INTSECT_PBRLIFEB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Put Back Right Lifebuoy

	["Item_Pickup",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && (typeOf player_objintersect == "A3PL_Lifebuoy")}], //Enter as Passenger
	["Item_Pickup",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player)&& (typeOf player_objintersect == "A3PL_Lifebuoy")}], //Exit Vehicle
	["Item_Pickup",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])&& (typeOf player_objintersect == "A3PL_Lifebuoy")}], //Eject All Passengers

	["Platform_1",localize"STR_INTSECT_TOGLPF",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Toggle Left Platform
	["Platform_2",localize"STR_INTSECT_TOGRPF",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Toggle Right Platform

	["Anchor",localize"STR_INTSECT_ANCHOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],//Drop/Retrieve Anchor

	// Locker
	["Door_1",localize"STR_INTSECT_BUYLOCKER",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((player_objIntersect getVariable ["owner",""]) isEqualTo "") && (typeOf player_objintersect isEqualTo "A3PL_EMS_Locker") && (player getVariable["job","unemployed"] IN ["fifr","uscg","fisd","doj","dmv","usms"])}],
	["Door_1",localize"STR_INTSECT_OCLOCKERDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((player_objIntersect getVariable ["owner",""]) isEqualTo getPlayerUID player) && (typeOf player_objintersect isEqualTo "A3PL_EMS_Locker")}],
	["lockerbottom",localize"STR_INTSECT_LOCKERSTORE","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player_objIntersect getVariable ["owner",""]) isEqualTo getPlayerUID player) && (typeOf player_objintersect isEqualTo "A3PL_EMS_Locker")}],
	["lockertop",localize"STR_INTSECT_LOCKERSTORE","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player_objIntersect getVariable ["owner",""]) isEqualTo getPlayerUID player) && (typeOf player_objintersect isEqualTo "A3PL_EMS_Locker")}],

	//Common Cars Doors
	["doorL",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["doorL",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& {(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}}], //Open\Close Door
	["doorL",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Driver
	["doorL",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["doorL",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && {!(player_objIntersect getVariable ["locked",true])} && {(!(vehicle player getVariable ["trapped",false]))} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["doorL",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Detain Suspect
	["doorL",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Eject All Passengers
	["doorR",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["doorR",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}}], //Open\Close Door
	["doorR",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}], //Enter as Driver
	["doorR",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["doorR",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && {!(player_objIntersect getVariable ["locked",true])} && {(!(vehicle player getVariable ["trapped",false]))} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["doorR",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Detain Suspect
	["doorR",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Eject All Passengers

	//Little bird interactions
	["z_doorl_front",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}],
	["z_doorr_front",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}],
	["z_doorr_back",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}],
	["z_doorl_back",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}],
	["z_doorl_front",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["z_doorr_front",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors

	// Cessna172 passenger
	["Pilot_Door",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])} && {(typeof player_objintersect == "A3PL_Cessna172")}}], //Enter as Passenger
	["CoPilot_Door",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])} && {(typeof player_objintersect == "A3PL_Cessna172")}}], //Enter as Passenger
	["Door_LF",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && {!(player_objIntersect getVariable ["locked",true])} && {(!(vehicle player getVariable ["trapped",false]))} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LF",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LF",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Eject All Passengers
	["Door_LF",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Detain Suspect
	["Door_LF",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk","A3PL_Suburban","A3PL_Actros","A3PL_CLS63","A3PL_Taurus"])}}], //Open\Close Door
	["Door_LF",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LF2",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}],//Enter as Passenger
	["Door_LF2",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && {!(player_objIntersect getVariable ["locked",true])} && {(!(vehicle player getVariable ["trapped",false]))} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LF2",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LF2",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Eject All Passengers
	["Door_LF2",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Detain Suspect
	["Door_LF2",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}}], //Open\Close Door
	["Door_LF2",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LF3",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}],//Enter as Passenger
	["Door_LF3",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && {!(player_objIntersect getVariable ["locked",true])} && {(!(vehicle player getVariable ["trapped",false]))} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LF3",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LF3",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Eject All Passengers
	["Door_LF3",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Detain Suspect
	["Door_LF3",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}}], //Open\Close Door
	["Door_LF3",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LF4",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}],//Enter as Passenger
	["Door_LF4",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && {!(player_objIntersect getVariable ["locked",true])} && {(!(vehicle player getVariable ["trapped",false]))} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LF4",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LF4",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Eject All Passengers
	["Door_LF4",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Detain Suspect
	["Door_LF4",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}}], //Open\Close Door
	["Door_LF4",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LF5",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}],//Enter as Passenger
	["Door_LF5",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && {!(player_objIntersect getVariable ["locked",true])} && {(!(vehicle player getVariable ["trapped",false]))} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LF5",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LF5",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Eject All Passengers
	["Door_LF5",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Detain Suspect
	["Door_LF5",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}}], //Open\Close Door
	["Door_LF5",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LF6",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {!(player_objIntersect getVariable ["locked",true])}}],//Enter as Passenger
	["Door_LF6",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && {!(player_objIntersect getVariable ["locked",true])} && {(!(vehicle player getVariable ["trapped",false]))} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LF6",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LF6",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Eject All Passengers
	["Door_LF6",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])}}], //Detain Suspect
	["Door_LF6",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && {(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}}], //Open\Close Door
	["Door_LF6",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle

	["Door_LB",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LB",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LB",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_LB",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_LB",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk","A3PL_Suburban","A3PL_CLS63","A3PL_Taurus"])}],
	["Door_LB",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LB2",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB2",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LB2",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LB2",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_LB2",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_LB2",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LB2",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LB3",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB3",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LB3",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LB3",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_LB3",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_LB3",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LB3",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LB4",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB4",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LB4",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LB4",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_LB4",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_LB4",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LB4",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LB5",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB5",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LB5",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LB5",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_LB5",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_LB5",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LB5",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LB6",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB6",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_LB6",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_LB6",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_LB6",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_LB6",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LB6",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle

	["Door_RF",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RF",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RF",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RF",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RF",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk","A3PL_Suburban","A3PL_CLS63","A3PL_GMCVandura","A3PL_Taurus"])}], //Open\Close Door
	["Door_RF",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RF2",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF2",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RF2",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RF2",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RF2",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RF2",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RF2",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RF3",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF3",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RF3",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RF3",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RF3",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RF3",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RF3",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RF4",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF4",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RF4",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RF4",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RF4",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RF4",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RF4",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RF5",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF5",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RF5",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RF5",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RF5",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RF5",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RF5",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RF6",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF6",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RF6",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RF6",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RF6",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RF6",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RF6",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle

	["Door_RB",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RB",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RB",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RB",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RB",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk","A3PL_Suburban"])}], //Open\Close Door
	["Door_RB",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle

	["Door_RB2",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB2",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RB2",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RB2",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RB2",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RB2",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RB2",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RB3",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB3",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RB3",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RB3",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RB3",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RB3",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RB3",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RB4",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB4",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RB4",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RB4",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RB4",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RB4",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RB4",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RB5",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB5",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RB5",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RB5",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RB5",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RB5",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RB5",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RB6",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB6",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && !(player_objIntersect getVariable ["locked",true]) && (!(vehicle player getVariable ["trapped",false])) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}],		 //Exit Vehicle
	["Door_RB6",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{((player_objintersect IN A3PL_Player_Vehicles) || (vehicle player isEqualTo player_objintersect)) && {!(player getVariable ["Cuffed",false])} && {!(player getVariable ["Zipped",false])}}], //Lock/Unlock Vehicle Doors
	["Door_RB6",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Eject All Passengers
	["Door_RB6",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])}], //Detain Suspect
	["Door_RB6",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RB6",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle

	["Door_LF",localize"STR_INTSECT_ENTCOPIL","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(player_objintersect isKindOf "Air") && (vehicle player == player)&& !(player_objIntersect getVariable ["locked",true])}], ////Enter as Co-Pilot
	["Cargo_Door_1",format [localize"STR_INTSECT_OCCOMPT",1],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_2",format [localize"STR_INTSECT_OCCOMPT",2],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_3",format [localize"STR_INTSECT_OCCOMPT",3],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_4",format [localize"STR_INTSECT_OCCOMPT",4],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_5",format [localize"STR_INTSECT_OCCOMPT",5],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_6",format [localize"STR_INTSECT_OCCOMPT",6],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_7",format [localize"STR_INTSECT_OCCOMPT",7],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_8",format [localize"STR_INTSECT_OCCOMPT",8],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_9",format [localize"STR_INTSECT_OCCOMPT",9],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_10",format [localize"STR_INTSECT_OCCOMPT",10],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_11",format [localize"STR_INTSECT_OCCOMPT",11],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_12",format [localize"STR_INTSECT_OCCOMPT",12],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_13",format [localize"STR_INTSECT_OCCOMPT",13],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_14",format [localize"STR_INTSECT_OCCOMPT",14],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_15",format [localize"STR_INTSECT_OCCOMPT",15],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_16",format [localize"STR_INTSECT_OCCOMPT",16],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_17",format [localize"STR_INTSECT_OCCOMPT",17],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_18",format [localize"STR_INTSECT_OCCOMPT",18],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_19",format [localize"STR_INTSECT_OCCOMPT",19],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_20",format [localize"STR_INTSECT_OCCOMPT",20],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],

	["trunk",localize"STR_INTSECT_OPCLTRUNK","\a3\ui_f\data\gui\cfg\Hints\doors_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open/Close Trunk
	["trunkinside",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside1",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside2",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside3",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside4",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside5",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside6",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside7",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside8",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside9",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside10",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside11",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside12",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside13",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside14",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside15",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside16",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside17",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside18",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside19",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item
	["trunkinside20",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{vehicle player isEqualTo player}], //Place Item

	["door1",localize"STR_INTSECT_ENTERDRIVER",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {(!(player_objIntersect getVariable ["locked",true]))} && {(typeOf player_objintersect IN Config_Arma_Vehs)}}],//Enter as Passenger
	["door1",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {(simulationEnabled player_objIntersect)} && {(!(player_objIntersect getVariable ["locked",true]))} && {(typeOf player_objintersect IN Config_Arma_Vehs)}}],		 //Exit Vehicle
	["door1",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect IN A3PL_Player_Vehicles) && {(typeOf player_objintersect IN Config_Arma_Vehs)}}], //Lock/Unlock Vehicle Doors
	["door1",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])} && {(typeOf player_objintersect IN Config_Arma_Vehs)}}], //Eject All Passengers
	["door1",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) &&  {((player getVariable "job") IN ["uscg","fisd","usms"])} && {(typeOf player_objintersect IN Config_Arma_Vehs)}}], //Detain Suspect
	["door1",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"&&{(typeOf player_objintersect IN Config_Arma_Vehs)}}], //Repair Vehicle

	["door2",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && (!(player_objIntersect getVariable ["locked",true])) && {(typeOf player_objintersect IN Config_Arma_Vehs)}}],//Enter as Passenger
	["door2",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && (!(player_objIntersect getVariable ["locked",true]))&&{(typeOf player_objintersect IN Config_Arma_Vehs)}}],		 //Exit Vehicle
	["door2",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect IN A3PL_Player_Vehicles) && {(typeOf player_objintersect IN Config_Arma_Vehs)}}], //Lock/Unlock Vehicle Doors
	["door2",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])} && {(typeOf player_objintersect IN Config_Arma_Vehs)}}], //Eject All Passengers
	["door2",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && {((player getVariable "job") IN ["uscg","fisd","usms"])} && {(typeOf player_objintersect IN Config_Arma_Vehs)}}], //Detain Suspect
	["door2",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench" && {(typeOf player_objintersect IN Config_Arma_Vehs)}}], //Repair Vehicle

	["door3",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && (simulationEnabled player_objIntersect) && (!(player_objIntersect getVariable ["locked",true])) && (typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}],//Enter as Passenger
	["door3",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) isEqualTo player) && (!(player_objIntersect getVariable ["locked",true]))&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}],		 //Exit Vehicle
	["door3",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect IN A3PL_Player_Vehicles)&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}], //Lock/Unlock Vehicle Doors
	["door3",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}], //Eject All Passengers
	["door3",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) isEqualTo player) && ((player getVariable "job") IN ["uscg","fisd","usms"])&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}], //Detain Suspect
	["door3",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}], //Repair Vehicle

	["door1",localize"STR_INTSECT_DRVDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["C_Van_02_transport_F"])}],
	["door2",localize"STR_INTSECT_PSGDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["C_Van_02_transport_F"])}],
	["door3",localize"STR_INTSECT_LATDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["C_Van_02_transport_F"])}],

	["Door_1","Lockpick Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf (call A3PL_Intersect_cursortarget)) IN Config_Houses_List)}}],
	["Door_1","Secure House",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect getVariable "robbed") && {(player getVariable "job" isEqualTo "fisd")}}],

	["cell_door_1","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_2","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_3","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_4","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_5","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_6","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_7","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_8","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_9","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_10","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_11","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_12","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_13","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],
	["cell_door_14","Lockpick Cell Door",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_Itemclass isEqualTo "v_lockpick") && {((typeOf player_objIntersect) != "Land_A3PL_Sheriffpd")}}],

	["item_pickup","Seize Item","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player_objintersect getVariable["class",""]) IN Player_illegalItems) && {(player getVariable["job","unemployed"] IN ["fisd","uscg","usms"])}}],
	["item_pickup","Enter into Evidince","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player_objintersect getVariable["class",""]) IN Player_IllegalPhysicalItems) && {(player getVariable["job","unemployed"] IN ["fisd","uscg","usms"])}}],
	["buoy","Seize Item","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{(player getVariable["job","unemployed"] IN ["fisd","uscg","usms"])}],
	["shipramp","Ship Ramp","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{}]
];
publicVariable "Config_IntersectArray";

//If a specific intersection name is in this array it will execute and not check for a specific typeOf aka it ignores that parameter
Config_GenArray =
[
	"Break Glass",
	"Open/Close Safe",
	"Secure Gang Hideout",
	"Enter into Evidince",
	"Talk to the Ship Captain",
	"Big Dicks Sports Store",
	localize"STR_INTSECT_IMPNEARVEH",
	"Ship Ramp",
	"Purchase Warehouse",
	"Chemical Dealer",
	localize"STR_QuickActionsNPC_FakeID",
	"Produce Cocaine Base",
	"Remove Barrel Contents",
	"Produce Coca Paste",
	"Check Barrel Contents",
	"Add Item",
	"Collect Product",
	"Seize Item",
	"Remove Mask",
	"Harvest Mushrooms",
	"Search Trash",
  	"Secure House",
	"Lockpick Door",
	"Lockpick Cell Door",
	localize"STR_INTSECT_HITCHFOLD",
	"Toggle Gooseneck",
	localize"STR_INTSECT_SPVHINGAR",
	localize"STR_INTSECT_OPIMEXMENU",
	localize"STR_INTSECT_UPLWRAMP",
	localize"STR_INTSECT_TrashSlideLeft",
	localize"STR_INTSECT_TrashLwLeft",
	localize"STR_INTSECT_TrashSlideRight",
	localize"STR_INTSECT_TrashLwRight",
	localize"STR_INTSECT_TrashClose",
	localize"STR_QuickActionsNPC_StationStore",
	format [localize"STR_INTSECT_TOGSTARENG",1],
	format [localize"STR_INTSECT_TOGSTARENG",2],
	format [localize"STR_INTSECT_THROTCL",1],
	format [localize"STR_INTSECT_THROTCL",2],
	localize"STR_INTSECT_TOGATCR",
	localize"STR_INTSECT_TOGBATT",
	localize"STR_INTSECT_TOGHEADL",
	localize"STR_INTSECT_TOGROTBR",
	format [localize"STR_INTSECT_INSPENG",1],
	format [localize"STR_INTSECT_INSPENG",2],
	format [localize"STR_INTSECT_INSPMAINROT",1],
	format [localize"STR_INTSECT_INSPMAINROT",2],
	format [localize"STR_INTSECT_INSPMAINROT",3],
	format [localize"STR_INTSECT_INSPMAINROT",4],
	format [localize"STR_INTSECT_INSPTAILROT","#1"],
	format [localize"STR_INTSECT_INSPTAILROT","#2"],
	format [localize"STR_INTSECT_INSPTAILROT","Hub"],
	localize"STR_INTSECT_INSPTRANS",
	localize"STR_INTSECT_INSPFUEL",
	format [localize"STR_INTSECT_INSPGEAR",1],
	format [localize"STR_INTSECT_INSPGEAR",2],
	format [localize"STR_INTSECT_INSPGEAR",3],
	format [localize"STR_INTSECT_INSPGEAR",4],
	format [localize"STR_INTSECT_INSPHORSTAB",1],
	format [localize"STR_INTSECT_INSPHORSTAB",2],
	localize "STR_INTSECT_INSPLL",
	format [localize"STR_INTSECT_INSPPTUB",1],
	format [localize"STR_INTSECT_INSPPTUB",2],
	format [localize"STR_INTSECT_INSPSTP",1],
	format [localize"STR_INTSECT_INSPSTP",2],
	localize"STR_INTSECT_INSPVERSTAB",
	format [localize"STR_INTSECT_INSPINT",1],
	format [localize"STR_INTSECT_INSPINT",2],
	"Toggle Left Engine Hatch",
	"Toggle Right Engine Hatch",
	localize"STR_INTSECT_SITDOWN",
	localize"STR_INTSECT_LAYDOWN",
	localize"STR_INTSECT_GETUP",
	localize"STR_INTSECT_DOOR",
	localize"STR_INTSECT_USEDOORB",
	localize"STR_INTSECT_TURNONLIGHTS",
	localize"STR_INTSECT_TURNONALLL",
	localize"STR_INTSECT_TOGCOLLIGHT",
	localize"STR_INTSECT_HITCHTRLER",
	localize"STR_INTSECT_UNHITCHTRL",
	localize"STR_INTSECT_HIGHBEAM",
	localize"STR_INTSECT_OPCLTRAILD",
	localize"STR_INTSECT_LRTRAILERR",
	localize"STR_INTSECT_GARAGEDOOR",
	localize"STR_INTSECT_PATDOWN",
	localize"STR_INTSECT_CUFFUN",
	localize"STR_INTSECT_LPCUFF",
	localize"STR_INTSECT_ZIPUN",
	localize"STR_QuickActionsBuildings_CheckFireAlarm",
	localize"STR_QuickActionsBuildings_TriggerFireAlarm",
	localize"STR_QuickActionsBuildings_ReEnableFireAlarm",
	localize"STR_QuickActionsBuildings_RepairFireAlarm",
	localize"STR_INTSECT_ENTERDRIVER",
	localize"STR_INTSECT_ENTASPASS",
	localize"STR_INTSECT_EXITVEH",
	localize"STR_INTSECT_IGNITION",
	localize"STR_INTSECT_TOGLIGHTB",
	localize"STR_INTSECT_TOGSIR",
	format [localize"STR_INTSECT_TOGMANUAL",1],
	format [localize"STR_INTSECT_TOGMANUAL",2],
	format [localize"STR_INTSECT_TOGMANUAL",3],
	localize"STR_INTSECT_TOGHEADL",
	localize"STR_INTSECT_OPCLTRUNK",
	localize"STR_INTSECT_SPINSIGN",
	localize"STR_INTSECT_USEPOLRAD",
	localize"STR_INTSECT_PLACEITEM",
	localize"STR_INTSECT_TGLFAIRAVAIL",
	localize"STR_INTSECT_PAUSEFAIR",
	localize"STR_INTSECT_RESETFAIR",
	localize"STR_INTSECT_STARTFAIR",
	localize"STR_INTSECT_STOPFAIR",
	format [localize"STR_INTSECT_CLIMBUPL",1],
	format [localize"STR_INTSECT_CLIMBUPL",2],
	format [localize"STR_INTSECT_CLIMBUPL",3],
	format [localize"STR_INTSECT_CLIMBUPL",4],
	format [localize"STR_INTSECT_CLIMBUPL",5],
	format [localize"STR_INTSECT_CLIMBDOWNL",1],
	format [localize"STR_INTSECT_CLIMBDOWNL",2],
	format [localize"STR_INTSECT_CLIMBDOWNL",3],
	format [localize"STR_INTSECT_CLIMBDOWNL",4],
	format [localize"STR_INTSECT_CLIMBDOWNL",5],
	localize"STR_INTSECT_PICKUPLAD",
	localize"STR_INTSECT_EXRELADDER",
	localize"STR_INTSECT_DETAINSUS",
	localize"STR_INTSECT_EJALLPASS",
	localize"STR_INTSECT_LOUNDOOR",
	localize"STR_INTSECT_VEHSTOR",
	localize"STR_INTSECT_STOREVEH",
	localize"STR_INTSECT_OBJSTOR",
	localize"STR_INTSECT_STOREOBJ",
	localize"STR_QuickActionsNPC_TalkToTheMcFishersEmpl",
	localize"STR_QuickActionsNPC_TakeMcFishersUniform",
	localize"STR_QuickActionsNPC_TalkToTheTacoHellEmpl",
	localize"STR_QuickActionsNPC_TakeTacoHellUniform",
	localize"STR_QuickActionsNPC_TalkToTheFisherMan",
	localize"STR_QuickActionsNPC_TalkToTheDoctorWithoutDiploma",
	localize"STR_QuickActionsNPC_TalkToTheDoctorGuard",
	localize"STR_QuickActionsNPC_TalkToTheBankEmployee",
	localize"STR_QuickActionsNPC_TalkToTheFreight",
	localize"STR_QuickActionsNPC_TalkToInsurer",
	localize"STR_QuickActionsNPC_TalkToPort",
	localize"STR_QuickActionsNPC_TalkToUSCGOfficer",
	localize"STR_QuickActionsNPC_TalkToTheSupermarket",
	localize"STR_QuickActionsNPC_TalkToTheSupermarket2",
	localize"STR_QuickActionsNPC_SpeaktoAdherent",
	localize"STR_QuickActionsNPC_SpeaktoThingsPerk",
	localize"STR_QuickActionsNPC_RentATowTruck",
	localize"STR_QuickActionsNPC_CCTVSilverton",
	localize"STR_QuickActionsNPC_CCTVElk",
	localize"STR_QuickActionsNPC_CCTVCentral",
	localize"STR_QuickActionsNPC_CCTVNorthdale",
	localize"STR_QuickActionsNPC_RemoveElectronicBracelet",
	localize"STR_QuickActionsNPC_ResellNearVehicle",
	localize"STR_QuickActionsNPC_AccessPrisonShop",
	localize"STR_QuickActionsNPC_TalkToTheRoadService2",
	localize"STR_QuickActionsNPC_TalkToTheFermer",
	localize"STR_QuickActionsNPC_TalkToTheOilExtractor",
	localize"STR_QuickActionsNPC_TalkToTheDrugDealer",
	localize"STR_QuickActionsNPC_TalkToTheBlackMarket",
	localize"STR_QuickActionsNPC_TalkToTheGunsVendor",
	localize"STR_QuickActionsNPC_VehiclesFactory",
	localize"STR_QuickActionsNPC_FactionAccount",
	localize"STR_QuickActionsNPC_TalkToTheHunter",
	localize"STR_INTSECT_CONVSTOLMONEY",
	localize"STR_QuickActionsNPC_AccessShopGems",
	localize"STR_QuickActionsNPC_BuySellHalloweenItems",
	localize"STR_QuickActionsNPC_BuySellChristmasItems",
	localize"STR_QuickActionsNPC_AccessShopSupply",
	localize"STR_INTSECT_CAPTSHIP",
	localize"STR_QuickActionsNPC_CatpuredShip",
	localize"STR_QuickActionsNPC_AccessShopSupply2",
	localize"STR_QuickActionsNPC_AccessShopFIMS",
	localize"STR_QuickActionsNPC_AccessShopFIFR",
	localize"STR_QuickActionsNPC_AccessShopVFD",
	localize"STR_QuickActionsNPC_AccessHardwareShop",
	localize"STR_QuickActionsNPC_AccessGeneralShop",
	localize"STR_QuickActionsNPC_PaintBallShop",
	localize"STR_QuickActionsNPC_Store",
	"Moonshine Trader",
	localize"STR_QuickActionsNPC_BucheronShop",
	localize"STR_QuickActionsNPC_AccessShopWaste",
	localize"STR_QuickActionsNPC_TalkToTheDMVNPC",
	localize"STR_QuickActionsNPC_StartStopWaste",
	localize"STR_QuickActionsNPC_StartStopDelivery",
	localize"STR_QuickActionsNPC_KartRent",
	localize"STR_QuickActionsNPC_PriseServiceUSMS",
	localize"STR_QuickActionsNPC_TalkToSheriff",
	localize"STR_QuickActionsNPC_PriseServiceDOJ",
	localize"STR_QuickActionsNPC_TakeFuelStationCash",
	localize"STR_QuickActionsNPC_RobShop",
	localize"STR_QuickActionsNPC_SecureShop",
	localize"STR_QuickActionsNPC_AccessSeedShop",
	localize"STR_QuickActionsNPC_AccessFIFRVEHShop",
	localize"STR_QuickActionsNPC_AccessUSCGShop",
	localize"STR_QuickActionsNPC_AccessUSCGPilotShop",
	localize"STR_QuickActionsNPC_AccessUSCGVehShop",
	localize"STR_QuickActionsNPC_AccessUSCGBoatShop",
	localize"STR_QuickActionsNPC_AccessUSCGAirShop",
	localize"STR_QuickActionsNPC_AccessFIFRAirShop",
	localize"STR_QuickActionsNPC_AccessUSCGArmory",
	localize"STR_INTSECT_TOGDOZBLAD",
	localize"STR_INTSECT_DETATTACHM",
	localize"STR_INTSECT_CONNBUCKET",
	localize"STR_INTSECT_CONNJACKHAM",
	localize"STR_INTSECT_CONNECTCLAW",
	"Refuel Jerrycan",
	localize"STR_INTSECT_PICKUPITEM",
	localize"STR_INTSECT_PickupDeliveryBox",
	localize"STR_INTSECT_PICKITEMTOHAND",
	localize"STR_INTSECT_CREATEFISHB",
	localize"STR_INTSECT_OPCLJAILD",
	localize"STR_INTSECT_USEATM",
	localize"STR_INTSECT_BUSEITEM",
	localize"STR_INTSECT_DRAG",
	localize"STR_INTSECT_DRAGH",
	localize"STR_INTSECT_Grab",
	localize"STR_INTSECT_KICKDOWN",
	localize"STR_INTSECT_LUVEHDOORS",
 	localize"STR_INTSECT_REPVEH",
	localize"STR_INTSECT_HANDTICKET",
	localize"STR_INTSECT_PICKUPKEY",
	localize"STR_INTSECT_LRRAMP",
	localize"STR_INTSECT_KNOCKONDOOR",
	localize"STR_INTSECT_HARPLANT",
	localize"STR_INTSECT_ENTERDRIVER",
	localize"STR_INTSECT_ENTERASENG",
	localize"STR_INTSECT_ENTASCAP",
	localize"STR_INTSECT_ENTERASGUN",
	localize"STR_INTSECT_ENTERASBOWG",
	localize"STR_INTSECT_TOGREARSPOTL",
	localize"STR_INTSECT_LoadVehicle",
	localize"STR_INTSECT_UnloadVehicle",
	localize"STR_INTSECT_TOGGRAMP",
	localize"STR_INTSECT_TOGLPF",
	localize"STR_INTSECT_TOGRPF",
	localize"STR_INTSECT_OPENMEDICALMEN",
	localize"STR_A3PL_Medical_ChestCompressions",
	localize"STR_INTSECT_REDRARM",
	localize"STR_INTSECT_REDRARMD",
	localize"STR_INTSECT_STARTJPUMP",
	localize"STR_INTSECT_OPK9MEN",
	localize"STR_INTSECT_PLACEBURGER",
	localize"STR_INTSECT_BUSENET",
	localize"STR_INTSECT_COLLNET",
	localize"STR_INTSECT_DEPLNET",
	localize"STR_INTSECT_BaitNet",
	localize"STR_INTSECT_BUSEBUCK",
	localize"STR_INTSECT_AIRSUSCONT",
	localize"STR_INTSECT_SWITCHIGN",
	localize"STR_INTSECT_SWITCHIGN2",
	localize"STR_INTSECT_SWITCHBAT",
	localize"STR_INTSECT_APUGEN",
	format [localize"STR_INTSECT_ENGGEN",1],
	format [localize"STR_INTSECT_ENGGEN",2],
	localize"STR_INTSECT_APUCONT",
	localize"STR_INTSECT_ECSSTART",
	localize"STR_INTSECT_FUELPUMP",
	localize"STR_INTSECT_UNFOJAYHWK",
	localize"STR_INTSECT_COCKLIGHT",
	localize"STR_INTSECT_TOGGLESL",
	localize"STR_INTSECT_CONHOSETTANK",
	localize"STR_INTSECT_CONGASHOSE",
	localize"STR_INTSECT_GRABGASHOSE",
	localize"STR_INTSECT_TOGGLEFUELP",
	localize"STR_INTSECT_RETGASHOSE",
	localize"STR_INTSECT_TOGGLEFLOATS",
	localize"STR_INTSECT_TOGGLEFP",
	localize"STR_INTSECT_TOGGLEFP",
	localize"STR_INTSECT_TOGGLEBAT",
	localize"STR_INTSECT_ADJFLUP",
	localize"STR_INTSECT_ADJFLDWN",
	localize"STR_INTSECT_SWITCHGEN",
	localize"STR_INTSECT_ENTCOPIL",
	localize"STR_QuickActionsNPC_BuyMapIron",
	localize"STR_QuickActionsNPC_BuyMapCharcoal",
	localize"STR_QuickActionsNPC_BuyMapAluminium",
	localize"STR_QuickActionsNPC_BuyMapSulfur",
	localize"STR_QuickActionsNPC_BuyMapOil",
	format [localize"STR_INTSECT_OCCOMPT",1],
	format [localize"STR_INTSECT_OCCOMPT",2],
	format [localize"STR_INTSECT_OCCOMPT",3],
	format [localize"STR_INTSECT_OCCOMPT",4],
	format [localize"STR_INTSECT_OCCOMPT",5],
	format [localize"STR_INTSECT_OCCOMPT",6],
	format [localize"STR_INTSECT_OCCOMPT",7],
	format [localize"STR_INTSECT_OCCOMPT",8],
	format [localize"STR_INTSECT_OCCOMPT",9],
	format [localize"STR_INTSECT_OCCOMPT",10],
	format [localize"STR_INTSECT_OCCOMPT",11],
	format [localize"STR_INTSECT_OCCOMPT",12],
	format [localize"STR_INTSECT_OCCOMPT",13],
	format [localize"STR_INTSECT_OCCOMPT",14],
	format [localize"STR_INTSECT_OCCOMPT",15],
	format [localize"STR_INTSECT_OCCOMPT",16],
	format [localize"STR_INTSECT_OCCOMPT",17],
	format [localize"STR_INTSECT_OCCOMPT",18],
	format [localize"STR_INTSECT_OCCOMPT",19],
	format [localize"STR_INTSECT_OCCOMPT",20],
	"Toggle Mooring Line",
	format [localize"STR_INTSECT_ENTASGUN",1],
	format [localize"STR_INTSECT_ENTASGUN",2],
	format [localize"STR_INTSECT_ENTASGUN",3],
	format [localize"STR_INTSECT_ENTASGUN",4],
	format [localize"STR_INTSECT_ENTASGUN",5],
	format [localize"STR_INTSECT_ENTASGUN",6],
	format [localize"STR_INTSECT_ENTASGUN",7],
	format [localize"STR_INTSECT_ENTASGUN",8],
	format [localize"STR_INTSECT_ENTASGUN",9],
	format [localize"STR_INTSECT_ENTASGUN",10],
	format [localize"STR_INTSECT_ENTASGUN",11],
	format [localize"STR_INTSECT_ENTASGUN",12],
	format [localize"STR_INTSECT_ENTASGUN",13],
	format [localize"STR_INTSECT_ENTASGUN",14],
	format [localize"STR_INTSECT_ENTASGUN",15],
	format [localize"STR_INTSECT_ENTASGUN",16],
	format [localize"STR_INTSECT_ENTASGUN",17],
	format [localize"STR_INTSECT_ENTASGUN",18],
	format [localize"STR_INTSECT_ENTASGUN",19],
	format [localize"STR_INTSECT_ENTASGUN",20],
	format [localize"STR_INTSECT_SITINSEAT",1],
	format [localize"STR_INTSECT_SITINSEAT",2],
	format [localize"STR_INTSECT_SITINSEAT",3],
	format [localize"STR_INTSECT_SITINSEAT",4],
	format [localize"STR_INTSECT_SITINSEAT",5],
	format [localize"STR_INTSECT_SITINSEAT",6],
	format [localize"STR_INTSECT_SITINSEAT",7],
	format [localize"STR_INTSECT_SITINSEAT",8],
	format [localize"STR_INTSECT_SITINSEAT",9],
	format [localize"STR_INTSECT_SITINSEAT",10],
	format [localize"STR_INTSECT_SITINSEAT",11],
	format [localize"STR_INTSECT_SITINSEAT",12],
	format [localize"STR_INTSECT_SITINSEAT",13],
	format [localize"STR_INTSECT_SITINSEAT",14],
	format [localize"STR_INTSECT_SITINSEAT",15],
	format [localize"STR_INTSECT_SITINSEAT",16],
	format [localize"STR_INTSECT_SITINSEAT",17],
	format [localize"STR_INTSECT_SITINSEAT",18],
	format [localize"STR_INTSECT_SITINSEAT",19],
	format [localize"STR_INTSECT_SITINSEAT",20],
	format [localize"STR_INTSECT_SITINSEAT",21],
	format [localize"STR_INTSECT_SITINSEAT",22],
	format [localize"STR_INTSECT_SITINSEAT",23],
	format [localize"STR_INTSECT_SITINSEAT",24],
	format [localize"STR_INTSECT_SITINSEAT",25],
	format [localize"STR_INTSECT_SITINSEAT",26],
	format [localize"STR_INTSECT_SITINSEAT",27],
	format [localize"STR_INTSECT_SITINSEAT",28],
	format [localize"STR_INTSECT_SITINSEAT",29],
	format [localize"STR_INTSECT_SITINSEAT",30],
	format [localize"STR_INTSECT_SITINSEAT",31],
	format [localize"STR_INTSECT_SITINSEAT",32],
	format [localize"STR_INTSECT_SITINSEAT",33],
	format [localize"STR_INTSECT_SITINSEAT",34],
	format [localize"STR_INTSECT_SITINSEAT",35],
	format [localize"STR_INTSECT_SITINSEAT",36],
	format [localize"STR_INTSECT_SITINSEAT",37],
	format [localize"STR_INTSECT_SITINSEAT",38],
	format [localize"STR_INTSECT_SITINSEAT",39],
	format [localize"STR_INTSECT_SITINSEAT",40],
	format [localize"STR_INTSECT_SITINSEAT",41],
	format [localize"STR_INTSECT_SITINSEAT",42],
	format [localize"STR_INTSECT_SITINSEAT",43],
	format [localize"STR_INTSECT_SITINSEAT",44],
	format [localize"STR_INTSECT_SITINSEAT",45],
	format [localize"STR_INTSECT_SITINSEAT",46],
	format [localize"STR_INTSECT_SITINSEAT",47],
	format [localize"STR_INTSECT_SITINSEAT",48],
	format [localize"STR_INTSECT_SITINSEAT",49],
	format [localize"STR_INTSECT_SITINSEAT",50],
	localize"STR_INTSECT_MOVETODRIVER",
	localize"STR_INTSECT_MOVETOCOPIL",
	format [localize"STR_INTSECT_MOVTOGUNNR",1],
	format [localize"STR_INTSECT_MOVTOGUNNR",2],
	format [localize"STR_INTSECT_MOVTOGUNNR",3],
	format [localize"STR_INTSECT_MOVTOGUNNR",4],
	format [localize"STR_INTSECT_MOVTOGUNNR",5],
	format [localize"STR_INTSECT_MOVTOGUNNR",6],
	format [localize"STR_INTSECT_MOVTOGUNNR",7],
	format [localize"STR_INTSECT_MOVTOGUNNR",8],
	format [localize"STR_INTSECT_MOVTOGUNNR",9],
	format [localize"STR_INTSECT_MOVTOGUNNR",10],
	format [localize"STR_INTSECT_MOVTOGUNNR",11],
	format [localize"STR_INTSECT_MOVTOGUNNR",12],
	format [localize"STR_INTSECT_MOVTOGUNNR",13],
	format [localize"STR_INTSECT_MOVTOGUNNR",14],
	format [localize"STR_INTSECT_MOVTOGUNNR",15],
	format [localize"STR_INTSECT_MOVTOGUNNR",16],
	format [localize"STR_INTSECT_MOVTOGUNNR",17],
	format [localize"STR_INTSECT_MOVTOGUNNR",18],
	format [localize"STR_INTSECT_MOVTOGUNNR",19],
	format [localize"STR_INTSECT_MOVTOGUNNR",20],
	format [localize"STR_INTSECT_MOVETOSEAT",1],
	format [localize"STR_INTSECT_MOVETOSEAT",2],
	format [localize"STR_INTSECT_MOVETOSEAT",3],
	format [localize"STR_INTSECT_MOVETOSEAT",4],
	format [localize"STR_INTSECT_MOVETOSEAT",5],
	format [localize"STR_INTSECT_MOVETOSEAT",6],
	format [localize"STR_INTSECT_MOVETOSEAT",7],
	format [localize"STR_INTSECT_MOVETOSEAT",8],
	format [localize"STR_INTSECT_MOVETOSEAT",9],
	format [localize"STR_INTSECT_MOVETOSEAT",10],
	format [localize"STR_INTSECT_MOVETOSEAT",11],
	format [localize"STR_INTSECT_MOVETOSEAT",12],
	format [localize"STR_INTSECT_MOVETOSEAT",13],
	format [localize"STR_INTSECT_MOVETOSEAT",14],
	format [localize"STR_INTSECT_MOVETOSEAT",15],
	format [localize"STR_INTSECT_MOVETOSEAT",16],
	format [localize"STR_INTSECT_MOVETOSEAT",17],
	format [localize"STR_INTSECT_MOVETOSEAT",18],
	format [localize"STR_INTSECT_MOVETOSEAT",19],
	format [localize"STR_INTSECT_MOVETOSEAT",20],
	format [localize"STR_INTSECT_MOVETOSEAT",21],
	format [localize"STR_INTSECT_MOVETOSEAT",22],
	format [localize"STR_INTSECT_MOVETOSEAT",23],
	format [localize"STR_INTSECT_MOVETOSEAT",24],
	format [localize"STR_INTSECT_MOVETOSEAT",25],
	format [localize"STR_INTSECT_MOVETOSEAT",26],
	format [localize"STR_INTSECT_MOVETOSEAT",27],
	format [localize"STR_INTSECT_MOVETOSEAT",28],
	format [localize"STR_INTSECT_MOVETOSEAT",29],
	format [localize"STR_INTSECT_MOVETOSEAT",30],
	format [localize"STR_INTSECT_MOVETOSEAT",31],
	format [localize"STR_INTSECT_MOVETOSEAT",32],
	format [localize"STR_INTSECT_MOVETOSEAT",33],
	format [localize"STR_INTSECT_MOVETOSEAT",34],
	format [localize"STR_INTSECT_MOVETOSEAT",35],
	format [localize"STR_INTSECT_MOVETOSEAT",36],
	format [localize"STR_INTSECT_MOVETOSEAT",37],
	format [localize"STR_INTSECT_MOVETOSEAT",38],
	format [localize"STR_INTSECT_MOVETOSEAT",39],
	format [localize"STR_INTSECT_MOVETOSEAT",40],
	format [localize"STR_INTSECT_MOVETOSEAT",41],
	format [localize"STR_INTSECT_MOVETOSEAT",42],
	format [localize"STR_INTSECT_MOVETOSEAT",43],
	format [localize"STR_INTSECT_MOVETOSEAT",44],
	format [localize"STR_INTSECT_MOVETOSEAT",45],
	format [localize"STR_INTSECT_MOVETOSEAT",46],
	format [localize"STR_INTSECT_MOVETOSEAT",47],
	format [localize"STR_INTSECT_MOVETOSEAT",48],
	format [localize"STR_INTSECT_MOVETOSEAT",49],
	format [localize"STR_INTSECT_MOVETOSEAT",50],
	localize"STR_INTSECT_SIRENCONTR",
	localize"STR_INTSECT_MASTERON",
	localize"STR_INTSECT_SIRENMASTER",
	localize"STR_INTSECT_DIRECTCONTR",
	localize"STR_INTSECT_DIRECTMASTER",
	localize"STR_INTSECT_AIRHORN",
	localize"STR_INTSECT_ELECHORN",
	localize"STR_INTSECT_ELECAIRH",
	localize"STR_INTSECT_RUMBLERMAN",
	localize"STR_INTSECT_T3YELP",
	localize"STR_INTSECT_RADARMASTER",
	localize"STR_INTSECT_REARRADAR",
	localize"STR_INTSECT_FRONTRADAR",
	localize"STR_INTSECT_RESETLOCKFAST",
	localize"STR_INTSECT_TURNONOFFLAP",
	localize"STR_INTSECT_ACCPOLDB",
	localize"STR_INTSECT_SWIVELLAP",
	localize"STR_INTSECT_RIGHTALLLIGHT",
	localize"STR_INTSECT_LEFTALLLIGHT",
	localize"STR_INTSECT_TOGSPOTLIGHT",
	localize"STR_INTSECT_TOGCONTCOV",
	localize"STR_INTSECT_TOGDSFOUT",
	localize"STR_INTSECT_TOGDROUT",
	localize"STR_INTSECT_TOGPSFOUT",
	localize"STR_INTSECT_TOGPSROUT",
	localize"STR_INTSECT_TORADSOUT",
	localize"STR_INTSECT_TORAPSOUT",
	localize"STR_INTSECT_DSFLOODL",
	localize"STR_INTSECT_PSFLOODL",
	localize"STR_INTSECT_PERILIGHT",
	localize"STR_INTSECT_LADDERFLOODL",
	localize"STR_INTSECT_LADDERCAM",
	localize"STR_INTSECT_USESTRETCH",
	localize"STR_INTSECT_STORESTRETCH",
	localize"STR_INTSECT_GRABLLB",
	localize"STR_INTSECT_PUTBACKLLB",
	localize"STR_INTSECT_GRABRLB",
	localize"STR_INTSECT_PBRLIFEB",
	localize"STR_INTSECT_CLIMBINTYA",
	localize"STR_INTSECT_REARFLOODL",
	localize"STR_INTSECT_INTLIGHTS",
	localize"STR_INTSECT_ENTASLADOP",
	localize"STR_INTSECT_HOLDHOSEAD",
	localize"STR_INTSECT_CONHOSETAD",
	localize"STR_QuickActionsNPC_AccessMinerShop",
	localize"STR_INTSECT_RollupHose",
	localize"STR_INTSECT_OPCLDOOR",
	localize"STR_INTSECT_TONOFFPUMP",
	localize"STR_INTSECT_REVERSECAM",
	localize"STR_INTSECT_ENTCODR",
	localize"STR_INTSECT_LORALADRACK",
	localize"STR_INTSECT_TAKELADDER",
	localize"STR_INTSECT_PUTBACKLAD",
	format [localize"STR_INTSECT_PUTBACKHOSE",1],
	format [localize"STR_INTSECT_PUTBACKHOSE",2],
	format [localize"STR_INTSECT_PUTBACKHOSE",3],
	format [localize"STR_INTSECT_PUTBACKHOSE",4],
	format [localize"STR_INTSECT_PUTBACKHOSE",5],
	format [localize"STR_INTSECT_TAKEHOSE",1],
	format [localize"STR_INTSECT_TAKEHOSE",2],
	format [localize"STR_INTSECT_TAKEHOSE",3],
	format [localize"STR_INTSECT_TAKEHOSE",4],
	format [localize"STR_INTSECT_TAKEHOSE",5],
	localize"STR_INTSECT_UseDistributor",
	localize"STR_INTSECT_CasinoPlayPoker",
	localize"STR_INTSECT_CasinoSit01",
	localize"STR_INTSECT_CasinoSit02",
	localize"STR_INTSECT_CasinoSit03",
	localize"STR_INTSECT_CasinoSit04",
	localize"STR_INTSECT_CasinoSit05",
	localize"STR_INTSECT_CasinoSit06",
	localize"STR_INTSECT_CasinoSit07",
	localize"STR_INTSECT_CasinoSit08",
	localize"STR_INTSECT_BUYLOCKER",
	localize"STR_INTSECT_OPCLDOOR",
	localize"STR_INTSECT_OCLOCKERDOOR",
	localize"STR_INTSECT_LOCKERSTORE",
	localize"STR_INTSECT_CHECKITEM",
	localize"STR_INTSECT_COLLECTITEM",
	localize"STR_INTSECT_SELLITEM",
	localize"STR_INTSECT_BUYITEM",
	localize"STR_QuickActionsNPC_TalkToExterminator",
	localize"STR_QuickActionsNPC_ATCManager",
	localize"STR_QuickActionsNPC_ATCExit",
	localize"STR_QuickActionsNPC_OpenRadar",
	localize"STR_QuickActionsNPC_TakeRadio",
	localize"STR_QuickActionsNPC_ReadDecrees",
	localize"STR_QuickActionsNPC_OpenBusiness",
	localize"STR_QuickActionsNPC_BusinessManagement",
	localize"STR_QuickActionsNPC_ResignCompany",
	localize"STR_QuickActionsNPC_EnterpriseAccountManagment",
	localize"STR_QuickActionsNPC_GoodsFactory",
	localize"STR_QuickActionsNPC_FIFDManagment",
	localize"STR_QuickActionsNPC_USCGManagment",
	localize"STR_QuickActionsNPC_FISDManagment",
	localize"STR_QuickActionsNPC_DMVManagment",
	localize"STR_QuickActionsNPC_DOJManagment",
	localize"STR_QuickActionsNPC_USMSManagment",
	localize "STR_QuickActionsNPC_AccessWeaponsDOC",
	localize "STR_QuickActionsNPC_AccessSDWeaponsFISD",
	localize "STR_QuickActionsNPC_AccessUSMSCarVendor",
	localize "STR_QuickActionsNPC_AccessFISDCarVendor",
	localize "STR_QuickActionsNPC_AccessDMVCarVendor",
	localize "STR_QuickActionsNPC_AccessFISDSuppliesVendor",
	localize "STR_QuickActionsNPC_AccessDOJSuppliesVendor",
	localize "STR_QuickActionsNPC_AccessDMVSuppliesVendor",
	localize "STR_QuickActionsNPC_AccessUSMSSuppliesVendor",
	localize"STR_INTSECT_OPTREASINF",
	localize"STR_QuickActionsNPC_TalkToThePhoneOperator",
	localize"STR_QuickActionsNPC_WeaponIllegalShop",
	localize"STR_QuickActionsNPC_GamerPerkShop",
	localize"STR_QuickActionsNPC_GardenPerkShop",
	localize"STR_QuickActionsNPC_MancavePerkShop",
	localize"STR_QuickActionsNPC_WalldecorPerkShop",
	localize"STR_QuickActionsNPC_WinchesterPerkShop",
	localize"STR_INTSECT_OPENMEDICALMEN",
	localize"STR_INTSECT_USEJERRYC",
	localize"STR_INTSECT_USEJERRYC",
	localize"STR_INTSECT_FillBottle",
	localize"STR_QuickActionsNPC_ExterminatorShop",
	localize"STR_QuickActionsNPC_MailManShop",
	localize"STR_QuickActionsNPC_FISecurityService",
	localize"STR_QuickActionsNPC_SFPShop",
	localize"STR_QuickActionsNPC_VehiclesFactionFactory",
	localize"STR_QuickActionsNPC_AccessAcierie",
	localize"STR_QuickActionsNPC_AccessFoodFactory",
	localize"STR_QuickActionsNPC_OilRefinery",
	localize"STR_QuickActionsNPC_AccessVetements",
	localize"STR_QuickActionsNPC_AccessVetementsLunettes",
	localize"STR_QuickActionsNPC_AccessVetementsVestes",
	localize"STR_QuickActionsNPC_AccessVetementsChapeaux",
	localize"STR_QuickActionsNPC_SkinAnimal",
	localize"STR_INTSECT_TagMeat",
	localize"STR_INTSECT_GENERATORONOFF",
	localize"STR_INTSECT_GENERATORFUEL",
	localize"STR_QuickActionsNPC_AccessChemicalPlant",
	localize"STR_QuickActionsNPC_AccessFactoryLegalArms",
	localize"STR_QuickActionsNPC_WeaponIllegalFactory",
	localize"STR_QuickActionsNPC_VehiclePartsFactory",
	localize"STR_QuickActionsNPC_FactoryBoat",
	localize"STR_QuickActionsNPC_AirbuyFactory",
	localize"STR_INTSECT_TAKEBODY",
	localize"STR_INTSECT_HIDEOUTSHOP",
	"Low End Car Dealer",
	localize"STR_INTSECT_CONHOSETOENGIN",
	localize"STR_INTSECT_CONHOSETOENGDIS",
	localize"STR_INTSECT_OPCLINLET"
];
publicVariable "Config_GenArray";

Config_QuickActions =
[
	["",localize"STR_INTSECT_DOOR",{call A3PL_Intersect_HandleDoors;}],
	["",localize"STR_INTSECT_GARAGEDOOR",{call A3PL_Intersect_HandleDoors;}],
	["","Trunk",{private ["_obj"]; _obj = (call A3PL_Intersect_Cursortarget); if (_obj animationPhase "trunk" < 0.5) then {_obj animate ["trunk",1];} else {_obj animate ["trunk",0]};}],
	#include "QuickActions\Objects.sqf",
	#include "QuickActions\Vehicles.sqf",
	#include "QuickActions\Buildings.sqf",
	#include "QuickActions\NPC.sqf"
];
publicVariable "Config_QuickActions";
