// Feather disable all

/// Returns whether the instance has been clicked.
/// 
/// @param [element=self]

function GuiPrimaryGetClick(_element = self)
{
    if (not GuiExists(_element)) return false;
    
    with(_element.GUI_VARS)
    {
        return __layer.__primaryConsumed? false : __click;
    }
    
    return false;
}