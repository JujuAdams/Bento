// Feather disable allry.

function __GuiEnsureLayout()
{
    static _system = __GuiSystem();
    if (not _system.__layoutDirty) return;
    
    with(_system)
    {
        var _rootInstance = GUI_ROOT;
        var _rootGui = _rootInstance.__gui;
        
        //Ensure a full reset of the animation/scroll positions
        array_resize(__animAndScrollDirtyArray, 0);
        array_push(__animAndScrollDirtyArray, _rootInstance);
        
        var _layoutOrder = __layoutOrder;
        array_resize(_layoutOrder, 0);
        __layoutDirty = false;
        
        __GuiEnsureChildOrder();
        
        //Ensure that our layout order is up-to-date
        __GuiEnsureLayerOrderInner(_rootInstance);
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
        _rootGui.__SolverPositions(0, 0, _rootGui.__solvedWidth, _rootGui.__solvedHeight);
    }
}

function __GuiEnsureLayerOrderInner(_instance)
{
    static _system      = __GuiSystem();
    static _layoutOrder = _system.__layoutOrder;
    
    with(_instance.__gui)
    {
        array_push(_layoutOrder, self);
        
        var _array = __childArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            __GuiEnsureLayerOrderInner(_array[_i]);
            ++_i;
        }
    }
}