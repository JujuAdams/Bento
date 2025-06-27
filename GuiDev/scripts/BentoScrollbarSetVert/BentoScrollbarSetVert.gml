// Feather disable all

/// @param orientLeft
/// @param thickness
/// @param padLeft
/// @param padTop
/// @param padRight
/// @param padBottom
/// @param overlap
/// @param [element=self]

function BentoScrollbarSetVert(_mirror, _thickness, _padLeft, _padTop, _padRight, _padBottom, _overlap, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__scrollbarVert == undefined)
        {
            __scrollbarVert = new __BentoClassScrollbarVert(_element);
        }
        
        with(__scrollbarVert)
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
            __scissorScrollbarLeft  = _overlap? 0 : _padLeft + _thickness + _padRight;
            __scissorScrollbarRight = 0;
        }
        else
        {
            __scissorScrollbarLeft  = 0;
            __scissorScrollbarRight = _overlap? 0 : _padLeft + _thickness + _padRight;
        }
        
        //FIXME - Don't mark the as dirty every time
        __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT | __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
    }
}