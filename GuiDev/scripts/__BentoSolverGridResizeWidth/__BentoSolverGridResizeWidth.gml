// Feather disable all

function __BentoSolverGridResizeWidth()
{
    var _childArray   = __childArray;
    var _childCount = array_length(_childArray);
    
    var _available = __solvedWidth - (__solverPadLeft + __solverPadRight + max(0, __gridColumns-1)*__layoutGutterX);
    var _cellSize = floor(_available / max(1, __gridColumns));
    
    if (_available > 0)
    {
        var _i = 0;
        repeat(_childCount)
        {
            with( _childArray[_i].BENTO_VARS)
            {
                if (__layoutWidthResize == BENTO_RESIZE_DEFLATE)
                {
                    __solvedWidth = clamp(min(__solvedWidth, _cellSize), __layoutWidthMin, __layoutWidthMax);
                }
                else if (__layoutWidthResize == BENTO_RESIZE_INFLATE)
                {
                    __solvedWidth = clamp(_cellSize, __layoutWidthMin, __layoutWidthMax);
                }
            }
            
            ++_i;
        }
    }
}