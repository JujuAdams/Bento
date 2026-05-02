// Feather disable all

/// Sets whether a Bento element is disabled. A disabled element will not be interactible nor will
/// it be visible. The children of a disabled element will not be interactible or visible either.
/// 
/// @param state
/// @param [element=self]

function BentoSetDisable(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__disable == _state) return;
        __disable = _state;
        
        //Disabling elements invalidates a lot of cached data
        __layer.__dirtyFlags |= __BENTO_DIRTY_ALL;
    }
}