// Feather disable all

/// @param orientTop
/// @param height
/// @param padding
/// @param drawFunction
/// @param [element=self]

function GuiScrollbarSetHori(_mirror, _thickness, _padLeft, _padTop, _padRight, _padBottom, _element = self)
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
        }
        
        if (_mirror)
        {
            __scissorScrollbarTop    = _padTop + _thickness + _padBottom;
            __scissorScrollbarBottom = 0;
        }
        else
        {
            __scissorScrollbarTop    = 0;
            __scissorScrollbarBottom = _padTop + _thickness + _padBottom;
        }
        
        __layer.__stepDirty = true;
        
        //FIXME - Don't mark the layout as dirty every time
        __layer.__layoutDirty = true;
    }
}