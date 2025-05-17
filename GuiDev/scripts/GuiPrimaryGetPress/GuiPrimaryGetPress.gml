// Feather disable all

/// Returns whether the primary action has pressed (newly held) the instance.
/// 
/// N.B. This is NOT the same as clicking an instance as an instance may be pressed for many
///      reasons other than user intent. To check whether an instance has been clicked, please use
///      `GuiPrimaryGetClick()`.
/// 
/// @param [instance]

function GuiPrimaryGetPress(_element = self)
{
    if (not __GuiExists(_element)) return false;
    return (_element.GUI_VARS.__primaryState == GUI_PRESS);
}