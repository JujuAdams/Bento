// Feather disable all

/// Returns the instance ID of the host for the target instance. The target can be a tab button or
/// a tab child. If a tab isn't open, this function will return `noone`.
/// 
/// @param [instance=id]

function GuiTabGetHost(_instance = id)
{
    if (not instance_exists(_instance)) return noone;
    
    return _instance.__tabsHost;
}