// Feather disable all

/// "Consumes" all user input.
/// 
/// @param [environment=current]

function GuiNavConsume(_environment = undefined)
{
    static _system = __GuiSystem();
    static _globalHotkeyArray = _system.__globalHotkeyArray;
    
    with(_environment ?? _system.__environmentCurrent)
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