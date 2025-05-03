// Feather disable all

/// @param [element=self]

function GuiNavGetFocus(_element = self)
{
    return GUI_EXISTS(_element)? _element.GUI_VARS.__focused : false;
}