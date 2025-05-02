// Feather disable all

/// @param [instance=self]

function GuiScrollGetParamX(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return 0;
    
    with(_instance.GUI_VARS)
    {
        return 1 - clamp((__scrollX - __scrollMinX) / max(0.0001, __scrollMaxX - __scrollMinX), 0, 1);
    }
    
    return 0;
}