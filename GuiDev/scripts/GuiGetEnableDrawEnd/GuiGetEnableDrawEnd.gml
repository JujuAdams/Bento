// Feather disable all

/// Returns whether an instance has its Draw End user event enabled for use by `GuiSetEnableDrawEnd()`.
/// 
/// @param [element=self]

function GuiGetEnableDrawEnd(_element = self)
{
    if (not GUI_EXISTS(_element)) return false;
    
    return _element.GUI_VARS.__drawEnd;
}