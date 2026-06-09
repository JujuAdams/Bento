// Feather disable all

/// Hovers the element with a matching name. This function will only work if the element exists
/// and the layer that element is on is using a navigation input mode. Please see `BentoHover()`
/// for further information.
/// 
/// @param name
/// @param [environmentOrName=current]

function BentoNameHover(_name, _environmentOrName = undefined)
{
    return BentoHover(BentoNameFind(_name, _environmentOrName));
}