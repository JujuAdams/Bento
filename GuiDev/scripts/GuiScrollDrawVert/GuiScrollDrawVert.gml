// Feather disable all

/// Draws a vertical scrollbar at the given coordinates. The scrollbar is non-interactive and is
/// purely visual.
/// 
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [instance=id]

function GuiScrollDrawVert(_left, _top, _right, _bottom, _instance = id)
{
    with(_instance)
    {
        if (not _instance.__scrollEnabled) return;
        
        var _scrollSize = __scrollMaxY - __scrollMinY;
        if (_scrollSize <= 0) return;
        
        var _q = 1 - clamp((__scrollY - __scrollMinY) / (__scrollMaxY - __scrollMinY), 0, 1);
        
        var _handleSize = (_bottom - _top) * (height / (height + _scrollSize));
        var _y = lerp(_top, _bottom - _handleSize, _q);
        
        draw_set_color(c_black);
        draw_rectangle(_left, _top, _right, _bottom, false);
        draw_set_color(c_white);
        draw_rectangle(_left, _top, _right, _bottom, true);
        draw_rectangle(_left, _y, _right, _y + _handleSize, false);
    }
}