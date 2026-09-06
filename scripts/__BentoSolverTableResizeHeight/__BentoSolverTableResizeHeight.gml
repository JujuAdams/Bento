// Feather disable all

function __BentoSolverTableResizeHeight(_rootWidth, _rootHeight)
{
    var _layoutHeightMin = __BentoParsePercentageString(__layoutHeightMin, _rootWidth);
    var _layoutHeightMax = __BentoParsePercentageString(__layoutHeightMax, _rootHeight);
    
    var _childArray   = __layoutChildArray;
    var _childCount   = array_length(_childArray);
    var _tableColumns = __tableColumns;
    var _tableRows    = ceil(_childCount / _tableColumns);
    var _rowMaxHeight = __tableMaxHeight;
    
    ///////
    // Distribute space between rows
    ///////
    
    static _modifiableArray = [];
    static _modifyingArray  = [];
    
    var _row = 0;
    repeat(_tableRows)
    {
        array_push(_modifiableArray, _row);
        ++_row;
    }
        
    var _remaining = __solvedHeight - (__solverChildrenDeflateHeight + __layoutMarginHeight);
    if (_remaining > 0)
    {
        if (__layoutHeightResize == BENTO_RESIZE_INFLATE)
        {
            //////
            // Expand rows
            //////
            
            while ((_remaining > 0) && (array_length(_modifiableArray) > 0))
            {
                var _min       = infinity;
                var _secondMin = undefined;
                
                var _i = 0;
                repeat(array_length(_modifiableArray))
                {
                    var _row = _modifiableArray[_i];
                    
                    var _childSize = __layoutTableSolvedHeight[_row];
                    if (_childSize < _min)
                    {
                        _secondMin = _min;
                        _min = _childSize;
                    
                        array_resize(_modifyingArray, 0);
                        array_push(_modifyingArray, _row);
                    }
                    else if (_childSize == _min)
                    {
                        array_push(_modifyingArray, _row);
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
                    var _row = _modifyingArray[_i];
                    
                    var _prevSize = __layoutTableSolvedHeight[_row];
                    if (_prevSize == _min)
                    {
                        if (_prevSize + _addition >= _rowMaxHeight)
                        {
                            var _newSize = _rowMaxHeight;
                            array_delete(_modifiableArray, array_get_index(_modifiableArray, _row), 1);
                        }
                        else
                        {
                            var _newSize = _prevSize + _addition;
                        }
                        
                        __layoutTableSolvedHeight[@ _row] = _newSize;
                        _remaining += _prevSize - _newSize;
                    }
                    
                    ++_i;
                }
            }
        }
    }
    else if (_remaining < 0)
    {
        //////
        // Squash rows
        //////
        
        while((_remaining < 0) && (array_length(_modifiableArray) > 0))
        {
            var _max       = 0;
            var _secondMax = undefined;
            
            var _i = 0;
            repeat(array_length(_modifiableArray))
            {
                var _row = _modifiableArray[_i];
                
                var _childSize = __layoutTableSolvedHeight[_row];
                if (_childSize > _max)
                {
                    _secondMax = _max;
                    _max = _childSize;
                            
                    array_resize(_modifyingArray, 0);
                    array_push(_modifyingArray, _row);
                }
                else if (_childSize == _max)
                {
                    array_push(_modifyingArray, _row);
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
                
                var _prevSize = __layoutTableSolvedHeight[_row];
                if (_prevSize == _max)
                {
                    if (_prevSize + _addition <= __layoutTableMinHeight[_row])
                    {
                        var _newSize = __layoutTableMinHeight[_row];
                        array_delete(_modifiableArray, array_get_index(_modifiableArray, _child), 1);
                    }
                    else
                    {
                        var _newSize = _prevSize + _addition;
                    }
                    
                    __layoutTableSolvedHeight[@ _row] = _newSize;
                    _remaining += _prevSize - _newSize;
                }
                
                ++_i;
            }
            
            array_resize(_modifyingArray, 0);
        }
        
        array_resize(_modifiableArray, 0);
    }
    
    ///////
    // Stretch inflate elements to the maximum available space
    ///////
    
    var _i = 0;
    repeat(_childCount)
    {
        var _row = _i div _tableColumns;
        
        var _available = __layoutTableSolvedHeight[@ _row];
        if (_available > 0)
        {
            with( _childArray[_i])
            {
                if (__layoutHeightResize == BENTO_RESIZE_INFLATE)
                {
                    __solvedHeight = clamp(_available, _layoutHeightMin, _layoutHeightMax);
                }
                else
                {
                    __solvedHeight = clamp(min(__solvedHeight, _available), _layoutHeightMin, _layoutHeightMax);
                }
            }
        }
        
        ++_i;
    }
}