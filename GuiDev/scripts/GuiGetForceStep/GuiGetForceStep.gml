// Feather disable all

/// @param [element=self]

function GuiGetForceStep(_element = self)
{
    return __GuiExists(_element)? _element.GUI_VARS.__forceStep : false;
}