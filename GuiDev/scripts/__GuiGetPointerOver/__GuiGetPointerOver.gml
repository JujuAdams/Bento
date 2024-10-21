// Feather disable all

/// Returns which instance is highlighted using the mouse & touch highlighting rules. This function
/// can return `noone` if no instance is highlighted.

function __GuiGetPointerOver(_mouseX, _mouseY)
{
    static _system    = __GuiSystem();
    static _stepOrder = __GuiSystem().__stepOrder;
    
    var _scissorStack = __GuiScissorReset();
    var _scissorL = -infinity;
    var _scissorT = -infinity;
    var _scissorR =  infinity;
    var _scissorB =  infinity;
    var _insideScissor = true;
    
    var _holdInstance = _system.__holdInstance;
    
    var _instance = noone;
    var _i = 0;
    repeat(array_length(_stepOrder))
    {
        var _method = _stepOrder[_i];
        var _methodFunc = method_get_index(_method);
        
        if (_methodFunc == __GuiStepMethod)
        {
            if (_insideScissor)
            {
                with(method_get_self(_stepOrder[_i]))
                {
                    if (visible
                    &&  ((not instance_exists(_holdInstance)) || (_holdInstance == id))
                    &&  (_mouseX >= x - width/2) && (_mouseY >= y - height/2)
                    &&  (_mouseX <= x + width/2) && (_mouseY <= y + height/2))
                    {
                        _instance = id;
                    }
                }
            }
        }
        else if (_methodFunc == __GuiStepMethodScissorPush)
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
                _scissorL = max(_scissorL, __scissorLeft  );
                _scissorT = max(_scissorT, __scissorTop   );
                _scissorR = min(_scissorR, __scissorRight );
                _scissorB = min(_scissorB, __scissorBottom);
            }
            
            _insideScissor = ((_mouseX >= _scissorL) && (_mouseY >= _scissorT) && (_mouseX <= _scissorR) && (_mouseY <= _scissorB));
        }
        
        ++_i;
    }
    
    return _instance;
}