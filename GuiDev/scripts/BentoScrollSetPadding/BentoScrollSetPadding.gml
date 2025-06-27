// Feather disable all

/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [element=self]

function BentoScrollSetPadding(_left, _top, _right, _bottom, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if ((_left   != __scrollPadLeft)
        ||  (_top    != __scrollPadTop)
        ||  (_right  != __scrollPadRight)
        ||  (_bottom != __scrollPadBottom))
        {
            __scrollPadLeft   = _left;
            __scrollPadTop    = _top;
            __scrollPadRight  = _right;
            __scrollPadBottom = _bottom;
            
            BentoScrollLimitsMarkDirty(_element);
        }
    }
}