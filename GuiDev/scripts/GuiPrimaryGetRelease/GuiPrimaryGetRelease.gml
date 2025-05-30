// Feather disable all

/// Returns whether the primary action has released (newly un-held) the instance.
/// 
/// N.B. This is NOT the same as clicking an instance as an instance may be released for many
///      reasons other than user intent. To check whether an instance has been clicked, please use
///      `GuiPrimaryGetClick()`.
/// 
/// @param [instance]

function GuiPrimaryGetRelease(_element = self)
{
    if (not GuiExists(_element)) return false;
    return (_element.GUI_VARS.__primaryState == __GUI_END);
}