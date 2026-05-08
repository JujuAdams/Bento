// Feather disable all

/// Gets whether a layer should be drawn when backgrounded.
/// 
/// @param [layerOrName=current]
/// @param [environmentOrName=current]

function BentoLayerGetDrawWhenBackgrounded(_layerOrName = undefined, _environmentOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName, _environmentOrName, noone))
    {
        return __drawWhenBackgrounded;
    }
    
    return false;
}