// Feather disable all

/// "Consumes" all user input.
/// 
/// @param [layerOrName=current]

function BentoInputConsume(_layerOrName = undefined)
{
    static _hotkeyArray = [];
    
    with(__BentoLayerEnsure(_layerOrName))
    {
        __primaryConsumed = true;
        
        var _map = __hotkeyConsumedMap;
        ds_map_keys_to_array(__environment.__envHotkeyInputMap, _hotkeyArray);
        var _i = 0;
        repeat(array_length(_hotkeyArray))
        {
            _map[? _hotkeyArray[_i]] = true;
            ++_i;
        }
        
        array_resize(_hotkeyArray, 0);
    }
}