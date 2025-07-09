// Feather disable all

function __BentoSolverRectGetDeflateHeight()
{
    __solvedHeight        = clamp(__BentoSolvertGetSafeHeight(), __layoutHeightMin, __layoutHeightMax);
    __solverDeflateHeight = __solvedHeight;
    __solverMinHeight     = (__layoutHeightMin > 0)? __layoutHeightMin : __solvedHeight;
}