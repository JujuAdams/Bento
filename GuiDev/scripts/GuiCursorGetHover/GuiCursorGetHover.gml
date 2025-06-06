// Feather disable all

/// Returns whether the cursor is hovering the instance.
/// 
/// @param [element=self]

function GuiCursorGetHover(_element = self)
{
    if (not GuiExists(_element)) return false;
    return ((_element.GUI_VARS.__hoverState == __GUI_START) || (_element.GUI_VARS.__hoverState == __GUI_ON));
}