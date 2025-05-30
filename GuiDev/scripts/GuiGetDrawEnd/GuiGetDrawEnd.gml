// Feather disable all

/// Returns whether an instance has its Draw After user event enabled for use by `GuiSetDrawAfter()`.
/// 
/// @param [element=self]

function GuiGetDrawAfter(_element = self)
{
    if (not GuiExists(_element)) return false;
    
    return _element.GUI_VARS.__drawAfter;
}