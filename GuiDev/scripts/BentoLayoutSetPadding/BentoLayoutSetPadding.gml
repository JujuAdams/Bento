// Feather disable all

/// @param [left]
/// @param [top]
/// @param [right]
/// @param [bottom]
/// @param [element=self]

function BentoLayoutSetPadding(_left, _top, _right, _bottom, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (_left != undefined)
        {
            if (__layoutPadLeft != _left)
            {
                __layoutPadLeft = _left;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_top != undefined)
        {
            if (__layoutPadTop != _top)
            {
                __layoutPadTop = _top;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_right != undefined)
        {
            if (__layoutPadRight != _right)
            {
                __layoutPadRight = _right;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_bottom != undefined)
        {
            if (__layoutPadBottom != _bottom)
            {
                __layoutPadBottom = _bottom;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}