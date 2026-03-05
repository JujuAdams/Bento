// Feather disable all

/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureLayout()
{
    if not (__dirtyFlags & __BENTO_DIRTY_LAYOUT) return;
    __dirtyFlags = ~((~__dirtyFlags) | __BENTO_DIRTY_LAYOUT);
    
    var _layoutOrder = __layoutOrder;
    array_resize(_layoutOrder, 0);
    
    if (BentoExists(__rootElement))
    {
        //Ensure that our layout order is up-to-date
        __BentoEnsureLayerOrderInner(_layoutOrder, __rootElement.BENTO_VARS);
        var _count = array_length(_layoutOrder);
        
        //Populate static widths of elements
        var _i = _count-1;
        repeat(_count)
        {
            _layoutOrder[_i].__SolverGetDeflateWidth();
            --_i;
        }
        
        //Redistribute element widths, deflating and inflating elements
        var _i = 0;
        repeat(_count)
        {
            _layoutOrder[_i].__SolverResizeWidth();
            ++_i;
        }
        
        //Populate static heights of elements
        var _i = _count-1;
        repeat(_count)
        {
            _layoutOrder[_i].__SolverGetDeflateHeight();
            --_i;
        }
        
        //Redistribute element heights, deflating and inflating elements
        var _i = 0;
        repeat(_count)
        {
            _layoutOrder[_i].__SolverResizeHeight();
            ++_i;
        }
        
        //Final pass to set positions in stone
        var _rootBento = __rootElement.BENTO_VARS;
        _rootBento.__SolverFinalPositions(0, 0, _rootBento.__solvedWidth, _rootBento.__solvedHeight);
    }
    
    //Ensure a full reset of the transform/scroll positions
    array_resize(__dirtyOffsetArray, 0);
    
    if (BentoExists(__rootElement))
    {
        array_push(__dirtyOffsetArray, __rootElement);
    }
}

function __BentoEnsureLayerOrderInner(_layoutOrder, _elementVars)
{
    with(_elementVars)
    {
        array_push(_layoutOrder, self);
        
        __solverPadLeft   = __layoutPadLeft   + __scissorPadLeft   + __scissorScrollbarLeft;
        __solverPadTop    = __layoutPadTop    + __scissorPadTop    + __scissorScrollbarTop;
        __solverPadRight  = __layoutPadRight  + __scissorPadRight  + __scissorScrollbarRight;
        __solverPadBottom = __layoutPadBottom + __scissorPadBottom + __scissorScrollbarBottom;
        
        var _childArray  = __childArray;
        var _layoutArray = __layoutChildArray;
        
        var _i = 0;
        repeat(array_length(_childArray))
        {
            with(_childArray[_i])
            {
                if (not __disable)
                {
                    array_push(_layoutArray, self);
                    __BentoEnsureLayerOrderInner(_layoutOrder, self);
                }
            }
            
            ++_i;
        }
    }
}