// Feather disable all

function GuiNavClearFocus()
{
    static _system = __GuiSystem();
    
    with(_system)
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