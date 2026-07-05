// Feather disable all

function __BentoSolverTextGetDeflateHeight()
{
    var _layoutHeightMin = __BentoParsePercentageString(__layoutHeightMin, display_get_gui_height());
    var _layoutHeightMax = __BentoParsePercentageString(__layoutHeightMax, display_get_gui_height());
    
    var _height = clamp(__funcMeasureHeight(__solvedWidth, _layoutHeightMax), _layoutHeightMin, _layoutHeightMax);
    __solverMinHeight     = (_layoutHeightMin > 0)? _layoutHeightMin : _height;
    __solvedHeight        = _height;
    __solverDeflateHeight = _height;
}