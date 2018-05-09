/*
	author: 10Dozen
	description: Updates given 1-dimensional white/blacklist with given items
	input: 0: ARRAY - list to update, 1: ARRAY - values to update, 2: BOOL - add/update or remove items
	returns: nothing
	example:
		[dzn_VOF_Blacklist,["B_Heli_Transport_01_F"], true] call dzn_VOF_fnc_updateList; // Adds B_Heli_Transport_01_F class to dzn_VOF_Blacklist
		[dzn_VOF_ACE_Cookoff_Whitelist, ["B_MBT_01_cannon_F","B_MBT_01_cannon_F_SEP"], false] call dzn_VOF_fnc_updateList; // Remove 2 tanks from Cookoff whitelist
*/

params ["_arr","_vals",["_needUpdate",true]];

{
	private _index = _arr find _x;

	if (_needUpdate && _index < 0) then { _arr pushBack _x; };
	if (!_needUpdate && _index > -1) then { _arr deleteAt _index; };
} forEach _vals;