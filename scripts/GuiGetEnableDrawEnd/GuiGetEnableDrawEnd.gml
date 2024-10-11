// Feather disable all

/// @param [instance=id]

function GuiGetEnableDrawEnd(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    
    return _instance.__drawEnd;
}