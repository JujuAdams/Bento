// Feather disable all

/// Destroys an instance with a matching name, if it exists.
/// 
/// @param name

function BentoNameDestroy(_name)
{
    BentoDestroy(BentoNameFind(_name));
}