// Feather disable all

/// @param instance

function GuiGetName(_instance)
{
    if (not instance_exists(_instance)) return undefined;
    
    return _instance.__name;
}