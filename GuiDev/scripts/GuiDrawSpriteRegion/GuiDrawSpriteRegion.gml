/// @param sprite
/// @param image
/// @param left
/// @param top
/// @param width
/// @param height
/// @param hAlign
/// @param vAlign
/// @param [xScale=1]
/// @param [yScale=1]
/// @param [angle=0]
/// @param [blend=white]
/// @param [alpha=1]

function GuiDrawSpriteRegion(_sprite, _image, _left, _top, _width, _height, _hAlign = fa_center, _vAlign = fa_middle, _xScale = 1, _yScale = 1, _angle = 0, _blend = c_white, _alpha = 1)
{
    if (_hAlign == fa_left)
    {
        var _x = _left + sprite_get_xoffset(_sprite);
    }
    else if (_hAlign == fa_center)
    {
        var _x = _left + 0.5*_width;
    }
    else if (_hAlign = fa_right)
    {
        var _x = _left + _width - sprite_get_width(_sprite) + sprite_get_xoffset(_sprite);
    }
    else
    {
        //Default to stretch
        var _xScaleFit = _width / sprite_get_width(_sprite);
        var _x = _left + _xScaleFit*sprite_get_xoffset(_sprite);
        _xScale *= _xScaleFit;
    }
    
    if (_vAlign == fa_top)
    {
        var _y = _top + sprite_get_yoffset(_sprite);
    }
    else if (_vAlign == fa_middle)
    {
        var _y = _top + 0.5*_height;
    }
    else if (_vAlign = fa_bottom)
    {
        var _y = _top + _height - sprite_get_height(_sprite) + sprite_get_yoffset(_sprite);
    }
    else
    {
        //Default to stretch
        var _yScaleFit = _height / sprite_get_height(_sprite);
        var _y = _top + _yScaleFit*sprite_get_yoffset(_sprite);
        _yScale *= _yScaleFit;
    }
    
    draw_sprite_ext(_sprite, _image, _x, _y, _xScale, _yScale, _angle, _blend, _alpha);
}