// Feather disable all

/// Returns the current scroll x-offset target.
/// 
/// @param [element=self]

function GuiScrollGetTargetX(_element = self)
{
    if (not GuiExists(_element)) return 0;
    
    return _element.GUI_VARS.__scrollTargetX;
}