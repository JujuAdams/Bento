/// Sets whether the navigation graph is visible.
/// 
/// @param state

function BentoDebugShowNavigation(_state)
{
    static _debugStruct = __BentoGlobal().__debug;
    
    _debugStruct.__showNavigationGraph = _state;
    
    __BentoTrace("Set DebugShowNavigation = ", _state);
}