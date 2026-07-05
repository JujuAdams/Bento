// Feather disable all

function __BentoSolverTextGetDeflateWidth()
{
    var _layoutWidthMin = __BentoParsePercentageString(__layoutWidthMin, display_get_gui_width());
    var _layoutWidthMax = __BentoParsePercentageString(__layoutWidthMax, display_get_gui_width());
    
    //Fall back on the minimum width if we can't find a suitable preferred width
    __solvedWidth = clamp(__BentoSolvertGetSafeWidth(), _layoutWidthMin, _layoutWidthMax);
    __solverDeflateWidth = __solvedWidth;
    __solverMinWidth    = (_layoutWidthMin > 0)? _layoutWidthMin : __solvedWidth;
}