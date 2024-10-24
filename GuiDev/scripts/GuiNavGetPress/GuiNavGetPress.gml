// Feather disable all

/// Returns whether the primary action has pressed (newly held) the instance.
/// 
/// N.B. This is NOT the same as clicking an instance as an instance may be pressed for many
///      reasons other than user intent. To check whether an instance has been clicked, please use
///      `GuiNavGetClick()`.
/// 
/// @param [instance]

function GuiNavGetPress(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return (_instance.__holdState == GUI_PRESS);
}