// Feather disable all

/// @param name
/// @param [environment=current]

function BentoLayerStopAnimating(_name, _environment = undefined)
{
    var _layerStruct = BentoLayerFind(_name, _environment);
    if (_layerStruct == undefined) return;
    
    ds_map_clear(_layerStruct.__animatingMap);
    array_resize(_layerStruct.__animatingArray, 0);
}