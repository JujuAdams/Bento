// Feather disable all

/// @param state
/// @param [instance=id]

function GuiNavSetFocus(_state, _instance = id)
{
    static _system        = __GuiSystem();
    static _stepRootStack = _system.__stepRootStack;
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
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
                    if (__scissorEnabled)
                    {
                        _system.__directionalLastX = _instance.guiLeft + __scissorPadLeft;
                        _system.__directionalLastY = _instance.guiTop  + __scissorPadTop;
                    }
                    else
                    {
                        _system.__directionalLastX = _instance.guiLeft;
                        _system.__directionalLastY = _instance.guiTop;
                    }
                }
                
                array_push(_stepRootStack, _instance);
            }
            else
            {
                var _index = array_get_index(_stepRootStack, _instance);
                if (_index >= 0)
                {
                    // Mark everything after us in the step root stack as unfocused
                    var _i = _index;
                    repeat(array_length(_stepRootStack) - _index)
                    {
                        with(_stepRootStack[_i].GUI_STRUCT)
                        {
                            __focused         = false;
                            __focusBlockHover = false;
                        }
                        
                        ++_i;
                    }
                    
                    // And then clear out those UI elements we've just unfocused
                    array_delete(_stepRootStack, _index, array_length(_stepRootStack) - _index);
                }
            }
        }
        else
        {
            __GuiTrace($"{object_get_name(object_index)}:{_instance.id} is not focusable");
        }
    }
}