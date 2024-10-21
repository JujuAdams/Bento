// Feather disable all

/// Returns a static struct containing the bounding box for members of a layout. The `padding`
/// parameter allows you to adding spacing around the edge of member instances. The returned
/// struct will contain the following member variables:
/// 
/// .x:      x-position of the center of the bounding box
/// .y:      y-position of the center of the bounding box
/// .width:  width of the bounding box
/// .height: height of the bounding box
/// 
/// @param layout
/// @param padLeft
/// @param padTop
/// @param padRight
/// @param padBottom

function GuiLayoutGetBoundsExt(_layout, _padLeft, _padTop, _padRight, _padBottom)
{
    static _result = {};
    
    var _array = _layout.__instanceArray;
    
    var _left   =  __GUI_VERY_LARGE;
    var _top    =  __GUI_VERY_LARGE;
    var _right  = -__GUI_VERY_LARGE;
    var _bottom = -__GUI_VERY_LARGE;
    
    var _i = 0;
    repeat(array_length(_array))
    {
        with(_array[_i])
        {
            _left   = min(_left,   x - 0.5*width );
            _top    = min(_top,    y - 0.5*height);
            _right  = max(_right,  x + 0.5*width );
            _bottom = max(_bottom, y + 0.5*height);
        }
        
        ++_i;
    }
    
    with(_result)
    {
        x = 0.5*(_left - _padLeft + _right + _padRight);
        y = 0.5*(_top - _padTop + _bottom + _padBottom);
        
        width  = _right - _left + _padLeft + _padRight;
        height = _bottom - _top + _padTop + _padBottom;
    }
    
    return _result;
}