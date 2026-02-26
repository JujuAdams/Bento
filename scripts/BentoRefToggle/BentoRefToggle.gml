// Feather disable all

/// Toggles the value held by a reference, turning a `true` value into a `false` value and vice
/// versa. This reference must have been created by `BentoRefCreate()`. If the reference is no
/// longer valid (the struct has fallen out of scope or has been destroyed) then this function will
/// silently fail.
/// 
/// @param reference

function BentoRefToggle(_reference)
{
    BentoRefSet(_reference, not BentoRefGet(_reference, false));
}