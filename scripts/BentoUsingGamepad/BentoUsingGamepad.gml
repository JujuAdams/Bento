// Feather disable all

/// Returns whether the input mode has been set to `BENTO_MODE_GAMEPAD`.
/// 
/// @param [layerOrName=current]
/// @param [environmentName=current]

function BentoUsingGamepad(_layerOrName = undefined, _environmentOrName = undefined)
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
    
    return (_layer.__inputMode == BENTO_MODE_GAMEPAD);
}