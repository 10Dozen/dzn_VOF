/*
	author: 10Dozen
	description: Start vehicle fire process
	input: OBJECT - vehicle
	returns: nothing
	example:
*/

#include "..\macro.hpp"

private _v = _this;

_v setVariable [SVAR(IsOnFire), true, true];
_v setVariable [SVAR(FireStartTme), time, true];
_v setVariable [SVAR(AllowCrewDamage), false, true];

private _timeout = selectRandom GVAR(IgnitionTimeout);
sleep _timeout;

_timeout = selectRandom GVAR(BurningTime);
// Fire Effects thread
[_v, _timeout] spawn {
	params["_v","_timeout"];

	private _pos = [0,0,0];

/*
	_pos = _v modelToWorld (
			(["motor","engine"] apply { _v selectionPosition _x }) select { !(_x isEqualTo [0,0,0]) } select 0
	);
			_pos = _v worldToModel [_pos select 0, _pos select 1, 1 min (_pos select 2)];

			// If engine and fuel are separated - flame will come to fueltank. If not - flame will move to [0,0,0] of the model
			private _dY = if ( abs((_v selectionPosition "motor" select 1) - (_v selectionPosition "palivo" select 1)) > 1.85 ) then {
				(_v selectionPosition "motor" select 1) - (_v selectionPosition "palivo" select 1)
			} else {
				(_pos select 1)
			};
			private _width = abs(boundingBoxReal _v select 0 select 0) - 1;
			private _path = [
				[ _pos, _t/4 ]
				, [ [selectRandom[1,-1]*random(_width), (_pos select 1) / 2, _pos select 2], (_t/(4 + random (2))) ]
				, [ [selectRandom[1,-1]*random(_width), 0, _pos select 2], (_t/(5 + random (2))) ]
			];

			private _soundSource = createSoundSource ["Sound_Fire", _v, [], 0];
			{
				sleep (_x select 1);

				if (_forEachIndex != 0) then {
					private _p = _path select (_forEachIndex - 1);
					[_v, _p select 0, _t - (_p select 1), [0.5,0.5,0.5], [2, 20, 2, 1, 2, 5.4]] remoteExec [SVAR(fnc_setEffectFire), 0];
				};

				[_v, _x select 0, _t - (_x select 1)] remoteExec [SVAR(fnc_setEffectFire), 0];

				if ((_forEachIndex + 1) == count _path) then {
					sleep (_t);
					deleteVehicle _soundSource;
				};
			} forEach _path;

*/


};

// Crew Management thread
[_v, _timeout] spawn {
	params["_v","_timeout"];

	sleep 0.33*_timeout;
	_v spawn GVAR(fnc_LeaveVehicle);
	_v spawn GVAR(fnc_HandleCrewEffects);

	sleep 0.17*_timeout;
	_v setVariable [SVAR(AllowCrewDamage), true, true];
	[_v, "fire"] call GVAR(fnc_InformCrew);
};