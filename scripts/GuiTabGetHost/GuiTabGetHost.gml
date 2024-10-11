// Feather disable all

/// @param instance

function GuiTabGetHost(_instance)
{
    if (not instance_exists(_instance)) return noone;
    
    return _instance.__tabsHost;
}