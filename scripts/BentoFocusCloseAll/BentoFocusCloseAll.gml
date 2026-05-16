// Feather disable all

/// Closes focus for all focused elements on the given layer.
/// 
/// @param [layerOrName=current]

function BentoFocusCloseAll(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        var _focusStack = __layer.__focusStack;
        if (array_length(_focusStack) > 0)
        {
            __layer.__dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
            
            var _i = 0;
            repeat(array_length(_focusStack))
            {
                with(_focusStack[_i].__focusElement.BENTO_VARS)
                {
                    __focusType = BENTO_FOCUS_NONE;
                    __focused   = false;
                }
                
                ++_i;
            }
            
            array_resize(_focusStack, 0);
            __layer.__focusTop = undefined;
        }
    }
}