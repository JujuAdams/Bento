// Feather disable all

function __BentoSolverGridPositions(_left, _top, _allocatedWidth, _allocatedHeight)
{
    __BentoScrollLimitsMarkSelfDirty();
    
    __solvedLeft = _left + __layoutAnchorX*(_allocatedWidth  - __solvedWidth );
    __solvedTop  = _top  + __layoutAnchorY*(_allocatedHeight - __solvedHeight);
    
    if (BENTO_FLOOR_LAYOUT_POSITIONS)
    {
        __solvedLeft   = floor(__solvedLeft);
        __solvedTop    = floor(__solvedTop);
        __solvedWidth  = floor(__solvedWidth);
        __solvedHeight = floor(__solvedHeight);
    }
    
    var _contentWidth  = __solvedWidth  - (__solverPadLeft + __solverPadRight);
    var _contentHeight = __solvedHeight - (__solverPadTop + __solverPadBottom);
    
    var _columns = floor((_contentWidth  + __layoutGutterX) / (__solverCellMinWidth  + __layoutGutterX));
    var _rows    = floor((_contentHeight + __layoutGutterY) / (__solverCellMinHeight + __layoutGutterY));
    
    _columns = clamp(_columns, __gridMinColumns, __gridMaxColumns);
    _rows    = clamp(_rows,    __gridMinRows,    __gridMaxRows);
    
    var _cellWidth  = floor((_contentWidth  - __layoutGutterX*_columns) / _columns);
    var _cellHeight = floor((_contentHeight - __layoutGutterY*_rows   ) / _rows   );
    
    var _childArray = __layoutChildArray;
    var _childCount = array_length(_childArray);
    
    var _gridX = 0;
    
    var _childLeft = __solvedLeft + __solverPadLeft;
    var _childTop  = __solvedTop  + __solverPadTop;
    var _startLeft = _childLeft;
    var _i = 0;
    repeat(_childCount)
    {
        _childArray[_i].__SolverFinalPositions(_childLeft, _childTop, _cellWidth, _cellHeight);
        
        _childLeft += _cellWidth + __layoutGutterX;
        ++_gridX;
        
        if (_gridX >= _columns)
        {
            _childLeft  = _startLeft;
            _childTop  += _cellHeight + __layoutGutterY;
            
            _gridX = 0;
        }
        
        ++_i;
    }
    
    //Reset the temporary layout array
    array_resize(__layoutChildArray, 0);
}