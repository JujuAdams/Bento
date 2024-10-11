// Feather disable all

/// @param [instance=id]

function GuiGetBottom(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.y + _instance.height/2;
}