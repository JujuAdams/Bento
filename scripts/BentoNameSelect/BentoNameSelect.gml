// Feather disable all

/// Selects the element with a matching name.
/// 
/// @param name
/// @param [environmentOrName=current]

function BentoNameSelect(_name, _environmentOrName = undefined)
{
    return BentoSelect(BentoNameFind(_name, _environmentOrName));
}