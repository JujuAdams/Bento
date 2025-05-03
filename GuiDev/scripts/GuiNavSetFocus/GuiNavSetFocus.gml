// Feather disable all

/// @param state
/// @param [element=self]

function GuiNavSetFocus(_state, _element = self)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__focusable)
        {
            if (__focused == _state) return;
            
            __layer.__stepDirty = true;
            var _stepRootStack = __layer.__stepRootStack;
            
            if (_state)
            {
                __focused         = true;
                __focusBlockHover = (array_length(__childArray) > 0);
                
                if (__focusBlockHover)
                {
                    if (__scissorEnabled)
                    {
                        __layer.__directionalLastX = _element.guiLeft + __scissorPadLeft;
                        __layer.__directionalLastY = _element.guiTop  + __scissorPadTop;
                    }
                    else
                    {
                        __layer.__directionalLastX = _element.guiLeft;
                        __layer.__directionalLastY = _element.guiTop;
                    }
                }
                
                array_push(_stepRootStack, _element);
            }
            else
            {
                var _index = array_get_index(_stepRootStack, _element);
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
            __GuiTrace($"UI element {_element.GUI_VARS.__envIndex} {object_get_name(object_index)} is not focusable");
        }
    }
}