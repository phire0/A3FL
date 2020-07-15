
Config_NPC_Text =
[
	["estate_initial", localize"STR_NPC_WELCOMEESTATE",[localize"STR_NPC_WELCOMEESTATE1",localize"str_NPC_WELCOMEESTATE2"],["if (player getVariable 'job' == 'RealEstate') exitwith {['estate_already'] call A3PL_NPC_Start;}; ['estate_work'] call A3PL_NPC_Start;",""]],
	["estate_work", localize"STR_NPC_ESTATEWORK",[localize"STR_NPC_ESTATEWORK1", localize"STR_NPC_ESTATEWORK2"],["['RealEstate'] call A3PL_NPC_TakeJob;",""]],
	["estate_already", localize"STR_NPC_ALREADYWORKING",[localize"STR_NPC_ALREADYWORKING1",localize"STR_NPC_ALREADYWORKING2"],["","call A3PL_NPC_LeaveJob;"]],
	["estate_accepted", localize"STR_NPC_ESTATEACCEPTED",[localize"STR_NPC_ESTATEACCEPTED1", localize"STR_NPC_ESTATEACCEPTED2"],["['estate_tutorial'] call A3PL_NPC_Start;",""]],
	["estate_tutorial", localize"STR_NPC_ESTATETUTORIAL",[localize"STR_NPC_ESTATETUTORIAL1"],[""]],

	["mcfishers_initial", localize"STR_NPC_WELCOMEMCF",[localize"str_NPC_WELCOMEMCF1",localize"str_NPC_WELCOMEMCF2"],["if (player getVariable 'job' == 'mcfisher') exitwith {['mcfishers_already'] call A3PL_NPC_Start;}; ['mcfishers_work'] call A3PL_NPC_Start;",""]],
	["mcfishers_work", localize"STR_NPC_MCFWORK",[localize"STR_NPC_MCFWORK1", localize"STR_NPC_MCFWORK2"],["['mcfisher'] call A3PL_NPC_TakeJob;",""]],
	["mcfishers_already", localize"STR_NPC_ALREADYWORKING",[localize"STR_NPC_ALREADYWORKING1",localize"STR_NPC_ALREADYWORKING2"],["","call A3PL_NPC_LeaveJob;"]],
	["mcfishers_accepted", localize"STR_NPC_MCFACCEPTED",[localize"STR_NPC_MCFACCEPTED1", localize"STR_NPC_MCFACCEPTED2"],["['mcfishers_tutorial'] call A3PL_NPC_Start;",""]],
	["mcfishers_tutorial", localize"STR_NPC_MCFTUTORIAL",[localize"STR_NPC_MCFTUTORIAL1"],[""]],

	["tacohell_initial", localize"STR_NPC_THINIT",[localize"STR_NPC_THINIT1",localize"STR_NPC_THINIT2"],["if (player getVariable 'job' == 'tacohell') exitwith {['tacohell_already'] call A3PL_NPC_Start;}; ['tacohell_work'] call A3PL_NPC_Start;",""]],
	["tacohell_work", localize"STR_NPC_THWORK",[localize"STR_NPC_THWORK1", localize"STR_NPC_THWORK2"],["['tacohell'] call A3PL_NPC_TakeJob;",""]],
	["tacohell_already", localize"STR_NPC_ALREADYWORKING",[localize"STR_NPC_ALREADYWORKING1",localize"STR_NPC_ALREADYWORKING2"],["","call A3PL_NPC_LeaveJob;"]],
	["tacohell_accepted", localize"STR_NPC_THACCEPTED",[localize"STR_NPC_THACCEPTED1", localize"STR_NPC_THACCEPTED2"],["['tacohell_tutorial'] call A3PL_NPC_Start;",""]],
	["tacohell_tutorial", localize"STR_NPC_THTUTORIAL",[localize"STR_NPC_THTUTORIAL1"],[""]],

	["fisherman_initial", localize"STR_NPC_HELLOWHOWHELP",[localize"STR_NPC_FISHMANINIT1",localize"STR_NPC_FISHMANINIT2",localize"STR_NPC_FISHMANINIT3"],["if (player getVariable 'job' == 'pecheur') exitwith {['fisherman_already'] call A3PL_NPC_Start;}; ['fisherman_work'] call A3PL_NPC_Start;","","['Shop_Fisherman'] call A3PL_Shop_open"]],
	["fisherman_work", localize"STR_NPC_FISHMANWORK",[localize"STR_NPC_FISHMANWORK1",localize"STR_NPC_FISHMANWORK2"],["['fisher'] call A3PL_NPC_TakeJob;",""]],
	["fisherman_already", localize"STR_NPC_FISHMANALREADY",[localize"STR_NPC_FISHMANALREADY1",localize"STR_NPC_FISHMANALREADY2"],["","call A3PL_NPC_LeaveJob;"]],
	["fisherman_accepted", localize"STR_NPC_FISHMANACCEPTED",[localize"STR_NPC_FISHMANACCEPTED1", localize"STR_NPC_FISHMANACCEPTED2"],["['fisherman_tutorial'] call A3PL_NPC_Start;",""]],
	["fisherman_tutorial", localize"STR_NPC_FISHMANTUTORIAL",[localize"STR_NPC_FISHMANTUTORIAL1"],[""]],

	["bank_initial", localize"STR_NPC_BANKINIT",[localize"STR_NPC_BANKINIT1",localize"STR_NPC_BANKINIT2"],["if (Player_Paycheck < 1 ) then {['bank_paycheckrefuse'] call A3PL_NPC_Start;} else {['bank_paycheckaccepted'] call A3PL_NPC_Start;};","call A3PL_ATM_Open;"]],
	["bank_paycheckrefuse", localize"STR_NPC_BANKPCREF",[localize"STR_NPC_BANKPCREF1"],[""]],
	["bank_paycheckaccepted", localize"STR_NPC_BANKPCACC",[localize"STR_NPC_BANKPCACC1",localize"STR_NPC_BANKPCACC2"],["call A3PL_Player_PickupPaycheck;",""]],

	["uscg_initial",localize"STR_NPC_USCGINIT",[localize"STR_NPC_USCGINIT1"],["if (player getVariable 'job' == 'uscg') exitwith {['uscg_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'uscg') then { ['uscg_work'] call A3PL_NPC_Start; } else {['uscg_workdenied'] call A3PL_NPC_Start;};"]],
	["uscg_workdenied", localize"STR_NPC_USCGDENIED",[localize"STR_NPC_SORRYILEAVE"],[""]],
	["uscg_work", localize"STR_NPC_USCGWORK",[localize"STR_NPC_USCGWORK1",localize"STR_NPC_USCGWORK2"],["['uscg'] call A3PL_NPC_TakeJob;",""]],
	["uscg_already", localize"STR_NPC_USCGALREADY",[localize"STR_NPC_USCGALREADY1",localize"STR_NPC_USCGALREADY2"],["call A3PL_NPC_LeaveJob;",""]],
	["uscg_accepted", localize"STR_NPC_USCGALACCEPTED",[localize"STR_NPC_USCGALACCEPTED1"],[""]],
	["uscg_service", localize"STR_NPC_USCGNSERVICE",[localize"STR_NPC_USCGNSERVICER"],[""]],

	["fifr_initial", localize"STR_NPC_FIFRINIT",[localize"STR_NPC_FIFRINIT1",localize"STR_NPC_FIFRINIT2",localize"STR_NPC_FIFRINIT3", localize"str_NPC_FIFRINIT4"],["if ((str (player getvariable ['A3PL_Wounds',[]]) == '[]') && ((player getvariable ['A3PL_MedicalVars',[5000,'120/80',37]] select 0) == 5000)) exitwith {['fifr_healdenied'] call A3PL_NPC_Start;}; ['fifr_heal'] call A3PL_NPC_Start;","['fifr_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'fifr') exitwith {['fifr_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'fifr') then { ['fifr_work'] call A3PL_NPC_Start; } else {['fifr_workdenied'] call A3PL_NPC_Start;};", "['Shop_Clinic'] call A3PL_Shop_Open;"]],
	["fifr_healdenied", localize"STR_NPC_FIFRHEALD",[localize"STR_NPC_FIFRHEALD1"],[""]],
	["fifr_howto", localize"STR_NPC_FIFRHOWTO",[localize"STR_NPC_ALRIGHTTNX"],[""]],
	["fifr_workdenied", localize"STR_NPC_FIFRDEN",[localize"STR_NPC_FIFRDEN1"],[""]],
	["fifr_work",localize"STR_NPC_FIFRWORK",[localize"STR_NPC_FIFRWORK1",localize"STR_NPC_FIFRWORK2"],["['fifr'] call A3PL_NPC_TakeJob;",""]],
	["fifr_already", localize"STR_NPC_FIFRALREADY",[localize"STR_NPC_FIFRALREADY1",localize"STR_NPC_FIFRALREADY2"],["call A3PL_NPC_LeaveJob;",""]],
	["fifr_accepted", localize"STR_NPC_FIFRACC",[localize"STR_NPC_FIFRACC1"],[""]],
	["fifr_heal", localize"STR_NPC_FIFRHEAL",[localize"STR_NPC_FIFRHEAL1",localize"STR_NPC_FIFRHEAL2"],["[] spawn A3PL_Medical_Heal;"]],
	["fifr_healdone", localize"STR_NPC_FIFRDONE",[localize"STR_NPC_FIFRDONE1"],[""]],

	["fifr_initialill", localize"STR_NPC_FIFRINITILL",[localize"STR_NPC_FIFRINITILL1"],["if ((str (player getvariable ['A3PL_Wounds',[]]) == '[]') && ((player getvariable ['A3PL_MedicalVars',[5000,'120/80',37]] select 0) == 5000)) exitwith {['fifr_healdeniedill'] call A3PL_NPC_Start;}; ['fifr_healill'] call A3PL_NPC_Start;"]],
	["fifr_healdeniedill", localize"STR_NPC_FIFRHEALDILL",[localize"STR_NPC_FIFRHEALD1ILL"],[""]],
	["fifr_healill", localize"STR_NPC_FIFRHEALILL",[localize"STR_NPC_FIFRHEALILL1",localize"STR_NPC_FIFRHEALILL2"],["call A3PL_Medical_Heal_Ill;"]],
	["fifr_healdoneill", localize"STR_NPC_FIFRDONEILL",[localize"STR_NPC_FIFRDONEILL1"],[""]],

	["vehiclesell_initial", localize"STR_NPC_VEHICLESELLINIT",[localize"STR_NPC_VEHICLESELLINIT1",localize"STR_NPC_VEHICLESELLINIT2"],["['vehiclesell_yes'] call A3PL_NPC_Start;","['vehiclesell_no'] call A3PL_NPC_Start;"]],
	["vehiclesell_no", localize"STR_NPC_ENIGMENO",[localize"STR_NPC_ENIGMEDSL"],[""]],
	["vehiclesell_yes", localize"STR_NPC_VEHICLESELLYES",[localize"STR_NPC_VEHICLESELLOFF"],["call A3PL_Chopshop_Chop;"]],

	["roadworker_initial", localize"STR_NPC_ROADWINIT",[localize"STR_NPC_ROADWINIT1",localize"STR_NPC_ROADWINIT2"],["if ((player getVariable ['job','unemployed']) == 'roadworker') exitwith {['roadworker_already'] call A3PL_NPC_Start;}; ['roadworker_work'] call A3PL_NPC_Start;",""]],
	["roadworker_work", localize"STR_NPC_ROADWWORK",[localize"STR_NPC_ROADWWORK1",localize"STR_NPC_ROADWWORK2"],["['roadworker'] call A3PL_NPC_TakeJob;",""]],
	["roadworker_already", localize"STR_NPC_ROADWALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["call A3PL_NPC_LeaveJob;",""]],
	["roadworker_accepted", localize"STR_NPC_ROADWACC",[localize"STR_NPC_ROADWACC1",localize"STR_NPC_ROADWACC2"],["['roadworker_howto'] call A3PL_NPC_Start;",""]],
	["roadworker_howto", localize"STR_NPC_ROADWHOWTO",[localize"STR_NPC_ALRIGHTTNX"],[""]],

	["farmer_initial", localize"STR_NPC_FARMINIT",[localize"STR_NPC_FARMINIT1",localize"STR_NPC_FARMINIT2"],["if ((player getVariable ['job','unemployed']) == 'agriculteur') exitwith {['farmer_already'] call A3PL_NPC_Start;}; ['farmer_work'] call A3PL_NPC_Start;",""]],
	["farmer_work",  localize"STR_NPC_FARMWORK",[localize"STR_NPC_FARMWORK1",localize"STR_NPC_FARMWORK2"],["['farmer'] call A3PL_NPC_TakeJob;",""]],
	["farmer_already",  localize"STR_NPC_FARMALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["call A3PL_NPC_LeaveJob;",""]],
	["farmer_accepted",  localize"STR_NPC_FARMACC",[localize"STR_NPC_FARMACC1",localize"STR_NPC_FARMACC2"],["['farmer_howto'] call A3PL_NPC_Start;",""]],
	["farmer_howto",  localize"STR_NPC_FARMHOWTO",[localize"STR_NPC_ALRIGHTTNX"],[""]],

	["oil_initial", localize"STR_NPC_OILRECINIT",[localize"STR_NPC_OILRECINIT1",localize"STR_NPC_OILRECINIT2"],["if ((player getVariable ['job','unemployed']) == 'oil') exitwith {['oil_already'] call A3PL_NPC_Start;}; ['oil_work'] call A3PL_NPC_Start;",""]],
	["oil_work",  localize"STR_NPC_OILRECWORK",[localize"STR_NPC_OILRECWORK1",localize"STR_NPC_OILRECWORK2"],["['oil'] call A3PL_NPC_TakeJob;",""]],
	["oil_already",  localize"STR_NPC_OILRECALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["call A3PL_NPC_LeaveJob;",""]],
	["oil_accepted",  localize"STR_NPC_OILRECACC",[localize"STR_NPC_OILRECACC1",localize"STR_NPC_OILRECACC2"],["['oil_howto'] call A3PL_NPC_Start;",""]],
	["oil_howto",  localize"STR_NPC_OILRECHOWTO",[localize"STR_NPC_ALRIGHTTNX"],[""]],

	["dmv_initial",localize"STR_NPC_DMV1",["I need a driving license","Nothing, have a good day"],["['dmv_drivingteststart'] call A3PL_NPC_Start;",""]],
	["dmv_drivingteststart","Okay, the test costs $500 and covers some basic road and safety laws. Let me know when you are ready to begin.",["I'm ready!","I'm not ready, I'll be back later"],["[] call A3PL_DMV_StartTest;",""]],

	["dmv_drivingtest1","When approaching a unmarked T-Intersection, what must you do?",["A) Yield","B) Keep Going","C) Off-road around the junction","D) Come to a complete stop"],["['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtest2'] call A3PL_NPC_Start;"]],
	["dmv_drivingtest2","What is the speed limit on a street with unmarked roads?",["A) 30","B) 40","C) 50","D) 35"],["['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtest3'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;"]],
	["dmv_drivingtest3","What speed must you slow down to when passing an emergency vehicle?",["A) 20","B) 30","C) 35","D) 15"],["['dmv_drivingtest4'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;"]],
	["dmv_drivingtest4","What is the speed limit on the MSR?",["A) 30","B) 50","C) 70","D) 80"],["['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtest5'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;"]],
	["dmv_drivingtest5","If someone is driving aggressively behind you, what should you do?",["A) Try to get out of the aggressive drivers way","B) Stare at the driver as they are passing you","C) Speed up as they are passing you","D) Block the passing lane, preventing them from overtaking"],["['dmv_drivingtest6'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;"]],
	["dmv_drivingtest6","If an oncoming driver is heading toward you in your lane, what should you do?",["A) Steer right, blow your horn, and accelerate","B) Steer left, blow your horn, and brake","C) Steer right, blow your horn, and brake","D) Stay in the center of your lane, blow your horn, and brake"],["['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtest7'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;"]],
	["dmv_drivingtest7","After you have overtaken a vehicle, when should return to the right lane?",["A) When you see the front bumper of the other car in your mirror","B) When you have put your turn signal on","C) When you have turned your headlights on","D) When you see the other car's headlights come on"],["['dmv_drivingtestpass'] call A3PL_NPC_Start; ['driver'] call A3PL_DMV_Add;","['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;","['dmv_drivingtestfail'] call A3PL_NPC_Start;"]],

	["dmv_drivingtestpass","Congratulations, you have passed your driving test! Your license has been issued.",["Thank you, see you later!"],[""]],
	["dmv_drivingtestfail","Unfortunatly you have failed your driving test, you can retake the test at any time for $500",["I'm ready for a second chance","I'll come back later"],["['dmv_drivingtest1'] call A3PL_NPC_Start;",""]],

	["verizon_initial",localize"STR_NPC_HELLOHOWICANHELPYOU",[localize"STR_NPC_CHOOSESUB"],["['verizon_howto'] call A3PL_NPC_Start;"]],
	["verizon_howto",localize"STR_NPC_VERIZONCHOOSESUBSCRIPTION",[localize"STR_NPC_SECONDARYPHONE"],["['2'] spawn A3PL_iPhoneX_AddPhoneNumber;"]],

	["fifrb_initial", localize"STR_NPC_FIFRINIT",[localize"STR_NPC_FIFRINIT2",localize"STR_NPC_FIFRINIT3"],["['fifrb_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'fifr') exitwith {['fifrb_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'fifr') then { ['fifrb_work'] call A3PL_NPC_Start; } else {['fifrb_workdenied'] call A3PL_NPC_Start;};"]],
	["fifrb_howto", localize"STR_NPC_FIFRHOWTO",[localize"STR_NPC_ALRIGHTTNX"],[""]],
	["fifrb_workdenied", localize"STR_NPC_FIFRDEN",[localize"STR_NPC_FIFRDEN1"],[""]],
	["fifrb_work", localize"STR_NPC_FIFRWORK",[localize"STR_NPC_FIFRWORK1",localize"STR_NPC_FIFRWORK2"],["['fifr'] call A3PL_NPC_TakeJob;",""]],
	["fifrb_already", localize"STR_NPC_FIFRALREADY",[localize"STR_NPC_FIFRALREADY1",localize"STR_NPC_FIFRALREADY2"],["call A3PL_NPC_LeaveJob;",""]],
	["fifrb_accepted", localize"STR_NPC_FIFRACC",[localize"STR_NPC_FIFRACC1"],[""]],

	["police_initial", localize"STR_NPC_POLICEINIT",[localize"STR_NPC_POLICEINIT1",localize"STR_NPC_POLICEINIT2",localize"STR_NPC_POLICEINIT3"],["['police_howto'] call A3PL_NPC_Start;","['police_reportcrime'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'fisd') exitwith {['police_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'fisd') then { ['police_work'] call A3PL_NPC_Start; } else {['police_workdenied'] call A3PL_NPC_Start;};"]],
	["police_howto", localize"STR_NPC_WEBSITEMOREINFO",[localize"STR_NPC_ALRIGHTTNX"],[""]],
	["police_reportcrime", localize"STR_NPC_POLICEREPCRIME",[localize"STR_NPC_ALRIGHTTNX"],[""]],
	["police_workdenied", localize"STR_NPC_POLICEDENIED",[localize"STR_NPC_SORRYILEAVE"],[""]],
	["police_work", localize"STR_NPC_WORK",[localize"STR_NPC_WORK1",localize"STR_NPC_WORK2"],["['fisd'] call A3PL_NPC_TakeJob;",""]],
	["police_already", localize"STR_NPC_ALREADY",[localize"STR_NPC_ALREADY1",localize"STR_NPC_ALREADY2"],["call A3PL_NPC_LeaveJob;",""]],
	["police_accepted", localize"STR_NPC_ACCEPTED",[localize"STR_NPC_ACCEPTED1"],[""]],

	["doj_initial", localize"STR_NPC_HELLOWHOWHELP",[localize"STR_NPC_FAAINIT1",localize"STR_NPC_DOJINIT2"],["['doj_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'doj') exitwith {['doj_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'doj') then { ['doj_work'] call A3PL_NPC_Start; } else {['doj_workdenied'] call A3PL_NPC_Start;}"]],
	["doj_howto", localize"STR_NPC_DOJHOWTO",[localize"STR_NPC_AIGHTTNX"],[""]],
	["doj_already",  localize"STR_NPC_DOJALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["call A3PL_NPC_LeaveJob;",""]],
	["doj_work", localize"STR_NPC_DOJWORK",[localize"STR_NPC_IMREADY",localize"STR_NPC_BEBACKLATER"],["['doj'] call A3PL_NPC_TakeJob;",""]],
	["doj_workdenied", localize"STR_NPC_DOJDEN",[localize"STR_NPC_SORRYILEAVE"],[""]],

	["doc_initial",localize "STR_NPC_DOC1",[localize"STR_NPC_DOC2",localize"STR_NPC_DOC3"],["['doc_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'usms') exitwith {['doc_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'usms') then { ['doc_work'] call A3PL_NPC_Start; } else {['doc_workdenied'] call A3PL_NPC_Start;}"]],
	["doc_howto",localize "STR_NPC_DOC4",[localize"STR_NPC_DOC5"],[""]],
	["doc_already", localize "STR_NPC_DOC6",[localize"STR_NPC_DOC7",localize"STR_NPC_DOC8"],["call A3PL_NPC_LeaveJob;",""]],
	["doc_work",localize "STR_NPC_DOC9",[localize"STR_NPC_DOC10",localize"STR_NPC_DOC11"],["['usms'] call A3PL_NPC_TakeJob;",""]],
	["doc_workdenied",localize "STR_NPC_DOC12",[localize"STR_NPC_DOC13"],[""]],

	["sfp_start", localize"STR_NPC_SFPINIT",[localize"STR_NPC_SFPINIT2",localize"STR_NPC_SFPINIT4"],["call A3PL_SFP_SignOn;",""]],

	["roadside_service_initial", localize"STR_NPC_Road_Init",[localize"STR_NPC_Road_Init1",localize"STR_NPC_Road_Init2",localize"STR_NPC_Road_Init3"],["if ((player getVariable ['job','unemployed']) == 'Roadside') exitwith {['roadside_service_already'] call A3PL_NPC_Start;}; ['roadside_service_work'] call A3PL_NPC_Start;","if ((player getVariable ['job','unemployed']) == 'Roadside') then {['roadside_service_supplies'] call A3PL_Shop_Open;} else {['You have to be signed in as the roadside service job to be able to do this', 'red'] call A3PL_Player_Notification;};",""]],
	["roadside_service_work",  localize"STR_NPC_Road_Work",[localize"STR_NPC_Road_Work1",localize"STR_NPC_Road_Work2"],["['Roadside'] call A3PL_NPC_TakeJob;['roadside_service_accepted'] call A3PL_NPC_Start;",""]],
	["roadside_service_already",  localize"STR_NPC_Road_Already",[localize"STR_NPC_Road_Already1",localize"STR_NPC_Road_Already2"],["call A3PL_NPC_LeaveJob;",""]],
	["roadside_service_accepted",  localize"STR_NPC_Road_Accepted",[localize"STR_NPC_Road_Accepted1",localize"STR_NPC_Road_Accepted2"],["","['roadside_service_howto'] call A3PL_NPC_Start;"]],
	["roadside_service_howto",  localize"STR_NPC_Road_Howto",[localize"STR_NPC_Road_HowtoReply1",localize"STR_NPC_Road_HowtoReply2"],["['roadside_service_howtopt2'] call A3PL_NPC_Start;",""]],
	["roadside_service_howtopt2",  localize"STR_NPC_Road_Howto1",[localize"STR_NPC_Road_HowtoReply1",localize"STR_NPC_Road_HowtoReply2"],["['roadside_service_howtopt3'] call A3PL_NPC_Start;",""]],
	["roadside_service_howtopt3",  localize"STR_NPC_Road_Howto2",[localize"STR_NPC_Road_HowtoReply1",localize"STR_NPC_Road_HowtoReply2"],["['roadside_service_howtopt4'] call A3PL_NPC_Start;",""]],
	["roadside_service_howtopt4",  localize"STR_NPC_Road_Howto3",[localize"STR_NPC_Road_HowtoReply1",localize"STR_NPC_Road_HowtoReply2"],["['roadside_service_howtopt5'] call A3PL_NPC_Start;",""]],
	["roadside_service_howtopt5",  localize"STR_NPC_Road_Howto4",[localize"STR_NPC_Road_HowtoReply3"],[""]],

	["port_initial", localize"STR_NPC_PORTINIT",[localize"STR_NPC_OPT1",localize"STR_NPC_OPT2"],["[] spawn A3PL_Robberies_RobPort;",""]],
	["atc", localize"STR_NPC_ATCINIT",[localize"STR_NPC_ATC_1",localize"STR_NPC_ATC_2"],["call A3PL_ATC_Tower;",""]],
	["freight_initial", localize"STR_NPC_FREIGHTINIT",[localize"STR_NPC_FREIGHT_OPT1",localize"STR_NPC_FREIGHT_OPT2",localize"STR_NPC_FREIGHT_OPT3"],["[player_objintersect] call A3PL_Freight_Start;","[player_objintersect] call A3PL_Freight_Unload;",""]],

	["ship_initial", "Hi, I run the shipping company How can I help you?",["Sign on as a Ship Captain",localize"STR_NPC_FREIGHT_OPT3"],["if (['boat',player] call A3PL_DMV_Check) then { ['captain'] call A3PL_NPC_TakeJob;['ship_captain_accepted'] call A3PL_NPC_Start; } else {['ship_captain_denied'] call A3PL_NPC_Start;}",""]],
	["ship_captain_accepted", "You are now working for the shipping company!",["Thanks, I'll be on my way now!","I need to rent a ship!"],["","[player_objintersect] call A3PL_JobShipCaptain_RentVehicle;"]],
	["ship_captain_denied", "You need to get a boating license to work for me, contact USCG to get one!",["Thanks, I'll be on my way now!"],[""]]
];
publicVariable "Config_NPC_Text";
