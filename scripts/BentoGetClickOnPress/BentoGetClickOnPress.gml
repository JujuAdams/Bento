// Feather disable all

/// @param [element=self]

function BentoGetClickOnPress(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__clickOnPress : false;
}