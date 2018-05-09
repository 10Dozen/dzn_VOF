/*
	author: 10Dozen
	description: none
	input: ARRAY - 0: (STRING) Variable name, 1: (STRING) Variable new value
	returns: nothing
	exmple:
		["dzn_VOF_IgnitionTimeoutSetting", "15-30"] call dzn_VOF_fnc_updateTimeoutSetting
*/

params ["_varName", "_val"];

#define DEFAUL_VAL  [15,17,30]

private _vals = (_val splitString "-") apply { parseNumber _x };
private _newVal =  switch (count _vals) do {
	case 1: { [_vals select 0, _vals select 0, _vals select 0] };
	case 2: { [_vals select 0, ((_vals select 0) + (_vals select 1))/2, _vals select 1] };
	default { DEFAUL_VAL };
};

if (_newVal isEqualTo [0,0,0] || _newVal isEqualTo DEFAUL_VAL) exitWith { hint "Wrong setting value! Should be in format ""10-30"""; };

call compile format ["%1 = %2", _varName, _newVal];