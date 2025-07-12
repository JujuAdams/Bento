// Feather disable all

/// Destroys a layer.
/// 
/// @param [layerOrName=current]

function BentoLayerDestroy(_layerOrName = undefined)
{
    var _layer = __BentoLayerEnsure(_layerOrName);
    if (_layer != undefined) _layer.__Destroy();
}