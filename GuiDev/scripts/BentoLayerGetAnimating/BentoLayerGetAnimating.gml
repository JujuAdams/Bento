// Feather disable all

/// @param name
/// @param [environmentName=current]

function BentoLayerGetAnimating(_name, _environmentName = undefined)
{
    var _layerStruct = __BentoLayerFind(_name, __BentoEnvironmentEnsure(_environmentName));
    if (_layerStruct == undefined) return;
    
    return (not ds_map_empty(_layerStruct.__animatingMap));
}