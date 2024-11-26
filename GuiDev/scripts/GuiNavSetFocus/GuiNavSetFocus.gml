// Feather disable all

/// @param state
/// @param [instance=id]

function GuiNavSetFocus(_state, _instance = id)
{
    static _system        = __GuiSystem();
    static _stepRootStack = _system.__stepRootStack;
    
    with(_instance)
    {
        if (__focusable)
        {
            if (__focused == _state) return;
            _system.__stepDirty = true;
            
            if (_state)
            {
                __focused         = true;
                __focusBlockHover = (array_length(__childArray) > 0);
                
                if (__focusBlockHover)
                {
                    if (__scissorState)
                    {
                        _system.__gamepadLastX = __scissorLeft;
                        _system.__gamepadLastY = __scissorTop;
                    }
                    else
                    {
                        _system.__gamepadLastX = x;
                        _system.__gamepadLastY = y;
                    }
                }
                
                array_push(_stepRootStack, id);
            }
            else
            {
                var _index = array_get_index(_stepRootStack, id);
                if (_index >= 0)
                {
                    // Mark everything above us in the step root stack as unfocused
                    var _i = _index;
                    repeat(array_length(_stepRootStack) - _index)
                    {
                        with(_stepRootStack[_i])
                        {
                            __focused         = false;
                            __focusBlockHover = false;
                        }
                        
                        ++_i;
                    }
                    
                    // And then clear out the step root stack
                    array_delete(_stepRootStack, _index, array_length(_stepRootStack) - _index);
                }
            }
        }
        else
        {
            __GuiTrace($"{object_get_name(object_index)}:{id} is not focusable");
        }
    }
}