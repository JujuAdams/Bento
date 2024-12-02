// Feather disable all

/// Returns the bounding box that encompasses all children (inside and outside) of the target
/// instance. The `padding` parameter allows you to add space around the edge of the bounding box.
/// A static struct is returned with the following member variables:
/// 
/// .x:      x-position of the middle of the bounding box
/// .y:      y-position of the middle of the bounding box
/// .width:  width of the bounding box
/// .height: height of the bounding box
/// .left:   x-position of the left of the bounding box
/// .top:    y-position of the top of the bounding box
/// .right:  x-position of the right of the bounding box
/// .bottom: y-position of the bottom of the bounding box
/// 
/// @param padLeft
/// @param padTop
/// @param padRight
/// @param padBottom
/// @param [instance=id]

function GuiGetChildrenBoundsExt(_padLeft, _padTop, _padRight, _padBottom, _instance = id)
{
    static _result = {};
    
    var _empty = true;
    
    with(_instance)
    {
        var _insideArray  = __childInsideArray;
        var _outsideArray = __childOutsideArray;
        
        if ((array_length(_insideArray) > 0) || (array_length(_outsideArray) > 0))
        {
            _empty = false;
            
            var _left   =  infinity;
            var _top    =  infinity; 
            var _right  = -infinity;
            var _bottom = -infinity;
            
            var _i = 0;
            repeat(array_length(_insideArray))
            {
                with(_insideArray[_i])
                {
                    _left   = min(_left,   bbox_left);
                    _top    = min(_top,    bbox_top);
                    _right  = max(_right,  bbox_right);
                    _bottom = max(_bottom, bbox_bottom);
                }
                
                ++_i;
            }
            
            var _i = 0;
            repeat(array_length(_outsideArray))
            {
                with(_outsideArray[_i])
                {
                    _left   = min(_left,   bbox_left);
                    _top    = min(_top,    bbox_top);
                    _right  = max(_right,  bbox_right);
                    _bottom = max(_bottom, bbox_bottom);
                }
                
                ++_i;
            }
            
            with(_result)
            {
                x = 0.5*(_left - _padLeft + _right + _padRight);
                y = 0.5*(_top - _padTop + _bottom + _padBottom);
                
                width  = _right - _left + _padLeft + _padRight;
                height = _bottom - _top + _padTop + _padBottom;
                
                left   = _left - _padLeft;
                top    = _top - _padTop;
                right  = _right + _padRight;
                bottom = _bottom + _padBottom;
            }
        }
    }
    
    if (_empty)
    {
        with(_result)
        {
            x = 0.5*(_padRight - _padLeft);
            y = 0.5*(_padBottom - _padTop);
            
            width  = _padLeft + _padRight;
            height = _padTop + _padBottom;
            
            left   = -_padLeft;
            top    = -_padTop;
            right  =  _padRight;
            bottom =  _padBottom;
        }
    }
    
    return _result;
}