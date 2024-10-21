// Feather disable all

/// "Consumes" all user input.

function GuiNavConsume()
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        __primaryConsumed = true;
        
        var _i = 0;
        repeat(array_length(__buttonArray))
        {
            __buttonConsumedMap[? __buttonArray[_i]] = true;
            ++_i;
        }
    }
}