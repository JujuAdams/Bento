// Feather disable all

function __BentoSolverTableResizeWidth(_rootWidth)
{
    var _layoutWidthMin = __BentoParsePercentageString(__layoutWidthMin, _rootWidth);
    var _layoutWidthMax = __BentoParsePercentageString(__layoutWidthMax, _rootWidth);
    
    var _childArray   = __layoutChildArray;
    var _tableColumns = __tableColumns;
    var _childCount   = array_length(_childArray);
    
    ///////
    // Distribute space between columns
    ///////
    
    static _modifiableArray = [];
    static _modifyingArray  = [];
        
    var _remaining = __solvedWidth - (__solverChildrenDeflateWidth + __layoutMarginWidth);
    if (_remaining > 0)
    {
        if (__layoutWidthResize == BENTO_RESIZE_INFLATE)
        {
            //////
            // Expand columns
            //////
            
            while(_remaining > 0)
            {
                var _min       = infinity;
                var _secondMin = undefined;
                
                var _column = 0;
                repeat(_tableColumns)
                {
                    var _childSize = __layoutTableSolvedWidth[_column];
                    if (_childSize < _min)
                    {
                        _secondMin = _min;
                        _min = _childSize;
                    
                        array_resize(_modifyingArray, 0);
                        array_push(_modifyingArray, _column);
                    }
                    else if (_childSize == _min)
                    {
                        array_push(_modifyingArray, _column);
                    }
                    else //if (_childSize > _min)
                    {
                        _secondMin = min(_secondMin, _childSize);
                    }
                
                    ++_column;
                }
                
                var _workCount = array_length(_modifyingArray);
                if (_workCount <= 0) break;
                
                var _addition = min(_remaining / _workCount, (_secondMin ?? 0) - _min);
                
                var _i = 0;
                repeat(_workCount)
                {
                    var _column = _modifyingArray[_i];
                    
                    var _prevSize = __layoutTableSolvedWidth[_column];
                    if (_prevSize == _min)
                    {
                        __layoutTableSolvedWidth[@ _column] += _addition;
                        _remaining -= _addition;
                    }
                    
                    ++_i;
                }
            }
        }
    }
    else if (_remaining < 0)
    {
        //////
        // Squash columns
        //////
        
        var _column = 0;
        repeat(_tableColumns)
        {
            array_push(_modifiableArray, _column);
            ++_column;
        }
        
        while((_remaining < 0) && (array_length(_modifiableArray) > 0))
        {
            var _max       = 0;
            var _secondMax = undefined;
            
            var _i = 0;
            repeat(array_length(_modifiableArray))
            {
                var _column = _modifiableArray[_i];
                
                var _childSize = __layoutTableSolvedWidth[_column];
                if (_childSize > _max)
                {
                    _secondMax = _max;
                    _max = _childSize;
                            
                    array_resize(_modifyingArray, 0);
                    array_push(_modifyingArray, _column);
                }
                else if (_childSize == _max)
                {
                    array_push(_modifyingArray, _column);
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
                
                var _prevSize = __layoutTableSolvedWidth[_column];
                if (_prevSize == _max)
                {
                    if (_prevSize + _addition <= __layoutTableMinWidth[_column])
                    {
                        var _newSize = __layoutTableMinWidth[_column];
                        array_delete(_modifiableArray, array_get_index(_modifiableArray, _child), 1);
                    }
                    else
                    {
                        var _newSize = _prevSize + _addition;
                    }
                    
                    __layoutTableSolvedWidth[@ _column] = _newSize;
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
        var _column = _i mod _tableColumns;
        
        var _available = __layoutTableSolvedWidth[@ _column];
        if (_available > 0)
        {
            with( _childArray[_i])
            {
                if (__layoutWidthResize == BENTO_RESIZE_INFLATE)
                {
                    __solvedWidth = clamp(_available, _layoutWidthMin, _layoutWidthMax);
                }
                else
                {
                    __solvedWidth = clamp(min(__solvedWidth, _available), _layoutWidthMin, _layoutWidthMax);
                }
            }
        }
        
        ++_i;
    }
}