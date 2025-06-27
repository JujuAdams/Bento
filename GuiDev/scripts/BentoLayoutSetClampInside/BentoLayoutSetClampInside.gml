// Feather disable all

/// @param state
/// @param [element=self]

function BentoLayoutSetClampInside(_state, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__layoutClampInside != _state)
        {
            __layoutClampInside = _state;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}