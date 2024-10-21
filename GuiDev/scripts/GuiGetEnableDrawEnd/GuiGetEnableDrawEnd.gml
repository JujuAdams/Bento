// Feather disable all

/// Returns whether an instance has its Draw End user event enabled for use by `GuiSetEnableDrawEnd()`.
/// 
/// @param [instance=id]

function GuiGetEnableDrawEnd(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    
    return _instance.__drawEnd;
}