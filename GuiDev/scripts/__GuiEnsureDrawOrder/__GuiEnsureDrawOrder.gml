// Feather disable all

/// Ensures that a valid draw order exists on the system struct. This draw order has be marked
/// as "dirty" by many operations and this function updates the draw order only when necessary.
/// 
/// Must be called in the scope of `__GuiClassEnvironment`.

function __GuiEnsureDrawOrder()
{
    if (not __drawDirty) return;
    
    array_resize(__drawOrder, 0);
    __drawDirty = false;
    
    __GuiEnsureChildOrder();
    __GuiEnsureDrawOrderInner(__drawOrder, __rootInstance);
}

#macro __GUI_DRAW_ORDER_DRAW_END  1
#macro __GUI_DRAW_ORDER_VISIBLE   2
#macro __GUI_DRAW_ORDER_SCISSOR   4
#macro __GUI_DRAW_ORDER_MATRIX    8

function __GuiEnsureDrawOrderInner(_drawOrder, _instance)
{
    with(_instance.GUI_VARS)
    {
        if (__disable) return;
        
        ///////////////////////////////////////////////////////////////////////////
        //                                                                       //
        //  N.B. We build the draw order backwards to handle blockers elegantly  //
        //                                                                       //
        ///////////////////////////////////////////////////////////////////////////
        
        //Calculate a lookup index based on the properties of this instance
        var _lookup = ((_instance.visible? __GUI_DRAW_ORDER_VISIBLE : 0)
                    |  (__scissorEnabled? __GUI_DRAW_ORDER_SCISSOR : 0)
                    |  ((__transformMatrix != undefined)? __GUI_DRAW_ORDER_MATRIX : 0));
        
        //Find a Draw End function for the lookup index
        var _function = _functionLookupArray[_lookup | __GUI_DRAW_ORDER_DRAW_END];
        if (_function != undefined)  array_insert(_drawOrder, 0, method(_instance, _function));
        
        //Add children created inside the parent to the Draw order
        var _array = __childArray;
        var _i = array_length(_array)-1;
        repeat(array_length(_array))
        {
            if (__GuiEnsureDrawOrderInner(_drawOrder, _array[_i]) == __GUI_RETURN_BLOCK_SIBLINGS) break;
            --_i;
        }
        
        //Find a Draw function for the lookup index
        var _function = _functionLookupArray[_lookup];
        if (_function != undefined)  array_insert(_drawOrder, 0, method(_instance, _function));
        
        //If we're a blocker, nope out
        if (__behavior == GUI_BEHAVIOR_BLOCK_SIBLINGS)
        {
            return __GUI_RETURN_BLOCK_SIBLINGS;
        }
    }
    
    return __GUI_RETURN_NORMAL;
    
    static _functionLookupArray = (function()
    {
        var _array = array_create(2*__GUI_DRAW_ORDER_DRAW_END - 1, undefined);
        
        _array[0] = undefined;
        
        _array[__GUI_DRAW_ORDER_SCISSOR] = function()
        {
            __GuiScissorPushFromInstance();
        }
        
        _array[__GUI_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(GUI_VARS.__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__GUI_DRAW_ORDER_SCISSOR | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(GUI_VARS.__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            __GuiScissorPushFromInstance();
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE] = function()
        {
            event_user(GUI_USER_EVENT_DRAW);
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_SCISSOR] = function()
        {
            event_user(GUI_USER_EVENT_DRAW);
            __GuiScissorPushFromInstance();
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(GUI_VARS.__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            event_user(GUI_USER_EVENT_DRAW);
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_DRAW_END] = function()
        {
            event_user(GUI_USER_EVENT_DRAW_END);
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_SCISSOR | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(GUI_VARS.__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            event_user(GUI_USER_EVENT_DRAW);
            __GuiScissorPushFromInstance();
        }
        
        _array[__GUI_DRAW_ORDER_DRAW_END] = undefined;
        
        _array[__GUI_DRAW_ORDER_DRAW_END | __GUI_DRAW_ORDER_SCISSOR] = function()
        {
            __GuiScissorPop();
        }
        
        _array[__GUI_DRAW_ORDER_DRAW_END | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__GUI_DRAW_ORDER_DRAW_END | __GUI_DRAW_ORDER_SCISSOR | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            __GuiScissorPop();
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__GUI_DRAW_ORDER_DRAW_END | __GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_SCISSOR] = function()
        {
            __GuiScissorPop();
            event_user(GUI_USER_EVENT_DRAW_END);
        }
        
        _array[__GUI_DRAW_ORDER_DRAW_END | __GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            event_user(GUI_USER_EVENT_DRAW_END);
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__GUI_DRAW_ORDER_DRAW_END | __GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_SCISSOR | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            __GuiScissorPop();
            event_user(GUI_USER_EVENT_DRAW_END);
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        return _array;
    })();
}