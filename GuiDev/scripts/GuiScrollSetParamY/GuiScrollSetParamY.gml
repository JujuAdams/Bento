// Feather disable all

/// @param param
/// @param [element=self]

function GuiScrollSetParamY(_param, _element = self)
{
    if (not GUI_EXISTS(_element)) return;
    
    with(_element.GUI_VARS)
    {
        GuiScrollSet(__scrollY, lerp(__scrollMinY, __scrollMaxY, 1 - clamp(_param, 0, 1)));
    }
}