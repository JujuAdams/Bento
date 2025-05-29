// Feather disable all

/// Returns the current scroll y-offset.
/// 
/// @param [element=self]

function GuiScrollGetY(_element = self)
{
    if (not __GuiExists(_element)) return 0;
    
    return _element.GUI_VARS.__scrollY;
}