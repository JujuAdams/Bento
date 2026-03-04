// Feather disable all

/// Closes focus for an element.
/// 
/// @param [element=self]

function BentoFocusClose(_element = self)
{
    return __BentoFocusCloseInner(_element);
}

function __BentoFocusCloseInner(_element)
{
    with(__BentoGetVars(_element))
    {
        if (__focused)
        {
            __layer.__dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
            
            var _focusStack = __layer.__focusStack;
            var _index = array_get_index(_focusStack, _element);
            if (_index >= 0)
            {
                var _i = array_length(_focusStack)-1;
                repeat(array_length(_focusStack) - _index)
                {
                    with(_focusStack[_i].BENTO_VARS)
                    {
                        __focusType = BENTO_FOCUS_NONE;
                        __focused   = false;
                    }
                    
                    --_i;
                }
            }
            
            array_delete(_focusStack, _index, array_length(_focusStack) - _index);
            __layer.__focusTop = array_last(_focusStack);
            
            BentoSelect(_element);
        }
    }
}