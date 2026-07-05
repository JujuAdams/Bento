// Feather disable all

function __BentoSolverRectResizeWidth()
{
    var _layoutWidthMin = __BentoParsePercentageString(__layoutWidthMin, display_get_gui_width());
    var _layoutWidthMax = __BentoParsePercentageString(__layoutWidthMax, display_get_gui_width());
    
    var _childArray = __layoutChildArray;
    var _available = __solvedWidth - (__solverPadLeft + __solverPadRight);
    
    var _i = 0;
    repeat(array_length(_childArray))
    {
        with(_childArray[_i])
        {
            if (__layoutWidthResize == BENTO_RESIZE_INFLATE)
            {
                __solvedWidth = clamp(_available, _layoutWidthMin, _layoutWidthMax);
            }
            else
            {
                __solvedWidth = clamp(min(__solvedWidth, _available), _layoutWidthMin, _layoutWidthMax);
            }
        }
        
        ++_i;
    }
}