// Feather disable all

function __BentoSolverGridResizeWidth()
{
    var _contentSize  = __solvedWidth - (__solverPadLeft + __solverPadRight);
    var _contentCount = floor((_contentSize + __layoutGutterX) / (__solverCellMinWidth + __layoutGutterX));
    _contentCount = clamp(_contentCount, __gridMinColumns, __gridMaxColumns);
    
    var _cellSize = floor((_contentSize - __layoutGutterX*_contentCount) / _contentCount);
    
    var _childArray = __layoutChildArray;
    var _childCount = array_length(_childArray);
    
    var _i = 0;
    repeat(_childCount)
    {
        with( _childArray[_i])
        {
            if (__layoutWidthResize == BENTO_RESIZE_INFLATE)
            {
                __solvedWidth = clamp(_cellSize, __solverMinWidth, __layoutWidthMax);
            }
            else
            {
                __solvedWidth = clamp(min(__solvedWidth, _cellSize), __solverMinWidth, __layoutWidthMax);
            }
        }
        
        ++_i;
    }
}