// Feather disable all

/// Returns if a layer contains any animating elements.
/// 
/// @param layerOrName
/// @param [environmentName=current]

function BentoLayerGetAnimating(_layerOrName, _environmentName = undefined)
{
    var _layerStruct = __BentoLayerEnsure(_layerOrName, __BentoEnvironmentEnsure(_environmentName));
    if (_layerStruct == undefined) return;
    
    return (not ds_map_empty(_layerStruct.__animatingMap));
}