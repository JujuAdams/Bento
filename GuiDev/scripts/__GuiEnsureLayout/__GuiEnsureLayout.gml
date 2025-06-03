// Feather disable all

/// Must be called in the scope of `__GuiClassLayer`.

function __GuiEnsureLayout()
{
    if not (__dirtyFlags & __GUI_DIRTY_LAYOUT) return;
    __dirtyFlags = ~((~__dirtyFlags) | __GUI_DIRTY_LAYOUT);
    
    var _layoutOrder = __layoutOrder;
    array_resize(_layoutOrder, 0);
    
    //Ensure that our layout order is up-to-date
    __GuiEnsureLayerOrderInner(_layoutOrder, __rootElement);
    var _count = array_length(_layoutOrder);
    
    //Populate static widths of instances
    var _i = _count-1;
    repeat(_count)
    {
        _layoutOrder[_i].__SolverShrinkWidth();
        --_i;
    }
    
    //Redistribute instance widths, shrinking and growing instances
    var _i = 0;
    repeat(_count)
    {
        _layoutOrder[_i].__SolverResizeWidth();
        ++_i;
    }
    
    //Populate static heights of instances
    var _i = _count-1;
    repeat(_count)
    {
        _layoutOrder[_i].__SolverShrinkHeight();
        --_i;
    }
    
    //Redistribute instance heights, shrinking and growing instances
    var _i = 0;
    repeat(_count)
    {
        _layoutOrder[_i].__SolverResizeHeight();
        ++_i;
    }
    
    //Final pass to set positions in stone
    var _rootGui = __rootElement.GUI_VARS;
    _rootGui.__SolverPositions(0, 0, _rootGui.__solvedWidth, _rootGui.__solvedHeight);
    
    //Ensure a full reset of the transform/scroll positions
    array_resize(__dirtyScrollPosArray, 0);
    array_push(__dirtyScrollPosArray, __rootElement);
}

function __GuiEnsureLayerOrderInner(_layoutOrder, _element)
{
    with(_element.GUI_VARS)
    {
        array_push(_layoutOrder, self);
        
        __solverPadLeft   = __layoutPadLeft   + __scissorPadLeft   + __scissorScrollbarLeft;
        __solverPadTop    = __layoutPadTop    + __scissorPadTop    + __scissorScrollbarTop;
        __solverPadRight  = __layoutPadRight  + __scissorPadRight  + __scissorScrollbarRight;
        __solverPadBottom = __layoutPadBottom + __scissorPadBottom + __scissorScrollbarBottom;
        
        var _array = __childArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            __GuiEnsureLayerOrderInner(_layoutOrder, _array[_i]);
            ++_i;
        }
    }
}