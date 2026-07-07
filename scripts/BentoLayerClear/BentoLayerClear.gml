// Feather disable all

/// Destroys all children on a layer.
/// 
/// @param [layerOrName=current]

function BentoLayerClear(_layerOrName = undefined)
{
    BentoDestroyChildren(BentoLayerGetRoot(_layerOrName));
}