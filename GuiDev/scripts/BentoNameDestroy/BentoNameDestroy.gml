// Feather disable all

/// Destroys the element with the matching name, if it exists.
/// 
/// @param name
/// @param [layerOrName=current]

function BentoNameDestroy(_name, _layerOrName = undefined)
{
    BentoDestroy(BentoNameFind(_name, _layerOrName));
}