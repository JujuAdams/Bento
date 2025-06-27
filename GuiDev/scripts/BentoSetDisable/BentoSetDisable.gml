// Feather disable all

/// Sets whether a Bento instance is disabled. A disabled instance will not be interactible nor will
/// it be visible. The children of a disabled instance will not be interactible or visible either.
/// Disabled instance will still affect layouts, however.
/// 
/// @param state
/// @param [element=self]

function BentoSetDisable(_state, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__disable == _state) return;
        __disable = _state;
        
        //Disabling elements invalidates a lot of cached data
        __layer.__dirtyFlags |= __BENTO_DIRTY_ALL;
    }
}