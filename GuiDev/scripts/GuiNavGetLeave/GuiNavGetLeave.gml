// Feather disable all

/// Returns whether the cursor has left (newly un-hovered) the instance.
/// 
/// @param [element=self]

function GuiNavGetLeave(_element = self)
{
    if (not GUI_EXISTS(_element)) return false;
    return (_element.GUI_VARS.__overState == GUI_LEAVE);
}