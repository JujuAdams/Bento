// Feather disable all

/// Returns the behavior set for a GUI instance. For more information, please see the setter
/// function `GuiSetBehavior()`.
/// 
/// @param [element=self]

function GuiGetBehavior(_element = self)
{
    if (not GUI_EXISTS(_element)) return undefined;
    
    return _element.GUI_VARS.__behavior;
}