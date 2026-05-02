// Feather disable all

function __BentoSolverGridResizeHeight()
{
    __BentoSolverMaintainAspectRatio();
    
    var _contentSize  = __solvedHeight - (__solverPadTop + __solverPadBottom);
    var _contentCount = floor((_contentSize + __layoutGutterY) / (__solverCellMinHeight + __layoutGutterY));
    _contentCount = clamp(_contentCount, __gridMinRows, __gridMaxRows);
    
    var _cellSize = floor((_contentSize - __layoutGutterY*_contentCount) / _contentCount);
    
    var _childArray = __layoutChildArray;
    var _childCount = array_length(_childArray);
    
    var _i = 0;
    repeat(_childCount)
    {
        with( _childArray[_i])
        {
            if (__layoutHeightResize == BENTO_RESIZE_INFLATE)
            {
                __solvedHeight = clamp(_cellSize, __solverMinHeight, __layoutHeightMax);
            }
            else
            {
                __solvedHeight = clamp(min(__solvedHeight, _cellSize), __solverMinHeight, __layoutHeightMax);
            }
        }
        
        ++_i;
    }
}