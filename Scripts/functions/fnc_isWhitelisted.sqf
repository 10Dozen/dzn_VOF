/*
	author: 10Dozen
	description: Checks given class from any level of hierarchical class tree - is it whitelisted or blacklisted in given lists
	input: 0: CLASS - vehicle class, 1: ARRAY - 1-dimensional whitelist of classes, 2: ARRAY - 1-dimensional blacklist of classes
	returns: BOOL - is class whitelisted or NOT blacklisted
	example:
		["MyCar", ["MyCar_2","Tank_F"], ["MyCar_Base","Car_F"]] call dzn_VOF_fnc_checkWhitelisted; // Return FALSE, because parent class MyCar_Base is blacklisted
		["MyCar2", ["MyCar_2","Tank_F"], ["MyCar_Base","Car_F"]] call dzn_VOF_fnc_checkWhitelisted; // Return TRUE, because class MyCar2 is whitelisted
*/

params ["_class","_whitelist","_blacklist"];

private _parents = [configFile >> "CfgVehicles" >> _class, true] call BIS_fnc_returnParents;
private _wID = 1001;
private _bID = 1002;

{
	if ((_x in _whitelist) && _wID < 0) then { _wID = _forEachIndex; };
	if ((_x in _blacklsit) && _bID < 0) then { _bID = _forEachIndex; };
} forEach _parents;

_wID < _bID