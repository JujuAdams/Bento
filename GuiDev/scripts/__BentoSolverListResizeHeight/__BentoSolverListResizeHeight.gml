// Feather disable all

function __BentoSolverListResizeHeight()
{
    var _childArray = __childArray;
    var _childCount = array_length(_childArray);
    
    var _remaining = __solvedHeight - __solverGetShrinkHeight;
    
    if (__listAxis == GUI_AXIS_X)
    {
        //////
        // Minor Axis - Stretch expand elements to the maximum available space
        //////
            
        var _available = __solvedHeight - (__solverPadLeft + __solverPadRight);
        if (_available > 0)
        {
            var _i = 0;
            repeat(_childCount)
            {
                with( _childArray[_i].GUI_VARS)
                {
                    if (__layoutHeightResize == GUI_RESIZE_SHRINK)
                    {
                        __solvedHeight = clamp(min(__solvedHeight, _available), __layoutHeightMin, __layoutHeightMax);
                    }
                    else if (__layoutHeightResize == GUI_RESIZE_EXPAND)
                    {
                        __solvedHeight = clamp(_available, __layoutHeightMin, __layoutHeightMax);
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
            // expand children
            //////
                
            var _i = 0;
            repeat(_childCount)
            {
                var _child = _childArray[_i];
                if (_child.GUI_VARS.__layoutHeightResize == GUI_RESIZE_EXPAND)
                {
                    array_push(_modifiableArray, _child);
                }
                    
                ++_i;
            }
            
            while (_remaining > 0)
            {
                var _min       = infinity;
                var _secondMin = undefined;
                
                var _i = 0;
                repeat(array_length(_modifiableArray))
                {
                    var _child = _modifiableArray[_i];
                    
                    var _childSize = _child.GUI_VARS.__solvedHeight;
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
                    
                    var _prevSize = _child.GUI_VARS.__solvedHeight;
                    if (_prevSize == _min)
                    {
                        if (_prevSize + _addition >= _child.GUI_VARS.__layoutHeightMax)
                        {
                            var _newSize = _child.GUI_VARS.__layoutHeightMax;
                            array_delete(_modifiableArray, array_get_index(_modifiableArray, _child), 1);
                        }
                        else
                        {
                            var _newSize = _prevSize + _addition;
                        }
                        
                        _child.GUI_VARS.__solvedHeight = _newSize;
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
                if (_child.GUI_VARS.__layoutHeightResize != GUI_RESIZE_STATIC)
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
                    
                    var _childSize = _child.GUI_VARS.__solvedHeight;
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
                    
                    var _prevSize = _child.GUI_VARS.__solvedHeight;
                    if (_prevSize == _max)
                    {
                        if (_prevSize + _addition <= _child.GUI_VARS.__layoutHeightMin)
                        {
                            var _newSize = _child.GUI_VARS.__layoutHeightMin;
                            array_delete(_modifiableArray, array_get_index(_modifiableArray, _child), 1);
                        }
                        else
                        {
                            var _newSize = _prevSize + _addition;
                        }
                        
                        _child.GUI_VARS.__solvedHeight = _newSize;
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