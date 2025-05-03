// Feather disable all

/// @param layerOrName
/// @param [environment=current]

function GuiLayerExists(_layerOrName, _environment = undefined)
{
    static _system = __GuiSystem();
    
    if (is_string(_layerOrName))
    {
        return (GuiLayerFind(_layerOrName, _environment ?? _system.__environmentCurrent) != undefined);
    }
    else if (is_struct(_layerOrName))
    {
        _environment ??= _layer.__environment;
        return (array_get_index(_environment.__layerArray, _layerOrName) >= 0);
    }
    
    return false;
}