/*
	author: 10Dozen
	description: Handles damage with VOF functionality
	input: ARRAY - "HandleDamage" event handler values
	returns: nothing
	example:
*/
#include "..\macro.hpp"

params ["_vehicle", "", "_damage", "_source", "_ammo", "_hitIndex", "_shooter", "_hitpoint"];

if (damage _vehicle >= 1) exitWith {}; // Killed already

if (_hitIndex == -1) then { _hitpoint = "#structural"; };
switch toLower(_hitpoint) do {
	// Vehicle fire effect
	case "hitengine";
	case "hitfuel": {
		[_vehicle,_damage,toLower(_hitpoint)] call GVAR(fnc_handle_setOnFire)
	};

	// Structural OR Catastrophic destruction effect
	case "hithull";
	case "#structural": {
		//>> TODO: Handle Structural damage function
			//>> TODO: Check is damage catastrophical and exit with CD effect
			//>> TODO: Update structural damage

		//>> TODO: Return 0.89 damage


/*
		private _structuralDamage = _damage + (_vehicle getVariable "dzn_VOF_overallStructuralDamage");
		_vehicle setVariable [
			"dzn_VOF_overallStructuralDamage"
			, _structuralDamage
			, true
		];

		if (_structuralDamage > (_vehicle getVariable "dzn_VOF_structuralDamageMax")) then {
			_vehicle call GVAR(fnc_setDisabled);
		};

		_damage min 0.89
		*/
	};

	// Simple damage effect (wheels, turrets, misc. selections)
	default {
		_damage
	};
};