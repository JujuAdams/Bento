// Feather disable all

/// Sets up a horizontal scrollbar on an element. You may enable both a vertical and horizontal
/// scrollbar at the same time.
/// 
/// If the `orientTop` parameter is set to `false`, the scrollbar will be placed at the bottom of
/// the element. If the `overlap` parameter is set to `true` then children of the element will be
/// allowed to extend underneath the scrollbar. If the `overlap` parameter is set to `false` then
/// the scroll region will be reduced in size to accommodate the scrollbar.
/// 
/// N.B. This function will **not** automatically draw the scrollbar, it only sets up the
///      interaction logic. You should use `BentoScrollbarGetHoriData()` to collect information
///      about the scrollbar's current state in a Draw After user event / callback and render
///      graphics accordingly.
/// 
/// @param orientTop
/// @param thickness
/// @param padLeft
/// @param padTop
/// @param padRight
/// @param padBottom
/// @param overlap
/// @param [element=self]

function BentoScrollbarSetHori(_mirror, _thickness, _padLeft, _padTop, _padRight, _padBottom, _overlap, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__scrollbarHori == undefined)
        {
            __scrollbarHori = new __BentoClassScrollbarHori(_element);
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
        
        //FIXME - Don't mark the layer as dirty every time
        __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT | __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
    }
}