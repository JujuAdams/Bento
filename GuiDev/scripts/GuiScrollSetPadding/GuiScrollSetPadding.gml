// Feather disable all

/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [instance=id]

function GuiScrollSetPadding(_left, _top, _right, _bottom, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
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