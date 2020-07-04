/// @function bento_draw_rectangle(left, top, right, bottom, color, alpha, outlineThickness)
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param color
/// @param alpha
/// @param outlineThickness
function bento_draw_rectangle(_left, _top, _right, _bottom, _color, _alpha, _outline_thickness)
{
    //Draw the background fill using a single stretched sprite
    //This may seem a bit weird, but this is to ensure accuracy cross-platform
    if (_alpha > 0.0)
    {
        var _width  = 1 + _right - _left;
        var _height = 1 + _bottom - _top;
        
        if (_outline_thickness <= 0.0)
        {
            draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                      _left, _top,
                                      _width, _height,
                                      _color, _alpha);
        }
        else
        {
            //Top
            draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                      _left, _top,
                                      _width, _outline_thickness,
                                      _color, _alpha);
            
            //Left
            draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                      _left, _top + _outline_thickness,
                                      _outline_thickness, _height - 2*_outline_thickness,
                                      _color, _alpha);
            
            //Bottom
            draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                      _left, _bottom + 1 - _outline_thickness,
                                      _width, _outline_thickness,
                                      _color, _alpha);
            
            //Right
            draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                      _right + 1 - _outline_thickness, _top + _outline_thickness,
                                      _outline_thickness, _height - 2*_outline_thickness,
                                      _color, _alpha);
        }
    }
}