// Feather disable all

/// Returns whether the cursor is over the instance.
/// 
/// @param [instance]

function GuiNavGetOver(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return ((_instance.overState == GUI_ENTER) || (_instance.overState == GUI_OVER));
}