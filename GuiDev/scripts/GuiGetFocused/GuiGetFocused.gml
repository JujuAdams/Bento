// Feather disable all

/// @param [element=self]

function GuiGetFocused(_element = self)
{
    return __GuiExists(_element)? _element.GUI_VARS.__focused : false;
}