// Feather disable all

/// @param [instance=self]

function GuiScrollGetParamY(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return 0;
    
    with(_instance.GUI_VARS)
    {
        return 1 - clamp((__scrollY - __scrollMinY) / max(0.0001, __scrollMaxY - __scrollMinY), 0, 1);
    }
    
    return 0;
}