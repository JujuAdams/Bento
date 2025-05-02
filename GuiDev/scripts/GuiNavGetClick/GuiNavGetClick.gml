// Feather disable all

/// Returns whether the instance has been clicked.
/// 
/// @param [instance=self]

function GuiNavGetClick(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return false;
    
    with(_instance.GUI_VARS)
    {
        return __environment.__primaryConsumed? false : __click;
    }
    
    return false;
}