// Feather disable all

event_inherited();

GuiSetIfNotDefined("text", "");
GuiSetIfNotDefined("font", -1);
GuiSetIfNotDefined("hAlign", fa_left);
GuiSetIfNotDefined("vAlign", fa_top);

with(__gui)
{
    __SolverFitWidth = function()
    {
        draw_set_font(font);
        
        //Determine the preferred width for the text. If the preferred width isn't set then we use the
        //full width of the text string itself.
        var _widthPref = clamp((__layoutWidthPref > 0)? __layoutWidthPref : string_width(text), __layoutWidthMin, __layoutWidthMax);
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
        
        //Whatever the weather, the width for the purpose of fitting the parent is whatever layout
        //width guess we've made.
        __solverFitWidth = __solvedWidth;
        
        draw_set_font(-1);
    }
    
    __SolverFitHeight = function()
    {
        draw_set_font(font);
        
        if (__layoutHeightResize == GUI_RESIZE_FIT)
        {
            //Change the height of this instance based on the new wrapping rules.
            //
            //P.S. Not sure how well GameMaker handles `infinity` for some internal functions
            var _height = clamp(string_height_ext(text, -1, __solvedWidth), __layoutHeightMin, __layoutHeightMax);
            __solverMinHeight = _height;
            __solvedHeight      = _height;
        }
        else
        {
            //
            __solverMinHeight = (__layoutHeightMin > 0)? __layoutHeightMin : string_height(text);
            __solvedHeight      = clamp(__layoutHeightPref, __layoutHeightMin, __layoutHeightMax);
        }
        
        __solverFitHeight = __solvedHeight;
        
        draw_set_font(-1);
    }
}