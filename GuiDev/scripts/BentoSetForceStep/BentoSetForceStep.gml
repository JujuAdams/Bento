// Feather disable all

/// Sets whether the Step user event / callback is forced on for the given element.
/// 
/// @param state
/// @param [element=self]

function BentoSetForceStep(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__forceStep == _state) return;
        __forceStep = _state;
        
        __layer.__dirtyFlags |= __BENTO_DIRTY_STEP;
    }
}