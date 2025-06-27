// Feather disable all

// TODO - Move name map to environment?

/// Selects the element with a matching name.
/// 
/// @param name
/// @param [layerOrName=current]

function BentoNameSelect(_name, _layerOrName = undefined)
{
    return BentoSelect(BentoNameFind(_name, _layerOrName));
}