// Feather disable all

/// @param reference

function BentoRefIsAlive(_reference)
{
    return (_reference == global)? true : weak_ref_alive(_reference.scope);
}