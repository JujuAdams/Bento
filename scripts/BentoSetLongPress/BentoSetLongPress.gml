// Feather disable all

/// @param state
/// @param [element=self]

function BentoSetLongPress(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        __longPressEnabled = _state;
    }
}