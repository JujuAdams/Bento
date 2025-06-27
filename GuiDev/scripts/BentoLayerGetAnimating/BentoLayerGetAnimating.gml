// Feather disable all

/// @param name
/// @param [environment=current]

function BentoLayerGetAnimating(_name, _environment = undefined)
{
    var _layerStruct = BentoLayerFind(_name, _environment);
    if (_layerStruct == undefined) return;
    
    return (not ds_map_empty(_layerStruct.__animatingMap));
}