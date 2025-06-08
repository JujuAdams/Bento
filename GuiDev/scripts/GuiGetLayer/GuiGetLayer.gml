// Feather disable all

/// @param [element=self]

function GuiGetLayer(_element = self)
{
    return GuiExists(_element)? _element.GUI_VARS.__layer : undefined;
}