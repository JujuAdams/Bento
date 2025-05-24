// Feather disable all

/// Ensures that a valid draw order exists on the system struct. This draw order has be marked
/// as "dirty" by many operations and this function updates the draw order only when necessary.
/// 
/// Must be called in the scope of `__GuiClassLayer`.

function __GuiEnsureDrawOrder()
{
    if (not __drawDirty) return;
    
    array_resize(__drawOrder, 0);
    __drawDirty = false;
    
    __GuiEnsureChildOrder();
    __GuiEnsureDrawOrderInner(__drawOrder, __rootElement);
}

#macro __GUI_DRAW_ORDER_VISIBLE  1
#macro __GUI_DRAW_ORDER_SCISSOR  2
#macro __GUI_DRAW_ORDER_MATRIX   4

function __GuiEnsureDrawOrderInner(_drawOrder, _element)
{
    with(_element.GUI_VARS)
    {
        if (__disable) return;
        
        //Calculate a lookup index based on the properties of this instance
        var _lookup = ((__visible? __GUI_DRAW_ORDER_VISIBLE : 0)
                    |  (__scissorEnabled? __GUI_DRAW_ORDER_SCISSOR : 0)
                    |  ((__transformMatrix != undefined)? __GUI_DRAW_ORDER_MATRIX : 0));
        
        //Find a Draw function for the lookup index
        var _function = _functionDrawLookupArray[_lookup];
        if (_function != undefined) array_push(_drawOrder, method(_element, _function));
        
        //Add children created inside the parent to the Draw order
        var _array = __childArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            __GuiEnsureDrawOrderInner(_drawOrder, _array[_i]);
            ++_i;
        }
        
        //Update the lookup index based on the "Draw After" visibility state
        if (not __drawAfter) _lookup &= (~__GUI_DRAW_ORDER_VISIBLE);
        
        //Find a Draw After function for the lookup index
        var _function = _functionDrawAfterLookupArray[_lookup];
        if (_function != undefined) array_push(_drawOrder, method(_element, _function));
    }
    
    static _functionDrawLookupArray = (function()
    {
        var _array = array_create((__GUI_DRAW_ORDER_MATRIX << 1), undefined);
        
        _array[0] = undefined;
        
        _array[__GUI_DRAW_ORDER_SCISSOR] = function()
        {
            __GuiScissorPushFromElement();
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
            __GuiScissorPushFromElement();
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE] = function()
        {
            GUI_VARS.__eventDraw();
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_SCISSOR] = function()
        {
            GUI_VARS.__eventDraw();
            __GuiScissorPushFromElement();
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(GUI_VARS.__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            GUI_VARS.__eventDraw();
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_SCISSOR | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(GUI_VARS.__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            GUI_VARS.__eventDraw();
            __GuiScissorPushFromElement();
        }
        
        return _array;
    })();
    
    static _functionDrawAfterLookupArray = (function()
    {
        var _array = array_create((__GUI_DRAW_ORDER_MATRIX << 1) - 1, undefined);
        
        _array[0] = undefined;
        
        _array[__GUI_DRAW_ORDER_SCISSOR] = function()
        {
            __GuiScissorPop();
        }
        
        _array[__GUI_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__GUI_DRAW_ORDER_SCISSOR | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            __GuiScissorPop();
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_SCISSOR] = function()
        {
            __GuiScissorPop();
            GUI_VARS.__eventDrawAfter();
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            GUI_VARS.__eventDrawAfter();
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__GUI_DRAW_ORDER_VISIBLE | __GUI_DRAW_ORDER_SCISSOR | __GUI_DRAW_ORDER_MATRIX] = function()
        {
            __GuiScissorPop();
            GUI_VARS.__eventDrawAfter();
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        return _array;
    })();
}