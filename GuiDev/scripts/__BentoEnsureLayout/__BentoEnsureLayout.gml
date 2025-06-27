// Feather disable all

/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureLayout()
{
    if not (__dirtyFlags & __BENTO_DIRTY_LAYOUT) return;
    __dirtyFlags = ~((~__dirtyFlags) | __BENTO_DIRTY_LAYOUT);
    
    var _layoutOrder = __layoutOrder;
    array_resize(_layoutOrder, 0);
    
    //Ensure that our layout order is up-to-date
    __BentoEnsureLayerOrderInner(_layoutOrder, __rootElement);
    var _count = array_length(_layoutOrder);
    
    //Populate static widths of instances
    var _i = _count-1;
    repeat(_count)
    {
        _layoutOrder[_i].__SolverGetShrinkWidth();
        --_i;
    }
    
    //Redistribute instance widths, shrinking and expanding instances
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
        _layoutOrder[_i].__SolverGetShrinkHeight();
        --_i;
    }
    
    //Redistribute instance heights, shrinking and expanding instances
    var _i = 0;
    repeat(_count)
    {
        _layoutOrder[_i].__SolverResizeHeight();
        ++_i;
    }
    
    //Final pass to set positions in stone
    var _rootBento = __rootElement.BENTO_VARS;
    _rootBento.__SolverPositions(0, 0, _rootBento.__solvedWidth, _rootBento.__solvedHeight);
    
    //Ensure a full reset of the transform/scroll positions
    array_resize(__dirtyOffsetArray, 0);
    array_push(__dirtyOffsetArray, __rootElement);
}

function __BentoEnsureLayerOrderInner(_layoutOrder, _element)
{
    with(_element.BENTO_VARS)
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
            __BentoEnsureLayerOrderInner(_layoutOrder, _array[_i]);
            ++_i;
        }
    }
}