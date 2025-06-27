// Feather disable all

/// Sets whether an element should execute its Draw After Event user event (`BENTO_USER_EVENT_DRAW_AFTER`).
/// The Draw After user event is executed after the Draw user event (`BENTO_USER_EVENT_DRAW`) and after
/// drawing child elements. The Draw After event is not clipped by the scissor test, if one is set up.
/// 
/// @param state
/// @param [element=self]

function BentoSetDrawAfter(_state, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__drawAfter == _state) return;
        __drawAfter = _state;
        
        __layer.__dirtyFlags |= __BENTO_DIRTY_DRAW;
    }
}