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
    
    if (_fallbackLayer != undefined)
    {
        return _fallbackLayer;
    }
    
    var _layer = _system.__layerCurrent;
    if (_layer != undefined)
    {
        return _layer;
    }
    
    var _environment = __BentoEnvironmentEnsure(_environmentOrName);
    if (_environment == undefined)
    {
        __BentoError($"Could not find an environment");
    }
    
    var _layer = array_last(_environment.__layerArray);
    if (_layer != undefined)
    {
        return _layer;
    }
    
    __BentoError($"No layer exists on environment \"{__BentoEnvironmentEnsure(_environmentOrName).__name}\"");
}