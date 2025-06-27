// Feather disable all

/// "Consumes" all user input.
/// 
/// @param [layerOrName=current]

function BentoInputConsume(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
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