// Feather disable all

function __BentoSolverRectResizeWidth(_rootWidth)
{
    var _childArray = __layoutChildArray;
    var _available = __solvedWidth - (__solverPadLeft + __solverPadRight + __layoutMarginWidth);
    
    var _i = 0;
    repeat(array_length(_childArray))
    {
        with(_childArray[_i])
        {
            if (__layoutWidthResize == BENTO_RESIZE_INFLATE)
            {
                __solvedWidth = clamp(_available,
                                      __BentoParsePercentageString(__layoutWidthMin, _rootWidth),
                                      __BentoParsePercentageString(__layoutWidthMax, _rootWidth));
            }
            else
            {
                __solvedWidth = max(min(__solvedWidth, _available), __BentoParsePercentageString(__layoutWidthMin, _rootWidth));
            }
        }
        
        ++_i;
    }
}