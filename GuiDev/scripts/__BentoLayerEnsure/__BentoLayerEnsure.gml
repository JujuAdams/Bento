// Feather disable all

/// @param layerOrName
/// @param environmentOrName
/// @param [fallback=current]

function __BentoLayerEnsure(_layerOrName, _environmentOrName = undefined, _fallback = undefined)
{
    static _system = __BentoSystem();
    
    if (is_struct(_layerOrName))
    {
        return _layerOrName;
    }
    
    if (is_string(_layerOrName))
    {
        return __BentoLayerFind(_layerOrName, __BentoEnvironmentEnsure(_environmentOrName));
    }
    
    return _fallback ?? _system.__layerCurrent;
}