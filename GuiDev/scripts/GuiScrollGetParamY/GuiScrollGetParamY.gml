// Feather disable all

/// @param [element=self]

function GuiScrollGetParamY(_element = self)
{
    if (not __GuiExists(_element)) return 0;
    
    with(_element.GUI_VARS)
    {
        return 1 - clamp((__scrollY - __scrollMinY) / max(0.0001, __scrollMaxY - __scrollMinY), 0, 1);
    }
    
    return 0;
}