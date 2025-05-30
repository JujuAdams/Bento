// Feather disable all

/// @param param
/// @param [scrollSpeed=default]
/// @param [element=self]

function GuiScrollSetParamY(_param, _scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        GuiScrollSet(__scrollY, lerp(__scrollMinY, __scrollMaxY, 1 - clamp(_param, 0, 1)), _scrollSpeed, _element);
    }
}