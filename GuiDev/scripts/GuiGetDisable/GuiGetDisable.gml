// Feather disable all

/// Returns whether an instance has been disabled by `GuiSetDisable()`.
/// 
/// @param [instance=self]

function GuiGetDisable(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return false;
    
    return _instance.GUI_VARS.__disable;
}