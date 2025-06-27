// Feather disable all

/// @param state
/// @param [element=self]

function BentoClipSetEnabled(_state, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__scissorEnabled != _state)
        {
            __scissorEnabled = _state;
            
            __layer.__dirtyFlags |= __GUI_DIRTY_STEP | __GUI_DIRTY_HOVERABLE | __GUI_DIRTY_DRAW;
        }
    }
}