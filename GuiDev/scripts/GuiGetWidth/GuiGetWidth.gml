// Feather disable all

/// Returns the width of the instance.
/// 
/// @param [instance=id]

function GuiGetWidth(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.width;
}