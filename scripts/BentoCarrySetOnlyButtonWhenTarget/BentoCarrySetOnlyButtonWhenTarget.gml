// Feather disable all

/// @param state
/// @param [element=self]

function BentoCarrySetOnlyButtonWhenTarget(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__carryOnlyButtonWhenTarget != _state)
        {
            __layer.__dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
            __carryOnlyButtonWhenTarget =_state;
        }
    }
}