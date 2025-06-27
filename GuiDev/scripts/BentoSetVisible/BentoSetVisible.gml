// Feather disable all

/// @param state
/// @param [element=self]

function BentoSetVisible(_state, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__visible == _state) return;
        __visible = _state;
        
        __layer.__dirtyFlags |= __GUI_DIRTY_DRAW;
    }
}