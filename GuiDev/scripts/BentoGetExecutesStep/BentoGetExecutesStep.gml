// Feather disable all

/// @param [element=self]

function BentoGetExecutesStep(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__executesStep : false;
}