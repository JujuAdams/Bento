// Feather disable all

/// Returns whether an element with the given name exists.
/// 
/// @param name
/// @param [layerOrName=current]

function BentoNameExists(_name, _layerOrName = undefined)
{
    var _layer = __BentoLayerEnsure(_layerOrName);
    if (_layer != undefined)
    {
        return BentoExists(_layer.__nameMap[? _name] ?? BENTO_NO_ELEMENT);
    }
    else
    {
        return false;
    }
}