// Feather disable all

/// Returns the height of the instance.
/// 
/// @param [instance=id]

function GuiGetHeight(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.height;
}