// Feather disable all

/// Returns the absolute x-coordinate of the right of the instance.
/// 
/// @param [instance=id]

function GuiGetRight(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.x + _instance.width/2;
}