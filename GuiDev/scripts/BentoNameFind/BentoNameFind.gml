// Feather disable all

/// Returns the `id` of the instance with a matching name. If no instance exists, this function
/// will return `BENTO_NO_ELEMENT`.
/// 
/// @param name
/// @param [layerOrName=current]

function BentoNameFind(_name, _layerOrName = undefined)
{
    var _layer = __BentoLayerEnsure(_layerOrName);
    if (_layer != undefined)
    {
        return (_layer.__nameMap[? _name] ?? BENTO_NO_ELEMENT);
    }
    else
    {
        return BENTO_NO_ELEMENT;
    }
}