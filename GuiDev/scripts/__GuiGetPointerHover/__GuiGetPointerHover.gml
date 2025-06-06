// Feather disable all

/// Returns which instance is highlighted using the mouse & touch highlighting rules. This function
/// can return `GUI_NO_ELEMENT` if no instance is highlighted.

function __GuiGetPointerHover(_mouseX, _mouseY)
{
    var _hoverableOrder = __hoverableOrder;
    var _hoverableCount = array_length(_hoverableOrder);
    
    if (not __navPointer)
    {
        __GuiError("Can only use `__GuiGetPointerHover()` in pointer mode");
    }
    
    var _holdElement = __holdElement;
    
    var _i = _hoverableCount-1;
    repeat(_hoverableCount)
    {
        var _result = _hoverableOrder[_i](_mouseX, _mouseY, _holdElement);
        if (_result != undefined)
        {
            return _result;
        }
        
        --_i;
    }
}

/*
function __GuiGetPointerHover(_mouseX, _mouseY)
{
    var _scissorStack  = __GuiScissorReset();
    var _scissorL      = -infinity;
    var _scissorT      = -infinity;
    var _scissorR      =  infinity;
    var _scissorB      =  infinity;
    var _insideScissor =  true;
    
    var _result = GUI_NO_ELEMENT;
    
    var _holdElement = __holdElement;
    var _holdElementDoesntExist = not GuiExists(_holdElement);
    
    var _stepOrder = __stepOrder;
    var _i = 0;
    repeat(array_length(_stepOrder))
    {
        var _method = _stepOrder[_i];
        var _methodFunc = method_get_index(_method);
        
        if (_methodFunc == __GuiScissorPop)
        {
            //Restore the previous state
            var _bounds = array_pop(_scissorStack);
            var _scissorL      = _bounds.x;
            var _scissorT      = _bounds.y;
            var _scissorR      = _bounds.w;
            var _scissorB      = _bounds.h;
            var _insideScissor = _bounds[$ "__inside"] ?? false;
        }
        else if (_methodFunc == __GuiScissorPushFromElement)
        {
            //Store the previous scissor state
            array_push(_scissorStack, {
                x: _scissorL,
                y: _scissorT,
                w: _scissorR,
                h: _scissorB,
                
                __inside: _insideScissor,
            });
            
            var _element = method_get_self(_method);
            with(_element.GUI_VARS)
            {
                _scissorL = max(_scissorL, _element.guiLeft   + __scissorPadLeft   + __scissorScrollbarLeft  );
                _scissorT = max(_scissorT, _element.guiTop    + __scissorPadTop    + __scissorScrollbarTop   );
                _scissorR = min(_scissorR, _element.guiRight  - __scissorPadRight  - __scissorScrollbarRight );
                _scissorB = min(_scissorB, _element.guiBottom - __scissorPadBottom - __scissorScrollbarBottom);
            }
            
            _insideScissor = ((_mouseX >= _scissorL) && (_mouseY >= _scissorT) && (_mouseX <= _scissorR) && (_mouseY <= _scissorB));
        }
        else
        {
            if (_insideScissor)
            {
                with(method_get_self(_method))
                {
                    if ((_methodFunc == __GuiScrollbarUpdateVert) || (_methodFunc == __GuiScrollbarUpdateHori))
                    {
                        if (hoverScrollbar && (_holdElementDoesntExist || ((_holdElement == __element) && grabHandle)))
                        {
                            _result = __element;
                        }
                    }
                    else
                    {
                        if (_holdElementDoesntExist || (_holdElement == self))
                        {
                            if (GUI_VARS.__elementIsInstance)
                            {
                                if (instance_position(_mouseX, _mouseY, self))
                                {
                                    _result = self; 
                                }
                            }
                            else
                            {
                                if (point_in_rectangle(_mouseX, _mouseY, guiLeft, guiTop, guiRight, guiBottom))
                                {
                                    _result = self; 
                                }
                            }
                        }
                    }
                }
            }
        }
        
        ++_i;
    }
    
    return _result;
}
*/