// Feather disable all

/// @param [element=self]

function BentoClipGetPartiallyVisible(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    return (_element.GUI_VARS.__scissorVisibility != GUI_VISIBLE_NONE);
}