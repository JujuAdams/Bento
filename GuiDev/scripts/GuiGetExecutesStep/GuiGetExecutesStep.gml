// Feather disable all

/// @param [element=self]

function GuiGetExecutesStep(_element = self)
{
    return __GuiExists(_element)? _element.GUI_VARS.__executesStep : false;
}