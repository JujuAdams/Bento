// Feather disable all

/// Returns the absolute y-coordinate of the top of the instance.
/// 
/// @param [instance=id]

function GuiGetTop(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.y - _instance.height/2;
}