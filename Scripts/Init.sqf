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
			private _canBurn = [_class, GVAR(Whitelist) apply { _x select 0 }, GVAR(Blacklist)] call GVAR(fnc_isWhitelisted);
			private _canCookoff = [_class, GVAR(ACE_Cookoff_Whitelist), GVAR(ACE_Cookoff_Blacklist)] call GVAR(fnc_isWhitelisted);

			if (_canBurn && isNil { _v getVariable SVAR(Handled) }) then {
				// Not good, cuz there may be few (Car and Truck for example), need additional function to get damage
				private _strDamageLimit = _v call ;
            	{
            		if (_class isKindOf (_x select 0)) exitWith { _strDamageLimit = _x select 1; };
            	} forEach GVAR(Whitelist);

				_v setVariable [SVAR(DamageLimit), _v call GVAR(fnc_getStructuralDamageLimit), true];
				_v setVariable [SVAR(OverallDamage), damage _v, true];
				_v setVariable [SVAR(Handled), true, true];
				_v setVariable ["ace_cookoff_enabled", _canCookoff, true];

				_this addEventHandler ["HandleDamage", GVAR(handleDamage)];
			};

			sleep 0.01;
		} forEach vehicles;

		sleep GVAR(CheckTimeout);
	};
};
