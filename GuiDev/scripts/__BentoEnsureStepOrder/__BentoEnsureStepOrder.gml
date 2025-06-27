// Feather disable all

/// Ensures that a valid step order exists on the system struct. This step order has be marked
/// as "dirty" by many operations and this function updates the step order only when necessary.
/// 
/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureStepOrder()
{
    if not (__dirtyFlags & __BENTO_DIRTY_STEP) return;
    __dirtyFlags = ~((~__dirtyFlags) | __BENTO_DIRTY_STEP);
    
    array_resize(__stepOrder, 0);
    __BentoEnsureStepOrderInner(self, __stepOrder, __GetFocusRoot(), __navPointer? BENTO_BUTTON_POINTER : BENTO_BUTTON_DIRECTIONAL, 0);
}

function __BentoEnsureStepOrderInner(_layer, _stepOrder, _element, _navType, _localIndex)
{
    with(_element.BENTO_VARS)
    {
        __localIndex = _localIndex;
        
        if (__disable)
        {
            __executesStep = false;
            return;
        }
        
        //Determine whether we need to execute the Step user event
        //This should match the code in `BentoGetExecutesStep()`
        if (BENTO_ALWAYS_EXECUTE_STEP || (__buttonType & _navType) || __forceStep || __focused || __scissorEnabled)
        {
            __executesStep = true;
            array_push(_stepOrder, __eventStep);
        }
        
        //Then move on to our children
        var _array = __childArray;
        if (__scissorEnabled)
        {
            array_push(_stepOrder, __eventScissorPush);
            
            var _i = 0;
            repeat(array_length(_array))
            {
                __BentoEnsureStepOrderInner(_layer, _stepOrder, _array[_i], _navType, _i);
                ++_i;
            }
            
            array_push(_stepOrder, __eventScissorPop);
            
            //FIXME - Do we want to allow scrollbar behaviour outside of scissoring?
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
                __BentoEnsureStepOrderInner(_layer, _stepOrder, _array[_i], _navType, _i);
                ++_i;
            }
        }
    }
}