#include "macro.hpp"
#define PATH                    "functions\"
#define COMPILE_FUNCTION(X)     GVAR(X) = compile preprocessFileLineNumbers format ["%1%2.sqf", PATH, #X]

COMPILE_FUNCTION(fnc_updateTimeoutSetting);
COMPILE_FUNCTION(fnc_clearRoots);
COMPILE_FUNCTION(fnc_updateWhitelist);
COMPILE_FUNCTION(fnc_updateList);



COMPILE_FUNCTION(fnc_publish);
