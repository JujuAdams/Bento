// Feather disable all

/// @param state
/// @param [element=self]

function BentoSetVisible(_state, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__visible == _state) return;
        __visible = _state;
        
        __layer.__dirtyFlags |= __BENTO_DIRTY_DRAW;
    }
}