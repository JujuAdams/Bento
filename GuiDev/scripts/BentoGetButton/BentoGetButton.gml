// Feather disable all

/// @param [element=self]

function BentoGetButton(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__buttonType : BENTO_BUTTON_NEVER;
}