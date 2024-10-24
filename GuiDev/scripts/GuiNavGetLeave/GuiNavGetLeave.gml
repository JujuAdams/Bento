// Feather disable all

/// Returns whether the cursor has left (newly un-hovered) the instance.
/// 
/// @param [instance=id]

function GuiNavGetLeave(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return (_instance.__overState == GUI_LEAVE);
}