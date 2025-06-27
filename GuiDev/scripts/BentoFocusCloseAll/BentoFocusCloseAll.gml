// Feather disable all

/// Closes focus for all focused elements on the given layer.
/// 
/// @param [layer=current]

function BentoFocusCloseAll(_layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        var _focusStack = __layer.__focusStack;
        if (array_length(_focusStack) > 0)
        {
            __layer.__dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
            
            var _i = 0;
            repeat(array_length(_focusStack))
            {
                _focusStack[_i].__focused = false;
                ++_i;
            }
            
            array_resize(_focusStack, 0);
            __layer.__focusTop = undefined;
        }
    }
}