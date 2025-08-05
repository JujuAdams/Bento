// Feather disable all

/// @param reference

function BentoRefToggle(_reference)
{
    BentoRefSet(_reference, not BentoRefGet(_reference, false));
}