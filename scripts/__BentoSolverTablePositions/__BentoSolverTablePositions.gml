// Feather disable all

function __BentoSolverTablePositions(_left, _top, _allocatedWidth, _allocatedHeight, _rightToLeftRootWidth)
{
    __BentoScrollLimitsMarkSelfDirty();
    
    __solvedLeft = _left + __layoutAnchorX*(_allocatedWidth  - __solvedWidth ) + __layoutMarginLeft;
    __solvedTop  = _top  + __layoutAnchorY*(_allocatedHeight - __solvedHeight) + __layoutMarginTop;
    __solvedWidth  -= __layoutMarginWidth;
    __solvedHeight -= __layoutMarginHeight;
    
    if (BENTO_FLOOR_LAYOUT_POSITIONS)
    {
        __solvedLeft   = floor(__solvedLeft);
        __solvedTop    = floor(__solvedTop);
        __solvedWidth  = floor(__solvedWidth);
        __solvedHeight = floor(__solvedHeight);
    }
    
    var _childArray   = __layoutChildArray;
    var _childCount   = array_length(_childArray);
    var _tableColumns = __tableColumns;
    var _tableRows    = ceil(_childCount / _tableColumns);
    
    var _xPos    = __solvedLeft + __solverPadLeft;
    var _yPos    = __solvedTop  + __solverPadTop;
    var _xGutter = __layoutGutterX;
    var _yGutter = __layoutGutterY;
    
    var _x = _xPos;
    var _y = _yPos;
    
    var _row = 0;
    var _rowHeight = __layoutTableSolvedHeight[0];
    var _column = 0;
    
    var _i = 0;
    repeat(_childCount)
    {
        var _columnWidth = __layoutTableSolvedWidth[_column];
        
        with(_childArray[_i])
        {
            __SolverFinalPositions(_x, _y, _columnWidth, _rowHeight, _rightToLeftRootWidth);
        }
        
        ++_i;
        
        ++_column;
        if (_column >= _tableColumns)
        {
            ++_row;
            if (_row >= _tableRows) break;
            
            _x = _xPos;
            _y += _rowHeight + _yGutter;
            
            _rowHeight = __layoutTableSolvedHeight[_row];
            _column = 0;
        }
        else
        {
            _x += _columnWidth + _xGutter;
        }
    }
    
    //Reset the temporary layout array
    array_resize(__layoutChildArray, 0);
    
    //Flip the x-axis position if we're using a right-to-left layout
    if (_rightToLeftRootWidth != undefined)
    {
        __solvedLeft = _rightToLeftRootWidth - (__solvedLeft + __solvedWidth);
    }
}