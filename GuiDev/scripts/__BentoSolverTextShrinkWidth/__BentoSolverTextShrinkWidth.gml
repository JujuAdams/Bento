// Feather disable all

function __BentoSolverTextGetShrinkWidth()
{
    draw_set_font(__attachedElement.font);
    
    //Determine the preferred width for the text. If the preferred width isn't set then we use the
    //full width of the text string itself.
    var _widthPref = clamp((__layoutWidthPref > 0)? __layoutWidthPref : string_width(__attachedElement.text), __layoutWidthMin, __layoutWidthMax);
    __solvedWidth = _widthPref;
            
    if (__layoutWidthResize == GUI_RESIZE_STATIC)
    {
        //For static (non-resizing) text, we treat the width of the text as a hard limit.
        __solverMinWidth = (__layoutWidthMin > 0)? __layoutWidthMin : _widthPref;
    }
    else
    {
        //Use a conveniently small string to act as a baseline minimum width if no minimum width has been specified.
        __solverMinWidth = (__layoutWidthMin > 0)? __layoutWidthMin : string_width("Adams");
    }
    
    //Whatever the weather, the width for the purpose of shrinking the parent is whatever layout
    //width guess we've made.
    __solverGetShrinkWidth = __solvedWidth;
    
    draw_set_font(-1);
}