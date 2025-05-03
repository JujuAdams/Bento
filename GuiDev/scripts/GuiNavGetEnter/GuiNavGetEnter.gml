// Feather disable all

/// Returns whether the cursor has entered (newly hovered) the instance.
/// 
/// @param [element=self]

function GuiNavGetEnter(_element = self)
{
    if (not GUI_EXISTS(_element)) return false;
    return (_element.GUI_VARS.__overState == GUI_ENTER);
}