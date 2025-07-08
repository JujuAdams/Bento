// Feather disable all

/// Sets whether the clipping region is enabled for an element.
/// 
/// @param state
/// @param [element=self]

function BentoClipSetEnabled(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__scissorEnabled != _state)
        {
            __scissorEnabled = _state;
            
            __layer.__dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE | __BENTO_DIRTY_DRAW;
        }
    }
}