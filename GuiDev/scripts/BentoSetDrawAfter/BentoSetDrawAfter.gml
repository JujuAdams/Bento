// Feather disable all

/// Sets whether an element should execute its Draw After Event user event / callback. Draw After
/// is executed after the Draw user event / callback and after drawing child elements. Anything
/// drawn in the Draw After event is not clipped even if a clipping region is set up.
/// 
/// @param state
/// @param [element=self]

function BentoSetDrawAfter(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__drawAfter == _state) return;
        __drawAfter = _state;
        
        __layer.__dirtyFlags |= __BENTO_DIRTY_DRAW;
    }
}