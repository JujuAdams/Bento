// Feather disable all

/// @param param
/// @param [element=self]

function GuiScrollSetParamX(_param, _element = self)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        GuiScrollSet(lerp(__scrollMinX, __scrollMaxX, 1 - clamp(_param, 0, 1)), __scrollY, undefined, _element);
    }
}