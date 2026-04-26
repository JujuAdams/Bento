// Feather disable all

/// Returns the channel for the currently dragged element within the drag & drop system. If no
/// element is being dragged then this function returns `undefined`.
/// 
/// @param [layerOrName=current]
/// @param [environmentName=current]

function BentoCarryGetChannel(_layerOrName = undefined, _environmentOrName = undefined)
{
    var _layer = __BentoLayerEnsure(_layerOrName, _environmentOrName);
    if (_layer == undefined)
    {
        if (is_struct(_layerOrName))
        {
            __BentoError("Could not find layer (datatype=struct)");
        }
        else if (is_array(_layerOrName))
        {
            __BentoError("Could not find layer (datatype=array)");
        }
        else
        {
            __BentoError($"Could not find layer \"{_layerOrName}\"");
        }
    }
    
    with(__BentoGetVars(_layer.__carryItemElement))
    {
        return __carryItemChannel;
    }
    
    return undefined;
}