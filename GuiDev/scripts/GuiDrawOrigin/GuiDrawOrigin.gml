// Feather disable all

/// @param [size=3]
/// @param [color=white]
/// @param [alpha=1]

function GuiDrawOrigin(_size = 3, _color = c_white, _alpha = 1)
{
    var _oldColor = draw_get_color();
    var _oldAlpha = draw_get_alpha();
    
    draw_set_color(_color);
    draw_set_alpha(_alpha);
    
    var _x = layoutX;
    var _y = layoutY; 
    
    draw_line(_x-_size, _y-_size, _x+_size, _y+_size);
    draw_line(_x-_size, _y+_size, _x+_size, _y-_size);
    
    draw_set_color(_oldColor);
    draw_set_alpha(_oldAlpha);
}