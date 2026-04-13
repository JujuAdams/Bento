// Feather disable all

/// Sets whether the Step user event / callback is enabled for the given element regardless of
/// whether it is a button or not. Step events may not be executed for other reasons.
/// 
/// @param state
/// @param [element=self]

function BentoSetPushStep(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__forceStep == _state) return;
        __forceStep = _state;
        
        __layer.__dirtyFlags |= __BENTO_DIRTY_STEP;
    }
}