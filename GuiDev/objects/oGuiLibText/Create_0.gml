// Feather disable all

event_inherited();

GuiSetIfNotDefined("text", "");
GuiSetIfNotDefined("font", -1);
GuiSetIfNotDefined("hAlign", fa_left);
GuiSetIfNotDefined("vAlign", fa_top);

with(GUI_VARS)
{
    __SolverShrinkWidth = function()
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
        __solverShrinkWidth = __solvedWidth;
        
        draw_set_font(-1);
    }
    
    __SolverShrinkHeight = function()
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
            //
            __solverMinHeight = (__layoutHeightMin > 0)? __layoutHeightMin : string_height(__attachedElement.text);
            __solvedHeight      = clamp(__layoutHeightPref, __layoutHeightMin, __layoutHeightMax);
        }
        
        __solverShrinkHeight = __solvedHeight;
        
        draw_set_font(-1);
    }
}