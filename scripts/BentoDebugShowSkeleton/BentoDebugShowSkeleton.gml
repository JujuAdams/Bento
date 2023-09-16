/// Sets whether the wireframe for Bento boxes is visible.
/// 
/// @param state

function BentoDebugShowSkeleton(_state)
{
    static _debugStruct = __BentoGlobal().__debug;
    
    _debugStruct.__showSkeleton = _state;
    
    __BentoTrace("Set DebugShowSkeleton = ", _state);
}