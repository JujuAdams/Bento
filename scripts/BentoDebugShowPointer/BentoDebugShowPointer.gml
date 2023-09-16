/// Sets whether the Bento native pointer position is visible.
/// 
/// @param state

function BentoDebugShowPointer(_state)
{
    static _debugStruct = __BentoGlobal().__debug;
    
    _debugStruct.__showPointer = _state;
    
    __BentoTrace("Set DebugShowPointer = ", _state);
}