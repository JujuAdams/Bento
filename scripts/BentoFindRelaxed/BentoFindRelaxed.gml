/// Finds a box with the given identifier. If it cannot be found, <undefined> is returned.
/// 
/// @param identifier
/// @param [layerName]

function BentoFindRelaxed(_identifier, _layerName = undefined)
{
    static _global = __BentoGlobal();
    
    if (_layerName == undefined)
    {
        var _layer = __BentoLayerStackTop();
    }
    else
    {
        var _layer = _global.__currentHost.__GetLayer(_layerName);
    }
    
    if (!is_struct(_layer)) return undefined;
    
    return _layer.__struct.Find(_identifier);
}