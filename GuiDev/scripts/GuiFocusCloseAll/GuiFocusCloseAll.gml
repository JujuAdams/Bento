// Feather disable all

/// @param [layer=current]

function GuiFocusCloseAll(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        var _focusStack = __layer.__focusStack;
        if (array_length(_focusStack) > 0)
        {
            with(__layer)
            {
                __stepDirty      = true;
                __hoverableDirty = true;
            }
            
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