// Feather disable all

/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [element=self]

function BentoClipSetPadding(_left, _top, _right, _bottom, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if ((_left   != __scissorPadLeft)
        ||  (_top    != __scissorPadTop)
        ||  (_right  != __scissorPadRight)
        ||  (_bottom != __scissorPadBottom))
        {
            __scissorPadLeft   = _left;
            __scissorPadTop    = _top;
            __scissorPadRight  = _right;
            __scissorPadBottom = _bottom;
            
            __layer.__dirtyFlags |= __GUI_DIRTY_STEP | __GUI_DIRTY_HOVERABLE | __GUI_DIRTY_DRAW;
        }
    }
}