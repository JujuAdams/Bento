// Feather disable all

/// @param state
/// @param [element=self]

function BentoSetClickOnPress(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        __clickOnPress = _state;
    }
}