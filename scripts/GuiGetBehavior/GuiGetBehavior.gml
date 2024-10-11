// Feather disable all

/// Returns the behavior set for a GUI instance. For more information, please see the setter
/// function `GuiSetBehavior()`.
/// 
/// @param instance

function GuiGetBehavior(_instance)
{
    if (not instance_exists(_instance)) return undefined;
    
    return _instance.__behavior;
}