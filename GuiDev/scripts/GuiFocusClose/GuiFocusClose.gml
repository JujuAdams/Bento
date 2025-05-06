// Feather disable all

/// @param [element=self]

function GuiFocusClose(_element = self)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__focused)
        {
            __layer.__stepDirty = true;
            
            var _focusStack = __layer.__focusStack;
            var _index = array_get_index(_focusStack, _element);
            if (_index >= 0)
            {
                var _i = array_length(_focusStack)-1;
                repeat(array_length(_focusStack) - _index)
                {
                    _focusStack[_i].GUI_VARS.__focused = false;
                    --_i;
                }
            }
            
            array_delete(_focusStack, _index, array_length(_focusStack) - _index);
            __layer.__focusTop = array_last(_focusStack);
        }
    }
}