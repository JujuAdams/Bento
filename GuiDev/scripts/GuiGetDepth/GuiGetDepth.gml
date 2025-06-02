// Feather disable all

/// Returns the local depth for an instance.
/// 
/// @param [element=self]

function GuiGetDepth(_element = self)
{
    if (not GuiExists(_element)) return 0;
    
    return _element.GUI_VARS.__drawDepth;
}