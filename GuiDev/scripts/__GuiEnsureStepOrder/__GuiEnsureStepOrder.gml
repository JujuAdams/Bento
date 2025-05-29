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
    __GuiEnsureStepOrderInner(self, __stepOrder, _root, __navPointer? GUI_BUTTON_POINTER : GUI_BUTTON_DIRECTIONAL, false);
    
    return __stepOrder;
}

function __GuiEnsureStepOrderInner(_layer, _stepOrder, _element, _buttonType, _enclosedUnfocused)
{
    with(_element.GUI_VARS)
    {
        __enclosedUnfocused = _enclosedUnfocused;
        
        if (__disable)
        {
            __executesStep = false;
            return;
        }
        
        //Determine whether we need to execute the Step user event
        //This should match the code in `GuiGetExecutesStep()`
        if (GUI_ALWAYS_EXECUTE_STEP || (__buttonType & _buttonType) || __forceStep || __focused || __scissorEnabled)
        {
            __executesStep = true;
            array_push(_stepOrder, __eventStep);
        }
        
        if (__focusEncloseChildren && (not __focused) && (_buttonType == GUI_BUTTON_DIRECTIONAL))
        {
            _enclosedUnfocused = true;
        }
        
        //Then move on to our children
        var _array = __childArray;
        if (__scissorEnabled)
        {
            array_push(_stepOrder, __eventScissorPush);
            
            var _i = 0;
            repeat(array_length(_array))
            {
                __GuiEnsureStepOrderInner(_layer, _stepOrder, _array[_i], _buttonType, _enclosedUnfocused);
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
                __GuiEnsureStepOrderInner(_layer, _stepOrder, _array[_i], _buttonType, _enclosedUnfocused);
                ++_i;
            }
        }
    }
}