// Feather disable all

/// Returns the root element for the layer. This function is an alias for `BentoLayerGetRoot()`.
/// 
/// @param [layerOrName=current]

function BentoGetRoot(_layerOrName = undefined)
{
    return BentoLayerGetRoot(_layerOrName);
}