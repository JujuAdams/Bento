// Feather disable all

/// Sets the margin around an element. Positive margin values will position the element away from 
/// the edge of its parent.
/// 
/// @param [left]
/// @param [top]
/// @param [right]
/// @param [bottom]
/// @param [element=self]

function BentoLayoutSetMarginExt(_left, _top, _right, _bottom, _element = self)
{
    with(__BentoGetVars(_element))
    {
        var _dirty = false;
        
        if (_left != undefined)
        {
            if (__layoutMarginLeft != _left)
            {
                __layoutMarginLeft = _left;
                _dirty = true;
            }
        }
        
        if (_top != undefined)
        {
            if (__layoutMarginTop != _top)
            {
                __layoutMarginTop = _top;
                _dirty = true;
            }
        }
        
        if (_right != undefined)
        {
            if (__layoutMarginRight != _right)
            {
                __layoutMarginRight = _right;
                _dirty = true;
            }
        }
        
        if (_bottom != undefined)
        {
            if (__layoutMarginBottom != _bottom)
            {
                __layoutMarginBottom = _bottom;
                _dirty = true;
            }
        }
        
        if (_dirty)
        {
            __layoutMarginWidth  = __layoutMarginLeft + __layoutMarginRight;
            __layoutMarginHeight = __layoutMarginTop + __layoutMarginBottom;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}