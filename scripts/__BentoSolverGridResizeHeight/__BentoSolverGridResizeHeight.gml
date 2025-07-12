// Feather disable all

function __BentoSolverGridResizeHeight()
{
    var _childArray = __layoutChildArray;
    var _childCount = array_length(_childArray);
    
    var _available = __solvedHeight - (__solverPadTop + __solverPadBottom + max(0, __gridRows-1)*__layoutGutterY);
    var _cellSize = floor(_available / max(1, __gridRows));
    
    if (_available > 0)
    {
        var _i = 0;
        repeat(_childCount)
        {
            with( _childArray[_i])
            {
                if (__layoutHeightResize == BENTO_RESIZE_INFLATE)
                {
                    __solvedHeight = clamp(_cellSize, __layoutHeightMin, __layoutHeightMax);
                }
                else
                {
                    __solvedHeight = clamp(min(__solvedHeight, _cellSize), __layoutHeightMin, __layoutHeightMax);
                }
            }
            
            ++_i;
        }
    }
}