// Feather disable all

/// Returns whether the cursor has left (newly un-hovered) the instance.
/// 
/// @param [element=self]

function GuiCursorGetLeave(_element = self)
{
    if (not GuiExists(_element)) return false;
    return (_element.GUI_VARS.__overState == __GUI_END);
}