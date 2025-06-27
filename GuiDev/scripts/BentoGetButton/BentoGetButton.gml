// Feather disable all

/// @param [element=self]

function BentoGetButton(_element = self)
{
    return BentoExists(_element)? _element.GUI_VARS.__buttonType : GUI_BUTTON_NEVER;
}