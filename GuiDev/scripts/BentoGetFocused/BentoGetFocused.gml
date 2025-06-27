// Feather disable all

/// @param [element=self]

function BentoGetFocused(_element = self)
{
    return BentoExists(_element)? _element.GUI_VARS.__focused : false;
}