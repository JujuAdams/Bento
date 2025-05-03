// Feather disable all

/// Returns the current scroll y-offset target.
/// 
/// @param [element=self]

function GuiScrollGetTargetY(_element = self)
{
    if (not GUI_EXISTS(_element)) return 0;
    
    return _element.GUI_VARS.__scrollTargetY;
}