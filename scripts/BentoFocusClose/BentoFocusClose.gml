// Feather disable all

/// Closes focus for an element.
/// 
/// @param [element=self]

function BentoFocusClose(_element = self)
{
    return __BentoFocusCloseInner(_element);
}

function __BentoFocusCloseInner(_element)
{
    if (not BentoExists(_element)) return;
    if (not _element.BENTO_VARS.__focused) return;
    
    with(_element.BENTO_VARS.__layer)
    {
        __dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
        
        var _prevHoverElement = BENTO_NO_ELEMENT;
        
        //Find the focus element that just closed in the stack
        var _focusStack = __focusStack;
        var _i = 0;
        repeat(array_length(_focusStack))
        {
            var _focusInfo = _focusStack[_i];
            if (_focusInfo.__focusElement == _element)
            {
                //We found it, collect the element that was hovered before the element was focused
                _prevHoverElement = _focusInfo.__prevHoverElement
                break;
            }
            
            ++_i;
        }
        
        var _foundIndex = _i;
        
        //Close the focus for the element and everything after it too
        repeat(array_length(_focusStack) - _i)
        {
            with(_focusStack[_i].__focusElement.BENTO_VARS)
            {
                __focusType = BENTO_FOCUS_NONE;
                __focused   = false;
            }
            
            ++_i;
        }
        
        //Scale down the array to remove focus elements we don't want
        array_resize(_focusStack, _foundIndex-1);
        
        //Updates the current top focus element
        __focusTop = (_foundIndex >= 1)? _focusStack[_foundIndex-1].__focusElement : undefined;
        
        //If we're using navigation input mode then try to hover the element that was previously
        //hovered before the element was focused
        if (__inputModeNavigation)
        {
            __BentoEnsureHoverableOrder();
            
            if (__BentoGetHoverableInternal(_prevHoverElement, false))
            {
                __BentoSetHover(_prevHoverElement, false);
                __hoverElementSoft = BENTO_NO_ELEMENT;
            }
        }
    }
}