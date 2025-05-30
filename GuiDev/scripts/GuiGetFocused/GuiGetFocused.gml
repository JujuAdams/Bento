// Feather disable all

/// @param [element=self]

function GuiGetFocused(_element = self)
{
    return GuiExists(_element)? _element.GUI_VARS.__focused : false;
}