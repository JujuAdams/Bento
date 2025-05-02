// Feather disable all

/// @param [environment=current]

function GuiNavClearFocus(_environment = undefined)
{
    static _system = __GuiSystem();
    
    with(_environment ?? _system.__environmentCurrent)
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