// Feather disable all

/// @param param
/// @param [instance=self]

function GuiScrollSetParamY(_param, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        GuiScrollSet(__scrollY, lerp(__scrollMinY, __scrollMaxY, 1 - clamp(_param, 0, 1)));
    }
}