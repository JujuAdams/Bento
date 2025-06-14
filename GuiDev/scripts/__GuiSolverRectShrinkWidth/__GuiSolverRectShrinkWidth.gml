// Feather disable all

function __GuiSolverRectGetShrinkWidth()
{
    //Determine the preferred width
    if (__layoutWidthPref > 0)
    {
        //If the preferred width is greater than 0 then use the preferred width
        var _width = __layoutWidthPref;
    }
    else if (__elementIsInstance && sprite_exists(__attachedElement.sprite_index))
    {
        //Otherwise use the width of the element's sprite (if it's an instance element)
        var _width = sprite_get_width(__attachedElement.sprite_index);
    }
    else
    {
        //Fall back on the minimum width if we can't find a suitable preferred width
        var _width = __layoutWidthMin;
    }
    
    __solvedWidth = clamp(_width, __layoutWidthMin, __layoutWidthMax);
    
    __solverGetShrinkWidth = __solvedWidth;
    __solverMinWidth = (__layoutWidthMin > 0)? __layoutWidthMin : __solvedWidth;
}