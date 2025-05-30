// Feather disable all

function __GuiSolverRectPositions(_left, _top, _allocatedWidth, _allocatedHeight)
{
    // N.B. `GUI_LAYOUT_LIST`, `GUI_LAYOUT_GRID` override this function.
    
    __solvedLeft = _left + __layoutOffsetX + __layoutAlignH*(_allocatedWidth  - __solvedWidth );
    __solvedTop  = _top  + __layoutOffsetY + __layoutAlignV*(_allocatedHeight - __solvedHeight);
    
    if (GUI_FLOOR_LAYOUT_POSITIONS)
    {
        __solvedLeft   = floor(__solvedLeft);
        __solvedTop    = floor(__solvedTop);
        __solvedWidth  = floor(__solvedWidth);
        __solvedHeight = floor(__solvedHeight);
    }
    
    var _childX      = __solvedLeft + __layoutPadLeft;
    var _childY      = __solvedTop  + __layoutPadTop;
    var _childWidth  = __solvedWidth  - (__layoutPadLeft + __layoutPadRight);
    var _childHeight = __solvedHeight - (__layoutPadTop + __layoutPadBottom);
    
    var _childArray = __childArray;
    var _i = 0;
    repeat(array_length(_childArray))
    {
        _childArray[_i].GUI_VARS.__SolverPositions(_childX, _childY, _childWidth, _childHeight);
        ++_i;
    }
}