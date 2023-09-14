/// @param state

function BentoDebugRelaxedSprites(_state)
{
    static _debugStruct = __BentoGlobal().__debug;
    
    if (GM_build_type == "run")
    {
        _debugStruct.__relaxedSprites = _state;
        __BentoTrace("Set DebugRelaxedSprites = ", _state);
    }
}