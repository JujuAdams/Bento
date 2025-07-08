// Feather disable all

/// Sets the padding values for the clipping region for an element. These values position the
/// clipping region relative to the element's bounding box.
/// 
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [element=self]

function BentoClipSetPadding(_left, _top, _right, _bottom, _element = self)
{
    with(__BentoGetVars(_element))
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
            
            __layer.__dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE | __BENTO_DIRTY_DRAW;
        }
    }
}