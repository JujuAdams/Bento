// Feather disable all

function __BentoSolverTextGetDeflateWidth()
{
    //Fall back on the minimum width if we can't find a suitable preferred width
    __solvedWidth = clamp((__layoutWidthPref > 0)? __layoutWidthPref : __layoutWidthMin, __layoutWidthMin, __layoutWidthMax);
    __solverDeflateWidth = __solvedWidth;
    __solverMinWidth    = (__layoutWidthMin > 0)? __layoutWidthMin : __solvedWidth;
}