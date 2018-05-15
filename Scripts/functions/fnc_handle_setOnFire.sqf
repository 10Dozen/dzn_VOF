/*
	author: 10Dozen
	description: Process all checks and initiant VOF effects
	input: 0: OBJECT - target object, 1: SCALAR - suffered damage
	returns: SCALAR - amount of damage to selection
	example:
*/

params["_v", "_dmg"];

if (_v getVariable [SVAR(IsOnFire), false]) then {
	//>> TODO: Here we should check Ignition on hit chance

	if (random(100) > GVAR(IgnitionChance)) then {



	};
};


//>> TODO: Here we should check Chance of Engine Destruction