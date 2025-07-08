// Feather disable all

function __BentoSolverTextGetShrinkHeight()
{
    var _height = clamp(__funcMeasureHeight(__solvedWidth), __layoutHeightMin, __layoutHeightMax);
    __solverMinHeight       = _height;
    __solvedHeight          = _height;
    __solverGetShrinkHeight = _height;
}