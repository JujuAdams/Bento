// Feather disable allry.

function __GuiEnsureLayout()
{
    static _system = __GuiSystem();
    if (not _system.__layoutDirty) return;
    
    with(_system)
    {
        var _guiRoot = GUI_ROOT;
        
        //Ensure a full reset of the animation/scroll positions
        array_resize(__animAndScrollDirtyArray, 0);
        array_push(__animAndScrollDirtyArray, _guiRoot);
        
        var _layoutOrder = __layoutOrder;
        array_resize(_layoutOrder, 0);
        __layoutDirty = false;
        
        __GuiEnsureChildOrder();
        
        //Ensure that our layout order is up-to-date
        __GuiEnsureLayerOrderInner(_guiRoot);
        var _instanceCount = array_length(_layoutOrder);
        
        //ulate static widths of instances
        var _i = _instanceCount-1;
        repeat(_instanceCount)
        {
            _layoutOrder[_i].__SolverFitWidth();
            --_i;
        }
        
        //Redistribute instance widths, shrinking and growing instances
        var _i = 0;
        repeat(_instanceCount)
        {
            _layoutOrder[_i].__SolverResizeWidth();
            ++_i;
        }
        
        //ulate static heights of instances
        var _i = _instanceCount-1;
        repeat(_instanceCount)
        {
            _layoutOrder[_i].__SolverFitHeight();
            --_i;
        }
        
        //Redistribute instance heights, shrinking and growing instances
        var _i = 0;
        repeat(_instanceCount)
        {
            _layoutOrder[_i].__SolverResizeHeight();
            ++_i;
        }
        
        //Final pass to set positions in stone
        _guiRoot.__SolverPositions(0, 0, _guiRoot.__solvedWidth, _guiRoot.__solvedHeight);
    }
}

function __GuiEnsureLayerOrderInner(_instance)
{
    static _system      = __GuiSystem();
    static _layoutOrder = __GuiSystem().__layoutOrder;
    
    with(_instance)
    {
        array_push(_layoutOrder, id);
        
        var _array = __childArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            __GuiEnsureLayerOrderInner(_array[_i]);
            ++_i;
        }
    }
}