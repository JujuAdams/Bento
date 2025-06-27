// Feather disable all

/// Returns which instance is highlighted using the mouse & touch highlighting rules. This function
/// can return `BENTO_NO_ELEMENT` if no instance is highlighted.

function __BentoGetPointerHover(_mouseX, _mouseY)
{
    var _hoverableOrder = __hoverableOrder;
    var _hoverableCount = array_length(_hoverableOrder);
    
    if (not __navPointer)
    {
        __BentoError("Can only use `__BentoGetPointerHover()` in pointer mode");
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
function __BentoGetPointerHover(_mouseX, _mouseY)
{
    var _scissorStack  = __BentoScissorReset();
    var _scissorL      = -infinity;
    var _scissorT      = -infinity;
    var _scissorR      =  infinity;
    var _scissorB      =  infinity;
    var _insideScissor =  true;
    
    var _result = BENTO_NO_ELEMENT;
    
    var _holdElement = __holdElement;
    var _holdElementDoesntExist = not BentoExists(_holdElement);
    
    var _stepOrder = __stepOrder;
    var _i = 0;
    repeat(array_length(_stepOrder))
    {
        var _method = _stepOrder[_i];
        var _methodFunc = method_get_index(_method);
        
        if (_methodFunc == __BentoScissorPop)
        {
            //Restore the previous state
            var _bounds = array_pop(_scissorStack);
            var _scissorL      = _bounds.x;
            var _scissorT      = _bounds.y;
            var _scissorR      = _bounds.w;
            var _scissorB      = _bounds.h;
            var _insideScissor = _bounds[$ "__inside"] ?? false;
        }
        else if (_methodFunc == __BentoScissorPushFromElement)
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
            with(_element.BENTO_VARS)
            {
                _scissorL = max(_scissorL, _element.bentoLeft   + __scissorPadLeft   + __scissorScrollbarLeft  );
                _scissorT = max(_scissorT, _element.bentoTop    + __scissorPadTop    + __scissorScrollbarTop   );
                _scissorR = min(_scissorR, _element.bentoRight  - __scissorPadRight  - __scissorScrollbarRight );
                _scissorB = min(_scissorB, _element.bentoBottom - __scissorPadBottom - __scissorScrollbarBottom);
            }
            
            _insideScissor = ((_mouseX >= _scissorL) && (_mouseY >= _scissorT) && (_mouseX <= _scissorR) && (_mouseY <= _scissorB));
        }
        else
        {
            if (_insideScissor)
            {
                with(method_get_self(_method))
                {
                    if ((_methodFunc == __BentoScrollbarUpdateVert) || (_methodFunc == __BentoScrollbarUpdateHori))
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
                            if (BENTO_VARS.__elementIsInstance)
                            {
                                if (instance_position(_mouseX, _mouseY, self))
                                {
                                    _result = self; 
                                }
                            }
                            else
                            {
                                if (point_in_rectangle(_mouseX, _mouseY, bentoLeft, bentoTop, bentoRight, bentoBottom))
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