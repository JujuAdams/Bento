// Feather disable all

/// @param focusType
/// @param [element=self]

function GuiFocusOpen(_focusType, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        var _layer = __layer;
        
        __focusType = _focusType;
        
        //If the player is using a pointer but we want to always cancel focus when using a pointer
        //then sort that out
        if (_layer.__navPointer && (_focusType == GUI_FOCUS_POINTER_CANCEL_ALWAYS))
        {
            GuiFocusClose(_element);
            return;
        }
        
        if (not __focused)
        {
            __focused = true;
            _layer.__stepDirty = true;
            
            var _focusStack = __layer.__focusStack;
            
            var _i = array_length(_focusStack)-1;
            if (_i >= 0)
            {
                var _focusElement = undefined;
                repeat(array_length(_focusStack))
                {
                    if (GuiIsAncestor(_focusStack[_i], _element))
                    {
                        _focusElement = _focusStack[_i];
                        break;
                    }
                    
                    --_i;
                }
                
                GuiFocusClose(_focusElement);
            }
            
            array_push(_focusStack, _element);
            _layer.__focusTop = _element;
            
            _layer.__cursorLastL = _element.guiLeft;
            _layer.__cursorLastT = _element.guiTop;
            _layer.__cursorLastR = _element.guiRight;
            _layer.__cursorLastB = _element.guiBottom;
            
            if (__scissorEnabled)
            {
                //Use the smaller scissor region
                _layer.__directionalLastX = _element.guiLeft + __scissorPadLeft;
                _layer.__directionalLastY = _element.guiTop  + __scissorPadTop;
            }
            else
            {
                _layer.__directionalLastX = _element.guiLeft;
                _layer.__directionalLastY = _element.guiTop;
            }
        }
    }
}