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
    
    __popUpRoot = noone;
    
    __GuiEnsureChildOrder();
    __GuiEnsureStepOrderInner(self, __stepOrder, (__navMode == GUI_NAV_DIRECTIONAL)? (array_last(__stepRootStack) ?? __rootElement) : __rootElement);
    
    return __stepOrder;
}

function __GuiEnsureStepOrderInner(_layer, _stepOrder, _element)
{
    with(_element.GUI_VARS)
    {
        if (__disable) return __GUI_RETURN_NORMAL;
        
        //N.B. We iterate over instances backwards to handle modals and blockers elegantly
        
        var _focused = (__focused && (_layer.__navMode == GUI_NAV_DIRECTIONAL));
        if ((not __focusable) || _layer.__navPointer || _focused)
        {
            if (__scissorEnabled)
            {
                array_insert(_stepOrder, 0, method(_element, __GuiStepMethodScissorPush));
            }
            
            //Add children created inside the parent to the Step order. If we encounter a blocking
            //instance inside the parent then only prevent adding of instances that are inside the
            //parent.
            var _array = __childArray;
            var _i = array_length(_array)-1;
            repeat(array_length(_array))
            {
                var _return = __GuiEnsureStepOrderInner(_layer, _stepOrder, _array[_i]);
                if ((_return == __GUI_RETURN_MODAL) || (_return == __GUI_RETURN_BLOCK_SIBLINGS)) break;
                --_i;
            }
            
            if (__scissorEnabled)
            {
                array_insert(_stepOrder, 0, method(_element, __GuiScissorPop));
            }
        }
        
        if ((__behavior == GUI_BEHAVIOR_BUTTON) || (__behavior == GUI_BEHAVIOR_LISTENER))
        {
            array_insert(_stepOrder, 0, method(_element, __GuiStepMethod));
        }
        else if (__behavior == GUI_BEHAVIOR_MODAL)
        {
            array_insert(_stepOrder, 0, method(_element, __GuiStepMethod));
            return __GUI_RETURN_MODAL;
        }
        else if (__behavior == GUI_BEHAVIOR_BLOCK_SIBLINGS)
        {
            array_insert(_stepOrder, 0, method(_element, __GuiStepMethod));
            return __GUI_RETURN_BLOCK_SIBLINGS;
        }
        else if (__behavior == GUI_BEHAVIOR_POP_UP)
        {
            //Store the first pop-up instance we see so we can detect when the user clicks off of
            //the pop-up (which will destroy it)
            if (not GUI_EXISTS(_layer.__popUpRoot)) _layer.__popUpRoot = _element;
            
            //Pop-ups are not selectable but are still hoverable. This means we need to push them
            //to the Step order
            array_insert(_stepOrder, 0, method(_element, __GuiStepMethod));
            
            if (not GUI_POP_UP_CLICK_THROUGH)
            {
                return __GUI_RETURN_MODAL;
            }
        }
        else
        {
            //Other behaviors are not hoverable (or selectable) so we don't push them to the Step
            //order unless they're pushing scissor state
            
            if (__scissorEnabled)
            {
                array_insert(_stepOrder, 0, method(_element, __GuiStepMethod));
            }
        }
    }
    
    return __GUI_RETURN_NORMAL;
}

function __GuiStepMethod()
{
    event_user(GUI_USER_EVENT_STEP);
}

function __GuiStepMethodScissorPush()
{
    var _guiStruct = GUI_VARS;
    __GuiScissorPush(guiLeft   + _guiStruct.__scissorPadLeft,
                     guiTop    + _guiStruct.__scissorPadTop,
                     guiRight  - _guiStruct.__scissorPadRight,
                     guiBottom - _guiStruct.__scissorPadBottom);
}