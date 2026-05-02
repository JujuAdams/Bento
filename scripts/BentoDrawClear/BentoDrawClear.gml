// Feather disable all

/// Convenience function that draws a fullscreen rectangle with the given `color` and `alpha`.
/// This is a helpful function to call when drawing modals.
/// 
/// @param [color=black]
/// @param [alpha=0.4]

function BentoDrawClear(_color = c_black, _alpha = 0.4)
{
    var _oldColor = draw_get_color();
    var _oldAlpha = draw_get_alpha();
    
    draw_set_color(_color);
    draw_set_alpha(_alpha);
    draw_rectangle(-__BENTO_VERY_LARGE, -__BENTO_VERY_LARGE, __BENTO_VERY_LARGE, __BENTO_VERY_LARGE, false);
    
    draw_set_color(_oldColor);
    draw_set_alpha(_oldAlpha);
}