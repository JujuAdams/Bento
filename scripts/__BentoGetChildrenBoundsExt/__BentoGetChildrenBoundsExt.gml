// Feather disable all

/// Returns the bounding box that encompasses all children of the target element. The `padding`
/// parameter allows you to add space around the edge of the bounding box. A static struct is
/// returned with the following member variables:
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
/// @param [element=self]

function __BentoGetChildrenBoundsExt(_padLeft, _padTop, _padRight, _padBottom, _element = self)
{
    static _result = {};
    
    var _empty = true;
    
    if (BentoExists(_element))
    {
        with(_element.BENTO_VARS)
        {
            var _childArray = __childArray;
            if (array_length(_childArray) > 0)
            {
                _empty = false;
                
                var _left   =  infinity;
                var _top    =  infinity; 
                var _right  = -infinity;
                var _bottom = -infinity;
                
                var _i = 0;
                repeat(array_length(_childArray))
                {
                    with(_childArray[_i])
                    {
                        _left   = min(_left,   __solvedLeft);
                        _top    = min(_top,    __solvedTop);
                        _right  = max(_right,  __solvedLeft + __solvedWidth);
                        _bottom = max(_bottom, __solvedTop  + __solvedHeight);
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
            else
            {
                var _x = __attachedElement.bentoX;
                var _y = __attachedElement.bentoY;
                
                with(_result)
                {
                    x = _x;
                    y = _y;
                    
                    width  = _padLeft + _padRight;
                    height = _padTop + _padBottom;
                    
                    left   = _x - _padLeft;
                    top    = _y - _padTop;
                    right  = _x + _padRight;
                    bottom = _y + _padBottom;
                }
            }
        }
    }
    else
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