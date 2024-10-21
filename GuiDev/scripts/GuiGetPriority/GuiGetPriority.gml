// Feather disable all

/// Returns the priority for an instance.
/// 
/// @param [instance=id]

function GuiGetPriority(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.priority;
}