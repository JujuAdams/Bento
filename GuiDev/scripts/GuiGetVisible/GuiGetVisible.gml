// Feather disable all

/// @param [instance=id]

function GuiGetVisible(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    
    return _instance.GUI_VARS.__visible;
}