// Feather disable all

/// Sets whether an instance should execute its Draw After Event user event (`GUI_USER_EVENT_DRAW_AFTER`).
/// The Draw After user event is executed after the Draw user event (`GUI_USER_EVENT_DRAW`) and after
/// drawing child elements. The Draw After event is not clipped by the scissor test, if one is set up.
/// 
/// @param state
/// @param [element=self]

function GuiSetDrawAfter(_state, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__drawAfter == _state) return;
        __drawAfter = _state;
        
        __layer.__dirtyFlags |= __GUI_DIRTY_DRAW;
    }
}