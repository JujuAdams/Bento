// Feather disable all

/// Sets the scroll offset.
/// 
/// @param scrollX
/// @param scrollY
/// @param [instance=id]

function GuiScrollSet(_scrollX, _scrollY, _instance = id)
{
    with(_instance)
    {
        if (not __scrollEnabled) return;
        
        var _oldX = __scrollX;
        var _oldY = __scrollY;
        
        __scrollX = clamp(_scrollX, __scrollMinX, __scrollMaxX);
        __scrollY = clamp(_scrollY, __scrollMinY, __scrollMaxY);
        
        __GuiScrollApply(_instance, __scrollX - _oldX, __scrollY - _oldY);
    }
}