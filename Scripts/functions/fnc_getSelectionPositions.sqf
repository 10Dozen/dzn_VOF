/*
	author: 10Dozen
	description: Return array of model positions of the Engine and Fueltanks
	input: OBJECT - vehicle
	returns: ARRAY of pos3d in format [@EnginePosition, @FuelPosition]
	example:
*/

private _v = _this;

#define ENGINE_ENUM		["motor","engine_1_hit","engine_2_hit","engine_hit"]
#define FUEL_ENUM		["palivo","fuel_hit"]

private _poses = [];
{
	{
		private _selPos = _v selectionPosition _x;
        if !(_selPos isEqualTo [0,0,0]) exitWith { _poses pushBack _selPos; };
	} forEach _x;
} forEach [ENGINE_ENUM, FUEL_ENUM];

_poses