/*
	author: 10Dozen
	description: Remove root classes from passed 1- or 2-dimmensional array for whitelists
	input: ARRAY of strings or ARRAY of [@String,@Any] arrays
	returns: ARRAY - cleared array
	example:
		_arr = [["Car_F",5],["KEK",2]] call dzn_VOF_fnc_clearRoots; // Return: [["KEK",2]]
		_arr =  ["Car_F","KEK","LOL","Truck_F"] call dzn_VOF_fnc_clearRoots; // Return: ["KEK","LOL"]
*/

private _isOneDimension = typename (_this select 0) == "STRING";

{
	private _root = _x;
	private _index = -1;

	if (_isOneDimension) then {
		_index = _this find _root;
	} else {
		{
			if (_root in _x) exitWith {	_index = _forEachIndex;	};
		} forEach _this;
	};

	_this deleteAt _index;
} forEach ["Car_F","Truck_F","Tank_F"];

_this