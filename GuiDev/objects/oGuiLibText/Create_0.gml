// Feather disable all

event_inherited();

GuiSetIfNotDefined(id, "text", "");
GuiSetIfNotDefined(id, "font", -1);
GuiSetIfNotDefined(id, "hAlign", fa_left);
GuiSetIfNotDefined(id, "vAlign", fa_top);

__SolverFitWidth = function()
{
    draw_set_font(font);
    
    var _width    = __layoutWidthPref;
    var _height   = __layoutHeightPref;
    
    if (_width  <= 0) _width  = string_width( text);
    if (_height <= 0) _height = string_height(text);
    
    if (__layoutWidthResize == GUI_RESIZE_FIT)
    {
        layoutWidth = string_width_ext(text, -1, min(999999, __layoutWidthMin)); //Not sure how well GameMaker handle `infinity` for some internal functions
    }
    else
    {
        layoutWidth = clamp(_width, __layoutWidthMin, __layoutWidthMax);
    }
    
    __solverMinWidth = (__layoutWidthMin > 0)? __layoutWidthMin : ((__layoutWidthResize == GUI_RESIZE_STATIC)? _width : string_width("Hello"));
    __solverFitWidth = layoutWidth;
    
    draw_set_font(-1);
}

__LayoutReflowText = function()
{
    draw_set_font(font);
    
    if (__layoutWidthResize == GUI_RESIZE_FIT)
    {
        var _width = string_width_ext(text, -1, layoutWidth);
        layoutWidth = _width;
        __solverFitWidth = _width;
    }
    
    draw_set_font(-1);
}

__SolverFitHeight = function()
{
    draw_set_font(font);
    
    if (__layoutHeightResize == GUI_RESIZE_FIT)
    {
        var _height = max(__layoutHeightMin, string_height_ext(text, -1, layoutWidth)); //Not sure how well GameMaker handle `infinity` for some internal functions
        __solverMinHeight = _height;
        layoutHeight    = _height;
    }
    else
    {
        __solverMinHeight = (__layoutHeightMin > 0)? __layoutHeightMin : string_height(text);
        layoutHeight    = clamp(__layoutHeightPref, __layoutHeightMin, __layoutHeightMax);
    }
    
    __solverFitHeight = layoutHeight;
    
    draw_set_font(-1);
}

__SolverSetLayoutXY = function()
{
    layoutX = GuiRegionGetTextX(layoutLeft, layoutWidth,  hAlign);
    layoutY = GuiRegionGetTextY(layoutTop,  layoutHeight, vAlign);
}