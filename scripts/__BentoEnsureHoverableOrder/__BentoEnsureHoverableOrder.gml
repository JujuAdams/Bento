// Feather disable all

/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureHoverableOrder()
{
    if not (__dirtyFlags & __BENTO_DIRTY_HOVERABLE) return;
    __dirtyFlags = ~((~__dirtyFlags) | __BENTO_DIRTY_HOVERABLE);
    
    ++__hoverableRegenCount;
    array_resize(__hoverableOrder, 0);
    
    var _rootElement = __GetFocusRoot();
    if (BentoExists(_rootElement))
    {
        if (BentoExists(__carryItemElement))
        {
            var _carryItemVars = __carryItemElement.BENTO_VARS;
            var _carryChannel  = _carryItemVars.__carryItemChannel;
        }
        else
        {
            var _carryChannel  = undefined;
            var _carryItemVars = undefined;
        }
        
        if (__inputModePointer)
        {
            __BentoEnsureHoverableOrderInnerPointer(__hoverableOrder, _rootElement.BENTO_VARS, __hoverableRegenCount, _carryItemVars, _carryChannel);
        }
        else if (__inputModeNavigation)
        {
            __BentoEnsureHoverableOrderInnerNavigation(__hoverableOrder, _rootElement.BENTO_VARS, __hoverableRegenCount, _carryItemVars, _carryChannel);
        }
    }
}

function __BentoEnsureHoverableOrderInnerPointer(_hoverableOrder, _elementVars, _hoverableIndex, _carryItemVars, _carryChannel)
{
    with(_elementVars)
    {
        if (__disable) return; //Disabled elements always ban hover, understandably
        
        if (BENTO_ALLOW_ENCLOSED_GETTER)
        {
            __enclosed = (_hoverableIndex == undefined);
        }
        
        //Elements can only be hovered if the are not enclosed as indicated by `_hoverableIndex`
        if (_hoverableIndex != undefined)
        {
            if (__scrollbarVert != undefined)
            {
                array_push(_hoverableOrder, __scrollbarVert.__CheckOver);
            }
            
            if (__scrollbarHori != undefined)
            {
                array_push(_hoverableOrder, __scrollbarHori.__CheckOver);
            }
        }
        
        //Enclose our children if the enclose type matches the input mode
        var _anyChildButton = false;
        var _childHoverableIndex = ((not __focused) && (__focusEncloseType & BENTO_ENCLOSE_POINTER))? undefined : _hoverableIndex;
        
        if (BENTO_ALLOW_ENCLOSED_GETTER || (_childHoverableIndex != undefined))
        {
            //Then move on to our children
            var _childArray = __childArray;
            var _i = array_length(_childArray)-1;
            repeat(array_length(_childArray))
            {
                _anyChildButton |= __BentoEnsureHoverableOrderInnerPointer(_hoverableOrder, _childArray[_i], _childHoverableIndex, _carryItemVars, _carryChannel);
                --_i;
            }
        }
        
        //Elements can only be hovered if the are not enclosed as indicated by `_hoverableIndex`
        if (_hoverableIndex != undefined)
        {
            var _carryIsTarget = ((_carryChannel == __carryTargetChannel) && ((not is_callable(__carryTargetFunc)) || __carryTargetFunc()));
            if ((_carryChannel == undefined) || (_carryItemVars == self) || _carryIsTarget || __scrollHori || __scrollVert)
            {
                if ((__buttonType & BENTO_BUTTON_POINTER) && ((not __carryOnlyButtonWhenTarget) || _carryIsTarget))
                {
                    __buttonIndex = _hoverableIndex;
                }
                
                __hoverableIndex = _hoverableIndex;
                array_push(_hoverableOrder, __funcHover);
                
                return true;
            }
        }
    }
    
    return false;
}

function __BentoEnsureHoverableOrderInnerNavigation(_hoverableOrder, _elementVars, _hoverableIndex, _carryItemVars, _carryChannel)
{
    with(_elementVars)
    {
        if (__disable) return; //Disabled elements always ban hover, understandably
        
        if (BENTO_ALLOW_ENCLOSED_GETTER)
        {
            __enclosed = (_hoverableIndex == undefined);
        }
        
        //Enclose our children if the enclose type matches the input mode
        var _anyChildButton = false;
        var _childHoverableIndex = ((not __focused) && (__focusEncloseType & BENTO_ENCLOSE_NAVIGATION))? undefined : _hoverableIndex;
        
        if (BENTO_ALLOW_ENCLOSED_GETTER || (_childHoverableIndex != undefined))
        {
            //Then move on to our children. We track whether any children are hoverable
            var _childArray = __childArray;
            var _i = array_length(_childArray)-1;
            repeat(array_length(_childArray))
            {
                _anyChildButton |= __BentoEnsureHoverableOrderInnerNavigation(_hoverableOrder, _childArray[_i], _childHoverableIndex, _carryItemVars, _carryChannel);
                --_i;
            }
        }
        
        //Elements can only be hovered if the are:
        // 1. set up as buttons when in navigation mode
        // 2. not enclosed as indicated by `_hoverableIndex`
        // 3. either not focused or don't have any children that are buttons
        if ((_hoverableIndex != undefined)
        &&  (__buttonType & BENTO_BUTTON_NAVIGATION)
        &&  ((not _anyChildButton) || (not __focused)))
        {
            if (((not __carryOnlyButtonWhenTarget) && ((_carryChannel == undefined) || (_carryItemVars == self)))
            ||  ((_carryChannel == __carryTargetChannel) && ((not is_callable(__carryTargetFunc)) || __carryTargetFunc())))
            {
                __buttonIndex = _hoverableIndex;
                
                __hoverableIndex = _hoverableIndex;
                array_push(_hoverableOrder, __attachedElement);
                
                return true;
            }
        }
    }
    
    return false;
}