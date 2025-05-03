// Feather disable all

/// Must be called in the scope of `__GuiClassLayer`.

function __GuiEnsureLayout()
{
    if (not __layoutDirty) return;
    __layoutDirty = false;
    
    var _layoutOrder = __layoutOrder;
    array_resize(_layoutOrder, 0);
    
    __GuiEnsureChildOrder();
    
    //Ensure that our layout order is up-to-date
    __GuiEnsureLayerOrderInner(_layoutOrder, __rootInstance);
    var _count = array_length(_layoutOrder);
    
    //Populate static widths of instances
    var _i = _count-1;
    repeat(_count)
    {
        _layoutOrder[_i].__SolverFitWidth();
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
        _layoutOrder[_i].__SolverFitHeight();
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
    var _rootGui = __rootInstance.GUI_VARS;
    _rootGui.__SolverPositions(0, 0, _rootGui.__solvedWidth, _rootGui.__solvedHeight);
    
    //Ensure a full reset of the transform/scroll positions
    array_resize(__transformAndScrollDirtyArray, 0);
    array_push(__transformAndScrollDirtyArray, __rootInstance);
}

function __GuiEnsureLayerOrderInner(_layoutOrder, _instance)
{
    with(_instance.GUI_VARS)
    {
        array_push(_layoutOrder, self);
        
        var _array = __childArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            __GuiEnsureLayerOrderInner(_layoutOrder, _array[_i]);
            ++_i;
        }
    }
}