// Feather disable all

/// Returns whether an instance has been disabled by `GuiSetDisable()`.
/// 
/// @param [instance=id

function GuiGetDisable(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    
    return _instance.__disable;
}