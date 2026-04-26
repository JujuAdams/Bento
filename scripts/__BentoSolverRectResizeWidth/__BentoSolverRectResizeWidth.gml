// Feather disable all

function __BentoSolverRectResizeWidth()
{
    var _childArray = __layoutChildArray;
    var _available = __solvedWidth - (__solverPadLeft + __solverPadRight);
    
    var _i = 0;
    repeat(array_length(_childArray))
    {
        with(_childArray[_i])
        {
            if (__layoutWidthResize == BENTO_RESIZE_INFLATE)
            {
                __solvedWidth = clamp(_available, __layoutWidthMin, __layoutWidthMax);
            }
            else
            {
                __solvedWidth = clamp(min(__solvedWidth, _available), __layoutWidthMin, __layoutWidthMax);
            }
        }
        
        ++_i;
    }
}