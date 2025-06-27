// Feather disable all

/// @param [element=self]

function BentoFocusGetEnclose(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__focusEncloseType : false;
}