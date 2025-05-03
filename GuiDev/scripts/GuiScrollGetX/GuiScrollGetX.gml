// Feather disable all

/// Returns the current scroll x-offset.
/// 
/// @param [element=self]

function GuiScrollGetX(_element = self)
{
    if (not __GuiExists(_element)) return 0;
    
    return _element.GUI_VARS.__scrollX;
}