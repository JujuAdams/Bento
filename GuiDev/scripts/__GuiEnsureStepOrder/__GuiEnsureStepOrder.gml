// Feather disable all

/// Ensures that a valid step order exists on the system struct. This step order has be marked
/// as "dirty" by many operations and this function updates the step order only when necessary.
/// 
/// Must be called in the scope of `__GuiClassLayer`.

function __GuiEnsureStepOrder()
{
    if (not __stepDirty) return;
    __stepDirty = false;
    
    array_resize(__stepOrder, 0);
    
    //Determine where to start the Step order processing
    //FIXME - Walk up focus stack to find a pointer constrain element rather than only looking at the top one
    var _focusTop = __focusTop;
    if (__GuiExists(_focusTop) && (__navDirectional || (_focusTop.GUI_VARS.__focusType == GUI_FOCUS_POINTER_CONSTRAIN)))
    {
        var _root = _focusTop;
    }
    else
    {
        var _root = __rootElement;
    }
    
    __GuiEnsureChildOrder();
    __GuiEnsureStepOrderInner(self, __stepOrder, _root, __navPointer? GUI_BUTTON_POINTER : GUI_BUTTON_ALWAYS);
    
    return __stepOrder;
}

function __GuiEnsureStepOrderInner(_layer, _stepOrder, _element, _minButtonType)
{
    with(_element.GUI_VARS)
    {
        if (__disable) return true;
        
        if (GUI_ALWAYS_EXECUTE_STEP)
        {
            array_push(_stepOrder, __eventStep);
        }
        else
        {
            //Determine whether we need to execute the Step user event
            if (__focused)
            {
                array_push(_stepOrder, __eventStep);
                
                //Don't need this code any more since we're starting iteration at the focused element
                //if (__layer.__navDirectional || (__focusType == GUI_FOCUS_POINTER_CONSTRAIN))
                //{
                //    return false;
                //}
            }
            else if ((__buttonType >= _minButtonType) || __listener || __scissorEnabled)
            {
                array_push(_stepOrder, __eventStep);
            }
        }
        
        //Then move on to our children
        var _array = __childArray;
        if (__scissorEnabled)
        {
            array_push(_stepOrder, __eventScissorPush);
            
            var _i = 0;
            repeat(array_length(_array))
            {
                __GuiEnsureStepOrderInner(_layer, _stepOrder, _array[_i], _minButtonType);
                ++_i;
            }
            
            array_push(_stepOrder, __eventScissorPop);
        }
        else
        {
            //Same as above, just without the scissor events
            var _i = 0;
            repeat(array_length(_array))
            {
                __GuiEnsureStepOrderInner(_layer, _stepOrder, _array[_i], _minButtonType);
                ++_i;
            }
        }
    }
    
    return true;
}