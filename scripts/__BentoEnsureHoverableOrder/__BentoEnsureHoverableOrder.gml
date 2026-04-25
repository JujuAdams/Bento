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
        if (BentoExists(__dndItemElement))
        {
            var _dndItemVars = __dndItemElement.BENTO_VARS;
            var _dndChannel  = _dndItemVars.__dndItemChannel;
        }
        else
        {
            var _dndChannel  = undefined;
            var _dndItemVars = undefined;
        }
        
        if (__navPointer)
        {
            __BentoEnsureHoverableOrderInnerPointer(__hoverableOrder, _rootElement.BENTO_VARS, __hoverableRegenCount, _dndItemVars, _dndChannel);
        }
        else if (__navDirectional)
        {
            __BentoEnsureHoverableOrderInnerDirectional(__hoverableOrder, _rootElement.BENTO_VARS, __hoverableRegenCount, _dndItemVars, _dndChannel);
        }
    }
}

function __BentoEnsureHoverableOrderInnerPointer(_hoverableOrder, _elementVars, _hoverableIndex, _dndItemVars, _dndChannel)
{
    with(_elementVars)
    {
        if (__disable) return; //Disabled elements always ban hover, understandably
        
        if (BENTO_ALLOW_ENCLOSED_GETTER)
        {
            __enclosed = (_hoverableIndex == undefined);
        }
        
        //Elements can only be selected if the are not enclosed as indicated by `_hoverableIndex`
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
        
        //Enclose our children if the enclose type matches the nav type
        var _anyChildButton = false;
        var _childHoverableIndex = ((not __focused) && (__focusEncloseType & BENTO_ENCLOSE_POINTER))? undefined : _hoverableIndex;
        
        if (BENTO_ALLOW_ENCLOSED_GETTER || (_childHoverableIndex != undefined))
        {
            //Then move on to our children
            var _childArray = __childArray;
            var _i = array_length(_childArray)-1;
            repeat(array_length(_childArray))
            {
                _anyChildButton |= __BentoEnsureHoverableOrderInnerPointer(_hoverableOrder, _childArray[_i], _childHoverableIndex, _dndItemVars, _dndChannel);
                --_i;
            }
        }
        
        //Elements can only be selected if the are not enclosed as indicated by `_hoverableIndex`
        if (_hoverableIndex != undefined)
        {
            var _dndIsTarget = ((_dndChannel == __dndTargetChannel) && ((not is_callable(__dndTargetFunc)) || __dndTargetFunc()));
            if ((_dndChannel == undefined) || (_dndItemVars == self) || _dndIsTarget || __scrollHori || __scrollVert)
            {
                if ((__buttonType & BENTO_BUTTON_POINTER) && ((not __dndOnlyButtonWhenTarget) || _dndIsTarget))
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

function __BentoEnsureHoverableOrderInnerDirectional(_hoverableOrder, _elementVars, _hoverableIndex, _dndItemVars, _dndChannel)
{
    with(_elementVars)
    {
        if (__disable) return; //Disabled elements always ban hover, understandably
        
        if (BENTO_ALLOW_ENCLOSED_GETTER)
        {
            __enclosed = (_hoverableIndex == undefined);
        }
        
        //Enclose our children if the enclose type matches the nav type
        var _anyChildButton = false;
        var _childHoverableIndex = ((not __focused) && (__focusEncloseType & BENTO_ENCLOSE_DIRECTIONAL))? undefined : _hoverableIndex;
        
        if (BENTO_ALLOW_ENCLOSED_GETTER || (_childHoverableIndex != undefined))
        {
            //Then move on to our children. We track whether any children are hoverable
            var _childArray = __childArray;
            var _i = array_length(_childArray)-1;
            repeat(array_length(_childArray))
            {
                _anyChildButton |= __BentoEnsureHoverableOrderInnerDirectional(_hoverableOrder, _childArray[_i], _childHoverableIndex, _dndItemVars, _dndChannel);
                --_i;
            }
        }
        
        //Elements can only be selected if the are:
        // 1. set up as buttons when in directional mode
        // 2. not enclosed as indicated by `_hoverableIndex`
        // 3. either not focused or don't have any children that are buttons
        if ((_hoverableIndex != undefined)
        &&  (__buttonType & BENTO_BUTTON_DIRECTIONAL)
        &&  ((not _anyChildButton) || (not __focused)))
        {
            if (((not __dndOnlyButtonWhenTarget) && ((_dndChannel == undefined) || (_dndItemVars == self)))
            ||  ((_dndChannel == __dndTargetChannel) && ((not is_callable(__dndTargetFunc)) || __dndTargetFunc())))
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