// Feather disable all

/// @param [element=self]

function GuiGetListener(_element = self)
{
    return __GuiExists(_element)? _element.GUI_VARS.__listener : false;
}