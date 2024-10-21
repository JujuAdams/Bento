// Feather disable all

/// Convenience function that draws a fullscreen rectangle with the given `color` and `alpha`.
/// This is a helpful function to call when drawing modals.
/// 
/// @param color
/// @param alpha

function GuiDrawClear(_color, _alpha)
{
    var _oldColor = draw_get_color();
    var _oldAlpha = draw_get_alpha();
    
    draw_set_color(_color);
    draw_set_alpha(_alpha);
    draw_rectangle(-__GUI_VERY_LARGE, -__GUI_VERY_LARGE, __GUI_VERY_LARGE, __GUI_VERY_LARGE, false);
    
    draw_set_color(_oldColor);
    draw_set_alpha(_oldAlpha);
}