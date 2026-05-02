// Feather disable all

/// Sets the padding values for the scroll area for an element. These values position the scroll
/// area relative to the element's bounding box.
/// 
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [element=self]

function BentoScrollSetPadding(_left, _top, _right, _bottom, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if ((_left   != __scrollPadLeft)
        ||  (_top    != __scrollPadTop)
        ||  (_right  != __scrollPadRight)
        ||  (_bottom != __scrollPadBottom))
        {
            __scrollX += _left - __scrollPadLeft;
            __scrollY += _top  - __scrollPadTop;
            
            __scrollPadLeft   = _left;
            __scrollPadTop    = _top;
            __scrollPadRight  = _right;
            __scrollPadBottom = _bottom;
            
            BentoScrollLimitsMarkDirty(_element);
        }
    }
}