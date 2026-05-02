// Feather disable all

/// Returns if a layer exists.
/// 
/// @param layerOrName
/// @param [environmentName=current]

function BentoLayerExists(_layerOrName, _environmentName = undefined)
{
    static _system = __BentoSystem();
    
    if (is_string(_layerOrName))
    {
        return (__BentoLayerFind(_layerOrName, __BentoEnvironmentEnsure(_environmentName)) != undefined);
    }
    else if (is_struct(_layerOrName))
    {
        return (array_get_index(__BentoEnvironmentEnsure(_environmentName, _layerOrName.__environment).__layerArray, _layerOrName) >= 0);
    }
    
    return false;
}