// Feather disable all

function __BentoSolverRectResizeHeight()
{
    var _layoutHeightMin = __BentoParsePercentageString(__layoutHeightMin, display_get_gui_height());
    var _layoutHeightMax = __BentoParsePercentageString(__layoutHeightMax, display_get_gui_height());
    
    __BentoSolverMaintainAspectRatio();
    
    var _childArray = __layoutChildArray;
    var _available = __solvedHeight - (__solverPadTop + __solverPadBottom);
    
    var _i = 0;
    repeat(array_length(_childArray))
    {
        with(_childArray[_i])
        {
            if (__layoutHeightResize == BENTO_RESIZE_INFLATE)
            {
                __solvedHeight = clamp(_available, _layoutHeightMin, _layoutHeightMax);
            }
            else
            {
                __solvedHeight = clamp(min(__solvedHeight, _available), _layoutHeightMin, _layoutHeightMax);
            }
        }
        
        ++_i;
    }
}