// Feather disable all

/// Returns whether an instance has its Draw End user event enabled for use by `GuiSetEnableDrawEnd()`.
/// 
/// @param [instance=self]

function GuiGetEnableDrawEnd(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return false;
    
    return _instance.GUI_VARS.__drawEnd;
}