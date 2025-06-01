// Feather disable all

function __GuiSolverRectShrinkHeight()
{
    //Determine the preferred height
    if (__layoutHeightPref > 0)
    {
        //If the preferred height is greater than 0 then use the preferred height
        var _height = __layoutHeightPref;
    }
    else if (__elementIsInstance && sprite_exists(__attachedElement.sprite_index))
    {
        //Otherwise use the height of the element's sprite (if it's an instance element)
        var _height = sprite_get_height(__attachedElement.sprite_index);
    }
    else
    {
        //Fall back on the minimum height if we can't find a suitable preferred height
        var _height = __layoutHeightMin;
    }
    
    __solvedHeight = clamp(_height, __layoutHeightMin, __layoutHeightMax);
    
    __solverShrinkHeight = __solvedHeight;
    __solverMinHeight = (__layoutHeightMin > 0)? __layoutHeightMin : __solvedHeight;
}