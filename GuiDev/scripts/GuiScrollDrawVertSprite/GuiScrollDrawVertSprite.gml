// Feather disable all

/// Draws a vertical scrollbar at the given coordinates using a couple of sprites. The scrollbar
/// is non-interactive and is purely visual.
/// 
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param barSprite
/// @param handleSprite
/// @param handlePadding
/// @param [instance=id]

function GuiScrollDrawVertSprite(_left, _top, _right, _bottom, _barSprite, _handleSprite, _handlePadding, _instance = id)
{
    with(_instance)
    {
        if (not _instance.__scrollEnabled) return;
        
        var _scrollSize = __scrollMaxY - __scrollMinY;
        if (_scrollSize <= 0) return;
        
        var _q = 1 - clamp((__scrollY - __scrollMinY) / (__scrollMaxY - __scrollMinY), 0, 1);
        
        var _handleSize = ceil((_bottom - _top) * (height / (height + _scrollSize)));
        var _y = lerp(_top + _handlePadding, _bottom - _handlePadding - _handleSize, _q);
        
        draw_sprite_stretched(_barSprite, 0, _left, _top, 1 + _right - _left, 1 + _bottom - _top);
        
        var _handleLeft  = _left  + _handlePadding;
        var _handleRight = _right - _handlePadding;
        draw_sprite_stretched(_handleSprite, 0, _handleLeft, _y, 1 + _handleRight - _handleLeft, 1 + _handleSize);
    }
}