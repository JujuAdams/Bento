// Feather disable all

/// @param [layerOrName]
/// @param [environmentOrName]

function BentoLayerGetHovered(_layerName = undefined, _environmentName = undefined)
{
    with(__BentoLayerEnsure(_layerName, _environmentName))
    {
        return __hoverElement;
    }
    
    return BENTO_NO_ELEMENT;
}