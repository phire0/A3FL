/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Twitter_Init",
{
	for "_i" from 0 to 7 do
	{
		A3PL_TwitterMsg_Array set [_i, ["", -1]];
	};

	[] spawn
	{
		if (isDedicated) exitWith {};
		waitUntil {!isNull (findDisplay 46)};
		736713 cutRsc ["Dialog_HUD_Twitter", "PLAIN"];
		waitUntil {!isNil "A3PL_Twitter_MsgDisplay"};
		call A3PL_Twitter_MsgDisplay;
	};
}] call Server_Setup_Compile;

["A3PL_Twitter_Send",
{
	private ["_msg","_result"];
	_msg = ctrlText 98311;
	_dnCost = 1000;

	if (count _msg < 1) exitwith {};
	if (count _msg > 140) exitwith { [localize"STR_NewTwitter_140Max", "red"] call A3PL_Player_Notification; };
	if (!(profilenamespace getVariable ["A3PL_Twitter_Enabled",true])) exitwith {[localize"STR_NewTwitter_Disabled", "red"] call A3PL_Player_Notification;};

	closedialog 0;

	_twitterTag = player getVariable["twitterTag",["#B5B5B5","#ed7202","\A3PL_Common\icons\citizen.paa"]];
	_msgcolor = _twitterTag select 0;
	_namecolor = _twitterTag select 1;
	_namepicture = _twitterTag select 2;
	_name = player getvariable ["name",(name player)];
	_truecaller = _name;

	if (_namepicture == "\A3PL_Common\icons\citizen.paa") then {
		switch (player getVariable ["job","unemployed"]) do {
			default {};
			case ("fifr"): {_namepicture = "\A3PL_Common\icons\fire.paa"; _namecolor = "#FF0000";};
			case ("fisd"): {_namepicture = "\A3PL_Common\icons\faction_sheriff.paa"; _namecolor = "#556B2F";};
			case ("doj"): {_namepicture = "\A3PL_Common\icons\faction_doj.paa"; _namecolor = "#B18904";};
			case ("usms"): {_namepicture = "\A3PL_Common\icons\usms.paa"; _namecolor = "#B18904";};
			case ("uscg"): {_namepicture = "\A3PL_Common\icons\faction_cg.paa"; _namecolor = "#16a085";};
		 };
	 };

	_messageto = "";
	_todatabase = true;
	_doubleCommand = true;
	_needcellphone = true;
	_exitwith = false;
	_splitted = _msg splitString " ";
	_hasNumber = isNil "A3PL_phoneNumberActive";
	if (_msg find "/" == 0) then {_doubleCommand = false;};

	if (((toLower (_splitted select 0) == "/a")) && !_doubleCommand) exitWith {
		_splitted deleteat 0;
		_messageto = ["admin",["admin",player,player getvariable ["name",(name player)],(time + 300)]];
		_todatabase = false;
		_needcellphone = false;
		_doubleCommand = true;
		_msg = _splitted joinString " ";
		_name = format ["* HELP * %1",_name];
		_namecolor = "#3d0000";
		_msgcolor = "#ffbfbf";
		[_msg,_msgcolor,_namepicture,_name,_namecolor,_messageto,_truecaller] remoteExec ["A3PL_Twitter_NewMsg", -2];
	};
	if (((toLower (_splitted select 0) == "/r")) && !_doubleCommand) exitWith {
		if(!(pVar_AdminTwitter)) exitwith {
			[localize"STR_NewTwitter_CantExecute","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg;
			_exitwith = true;
		};
		_todatabase = false;
		_doubleCommand = true;
		_splitted deleteat 0;

		_namecolor = "#c64700";
		_msgcolor = "#ff9960";
		_name = format ["Answer from %1",_name];
		_namepicture = "";
		_found = false;
		_person = [];
		_arraynum = -1;
		{
			if (((toLower (_x select 2)) find (toLower (_splitted select 0))) == 0) then {
				if ((_x select 3) > time) then {
					_found = true;
					_person = _x;
					_arraynum = _foreachindex;
				} else {
					A3PL_Twitter_ReplyArr deleteat _foreachindex;
				};
			};
		} foreach (missionNameSpace getVariable ["A3PL_Twitter_ReplyArr",[]]);
		if (!_found) exitwith {[localize"STR_NewTwitter_ContactErr","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg; _exitwith = true;};
		{if (_person select 1 == _x) exitwith {_found = false;};} foreach allplayers;
		if (_found) exitwith {[localize"STR_NewTwitter_ContactErr2","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg; A3PL_Twitter_ReplyArr deleteat _arraynum; _exitwith = true;};
		_splitted deleteat 0;
		_msg = _splitted joinString " ";
		_messageto = ["reply",_person];
		[_msg,_msgcolor,_namepicture,_name,_namecolor,_messageto,_truecaller] remoteExec ["A3PL_Twitter_NewMsg", -2];
	};
	if (!([] call A3PL_Lib_HasPhone)) exitwith {[localize"STR_EVENTHANDLERS_PHONENEEDED","red"] call A3PL_Player_Notification;};
	if (((toLower (_splitted select 0) == "/dn")) && !_doubleCommand) exitWith {
		_splitted deleteat 0;
		_messageto = ["darknet",["darknet",player,player getvariable ["name",(name player)],(time + 300)]];
		_todatabase = true;
		_doubleCommand = true;
		_msg = _splitted joinString " ";
		_name = format ["%1",_name];
		_namepicture = "\A3PL_Common\icons\citizen.paa";
		if(player getVariable ["Player_Bank",0] < _dnCost) exitWith {["You do not have enough to post on the DarkNet!","red"] call A3PL_Player_Notification;};
		[player, 'Player_Bank', ((player getVariable 'Player_Bank') - _dnCost)] remoteExec ['Server_Core_ChangeVar', 2];
		if(!isNil "A3PL_phoneNumberActive") then {
			_name = format ["DarkNet [%1]", A3PL_phoneNumberActive];
		};
		_namecolor = "#202020";
		_msgcolor = "#ffffff";
		[_msg,_msgcolor,_namepicture,_name,_namecolor,_messageto,_truecaller] remoteExec ["A3PL_Twitter_NewMsg", -2];

		[getPlayerUID player,_msg,_msgcolor,_namepicture,_name,_namecolor,true] remoteExec ["Server_Twitter_HandleMsg", 2];
	};
	if(!_hasNumber) then {
		if(pVar_AdminTwitter) then {A3PL_Twitter_Cooldown = 0;};
		if(((diag_ticktime-(missionNameSpace getVariable ["A3PL_Twitter_Cooldown",-10])) < 10)) exitwith {[format ["Please wait %1 seconds before sending a new tweet",round (10-(diag_ticktime-A3PL_Twitter_Cooldown))], "red"] call A3PL_Player_Notification;};
		A3PL_Twitter_Cooldown = diag_ticktime;
		if (((toLower (_splitted select 0) == "/ad")) && !_doubleCommand) then {
			_splitted deleteat 0;
			_todatabase = true;
			_doubleCommand = true;
			_msg = _splitted joinString " ";
			_name = format ["%1",_name];
			if(!isNil "A3PL_phoneNumberActive") then {
				_name = format ["%1 [%2]",_name, A3PL_phoneNumberActive];
			};
			_namecolor = "#00bfbf";
			_msgcolor = "#4cffff";
		};
		if (((_splitted select 0 == "/h") or (_splitted select 0 == "/H")) && !_doubleCommand) exitwith {
			A3PL_Twitter_Cooldown = 0;
			["/h [Guide] | /a [admin] | /ad [AD]","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg;
		};
		if (_exitwith) exitwith {};

		_a = 0;
		while {_a < 18} do {
			_toFind = [";)","<3",":)",":fuck:",":hi:",":o",":yes:",":p",":@",":-(",":(",":christ:",":hands:",":k:",":POG:",":sad:",":think:",":yikes:"];
			_toFind = _toFind select _a;
			_replaceBy = ["<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_cleinoeil.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_coeur.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_content.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_fuck.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_hi.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_o.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_ok.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_p.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pascontent.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pleure.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_triste.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\pepeChrist.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\pepeHands.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\pepeOk.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\pepePoggers.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\pepeSad.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\pepeThink.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\pepeYikes.paa'/>"];
			_replaceBy = _replaceBy select _a;
			_numberCharToReplace = count _toFind;
			_numberFind = _msg find _toFind;
			while {_numberFind != -1} do {
				_numberFind = _msg find _toFind;
				if (_numberFind isEqualTo -1) exitWith {};
					_splitMessage = _msg splitString "";
					_splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
					_splitMessage set [_numberFind, _replaceBy];
					_msg = _splitMessage joinString "";
				};
			_a = _a + 1;
		};

		if (!_doubleCommand) exitwith {
			A3PL_Twitter_Cooldown = 0;
			["Unknown command (type /h to get help)","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg;
		};
		if (_todatabase) exitwith {
			_result = [getPlayerUID player,_msg,_msgcolor,_namepicture,_name,_namecolor];
			_result remoteExec ["Server_Twitter_HandleMsg", 2];
		};
		[_msg,_msgcolor,_namepicture,_name,_namecolor,_messageto,_truecaller] remoteExec ["A3PL_Twitter_NewMsg", -2];
	} else {
		["You need a phone number to do that!", "red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Twitter_NewMsg",
{
	disableSerialization;
	private ["_msg", "_msgduration", "_i", "_id", "_params", "_messageto", "_subName", "_subText","_namepicture","_name","_msgcolor","_namecolor","_maxmsg","_logo","_nametext","_logname","_logchat","_messagelog","_selmsg"];

	if (isDedicated) exitWith {};
	if (isNil "A3PL_TwitterMsg_Array") exitWith {};
	if (!(profilenamespace getVariable ["A3PL_Twitter_Enabled",true])) exitwith {};
	if (!(typeName _this == typeName [])) exitWith {};


	_msg = param [0,""];
	_msgcolor = param [1,""];
	_namepicture = param [2,""];
	_name = param [3,""];
	_namecolor = param [4,""];
	_messageto = param [5,""];
	_truecaller = param [6,""];
	_msgduration = 20;
	_maxmsg = (8 - 1);


	_cancelaction = true;
	if (typename _messageto == "ARRAY") then {
		if (_messageto select 0 == "admin") then {
			if(pVar_AdminTwitter) then {_cancelaction = false;};
			A3PL_Twitter_ReplyArr = (missionNameSpace getVariable ["A3PL_Twitter_ReplyArr",[]]) + [(_messageto select 1)];
		};
		if (_messageto select 0 == "darknet") then {
			if(player getVariable["faction","citizen"] isEqualTo "citizen") then {_cancelaction = false;};
			A3PL_Twitter_ReplyArr = (missionNameSpace getVariable ["A3PL_Twitter_ReplyArr",[]]) + [(_messageto select 1)];
		};
		if (_messageto select 0 == "reply") then {
			if (player == (_messageto select 1) select 1) then {_cancelaction = false;};
			if (((_messageto select 1) select 0 == "admin") && pVar_AdminTwitter) then {_cancelaction = false;};
		};
	};

	if (typename _messageto == "STRING") then {
		if (_messageto == "") then {_cancelaction = false;};
	};

	if (_cancelaction) exitwith {};

	_msg = _msg call A3PL_Twitter_stripLineBreaks;
	_msg = _msg call A3PL_Twitter_replaceAmpersands;

	_logo = "";
	_nametext = "";
	_logname = "";
	_logchat = "";
	_messagelog = _msg;


	if (_namepicture != "") then
	{
		_logo = format ["<t size='0.5'><img image='%1' /> </t>",_namepicture];
	};

	if (_name != "") then
	{
		_nametext = format ["<t color='%1'>%2: </t>",_namecolor,_name];
		_logname = format ["%1",_name];
	};

	if ((_msgcolor find "#") != 0) then
	{
		switch (_msgcolor) do
		{
			case "red": { _msgcolor = "#FF0000"; };
			case "green": { _msgcolor = "#00DB07"; };
			default { _msgcolor = "#FFFFFF"; };
		};
	};

	_messageinfo = format ["<t color='%1'>%2</t>",_msgcolor,_msg];

	if (count _logname == 0) then
	{
		_logchat = format ["%1",_messagelog];
	} else
	{
		_logchat = format ["%1: %2",_logname,_messagelog];
	};

	A3PL_TwitterChatLog = A3PL_TwitterChatLog + [[_namepicture,_logchat]];
	A3PL_TwitterChatPhone = A3PL_TwitterChatPhone + [[_name,_messagelog,_namecolor]];	//iPhoneX related
	while {count A3PL_TwitterChatLog > 50} do
	{
		A3PL_TwitterChatLog set [0,"delete"];
		A3PL_TwitterChatLog = A3PL_TwitterChatLog - ["delete"];
	};

	_msg = format ["%1%2%3",_logo,_nametext,_messageinfo];

	_selmsg = 0;
	while {_selmsg < _maxmsg} do
	{
		A3PL_TwitterMsg_Array set [_selmsg, A3PL_TwitterMsg_Array select (_selmsg+1)];
		_selmsg = _selmsg + 1;
	};

	_id = A3PL_TwitterMsg_Counter + 1;
	A3PL_TwitterMsg_Counter = A3PL_TwitterMsg_Counter + 1;
	A3PL_TwitterMsg_Array set [_maxmsg, [_msg, _id]];

	((uiNamespace getVariable ["Dialog_HUD_Twitter", displayNull]) displayCtrl 1000) ctrlSetText "Twitter";

	call A3PL_Twitter_MsgDisplay;
	[_id, _msgduration] spawn
	{
		private ["_id","_msgduration","_last"];
		_id = param [0,0];
		_msgduration = param [1,20];

		uiSleep _msgduration;

		{
			if (_x select 1 == _id) exitWith
			{
				A3PL_TwitterMsg_Array set [_forEachIndex, ["", -1]];
				call A3PL_Twitter_MsgDisplay;
			};
		} forEach A3PL_TwitterMsg_Array;

		_last = false;
		{
			if (_x select 0 != "") exitwith {_last = false;};
			if (_x select 0 == "") then {_last = true;} else {_last = false;};
		} foreach A3PL_TwitterMsg_Array;
		if (_last) then {((uiNamespace getVariable ["Dialog_HUD_Twitter", displayNull]) displayCtrl 1000) ctrlSetText "";};
	};
}] call Server_Setup_Compile;

["A3PL_Twitter_MsgDisplay",
{
	private ["_maxmsg"];
	_maxmsg = (8 - 1);
	private ["_ctrl", "_text", "_block"];

	if (isDedicated) exitWith {};
	if (isNil "A3PL_TwitterMsg_Array") exitWith {};
	disableSerialization;

	_block = "";
	for "_i" from 0 to _maxmsg do
	{
		_text = (A3PL_TwitterMsg_Array select _i) select 0;
		if (_text != "") then
		{
			_block = _block + _text + "<br />";
		};
	};

	((uiNamespace getVariable ["Dialog_HUD_Twitter", displayNull]) displayCtrl 100) ctrlSetStructuredText parseText _block;
}] call Server_Setup_Compile;

["A3PL_Twitter_stripLineBreaks",
{
	private ["_aaa","_c_chr_backSlash","_c_chr_space","_c_chr_n","_c_chr_N2","_c_chr_remove"];
	_c_chr_backSlash = 92;
	_c_chr_space = 32;
	_c_chr_n = 110;
	_c_chr_N2 = 78;
	_c_chr_remove = 990;

	_aaa = toArray _this;
	for "_i" from 0 to ((count _aaa)-2) do // checked in pairs - exclude last chr
	{
	  if ((_aaa select _i == _c_chr_backSlash) && (_aaa select (_i+1) in [_c_chr_N2, _c_chr_n])) then
	  {
		_aaa set [_i, _c_chr_space]; // leave one space
		_aaa set [_i+1, _c_chr_remove]; // remove this
	  };
	};
	_aaa = _aaa-[_c_chr_remove]; // strip out all deleted chars
	toString _aaa // result
}] call Server_Setup_Compile;

["A3PL_Twitter_replaceAmpersands",
{
	// Desc: replace "&" characters with "&amp;"
	private ["_aaa", "_ra", "_i", "_ja", "_ca"];

	// &amp;

	_aaa = toArray _this;
	_ra = +_aaa; // save "some" potential effort of copying.
	_ja = 0;

	for "_i" from 0 to ((count _aaa)-1) do
	{
		_ca = _aaa select _i;
		_ra set [_ja, _ca];
	  if (_ca == 38) then
	  {
		_ra set [_ja+0, 38];
		_ra set [_ja+1, 97];
		_ra set [_ja+2, 109];
		_ra set [_ja+3, 112];
		_ra set [_ja+4, 59];
			_ja = _ja + 5; // len of "&amp;"
	  }
		else
		{
			_ja = _ja + 1;
		};
	};

	toString _ra // result
}] call Server_Setup_Compile;

/*["A3PL_Twitter_Open",
{
	if (isDedicated) exitWith {};
	736713 cutText ["","PLAIN"];
	createdialog "Dialog_Twitter";
	{
		_logo = _x select 0;
		_text = _x select 1;
		_number = _forEachIndex;
		lbAdd [5120, _text];
		lbSetPicture [5120, _number, _logo];
	} foreach A3PL_TwitterChatLog;
	lbSetCurSel [5120, (count A3PL_TwitterChatLog + 1)];
}] call Server_Setup_Compile;*/
