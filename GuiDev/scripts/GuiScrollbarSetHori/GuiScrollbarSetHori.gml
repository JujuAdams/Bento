// Feather disable all

/// @param top
/// @param height
/// @param padding
/// @param drawFunction
/// @param [element=self]
/// @param [level=always]

function GuiScrollbarSetHori(_mirror, _thickness, _padding, _drawFunction, _element = self, _level = GUI_SCROLLBAR_ALWAYS)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS.__scrollbarHori)
    {
        __mirror    = _mirror;
        __thickness = _thickness;
        __padding   = _padding;
        __level     = _level;
        __drawFunc  = method(_element, __drawFunc);
    }
}