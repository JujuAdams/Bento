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
    if (GuiExists(_focusTop) && (__navDirectional || (_focusTop.GUI_VARS.__focusType == GUI_FOCUS_POINTER_CONSTRAIN)))
    {
        var _root = _focusTop;
    }
    else
    {
        var _root = __rootElement;
    }
    
    //FIXME - Ban hover for elements outside of the top focus element. Right now this code won't add
    //        unfocused elements to the Step order but that that doesn't stop unfocused elements from
    //        being hovered.
    __GuiEnsureStepOrderInner(self, __stepOrder, _root, __navPointer? GUI_BUTTON_POINTER : GUI_BUTTON_DIRECTIONAL, false, 0);
    
    return __stepOrder;
}

function __GuiEnsureStepOrderInner(_layer, _stepOrder, _element, _navType, _banHover, _localIndex)
{
    with(_element.GUI_VARS)
    {
        __localIndex = _localIndex;
        
        if (__disable)
        {
            __hoverBanned = true; //Disabled elements always ban hover, understandably
            __executesStep = false;
            return;
        }
        
        //Determine whether we need to execute the Step user event
        //This should match the code in `GuiGetExecutesStep()`
        if (GUI_ALWAYS_EXECUTE_STEP || (__buttonType & _navType) || __forceStep || __focused || __scissorEnabled)
        {
            __executesStep = true;
            array_push(_stepOrder, __eventStep);
        }
        
        if (_banHover)
        {
            //If our parent is banning hover then ban hover!
            __hoverBanned = true;
        }
        else if (__focused)
        {
            //If we're focused then only ban hover if we haVe children
            //Our children also will *not* be enclosed because we're focused
            __hoverBanned = (array_length(__childArray) > 0);
        }
        else
        {
            //Otherwise don't ban hover
            __hoverBanned = false;
            
            //Enclose our children if the enclose type matches the nav type
            if (__focusEncloseType & _navType)
            {
                _banHover = true;
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
                __GuiEnsureStepOrderInner(_layer, _stepOrder, _array[_i], _navType, _banHover, _i);
                ++_i;
            }
            
            array_push(_stepOrder, __eventScissorPop);
            
            //FIXME - Do we want to allow scroll behaviour outside of scissoring?
            if (__scrollbarHori != undefined)
            {
                array_push(_stepOrder, method(__scrollbarHori, __GuiScrollbarUpdateHori));
            }
            
            if (__scrollbarVert != undefined)
            {
                array_push(_stepOrder, method(__scrollbarVert, __GuiScrollbarUpdateVert));
            }
        }
        else
        {
            //Same as above, just without the scissor events
            var _i = 0;
            repeat(array_length(_array))
            {
                __GuiEnsureStepOrderInner(_layer, _stepOrder, _array[_i], _navType, _banHover, _i);
                ++_i;
            }
        }
    }
}