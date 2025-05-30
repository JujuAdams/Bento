// Feather disable all

/// @param [element=self]

function GuiGetVisible(_element = self)
{
    if (not GuiExists(_element)) return false;
    
    return _element.GUI_VARS.__visible;
}