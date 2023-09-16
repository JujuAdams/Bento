/// Deletes a layer with the given name. If the layer doesn't exists, this function does nothing.
/// 
/// @param [layerName=current]

function BentoLayerDelete(_layerName = undefined)
{
    static _global = __BentoGlobal();
    
    if (_layerName == undefined)
    {
        var _layer = __BentoLayerStackTop();
        if (_layer == undefined) return;
        _layerName = _layer.__name;
    }
    
    return _global.__currentHost.__LayerDelete(_layerName);
}