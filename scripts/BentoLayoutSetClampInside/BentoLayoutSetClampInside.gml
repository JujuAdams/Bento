// Feather disable all

/// Sets whether an element should be clamped inside the layer's root element. This is useful for
/// context menus (pop-up menus) that may be created at unpredictable positions.
/// 
/// If the optional `setMaxSize` parameter is set to `true` (which it is by default) then the
/// maximum size of the element will be set to `"100%"` in both axes. This maximum size will only
/// be set if the `state` parameter is also `true`.
/// 
/// @param state
/// @param [setMaxSize=true]
/// @param [element=self]

function BentoLayoutSetClampInside(_state, _setMaxSize = true, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__layoutClampInside != _state)
        {
            __layoutClampInside = _state;
            
            if (_state && _setMaxSize)
            {
                BentoLayoutSetMaxSize("100%", "100%", _element);
            }
            
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}