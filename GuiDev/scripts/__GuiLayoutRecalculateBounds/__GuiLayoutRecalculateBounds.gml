// Feather disable all

/// Recalculates the boundary for a layout based on the current position of its member instances.

function __GuiLayoutRecalculateBounds()
{
    var _array = __instanceArray;
    if (array_length(_array) <= 0)
    {
        __width     = 0;
        __height    = 0;
        __maxWidth  = 0;
        __maxHeight = 0;
        return;
    }
    
    var _left   =  __GUI_VERY_LARGE;
    var _top    =  __GUI_VERY_LARGE;
    var _right  = -__GUI_VERY_LARGE;
    var _bottom = -__GUI_VERY_LARGE;
    
    var _maxWidth  = 0;
    var _maxHeight = 0;
    
    var _i = 0;
    repeat(array_length(_array))
    {
        with(_array[_i])
        {
            _left   = min(_left,   x - 0.5*width );
            _top    = min(_top,    y - 0.5*height);
            _right  = max(_right,  x + 0.5*width );
            _bottom = max(_bottom, y + 0.5*height);
            
            _maxWidth  = max(_maxWidth,  width);
            _maxHeight = max(_maxHeight, height);
        }
        
        ++_i;
    }
    
    __width  = _right - _left;
    __height = _bottom - _top;
    
    __maxWidth  = _maxWidth;
    __maxHeight = _maxHeight;
}