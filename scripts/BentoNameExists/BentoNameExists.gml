// Feather disable all

/// Returns whether an element with the given name exists.
/// 
/// @param name
/// @param [environmentOrName=current]

function BentoNameExists(_name, _environmentOrName = undefined)
{
    return BentoExists(BentoNameFind(_name, _environmentOrName));
}