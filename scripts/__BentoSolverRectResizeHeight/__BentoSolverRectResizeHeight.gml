// Feather disable all

function __BentoSolverRectResizeHeight()
{
    var _childArray = __layoutChildArray;
    var _available = __solvedHeight - (__solverPadTop + __solverPadBottom);
    
    var _i = 0;
    repeat(array_length(_childArray))
    {
        with(_childArray[_i])
        {
            if (__layoutHeightResize == BENTO_RESIZE_INFLATE)
            {
                __solvedHeight = clamp(_available, __layoutHeightMin, __layoutHeightMax);
            }
        }
        
        ++_i;
    }
}