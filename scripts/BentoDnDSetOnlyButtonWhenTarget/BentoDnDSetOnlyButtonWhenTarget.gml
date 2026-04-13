// Feather disable all

/// @param state
/// @param [element=self]

function BentoDnDSetOnlyButtonWhenTarget(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__dndOnlyButtonWhenTarget != _state)
        {
            __layer.__dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
            __dndOnlyButtonWhenTarget =_state;
        }
    }
}