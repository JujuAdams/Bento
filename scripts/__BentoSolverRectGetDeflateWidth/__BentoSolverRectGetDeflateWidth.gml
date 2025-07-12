// Feather disable all

function __BentoSolverRectGetDeflateWidth()
{
    __solvedWidth        = clamp(__BentoSolvertGetSafeWidth(), __layoutWidthMin, __layoutWidthMax);
    __solverDeflateWidth = __solvedWidth;
    __solverMinWidth     = (__layoutWidthMin > 0)? __layoutWidthMin : __solvedWidth;
}