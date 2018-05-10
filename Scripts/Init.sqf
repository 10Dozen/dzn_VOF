#include "macro.hpp"

// Variables
GVAR(Whitelist) = [];
GVAR(Blacklist) = [];
GVAR(ACE_Cookoff_Whitelist) = [];
GVAR(ACE_Cookoff_Blacklist) = [];


// Kek



#include "Functions.sqf"
#include "Settings.sqf"


// Update variables with settings



// Initialization
if (!GVAR(Enabled)) exitWith {};

// Loop throu all vehicles and set cookoff variable to false

[] spawn {
	call GVAR(fnc_publish);
	while { true } do {
		{
			private _v = _x;

			private _class = typeOf _v;

			// Class IN whitelist and there is no class in blacklist
			private _canBurn = (
				{_v isKindOf (_x select 0)} count GVAR(Whitelist) > 0
				&& {_v isKindOf _x} count GVAR(Blacklist) == 0
			);

			private _canCookoff = (
				{_v isKindOf _x} count GVAR(ACE_Cookoff_Blacklist) > 0
				&& {_v isKindOf _x} count GVAR(ACE_Cookoff_Whitelist) == 0
			);
			private _strDamageLimit = 0;



		} forEach vehicles;

		sleep GVAR(CheckTimeout);

		/*
			private _v = _x;
			private _vehicleNonCookoffSettings = GVAR(nonCookingVehicles) select { _v isKindOf (_x select 0) };
			private _isCooking = ({ _v isKindOf _x } count GVAR(cookingVehicles)) > 0;
			if (
				!_isCooking
				&& !(_vehicleNonCookoffSettings isEqualTo [])
				&& isNil {_v getVariable "ace_cookoff_enable"}
			) then {
				_v setVariable ["ace_cookoff_enable", false, true];
				_v setVariable ["dzn_VOF_overallStructuralDamage", damage _v, true];
				_v setVariable [
					"dzn_VOF_structuralDamageMax"
					, _vehicleNonCookoffSettings select 0 select 1
					, true
				];
				_v remoteExec [SVAR(fnc_addDamageHandler), 0, true];

				sleep .01;



			};
		} forEach vehicles;

		sleep GVAR(CheckTimeout);
		*/
	};
};
