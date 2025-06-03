// Feather disable all

/// @param orientTop
/// @param thickness
/// @param padLeft
/// @param padTop
/// @param padRight
/// @param padBottom
/// @param overlap
/// @param [element=self]

function GuiScrollbarSetHori(_mirror, _thickness, _padLeft, _padTop, _padRight, _padBottom, _overlap, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__scrollbarHori == undefined)
        {
            __scrollbarHori = new __GuiClassScrollbarHori(_element);
        }
        
        with(__scrollbarHori)
        {
            __mirror    = _mirror;
            __thickness = _thickness;
            __padLeft   = _padLeft;
            __padTop    = _padTop;
            __padRight  = _padRight;
            __padBottom = _padBottom;
            __overlap   = _overlap;
        }
        
        if (_mirror)
        {
            __scissorScrollbarTop    = _overlap? 0 : _padTop + _thickness + _padBottom;
            __scissorScrollbarBottom = 0;
        }
        else
        {
            __scissorScrollbarTop    = 0;
            __scissorScrollbarBottom = _overlap? 0 : _padTop + _thickness + _padBottom;
        }
        
        //FIXME - Don't mark the as dirty every time
        __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT | __GUI_DIRTY_STEP | __GUI_DIRTY_HOVERABLE;
    }
}