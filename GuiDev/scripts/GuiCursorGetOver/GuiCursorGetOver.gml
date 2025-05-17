// Feather disable all

/// Returns whether the cursor is over the instance.
/// 
/// @param [instance]

function GuiCursorGetOver(_element = self)
{
    if (not __GuiExists(_element)) return false;
    return ((_element.GUI_VARS.__overState == __GUI_START) || (_element.GUI_VARS.__overState == __GUI_ON));
}