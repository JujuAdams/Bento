// Feather disable all

/// Destroys the element with the matching name, if it exists.
/// 
/// @param name
/// @param [environmentOrName=current]

function BentoNameDestroy(_name, _environmentOrName = undefined)
{
    BentoDestroy(BentoNameFind(_name, _environmentOrName));
}