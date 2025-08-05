// Feather disable all

/// @param reference
/// @param value

function BentoRefAdd(_reference, _value)
{
    BentoRefSet(_reference, BentoRefGet(_reference, 0) + _value);
}