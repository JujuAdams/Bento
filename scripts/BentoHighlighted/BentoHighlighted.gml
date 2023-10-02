/// Returns the currently highlighted UI element for the given layer. If no UI element is
/// currently highlighted, or the layer doesn't exist, this function returns <undefined>.
/// 
/// @param [layerName=current]

function BentoHighlighted(_layerName = undefined)
{
    static _global = __BentoGlobal();
    
    if (_layerName == undefined)
    {
        var _layer = __BentoLayerStackTop();
        if (_layer == undefined) return;
        _layerName = _layer.__name;
    }
    
    return _global.__currentHost.__LayerGetHighlighted(_layerName);
}