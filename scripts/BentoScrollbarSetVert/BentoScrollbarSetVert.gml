// Feather disable all

/// Sets up a vertical scrollbar on an element. You may enable both a vertical and horizontal
/// scrollbar at the same time.
/// 
/// If the `orientLeft` parameter is set to `false`, the scrollbar will be placed on the righthand
/// side of the element. If the `overlap` parameter is set to `true` then children of the element
/// will be allowed to extend underneath the scrollbar. If the `overlap` parameter is set to
/// `false` then the scroll region will be reduced in size to accommodate the scrollbar.
/// 
/// N.B. This function will **not** automatically draw the scrollbar, it only sets up the
///      interaction logic. You should use `BentoScrollbarGetVertData()` to collect information
///      about the scrollbar's current state in a Draw After user event / callback and render
///      graphics accordingly.
/// 
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
    with(__BentoGetVars(_element))
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
        
        //FIXME - Don't mark the layer as dirty every time
        __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT | __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
    }
}