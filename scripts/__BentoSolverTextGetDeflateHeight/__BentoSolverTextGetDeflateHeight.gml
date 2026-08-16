// Feather disable all

function __BentoSolverTextGetDeflateHeight(_rootHeight)
{
    var _layoutHeightMin = __BentoParsePercentageString(__layoutHeightMin, _rootHeight);
    var _layoutHeightMax = __BentoParsePercentageString(__layoutHeightMax, _rootHeight);
    
    var _height = clamp(__funcMeasureHeight(__solvedWidth, _layoutHeightMax), _layoutHeightMin, _layoutHeightMax) + __layoutMarginHeight;
    __solverMinHeight     = (_layoutHeightMin > 0)? (_layoutHeightMin + __layoutMarginHeight) : _height;
    __solvedHeight        = _height;
    __solverDeflateHeight = _height;
}