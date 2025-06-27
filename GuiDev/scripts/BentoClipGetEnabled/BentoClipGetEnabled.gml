// Feather disable all

/// @param [element=self]

function BentoClipGetEnabled(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__scissorEnabled : false;
}