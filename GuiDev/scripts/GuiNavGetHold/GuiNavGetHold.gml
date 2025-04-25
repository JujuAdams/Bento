// Feather disable all

/// Returns whether the primary action has been activated and held on the instance.
/// 
/// @param [instance=id]

function GuiNavGetHold(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return ((_instance.GUI_STRUCT.__holdState == GUI_ENTER) || (_instance.GUI_STRUCT.__holdState == GUI_HOLD));
}