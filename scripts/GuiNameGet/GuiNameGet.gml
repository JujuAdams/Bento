// Feather disable all

/// @param instance

function GuiNameGet(_instance)
{
    if (not instance_exists(_instance)) return undefined;
    
    return _instance.__name;
}