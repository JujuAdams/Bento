// Feather disable all

/// Returns the behavior set for a GUI instance. For more information, please see the setter
/// function `GuiSetBehavior()`.
/// 
/// @param [instance=self]

function GuiGetBehavior(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return undefined;
    
    return _instance.GUI_VARS.__behavior;
}