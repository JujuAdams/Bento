// Feather disable all

/// Ensures that a valid draw order exists on the system struct. This draw order has be marked
/// as "dirty" by many operations and this function updates the draw order only when necessary.
/// 
/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureDrawOrder()
{
    //Function to call per element with a dirty local draw order
    static _funcForEach = function(_elementVars)
    {
        static _funcSort = function(_a, _b)
        {
            var _delta = (_a.__drawDepth - _b.__drawDepth);
            
            if (_delta == 0)
            {
                //Fall back on the order that these siblings appear in the parent's child order
                var _parent = _a.__parent;
                if (_parent == BENTO_NO_ELEMENT) return 0;
                
                var _childArray = _parent.BENTO_VARS.__childArray;
                _delta = array_get_index(_childArray, _a) - array_get_index(_childArray, _b);
            }
            
            return sign(_delta);
        }
        
        with(_elementVars)
        {
            if (__drawOrderDirty)
            {
                __drawOrderDirty = false;
                array_sort(__childDrawArray, _funcSort);
            }
        }
    }
    
    //Don't do anything if nothing is dirty!
    if not (__dirtyFlags & __BENTO_DIRTY_DRAW) return;
    __dirtyFlags = ~((~__dirtyFlags) | __BENTO_DIRTY_DRAW);
    
    //Update the local draw order for dirty elements
    if (array_length(__dirtyChildOrderArray) > 0)
    {
        __BentoEnsureStepOrder();
        array_foreach(__dirtyChildOrderArray, _funcForEach);
        array_resize(__dirtyChildOrderArray, 0);
    }
    
    //Recursively build the global draw order
    array_resize(__drawOrder, 0);
    __BentoEnsureDrawOrderInner(__drawOrder, __rootElement.BENTO_VARS);
}

#macro __BENTO_DRAW_ORDER_VISIBLE  1
#macro __BENTO_DRAW_ORDER_SCISSOR  2
#macro __BENTO_DRAW_ORDER_MATRIX   4

function __BentoEnsureDrawOrderInner(_drawOrder, _elementVars)
{
    //N.B. - If you edit this, make sure to edit `__DrawWireframe()` as well
    
    with(_elementVars)
    {
        if (__disable) return;
        
        //Calculate a lookup index based on the properties of this element
        var _lookup = ((__visible? __BENTO_DRAW_ORDER_VISIBLE : 0)
                    |  (__scissorEnabled? __BENTO_DRAW_ORDER_SCISSOR : 0)
                    |  ((__transformMatrix != undefined)? __BENTO_DRAW_ORDER_MATRIX : 0));
        
        //Find a Draw function for the lookup index
        var _function = _functionDrawLookupArray[_lookup];
        if (_function != undefined) array_push(_drawOrder, method(self, _function));
        
        //Add children created inside the parent to the Draw order
        var _array = __childDrawArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            __BentoEnsureDrawOrderInner(_drawOrder, _array[_i]);
            ++_i;
        }
        
        //Update the lookup index based on the "Draw After" visibility state
        if (not __drawAfter) _lookup &= (~__BENTO_DRAW_ORDER_VISIBLE);
        
        //Find a Draw After function for the lookup index
        var _function = _functionDrawAfterLookupArray[_lookup];
        if (_function != undefined) array_push(_drawOrder, method(self, _function));
    }
    
    static _functionDrawLookupArray = (function()
    {
        var _array = array_create((__BENTO_DRAW_ORDER_MATRIX << 1), undefined);
        
        _array[0] = undefined;
        
        _array[__BENTO_DRAW_ORDER_SCISSOR] = function()
        {
            __BentoScissorPushFromVars();
        }
        
        _array[__BENTO_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__BENTO_DRAW_ORDER_SCISSOR | __BENTO_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            __BentoScissorPushFromVars();
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE] = function()
        {
            __eventDraw();
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_SCISSOR] = function()
        {
            __eventDraw();
            __BentoScissorPushFromVars();
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            __eventDraw();
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_SCISSOR | __BENTO_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            __eventDraw();
            __BentoScissorPushFromVars();
        }
        
        return _array;
    })();
    
    static _functionDrawAfterLookupArray = (function()
    {
        var _array = array_create((__BENTO_DRAW_ORDER_MATRIX << 1) - 1, undefined);
        
        _array[0] = undefined;
        
        _array[__BENTO_DRAW_ORDER_SCISSOR] = function()
        {
            __BentoScissorPop();
        }
        
        _array[__BENTO_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__BENTO_DRAW_ORDER_SCISSOR | __BENTO_DRAW_ORDER_MATRIX] = function()
        {
            __BentoScissorPop();
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_SCISSOR] = function()
        {
            __BentoScissorPop();
            __eventDrawAfter();
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_MATRIX] = function()
        {
            __eventDrawAfter();
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_SCISSOR | __BENTO_DRAW_ORDER_MATRIX] = function()
        {
            __BentoScissorPop();
            __eventDrawAfter();
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        return _array;
    })();
}