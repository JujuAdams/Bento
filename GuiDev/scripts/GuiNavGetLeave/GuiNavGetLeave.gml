// Feather disable all

/// Returns whether the cursor has left (newly un-hovered) the instance.
/// 
/// @param [instance=self]

function GuiNavGetLeave(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return false;
    return (_instance.GUI_VARS.__overState == GUI_LEAVE);
}