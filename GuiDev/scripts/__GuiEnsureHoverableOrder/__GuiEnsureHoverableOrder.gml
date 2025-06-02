// Feather disable all

/// Must be called in the scope of `__GuiClassLayer`.

function __GuiEnsureHoverableOrder()
{
    if (not __hoverableDirty) return;
    __hoverableDirty = false;
    
    ++__hoverableRegenCount;
    array_resize(__hoverableOrder, 0);
    
    //FIXME - Ban hover for elements outside of the top focus element. Right now this code won't add
    //        unfocused elements to the Step order but that that doesn't stop unfocused elements from
    //        being hovered.
    if (__navPointer)
    {
        __GuiEnsureHoverableOrderInnerPointer(__hoverableOrder, __GetFocusRoot(), __hoverableIndex);
    }
    else if (__navDirectional)
    {
        __GuiEnsureHoverableOrderInnerDirectional(__hoverableOrder, __GetFocusRoot(), __hoverableIndex);
    }
}

function __GuiEnsureHoverableOrderInnerPointer(_hoverableOrder, _element, _hoverableIndex)
{
    with(_element.GUI_VARS)
    {
        if (__disable) return; //Disabled elements always ban hover, understandably
        
        var _childHoverableIndex = _hoverableIndex;
        
        if (__focused)
        {
            //If we're focused then only ban hover if we haVe children
            //Our children also will *not* be enclosed because we're focused
            if (array_length(__childArray) > 0)
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
        
        //Then move on to our children
        var _array = __childArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            __GuiEnsureHoverableOrderInnerPointer(_hoverableOrder, _array[_i], _childHoverableIndex);
            ++_i;
        }
    }
}

function __GuiEnsureHoverableOrderInnerDirectional(_hoverableOrder, _element, _hoverableIndex)
{
    with(_element.GUI_VARS)
    {
        if (__disable) return; //Disabled elements always ban hover, understandably
        
        var _childHoverableIndex = _hoverableIndex;
        
        if (__focused)
        {
            //If we're focused then only ban hover if we haVe children
            //Our children also will *not* be enclosed because we're focused
            if (array_length(__childArray) > 0)
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
        __hoverableIndex = (__buttonType & GUI_BUTTON_DIRECTIONAL)? _hoverableIndex : undefined;
        
        //Then move on to our children
        var _array = __childArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            __GuiEnsureHoverableOrderInnerDirectional(_hoverableOrder, _array[_i], _childHoverableIndex);
            ++_i;
        }
    }
}