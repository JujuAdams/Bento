// Feather disable all

/// @param [instance=id]

function GuiGetRight(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.x + _instance.width/2;
}