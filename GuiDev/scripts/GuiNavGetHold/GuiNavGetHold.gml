// Feather disable all

/// Returns whether the primary action has been activated and held on the instance.
/// 
/// @param [instance=self]

function GuiNavGetHold(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return false;
    return ((_instance.GUI_VARS.__holdState == GUI_ENTER) || (_instance.GUI_VARS.__holdState == GUI_HOLD));
}