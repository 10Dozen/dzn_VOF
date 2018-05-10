// CBA Settings
#include "macro.hpp"
#define		TITLE		"dzn Vehicle On Fire"
#define		ACE_NOT_COOKOFFING_LIST \
CUP_BMP2_HQ_Base \
, CUP_BMP2_Ambul_Base \
, CUP_BRDM2_Base \
, CUP_BTR40_MG_Base \
, CUP_BTR60_Base \
, CUP_GAZ_Vodnik_Base \
, CUP_M113_Base \
, CUP_AAV_Base \
, CUP_BAF_Jackal2_BASE_D \
, CUP_Mastiff_Base \
, CUP_RG31_BASE \
, CUP_Ridgback_Base \
, CUP_B_LAV25M240_USMC \
, CUP_B_LAV25_HQ_USMC \
, CUP_StrykerBase \
, CUP_FV432_Bulldog_Base \
, rhs_btr_base \
, rhsusf_m113tank_base \
, rhsusf_rg33_base

#define		ACE_COOKOFING_LIST \
CUP_BRDM2_ATGM_Base \
, CUP_M163_Base \
, CUP_B_M1135_ATGMV_Desert \
, CUP_B_M1128_MGS_Desert \
, CUP_GAZ_Vodnik_BPPU_Base \
, rhs_btr80a_msv \
, rhs_btr80a_vdv \
, rhs_btr80a_vv \
, rhs_btr80a_vmf


private _add = {
	params ["_var","_type","_val",["_exp", "No Expression"]];
	private _arr = [format["dzn_VOF_%1",_var],_type,[localize format["STR_VOF_%1",_var], localize format ["STR_VOF_%1_desc", _var]],TITLE,_val,true];
	if !(typename _exp == "STRING" && { _exp == "No Expression" }) then { _arr pushBack _exp; };

	_arr call CBA_Settings_fnc_init;
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
		[SVAR(IgnitionTimeout),_this] call GVAR(fnc_updateTimeoutSetting);
	}
] call _add;

// Burning time (from ignition to vehicle destruction), in format "15" or "15-45" seconds
[
	"BurningTimeSetting"
	, "EDITBOX"
	, "45-75"
	, {
		[SVAR(BurningTime),_this] call GVAR(fnc_updateTimeoutSetting);
	}
] call _add;

// Chance of preventing engine destruction for Land vehicles
[
	"Land_EngineDestructionChance"
	, "SLIDER"
	, [0,100,90,0]
] call _add;

// Chance of preventing engine destruction for Air vehicles
[
	"Air_EngineDestructionChance"
	, "SLIDER"
	, [0,100,30,0]
] call _add;

// Apply to Cars
[
	"ApplyCars"
	, "CHECKBOX"
	, true
	, {
		[[["Car_F",5]], _this] call GVAR(fnc_updateWhitelist);
		[GVAR(Blacklist), ["Car_F"], !_this] call GVAR(fnc_updateList);
	}
] call _add;

// Apply to Trucks
[
	"ApplyTrucks"
	, "CHECKBOX"
	, true
	, {
		[[["Truck_F",5]], _this] call GVAR(fnc_updateWhitelist);
		[GVAR(Blacklist), ["Truck_F"], !_this] call GVAR(fnc_updateList);
	}
] call _add;

// Apply to Wheeled APC
[
	"ApplyWheeledAPC"
	, "CHECKBOX"
	, true
	, {
		[[["Wheeled_APC_F",5]], _this] call GVAR(fnc_updateWhitelist);
		[GVAR(Blacklist), ["Wheeled_APC_F"], !_this] call GVAR(fnc_updateList);
	}
] call _add;

// Apply to Tanks
[
	"ApplyTanks"
	, "CHECKBOX"
	, true
	, {
		[[["Tank_F",5]], _this] call GVAR(fnc_updateWhitelist);
		[GVAR(Blacklist), ["Tank_F"], !_this] call GVAR(fnc_updateList);
	}
] call _add;

// Apply to Helicopters
[
	"ApplyHeli"
	, "CHECKBOX"
	, true
	, {
		[[["Helicopter",5]], _this] call GVAR(fnc_updateWhitelist);
		[GVAR(Blacklist), ["Helicopter"], !_this] call GVAR(fnc_updateList);
	}
] call _add;

// Apply to Plane
[
	"ApplyPlane"
	, "CHECKBOX"
	, true
	, {
		[[["Plane",5]], _this] call GVAR(fnc_updateWhitelist);
		[GVAR(Blacklist), ["Plane"], !_this] call GVAR(fnc_updateList);
	}
] call _add;

// Apply to Ship
[
	"ApplyShip"
	, "CHECKBOX"
	, true
	, {
		[[["Ship",5]], _this] call GVAR(fnc_updateWhitelist);
		[GVAR(Blacklist), ["Ship"], !_this] call GVAR(fnc_updateList);
	}
] call _add;

// Burning vehicles custom whitelist
[
	"CustomWhitelistSetting"
	, "EDITBOX"
	, ""
	, {
		private _vals = (call compile format ["[%1]", _this]) call GVAR(fnc_clearRoots);

		if !(isNil SVAR(CustomWhitelist)) then {
			[GVAR(CustomWhitelist), false] call GVAR(fnc_updateWhitelist);
		};

		[_vals, true] call GVAR(fnc_updateWhitelist);
		GVAR(CustomWhitelist) = _vals;
	}
] call _add;

// Burning vehicles custom blacklist
[
	"CustomBlacklistSetting"
	, "EDITBOX"
	, ""
	, {
		private _vals = (_this splitString ", ") call GVAR(fnc_clearRoots); /* (call compile format ["[%1]", _this]) */

		if !(isNil SVAR(CustomBlacklist)) then {
			[GVAR(Blacklist), GVAR(CustomBlacklist), false] call GVAR(fnc_updateList);
		};

		[GVAR(Blacklist), _vals, true] call GVAR(fnc_updateList);
		GVAR(CustomBlacklist) = _vals;
	}
] call _add;

// ACE Cook-off enable vehicle list
[
	"Custom_ACE_Cookoff_Blacklist"
	, "EDITBOX"
	,  QUOTE(ACE_NOT_COOKOFFING_LIST)
	, {
		GVAR(ACE_Cookoff_Blacklist) = _this splitString ", ";
	}
] call _add;

// ACE Cook-off disable vehicle list
[
	"Custom_ACE_Cookoff_Whitelist"
	, "EDITBOX"
	, QUOTE(ACE_COOKOFING_LIST)
	, {
		GVAR(ACE_Cookoff_Whitelist) = _this splitString ", ";
	}
] call _add;

// Catastrophic destruction enabled
[
	"CD_Enabled"
	, "CHECKBOX"
	, true
] call _add;

// Catastrophic destruction damage limit
[
	"CD_DamageSetting"
	, "EDITBOX"
	, "20"
	, {
		GVAR(CD_Damage) = parseNumber _this;
	}
] call _add;
