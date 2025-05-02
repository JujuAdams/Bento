// Feather disable all

/// @param param
/// @param [instance=self]

function GuiScrollSetParamX(_param, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        GuiScrollSet(lerp(__scrollMinX, __scrollMaxX, 1 - clamp(_param, 0, 1)), __scrollY);
    }
}