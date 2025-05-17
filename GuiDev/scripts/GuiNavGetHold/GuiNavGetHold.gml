// Feather disable all

/// Returns whether the primary action has been activated and held on the instance.
/// 
/// @param [element=self]

function GuiNavGetHold(_element = self)
{
    if (not __GuiExists(_element)) return false;
    return ((_element.GUI_VARS.__primaryState & GUI_PRESS) > 0);
}