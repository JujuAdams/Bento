// Feather disable all

/// @param [element=self]

function GuiClipGetPartiallyVisible(_element = self)
{
    if (not GuiExists(_element)) return false;
    
    return (_element.GUI_VARS.__scissorVisibility != GUI_VISIBLE_NONE);
}