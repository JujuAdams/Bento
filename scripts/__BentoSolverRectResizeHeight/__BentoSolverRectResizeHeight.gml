// Feather disable all

function __BentoSolverRectResizeHeight(_rootWidth, _rootHeight)
{
    __BentoSolverMaintainAspectRatio(_rootWidth, _rootHeight);
    
    var _childArray = __layoutChildArray;
    var _available = __solvedHeight - (__solverPadHeight + __layoutMarginHeight);
    
    var _i = 0;
    repeat(array_length(_childArray))
    {
        with(_childArray[_i])
        {
            if (__layoutHeightResize == BENTO_RESIZE_INFLATE)
            {
                __solvedHeight = clamp(_available,
                                       __BentoParsePercentageString(__layoutHeightMin, _rootHeight),
                                       __BentoParsePercentageString(__layoutHeightMax, _rootHeight));
            }
            else
            {
                __solvedHeight = max(min(__solvedHeight, _available), __BentoParsePercentageString(__layoutHeightMin, _rootHeight));
            }
        }
        
        ++_i;
    }
}