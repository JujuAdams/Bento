// Feather disable all

/// @param [instance=id]

function GuiTabGetHost(_instance = id)
{
    if (not instance_exists(_instance)) return noone;
    
    return _instance.__tabsHost;
}