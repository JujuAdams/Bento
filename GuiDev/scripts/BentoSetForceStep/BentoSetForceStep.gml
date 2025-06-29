// Feather disable all

/// Sets whether the Step user event / callback is forced on for the given element.
/// 
/// @param state
/// @param [element=self]

function BentoSetForceStep(_state, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__forceStep == _state) return;
        __forceStep = _state;
        
        __layer.__stepDirty = true;
    }
}