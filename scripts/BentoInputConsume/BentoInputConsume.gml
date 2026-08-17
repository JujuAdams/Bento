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
        
        var _map = __environment.__envHotkeySeenMap;
        var _key = ds_map_find_first(_map);
        repeat(ds_map_size(_map))
        {
            __hotkeyConsumedMap[? _key] = true;
            _key = ds_map_find_next(_map, _key);
        }
    }
}