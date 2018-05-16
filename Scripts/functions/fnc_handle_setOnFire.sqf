/*
	author: 10Dozen
	description: Process all checks and initiant VOF effects
	input: 0: OBJECT - target object, 1: SCALAR - suffered damage, 2: STRING - Selection ("hitfuel" or "hitengine")
	returns: SCALAR - amount of damage to selection
	example:
*/
#include "..\macro.hpp"

params["_v", "_dmg", "_sel"];

// If resulting damage will not cause destruction - then just let it be, no effects should be added
private _selectionDamageResult = _dmg + (_vehicle getHitPointDamage "HitFuel");
if (_selectionDamageResult <= 0.89) exitWith { _dmg };

// Prevent multiple checks for damaging (???)
if (_v getVariable [SVAR(HandlingDamage),false]) exitWith {};
_v setVariable [SVAR(HandlingDamage), true, true];
_v spawn { sleep 0.1; _v setVariable [SVAR(HandlingDamage), false, true]; };

// Handle On Fire
if (
	_v getVariable [SVAR(IsOnFire), false]
) then {
	//>> TODO: Here we should check Ignition on hit chance

	if (random(100) > GVAR(IgnitionChance)) then {
		_v spawn GVAR(SetOnFire);
	};
};

// Check for Chance of Engine Destruction
if (_dmg <= 0.89) exitWith { _dmg }; // No need to update

private _chance = switch true do {
	case (_v isKindOf "Air"): {	GVAR(Air_EngineDestructionChance) };
	case (_v isKindOf "LandVehicle"): {	GVAR(Land_EngineDestructionChance) };
};

if (random(100) > _chance) exitWith { _dmg }; // Full damage should be returned

0.89 // Prevent destruction damage