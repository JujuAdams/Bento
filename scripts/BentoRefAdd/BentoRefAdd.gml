// Feather disable all

/// Adds a numeric value to the existingvalue held by a reference. This reference must have been
/// created by `BentoRef()`. If the reference is no longer valid (the struct has fallen out
/// of scope or has been destroyed) then this function will silently fail. if the value to add is
/// non-numeric then this function will silently fail.
/// 
/// @param reference
/// @param value

function BentoRefAdd(_reference, _value)
{
    if (not is_numeric(_value)) return 0;
    
    _value += BentoRefGet(_reference, 0);
    BentoRefSet(_reference, _value);
    
    return _value;
}