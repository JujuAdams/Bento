// Feather disable all

/// Must be called in the scope of `__GuiClassLayer`.

function __GuiEnsureHoverableOrder()
{
    if not (__dirtyFlags & __GUI_DIRTY_HOVERABLE) return;
    __dirtyFlags = ~((~__dirtyFlags) | __GUI_DIRTY_HOVERABLE);
    
    ++__hoverableRegenCount;
    array_resize(__hoverableOrder, 0);
    
    if (__navPointer)
    {
        __GuiEnsureHoverableOrderInnerPointer(__hoverableOrder, __GetFocusRoot(), __hoverableRegenCount);
    }
    else if (__navDirectional)
    {
        __GuiEnsureHoverableOrderInnerDirectional(__hoverableOrder, __GetFocusRoot(), __hoverableRegenCount);
    }
}

function __GuiEnsureHoverableOrderInnerPointer(_hoverableOrder, _element, _hoverableIndex)
{
    static _funcScrollbarCheck = function()
    {
        if (overScrollbar)
        {
            return __element;
        }
        else
        {
            return undefined;
        }
    }
    
    with(_element.GUI_VARS)
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
            if (__focusEncloseType & GUI_ENCLOSE_POINTER)
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
            __GuiEnsureHoverableOrderInnerPointer(_hoverableOrder, _childArray[_i], _childHoverableIndex);
            ++_i;
        }
        
        if (__scrollbarHori != undefined)
        {
            array_push(_hoverableOrder, method(__scrollbarHori, _funcScrollbarCheck));
        }
        
        if (__scrollbarVert != undefined)
        {
            array_push(_hoverableOrder, method(__scrollbarVert, _funcScrollbarCheck));
        }
    }
}

function __GuiEnsureHoverableOrderInnerDirectional(_hoverableOrder, _element, _hoverableIndex)
{
    with(_element.GUI_VARS)
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
            if (__focusEncloseType & GUI_ENCLOSE_DIRECTIONAL)
            {
                _childHoverableIndex = undefined;
            }
        }
        
        //Elements can only be selected if they're set up as buttons when in directional mode
        if ((_hoverableIndex != undefined) && (__buttonType & GUI_BUTTON_DIRECTIONAL))
        {
            __hoverableIndex = _hoverableIndex;
            array_push(_hoverableOrder, _element);
        }
        
        //Then move on to our children
        var _i = 0;
        repeat(array_length(_childArray))
        {
            __GuiEnsureHoverableOrderInnerDirectional(_hoverableOrder, _childArray[_i], _childHoverableIndex);
            ++_i;
        }
    }
}