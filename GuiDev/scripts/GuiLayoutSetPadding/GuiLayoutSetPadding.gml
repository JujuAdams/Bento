// Feather disable all

/// @param [left]
/// @param [top]
/// @param [right]
/// @param [bottom]
/// @param [instance=self]

function GuiLayoutSetPadding(_left, _top, _right, _bottom, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (_left != undefined)
        {
            if (__layoutPadLeft != _left)
            {
                __layoutPadLeft = _left;
                __environment.__layoutDirty = true;
            }
        }
        
        if (_top != undefined)
        {
            if (__layoutPadTop != _top)
            {
                __layoutPadTop = _top;
                __environment.__layoutDirty = true;
            }
        }
        
        if (_right != undefined)
        {
            if (__layoutPadRight != _right)
            {
                __layoutPadRight = _right;
                __environment.__layoutDirty = true;
            }
        }
        
        if (_bottom != undefined)
        {
            if (__layoutPadBottom != _bottom)
            {
                __layoutPadBottom = _bottom;
                __environment.__layoutDirty = true;
            }
        }
    }
}