// Feather disable all

/// Returns whether the Step user event / callback is forced on for the given element.
/// 
/// @param [element=self]

function BentoGetForceStep(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__forceStep : false;
}