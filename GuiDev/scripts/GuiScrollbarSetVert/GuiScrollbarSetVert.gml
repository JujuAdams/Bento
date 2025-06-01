// Feather disable all

/// @param orientLeft
/// @param thickness
/// @param padLeft
/// @param padTop
/// @param padRight
/// @param padBottom
/// @param [element=self]

function GuiScrollbarSetVert(_mirror, _thickness, _padLeft, _padTop, _padRight, _padBottom, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__scrollbarVert == undefined)
        {
            __scrollbarVert = new __GuiClassScrollbarVert(_element);
        }
        
        with(__scrollbarVert)
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
            __scissorScrollbarLeft  = _padLeft + _thickness + _padRight;
            __scissorScrollbarRight = 0;
        }
        else
        {
            __scissorScrollbarLeft  = 0;
            __scissorScrollbarRight = _padLeft + _thickness + _padRight;
        }
        
        //FIXME - Don't mark the layout as dirty every time
        __layer.__layoutDirty = true;
    }
}