// Feather disable all

/// @param focusType
/// @param [element=self]

function BentoFocusOpen(_focusType, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        var _layer = __layer;
        
        __focusType = _focusType;
        
        //If the player is using a pointer but we want to always cancel focus when using a pointer
        //then sort that out
        if (_layer.__navPointer && (_focusType == BENTO_FOCUS_POINTER_CANCEL_ALWAYS))
        {
            BentoFocusClose(_element);
            return;
        }
        
        if (not __focused)
        {
            __focused = true;
            _layer.__dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
            
            var _focusStack = __layer.__focusStack;
            
            var _i = array_length(_focusStack)-1;
            if (_i >= 0)
            {
                var _focusElement = undefined;
                repeat(array_length(_focusStack))
                {
                    if (BentoIsAncestor(_focusStack[_i], _element))
                    {
                        _focusElement = _focusStack[_i];
                        break;
                    }
                    
                    --_i;
                }
                
                BentoFocusClose(_focusElement);
            }
            
            array_push(_focusStack, _element);
            _layer.__focusTop = _element;
            
            _layer.__cursorLastL = _element.bentoLeft;
            _layer.__cursorLastT = _element.bentoTop;
            _layer.__cursorLastR = _element.bentoRight;
            _layer.__cursorLastB = _element.bentoBottom;
            
            if (__scissorEnabled)
            {
                //Use the smaller scissor region
                _layer.__directionalLastX = _element.bentoLeft + __scissorPadLeft + __scissorScrollbarLeft;
                _layer.__directionalLastY = _element.bentoTop  + __scissorPadTop + __scissorScrollbarTop;
            }
            else
            {
                _layer.__directionalLastX = _element.bentoLeft;
                _layer.__directionalLastY = _element.bentoTop;
            }
        }
    }
}