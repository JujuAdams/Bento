// Feather disable all

/// Returns the name of an instance, as set by `GuiNameSet()`.
/// 
/// @param [instance=id]

function GuiNameGet(_instance = id)
{
    if (not instance_exists(_instance)) return undefined;
    
    return _instance.GUI_STRUCT.__name;
}