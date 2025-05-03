// Feather disable all

/// @param [layer=current]

function GuiNavClearFocus(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        var _i = 0;
        repeat(array_length(__stepRootStack))
        {
            __stepRootStack[_i].__focused = false;
            ++_i;
        }
        
        array_resize(__stepRootStack, 0);
    }
}