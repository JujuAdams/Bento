// Feather disable all

/// @param instance
/// @param left
/// @param top
/// @param right
/// @param bottom

function GuiScrollDrawHori(_instance, _left, _top, _right, _bottom)
{
    with(_instance)
    {
        if (not _instance.__scrollEnabled) return;
        
        var _scrollSize = __scrollMaxX - __scrollMinX;
        if (_scrollSize <= 0) return;
        
        var _q = 1 - clamp((__scrollX - __scrollMinX) / (__scrollMaxX - __scrollMinX), 0, 1);
        
        var _handleSize = (_right - _left) * (width / (width + _scrollSize));
        var _y = lerp(_left, _right - _handleSize, _q);
        
        draw_set_color(c_black);
        draw_rectangle(_left, _top, _right, _bottom, false);
        draw_set_color(c_white);
        draw_rectangle(_left, _top, _right, _bottom, true);
        draw_rectangle(_left, _y, _right + _handleSize, _y, false);
    }
}