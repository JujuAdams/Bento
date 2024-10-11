// Feather disable all

/// @param instance

function GuiGetPriority(_instance)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.priority;
}