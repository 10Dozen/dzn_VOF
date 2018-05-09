/*
	author: 10Dozen
	description: Update VOF whitelist.
	input: 0: ARRAY - list of classnames, 1: BOOLEAN - add or remove items
	returns: nothing
	example:
	    [ [["Car_F",5],["Truck_F",6]], true ] call dzn_VOF_fnc_updateWhitelist; // Adds or update classes
	    [ [["Car_F",5]], false ] call dzn_VOF_fnc_updateWhitelist; // Remove class
*/
#include "..\macro.hpp"

params ["_list", ["_needUpdate", true]];

{
	private _classArr = _x;
	private _updated = false;

	{
		if ((_classArr select 0) in _x) exitWith {
			if (_needUpdate) then {
				_x set [1, _classArr select 1];
			} else {
				GVAR(Whitelist) deleteAt _forEachIndex;
			};
			_updated = true;
		};
	} forEach GVAR(Whitelist);

	if (_needUpdate && !_updated) then {
		GVAR(Whitelist) pushBack _classArr;
	}
} forEach _list;