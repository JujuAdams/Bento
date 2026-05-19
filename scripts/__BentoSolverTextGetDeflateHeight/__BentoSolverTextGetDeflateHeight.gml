// Feather disable all

function __BentoSolverTextGetDeflateHeight()
{
    var _height = clamp(__funcMeasureHeight(__solvedWidth, __layoutHeightMax), __layoutHeightMin, __layoutHeightMax);
    __solverMinHeight     = (__layoutHeightMin > 0)? __layoutHeightMin : _height;
    __solvedHeight        = _height;
    __solverDeflateHeight = _height;
}