// CBA Settings
#define		TITLE		"dzn Vehicle On Fire"
#define		SETNAME(X)	format["dzn_VOF_%1", X]
private _add = {
	params ["_var","_type","_val",["_exp", nil]];
	[format["dzn_VOF_%1",_var],_type,[localize format["STR_VOF_%1",_var], localize format ["STR_VOF_%1_desc", _var]],TITLE,_val,true,_exp] call CBA_Settings_fnc_init;
};

private _parseTimeSetting = {


};

// Common enable/disable switch
[
	"Enabled"
	, "CHECKBOX"
	, true
] call _add;

// Vehicle check loop timeout
[
	"CheckTimeout"
	, "SLIDER"
	, [1, 240, 30, 0]
] call _add;

// Chance of ignition on each hit
[
	"IgnitionChance"
	, "SLIDER"
	, [1, 100, 90, 0]
] call _add;

// Timeout before ignition starts, in format "15" or "15-45" seconds
[
	"IgnitionTimeoutSetting"
	, "EDITBOX"
	, "15-30"
	, {
		["dzn_VOF_IgnitionTimeout",_this] call dzn_VOF_fnc_updateTimeoutSetting;
	}
] call _add;

// Burning time (from ignition to vehicle destruction), in format "15" or "15-45" seconds
[
	"BurningTimeSetting"
	, "EDITBOX"
	, "45-75"
	, {
		["dzn_VOF_BurningTime",_this] call dzn_VOF_fnc_updateTimeoutSetting;
	}
] call _add;

// Chance of preventing engine destruction for Land vehicles
// Chance of preventing engine destruction for Air vehicles
//












[
	SETNAME("TimeoutMin")
	, "SLIDER"
	, [localize "STR_VOF_BurningTimeoutMin", localize "STR_VOF_BurningTimeoutMin_desc"] /* ["Burning out timeout (min)", "Minimum timeout before vehicle become destroyed by fire; Should be < Max"] */
	, TITLE
	, [5, 240, GVAR(timeoutRange) select 0, 0]
	, true
	, {
		if (_this <= (GVAR(timeoutRange) select 2)) then {
			GVAR(timeoutRange) = [
				_this
				, floor( (_this + (GVAR(timeoutRange) select 2))/2 )
				, GVAR(timeoutRange) select 2
			];
		};
	}
] call CBA_Settings_fnc_init;
[
	SETNAME("TimeoutMax")
	, "SLIDER"
	, [localize "STR_VOF_BurningTimeoutMax", localize "STR_VOF_BurningTimeoutMax_desc"]  /* ["Burning out timeout (min)", "Maximum timeout before vehicle become destroyed by fire; Should be > Min"]*/
	, TITLE
	, [5, 240, GVAR(timeoutRange) select 2, 0]
	, true
	, {
		if ((GVAR(timeoutRange) select 0) <= _this) then {
			GVAR(timeoutRange) = [
				GVAR(timeoutRange) select 0
				, floor( ((GVAR(timeoutRange) select 0) + _this)/2 )
				, _this
			];
		};
	}
] call CBA_Settings_fnc_init;

[
	SETNAME("NonCookingList")
	, "EDITBOX"
	, [localize "STR_VOF_NonCookingList", localize "STR_VOF_NonCookingList_desc"]   /* ["Non-cooking off vehicles", "Vehicles that should not cookoff, in format [@Class, @StructuralDamage], e.g. ['CUP_btr_base', 15]"] */
	, TITLE
	, str(GVAR(nonCookingVehicles)) select [1, count str(GVAR(nonCookingVehicles)) -2]
	, true
	, {
	    GVAR(nonCookingVehicles) = call compile format ["[%1]", _this];
	}
] call CBA_Settings_fnc_init;

[
	SETNAME("CookingList")
	, "EDITBOX"
	, [localize "STR_VOF_CookingList", localize "STR_VOF_CookingList_desc"]   /* ["Cooking off vehicles", "Vehicles of the same family as non-cooking off ones that can cookoff (e.g. BTR-82A)"] */
	, TITLE
	, GVAR(cookingVehicles) joinString ", "
	, true
	, { GVAR(cookingVehicles) = _this splitString ", "; }
] call CBA_Settings_fnc_init;