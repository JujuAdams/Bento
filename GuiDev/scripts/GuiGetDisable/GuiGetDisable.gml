// Feather disable all

/// Returns whether an instance has been disabled by `GuiSetDisable()`.
/// 
/// @param [element=self]

function GuiGetDisable(_element = self)
{
    if (not GUI_EXISTS(_element)) return false;
    
    return _element.GUI_VARS.__disable;
}