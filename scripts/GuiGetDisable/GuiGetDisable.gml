// Feather disable all

/// @param instance

function GuiGetDisable(_instance)
{
    if (not instance_exists(_instance)) return false;
    
    return _instance.__disable;
}