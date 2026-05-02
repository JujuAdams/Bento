// Feather disable all

/// Sets whether an element should be clamped inside the layer's root element. This is useful for
/// context menus (pop-up menus) that may be created at unpredictable positions.
/// 
/// @param state
/// @param [element=self]

function BentoLayoutSetClampInside(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__layoutClampInside != _state)
        {
            __layoutClampInside = _state;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}