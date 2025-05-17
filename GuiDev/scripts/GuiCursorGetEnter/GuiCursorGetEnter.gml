// Feather disable all

/// Returns whether the cursor has entered (newly hovered) the instance.
/// 
/// @param [element=self]

function GuiCursorGetEnter(_element = self)
{
    if (not __GuiExists(_element)) return false;
    return (_element.GUI_VARS.__overState == __GUI_START);
}