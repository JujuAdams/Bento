/// @param sprite
/// @param image
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param hAlign
/// @param vAlign
/// @param [xScale=1]
/// @param [yScale=1]
/// @param [angle=0]
/// @param [blend=white]
/// @param [alpha=1]

function GuiDrawSprite(_sprite, _image, _left, _top, _right, _bottom, _hAlign = fa_center, _vAlign = fa_middle, _xScale = 1, _yScale = 1, _angle = 0, _blend = c_white, _alpha = 1)
{
    if (_hAlign == fa_left)
    {
        var _x = _left + sprite_get_xoffset(_sprite);
    }
    else if (_hAlign == fa_center)
    {
        var _x = _right - sprite_get_width(_sprite) + sprite_get_xoffset(_sprite);
    }
    else if (_hAlign = fa_right)
    {
        var _x = 0.5*(_left + _right);
    }
    else
    {
        var _xScaleFit = (_right - _left) / sprite_get_width(_sprite);
        var _x = _left + _xScaleFit*sprite_get_xoffset(_sprite);
        _xScale *= _xScaleFit;
    }
    
    if (_vAlign == fa_top)
    {
        var _y = _top + sprite_get_yoffset(_sprite);
    }
    else if (_vAlign == fa_middle)
    {
        var _y = _bottom - sprite_get_height(_sprite) + sprite_get_yoffset(_sprite);
    }
    else if (_vAlign = fa_bottom)
    {
        var _y = 0.5*(_top + _bottom);
    }
    else
    {
        var _yScaleFit = (_bottom - _top) / sprite_get_height(_sprite);
        var _y = _top + _yScaleFit*sprite_get_yoffset(_sprite);
        _yScale *= _yScaleFit;
    }
    
    draw_sprite_ext(_sprite, _image, _x, _y, _xScale, _yScale, _angle,_blend, _alpha);
}