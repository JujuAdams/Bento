// Feather disable all

function __BentoSolverListResizeHeight()
{
    __BentoSolverMaintainAspectRatio();
    
    var _childArray = __layoutChildArray;
    var _childCount = array_length(_childArray);
    
    var _remaining = __solvedHeight - __solverChildrenDeflateHeight;
    
    if (__listAxis == BENTO_AXIS_X)
    {
        //////
        // Minor Axis - Stretch inflate elements to the maximum available space
        //////
            
        var _available = __solvedHeight - (__solverPadLeft + __solverPadRight);
        if (_available > 0)
        {
            var _i = 0;
            repeat(_childCount)
            {
                with( _childArray[_i])
                {
                    if (__layoutHeightResize == BENTO_RESIZE_INFLATE)
                    {
                        __solvedHeight = clamp(_available, __layoutHeightMin, __layoutHeightMax);
                    }
                    else
                    {
                        __solvedHeight = clamp(min(__solvedHeight, _available), __layoutHeightMin, __layoutHeightMax);
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
            // Inflate children
            //////
                
            var _i = 0;
            repeat(_childCount)
            {
                var _child = _childArray[_i];
                if (_child.__layoutHeightResize == BENTO_RESIZE_INFLATE)
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
                    
                    var _childSize = _child.__solvedHeight;
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
                    
                    var _prevSize = _child.__solvedHeight;
                    if (_prevSize == _min)
                    {
                        if (_prevSize + _addition >= _child.__layoutHeightMax)
                        {
                            var _newSize = _child.__layoutHeightMax;
                            array_delete(_modifiableArray, array_get_index(_modifiableArray, _child), 1);
                        }
                        else
                        {
                            var _newSize = _prevSize + _addition;
                        }
                        
                        _child.__solvedHeight = _newSize;
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
            // Squash children
            //////
            
            array_copy(_modifiableArray, 0, _childArray, 0, array_length(_childArray));
            
            while ((_remaining < 0) && (array_length(_modifiableArray) > 0))
            {
                var _max       = 0;
                var _secondMax = undefined;
                
                var _i = 0;
                repeat(array_length(_modifiableArray))
                {
                    var _child = _modifiableArray[_i];
                    
                    var _childSize = _child.__solvedHeight;
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
                    
                    var _prevSize = _child.__solvedHeight;
                    if (_prevSize == _max)
                    {
                        if (_prevSize + _addition <= _child.__solverMinHeight)
                        {
                            var _newSize = _child.__solverMinHeight;
                            array_delete(_modifiableArray, array_get_index(_modifiableArray, _child), 1);
                        }
                        else
                        {
                            var _newSize = _prevSize + _addition;
                        }
                        
                        _child.__solvedHeight = _newSize;
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