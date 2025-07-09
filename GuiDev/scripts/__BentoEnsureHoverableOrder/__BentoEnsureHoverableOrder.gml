// Feather disable all

/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureHoverableOrder()
{
    if not (__dirtyFlags & __BENTO_DIRTY_HOVERABLE) return;
    __dirtyFlags = ~((~__dirtyFlags) | __BENTO_DIRTY_HOVERABLE);
    
    ++__hoverableRegenCount;
    array_resize(__hoverableOrder, 0);
    
    if (__navPointer)
    {
        __BentoEnsureHoverableOrderInnerPointer(__hoverableOrder, __GetFocusRoot().BENTO_VARS, __hoverableRegenCount);
    }
    else if (__navDirectional)
    {
        __BentoEnsureHoverableOrderInnerDirectional(__hoverableOrder, __GetFocusRoot().BENTO_VARS, __hoverableRegenCount);
    }
}

function __BentoEnsureHoverableOrderInnerPointer(_hoverableOrder, _elementVars, _hoverableIndex)
{
    static _funcScrollbarCheck = function(_mouseX, _mouseY, _holdElement)
    {
        if (point_in_rectangle(_mouseX, _mouseY, barLeft, barTop, barRight, barBottom))
        {
            hoverScrollbar = true;
            return __element;
        }
        else
        {
            return undefined;
        }
    }
    
    with(_elementVars)
    {
        if (__disable) return; //Disabled elements always ban hover, understandably
        
        var _childHoverableIndex = _hoverableIndex;
        var _childArray = __childArray;
        
        if (__focused)
        {
            //If we're focused then only ban hover if we haVe children
            //Our children also will *not* be enclosed because we're focused
            if (array_length(_childArray) > 0)
            {
                _hoverableIndex = undefined;
            }
        }
        else
        {
            //Enclose our children if the enclose type matches the nav type
            if (__focusEncloseType & BENTO_ENCLOSE_POINTER)
            {
                _childHoverableIndex = undefined;
            }
        }
        
        __hoverableIndex = _hoverableIndex;
        array_push(_hoverableOrder, __funcHover);
        
        //Then move on to our children
        var _i = 0;
        repeat(array_length(_childArray))
        {
            __BentoEnsureHoverableOrderInnerPointer(_hoverableOrder, _childArray[_i], _childHoverableIndex);
            ++_i;
        }
        
        if (__scrollbarHori != undefined)
        {
            array_push(_hoverableOrder, __scrollbarHori.__CheckOver);
        }
        
        if (__scrollbarVert != undefined)
        {
            array_push(_hoverableOrder, __scrollbarVert.__CheckOver);
        }
    }
}

function __BentoEnsureHoverableOrderInnerDirectional(_hoverableOrder, _elementVars, _hoverableIndex)
{
    with(_elementVars)
    {
        if (__disable) return; //Disabled elements always ban hover, understandably
        
        var _childHoverableIndex = _hoverableIndex;
        var _childArray = __childArray;
        
        if (__focused)
        {
            //If we're focused then only ban hover if we haVe children
            //Our children also will *not* be enclosed because we're focused
            if (array_length(_childArray) > 0)
            {
                _hoverableIndex = undefined;
            }
        }
        else
        {
            //Enclose our children if the enclose type matches the nav type
            if (__focusEncloseType & BENTO_ENCLOSE_DIRECTIONAL)
            {
                _childHoverableIndex = undefined;
            }
        }
        
        //Elements can only be selected if they're set up as buttons when in directional mode
        if ((_hoverableIndex != undefined) && (__buttonType & BENTO_BUTTON_DIRECTIONAL))
        {
            __hoverableIndex = _hoverableIndex;
            array_push(_hoverableOrder, __attachedElement);
        }
        
        //Then move on to our children
        var _i = 0;
        repeat(array_length(_childArray))
        {
            __BentoEnsureHoverableOrderInnerDirectional(_hoverableOrder, _childArray[_i], _childHoverableIndex);
            ++_i;
        }
    }
}