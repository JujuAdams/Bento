// Feather disable all

/// Returns the name of an instance, as set by `GuiNameSet()`.
/// 
/// @param instance

function GuiNameGet(_instance)
{
    if (not instance_exists(_instance)) return undefined;
    
    return _instance.__name;
}