// Feather disable all

/// Returns the priority for an instance.
/// 
/// @param [element=self]

function GuiGetPriority(_element = self)
{
    if (not GuiExists(_element)) return 0;
    
    return _element.GUI_VARS.__priority;
}