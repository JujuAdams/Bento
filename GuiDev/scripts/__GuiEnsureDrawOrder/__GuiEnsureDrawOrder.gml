// Feather disable all

/// Ensures that a valid draw order exists on the system struct. This draw order has be marked
/// as "dirty" by many operations and this function updates the draw order only when necessary.

function __GuiEnsureDrawOrder()
{
    static _system          = __GuiSystem();
    static _dirtyOrderArray = __GuiSystem().__dirtyOrderArray;
    
    if (not _system.__drawDirty) return _system.__drawOrder;
    
    with(_system)
    {
        array_resize(__drawOrder, 0);
        __drawDirty = false;
        
        array_foreach(_dirtyOrderArray, __GuiSortChildren);
        array_resize(_dirtyOrderArray, 0);
        
        __GuiEnsureDrawOrderInner(GUI_ROOT);
        
        return __drawOrder;
    }
}

function __GuiEnsureDrawOrderInner(_instance)
{
    static _drawOrder = __GuiSystem().__drawOrder;
    
    with(_instance)
    {
        if (__disable) return;
        
        //N.B. We iterate over instances backwards to handle blockers elegantly
        
        //Add children created outside the parent to the Draw order
        var _array = __childOutsideArray;
        var _i = array_length(_array)-1;
        repeat(array_length(_array))
        {
            if (__GuiEnsureDrawOrderInner(_array[_i]) == __GUI_RETURN_BLOCK_SIBLINGS) break;
            --_i;
        }
        
        if (__drawEnd)
        {
            if (__scissorState)
            {
                array_insert(_drawOrder, 0, method(self, function()
                {
                    __GuiScissorPop();
                    event_user(GUI_USER_EVENT_DRAW_END);
                }));
            }
            else
            {
                array_insert(_drawOrder, 0, method(self, function()
                {
                    event_user(GUI_USER_EVENT_DRAW_END);
                }));
            }
        }
        else
        {
            if (__scissorState)
            {
                array_insert(_drawOrder, 0, method(self, __GuiScissorPop));
            }
        }
        
        //Add children created inside the parent to the Draw order
        var _array = __childInsideArray;
        var _i = array_length(_array)-1;
        repeat(array_length(_array))
        {
            if (__GuiEnsureDrawOrderInner(_array[_i]) == __GUI_RETURN_BLOCK_SIBLINGS) break;
            --_i;
        }
        
        //Always push ourselves to the Draw order
        if (__scissorState)
        {
            array_insert(_drawOrder, 0, method(self, function()
            {
                if (visible)
                {
                    event_user(GUI_USER_EVENT_DRAW);
                }
                
                __GuiScissorPush(__scissorLeft, __scissorTop, __scissorRight, __scissorBottom);
            }));
        }
        else
        {
            array_insert(_drawOrder, 0, method(self, function()
            {
                if (visible)
                {
                    event_user(GUI_USER_EVENT_DRAW);
                }
            }));
        }
        
        if (__behavior == GUI_BEHAVIOR_BLOCK_SIBLINGS)
        {
            return __GUI_RETURN_BLOCK_SIBLINGS;
        }
    }
    
    return __GUI_RETURN_NORMAL;
}