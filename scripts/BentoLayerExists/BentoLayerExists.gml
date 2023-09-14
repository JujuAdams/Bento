/// @param [layerName]

function BentoLayerExists(_layerName = undefined)
{
    static _global = __BentoGlobal();
    
    return _global.__currentHost.__LayerExists(_layerName);
}