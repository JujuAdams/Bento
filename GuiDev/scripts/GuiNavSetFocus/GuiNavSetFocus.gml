// Feather disable all

/// @param state
/// @param [instance=self]

function GuiNavSetFocus(_state, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (__focusable)
        {
            if (__focused == _state) return;
            
            __environment.__stepDirty = true;
            var _stepRootStack = __environment.__stepRootStack;
            
            if (_state)
            {
                __focused         = true;
                __focusBlockHover = (array_length(__childArray) > 0);
                
                if (__focusBlockHover)
                {
                    if (__scissorEnabled)
                    {
                        __environment.__directionalLastX = _instance.guiLeft + __scissorPadLeft;
                        __environment.__directionalLastY = _instance.guiTop  + __scissorPadTop;
                    }
                    else
                    {
                        __environment.__directionalLastX = _instance.guiLeft;
                        __environment.__directionalLastY = _instance.guiTop;
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
                        with(_stepRootStack[_i].GUI_VARS)
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
            __GuiTrace($"UI element {_instance.GUI_VARS.__globalIndex} {object_get_name(object_index)} is not focusable");
        }
    }
}