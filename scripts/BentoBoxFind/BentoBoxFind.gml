/// Finds a box with the given identifier. If it cannot be found, an exception is thrown.
/// 
/// @param identifier
/// @param [layerName]

function BentoBoxFind(_identifier, _layerName = undefined)
{
    static _global = __BentoGlobal();
    
    if (_layerName == undefined)
    {
        var _layer = __BentoLayerStackTop();
        if (!is_struct(_layer)) __BentoError("Current host has no layers");
    }
    else
    {
        var _layer = _global.__currentHost.__GetLayer(_layerName);
        if (!is_struct(_layer)) __BentoError("Layer named \"", _layerName, "\" doesn't exist");
    }
    
    var _result = _layer.__struct.Find(_identifier);
    if (!is_struct(_result)) __BentoError("Identifier \"", _identifier, "\" not found for ", _layer);
    
    return _result;
}