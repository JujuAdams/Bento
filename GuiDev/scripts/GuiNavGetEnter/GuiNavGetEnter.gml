// Feather disable all

/// Returns whether the cursor has entered (newly hovered) the instance.
/// 
/// @param [instance=self]

function GuiNavGetEnter(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return false;
    return (_instance.GUI_VARS.__overState == GUI_ENTER);
}