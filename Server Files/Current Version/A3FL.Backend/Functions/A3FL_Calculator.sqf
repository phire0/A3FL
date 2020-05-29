/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Calculator_Addition",
{
	disableSerialization;
	private _display = findDisplay 97800;
	private _control = _display displayCtrl 771;
	private _number1 = parseNumber(ctrlText _control);
	private _control = _display displayCtrl 772;
	private _number2 = parseNumber(ctrlText _control);
	private _result = _number1 + _number2;
	private _control = _display displayCtrl 774;
	_control ctrlSetText format ["%1",_result];
}] call Server_Setup_Compile;

["A3PL_Calculator_Division",
{
	disableSerialization;
	private _display = findDisplay 97800;
	private _control = _display displayCtrl 771;
	private _number1 = parseNumber(ctrlText _control);
	private _control = _display displayCtrl 772;
	private _number2 = parseNumber(ctrlText _control);
	private _result = _number1 / _number2;
	private _control = _display displayCtrl 774;
	_control ctrlSetText format ["%1",_result];
}] call Server_Setup_Compile;

["A3PL_Calculator_Multiplication",
{
	disableSerialization;
	private _display = findDisplay 97800;
	private _control = _display displayCtrl 771;
	private _number1 = parseNumber(ctrlText _control);
	private _control = _display displayCtrl 772;
	private _number2 = parseNumber(ctrlText _control);
	private _result = _number1 * _number2;
	private _control = _display displayCtrl 774;
	_control ctrlSetText format ["%1",_result];
}] call Server_Setup_Compile;

["A3PL_Calculator_PartPercentage",
{
	disableSerialization;
	private _display = findDisplay 97800;
	private _control = _display displayCtrl 771;
	private _number1 = parseNumber(ctrlText _control);
	private _control = _display displayCtrl 772;
	private _number2 = parseNumber(ctrlText _control);
	private _result = _number1 / 100 * _number2;
	private _control = _display displayCtrl 774;
	_control ctrlSetText format ["%1",_result];
}] call Server_Setup_Compile;

["A3PL_Calculator_Percentage",
{
	disableSerialization;
	private _display = findDisplay 97800;
	private _control = _display displayCtrl 771;
	private _number1 = parseNumber(ctrlText _control);
	private _control = _display displayCtrl 772;
	private _number2 = parseNumber(ctrlText _control);
	private _result = _number1 / 100 * _number2;
	private _control = _display displayCtrl 774;
	_control ctrlSetText format ["%1",_result];
}] call Server_Setup_Compile;

["A3PL_Calculator_Puissance",
{
	disableSerialization;
	private _display = findDisplay 97800;
	private _control = _display displayCtrl 771;
	private _number1 = parseNumber(ctrlText _control);	
	private _control = _display displayCtrl 772;
	private _number2 = parseNumber(ctrlText _control);
	private _result = _number1 ^ _number2;
	private _control = _display displayCtrl 774;
	_control ctrlSetText format ["%1",_result];
}] call Server_Setup_Compile;

["A3PL_Calculator_Substraction",
{
	disableSerialization;
	private _display = findDisplay 97800;
	private _control = _display displayCtrl 771;
	private _number1 = parseNumber(ctrlText _control);
	private _control = _display displayCtrl 772;
	private _number2 = parseNumber(ctrlText _control);
	private _result = _number1 - _number2;
	private _control = _display displayCtrl 774;
	_control ctrlSetText format ["%1",_result];
}] call Server_Setup_Compile;