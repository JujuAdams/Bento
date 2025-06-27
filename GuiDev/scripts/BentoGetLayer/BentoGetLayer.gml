// Feather disable all

/// @param [element=self]

function BentoGetLayer(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__layer : undefined;
}