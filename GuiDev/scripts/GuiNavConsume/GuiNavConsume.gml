// Feather disable all

/// "Consumes" all user input.

function GuiNavConsume()
{
    static _globalHotkeyArray = __GuiSystem().__globalHotkeyArray;
    
    with(GUI_ENVIRONMENT)
    {
        __primaryConsumed = true;
        
        var _i = 0;
        repeat(array_length(_globalHotkeyArray))
        {
            __hotkeyConsumedMap[? _globalHotkeyArray[_i]] = true;
            ++_i;
        }
    }
}