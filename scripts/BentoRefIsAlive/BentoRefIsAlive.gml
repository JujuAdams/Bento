// Feather disable all

/// Returns whether a reference still exists and is valid.
/// 
/// @param reference

function BentoRefIsAlive(_reference)
{
    return (_reference.scope == global)? true : weak_ref_alive(_reference.scope);
}