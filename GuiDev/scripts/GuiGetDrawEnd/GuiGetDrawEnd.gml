// Feather disable all

/// Returns whether an instance has its Draw End user event enabled for use by `GuiSetDrawEnd()`.
/// 
/// @param [element=self]

function GuiGetDrawEnd(_element = self)
{
    if (not __GuiExists(_element)) return false;
    
    return _element.GUI_VARS.__drawEnd;
}