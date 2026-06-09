// Feather disable all

/// Ensures that a valid step order exists on the system struct. This step order has be marked
/// as "dirty" by many operations and this function updates the step order only when necessary.
/// 
/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureStepOrder()
{
    if not (__dirtyFlags & __BENTO_DIRTY_STEP) return;
    __dirtyFlags = ~((~__dirtyFlags) | __BENTO_DIRTY_STEP);
    
    __BentoEnsureHoverableOrder();
    
    array_resize(__stepOrder, 0);
    
    var _rootElement = __GetFocusRoot();
    if (BentoExists(_rootElement))
    {
        __BentoEnsureStepOrderInner(self, __stepOrder, _rootElement.BENTO_VARS, __inputModePointer? BENTO_BUTTON_POINTER : BENTO_BUTTON_NAVIGATION);
    }
}

function __BentoEnsureStepOrderInner(_layer, _stepOrder, _elementVars, _inputModeType)
{
    with(_elementVars)
    {
        if (__disable)
        {
            __executesStep = false;
            return;
        }
        
        //Determine whether we need to execute the Step user event
        //
        //NOTE - This logic must match `BentoGetExecutesStep()`
        if (BENTO_ALWAYS_EXECUTE_STEP || (__buttonIndex == __layer.__hoverableRegenCount) || __forceStep || __focused || __scissorEnabled)
        {
            __executesStep = true;
            array_push(_stepOrder, __eventStep);
        }
        
        //Then move on to our children
        var _array = __childArray;
        if (__scissorEnabled)
        {
            array_push(_stepOrder, __eventStepScissorPush);
            
            var _i = 0;
            repeat(array_length(_array))
            {
                __BentoEnsureStepOrderInner(_layer, _stepOrder, _array[_i], _inputModeType);
                ++_i;
            }
            
            array_push(_stepOrder, __eventStepScissorPop);
            
            //TODO - Do we want to allow scrollbar behaviour outside of scissoring?
            
            if (__scrollbarHori != undefined)
            {
                array_push(_stepOrder, method(__scrollbarHori, __scrollbarHori.__Update));
            }
            
            if (__scrollbarVert != undefined)
            {
                array_push(_stepOrder, method(__scrollbarVert, __scrollbarVert.__Update));
            }
        }
        else
        {
            //Same as above, just without the scissor events
            var _i = 0;
            repeat(array_length(_array))
            {
                __BentoEnsureStepOrderInner(_layer, _stepOrder, _array[_i], _inputModeType);
                ++_i;
            }
        }
    }
}