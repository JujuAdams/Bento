// Feather disable all

function __BentoSolverTextGetDeflateWidth(_rootWidth)
{
    var _layoutWidthMin = __BentoParsePercentageString(__layoutWidthMin, _rootWidth);
    var _layoutWidthMax = __BentoParsePercentageString(__layoutWidthMax, _rootWidth);
    
    //Fall back on the minimum width if we can't find a suitable preferred width
    __solvedWidth        = clamp(__BentoSolvertGetSafeWidth(_rootWidth), _layoutWidthMin, _layoutWidthMax) + __layoutMarginWidth;
    __solverDeflateWidth = __solvedWidth;
    __solverMinWidth     = (_layoutWidthMin > 0)? (_layoutWidthMin + __layoutMarginWidth) : __solvedWidth;
}