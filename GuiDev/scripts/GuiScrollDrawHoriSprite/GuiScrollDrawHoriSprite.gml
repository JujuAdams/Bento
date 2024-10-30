// Feather disable all

/// Draws a horizontal scrollbar at the given coordinates using a couple of sprites. The scrollbar
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

function GuiScrollDrawHoriSprite(_left, _top, _right, _bottom, _barSprite, _handleSprite, _handlePadding, _instance = id)
{
    with(_instance)
    {
        if (not _instance.__scrollEnabled) return;
        
        var _scrollSize = __scrollMaxX - __scrollMinX;
        if (_scrollSize <= 0) return;
        
        var _q = 1 - clamp((__scrollX - __scrollMinX) / (__scrollMaxX - __scrollMinX), 0, 1);
        
        var _handleSize = ceil((_right - _left) * (width / (width + _scrollSize)));
        var _x = lerp(_left + _handlePadding, _right - _handlePadding - _handleSize, _q);
        
        draw_sprite_stretched(_barSprite, 0, _left, _top, 1 + _right - _left, 1 + _bottom - _top);
        
        var _handleTop    = _top    + _handlePadding;
        var _handleBottom = _bottom - _handlePadding;
        draw_sprite_stretched(_handleSprite, 0, _x, _handleTop, 1 + _handleSize, 1 + _handleBottom - _handleTop);
    }
}