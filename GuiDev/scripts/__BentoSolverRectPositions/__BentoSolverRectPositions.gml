// Feather disable all

function __BentoSolverRectPositions(_left, _top, _allocatedWidth, _allocatedHeight)
{
    // N.B. `BENTO_LAYOUT_LIST`, `BENTO_LAYOUT_GRID` override this function.
    
    __solvedLeft = _left + __layoutAnchorX*(_allocatedWidth  - __solvedWidth );
    __solvedTop  = _top  + __layoutAnchorY*(_allocatedHeight - __solvedHeight);
    
    if (BENTO_FLOOR_LAYOUT_POSITIONS)
    {
        __solvedLeft   = floor(__solvedLeft);
        __solvedTop    = floor(__solvedTop);
        __solvedWidth  = floor(__solvedWidth);
        __solvedHeight = floor(__solvedHeight);
    }
    
    var _childX      = __solvedLeft + __solverPadLeft;
    var _childY      = __solvedTop  + __solverPadTop;
    var _childWidth  = __solvedWidth  - (__solverPadLeft + __solverPadRight);
    var _childHeight = __solvedHeight - (__solverPadTop + __solverPadBottom);
    
    var _childArray = __childArray;
    var _i = 0;
    repeat(array_length(_childArray))
    {
        _childArray[_i].BENTO_VARS.__SolverPositions(_childX, _childY, _childWidth, _childHeight);
        ++_i;
    }
}