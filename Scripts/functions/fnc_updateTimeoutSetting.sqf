/*
	author: 10Dozen
	description: none
	input: ARRAY - 0: (STRING) Variable name, 1: (STRING) Variable new value
	returns: nothing
	exmple:
		["dzn_VOF_IgnitionTimeoutSetting", "15-30"] call dzn_VOF_fnc_updateTimeoutSetting
*/

params ["_varName", "_val"];

private _vals = (_val splitString "-") apply { parseNumber _x };
private _newVal =  switch (count _vals) do {
	case 1: { [_vals select 0, _vals select 0, _vals select 0] };
	case 2: { [_vals select 0, ((_vals select 0) + (_vals select 1))/2, _vals select 1] };
	default { [15, 17, 30] };
};

call compile format ["%1 = %2", _varName, _newVal];