// Feather disable all

/// @param [element=self]

function GuiGetForceStep(_element = self)
{
    return GuiExists(_element)? _element.GUI_VARS.__forceStep : false;
}