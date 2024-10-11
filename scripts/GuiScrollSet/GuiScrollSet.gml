// Feather disable all

/// @param instance
/// @param [scrollX=0]
/// @param [scrollY=0]

function GuiScrollSet(_instance, _scrollX = 0, _scrollY = 0)
{
    with(_instance)
    {
        if (not __scroll) return;
        
        var _oldX = __scrollX;
        var _oldY = __scrollY;
        
        __scrollX = clamp(_scrollX, __scrollMinX, __scrollMaxX);
        __scrollY = clamp(_scrollY, __scrollMinY, __scrollMaxY);
        
        __GuiScrollApply(_instance, __scrollX - _oldX, __scrollY - _oldY);
    }
}