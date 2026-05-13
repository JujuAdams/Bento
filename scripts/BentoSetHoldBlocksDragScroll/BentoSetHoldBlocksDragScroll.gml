// Feather disable all

/// Sets whether, when held, this element will not allow the scrolling parent to scroll on a drag
/// gesture. This is helpful for building sliders where the player might reasonably want to click
/// and drag the slider element without scrolling around.
/// 
/// @param state
/// @param [element=self]

function BentoSetHoldBlocksDragScroll(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        __holdBlocksDragScroll = _state;
    }
}