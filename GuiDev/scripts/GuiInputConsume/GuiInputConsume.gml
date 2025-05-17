// Feather disable all

/// "Consumes" all user input.
/// 
/// @param [layer=current]

function GuiInputConsume(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        __primaryConsumed = true;
        
        var _envHotkeyArray = __environment.__envHotkeyArray;
        var _i = 0;
        repeat(array_length(_envHotkeyArray))
        {
            __hotkeyConsumedMap[? _envHotkeyArray[_i]] = true;
            ++_i;
        }
    }
}