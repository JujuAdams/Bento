// Feather disable all

/// @param [element=self]

function GuiScrollGetHeight(_element = self)
{
    if (not __GuiExists(_element)) return 0;
    
    with(_element.GUI_VARS)
    {
        if (not __scrollVert) return 0;
        return max(0, __scrollMaxY - __scrollMinY);
    }
    
    return 0;
}