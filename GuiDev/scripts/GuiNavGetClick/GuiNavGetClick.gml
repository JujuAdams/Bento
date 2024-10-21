// Feather disable all

/// Returns whether the instance has been clicked.
/// 
/// @param [instance=id]

function GuiNavGetClick(_instance = id)
{
    static _system = __GuiSystem();
    if (_system.__primaryConsumed) return false;
    
    if (not instance_exists(_instance)) return false;
    return _instance.click;
}