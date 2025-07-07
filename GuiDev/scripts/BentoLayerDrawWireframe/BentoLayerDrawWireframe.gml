// Feather disable all

/// @param [layerName=top]
/// @param [environmentName=current]

function BentoLayerDrawWireframe(_layerName = undefined, _environmentName = undefined)
{
    if (_layerName == undefined)
    {
        var _layer = __BentoLayerTop(_environmentName);
    }
    else
    {
        var _layer = __BentoLayerFind(_layerName, _environmentName);
    }
    
    with(_layer)
    {
        __DrawWireframe();
    }
}