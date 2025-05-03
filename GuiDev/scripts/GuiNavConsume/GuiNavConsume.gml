// Feather disable all

/// "Consumes" all user input.
/// 
/// @param [layer=current]

function GuiNavConsume(_layer = undefined)
{
    static _system = __GuiSystem();
    static _globalHotkeyArray = _system.__envHotkeyArray;
    
    with(_layer ?? _system.__layerCurrent)
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