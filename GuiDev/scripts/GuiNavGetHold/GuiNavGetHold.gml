// Feather disable all

/// Returns whether the primary action has been activated and held on the instance.
/// 
/// @param [instance=id]

function GuiNavGetHold(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return ((_instance.__holdState == GUI_ENTER) || (_instance.__holdState == GUI_HOLD));
}