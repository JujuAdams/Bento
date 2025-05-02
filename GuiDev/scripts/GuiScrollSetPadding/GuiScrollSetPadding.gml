// Feather disable all

/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [instance=self]

function GuiScrollSetPadding(_left, _top, _right, _bottom, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
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
            
            GuiScrollLimitsMarkDirty(_instance);
        }
    }
}