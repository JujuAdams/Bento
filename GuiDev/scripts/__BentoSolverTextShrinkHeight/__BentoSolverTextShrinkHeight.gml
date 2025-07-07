// Feather disable all

function __BentoSolverTextGetShrinkHeight()
{
    draw_set_font(__attachedElement.font);
    
    if (__layoutHeightResize == BENTO_RESIZE_SHRINK)
    {
        //Change the height of this element based on the new wrapping rules.
        //
        //P.S. Not sure how well GameMaker handles `infinity` for some internal functions
        var _height = clamp(__funcMeasureHeight(__solvedWidth), __layoutHeightMin, __layoutHeightMax);
        __solverMinHeight = _height;
        __solvedHeight    = _height;
    }
    else
    {
        __solverMinHeight = (__layoutHeightMin > 0)? __layoutHeightMin : __funcMeasureHeight(999999);
        __solvedHeight    = clamp(__solverMinHeight, __layoutHeightMin, __layoutHeightMax);
    }
    
    __solverGetShrinkHeight = __solvedHeight;
    
    draw_set_font(-1);
}