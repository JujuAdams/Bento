// Feather disable all

/// Returns the input mode for a layer, as set by `BentoSetMode()`. This will be one of the
/// following constants:
/// 
/// - `BENTO_MODE_UNKNOWN`
/// - `BENTO_MODE_MOUSE`
/// - `BENTO_MODE_KEYBOARD`
/// - `BENTO_MODE_GAMEPAD`
/// - `BENTO_MODE_TOUCH`
/// 
/// @param [layerOrName=current]
/// @param [environmentName=current]

function BentoGetMode(_layerOrName = undefined, _environmentOrName = undefined)
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
    
    return _layer.__inputMode;
}