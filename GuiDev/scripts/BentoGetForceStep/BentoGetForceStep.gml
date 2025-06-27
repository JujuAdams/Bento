// Feather disable all

/// @param [element=self]

function BentoGetForceStep(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__forceStep : false;
}