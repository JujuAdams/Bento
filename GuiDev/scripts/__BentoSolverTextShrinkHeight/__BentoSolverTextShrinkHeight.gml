// Feather disable all

function __BentoSolverTextGetShrinkHeight()
{
    var _height = clamp(__funcMeasureHeight(__solvedWidth), __layoutHeightMin, __layoutHeightMax);
    __solverMinHeight    = (__layoutWidthMin > 0)? __layoutWidthMin : _height;
    __solvedHeight       = _height;
    __solverShrinkHeight = _height;
}