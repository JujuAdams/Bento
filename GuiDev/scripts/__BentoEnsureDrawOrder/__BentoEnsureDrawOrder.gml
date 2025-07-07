// Feather disable all

/// Ensures that a valid draw order exists on the system struct. This draw order has be marked
/// as "dirty" by many operations and this function updates the draw order only when necessary.
/// 
/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureDrawOrder()
{
    //Function to call per element with a dirty local draw order
    static _funcForEach = function(_element)
    {
        static _funcSort = function(_a, _b)
        {
            _a = _a.BENTO_VARS;
            _b = _b.BENTO_VARS;
            
            var _delta = (_a.__drawDepth - _b.__drawDepth);
            if (_delta < 0)
            {
                return 1;
            }
            else if (_delta > 0)
            {
                return -1;
            }
            else
            {
                //Fall back on the Step order
                return sign(_a.__localIndex - _b.__localIndex);
            }
        }
        
        with(_element.BENTO_VARS)
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
    __BentoEnsureDrawOrderInner(__drawOrder, __rootElement);
}

#macro __BENTO_DRAW_ORDER_VISIBLE  1
#macro __BENTO_DRAW_ORDER_SCISSOR  2
#macro __BENTO_DRAW_ORDER_MATRIX   4

function __BentoEnsureDrawOrderInner(_drawOrder, _element)
{
    //N.B. - If you edit this, make sure to edit `__DrawWireframe()` as well
    
    with(_element.BENTO_VARS)
    {
        if (__disable) return;
        
        //Calculate a lookup index based on the properties of this element
        var _lookup = ((__visible? __BENTO_DRAW_ORDER_VISIBLE : 0)
                    |  (__scissorEnabled? __BENTO_DRAW_ORDER_SCISSOR : 0)
                    |  ((__transformMatrix != undefined)? __BENTO_DRAW_ORDER_MATRIX : 0));
        
        //Find a Draw function for the lookup index
        var _function = _functionDrawLookupArray[_lookup];
        if (_function != undefined) array_push(_drawOrder, method(_element, _function));
        
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
        if (_function != undefined) array_push(_drawOrder, method(_element, _function));
    }
    
    static _functionDrawLookupArray = (function()
    {
        var _array = array_create((__BENTO_DRAW_ORDER_MATRIX << 1), undefined);
        
        _array[0] = undefined;
        
        _array[__BENTO_DRAW_ORDER_SCISSOR] = function()
        {
            __BentoScissorPushFromElement();
        }
        
        _array[__BENTO_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(BENTO_VARS.__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__BENTO_DRAW_ORDER_SCISSOR | __BENTO_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(BENTO_VARS.__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            __BentoScissorPushFromElement();
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE] = function()
        {
            BENTO_VARS.__eventDraw();
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_SCISSOR] = function()
        {
            BENTO_VARS.__eventDraw();
            __BentoScissorPushFromElement();
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(BENTO_VARS.__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            BENTO_VARS.__eventDraw();
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_SCISSOR | __BENTO_DRAW_ORDER_MATRIX] = function()
        {
            matrix_stack_push(BENTO_VARS.__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            BENTO_VARS.__eventDraw();
            __BentoScissorPushFromElement();
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
            BENTO_VARS.__eventDrawAfter();
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_MATRIX] = function()
        {
            BENTO_VARS.__eventDrawAfter();
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        _array[__BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_SCISSOR | __BENTO_DRAW_ORDER_MATRIX] = function()
        {
            __BentoScissorPop();
            BENTO_VARS.__eventDrawAfter();
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        }
        
        return _array;
    })();
}