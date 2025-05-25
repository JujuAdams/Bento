// Feather disable all

function __GuiSolverTextShrinkHeight()
{
    draw_set_font(__attachedElement.font);
    
    if (__layoutHeightResize == GUI_RESIZE_SHRINK)
    {
        //Change the height of this instance based on the new wrapping rules.
        //
        //P.S. Not sure how well GameMaker handles `infinity` for some internal functions
        var _height = clamp(string_height_ext(__attachedElement.text, -1, __solvedWidth), __layoutHeightMin, __layoutHeightMax);
        __solverMinHeight = _height;
        __solvedHeight    = _height;
    }
    else
    {
        __solverMinHeight = (__layoutHeightMin > 0)? __layoutHeightMin : string_height(__attachedElement.text);
        __solvedHeight    = clamp(__solverMinHeight, __layoutHeightMin, __layoutHeightMax);
    }
    
    __solverShrinkHeight = __solvedHeight;
    
    draw_set_font(-1);
}