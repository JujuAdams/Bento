// Feather disable all

/// Convenience function to draw a diagonal cross at a coordinate. Helpful for visually
/// identifying origins / pivot points etc.
/// 
/// @param x
/// @param y
/// @param [size=6]
/// @param [color=white]
/// @param [alpha=1]

function DrawCross(_x, _y, _size = 6, _color = c_white, _alpha = 1)
{
    var _oldColor = draw_get_color();
    var _oldAlpha = draw_get_alpha();
    
    draw_set_color(_color);
    draw_set_alpha(_alpha);
    
    draw_line(_x-_size, _y-_size, _x+_size, _y+_size);
    draw_line(_x-_size, _y+_size, _x+_size, _y-_size);
    
    draw_set_color(_oldColor);
    draw_set_alpha(_oldAlpha);
}