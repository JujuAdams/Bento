// Feather disable all

/// @param [element=self]

function GuiGetVisible(_element = self)
{
    if (not GUI_EXISTS(_element)) return false;
    
    return _element.GUI_VARS.__visible;
}