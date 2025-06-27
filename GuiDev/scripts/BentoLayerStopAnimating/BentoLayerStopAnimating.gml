// Feather disable all

/// @param name
/// @param [environmentName=current]

function BentoLayerStopAnimating(_name, _environmentName = undefined)
{
    var _layerStruct = __BentoLayerFind(_name, __BentoEnvironmentEnsure(_environmentName));
    if (_layerStruct == undefined) return;
    
    ds_map_clear(_layerStruct.__animatingMap);
    array_resize(_layerStruct.__animatingArray, 0);
}