// Feather disable all

/// Sets whether a Bento element should be drawn or not. A non-visible element will still execute
/// it's Step user event/callback (if applicable) and will still draw its children. If you would
/// like to entirely disable an element, please use `BentoSetDisable()`.
/// 
/// N.B. This is separate to GameMaker's native `visible` variable that objects have by default.
///      Bento uses its own separate visible variable for compatibility between objects and
///      structs, as well as allowing for more performant rendering.
/// 
/// @param state
/// @param [element=self]

function BentoSetVisible(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__visible == _state) return;
        __visible = _state;
        
        __layer.__dirtyFlags |= __BENTO_DIRTY_DRAW;
    }
}