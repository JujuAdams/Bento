/// @param text
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

function GuiDrawTextExtRegion(_text, _left, _top, _width, _height, _hAlign = fa_center, _vAlign = fa_middle, _xScale = 1, _yScale = 1, _angle = 0, _blend = c_white, _alpha = 1)
{
    if (_hAlign == fa_left)
    {
        var _x = _left;
    }
    else if (_hAlign = fa_right)
    {
        var _x = _left + _width;
    }
    else
    {
        //Default horizontal alignment to center
        var _x = _left + 0.5*_width;
    }
    
    if (_vAlign == fa_top)
    {
        var _y = _top;
    }
    else if (_vAlign = fa_bottom)
    {
        var _y = _top + _height;
    }
    else
    {
        //Default horizontal alignment to middle
        var _y = _top + 0.5*_height;
    }
    
    draw_text_ext_transformed_color(_x, _y, _text, -1, _width, _xScale, _yScale, _angle, _blend, _blend, _blend, _blend, _alpha);
}