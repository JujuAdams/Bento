// Feather disable all

function __GuiSolverListResizeWidth()
{
    var _childArray = __childArray;
    var _childCount = array_length(_childArray);
    
    var _remaining = __solvedWidth - __solverFitWidth;
    
    if (__listAxis == GUI_AXIS_Y)
    {
        //////
        // Minor Axis - Stretch grow elements to the maximum available space
        //////
            
        var _available = __solvedWidth - (__layoutPadLeft + __layoutPadRight);
        if (_available > 0)
        {
            var _i = 0;
            repeat(_childCount)
            {
                with( _childArray[_i].__gui)
                {
                    if (__layoutWidthResize == GUI_RESIZE_FIT)
                    {
                        __solvedWidth = clamp(min(__solvedWidth, _available), __layoutWidthMin, __layoutWidthMax);
                    }
                    else if (__layoutWidthResize == GUI_RESIZE_GROW)
                    {
                        __solvedWidth = clamp(_available, __layoutWidthMin, __layoutWidthMax);
                    }
                }
                
                ++_i;
            }
        }
    }
    else
    {
        //////
        // Major Axis
        //////
            
        static _modifiableArray = [];
        static _modifyingArray  = [];
            
        if (_remaining > 0)
        {
            //////
            // Grow children
            //////
                
            var _i = 0;
            repeat(_childCount)
            {
                var _child = _childArray[_i];
                if (_child.__gui.__layoutWidthResize == GUI_RESIZE_GROW)
                {
                    array_push(_modifiableArray, _child);
                }
                    
                ++_i;
            }
            
            while ((_remaining > 0) && (array_length(_modifiableArray) > 0))
            {
                var _min       = infinity;
                var _secondMin = undefined;
                
                var _i = 0;
                repeat(array_length(_modifiableArray))
                {
                    var _child = _modifiableArray[_i];
                    
                    var _childSize = _child.__gui.__solvedWidth;
                    if (_childSize < _min)
                    {
                        _secondMin = _min;
                        _min = _childSize;
                        
                        array_resize(_modifyingArray, 0);
                        array_push(_modifyingArray, _child);
                    }
                    else if (_childSize == _min)
                    {
                        array_push(_modifyingArray, _child);
                    }
                    else //if (_childSize > _min)
                    {
                        _secondMin = min(_secondMin, _childSize);
                    }
                    
                    ++_i;
                }
                
                var _workCount = array_length(_modifyingArray);
                if (_workCount <= 0) break;
                
                var _addition = min(_remaining / _workCount, (_secondMin ?? 0) - _min);
                
                var _i = 0;
                repeat(_workCount)
                {
                    var _child = _modifyingArray[_i];
                    
                    var _prevSize = _child.__gui.__solvedWidth;
                    if (_prevSize == _min)
                    {
                        if (_prevSize + _addition >= _child.__layoutWidthMax)
                        {
                            var _newSize = _child.__layoutWidthMax;
                            array_delete(_modifiableArray, array_get_index(_modifiableArray, _child), 1);
                        }
                        else
                        {
                            var _newSize = _prevSize + _addition;
                        }
                        
                        _child.__gui.__solvedWidth = _newSize;
                        _remaining += _prevSize - _newSize;
                    }
                    
                    ++_i;
                }
                
                array_resize(_modifyingArray, 0);
            }
            
            array_resize(_modifiableArray, 0);
        }
        else if (_remaining < 0)
        {
            //////
            // Shrink children
            //////
            
            var _i = 0;
            repeat(_childCount)
            {
                var _child = _childArray[_i];
                if (_child.__gui.__layoutWidthResize != GUI_RESIZE_STATIC)
                {
                    array_push(_modifiableArray, _child);
                }
                    
                ++_i;
            }
            
            while ((_remaining < 0) && (array_length(_modifiableArray) > 0))
            {
                var _max       = 0;
                var _secondMax = undefined;
                
                var _i = 0;
                repeat(array_length(_modifiableArray))
                {
                    var _child = _modifiableArray[_i];
                    
                    var _childSize = _child.__gui.__solvedWidth;
                    if (_childSize > _max)
                    {
                        _secondMax = _max;
                        _max = _childSize;
                            
                        array_resize(_modifyingArray, 0);
                        array_push(_modifyingArray, _child);
                    }
                    else if (_childSize == _max)
                    {
                        array_push(_modifyingArray, _child);
                    }
                    else //if (_childSize < _max)
                    {
                        _secondMax = max(_secondMax, _childSize);
                    }
                    
                    ++_i;
                }
                
                var _workCount = array_length(_modifyingArray);
                if (_workCount <= 0) break;
                    
                var _addition = max(_remaining / _workCount, (_secondMax ?? 0) - _max);
                
                var _i = 0;
                repeat(_workCount)
                {
                    var _child = _modifyingArray[_i];
                    
                    var _prevSize = _child.__gui.__solvedWidth;
                    if (_prevSize == _max)
                    {
                        if (_prevSize + _addition <= _child.__layoutWidthMin)
                        {
                            var _newSize = _child.__layoutWidthMin;
                            array_delete(_modifiableArray, array_get_index(_modifiableArray, _child), 1);
                        }
                        else
                        {
                            var _newSize = _prevSize + _addition;
                        }
                        
                        _child.__gui.__solvedWidth = _newSize;
                        _remaining += _prevSize - _newSize;
                    }
                    
                    ++_i;
                }
                
                array_resize(_modifyingArray, 0);
            }
            
            array_resize(_modifiableArray, 0);
        }
    }
}