// Feather disable all

/// Returns whether the instance has been clicked.
/// 
/// @param [instance=id]

function GuiNavGetClick(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    
    with(_instance.GUI_VARS)
    {
        return __environment.__primaryConsumed? false : __click;
    }
    
    return false;
}