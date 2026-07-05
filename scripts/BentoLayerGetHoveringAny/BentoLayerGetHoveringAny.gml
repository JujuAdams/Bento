// Feather disable all

/// @param [layerOrName]
/// @param [environmentOrName]

function BentoLayerGetHoveringAny(_layerName = undefined, _environmentName = undefined)
{
    return BentoExists(BentoLayerGetHovered(_layerName, _environmentName));
}