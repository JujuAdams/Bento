// Feather disable all

/// Returns which instance is highlighted using the mouse & touch highlighting rules. This function
/// can return `noone` if no instance is highlighted.

function __GuiGetPointerOver(_mouseX, _mouseY)
{
    var _scissorStack  = __GuiScissorReset();
    var _scissorL      = -infinity;
    var _scissorT      = -infinity;
    var _scissorR      =  infinity;
    var _scissorB      =  infinity;
    var _insideScissor =  true;
    
    var _element = noone;
    
    var _holdElement = __holdElement;
    var _stepOrder = __stepOrder;
    var _i = 0;
    repeat(array_length(_stepOrder))
    {
        var _method = _stepOrder[_i];
        var _methodFunc = method_get_index(_method);
        
        if (_methodFunc == __GuiStepMethodScissorPush)
        {
            //Restore the previous state
            var _bounds = array_pop(_scissorStack);
            var _scissorL      = _bounds.x;
            var _scissorT      = _bounds.y;
            var _scissorR      = _bounds.w;
            var _scissorB      = _bounds.h;
            var _insideScissor = _bounds[$ "__inside"] ?? false;
        }
        else if (_methodFunc == __GuiScissorPop)
        {
            //Store the previous scissor state
            array_push(_scissorStack, {
                x: _scissorL,
                y: _scissorT,
                w: _scissorR,
                h: _scissorB,
                
                __inside: _insideScissor,
            });
            
            with(method_get_self(_stepOrder[_i]))
            {
                var _guiStruct = GUI_VARS;
                _scissorL = max(_scissorL, guiLeft   + _guiStruct.__scissorPadLeft  );
                _scissorT = max(_scissorT, guiTop    + _guiStruct.__scissorPadTop   );
                _scissorR = min(_scissorR, guiRight  - _guiStruct.__scissorPadRight );
                _scissorB = min(_scissorB, guiBottom - _guiStruct.__scissorPadBottom);
            }
            
            _insideScissor = ((_mouseX >= _scissorL) && (_mouseY >= _scissorT) && (_mouseX <= _scissorR) && (_mouseY <= _scissorB));
        }
        else
        {
            if (_insideScissor)
            {
                with(method_get_self(_stepOrder[_i]))
                {
                    if (((not __GuiExists(_holdElement)) || (_holdElement == self)) && instance_position(_mouseX, _mouseY, self))
                    {
                        _element = self;
                    }
                }
            }
        }
        
        ++_i;
    }
    
    return _element;
}