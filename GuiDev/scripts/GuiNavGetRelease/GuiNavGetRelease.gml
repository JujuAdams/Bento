// Feather disable all

/// Returns whether the primary action has released (newly un-held) the instance.
/// 
/// N.B. This is NOT the same as clicking an instance as an instance may be released for many
///      reasons other than user intent. To check whether an instance has been clicked, please use
///      `GuiNavGetClick()`.
/// 
/// @param [instance]

function GuiNavGetRelease(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return false;
    return (_instance.GUI_VARS.__holdState == GUI_RELEASE);
}