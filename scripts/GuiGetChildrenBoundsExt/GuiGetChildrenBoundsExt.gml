// Feather disable all

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
                    _left   = min(_left,   x - width/2);
                    _top    = min(_top,    y - height/2);
                    _right  = max(_right,  x + width/2);
                    _bottom = max(_bottom, y + height/2);
                }
                
                ++_i;
            }
            
            var _i = 0;
            repeat(array_length(_outsideArray))
            {
                with(_outsideArray[_i])
                {
                    _left   = min(_left,   x - width/2);
                    _top    = min(_top,    y - height/2);
                    _right  = max(_right,  x + width/2);
                    _bottom = max(_bottom, y + height/2);
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