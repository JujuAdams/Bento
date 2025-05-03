// Feather disable all

/// @param [element=self]

function GuiScrollGetParamX(_element = self)
{
    if (not __GuiExists(_element)) return 0;
    
    with(_element.GUI_VARS)
    {
        return 1 - clamp((__scrollX - __scrollMinX) / max(0.0001, __scrollMaxX - __scrollMinX), 0, 1);
    }
    
    return 0;
}