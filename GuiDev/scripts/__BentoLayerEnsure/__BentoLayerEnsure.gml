// Feather disable all

/// @param layerOrName
/// @param environmentOrName
/// @param [fallbackLayer=current]

function __BentoLayerEnsure(_layerOrName, _environmentOrName = undefined, _fallbackLayer = undefined)
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
    
    return _fallbackLayer ?? _system.__layerCurrent;
}