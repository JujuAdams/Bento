// Feather disable all

/// Returns whether a layer is currently the top layer within its environment. If no parameters
/// are set, this function will target the currently processing layer.
/// 
/// @param [layerOrName]
/// @param [environmentOrName]

function BentoLayerGetTop(_layerName = undefined, _environmentName = undefined)
{
    with(__BentoLayerEnsure(_layerName, _environmentName))
    {
        return __isTopLayer;
    }
    
    return false;
}